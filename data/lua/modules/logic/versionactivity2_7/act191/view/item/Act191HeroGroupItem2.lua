module("modules.logic.versionactivity2_7.act191.view.item.Act191HeroGroupItem2", package.seeall)

slot0 = class("Act191HeroGroupItem2", LuaCompBase)

function slot0.ctor(slot0, slot1)
	slot0.handleView = slot1
end

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0.goEmpty = gohelper.findChild(slot1, "go_Empty")
	slot0.goCollection = gohelper.findChild(slot1, "go_Collection")
	slot0.imageRare = gohelper.findChildImage(slot1, "go_Collection/image_Rare")
	slot0.simageIcon = gohelper.findChildSingleImage(slot1, "go_Collection/simage_Icon")
	slot0.btnClick = gohelper.findChildButtonWithAudio(slot1, "btn_Click")
end

function slot0.addEventListeners(slot0)
	if slot0.btnClick then
		slot0:addClickCb(slot0.btnClick, slot0.onClick, slot0)
	end
end

function slot0.setData(slot0, slot1)
	slot0.itemUid = slot1

	if slot1 and slot1 ~= 0 then
		slot3 = Activity191Model.instance:getActInfo():getGameInfo():getItemInfoInWarehouse(slot1)
		slot0.itemId = slot3.itemId
		slot4 = Activity191Config.instance:getCollectionCo(slot3.itemId)

		UISpriteSetMgr.instance:setAct174Sprite(slot0.imageRare, "act174_propitembg_" .. slot4.rare)
		slot0.simageIcon:LoadImage(ResUrl.getRougeSingleBgCollection(slot4.icon))
		gohelper.setActive(slot0.goCollection, true)
		gohelper.setActive(slot0.goEmpty, false)
	else
		slot0.itemId = 0

		gohelper.setActive(slot0.goCollection, false)
		gohelper.setActive(slot0.goEmpty, true)
	end
end

function slot0.setIndex(slot0, slot1)
	slot0._index = slot1
end

function slot0.onClick(slot0)
	if slot0.handleView and slot0.handleView._nowDragingIndex then
		return
	end

	if slot0.callback then
		slot0.callback(slot0.callbackObj, slot0.itemId)

		return
	end

	ViewMgr.instance:openView(ViewName.Act191CollectionEditView, {
		index = slot0._index
	})

	if slot0.param then
		Act191StatController.instance:statButtonClick(slot0.param.fromView, string.format("itemClick_%s_%s_%s", slot0.param.type, slot0._index, slot0.itemId))
	end
end

function slot0.setExtraParam(slot0, slot1)
	slot0.param = slot1
end

function slot0.setOverrideClick(slot0, slot1, slot2)
	slot0.callback = slot1
	slot0.callbackObj = slot2
end

return slot0
