-- chunkname: @modules/logic/fight/mgr/FightPreloadTimelineAssetMgr.lua

module("modules.logic.fight.mgr.FightPreloadTimelineAssetMgr", package.seeall)

local MAX_LOAD_COUNT = 2
local FightPreloadTimelineAssetMgr = class("FightPreloadTimelineAssetMgr", FightBaseClass)

function FightPreloadTimelineAssetMgr:onConstructor()
	self.pendingQueue = {}
	self.queueCount = 0
	self.pendingHead = 1
	self.loadedDict = {}
	self.allDict = {}
	self.curLoadCount = 0

	self:com_registMsg(FightMsgId.ReleasePreloadTimelineAssetByStepId, self.onReleasePreloadTimelineAssetByStepId)
end

function FightPreloadTimelineAssetMgr:addPreLoad(timelineName, fightStepData)
	local classObj = self:newClass(FightPreloadTimelineAssetItem, timelineName, fightStepData)
	local stepUid = fightStepData.stepUid

	self.queueCount = self.queueCount + 1
	classObj.queueIndex = self.queueCount
	self.allDict[stepUid] = classObj
	self.pendingQueue[self.queueCount] = classObj

	self:tryLoadNext()
end

function FightPreloadTimelineAssetMgr:tryLoadNext()
	while self.curLoadCount < MAX_LOAD_COUNT and self.pendingHead <= self.queueCount do
		local item = self.pendingQueue[self.pendingHead]

		self.pendingHead = self.pendingHead + 1

		local stepUid = item.fightStepData and item.fightStepData.stepUid

		if stepUid and self.allDict[stepUid] == item and item:__isActive() then
			self.curLoadCount = self.curLoadCount + 1
			self.loadedDict[stepUid] = item

			item:startLoad()
		end
	end
end

function FightPreloadTimelineAssetMgr:onReleasePreloadTimelineAssetByStepId(stepId)
	local classObj = self.allDict[stepId]

	if not classObj then
		return
	end

	local releaseIndex = classObj.queueIndex

	for uid, loadedItem in pairs(self.loadedDict) do
		if releaseIndex > loadedItem.queueIndex then
			self.loadedDict[uid] = nil
			self.allDict[uid] = nil
			self.curLoadCount = self.curLoadCount - 1

			loadedItem:disposeSelf()
		end
	end

	while releaseIndex > self.pendingHead do
		local item = self.pendingQueue[self.pendingHead]

		if item then
			local uid = item.fightStepData and item.fightStepData.stepUid

			if uid and self.allDict[uid] then
				self.allDict[uid] = nil

				item:disposeSelf()
			end
		end

		self.pendingHead = self.pendingHead + 1
	end

	self.allDict[stepId] = nil

	if self.loadedDict[stepId] then
		self.loadedDict[stepId] = nil
		self.curLoadCount = self.curLoadCount - 1
	end

	classObj:disposeSelf()

	if releaseIndex + 1 > self.pendingHead then
		self.pendingHead = releaseIndex + 1
	end

	if self.curLoadCount < 0 then
		self.curLoadCount = 0
	end

	self:tryLoadNext()
end

function FightPreloadTimelineAssetMgr:onDestructor()
	self.pendingQueue = {}
	self.pendingHead = 1
	self.loadedDict = {}
	self.allDict = {}
	self.curLoadCount = 0
end

return FightPreloadTimelineAssetMgr
