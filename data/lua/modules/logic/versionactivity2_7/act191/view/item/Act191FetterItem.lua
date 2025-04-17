module("modules.logic.versionactivity2_7.act191.view.item.Act191FetterItem", package.seeall)

slot0 = class("Act191FetterItem", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0.imageRare = gohelper.findChildImage(slot1, "bg")
	slot0.goEffect2 = gohelper.findChild(slot1, "effect2")
	slot0.goEffect3 = gohelper.findChild(slot1, "effect3")
	slot0.goEffect4 = gohelper.findChild(slot1, "effect4")
	slot0.goEffect5 = gohelper.findChild(slot1, "effect5")
	slot0.imageIcon = gohelper.findChildImage(slot1, "icon")
	slot0.txtCnt = gohelper.findChildText(slot1, "count")
	slot0.btnClick = gohelper.findChildButtonWithAudio(slot1, "clickArea")
end

function slot0.addEventListeners(slot0)
	slot0:addClickCb(slot0.btnClick, slot0.onClick, slot0)
end

function slot0.setData(slot0, slot1, slot2)
	slot0.config = slot1

	if slot1.level ~= 0 then
		slot0.txtCnt.text = string.format("%d/%d", slot2, Activity191Config.instance:getRelationMaxCo(slot0.config.tag).activeNum)
	else
		slot0.txtCnt.text = string.format("<color=#ed7f7f>%d</color><color=#838383>/%d</color>", slot2, slot3.activeNum)
	end

	slot7 = "act174_shop_tag_" .. slot0.config.tagBg

	UISpriteSetMgr.instance:setAct174Sprite(slot0.imageRare, slot7)

	for slot7 = 2, 5 do
		gohelper.setActive(slot0["goEffect" .. slot7], slot7 == slot0.config.tagBg)
	end

	ZProj.UGUIHelper.SetGrayscale(slot0.imageIcon.gameObject, slot1.level == 0)

	slot5 = slot0.imageIcon.color
	slot5.a = slot1.level == 0 and 0.5 or 1
	slot0.imageIcon.color = slot5

	Activity191Helper.setFetterIcon(slot0.imageIcon, slot0.config.icon)
end

function slot0.onClick(slot0)
	if slot0.param then
		Act191StatController.instance:statButtonClick(slot0.param.fromView, string.format("clickArea_%s_%s", slot0.param.index, slot0.config.name))
	end

	Activity191Controller.instance:openFetterTipView({
		tag = slot0.config.tag,
		isEnemy = slot0.isEnemy
	})
end

function slot0.setEnemyView(slot0)
	slot0.isEnemy = true
end

function slot0.setClickEnable(slot0, slot1)
	gohelper.setActive(slot0.btnClick, slot1)
end

function slot0.setExtraParam(slot0, slot1)
	slot0.param = slot1
end

return slot0
