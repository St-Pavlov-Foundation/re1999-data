module("modules.logic.versionactivity2_6.dicehero.view.DiceHeroDiceBoxItem", package.seeall)

slot0 = class("DiceHeroDiceBoxItem", LuaCompBase)

function slot0.ctor(slot0, slot1)
	slot0._parentView = slot1
end

function slot0.init(slot0, slot1)
	slot0._goreroll = gohelper.findChild(slot1, "#go_reroll")
	slot0._goend = gohelper.findChild(slot1, "#go_end")
	slot0._godices = gohelper.findChild(slot1, "dices")
	slot0._btnreroll = gohelper.findChildButtonWithAudio(slot1, "#go_reroll/#btn_reroll")
	slot0._btnconfirm = gohelper.findChildButtonWithAudio(slot1, "#go_reroll/#btn_confirm")
	slot0._goconfirmeffect = gohelper.findChild(slot1, "#go_reroll/#btn_confirm/#hint")
	slot0._btnskip = gohelper.findChildButtonWithAudio(slot1, "#go_reroll/#btn_skip")
	slot0._btnend = gohelper.findChildButtonWithAudio(slot1, "#go_end/#btn_endround")
	slot0._goendeffect = gohelper.findChild(slot1, "#go_end/#btn_endround/#hint")
	slot0._btnusecard = gohelper.findChildButtonWithAudio(slot1, "#go_end/#btn_usecard")
	slot0._txtrollnum = gohelper.findChildTextMesh(slot1, "#go_reroll/#btn_reroll/#txt_rollnum")
	slot0._selectDict = {}
	slot0._dices = {}

	for slot6 = 1, 12 do
		slot7 = gohelper.findChild(slot0._godices, tostring(slot6))
		slot0._dices[slot6] = MonoHelper.addNoUpdateLuaComOnceToGo(slot0._parentView:getResInst(slot0._parentView.viewContainer._viewSetting.otherRes.diceitem, slot7), DiceHeroDiceItem, {
			index = slot6
		})

		slot0:addClickCb(gohelper.findChildButton(slot7, ""), slot0._onDiceClick, slot0, slot6)
	end

	if lua_dice_level.configDict[DiceHeroModel.instance.lastEnterLevelId] then
		if DiceHeroModel.instance:getGameInfo(slot4.chapter).currLevel ~= slot3 or slot5.allPass then
			gohelper.setActive(slot0._btnskip, true)
		else
			gohelper.setActive(slot0._btnskip, false)
		end
	else
		gohelper.setActive(slot0._btnskip, false)
	end

	slot0:onProgressUpdate()
	slot0:updateRollNum()
end

