module("modules.logic.versionactivity2_7.act191.view.item.Act191FetterIconItem", package.seeall)

slot0 = class("Act191FetterIconItem", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0.imageFetter = gohelper.findChildImage(slot1, "image_Fetter")
	slot0.btnClick = gohelper.findChildButtonWithAudio(slot1, "btn_Click")
end

function slot0.addEventListeners(slot0)
	slot0:addClickCb(slot0.btnClick, slot0.onClick, slot0)
end

function slot0.setData(slot0, slot1)
	slot0.relationCo = Activity191Config.instance:getRelationCo(slot1)

	Activity191Helper.setFetterIcon(slot0.imageFetter, slot0.relationCo.icon)
end

function slot0.onClick(slot0)
	if slot0.param then
		Act191StatController.instance:statButtonClick(slot0.param.fromView, string.format("Fetter_%s", slot0.relationCo.name))
	end

	Activity191Controller.instance:openFetterTipView({
		tag = slot0.relationCo.tag,
		isEnemy = slot0.isEnemy,
		isPreview = slot0.preview
	})
end

function slot0.setEnemyView(slot0)
	slot0.isEnemy = true
end

function slot0.setPreview(slot0)
	slot0.preview = true
end

function slot0.setExtraParam(slot0, slot1)
	slot0.param = slot1
end

return slot0
