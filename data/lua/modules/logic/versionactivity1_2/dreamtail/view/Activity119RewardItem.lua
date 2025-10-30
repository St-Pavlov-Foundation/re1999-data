﻿-- chunkname: @modules/logic/versionactivity1_2/dreamtail/view/Activity119RewardItem.lua

module("modules.logic.versionactivity1_2.dreamtail.view.Activity119RewardItem", package.seeall)

local Activity119RewardItem = class("Activity119RewardItem")

function Activity119RewardItem:init(go)
	self.go = go
	self.taskId = nil
	self.bonusCount = 0
	self.bonusItems = {}

	self:onInitView()
	self:addEvents()
end

function Activity119RewardItem:onInitView()
	self._rewards = {}

	for i = 1, 3 do
		self._rewards[i] = {}
		self._rewards[i]._goreward = gohelper.findChild(self.go, "reward" .. i)
		self._rewards[i]._bg = gohelper.findChild(self._rewards[i]._goreward, "bg")
		self._rewards[i]._itemposContent = gohelper.findChild(self._rewards[i]._goreward, "itemposContent")
		self._rewards[i]._state = gohelper.findChild(self._rewards[i]._goreward, "state")
		self._rewards[i]._lockbg = gohelper.findChild(self._rewards[i]._goreward, "lockbg")

		for j = 1, 3 do
			self._rewards[i]["_itempos" .. j] = gohelper.findChild(self._rewards[i]._itemposContent, "itempos" .. j)
		end

		self._rewards[i]._goclaimed = gohelper.findChild(self._rewards[i]._state, "go_claimed")
		self._rewards[i]._goclaim = gohelper.findChild(self._rewards[i]._state, "go_claim")
		self._rewards[i]._golocked = gohelper.findChild(self._rewards[i]._state, "go_locked")
		self._rewards[i]._btnclaim = gohelper.findChildButtonWithAudio(self._rewards[i]._state, "go_claim")
		self._rewards[i]._canvasGroup = gohelper.onceAddComponent(self._rewards[i]._itemposContent, typeof(UnityEngine.CanvasGroup))

		gohelper.setActive(self._rewards[i]._goreward, false)
	end
end

function Activity119RewardItem:addEvents()
	for i = 1, 3 do
		self._rewards[i]._btnclaim:AddClickListener(self.onTaskFinish, self)
	end
end

function Activity119RewardItem:removeEvents()
	for i = 1, 3 do
		self._rewards[i]._btnclaim:RemoveClickListener()
	end
end

function Activity119RewardItem:setBonus(bonusStr, taskId, isUnLock)
	self.taskId = taskId

	local bonus = GameUtil.splitString2(bonusStr, true)
	local bonusLen = #bonus

	if self.bonusCount ~= bonusLen then
		if self.bonusCount > 0 then
			gohelper.setActive(self._rewards[self.bonusCount]._goreward, false)
		end

		gohelper.setActive(self._rewards[bonusLen]._goreward, true)

		for i = bonusLen + 1, self.bonusCount do
			gohelper.setActive(self.bonusItems[i].go, false)
		end

		for i = 1, bonusLen do
			if not self.bonusItems[i] then
				self.bonusItems[i] = IconMgr.instance:getCommonPropItemIcon(self._rewards[bonusLen]["_itempos" .. i])
			else
				gohelper.setActive(self.bonusItems[i].go, true)
				self.bonusItems[i].go.transform:SetParent(self._rewards[bonusLen]["_itempos" .. i].transform, false)
			end
		end

		self.bonusCount = bonusLen
	end

	local reward = self._rewards[self.bonusCount]

	isUnLock = true

	gohelper.setActive(reward._bg, isUnLock)
	gohelper.setActive(reward._itemposContent, isUnLock)
	gohelper.setActive(reward._state, isUnLock)
	gohelper.setActive(reward._lockbg, not isUnLock)

	if isUnLock then
		for i = 1, bonusLen do
			local info = bonus[i]

			self.bonusItems[i]:setMOValue(info[1], info[2], info[3], nil, true)
			self.bonusItems[i]:setCountFontSize(48)
			self.bonusItems[i]:SetCountBgHeight(32)
		end
	end
end

function Activity119RewardItem:updateTaskStatus(status)
	local reward = self._rewards[self.bonusCount]

	gohelper.setActive(reward._goclaimed, status == 3)
	gohelper.setActive(reward._goclaim, status == 2)
	gohelper.setActive(reward._golocked, status == 1)

	reward._canvasGroup.alpha = status == 3 and 0.7 or 1

	for i = 1, #self.bonusItems do
		self.bonusItems[i]:setAlpha(status == 3 and 0.5 or 1)
	end
end

function Activity119RewardItem:onTaskFinish()
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Rewards)
	TaskRpc.instance:sendFinishTaskRequest(self.taskId)
end

function Activity119RewardItem:dispose()
	self:removeEvents()

	self.go = nil
	self.bonusCount = 0

	for i = 1, #self.bonusItems do
		self.bonusItems[i]:onDestroy()
	end

	self.bonusItems = nil

	for i = 1, 3 do
		for k, v in pairs(self._rewards[i]) do
			self._rewards[i][k] = nil
		end
	end

	self._rewards = nil
	self.taskId = nil
end

return Activity119RewardItem
