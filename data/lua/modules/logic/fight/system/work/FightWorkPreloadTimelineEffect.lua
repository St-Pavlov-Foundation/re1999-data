-- chunkname: @modules/logic/fight/system/work/FightWorkPreloadTimelineEffect.lua

module("modules.logic.fight.system.work.FightWorkPreloadTimelineEffect", package.seeall)

local FightWorkPreloadTimelineEffect = class("FightWorkPreloadTimelineEffect", FightWorkItem)
local TimelineEffectType = {
	"FightTLEventTargetEffect",
	nil,
	nil,
	nil,
	"FightTLEventAtkEffect",
	"FightTLEventAtkFlyEffect",
	"FightTLEventAtkFullEffect",
	"FightTLEventDefEffect",
	[28] = "FightTLEventDefEffect"
}
local TimelineEventOppositeSide = {
	[1] = "FightTLEventTargetEffect"
}
local INSTANTIATE_INTERVAL = 0.2

function FightWorkPreloadTimelineEffect:onConstructor(loaderComp, entityData, timelineName, fightStepData)
	self.loaderComp = loaderComp
	self.entityData = entityData
	self.timelineSide = entityData and entityData.side
	self.timelineName = timelineName
	self.timelineUrl = ResUrl.getSkillTimeline(self.timelineName)
	self.fightStepData = fightStepData
end

function FightWorkPreloadTimelineEffect:onStart()
	if FightEffectMgr.isForbidEffect then
		self:onDone(true)

		return
	end

	self:cancelFightWorkSafeTimer()

	self._effectItemList = {}
	self._pendingSideList = {}
	self._instantiateIndex = 0
	self.assetUrl = FightWorkTimelineItem.getTimelineAssetUrl(self.timelineName)

	self.loaderComp:loadAsset(self.assetUrl, self.onTimelineLoaded, self)
end

function FightWorkPreloadTimelineEffect:onTimelineLoaded(success, assetItem)
	if self.IS_DISPOSED then
		return
	end

	if not success or not assetItem then
		self:onDone(true)

		return
	end

	self:_collectPreloadEffect(assetItem)
	self:_startInstantiate()
end

function FightWorkPreloadTimelineEffect:_collectPreloadEffect(assetItem)
	local jsonArr = FightTLHelper.getTLJsonData(assetItem, self.timelineUrl)
	local timelineSide = self.timelineSide
	local effectPath2SideDict = {}

	for i = 1, #jsonArr, 2 do
		local tlType = tonumber(jsonArr[i])
		local paramList = jsonArr[i + 1]

		if TimelineEffectType[tlType] then
			local effectName = paramList and paramList[1]

			if not string.nilorempty(effectName) then
				local effectUrl = FightHelper.getEffectUrlWithLod(effectName)
				local needSide = timelineSide

				if TimelineEventOppositeSide[tlType] then
					needSide = timelineSide == FightEnum.EntitySide.MySide and FightEnum.EntitySide.EnemySide or FightEnum.EntitySide.MySide
				end

				local oldSide = effectPath2SideDict[effectUrl]
				local newSide = needSide

				if oldSide and oldSide ~= needSide then
					newSide = FightEnum.EntitySide.BothSide
				end

				effectPath2SideDict[effectUrl] = newSide
			end
		end
	end

	for path, side in pairs(effectPath2SideDict) do
		self:_addPreloadEffect(path, side)
	end
end

function FightWorkPreloadTimelineEffect:_addPreloadEffect(path, side)
	if side == nil then
		table.insert(self._pendingSideList, {
			path = path,
			side = FightEnum.EntitySide.BothSide
		})
	end

	if side == FightEnum.EntitySide.MySide or side == FightEnum.EntitySide.BothSide then
		table.insert(self._pendingSideList, {
			path = path,
			side = FightEnum.EntitySide.MySide
		})
	end

	if side == FightEnum.EntitySide.EnemySide or side == FightEnum.EntitySide.BothSide then
		table.insert(self._pendingSideList, {
			path = path,
			side = FightEnum.EntitySide.EnemySide
		})
	end
end

function FightWorkPreloadTimelineEffect:_startInstantiate()
	local count = #self._pendingSideList

	if count <= 0 then
		return
	end

	self._instantiateIndex = 0

	self:com_registRepeatTimer(self._instantiateOne, INSTANTIATE_INTERVAL, count)
end

function FightWorkPreloadTimelineEffect:_instantiateOne()
	if self.IS_DISPOSED then
		return
	end

	self._instantiateIndex = self._instantiateIndex + 1

	local data = self._pendingSideList[self._instantiateIndex]

	if not data then
		return
	end

	self:_instantiateEffect(data.path, data.side)
end

function FightWorkPreloadTimelineEffect:_instantiateEffect(path, side)
	local effectMgr = FightGameMgr.effectMgr

	if not effectMgr then
		return
	end

	if effectMgr:hasIdleEffect(path, side) then
		return
	end

	local preloadPoolGO = effectMgr:getPreloadPoolContainerGO()
	local effectItem = effectMgr:getEffect(path, side, self._onPreloadOneFinish, self, preloadPoolGO, true)

	if not effectItem then
		return
	end

	effectItem:setLocalPos(50000, 50000, 50000)
	table.insert(self._effectItemList, effectItem)
end

function FightWorkPreloadTimelineEffect:_onPreloadOneFinish(effectItem, success)
	if not success then
		logError("战斗特效预加载失败：" .. tostring(effectItem and effectItem.path))

		return
	end

	FightGameMgr.effectMgr:returnEffect(effectItem)
end

function FightWorkPreloadTimelineEffect:clearWork()
	local effectMgr = FightGameMgr.effectMgr

	if self._effectItemList then
		for _, item in ipairs(self._effectItemList) do
			if effectMgr then
				effectMgr:releasePreloadEffect(item)
			end
		end

		self._effectItemList = nil
	end

	self._pendingSideList = nil
end

return FightWorkPreloadTimelineEffect
