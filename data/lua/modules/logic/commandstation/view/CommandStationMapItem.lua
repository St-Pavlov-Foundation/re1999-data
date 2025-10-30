﻿-- chunkname: @modules/logic/commandstation/view/CommandStationMapItem.lua

module("modules.logic.commandstation.view.CommandStationMapItem", package.seeall)

local CommandStationMapItem = class("CommandStationMapItem", ListScrollCellExtend)

function CommandStationMapItem:onInitView()
	self._goTime = gohelper.findChild(self.viewGO, "#go_Time")
	self._goHighLight4 = gohelper.findChild(self.viewGO, "#go_Time/#go_HighLight4")
	self._goImportant = gohelper.findChild(self.viewGO, "#go_Time/#go_Important")
	self._txtEvent = gohelper.findChildText(self.viewGO, "#go_Time/#txt_Event")
	self._goExpand4 = gohelper.findChild(self.viewGO, "#go_Time/#go_Expand4")
	self._btnclicktime = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Time/#btn_click_time")
	self._goDispatch = gohelper.findChild(self.viewGO, "#go_Dispatch")
	self._goHighLight3 = gohelper.findChild(self.viewGO, "#go_Dispatch/#go_HighLight3")
	self._going = gohelper.findChild(self.viewGO, "#go_Dispatch/#go_ing")
	self._goExpand3 = gohelper.findChild(self.viewGO, "#go_Dispatch/#go_Expand3")
	self._goFinish = gohelper.findChild(self.viewGO, "#go_Dispatch/#go_Finish")
	self._goRedPoint = gohelper.findChild(self.viewGO, "#go_Dispatch/#go_Finish/#go_RedPoint")
	self._goGet = gohelper.findChild(self.viewGO, "#go_Dispatch/#go_Get")
	self._btnclickdispatch = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Dispatch/#btn_click_dispatch")
	self._goOutside = gohelper.findChild(self.viewGO, "#go_Outside")
	self._goHighLight1 = gohelper.findChild(self.viewGO, "#go_Outside/#go_HighLight1")
	self._goIcon1 = gohelper.findChild(self.viewGO, "#go_Outside/#go_Icon1")
	self._goIcon2 = gohelper.findChild(self.viewGO, "#go_Outside/#go_Icon2")
	self._goExpand1 = gohelper.findChild(self.viewGO, "#go_Outside/#go_Expand1")
	self._btnclickoutside = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Outside/#btn_click_outside")
	self._goCharacter = gohelper.findChild(self.viewGO, "#go_Character")
	self._goHighLight2 = gohelper.findChild(self.viewGO, "#go_Character/#go_HighLight2")
	self._goExpand2 = gohelper.findChild(self.viewGO, "#go_Character/#go_Expand2")
	self._btnclickcharacter = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Character/#btn_click_character")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CommandStationMapItem:addEvents()
	self._btnclicktime:AddClickListener(self._btnclicktimeOnClick, self)
	self._btnclickdispatch:AddClickListener(self._btnclickdispatchOnClick, self)
	self._btnclickoutside:AddClickListener(self._btnclickoutsideOnClick, self)
	self._btnclickcharacter:AddClickListener(self._btnclickcharacterOnClick, self)
end

function CommandStationMapItem:removeEvents()
	self._btnclicktime:RemoveClickListener()
	self._btnclickdispatch:RemoveClickListener()
	self._btnclickoutside:RemoveClickListener()
	self._btnclickcharacter:RemoveClickListener()
end

function CommandStationMapItem:_btnclicktimeOnClick()
	self:_btnclickOnClick()
end

function CommandStationMapItem:_btnclickdispatchOnClick()
	self:_btnclickOnClick()
end

function CommandStationMapItem:_btnclickoutsideOnClick()
	self:_btnclickOnClick()
end

function CommandStationMapItem:_btnclickcharacterOnClick()
	self:_btnclickOnClick()