function slot0.addEventListeners(slot0)
	slot0._btnreroll:AddClickListener(slot0._onClickReroll, slot0)
	slot0._btnconfirm:AddClickListener(slot0._onClickConfirm, slot0)
	slot0._btnend:AddClickListener(slot0._onClickEnd, slot0)
	slot0._btnskip:AddClickListener(slot0._onClickSkip, slot0)
	slot0._btnusecard:AddClickListener(slot0._onClickUseCard, slot0)
	DiceHeroController.instance:registerCallback(DiceHeroEvent.ConfirmDice, slot0.onProgressUpdate, slot0)
	DiceHeroController.instance:registerCallback(DiceHeroEvent.StepEnd, slot0.onStepEnd, slot0)
	DiceHeroController.instance:registerCallback(DiceHeroEvent.SkillCardSelectChange, slot0.onSkillCardSelectChange, slot0)
	DiceHeroController.instance:registerCallback(DiceHeroEvent.SkillCardDiceChange, slot0.updateUseCardStatu, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._btnreroll:RemoveClickListener()
	slot0._btnconfirm:RemoveClickListener()
	slot0._btnend:RemoveClickListener()
	slot0._btnskip:RemoveClickListener()
	slot0._btnusecard:RemoveClickListener()
	DiceHeroController.instance:unregisterCallback(DiceHeroEvent.ConfirmDice, slot0.onProgressUpdate, slot0)
	DiceHeroController.instance:unregisterCallback(DiceHeroEvent.StepEnd, slot0.onStepEnd, slot0)
	DiceHeroController.instance:unregisterCallback(DiceHeroEvent.SkillCardSelectChange, slot0.onSkillCardSelectChange, slot0)
	DiceHeroController.instance:unregisterCallback(DiceHeroEvent.SkillCardDiceChange, slot0.updateUseCardStatu, slot0)
end

function slot0.onStepEnd(slot0, slot1)
	for slot5 = 1, 12 do
		slot0._dices[slot5]:onStepEnd(slot1)
	end

	slot0:onProgressUpdate()
	slot0:updateRollNum()
	slot0:checkEndEffect()

	if DiceHeroFightModel.instance:getGameData().diceBox.resetTimes <= 0 and not slot2.confirmed and DiceHeroFightModel.instance.finishResult == DiceHeroEnum.GameStatu.None then
		slot0:_onClickConfirm()
	end
end

function slot0.startRoll(slot0)
	slot0._selectDict = {}

	for slot4 = 1, 12 do
		slot0._dices[slot4]:startRoll()
	end
end

function slot0.updateRollNum(slot0)
	if DiceHeroFightModel.instance:getGameData().diceBox.resetTimes > 0 then
		slot0._txtrollnum.text = slot1.resetTimes .. "/" .. slot1.maxResetTimes
	else
		slot0._txtrollnum.text = "<color=#cd5353>" .. slot1.resetTimes .. "</color>/" .. slot1.maxResetTimes
	end

	gohelper.setActive(slot0._goconfirmeffect, slot1.resetTimes <= 0)
end

function slot0.onProgressUpdate(slot0)
	slot1 = DiceHeroFightModel.instance:getGameData()

	gohelper.setActive(slot0._goreroll, not slot1.confirmed)
	gohelper.setActive(slot0._goend, slot1.confirmed)

	if slot1.confirmed then
		slot0:checkEndEffect()
	end
end

function slot0.checkEndEffect(slot0)
	slot1 = true

	for slot6, slot7 in pairs(DiceHeroFightModel.instance:getGameData().skillCards) do
		if slot7:canSelect() then
			slot1 = false

			break
		end
	end

	gohelper.setActive(slot0._goendeffect, slot1)
end

function slot0._onDiceClick(slot0, slot1)
	if DiceHeroHelper.instance:isInFlow() then
		return
	end

	if not slot0._dices[slot1].diceMo or slot2.deleted then
		return
	end

	slot3 = DiceHeroFightModel.instance:getGameData()
	slot4 = slot3.curSelectCardMo

	if not slot3.confirmed then
		if slot2.status ~= DiceHeroEnum.DiceStatu.Normal then
			return
		end

		if slot0._selectDict[slot1] then
			slot0._selectDict[slot1] = nil

			slot0._dices[slot1]:setSelect(false)
			AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_wenming_cardunready)
		else
			slot0._selectDict[slot1] = true

			slot0._dices[slot1]:setSelect(true)
			AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_wenming_cardready)
		end
	else
		if not slot4 then
			return
		end

		if slot2.status == DiceHeroEnum.DiceStatu.HardLock then
			return
		end

		if slot0._selectDict[slot1] then
			slot4:removeDice(slot2.uid)
		elseif not slot4:addDice(slot2.uid) then
			return
		end

		if slot0._selectDict[slot1] then
			slot0._selectDict[slot1] = nil

			AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_wenming_cardunready)
		else
			slot0._selectDict[slot1] = true

			AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_wenming_cardready)
		end

		slot5 = slot4:getCanUseDiceUidDict()

		for slot9 = 1, 12 do
			if slot0._dices[slot9].diceMo and not slot0._dices[slot9].diceMo.deleted then
				if slot0._selectDict[slot9] then
					slot0._dices[slot9]:setSelect(true)
				else
					slot0._dices[slot9]:setSelect(false, slot5[slot0._dices[slot9].diceMo.uid] and true or false)
				end
			end
		end
	end
end

function slot0._onClickUseCard(slot0)
	if not DiceHeroFightModel.instance:getGameData().curSelectCardMo then
		return
	end

	slot3, slot4 = slot2:canUse()

	if not slot3 then
		return
	end

	DiceHeroRpc.instance:sendDiceHeroUseSkill(DiceHeroEnum.SkillType.Normal, slot2.skillId, slot1.curSelectEnemyMo and slot1.curSelectEnemyMo.uid or "", slot4, slot3 > 0 and slot3 - 1 or slot3)
end

