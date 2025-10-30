﻿-- chunkname: @modules/logic/versionactivity3_2/dungeon/view/map/VersionActivity3_2DungeonMapTaskInfoItem.lua

module("modules.logic.versionactivity3_2.dungeon.view.map.VersionActivity3_2DungeonMapTaskInfoItem", package.seeall)

local VersionActivity3_2DungeonMapTaskInfoItem = class("VersionActivity3_2DungeonMapTaskInfoItem", LuaCompBase)

function VersionActivity3_2DungeonMapTaskInfoItem:setParam(param)
	if self._anim and (not self.viewGO.activeInHierarchy or self._elementId ~= param[2]) then
		self._anim:Play("taskitem_in", 0, 0)
	end

	self._index = param[1]
	self._elementId = param[2]

	local elementConfig = lua_chapter_map_element.configDict[self._elementId]

	if not elementConfig then
		logError("元件表找不到元件id:" .. self._elementId)
	end

	self._txtinfo.text = elementConfig.title

	VersionActivity3_2DungeonMapTaskInfoItem.setIcon(self._icon, self._elementId, "zhuxianditu_renwuicon_")
	self:refreshStatus()
end

function VersionActivity3_2DungeonMapTaskInfoItem.setIcon(icon, elementId, name)
	local elementConfig = lua_chapter_map_element.configDict[elementId]
	local isFinish = DungeonMapModel.instance:elementIsFinished(elementId)
	local resId = DungeonEnum.ElementTypeUIResIdMap[elementConfig.type] or elementConfig.type

	UISpriteSetMgr.instance:setUiFBSprite(icon, name .. resId .. (isFinish and 1 or 0))
end

function VersionActivity3_2DungeonMapTaskInfoItem:refreshStatus()
	local isFinish = DungeonMapModel.instance:elementIsFinished(self._elementId)

	if isFinish then
		local color = GameUtil.parseColor("#c66030")

		self._txtinfo.color = color
		self._icon.color = color
	else
		self._txtinfo.color = GameUtil.parseColor("#ded9d4")
		self._icon.color = GameUtil.parseColor("#a1a3a6")
	end
end

function VersionActivity3_2DungeonMapTaskInfoItem:init(go)
	self.viewGO = go
	self._txtinfo = gohelper.findChildText(self.viewGO, "txt_taskDesc")
	self._icon = gohelper.findChildImage(go, "bg/#image_icon")
	self._anim = go:GetComponent(typeof(UnityEngine.Animator))
	self._btn = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_click")

	self._btn:AddClickListener(self._onClickBtn, self)
end

function VersionActivity3_2DungeonMapTaskInfoItem:_onClickBtn()
	VersionActivityFixedDungeonController.instance:dispatchEvent(VersionActivityFixedDungeonEvent.ManualClickElement, self._elementId)
end

function VersionActivity3_2DungeonMapTaskInfoItem:playTaskOutAnim()
	if self.viewGO.activeInHierarchy then
		if self._anim then
			self._anim:Play("taskitem_out")
		else
			self:_hideGo()

			return
		end

		TaskDispatcher.cancelTask(self._hideGo, self)
		TaskDispatcher.runDelay(self._hideGo, self, 0.24)
	else
		self:_hideGo()
	end
end

function VersionActivity3_2DungeonMapTaskInfoItem:_hideGo()
	gohelper.setActive(self.viewGO, false)
end

function VersionActivity3_2DungeonMapTaskInfoItem:addEventListeners()
	self:addEventCb(DungeonController.instance, DungeonEvent.OnSetEpisodeListVisible, self._setEpisodeListVisible, self)
end

function VersionActivity3_2DungeonMapTaskInfoItem:removeEventListeners()
	return
end

function VersionActivity3_2DungeonMapTaskInfoItem:_setEpisodeListVisible(value)
	if not self._anim then
		return
	end

	if value then
		self._anim:Play("taskitem_in", 0, 0)
	else
		self._anim:Play("taskitem_out", 0, 0)
	end
end

function VersionActivity3_2DungeonMapTaskInfoItem:onStart()
	return
end

function VersionActivity3_2DungeonMapTaskInfoItem:onDestroy()
	TaskDispatcher.cancelTask(self._hideGo, self)
	self._btn:RemoveClickListener()
end

function VersionActivity3_2DungeonMapTaskInfoItem:_playEnterAnim(viewName)
	if not self._anim then
		return
	end

	if viewName == ViewName.DungeonMapTaskView then
		self._anim:Play("taskitem_in", 0, 0)
	end
end

function VersionActivity3_2DungeonMapTaskInfoItem:_playOutAnim(viewName)
	if not self._anim then
		return
	end

	if viewName == ViewName.DungeonMapTaskView then
		self._anim:Play("taskitem_out", 0, 0)
	end
end

return VersionActivity3_2DungeonMapTaskInfoItem