end

function CommandStationMapItem:_btnclickOnClick()
	if not self._eventConfig or self._isClose then
		return
	end

	CommandStationController.instance:dispatchEvent(CommandStationEvent.SelectedEvent, self._eventId)

	local timeId = CommandStationMapModel.instance:getTimeId()
	local param = {
		eventId = self._eventId,
		timeId = timeId
	}

	if self._category == CommandStationEnum.EventCategory.Normal then
		if self._eventTypeIsTime or self._eventTypeIsNormal then
			CommandStationController.instance:openCommandStationTimelineEventView(param)
		elseif self._eventTypeIsDialogue then
			CommandStationController.instance:openCommandStationDialogueEventView(param)
		elseif self._eventTypeIsDispatch then
			CommandStationController.instance:openCommandStationDispatchEventMainView(param)
		end
	elseif self._characterCategory then
		CommandStationController.instance:openCommandStationCharacterEventView(param)
	end

	self:FocusEvent()
	CommandStationController.StatCommandStationButtonClick("CommandStationMapItem", string.format("btnclickOnClick_%s_%s", timeId, self._eventId))
end

function CommandStationMapItem:FirstFocusEvent()
	local inBoundary = true

	if ViewMgr.instance:isOpen(ViewName.CommandStationCharacterEventView) then
		inBoundary = false
	end

	if not gohelper.isNil(self._sceneNodeGo) then
		CommandStationController.instance:dispatchEvent(CommandStationEvent.SceneFocusPos, self:_getLocalPos(), inBoundary)
	end
end

function CommandStationMapItem:FocusEvent()
	if not gohelper.isNil(self._sceneNodeGo) then
		CommandStationController.instance:dispatchEvent(CommandStationEvent.SceneFocusPos, self:_getLocalPos())
	end
end

function CommandStationMapItem:_getLocalPos()
	local pos = self._sceneNodeGo.transform.localPosition

	if self._eventTypeIsDispatch or self._characterCategory then
		pos.x = pos.x + 1
	end

	return pos
end

function CommandStationMapItem:playCloseAnim()
	if self._isClose then
		return
	end

	self._isClose = true

	TaskDispatcher.runDelay(self._ensureClose, self, 0.2)
	self._animatorPlayer:Play("close", self._closeAnimDone, self)
end

function CommandStationMapItem:_ensureClose()
	self:_closeAnimDone()
end

function CommandStationMapItem:_closeAnimDone()
	gohelper.destroy(self.viewGO)
end

function CommandStationMapItem:_commonAnimDone()
	return
end

function CommandStationMapItem:_editableInitView()
	self._animatorPlayer = SLFramework.AnimatorPlayer.Get(self.viewGO)
	self._animator = self.viewGO:GetComponent("Animator")

	gohelper.setActive(self._goTime, false)
	gohelper.setActive(self._goOutside, false)
	gohelper.setActive(self._goDispatch, false)
	gohelper.setActive(self._goCharacter, false)

	for i = 1, 4 do
		gohelper.setActive(self["_goHighLight" .. i], false)
		gohelper.setActive(self["_goExpand" .. i], false)
	end

	self._statusInfo = {
		[CommandStationEnum.EventType.Main] = 4,
		[CommandStationEnum.EventType.Dispatch] = 3,
		[CommandStationEnum.EventType.Normal] = 1,
		[CommandStationEnum.EventType.Dialogue] = 1
	}
	self._characterStatus = 2

	self:addEventCb(CommandStationController.instance, CommandStationEvent.SelectedEvent, self._onSelectedEvent, self)
	self:addEventCb(CommandStationController.instance, CommandStationEvent.CancelSelectedEvent, self._onCancelSelectedEvent, self)
end

function CommandStationMapItem:_onCancelSelectedEvent()
	if self._selectedSameType == false then
		self:_updateSelectedTypeState(true)
	end

	if self._isSelected then
		self:FirstFocusEvent()
	end

	self:_setSelected(false)
