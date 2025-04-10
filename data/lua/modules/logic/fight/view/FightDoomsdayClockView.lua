module("modules.logic.fight.view.FightDoomsdayClockView", package.seeall)

slot0 = class("FightDoomsdayClockView", FightBaseView)

function slot0.onInitView(slot0)
	slot0.animator = slot0.viewGO:GetComponent(gohelper.Type_Animator)
	slot0.goBroken = gohelper.findChild(slot0.viewGO, "root/clock/broken")
	slot0.goZhiZhen = gohelper.findChild(slot0.viewGO, "root/clock/unbroken/#image_zhizhen")
	slot0.trZhiZhen = slot0.goZhiZhen:GetComponent(gohelper.Type_Transform)
	slot0.areaTransform = gohelper.findChildComponent(slot0.viewGO, "root/clock/unbroken/#go_area", gohelper.Type_Transform)
	slot0.imageOrange = gohelper.findChildImage(slot0.viewGO, "root/clock/unbroken/#go_area/#image_orange")
	slot0.imageYellow = gohelper.findChildImage(slot0.viewGO, "root/clock/unbroken/#go_area/#image_yellow")
	slot0.imageRed = gohelper.findChildImage(slot0.viewGO, "root/clock/unbroken/#go_area/#image_red")
	slot0.imageGreen = gohelper.findChildImage(slot0.viewGO, "root/clock/unbroken/#go_area/#image_green")
	slot0.btnClick = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/#btn_click")
	slot0.timeValueAnimator = gohelper.findChildComponent(slot0.viewGO, "root/timevalue", gohelper.Type_Animator)
	slot0.timeValueBg = gohelper.findChildComponent(slot0.viewGO, "root/timevalue/bg", gohelper.Type_Image)
	slot0.timeValueBgGlow = gohelper.findChildComponent(slot0.viewGO, "root/timevalue/bg_glow", gohelper.Type_Image)
	slot4 = gohelper.Type_RectTransform
	slot0.rectAnimRoot = gohelper.findChildComponent(slot0.viewGO, "root/timevalue/scroll/animroot", slot4)
	slot0.txtTimeList = {}
	slot0.goTimeList = slot0:getUserDataTb_()

	for slot4 = 1, 5 do
		slot5 = gohelper.findChild(slot0.viewGO, "root/timevalue/scroll/animroot/#go_time_" .. slot4)

		table.insert(slot0.goTimeList, slot5)

		slot6 = slot0:getUserDataTb_()
		slot0.txtTimeList[slot4] = slot6
		slot6[FightParamData.ParamKey.DoomsdayClock_Range1] = gohelper.findChildText(slot5, "#txt_time_orange")
		slot6[FightParamData.ParamKey.DoomsdayClock_Range2] = gohelper.findChildText(slot5, "#txt_time_yellow")
		slot6[FightParamData.ParamKey.DoomsdayClock_Range3] = gohelper.findChildText(slot5, "#txt_time_red")
		slot6[FightParamData.ParamKey.DoomsdayClock_Range4] = gohelper.findChildText(slot5, "#txt_time_green")
	end

	slot0.key2Image = slot0:getUserDataTb_()
	slot0.key2Image[FightParamData.ParamKey.DoomsdayClock_Range1] = slot0.imageOrange
	slot0.key2Image[FightParamData.ParamKey.DoomsdayClock_Range2] = slot0.imageYellow
	slot0.key2Image[FightParamData.ParamKey.DoomsdayClock_Range3] = slot0.imageRed
	slot0.key2Image[FightParamData.ParamKey.DoomsdayClock_Range4] = slot0.imageGreen
	slot0.key2ImageLine = slot0:getUserDataTb_()
	slot0.key2ImageLine[FightParamData.ParamKey.DoomsdayClock_Range1] = gohelper.findChildComponent(slot0.viewGO, "root/clock/unbroken/#go_area/line1", gohelper.Type_RectTransform)
	slot0.key2ImageLine[FightParamData.ParamKey.DoomsdayClock_Range2] = gohelper.findChildComponent(slot0.viewGO, "root/clock/unbroken/#go_area/line2", gohelper.Type_RectTransform)
	slot0.key2ImageLine[FightParamData.ParamKey.DoomsdayClock_Range3] = gohelper.findChildComponent(slot0.viewGO, "root/clock/unbroken/#go_area/line3", gohelper.Type_RectTransform)
	slot4 = slot0.viewGO
	slot5 = "root/clock/unbroken/#go_area/line4"
	slot0.key2ImageLine[FightParamData.ParamKey.DoomsdayClock_Range4] = gohelper.findChildComponent(slot4, slot5, gohelper.Type_RectTransform)
	slot0.key2Transform = slot0:getUserDataTb_()
	slot0.key2ImageEffect = slot0:getUserDataTb_()

	for slot4, slot5 in pairs(slot0.key2Image) do
		slot0.key2Transform[slot4] = slot5:GetComponent(gohelper.Type_RectTransform)
		slot0.key2ImageEffect[slot4] = gohelper.findChild(slot5.gameObject, "#glow")
	end

	slot0.goAdd = gohelper.findChild(slot0.viewGO, "root/num/add")
	slot0.txtAdd = gohelper.findChildText(slot0.viewGO, "root/num/add/#txt_add")
	slot0.goReduce = gohelper.findChild(slot0.viewGO, "root/num/reduce")
	slot0.txtReduce = gohelper.findChildText(slot0.viewGO, "root/num/reduce/#txt_reduce")
	slot0.indicatorValue = FightDataHelper.fieldMgr:getIndicatorNum(FightEnum.IndicatorId.DoomsdayClock) or 0

	slot0:setTimeValueActive(false)
	gohelper.setActive(slot0.goBroken, false)

	slot0.keyList = {
		FightParamData.ParamKey.DoomsdayClock_Range1,
		FightParamData.ParamKey.DoomsdayClock_Range2,
		FightParamData.ParamKey.DoomsdayClock_Range3,
		FightParamData.ParamKey.DoomsdayClock_Range4
	}
