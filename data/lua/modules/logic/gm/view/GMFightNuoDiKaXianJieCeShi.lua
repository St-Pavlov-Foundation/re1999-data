module("modules.logic.gm.view.GMFightNuoDiKaXianJieCeShi", package.seeall)

slot0 = class("GMFightNuoDiKaXianJieCeShi", FightBaseView)

function slot0.onInitView(slot0)
	slot0.btnClose = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/btnClose")
	slot0.btnStart = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/btnStart")
	slot0.intputTimeline = gohelper.findChildTextMeshInputField(slot0.viewGO, "root/inputTimeline")
	slot0.inputCount = gohelper.findChildTextMeshInputField(slot0.viewGO, "root/inputCount")
end

function slot0.addEvents(slot0)
	slot0:com_registFightEvent(FightEvent.OnSkillPlayFinish, slot0.onSkillPlayFinish)
	slot0:com_registClick(slot0.btnClose, slot0.closeThis)
	slot0:com_registClick(slot0.btnStart, slot0.onClickStart)
	slot0.intputTimeline:AddOnValueChanged(slot0.onIntputTimelineChange, slot0)
	slot0.inputCount:AddOnValueChanged(slot0.onInputCountChange, slot0)
end

function slot0.onIntputTimelineChange(slot0, slot1)
	PlayerPrefsHelper.setString(PlayerPrefsKey.GMNuoDiKaCeShiTimeline, slot1)
end

function slot0.onInputCountChange(slot0, slot1)
	PlayerPrefsHelper.setString(PlayerPrefsKey.GMNuoDiKaCeShiTimelineEffectCount, slot1)
end

function slot0.onClickStart(slot0)
	if not FightHelper.getEntity(SkillEditorMgr.instance.cur_select_entity_id) then
		return
	end

	slot2 = FightStepData.New(FightDef_pb.FightStep())
	slot2.fromId = slot1.id
	slot2.toId = "0"
	slot2.actType = FightEnum.ActType.SKILL
	slot2.actId = 0

	if #FightDataHelper.entityMgr:getNormalList(slot1:getSide() == FightEnum.EntitySide.MySide and FightEnum.EntitySide.EnemySide or FightEnum.EntitySide.MySide) > 0 then
		slot2.toId = slot4[1].id
		slot7 = slot0.inputCount
		slot8 = slot7

		for slot8 = 1, tonumber(slot7.GetText(slot8)) do
			slot9 = FightActEffectData.New(FightDef_pb.ActEffect())
			slot9.targetId = slot4[math.random(1, #slot4)].id
			slot9.effectType = -666
			slot9.effectNum = 100

			table.insert(slot2.actEffect, slot9)
		end

		for slot8, slot9 in ipairs(slot4) do
			slot10 = FightActEffectData.New(FightDef_pb.ActEffect())
			slot10.targetId = slot9.id
			slot10.effectType = 2
			slot10.effectNum = 200

			table.insert(slot2.actEffect, slot10)
		end
	end

	slot0:com_sendFightEvent(FightEvent.SetGMViewVisible, false)

	slot0.fightStepData = slot2

	slot1.skill:playTimeline(slot0.intputTimeline:GetText(), slot2)
	gohelper.setActive(slot0.viewGO, false)
end

function slot0.onSkillPlayFinish(slot0, slot1, slot2, slot3)
	if slot3 == slot0.fightStepData then
		slot0:com_sendFightEvent(FightEvent.SetGMViewVisible, true)
		gohelper.setActive(slot0.viewGO, true)
	end
end

function slot0.onOpen(slot0)
	PlayerPrefsKey.GMNuoDiKaCeShiTimeline = "GMNuoDiKaCeShiTimeline"
	PlayerPrefsKey.GMNuoDiKaCeShiTimelineEffectCount = "GMNuoDiKaCeShiTimelineEffectCount"

	slot0.intputTimeline:SetText(PlayerPrefsHelper.getString(PlayerPrefsKey.GMNuoDiKaCeShiTimeline))
	slot0.inputCount:SetText(PlayerPrefsHelper.getString(PlayerPrefsKey.GMNuoDiKaCeShiTimelineEffectCount))
end

function slot0.onDestructor(slot0)
	slot0.intputTimeline:RemoveOnValueChanged()
	slot0.inputCount:RemoveOnValueChanged()
end

return slot0
