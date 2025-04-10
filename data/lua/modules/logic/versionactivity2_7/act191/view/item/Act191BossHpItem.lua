module("modules.logic.versionactivity2_7.act191.view.item.Act191BossHpItem", package.seeall)

slot0 = class("Act191BossHpItem", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0.hpImg = gohelper.findChildImage(slot1, "Root/bossHp/Alpha/bossHp/mask/container/imgHp")
	slot0.signRoot = gohelper.findChild(slot1, "Root/bossHp/Alpha/bossHp/mask/container/imgHp/imgSignHpContainer")
	slot0.signItem = gohelper.findChild(slot1, "Root/bossHp/Alpha/bossHp/mask/container/imgHp/imgSignHpContainer/imgSignHpItem")
	slot0.hpEffect = gohelper.findChild(slot1, "Root/bossHp/Alpha/bossHp/#hpeffect")

	gohelper.setActive(slot0.hpEffect, false)
end

function slot0.addEventListeners(slot0)
end

function slot0.onStart(slot0)
	slot0.data = FightDataHelper.fieldMgr.customData[FightCustomData.CustomDataType.Act191]
	slot0.curRate = (FightDataHelper.fieldMgr.param[FightParamData.ParamKey.ACT191_CUR_HP_RATE] or 0) / 1000
	slot0.bgWidth = recthelper.getWidth(slot0.signRoot.transform)
	slot0.halfWidth = slot0.bgWidth / 2
	slot0.itemDataList = GameUtil.splitString2(slot0.data.bloodReward, true)

	slot0:refreshItems()
	TaskDispatcher.runDelay(slot0.openAnimFinish, slot0, 1)
end

function slot0.openAnimFinish(slot0)
	slot0.tweenId = ZProj.TweenHelper.DOTweenFloat(1, slot0.curRate, 0.3, slot0.frameCallback, slot0.tweenDone, slot0, nil, EaseType.Linear)
end

function slot0.frameCallback(slot0, slot1)
	slot0.hpImg.fillAmount = slot1
end

function slot0.tweenDone(slot0)
	slot0.tweenId = nil
end

function slot0.refreshItems(slot0)
	gohelper.CreateObjList(slot0, slot0.onItemShow, slot0.itemDataList, slot0.signRoot, slot0.signItem)
	gohelper.setActive(slot0.signItem, false)
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

function slot0.onDestroy(slot0)
	TaskDispatcher.cancelTask(slot0.openAnimFinish, slot0)

	if slot0.tweenId then
		ZProj.TweenHelper.KillById(slot0.tweenId)

		slot0.tweenId = nil
	end
end

return slot0
