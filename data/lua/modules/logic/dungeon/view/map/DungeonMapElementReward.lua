﻿-- chunkname: @modules/logic/dungeon/view/map/DungeonMapElementReward.lua

module("modules.logic.dungeon.view.map.DungeonMapElementReward", package.seeall)

local DungeonMapElementReward = class("DungeonMapElementReward", BaseView)

function DungeonMapElementReward:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function DungeonMapElementReward:addEvents()
	return
end

function DungeonMapElementReward:removeEvents()
	return
end

function DungeonMapElementReward:_editableInitView()
	return
end

function DungeonMapElementReward:onUpdateParam()
	return
end

function DungeonMapElementReward:onOpen()
	self:addEventCb(DungeonController.instance, DungeonEvent.OnRemoveElement, self._OnRemoveElement, self, LuaEventSystem.High)
	self:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	self:addEventCb(DungeonMazeController.instance, DungeonMazeEvent.DungeonMazeCompleted, self._onMazeCompleted, self)
end

function DungeonMapElementReward:_onCloseViewFinish(viewName)
	if viewName == self._lastViewName then
		if self._rewardPoint then
			self:_dispatchEvent()
		end

		DungeonController.instance:dispatchEvent(DungeonEvent.EndShowRewardView)
	end
end

function DungeonMapElementReward:_onMazeCompleted()
	self._lastViewName = ViewName.CommonPropView
end

function DungeonMapElementReward:setShowToastState(state)
	self.notShowToast = state
end

function DungeonMapElementReward:_OnRemoveElement(id)
	local config = lua_chapter_map_element.configDict[id]

	self._lastViewName = nil
	self._rewardPoint = nil

	local rewardStr = DungeonModel.instance:getMapElementReward(id)

	if not string.nilorempty(rewardStr) then
		local list = GameUtil.splitString2(rewardStr, false, "|", "#")
		local dataList = {}

		for i, v in ipairs(list) do
			local materialData = MaterialDataMO.New()

			materialData:initValue(v[1], v[2], v[3])
			table.insert(dataList, materialData)
		end

		PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.CommonPropView, dataList)

		self._lastViewName = ViewName.CommonPropView
	end

	if config.fragment > 0 then
		local fragmentCo = lua_chapter_map_fragment.configDict[config.fragment]

		if fragmentCo and fragmentCo.type == DungeonEnum.FragmentType.LeiMiTeBeiNew then
			self._lastViewName = ViewName.VersionActivityNewsView
		elseif config.type == DungeonEnum.ElementType.SpStory then
			-- block empty
		elseif config.type == DungeonEnum.ElementType.Investigate then
			self._lastViewName = ViewName.InvestigateTipsView
		else
			self._lastViewName = ViewName.DungeonFragmentInfoView
		end

		if self._lastViewName then
			PopupController.instance:addPopupView(PopupEnum.PriorityType.DungeonFragmentInfoView, self._lastViewName, {
				elementId = config.id,
				fragmentId = config.fragment,
				notShowToast = self.notShowToast
			})
		end
	end

	if config.type == DungeonEnum.ElementType.EnterDialogue then
		self._lastViewName = ViewName.DialogueView
	end

	if self._lastViewName then
		DungeonController.instance:dispatchEvent(DungeonEvent.BeginShowRewardView)
	end

	if config.rewardPoint > 0 then
		self._rewardPoint = config.rewardPoint

		if not self._lastViewName then
			self:_dispatchEvent()
		end
	end
end

function DungeonMapElementReward:_dispatchEvent()
	DungeonModel.instance:endCheckUnlockChapter()
	DungeonController.instance:dispatchEvent(DungeonEvent.OnAddRewardPoint, self._rewardPoint)

	self._rewardPoint = nil
end

function DungeonMapElementReward:onClose()
	return
end

function DungeonMapElementReward:onDestroyView()
	return
end

return DungeonMapElementReward
