module("modules.logic.tips.view.stress.FightFocusAct183StressComp", package.seeall)

slot0 = class("FightFocusAct183StressComp", FightFocusStressCompBase)
slot0.PrefabPath = FightNameUIStressMgr.PrefabPath

function slot0.getUiType(slot0)
	return FightNameUIStressMgr.UiType.Act183
end

function slot0.initUI(slot0)
	slot0.stressText = gohelper.findChildText(slot0.instanceGo, "#txt_stress")
	slot0.goYellow = gohelper.findChild(slot0.instanceGo, "yellow")
	slot0.goBroken = gohelper.findChild(slot0.instanceGo, "broken")
	slot0.click = gohelper.findChildClickWithDefaultAudio(slot0.instanceGo, "#go_clickarea")

	slot0.click:AddClickListener(slot0.onClickStress, slot0)
end

function slot0.onClickStress(slot0)
	if not slot0.entityMo then
		return
	end

	if FightDataHelper.fieldMgr.customData[FightCustomData.CustomDataType.Act183] and slot1.stressIdentity[slot0.entityMo.id] then
		StressTipController.instance:openAct183StressTip(slot2)

		return
	end

	slot3 = slot0.entityMo:getCO() and lua_monster_skill_template.configDict[slot2.skillTemplate]

	if not (slot3 and slot3.identity) then
		return
	end

	StressTipController.instance:openAct183StressTip({
		slot4
	})
end

function slot0.refreshStress(slot0, slot1)
	if not slot0.loaded then
		slot0.cacheEntityMo = slot1

		return
	end

	if not slot1 then
		slot0:hide()

		return
	end

	if not slot1:hasStress() then
		slot0:hide()

		return
	end

	slot0:show()

	slot0.entityMo = slot1
	slot3 = slot1:getPowerInfo(FightEnum.PowerType.Stress) and slot2.num or 0
	slot0.stressText.text = slot3

	gohelper.setActive(slot0.goYellow, slot3 <= StressAct183Behavior.StressThreshold)
	gohelper.setActive(slot0.goBroken, StressAct183Behavior.StressThreshold < slot3)
end

function slot0.destroy(slot0)
	slot0.click:RemoveClickListener()

	slot0.click = nil

	uv0.super.destroy(slot0)
end

return slot0
