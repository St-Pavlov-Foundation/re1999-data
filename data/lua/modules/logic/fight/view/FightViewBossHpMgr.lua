module("modules.logic.fight.view.FightViewBossHpMgr", package.seeall)

slot0 = class("FightViewBossHpMgr", FightBaseView)

function slot0.onInitView(slot0)
	slot0._bossHpRoot = gohelper.findChild(slot0.viewGO, "root/bossHpRoot").transform

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:com_registFightEvent(FightEvent.BeforeEnterStepBehaviour, slot0._onBeforeEnterStepBehaviour)
	slot0:com_registFightEvent(FightEvent.OnRestartStageBefore, slot0._onRestartStage)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._hpItem = gohelper.findChild(slot0.viewGO, "root/bossHpRoot/bossHp")

	SLFramework.AnimatorPlayer.Get(slot0._hpItem):Play("idle", nil, )
	gohelper.setActive(gohelper.findChild(slot0.viewGO, "root/bossHpRoot/bossHp/Alpha/bossHp"), false)
end

function slot0._onRestartStage(slot0)
	slot0:killAllChildView()
end

function slot0._onBeforeEnterStepBehaviour(slot0)
	if not GMFightShowState.bossHp then
		return
	end

	if BossRushController.instance:isInBossRushInfiniteFight(true) then
		slot0:com_openSubView(BossRushFightViewBossHp, slot0._hpItem)

		return
	end

	if FightDataHelper.fieldMgr.customData[FightCustomData.CustomDataType.Act191] and slot1.bloodReward then
		gohelper.setActive(slot0._hpItem, false)
		slot0:com_openSubView(FightViewBossHpBloodReward, "ui/viewres/fight/fight_act191bosshpview.prefab", slot0._bossHpRoot.gameObject, slot1)

		return
	end

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.CardDeck) then
		slot2 = 3 + 1
	end

	if FightView.canShowSpecialBtn() then
		slot2 = slot2 + 1
	end

	if DungeonConfig.instance:getEpisodeCO(DungeonModel.instance.curSendEpisodeId) and slot3.type == DungeonEnum.EpisodeType.Rouge then
		slot2 = slot2 + 1
	end

	if slot2 >= 6 then
		recthelper.setAnchorX(slot0._bossHpRoot, -90)
	end

	for slot12, slot13 in ipairs(FightHelper.getSideEntitys(FightEnum.EntitySide.EnemySide)) do
		if slot13:getMO() and FightHelper.isBossId(FightHelper.getCurBossId(), slot14.modelId) then
			slot6 = 0 + 1

			table.insert({}, slot13.id)
		end
	end

	if slot6 == 2 then
		for slot12, slot13 in ipairs(slot8) do
			gohelper.setActive(gohelper.cloneInPlace(slot0._hpItem, "bossHp" .. slot12), true)
			recthelper.setWidth(slot14.transform, slot2 >= 5 and 400 or 450)

			slot16 = slot2 >= 5 and 240 or 295

			recthelper.setAnchorX(slot14.transform, slot12 == 1 and -slot16 or slot16)
			slot0:com_openSubView(FightViewMultiBossHp, slot14, nil, slot13)
		end

		gohelper.setActive(slot0._hpItem, false)
	else
		slot0:com_openSubView(FightViewBossHp, slot0._hpItem)
	end
end

function slot0.onOpen(slot0)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
