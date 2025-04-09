module("modules.logic.fight.view.FightDouQuQuHuntingView", package.seeall)

slot0 = class("FightDouQuQuHuntingView", FightBaseView)

function slot0.onInitView(slot0)
	slot0.huntingText = gohelper.findChildText(slot0.viewGO, "root/#txt_num")
	slot0.addEffect = gohelper.findChild(slot0.viewGO, "root/#add")
end

function slot0.addEvents(slot0)
	slot0:com_registFightEvent(FightEvent.UpdateFightParam, slot0.onUpdateFightParam)
end

function slot0.onUpdateFightParam(slot0, slot1, slot2, slot3, slot4)
	if slot1 ~= FightParamData.ParamKey.ACT191_HUNTING then
		return
	end

	slot0:com_killTween(slot0.tweenId)
	slot0:com_playTween(FightTweenType.DOTweenFloat, slot2, slot3, 0.5, slot0.onFrame, nil, slot0)

	if slot4 > 0 then
		gohelper.setActive(slot0.addEffect, false)
		gohelper.setActive(slot0.addEffect, true)
		slot0:com_registSingleTimer(slot0.hideEffect, 1)
	end
end

function slot0.onFrame(slot0, slot1)
	slot0:refreshData(math.ceil(slot1))
end

function slot0.hideEffect(slot0)
	gohelper.setActive(slot0.addEffect, false)
end

function slot0.refreshData(slot0, slot1)
	slot0.huntingText.text = string.format("<%s>%s</color>/%s", slot1 < slot0.maxValue and "#D97373" or "#65B96F", slot1, slot0.maxValue)
end

function slot0.onOpen(slot0)
	slot0.maxValue = FightDataHelper.fieldMgr.customData[FightCustomData.CustomDataType.Act191].minNeedHuntValue

	slot0:refreshData(FightDataHelper.fieldMgr.param[FightParamData.ParamKey.ACT191_HUNTING])
end

return slot0