end

function CommandStationMapItem:_onSelectedEvent(eventId)
	local config

	if self._category == CommandStationEnum.EventCategory.Normal then
		config = lua_copost_event.configDict[eventId]
	elseif self._category == CommandStationEnum.EventCategory.Character then
		config = lua_copost_character_event.configDict[eventId]
	end

	self._selectedSameType = config and config.eventType == self._eventConfig.eventType

	if not self._selectedSameType then
		self:_updateSelectedTypeState(false)
	end

	self:_setSelected(eventId == self._eventId)
end

function CommandStationMapItem:_updateSelectedTypeState(show)
	if self._isClose then
		return
	end

	self._animator.enabled = true

	if show then
		self._animator:Play("open")
	else
		self._animator:Play("close")
	end
end

function CommandStationMapItem:_setSelected(isSelected)
	local index = self._characterCategory and self._characterStatus or self._statusInfo[self._eventConfig.eventType]

	self:_setSelectedByIndex(index, isSelected)
end

function CommandStationMapItem:_setSelectedByIndex(index, isSelected)
	if isSelected and not self._eventIsRead then
		CommandStationRpc.instance:sendCommandPostEventReadRequest(self._eventId)

		self._eventIsRead = true
	end

	if not self._isClose then
		if isSelected then
			self._animatorPlayer:Play("tobig", self._commonAnimDone, self)
		elseif self._isSelected then
			self._animatorPlayer:Play("backbig", self._commonAnimDone, self)
		end
	end

	gohelper.setActive(self["_goHighLight" .. index], not self._eventIsRead)
	gohelper.setActive(self["_goExpand" .. index], isSelected)

	self._isSelected = isSelected
end

function CommandStationMapItem:_editableAddEvents()
	self:addEventCb(CommandStationController.instance, CommandStationEvent.DispatchFinish, self._onDispatchFinish, self)
	self:addEventCb(CommandStationController.instance, CommandStationEvent.DispatchStart, self._onDispatchStart, self)
end

function CommandStationMapItem:_editableRemoveEvents()
	return
end

function CommandStationMapItem:onUpdateMO(eventId, category)
	TaskDispatcher.cancelTask(self._refreshDispatchEventView, self)

	self._category = category
	self._eventId = eventId
	self._eventIsRead = CommandStationModel.instance:isEventRead(self._eventId)

	if self._category == CommandStationEnum.EventCategory.Normal then
		self._eventConfig = lua_copost_event.configDict[self._eventId]
	elseif self._category == CommandStationEnum.EventCategory.Character then
		self._characterCategory = true
		self._eventConfig = lua_copost_character_event.configDict[self._eventId]
	end

	if not self._eventConfig then
		logError(string.format("CommandStationMapItem event config not found, eventId: %d, category: %d", self._eventId, self._category))

		return
	end

	self:_setSelected(false)
	self:_setPos()

	if self._characterCategory then
		self:_showCharacterEvent()

		return
	end

	self:_showNormalEvent()
end

function CommandStationMapItem:_setPos()
	if self._uiFollower then
		return
	end

	self._uiFollower = gohelper.onceAddComponent(self.viewGO, typeof(ZProj.UIFollower))

	local name = string.format("%s_%s_%s", self._category, self._eventId, self._eventConfig.eventType)
	local entity = CommandStationMapModel.instance:getSceneNode(name)

	self.viewGO.name = name

	local eventCoordinate = self._eventConfig.eventCoordinate
	local posX = eventCoordinate[1] or 0
	local posY = eventCoordinate[2] or 0

	transformhelper.setLocalPos(entity.transform, posX, posY, 0)

	local mainCamera = CameraMgr.instance:getMainCamera()
	local uiCamera = CameraMgr.instance:getUICamera()
	local plane = ViewMgr.instance:getUIRoot().transform

	self._uiFollower:Set(mainCamera, uiCamera, plane, entity.transform, 0, 0, 0, 0, 0)
	self._uiFollower:SetEnable(true)
	self._uiFollower:ForceUpdate()

	self._sceneNodeGo = entity
