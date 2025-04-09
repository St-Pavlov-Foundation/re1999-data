module("modules.logic.versionactivity2_5.challenge.view.dungeon.detail.Act183DungeonConditionComp", package.seeall)

slot0 = class("Act183DungeonConditionComp", Act183DungeonBaseComp)

function slot0.init(slot0, slot1)
	uv0.super.init(slot0, slot1)

	slot0._txtconditionitem = gohelper.findChildText(slot0.go, "#go_conditiondescs/#txt_conditionitem")
	slot0._imageconditionstar = gohelper.findChildImage(slot0.go, "top/title/#image_conditionstar")

	Act183Helper.setEpisodeConditionStar(slot0._imageconditionstar, true)

	slot0._conditionItemTab = slot0:getUserDataTb_()
end

function slot0.addEventListeners(slot0)
end

function slot0.removeEventListeners(slot0)
end

function slot0.updateInfo(slot0, slot1)
	uv0.super.updateInfo(slot0, slot1)

	slot0._conditionIds = slot0._episodeMo:getConditionIds()
	slot0._isAllConditionPass = slot0._episodeMo:isAllConditionPass()
end

function slot0.checkIsVisible(slot0)
	return slot0._conditionIds and #slot0._conditionIds > 0
end

function slot0.show(slot0)
	uv0.super.show(slot0)
	slot0:createObjList(slot0._conditionIds, slot0._conditionItemTab, slot0._txtconditionitem.gameObject, slot0._initConditionItemFunc, slot0._refreshConditionItemFunc, slot0._defaultItemFreeFunc)
	ZProj.UGUIHelper.SetGrayscale(slot0._imageconditionstar.gameObject, not slot0._isAllConditionPass)
end

function slot0._initConditionItemFunc(slot0, slot1)
	slot1.txtcondition = gohelper.onceAddComponent(slot1.go, gohelper.Type_TextMesh)

	SkillHelper.addHyperLinkClick(slot1.txtcondition)

	slot1.gostar = gohelper.findChild(slot1.go, "star")
end

function slot0._refreshConditionItemFunc(slot0, slot1, slot2, slot3)
	if not Act183Config.instance:getConditionCo(slot2) then
		return
	end

	slot1.txtcondition.text = SkillHelper.buildDesc(slot4.decs1)

	gohelper.setActive(slot1.gostar, slot0._episodeMo:isConditionPass(slot2))
end

function slot0.onDestroy(slot0)
	uv0.super.onDestroy(slot0)
end

return slot0
