-- chunkname: @modules/logic/versionactivity4_0/deleike/view/DeleikeGameView.lua

module("modules.logic.versionactivity4_0.deleike.view.DeleikeGameView", package.seeall)

local DeleikeGameView = class("DeleikeGameView", BaseView)
local Time = UnityEngine.Time

function DeleikeGameView:onInitView()
	self._goTarget = gohelper.findChild(self.viewGO, "#go_Target")
	self._txtTarget = gohelper.findChildText(self.viewGO, "#go_Target/#txt_Target")
	self._goCancle = gohelper.findChild(self.viewGO, "#go_Cancle")
	self._btnBack = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Back")
	self._btnTips = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Tips")
	self._btnReset = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Reset")
	self._btnConfirm = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Confirm")
	self._goDragTip1 = gohelper.findChild(self.viewGO, "#go_DragTip1")
	self._goDragTip2 = gohelper.findChild(self.viewGO, "#go_DragTip2")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function DeleikeGameView:addEvents()
	self._btnBack:AddClickListener(self._btnBackOnClick, self)
	self._btnTips:AddClickListener(self._btnTipsOnClick, self)
	self._btnReset:AddClickListener(self._btnResetOnClick, self)
	self._btnConfirm:AddClickListener(self._btnConfirmOnClick, self)
	self:addEventCb(DeleikeController.instance, DeleikeEvent.Skill2DragStateChanged, self._onDragStateChanged, self)
	self:addEventCb(DeleikeController.instance, DeleikeEvent.SkillCntChange, self.refreshSkillCnt, self)
	self:addEventCb(DeleikeController.instance, DeleikeEvent.RestartGame, self._btnResetOnClick, self)
	self:addEventCb(DeleikeController.instance, DeleikeEvent.Skill2FirstDrag, self._onFirstDrag, self)
end

function DeleikeGameView:removeEvents()
	self._btnBack:RemoveClickListener()
	self._btnTips:RemoveClickListener()
	self._btnReset:RemoveClickListener()
	self._btnConfirm:RemoveClickListener()
end

function DeleikeGameView:_btnBackOnClick()
	return
end

function DeleikeGameView:_btnTipsOnClick()
	return
end

function DeleikeGameView:_btnConfirmOnClick()
	local skillMgr = DeleikeGameMgr.instance.skillMgr

	if skillMgr then
		skillMgr:cancelDrag()
	end
end

function DeleikeGameView:_btnResetOnClick()
	self.anim:Play("open", 0, 0)

	self.skillDraging = false

	DeleikeController.instance:dispatchEvent(DeleikeEvent.ResetGame)
	self:refreshSkillCnt(1)
	self:refreshSkillCnt(2)
end

function DeleikeGameView:_editableInitView()
	self.anim = gohelper.findComponentAnim(self.viewGO)
	self.animCancle = gohelper.findComponentAnim(self._goCancle)

	gohelper.setActive(self._goCancle, false)
	gohelper.setActive(self._btnConfirm, false)

	self.skillItems = {}
	self._skillAngles = {
		0,
		0
	}

	for i = 1, 2 do
		local skillItem = self:getUserDataTb_()
		local goSkill = gohelper.findChild(self.viewGO, "go_Skill" .. i)

		skillItem.animSkill = gohelper.findComponentAnim(goSkill)
		skillItem.goFrame = gohelper.findChild(goSkill, "go_Frame")
		skillItem.imageSkill = gohelper.findChildImage(goSkill, "image_Skill")
		skillItem.txtCount = gohelper.findChildText(goSkill, "image_Skill/txt_Count")
		skillItem.goHandle = gohelper.findChild(goSkill, "go_Handle")
		skillItem.goAdd = gohelper.findChild(goSkill, "go_add")
		skillItem.go = goSkill
		skillItem.transform = goSkill.transform
		self.skillItems[i] = skillItem
	end
end

function DeleikeGameView:onOpen()
	for i = 1, 2 do
		CommonDragHelper.instance:registerDragObj(self.skillItems[i].go, self._beginDrag, self._onDrag, self._endDrag, self._checkDrag, self, i, true)
	end

	local gameCfg = DeleikeGameMgr.instance.gameCfg

	self._txtTarget.text = gameCfg.targetDesc
end

function DeleikeGameView:onOpenFinish()
	self.anim.enabled = true

	self:refreshSkillCnt(1)
	self:refreshSkillCnt(2)
end

function DeleikeGameView:onDestroyView()
	for i = 1, 2 do
		CommonDragHelper.instance:unregisterDragObj(self.skillItems[i].go)
	end

	TaskDispatcher.cancelTask(self.delayHideCancle, self)
end

