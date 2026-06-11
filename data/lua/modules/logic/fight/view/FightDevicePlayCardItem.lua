-- chunkname: @modules/logic/fight/view/FightDevicePlayCardItem.lua

module("modules.logic.fight.view.FightDevicePlayCardItem", package.seeall)

local FightDevicePlayCardItem = class("FightDevicePlayCardItem", FightDeviceCardItem)

FightDevicePlayCardItem.DragScale = 1.2

local dt = 0.033

function FightDevicePlayCardItem.Create(goParent)
	local deviceItem = FightDevicePlayCardItem.New()

	deviceItem:init(goParent, FightDeviceCardItem.CardType.PlayCard)

	return deviceItem
end

function FightDevicePlayCardItem:initViews()
	FightDevicePlayCardItem.super.initViews(self)

	self.click = gohelper.getClick(self.go)

	self.click:AddClickListener(self.onClickDeviceCard, self)

	self.rectPlayCards = self.rectTrParent.parent
	self.longPress = SLFramework.UGUI.UILongPressListener.Get(self.go)

	self.longPress:SetLongPressTime({
		0.5,
		99999
	})
	self.longPress:AddLongPressListener(self.onLongPress, self)

	self.drag = SLFramework.UGUI.UIDragListener.Get(self.go)

	self.drag:AddDragBeginListener(self.onDragBegin, self)
	self.drag:AddDragListener(self.onDragging, self)
	self.drag:AddDragEndListener(self.onDragEnd, self)

	self.dt = dt / FightModel.instance:getUISpeed()
	self.lockComp = FightDevicePlayCardLockItem.New()

	self.lockComp:init(self)
	self:addEventCb(FightController.instance, FightEvent.OnDevice_SwitchIndex, self.onSwitchIndex, self)

	self.loaderComp = FightGameMgr.entityMgr:addComponent(FightLoaderComponent)
	self.timerComp = FightGameMgr.entityMgr:addComponent(FightTimerComponent)
	self.msgComp = FightGameMgr.entityMgr:addComponent(FightMsgComponent)

	self.msgComp:registMsg(FightMsgId.CancelOperateWhenMeiLeiErExRound, self.onCancelOperateWhenMeiLeiErExRound, self)
end

function FightDevicePlayCardItem:onSwitchIndex(srcIndex, targetIndex)
	if srcIndex == self.index then
		return
	end

	if srcIndex < targetIndex then
		if srcIndex > self.index or targetIndex < self.index then
			local anchorX = FightDeviceHelper.getDeviceItemAnchorX(self.index)

			self:tweenToAnchorPos(anchorX)

			return
		end

		local anchorX = FightDeviceHelper.getDeviceItemAnchorX(self.index - 1)

		self:tweenToAnchorPos(anchorX)

		return
	end

	if targetIndex > self.index or srcIndex < self.index then
		local anchorX = FightDeviceHelper.getDeviceItemAnchorX(self.index)

		self:tweenToAnchorPos(anchorX)

		return
	end

	local anchorX = FightDeviceHelper.getDeviceItemAnchorX(self.index + 1)

	self:tweenToAnchorPos(anchorX)
end

function FightDevicePlayCardItem:onDragBegin(param, pointerEventData)
	if not self:checkCanOperate() then
		return
	end

	if FightDeviceHelper.getDeviceAreaCount() <= 1 then
		return
	end

	AudioMgr.instance:trigger(2000037)

	self.dragging = true

	local scale = FightDevicePlayCardItem.DragScale

	transformhelper.setLocalScale(self.rectTr, scale, scale, scale)
	gohelper.setAsLastSibling(self.go)

	self.dt = dt / FightModel.instance:getUISpeed()

	local anchorX = self:getAnchorX(pointerEventData)

	self:tweenToAnchorPos(anchorX)
	self:tryDispatchSwitchEvent(anchorX)
end

function FightDevicePlayCardItem:onDragging(param, pointerEventData)
	if not self:checkCanOperate() then
		return
	end

	if FightDeviceHelper.getDeviceAreaCount() <= 1 then
		return
	end

	local anchorX = self:getAnchorX(pointerEventData)

	self:tweenToAnchorPos(anchorX)
	self:tryDispatchSwitchEvent(anchorX)
end