function slot0.onSkillCardSelectChange(slot0)
	if not DiceHeroFightModel.instance:getGameData().confirmed then
		return
	end

	slot0._selectDict = {}

	if slot1.curSelectCardMo then
		slot3, slot4 = slot2:isMatchMin(true)

		if slot3 then
			for slot8, slot9 in ipairs(slot4) do
				for slot13 = 1, 12 do
					if slot0._dices[slot13].diceMo and slot0._dices[slot13].diceMo.uid == slot9 and slot2:addDice(slot9) then
						slot0._selectDict[slot13] = true

						break
					end
				end
			end
		end
	end

	slot3 = slot2 and slot2:getCanUseDiceUidDict()

	for slot7 = 1, 12 do
		if slot0._dices[slot7].diceMo and not slot0._dices[slot7].diceMo.deleted then
			slot8 = nil

			if slot3 then
				slot8 = slot3[slot0._dices[slot7].diceMo.uid] and true or false
			end

			if slot0._selectDict[slot7] then
				slot0._dices[slot7]:setSelect(true)
			else
				slot0._dices[slot7]:setSelect(false, slot8)
			end
		end
	end

	slot0:updateUseCardStatu()
end

function slot0.updateUseCardStatu(slot0)
	gohelper.setActive(slot0._btnusecard, false)

	return

	if not DiceHeroFightModel.instance:getGameData().curSelectCardMo then
		gohelper.setActive(slot0._btnusecard, false)

		return
	end

	gohelper.setActive(slot0._btnusecard, true)
	ZProj.UGUIHelper.SetGrayscale(slot0._btnusecard.gameObject, not (slot1:canUse() and true or false))
end

function slot0._onClickReroll(slot0)
	if DiceHeroHelper.instance:isInFlow() then
		return
	end

	if DiceHeroFightModel.instance:getGameData().diceBox.resetTimes <= 0 then
		GameFacade.showToast(ToastEnum.DiceHeroDiceNoResetCount)

		return
	end

	slot2 = {}

	for slot6 in pairs(slot0._selectDict) do
		table.insert(slot2, DiceHeroFightModel.instance:getGameData().diceBox.dices[slot6].uid)
	end

	if not slot2[1] then
		GameFacade.showToast(ToastEnum.DiceHeroNoSelectDice)

		return
	end

	DiceHeroRpc.instance:sendDiceHeroResetDice(slot2, slot0._onReroll, slot0)
end

function slot0._onClickConfirm(slot0)
	if DiceHeroHelper.instance:isInFlow() then
		return
	end

	DiceHeroRpc.instance:sendDiceHeroConfirmDice(slot0._onConfirmEnd, slot0)
end

function slot0._onConfirmEnd(slot0, slot1, slot2, slot3)
	if slot2 ~= 0 then
		return
	end

	slot0:onSkillCardSelectChange()
end

function slot0._onClickEnd(slot0)
	if DiceHeroHelper.instance:isInFlow() then
		return
	end

	DiceHeroRpc.instance:sendDiceHeroEndRound()
	gohelper.setActive(slot0._goend, false)
end

function slot0._onClickSkip(slot0)
	MessageBoxController.instance:showMsgBox(MessageBoxIdDefine.DiceHeroSkipFight, MsgBoxEnum.BoxType.Yes_No, slot0._closeGameView, nil, , slot0)
end

function slot0._closeGameView(slot0)
	ViewMgr.instance:closeView(ViewName.DiceHeroGameView)
end

function slot0._onReroll(slot0, slot1, slot2, slot3)
	if slot2 ~= 0 then
		return
	end

	DiceHeroFightModel.instance:getGameData().diceBox:init(slot3.diceBox)
	DiceHeroFightModel.instance:getGameData():onStepEnd()
	slot0:updateRollNum()

	slot7 = 0.6

	UIBlockHelper.instance:startBlock("DiceHeroDiceBoxItem_reroll", slot7)

	for slot7 = 1, 12 do
		slot0._dices[slot7]:setSelect(false)

		if slot0._selectDict[slot7] then
			slot0._dices[slot7]:playRefresh(DiceHeroFightModel.instance:getGameData().diceBox.dices[slot7])
		end
	end

	slot0._selectDict = {}

	DiceHeroController.instance:dispatchEvent(DiceHeroEvent.RerollDice)
end

function slot0.onDestroy(slot0)
end

return slot0