function DeleikeGameView:refreshSkillCnt(skillId, isAdd)
	local player = DeleikeGameMgr.instance.player

	if player then
		local skillCount = player:getSkillCount(skillId)
		local skillItem = self.skillItems[skillId]

		skillItem.txtCount.text = luaLang("multiple") .. tostring(skillCount)

		if isAdd then
			gohelper.setActive(skillItem.goAdd, false)
			gohelper.setActive(skillItem.goAdd, true)
		end

		local animName = skillCount == 0 and "gray" or "idle"

		skillItem.animSkill:Play(animName, 0, 0)
	end
end

function DeleikeGameView:_onDragStateChanged(active)
	self.skillDraging = active

	gohelper.setActive(self._goDragTip2, active)

	if not active then
		gohelper.setActive(self._btnConfirm, active)
	end
end

function DeleikeGameView:_onFirstDrag()
	gohelper.setActive(self._btnConfirm, true)
end

function DeleikeGameView:_checkDrag(index)
	if self.skillDraging then
		return true
	end

	if DeleikeGameMgr.instance.inputLocked then
		return true
	end

	local player = DeleikeGameMgr.instance.player

	if not player then
		return true
	end

	local count = player:getSkillCount(index)

	return count < 1
end

function DeleikeGameView:_beginDrag(index, pointerEventData)
	gohelper.setActive(self._goDragTip1, true)
	gohelper.setActive(self._btnReset, false)
	TaskDispatcher.cancelTask(self.delayHideCancle, self)
	gohelper.setActive(self._goCancle, true)
	self.animCancle:Play("unhand_open", 0, 0)

	self.isDragInCancle = false

	local skillItem = self.skillItems[index]

	gohelper.setActive(skillItem.goFrame, true)
	gohelper.setActive(skillItem.goHandle, true)
	skillItem.animSkill:Play("hold_in", 0, 0)

	local skillMgr = DeleikeGameMgr.instance.skillMgr

	if skillMgr then
		skillMgr:onSkillBtnDragBegin(index)
	end
end

function DeleikeGameView:_onDrag(index, pointerEventData)
	self:_setDragInCancle(self:_isPointerInCancle(pointerEventData))

	local skillItem = self.skillItems[index]
	local localPoint = recthelper.screenPosToAnchorPos(pointerEventData.position, skillItem.transform)
	local dx = localPoint.x
	local dy = localPoint.y
	local innerRadius = DeleikeEnum.JoyStickInnerRadius
	local outerRadius = DeleikeEnum.JoyStickOuterRadius
	local dist = math.sqrt(dx * dx + dy * dy)

	if outerRadius < dist then
		local scale = outerRadius / dist

		dx = dx * scale
		dy = dy * scale
	end

	transformhelper.setLocalPosXY(skillItem.goHandle.transform, dx, dy)

	if dist < innerRadius then
		return
	end

	local targetAngle = math.atan2(dy, dx)
	local curAngle = self._skillAngles[index] or 0
	local diff = targetAngle - curAngle

	diff = (diff + math.pi) % (2 * math.pi) - math.pi

	local t = 1 - math.exp(-DeleikeEnum.JoyStickSmoothSpeed * Time.deltaTime)

	curAngle = curAngle + diff * t
	self._skillAngles[index] = curAngle

	local dirX = math.cos(curAngle)
	local dirY = math.sin(curAngle)
	local skillMgr = DeleikeGameMgr.instance.skillMgr

	if skillMgr then
		skillMgr:onSkillBtnDragMove(dirX, dirY)
	end
end

function DeleikeGameView:_endDrag(index, pointerEventData)
	gohelper.setActive(self._goDragTip1, false)
	gohelper.setActive(self._btnReset, true)

	local skillItem = self.skillItems[index]

	gohelper.setActive(skillItem.goFrame, false)
	gohelper.setActive(skillItem.goHandle, false)
	skillItem.animSkill:Play("hold_out", 0, 0)

	local cancelled = self:_isPointerInCancle(pointerEventData)
	local skillMgr = DeleikeGameMgr.instance.skillMgr

	if skillMgr then
		skillMgr:onSkillBtnDragEnd(cancelled)
	end

	if self._goCancle.activeInHierarchy then
		local animName = self.isDragInCancle and "hand_close" or "unhand_close"

		self.animCancle:Play(animName, 0, 0)
		TaskDispatcher.runDelay(self.delayHideCancle, self, 0.16)
	end
end

function DeleikeGameView:delayHideCancle()
	gohelper.setActive(self._goCancle, false)
end

function DeleikeGameView:_isPointerInCancle(pointerEventData)
	local pos = pointerEventData.position

	return recthelper.screenPosInRect(self._goCancle.transform, nil, pos.x, pos.y)
end

function DeleikeGameView:_setDragInCancle(inCancle)
	if self.isDragInCancle == inCancle then
		return
	end

	self.isDragInCancle = inCancle

	self.animCancle:Play(inCancle and "hand_in" or "hand_out", 0, 0)
end

return DeleikeGameView
