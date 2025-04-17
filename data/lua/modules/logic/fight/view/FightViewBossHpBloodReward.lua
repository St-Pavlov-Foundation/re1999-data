module("modules.logic.fight.view.FightViewBossHpBloodReward", package.seeall)

slot0 = class("FightViewBossHpBloodReward", FightBaseView)

function slot0.onInitView(slot0)
	slot0.hpImg = gohelper.findChildImage(slot0.viewGO, "Root/bossHp/Alpha/bossHp/mask/container/imgHp")
	slot0.signRoot = gohelper.findChild(slot0.viewGO, "Root/bossHp/Alpha/bossHp/mask/container/imgHp/imgSignHpContainer")
	slot0.signItem = gohelper.findChild(slot0.viewGO, "Root/bossHp/Alpha/bossHp/mask/container/imgHp/imgSignHpContainer/imgSignHpItem")
	slot0.hpEffect = gohelper.findChild(slot0.viewGO, "Root/bossHp/Alpha/bossHp/#hpeffect")

	gohelper.setActive(slot0.hpEffect, false)
end

function slot0.addEvents(slot0)
	slot0:com_registFightEvent(FightEvent.UpdateFightParam, slot0.onUpdateFightParam)
	slot0:com_registFightEvent(FightEvent.PlayTimelineHit, slot0.onPlayTimelineHit)
	slot0:com_registFightEvent(FightEvent.AfterCorrectData, slot0.onAfterCorrectData)

	slot0.tweenComp = slot0:addComponent(FightTweenComponent)
end

function slot0.onConstructor(slot0, slot1)
	slot0.data = slot1
end

function slot0.onOpen(slot0)
	slot0.invokedEffect = {}
	slot0.bgWidth = recthelper.getWidth(slot0.signRoot.transform)
	slot0.halfWidth = slot0.bgWidth / 2
	slot0.itemDataList = GameUtil.splitString2(slot0.data.bloodReward, true)

	slot0:refreshItems()
	slot0:refreshHp()
end

function slot0.onAfterCorrectData(slot0)
	slot0:refreshItems()
	slot0.tweenComp:DOFillAmount(slot0.hpImg, (FightDataHelper.fieldMgr.param[FightParamData.ParamKey.ACT191_CUR_HP_RATE] or 0) / 1000, 0.2)
end

function slot0.onPlayTimelineHit(slot0, slot1, slot2)
	if slot2.side ~= FightEnum.EntitySide.EnemySide then
		return
	end

	gohelper.setActive(slot0.hpEffect, false)
	gohelper.setActive(slot0.hpEffect, true)
	slot0:com_registSingleTimer(slot0.hideEffect, 0.5)

	slot3 = 0

	for slot7, slot8 in ipairs(slot1.actEffect) do
		if not slot8:isDone() and not slot0.invokedEffect[slot8.clientId] and slot8.effectType == FightEnum.EffectType.FIGHTPARAMCHANGE then
			for slot13, slot14 in ipairs(GameUtil.splitString2(slot8.reserveStr, true)) do
				if slot14[1] == FightParamData.ParamKey.ACT191_CUR_HP_RATE then
					slot3 = slot3 + slot14[2]
					slot0.invokedEffect[slot8.clientId] = true
				end
			end
		end
	end

	if slot3 ~= 0 then
		slot0:refreshHp(slot0.hpImg.fillAmount + slot3 / 1000)
	end
end

function slot0.hideEffect(slot0)
	gohelper.setActive(slot0.hpEffect, false)
end

function slot0.refreshHp(slot0, slot1)
	slot0.tweenComp:DOFillAmount(slot0.hpImg, slot1 or (FightDataHelper.fieldMgr.param[FightParamData.ParamKey.ACT191_CUR_HP_RATE] or 0) / 1000, 0.2)
end

function slot0.onUpdateFightParam(slot0, slot1, slot2, slot3, slot4, slot5)
	if slot1 == FightParamData.ParamKey.ACT191_MIN_HP_RATE then
		slot0:refreshItems()
	elseif slot1 == FightParamData.ParamKey.ACT191_CUR_HP_RATE and not slot0.invokedEffect[slot5.clientId] then
		slot0:refreshHp()
	end
end

function slot0.refreshItems(slot0)
	gohelper.CreateObjList(slot0, slot0.onItemShow, slot0.itemDataList, slot0.signRoot, slot0.signItem)
end

function slot0.onItemShow(slot0, slot1, slot2, slot3)
	if FightDataHelper.fieldMgr.param[FightParamData.ParamKey.ACT191_MIN_HP_RATE] <= slot2[1] then
		gohelper.setActive(gohelper.findChild(slot1, "unfinish"), false)
		gohelper.setActive(gohelper.findChild(slot1, "finished"), true)
	else
		gohelper.setActive(slot4, true)
		gohelper.setActive(slot5, false)
	end

	recthelper.setAnchorX(slot1.transform, slot7 / 1000 * slot0.bgWidth - slot0.halfWidth)
end

return slot0