function FightDevicePlayCardItem:onDragEnd(param, pointerEventData)
	if not self:checkCanOperate() then
		return
	end

	if FightDeviceHelper.getDeviceAreaCount() <= 1 then
		return
	end

	AudioMgr.instance:trigger(2000038)
	self:killMoveTween()
	transformhelper.setLocalScale(self.rectTr, 1, 1, 1)

	local anchorX = self:getAnchorX(pointerEventData)

	recthelper.setAnchorX(self.rectTr, anchorX)

	local targetIndex = self:getTargetIndex(anchorX)
	local deviceArea = FightDataHelper.getDeviceArea()

	deviceArea:moveDevice(self.index, targetIndex)
	FightController.instance:dispatchEvent(FightEvent.OnDevice_DragDone)

	self.dragging = false
end

function FightDevicePlayCardItem:tryDispatchSwitchEvent(anchorX)
	local targetIndex = self:getTargetIndex(anchorX)

	FightController.instance:dispatchEvent(FightEvent.OnDevice_SwitchIndex, self.index, targetIndex)
end

function FightDevicePlayCardItem:getAnchorX(pointerEventData)
	local screenPos = pointerEventData.position
	local anchorX = recthelper.screenPosToAnchorPos2(screenPos, self.rectTrParent)
	local itemWidth = FightDeviceHelper.getDeviceItemWidth()

	anchorX = anchorX + itemWidth

	local maxAnchorX = FightDeviceHelper.getDeviceAreaTotalWidth() - itemWidth

	return Mathf.Clamp(anchorX, 0, maxAnchorX)
end

function FightDevicePlayCardItem:getTargetIndex(anchorX)
	local halfWidth = FightDeviceHelper.getDeviceItemHalfWidth()
	local interval = FightDeviceHelper.getDeviceItemInterValWidth()
	local targetAnchor

	for i = 1, self.index - 1 do
		targetAnchor = FightDeviceHelper.getDeviceItemAnchorX(i)
		targetAnchor = targetAnchor + halfWidth

		if anchorX <= targetAnchor then
			return i
		end
	end

	local curTargetAnchor = FightDeviceHelper.getDeviceItemAnchorX(self.index) - halfWidth - interval
	local nextTargetAnchor = FightDeviceHelper.getDeviceItemAnchorX(self.index + 1) - halfWidth

	if curTargetAnchor < anchorX and anchorX < nextTargetAnchor then
		return self.index
	end

	local count = FightDeviceHelper.getDeviceAreaCount()

	for i = self.index + 1, FightDeviceHelper.getDeviceAreaCount() do
		targetAnchor = FightDeviceHelper.getDeviceItemAnchorX(i)
		targetAnchor = targetAnchor + halfWidth

		if targetAnchor <= anchorX then
			return i
		end
	end

	return count
end

function FightDevicePlayCardItem:tweenToAnchorPos(anchorX)
	self:killMoveTween()

	local curAnchor = recthelper.getAnchorX(self.rectTr)

	if math.abs(curAnchor - anchorX) > 20 then
		self.dragTweenId = ZProj.TweenHelper.DOAnchorPosX(self.rectTr, anchorX, 6 * self.dt)
	else
		recthelper.setAnchorX(self.rectTr, anchorX)
	end
end

function FightDevicePlayCardItem:killMoveTween()
	if self.dragTweenId then
		ZProj.TweenHelper.KillById(self.dragTweenId)

		self.dragTweenId = nil
	end
end

local OffsetY = 110
local TempScreenPos = Vector2()

function FightDevicePlayCardItem:onLongPress()
	if not self:checkCanOperate() then
		return
	end

	if self.dragging then
		return
	end

	self.longPressed = true

	local screenPosX, screenPosY = recthelper.uiPosToScreenPos2(self.rectPlayCards)

	TempScreenPos.x = screenPosX
	TempScreenPos.y = screenPosY

	local width = recthelper.getWidth(self.rectPlayCards) * 0.5

	FightDeviceCardTipController.instance:openCommonView(self:getDeviceSkillInfo(), self.uid, TempScreenPos, FightDeviceCardTipController.Pivot.TopRight, FightDeviceCardTipController.Pivot.TopRight, -width, OffsetY)
end

function FightDevicePlayCardItem:checkCanOperate()
	if FightDataHelper.lockOperateMgr:isLock() then
		return
	end

	if FightDataHelper.stageMgr:inFightState(FightStageMgr.FightStateType.DouQuQu) then
		return
	end

	if FightDataHelper.stageMgr:inFightState(FightStageMgr.FightStateType.Enter) then
		return
	end

	if not FightDataHelper.stageMgr:isEmptyOperateState() then
		local curOperateState = FightDataHelper.stageMgr:getCurOperateState()

		if curOperateState ~= FightStageMgr.OperateStateType.Discard and curOperateState ~= FightStageMgr.OperateStateType.RecordSkill and curOperateState ~= FightStageMgr.OperateStateType.DeviceDiscard then
			return
		end
	end

	if FightViewHandCard.blockOperate then
		return
	end

	if FightDataHelper.stateMgr:getIsAuto() then
		return
	end

	if FightDataHelper.stageMgr:getCurStage() == FightStageMgr.StageType.Play then
		return
	end

	return true