end

slot0.AreaId2Color = {
	[FightParamData.ParamKey.DoomsdayClock_Range1] = "#e56745",
	[FightParamData.ParamKey.DoomsdayClock_Range2] = "#4c7bff",
	[FightParamData.ParamKey.DoomsdayClock_Range3] = "#e54550",
	[FightParamData.ParamKey.DoomsdayClock_Range4] = "#60cace"
}
slot0.ZhiZhenTweenDuration = 0.5

function slot0.addEvents(slot0)
	slot0:com_registFightEvent(FightEvent.DoomsdayClock_OnValueChange, slot0.onValueChange)
	slot0:com_registFightEvent(FightEvent.DoomsdayClock_OnAreaChange, slot0.onAreaChange)
	slot0:com_registFightEvent(FightEvent.DoomsdayClock_OnBroken, slot0.onBroken)
	slot0:com_registFightEvent(FightEvent.OnIndicatorChange, slot0.onIndicatorChange)
	slot0:com_registFightEvent(FightEvent.DoomsdayClock_OnClear, slot0.onClear)
	slot0.btnClick:AddClickListener(slot0.onClickClock, slot0)
end

function slot0.onClickClock(slot0)
	HelpController.instance:showHelp(HelpEnum.HelpId.V2A7_boss)
end

function slot0.onClear(slot0)
	slot0:refreshHighlightArea()
end

function slot0.refreshHighlightArea(slot0)
	slot3 = FightParamData.ParamKey.DoomsdayClock_Range1

	for slot7, slot8 in ipairs(slot0.keyList) do
		if slot0:formatValue(slot0:getParamValue(FightParamData.ParamKey.DoomsdayClock_Value) + slot0:getParamValue(FightParamData.ParamKey.DoomsdayClock_Offset)) < slot0:getParamValue(slot8) then
			slot3 = slot8

			break
		end
	end

	slot4 = slot0.AreaId2Color[slot3] or "#ffd84c"

	for slot8, slot9 in pairs(slot0.key2ImageEffect) do
		gohelper.setActive(slot9, false)

		if slot8 == slot3 then
			gohelper.setActive(slot9, true)
		end
	end

	SLFramework.UGUI.GuiHelper.SetColor(slot0.timeValueBgGlow, slot4)
	slot0:refreshTxtColor(slot3)
	slot0.timeValueAnimator:Play("switch", 0, 0)
end

function slot0.refreshTxtColor(slot0, slot1)
	for slot5, slot6 in ipairs(slot0.txtTimeList) do
		for slot10, slot11 in pairs(slot6) do
			gohelper.setActive(slot11.gameObject, slot10 == slot1)
		end
	end
end

function slot0.formatValue(slot0, slot1)
	slot2 = slot0:getParamValue(FightParamData.ParamKey.DoomsdayClock_Range4)

	while slot1 < 0 do
		slot1 = slot1 + slot2
	end

	while slot2 <= slot1 do
		slot1 = slot1 - slot2
	end

	return slot1
