module("modules.logic.fight.view.FightBloodPoolView", package.seeall)

slot0 = class("FightBloodPoolView", FightBaseView)

function slot0.onConstructor(slot0, slot1)
	slot0.teamType = slot1
end

function slot0.onInitView(slot0)
	slot0.goPreTxt = gohelper.findChild(slot0.viewGO, "root/num/bottom/txt_preparation")
	slot0.bottomNumTxt = gohelper.findChildText(slot0.viewGO, "root/num/bottom/#txt_num")
	slot0.bottomPreNumTxt = gohelper.findChildText(slot0.viewGO, "root/num/bottom/txt_preparation/#txt_preparation")
	slot0.bottomNumAnimator = gohelper.findChildComponent(slot0.viewGO, "root/num/bottom", gohelper.Type_Animator)
	slot0.goLeft = gohelper.findChild(slot0.viewGO, "root/num/left")
	slot0.leftMaxTxt = gohelper.findChildText(slot0.viewGO, "root/num/left/#txt_num1")
	slot0.leftCurTxt = gohelper.findChildText(slot0.viewGO, "root/num/left/#txt_num1/#txt_num2")
	slot0.leftEffMaxTxt = gohelper.findChildText(slot0.viewGO, "root/num/left/#txt_num1eff")
	slot0.leftEffCurTxt = gohelper.findChildText(slot0.viewGO, "root/num/left/#txt_num1eff/#txt_num2")
	slot0.heartAnimator = gohelper.findChildComponent(slot0.viewGO, "root/heart", gohelper.Type_Animator)
	slot0.imageHeart = gohelper.findChildImage(slot0.viewGO, "root/heart/unbroken/#image_heart")
	slot0.imageHeartPre = gohelper.findChildImage(slot0.viewGO, "root/heart/unbroken/#image_heart_broken")
	slot0.imageHeartMat = slot0.imageHeart.material
	slot0.imageHeartPreMat = slot0.imageHeartPre.material
	slot0.heightPropertyId = UnityEngine.Shader.PropertyToID("_LerpOffset")
	slot0.longPress = SLFramework.UGUI.UILongPressListener.Get(gohelper.findChild(slot0.viewGO, "root/#btn_click"))

	slot0.longPress:SetLongPressTime({
		0.5,
		99999
	})

	slot0.preCostBloodValue = 0
	slot0.bloodPoolSkillId = FightHelper.getBloodPoolSkillId()

	gohelper.setActive(slot0.goPreTxt, false)
end

slot0.HeartTweenDuration = 0.5

function slot0.addEvents(slot0)
	slot0:com_registFightEvent(FightEvent.BloodPool_MaxValueChange, slot0.onMaxValueChange)
	slot0:com_registFightEvent(FightEvent.BloodPool_ValueChange, slot0.onValueChange)
	slot0:com_registFightEvent(FightEvent.BloodPool_OnPlayCard, slot0.onPlayBloodCard)
	slot0:com_registFightEvent(FightEvent.BloodPool_OnCancelPlayCard, slot0.onCancelPlayBloodCard)
	slot0:com_registFightEvent(FightEvent.RespBeginRound, slot0.onRespBeginRound)
	slot0:com_registFightEvent(FightEvent.BeforePlayHandCard, slot0.onPlayHandCard)
	slot0.longPress:AddClickListener(slot0.onClickBlood, slot0)
	slot0.longPress:AddLongPressListener(slot0.onLongPressBlood, slot0)
end

function slot0.onPlayHandCard(slot0, slot1)
	if not (FightDataHelper.handCardMgr.handCard and slot2[slot1]) then
		return
	end

	slot0:calculateSkillPreCostBloodValue(slot3.skillId)
	slot0:refreshPreCostBloodValue()
end

slot0.BloodValueChangeBehaviorId = 60191

function slot0.calculateSkillPreCostBloodValue(slot0, slot1)
	if not (slot1 and lua_skill.configDict[slot1]) then
		return
	end

	if not lua_skill_effect.configDict[slot2.skillEffect] then
		return
	end

	for slot7 = 1, FightEnum.MaxBehavior do
		if not string.nilorempty(slot3["behavior" .. slot7]) then
			for slot13, slot14 in ipairs(FightStrUtil.instance:getSplitString2Cache(slot8, true)) do
				if slot14[1] == uv0.BloodValueChangeBehaviorId then
					slot0.preCostBloodValue = slot0.preCostBloodValue + slot14[2]
				end
			end
		end
	end
end

function slot0.refreshPreCostBloodValue(slot0)
	slot1 = FightDataHelper.getBloodPool(slot0.teamType)
	slot2 = slot1.max
	slot3 = math.max(math.min(slot2, slot1.value + slot0.preCostBloodValue), 0)
	slot4 = string.format("%s/%s", slot3, slot2)
	slot0.bottomNumTxt.text = slot4
	slot0.bottomPreNumTxt.text = slot4
	slot0.leftCurTxt.text = slot3
	slot0.leftEffCurTxt.text = slot3

	slot0.imageHeartPreMat:SetFloat(slot0.heightPropertyId, slot3 / slot2)
	slot0:refreshPreTxtActive()
end

function slot0.refreshPreTxtActive(slot0)
	gohelper.setActive(slot0.goPreTxt, slot0.preCostBloodValue ~= 0)
end

function slot0.onPlayBloodCard(slot0)
	slot0.heartAnimator:Play("click", 0, 0)
	slot0:calculateSkillPreCostBloodValue(slot0.bloodPoolSkillId)
	slot0:refreshPreCostBloodValue()
end

