﻿-- chunkname: @modules/logic/versionactivity2_7/lengzhou6/view/LengZhou6EliminatePlayerSkill.lua

module("modules.logic.versionactivity2_7.lengzhou6.view.LengZhou6EliminatePlayerSkill", package.seeall)

local LengZhou6EliminatePlayerSkill = class("LengZhou6EliminatePlayerSkill", ListScrollCellExtend)

function LengZhou6EliminatePlayerSkill:onInitView()
	self._gorectMask = gohelper.findChild(self.viewGO, "#go_rectMask")
	self._txtskillTipDesc = gohelper.findChildText(self.viewGO, "#txt_skillTipDesc")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function LengZhou6EliminatePlayerSkill:addEvents()
	return
end

function LengZhou6EliminatePlayerSkill:removeEvents()
	return
end

local ZProj_RectMaskHoleType = typeof(ZProj.RectMaskHole)
local SLFramework_UGUI_UIClickListener = SLFramework.UGUI.UIClickListener
local UnityEngine_EventSystems_EventSystem = UnityEngine.EventSystems.EventSystem

function LengZhou6EliminatePlayerSkill:_editableInitView()
	self._rectMaskHole = self._gorectMask:GetComponent(ZProj_RectMaskHoleType)
	self._rectMaskHoleTr = self._rectMaskHole.transform
	self._rectMaskHole.enableClick = false
	self._rectMaskHole.enableDrag = false
	self._rectMaskHole.enablePress = false
	self._rectMaskHole.enableTargetClick = false
	self._rectMaskClick = SLFramework_UGUI_UIClickListener.Get(self._gorectMask)

	self._rectMaskClick:AddClickListener(self.onClick, self)
	self:setCanvas()
end

function LengZhou6EliminatePlayerSkill:onClick()
	local pos = UnityEngine.Input.mousePosition

	if self._pointerEventData == nil then
		self._pointerEventData = UnityEngine.EventSystems.PointerEventData.New(UnityEngine_EventSystems_EventSystem.current)
		self._raycastResults = System.Collections.Generic.List_UnityEngine_EventSystems_RaycastResult.New()
	end

	self._pointerEventData.position = pos

	if self:isInRect(self._pointerEventData) then
		self:checkAndExecute()
	else
		self:rectMaskClick()
	end
end

function LengZhou6EliminatePlayerSkill:checkAndExecute()
	if self._raycastResults == nil then
		return
	end

	UnityEngine_EventSystems_EventSystem.current:RaycastAll(self._pointerEventData, self._raycastResults)

	local current = self._pointerEventData.pointerCurrentRaycast.gameObject
	local roundType = EliminateLevelModel.instance:getCurRoundType()
	local isTeamChess = roundType == EliminateEnum.RoundType.TeamChess

	if isTeamChess then
		self._raycastResults:Clear()
	end

	local iter = self._raycastResults:GetEnumerator()

	while iter:MoveNext() do
		local raycastResult = iter.Current
		local go = raycastResult.gameObject

		if go ~= current and go ~= self._gorectMask then
			local btn = go:GetComponent(typeof(UnityEngine.UI.Button))

			if not gohelper.isNil(btn) then
				btn:OnPointerClick(self._pointerEventData)
			end
		end
	end
end

local tempVector2 = Vector2.New(0, 0)
local tempRect = UnityEngine.Rect.New(0, 0, 0, 0)

function LengZhou6EliminatePlayerSkill:isInRect(eventData)
	if self._size == nil or self._center == nil then
		return false
	end

	local camera3d = CameraMgr.instance:getUICamera()
	local centerX = self._center.x or 0
	local centerY = self._center.y or 0
	local sizeX = self._size.x or 0
	local sizeY = self._size.y or 0

	tempRect:Set(centerX - sizeX * 0.5, centerY - sizeY * 0.5, sizeX, sizeY)

	local isRect, tempVector2 = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(self._rectMaskHoleTr, eventData.position, camera3d, tempVector2)

	if isRect and tempRect:Contains(tempVector2) then
		return true
	end

	return false
end

function LengZhou6EliminatePlayerSkill:rectMaskClick()
	if self._rectMaskClickCb and self._rectMaskClickCbTarget then
		self._rectMaskClickCb(self._rectMaskClickCbTarget)
	end
end

function LengZhou6EliminatePlayerSkill:setTargetTrAndHoleSize(targetTr, x, y, offsetY, offsetX)
	local size = Vector2(x, y)

	self._rectMaskHole.size = size
	offsetY = offsetY or -30
	offsetX = offsetX or 0

	local sizeOffset = Vector2(offsetX, offsetY)

	self._center = sizeOffset
	self._size = size

	self._rectMaskHole:SetTarget(targetTr, sizeOffset, sizeOffset, nil)
end

function LengZhou6EliminatePlayerSkill:setCanvas()
	self._rectMaskHole.mainCanvas = ViewMgr.instance:getUICanvas()

	local mainCamera = CameraMgr.instance:getUICamera()

	self._rectMaskHole.mainCamera = mainCamera
	self._rectMaskHole.uiCamera = mainCamera
end

function LengZhou6EliminatePlayerSkill:setClickCb(cb, target)
	self._rectMaskClickCb = cb
	self._rectMaskClickCbTarget = target
end

function LengZhou6EliminatePlayerSkill:refreshSkillData()
	return
end

function LengZhou6EliminatePlayerSkill:onDestroyView()
	if self._rectMaskHole then
		self._rectMaskHole:InitPointerLuaFunction(nil, nil)

		self._rectMaskHole = nil
	end

	if self._rectMaskClick then
		self._rectMaskClick:RemoveClickListener()

		self._rectMaskClick = nil
		self._pointerEventData = nil
		self._raycastResults = nil
	end

	self._size = nil
	self._center = nil
	self._rectMaskClickCb = nil
	self._rectMaskClickCbTarget = nil
end

return LengZhou6EliminatePlayerSkill