end

function slot0.onBroken(slot0)
	gohelper.setActive(slot0.goBroken, true)
	AudioMgr.instance:trigger(20270057)
end

slot0.ItemHeight = 25
slot0.ItemCount = 5
slot0.ScrollCenterCount = 3
slot0.ScrollDuration = 1

function slot0.onIndicatorChange(slot0, slot1, slot2)
	if slot1 ~= FightEnum.IndicatorId.DoomsdayClock then
		return
	end

	if not slot2 or slot2 == 0 then
		return
	end

	FightModel.instance:setWaitIndicatorAnimation(true)

	slot0.startValue = slot0.indicatorValue
	slot0.endValue = slot0.indicatorValue + slot2
	slot0.indicatorValue = slot0.endValue
	slot0.totalOffset = math.abs(slot2)
	slot0.offsetSymbol = slot2 / slot0.totalOffset
	slot0.scrollLen = slot2 * uv0.ItemHeight

	if math.abs(slot2) <= 2 then
		slot3 = uv0.ScrollDuration / 2
	end

	slot0.speed = slot0.scrollLen / slot3
	slot0.scrolledAnchorY = 0
	slot0.scrolledOffset = 0

	slot0:setTimeValueTxt(slot0.startValue)
	slot0:setTimeValueActive(true)
	recthelper.setAnchorY(slot0.rectAnimRoot, 0)

	slot0.startScrollAnim = true
end

function slot0._onFrame(slot0)
	if not slot0.startScrollAnim then
		return
	end

	slot3 = Time.deltaTime * slot0.speed
	slot0.scrolledAnchorY = slot0.scrolledAnchorY + slot3

	recthelper.setAnchorY(slot0.rectAnimRoot, recthelper.getAnchorY(slot0.rectAnimRoot) + slot3)

	if uv0.ItemHeight <= math.abs(slot0.scrolledAnchorY) then
		slot0:onScrolledOneItemHeight()
	end
end

function slot0.onScrolledOneItemHeight(slot0)
	slot0.scrolledOffset = slot0.scrolledOffset + 1
	slot0.scrolledAnchorY = 0

	recthelper.setAnchorY(slot0.rectAnimRoot, 0)
	slot0:setTimeValueTxt(slot0.startValue + slot0.scrolledOffset * slot0.offsetSymbol)

	if slot0.scrolledOffset == slot0.totalOffset then
		slot0:onScrollAnimDone()
	end
end

function slot0.setTimeValueTxt(slot0, slot1)
	for slot5, slot6 in ipairs(slot0.txtTimeList) do
		for slot10, slot11 in pairs(slot6) do
			slot11.text = slot1 - uv0.ScrollCenterCount + slot5
		end
	end
end

function slot0.setTimeValueActive(slot0, slot1)
	for slot5, slot6 in ipairs(slot0.goTimeList) do
		gohelper.setActive(slot6, slot1 or slot5 == uv0.ScrollCenterCount)
	end
end

function slot0.onScrollAnimDone(slot0)
	slot0.startScrollAnim = false

	slot0:setTimeValueTxt(slot0.indicatorValue)
	slot0:setTimeValueActive(false)
	FightController.instance:dispatchEvent(FightEvent.OnIndicatorAnimationDone)
end

function slot0.onValueChange(slot0, slot1, slot2, slot3)
	slot0:tweenZhiZhen(slot3)
	slot0:showFloat(slot3)
	slot0.timeValueAnimator:Play("fit", 0, 0)
end

function slot0.onAreaChange(slot0)
	slot0:refreshArea()
	slot0:tweenZhiZhen()
end

function slot0.getParamValue(slot0, slot1)
	return FightDataHelper.fieldMgr.param and slot2:getKey(slot1) or 0
end

function slot0.onOpen(slot0)
	slot0.animator:Play("open")
	slot0:setTimeValueTxt(slot0.indicatorValue)
	slot0:refreshHighlightArea()
	slot0:refreshArea()
	slot0:directSetZhiZhenPos()
	slot0:initUpdateBeat()
end

function slot0.initUpdateBeat(slot0)
	slot0.updateHandle = UpdateBeat:CreateListener(slot0._onFrame, slot0)

	UpdateBeat:AddListener(slot0.updateHandle)
end