function slot0.onCancelPlayBloodCard(slot0)
	slot0.heartAnimator:Play("idle", 0, 0)

	slot0.preCostBloodValue = 0

	slot0:directSetBloodValue()
end

function slot0.onRespBeginRound(slot0)
	FightDataHelper.bloodPoolDataMgr:onCancelOperation()
end

function slot0.onClickBlood(slot0)
	if FightModel.instance:getCurStage() == FightEnum.Stage.AutoCard then
		return
	end

	if FightModel.instance:getCurStage() ~= FightEnum.Stage.Card then
		return
	end

	if FightDataHelper.operationDataMgr:isCardOpEnd() then
		return
	end

	if FightViewHandCard.blockOperate then
		return
	end

	if not FightDataHelper.getBloodPool(slot0.teamType) then
		return
	end

	if slot1.value < 1 then
		GameFacade.showToast(ToastEnum.NotEnoughBlood)

		return
	end

	if FightDataHelper.bloodPoolDataMgr:checkPlayedCard() then
		return
	end

	slot2 = FightDataHelper.operationDataMgr:newOperation()

	slot2:playBloodPoolCard(slot0.bloodPoolSkillId)
	FightController.instance:dispatchEvent(FightEvent.AddPlayOperationData, slot2)
	FightController.instance:dispatchEvent(FightEvent.onNoActCostMoveFlowOver)
	FightController.instance:dispatchEvent(FightEvent.RefreshPlayCardRoundOp, slot2)
	FightController.instance:dispatchEvent(FightEvent.OnPlayAssistBossCardFlowDone, slot2)
	FightDataHelper.bloodPoolDataMgr:playBloodPoolCard()
	AudioMgr.instance:trigger(20270004)
end

function slot0.onLongPressBlood(slot0)
	if FightModel.instance:getCurStage() == FightEnum.Stage.AutoCard then
		return
	end

	if FightModel.instance:getCurStage() ~= FightEnum.Stage.Card then
		return
	end

	if FightDataHelper.operationDataMgr:isCardOpEnd() then
		return
	end

	if FightViewHandCard.blockOperate then
		return
	end

	if not FightDataHelper.getBloodPool(slot0.teamType) then
		return
	end

	ViewMgr.instance:openView(ViewName.FightBloodPoolTipView)
end

function slot0.onMaxValueChange(slot0, slot1)
	if slot1 ~= slot0.teamType then
		return
	end

	slot0:refreshTxt()
end

function slot0.onValueChange(slot0, slot1)
	if slot1 ~= slot0.teamType then
		return
	end

	slot0:refreshTxt()
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(20270005)
	slot0:refreshTxt()
end

function slot0.recordPreValue(slot0)
	slot1 = FightDataHelper.getBloodPool(slot0.teamType)
	slot0.preValue = slot1.value
	slot0.preMaxValue = slot1.max
end

function slot0.refreshTxt(slot0)
	if not slot0.inited then
		slot0:directSetBloodValue()
		slot0:recordPreValue()
		slot0.heartAnimator:Play("add", 0, 0)

		slot0.inited = true

		return
	end

	slot0:cleanHeartImageTween()

	slot1 = FightDataHelper.getBloodPool(slot0.teamType)
	slot0.valueChangeLen = slot1.value - slot0.preValue
	slot0.maxValueChangeLen = slot1.max - slot0.preMaxValue
	slot0.startValue = slot0.preValue
	slot0.startMaxValue = slot0.preMaxValue

	slot0:recordPreValue()

	slot0.heartTweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, uv0.HeartTweenDuration, slot0.onHeartTweenFrame, slot0.onHeartTweenDone, slot0)

	slot0.bottomNumAnimator:Play("add", 0, 0)
	AudioMgr.instance:trigger(20270006)
	gohelper.setActive(slot0.goLeft, false)
	gohelper.setActive(slot0.goLeft, true)
end

function slot0.cleanHeartImageTween(slot0)
	if slot0.heartTweenId then
		ZProj.TweenHelper.KillById(slot0.heartTweenId)

		slot0.heartTweenId = nil
	end
end

function slot0.onHeartTweenFrame(slot0, slot1)
	slot0:setNumAndImage(math.floor(LuaTween.linear(slot1, slot0.startValue, slot0.valueChangeLen, 1)), math.floor(LuaTween.linear(slot1, slot0.startMaxValue, slot0.maxValueChangeLen, 1)))
end

function slot0.onHeartTweenDone(slot0)
	slot0:directSetBloodValue()
	slot0:recordPreValue()

	slot0.heartTweenId = nil
end

function slot0.directSetBloodValue(slot0)
	slot1 = FightDataHelper.getBloodPool(slot0.teamType)

	slot0:setNumAndImage(slot1.value, slot1.max)
end

function slot0.setNumAndImage(slot0, slot1, slot2)
	slot3 = string.format("%s/%s", slot1, slot2)
	slot0.bottomNumTxt.text = slot3
	slot0.bottomPreNumTxt.text = slot3
	slot0.leftMaxTxt.text = slot2
	slot0.leftCurTxt.text = slot1
	slot0.leftEffMaxTxt.text = slot2
	slot0.leftEffCurTxt.text = slot1
	slot4 = slot1 / slot2

	slot0.imageHeartMat:SetFloat(slot0.heightPropertyId, slot4)
	slot0.imageHeartPreMat:SetFloat(slot0.heightPropertyId, slot4)
	slot0:refreshPreTxtActive()
end

function slot0.onDestroyView(slot0)
	slot0:cleanHeartImageTween()
	slot0.longPress:RemoveClickListener()
	slot0.longPress:RemoveLongPressListener()

	slot0.longPress = nil
end

return slot0