end

function CommandStationMapItem:_showCharacterEvent()
	local chaId = self._eventConfig.chaId

	self._singleImage = gohelper.findChildSingleImage(self._goCharacter, "image_Icon")

	local chaConfig = lua_copost_character.configDict[chaId]

	if chaConfig then
		self._singleImage:LoadImage(ResUrl.getHeadIconSmall(chaConfig.chaPicture))
	end

	gohelper.setActive(self._goCharacter, true)
end

function CommandStationMapItem:isMainType()
	return self._eventConfig.eventType == CommandStationEnum.EventType.Main
end

function CommandStationMapItem:_showNormalEvent()
	self._eventTypeIsTime = self:isMainType()
	self._eventTypeIsNormal = self._eventConfig.eventType == CommandStationEnum.EventType.Normal
	self._eventTypeIsDialogue = self._eventConfig.eventType == CommandStationEnum.EventType.Dialogue
	self._eventTypeIsDispatch = self._eventConfig.eventType == CommandStationEnum.EventType.Dispatch

	gohelper.setActive(self._goTime, self._eventTypeIsTime)
	gohelper.setActive(self._goOutside, self._eventTypeIsDialogue or self._eventTypeIsNormal)
	gohelper.setActive(self._goDispatch, self._eventTypeIsDispatch)

	if self._eventTypeIsDialogue or self._eventTypeIsNormal then
		self:_updateDialogueEventView()

		return
	end

	if self._eventTypeIsDispatch then
		self:_updateDispatchEventView()

		return
	end
end

function CommandStationMapItem:_updateDialogueEventView()
	gohelper.setActive(self._goIcon1, self._eventTypeIsNormal)
	gohelper.setActive(self._goIcon2, self._eventTypeIsDialogue)
end

function CommandStationMapItem:_updateDispatchEventView()
	local state = CommandStationModel.instance:getDispatchEventState(self._eventId)
	local isInProgress = state == CommandStationEnum.DispatchState.InProgress
	local isCompleted = state == CommandStationEnum.DispatchState.Completed
	local isGetReward = state == CommandStationEnum.DispatchState.GetReward

	gohelper.setActive(self._goFinish, isCompleted)
	gohelper.setActive(self._going, isInProgress)
	gohelper.setActive(self._goGet, isGetReward)
	TaskDispatcher.cancelTask(self._refreshDispatchEventView, self)

	if isInProgress then
		TaskDispatcher.runRepeat(self._refreshDispatchEventView, self, 1)
	end
end

function CommandStationMapItem:_refreshDispatchEventView()
	local state = CommandStationModel.instance:getDispatchEventState(self._eventId)
	local isInProgress = state == CommandStationEnum.DispatchState.InProgress
	local isCompleted = state == CommandStationEnum.DispatchState.Completed

	gohelper.setActive(self._goFinish, isCompleted)
	gohelper.setActive(self._going, isInProgress)

	if isCompleted then
		TaskDispatcher.cancelTask(self._refreshDispatchEventView, self)
	end
end

function CommandStationMapItem:_onDispatchFinish()
	if self._eventTypeIsDispatch then
		self:_updateDispatchEventView()
	end
end

function CommandStationMapItem:_onDispatchStart()
	if self._eventTypeIsDispatch then
		self:_updateDispatchEventView()
	end
end

function CommandStationMapItem:onSelect(isSelect)
	return
end

function CommandStationMapItem:onDestroyView()
	TaskDispatcher.cancelTask(self._ensureClose, self)
	TaskDispatcher.cancelTask(self._refreshDispatchEventView, self)
	gohelper.destroy(self._sceneNodeGo)
end

return CommandStationMapItem
