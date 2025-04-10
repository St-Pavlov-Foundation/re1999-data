module("modules.logic.fight.view.stress.StressBehaviorBase", package.seeall)

slot0 = class("StressBehaviorBase", UserDataDispose)

function slot0.init(slot0, slot1, slot2)
	slot0:__onInit()

	slot0.instanceGo = slot1
	slot0.entity = slot2
	slot0.entityId = slot0.entity.id

	slot0:initUI()
	slot0:refreshUI()
	slot0:addCustomEvent()
end

function slot0.initUI(slot0)
end

function slot0.refreshUI(slot0)
end

function slot0.addCustomEvent(slot0)
	slot0:addEventCb(FightController.instance, FightEvent.PowerChange, slot0.onPowerChange, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.TriggerStressBehaviour, slot0.triggerStressBehaviour, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnStageChange, slot0.onStageChange, slot0)
end

function slot0.onStageChange(slot0)
	ViewMgr.instance:closeView(ViewName.StressTipView)
end

function slot0.onPowerChange(slot0, slot1, slot2, slot3, slot4)
end

function slot0.triggerStressBehaviour(slot0, slot1, slot2)
end

function slot0.getCurStress(slot0)
	return slot0.entity:getMO():getPowerInfo(FightEnum.PowerType.Stress) and slot2.num or 0
end

function FightNameUIStressMgr.log(slot0, slot1)
	logError(string.format("[%s] : %s", slot0.entity:getMO():getEntityName(), slot1))
end

function slot0.beforeDestroy(slot0)
	slot0:__onDispose()
end

return slot0