end

function FightDevicePlayCardItem:onClickDeviceCard()
	if self.longPressed then
		self.longPressed = false

		return
	end

	if self.dragging then
		return
	end

	if not self:checkCanOperate() then
		return
	end

	AudioMgr.instance:trigger(2000029)
	ViewMgr.instance:openView(ViewName.FightDeviceSwitchView, self.uid)
end

function FightDevicePlayCardItem:refreshUI(index, deviceInfo)
	if not deviceInfo then
		return
	end

	self.index = index
	self.uid = deviceInfo.uid

	local groupInfo = deviceInfo.skills[deviceInfo.clientIndex]

	FightDevicePlayCardItem.super.refreshUI(self, groupInfo.skills[1])
	self:refreshAnchor()

	if self.lockComp then
		self.lockComp:updateLock()
	end
end

function FightDevicePlayCardItem:afterLoadDone()
	local deviceInfo = FightDataHelper.getClientDeviceInfo(self.uid)

	if not deviceInfo then
		return
	end

	self:refreshUI(self.index, deviceInfo)
	self:playAnim("open1")
end

function FightDevicePlayCardItem:getUid()
	return self.uid
end

function FightDevicePlayCardItem:updateData()
	local deviceInfo = FightDataHelper.getClientDeviceInfo(self.uid)

	if not deviceInfo then
		return
	end

	self:refreshUI(self.index, deviceInfo)
end

function FightDevicePlayCardItem:refreshAnchor()
	if not self.loadedDone then
		return
	end

	self:killMoveTween()

	local anchor = FightDeviceHelper.getDeviceItemAnchorX(self.index)

	recthelper.setAnchorX(self.rectTr, anchor)
end

function FightDevicePlayCardItem:playScanEffect(success)
	if not self.loadedDone then
		return
	end

	if success then
		self:playAnim("success")
	else
		self:playAnim("fail")
	end
end

function FightDevicePlayCardItem:onCancelOperateWhenMeiLeiErExRound()
	local effectUrl = "ui/viewres/fight/fightmeileierercard.prefab"

	self.loaderComp:loadAsset(effectUrl, self.onMeiLerErEffectLoaded, self)
end

function FightDevicePlayCardItem:onMeiLerErEffectLoaded(success, assetItem)
	if not success then
		return
	end

	local prefab = assetItem:GetResource()
	local parentRoot

	if self.isBigSkill then
		parentRoot = gohelper.findChild(self.go, "unique/melieercard")
	else
		parentRoot = gohelper.findChild(self.go, "normal/melieercard")
	end

	local go = gohelper.clone(prefab, parentRoot)
	local normal = gohelper.findChild(go, "#nomal")
	local unique = gohelper.findChild(go, "ultimate")

	gohelper.setActive(normal, true)
	gohelper.setActive(unique, false)

	if self.isBigSkill then
		gohelper.setActive(normal, false)
		gohelper.setActive(unique, true)
	end

	self.timerComp:registRepeatTimer(self.removeMeiLerErEffect, self, 1.2, 1, go)
end

function FightDevicePlayCardItem:removeMeiLerErEffect(go)
	gohelper.destroy(go)
end

function FightDevicePlayCardItem:dispose()
	if self.msgComp then
		self.msgComp:disposeSelf()

		self.msgComp = nil
	end

	if self.loaderComp then
		self.loaderComp:disposeSelf()

		self.loaderComp = nil
	end

	if self.timerComp then
		self.timerComp:disposeSelf()

		self.timerComp = nil
	end

	self:killMoveTween()

	if self.click then
		self.click:RemoveClickListener()

		self.click = nil
	end

	if self.drag then
		self.drag:RemoveDragBeginListener()
		self.drag:RemoveDragListener()
		self.drag:RemoveDragEndListener()

		self.drag = nil
	end

	if self.longPress then
		self.longPress:RemoveLongPressListener()

		self.longPress = nil
	end

	if self.lockComp then
		self.lockComp:dispose()

		self.lockComp = nil
	end

	FightDevicePlayCardItem.super.dispose(self)
end

return FightDevicePlayCardItem