function slot0.tweenZhiZhen(slot0, slot1)
	slot0:clearZhiZhenTween()

	if not slot1 then
		slot0:directSetZhiZhenPos()

		return
	end

	slot2 = slot0:getParamValue(FightParamData.ParamKey.DoomsdayClock_Value)
	slot0.zhiZhenTweenId = ZProj.TweenHelper.DOTweenFloat(slot2 - slot1, slot2, uv0.ZhiZhenTweenDuration, slot0.tweenFrame, slot0.directSetZhiZhenPos, slot0)

	AudioMgr.instance:trigger(20270055)
end

function slot0.tweenFrame(slot0, slot1)
	transformhelper.setLocalRotation(slot0.trZhiZhen, 0, 0, -(slot1 / slot0:getParamValue(FightParamData.ParamKey.DoomsdayClock_Range4) * 360))
end

function slot0.directSetZhiZhenPos(slot0)
	transformhelper.setLocalRotation(slot0.trZhiZhen, 0, 0, slot0:getZhiZhenCurRotation())
end

function slot0.getZhiZhenCurRotation(slot0)
	return -(slot0:getParamValue(FightParamData.ParamKey.DoomsdayClock_Value) / slot0:getParamValue(FightParamData.ParamKey.DoomsdayClock_Range4) * 360)
end

slot0.RotateCircleAngle = 1800
slot0.RotateDuration = 1
slot0.RotateEaseType = EaseType.OutCirc

function slot0.refreshArea(slot0)
	slot4 = slot0:getParamValue(FightParamData.ParamKey.DoomsdayClock_Offset) / slot0:getParamValue(FightParamData.ParamKey.DoomsdayClock_Range4) * 360
	slot5 = 0

	for slot9, slot10 in pairs(slot0.key2Image) do
		slot11 = slot0:getParamValue(slot9) - slot5
		slot10.fillAmount = slot11 / slot2
		slot13 = slot5 / slot2 * 360

		transformhelper.setLocalRotation(slot0.key2Transform[slot9], 0, 0, -slot13 + slot4)
		transformhelper.setLocalRotation(slot0.key2ImageLine[slot9], 0, 0, -slot13 + slot4 - 180)

		slot5 = slot5 + slot11
	end

	slot0:clearRotationTween()

	slot0.tweenRotationId = ZProj.TweenHelper.DOTweenFloat(0, uv0.RotateCircleAngle, uv0.RotateDuration, slot0.onRotateFrameCallback, slot0.onRotateDoneCallback, slot0, nil, uv0.RotateEaseType)

	AudioMgr.instance:trigger(20270056)
end

function slot0.onRotateFrameCallback(slot0, slot1)
	transformhelper.setLocalRotation(slot0.areaTransform, 0, 0, slot1)
end

function slot0.onRotateDoneCallback(slot0)
	transformhelper.setLocalRotation(slot0.areaTransform, 0, 0, 0)

	slot0.tweenRotationId = nil
end

function slot0.showFloat(slot0, slot1)
	slot0:hideFloat()
	TaskDispatcher.cancelTask(slot0.hideFloat, slot0)

	if slot1 > 0 then
		gohelper.setActive(slot0.goAdd, true)

		slot0.txtAdd.text = string.format("%+d", slot1)
	else
		gohelper.setActive(slot0.goReduce, true)

		slot0.txtReduce.text = string.format("%+d", slot1)
	end

	TaskDispatcher.runDelay(slot0.hideFloat, slot0, 1)
end

function slot0.hideFloat(slot0)
	gohelper.setActive(slot0.goAdd, false)
	gohelper.setActive(slot0.goReduce, false)
end

function slot0.clearZhiZhenTween(slot0)
	if slot0.zhiZhenTweenId then
		ZProj.TweenHelper.KillById(slot0.zhiZhenTweenId)

		slot0.zhiZhenTweenId = nil
	end
end

function slot0.clearRotationTween(slot0)
	if slot0.tweenRotationId then
		ZProj.TweenHelper.KillById(slot0.tweenRotationId)

		slot0.tweenRotationId = nil
	end
end

function slot0.onDestroyView(slot0)
	if slot0.updateHandle then
		UpdateBeat:RemoveListener(slot0.updateHandle)
	end

	if slot0.btnClick then
		slot0.btnClick:RemoveClickListener()

		slot0.btnClick = nil
	end

	slot0:clearZhiZhenTween()
	slot0:clearRotationTween()
	TaskDispatcher.cancelTask(slot0.hideFloat, slot0)
end

return slot0
