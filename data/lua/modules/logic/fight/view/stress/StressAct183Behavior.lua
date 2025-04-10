module("modules.logic.fight.view.stress.StressAct183Behavior", package.seeall)

slot0 = class("StressAct183Behavior", StressBehaviorBase)
slot0.StressThreshold = 49

function slot0.initUI(slot0)
	slot0.stressText = gohelper.findChildText(slot0.instanceGo, "#txt_stress")
	slot0.goYellow = gohelper.findChild(slot0.instanceGo, "yellow")
	slot0.goBroken = gohelper.findChild(slot0.instanceGo, "broken")
	slot0.click = gohelper.findChildClickWithDefaultAudio(slot0.instanceGo, "#go_clickarea")

	slot0.click:AddClickListener(slot0.onClickStress, slot0)
end

function slot0.onClickStress(slot0)
	if FightModel.instance:getCurStage() ~= FightEnum.Stage.Card then
		return
	end

	if FightDataHelper.fieldMgr.customData[FightCustomData.CustomDataType.Act183] and slot2.stressIdentity[slot0.entityId] then
		StressTipController.instance:openAct183StressTip(slot3)

		return
	end

	slot5 = slot0.entity:getMO():getCO() and lua_monster_skill_template.configDict[slot4.skillTemplate]

	if not (slot5 and slot5.identity) then
		return
	end

	StressTipController.instance:openAct183StressTip({
		slot6
	})
end

function slot0.refreshUI(slot0)
	slot0.stressText.text = slot0:getCurStress()

	slot0:updateStatus()
end

function slot0.updateStatus(slot0)
	gohelper.setActive(slot0.goYellow, slot0:getCurStress() <= slot0.StressThreshold)
	gohelper.setActive(slot0.goBroken, slot0.StressThreshold < slot1)
end

function slot0.resetGo(slot0)
	gohelper.setActive(slot0.goYellow, false)
	gohelper.setActive(slot0.goBroken, false)
end

function slot0.onPowerChange(slot0, slot1, slot2, slot3, slot4)
	if slot0.entityId ~= slot1 then
		return
	end

	if FightEnum.PowerType.Stress ~= slot2 then
		return
	end

	if slot3 == slot4 then
		return
	end

	slot0:refreshUI()
end

function slot0.beforeDestroy(slot0)
	slot0.click:RemoveClickListener()

	slot0.click = nil

	slot0:__onDispose()
end

return slot0
