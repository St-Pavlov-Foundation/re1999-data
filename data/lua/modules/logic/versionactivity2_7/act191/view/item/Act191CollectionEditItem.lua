module("modules.logic.versionactivity2_7.act191.view.item.Act191CollectionEditItem", package.seeall)

slot0 = class("Act191CollectionEditItem", ListScrollCell)

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0.imageRare = gohelper.findChildImage(slot1, "image_Rare")
	slot0.simageIcon = gohelper.findChildSingleImage(slot1, "simage_Icon")
	slot0.simageHeroIcon = gohelper.findChildSingleImage(slot1, "simage_HeroIcon")
	slot0.goSelect = gohelper.findChild(slot1, "go_Select")
	slot0.goNew = gohelper.findChild(slot1, "go_New")
	slot0.btnClick = gohelper.findChildButtonWithAudio(slot1, "btn_Click")
	slot0._animator = slot0.go:GetComponent(typeof(UnityEngine.Animator))
	slot0.isSelect = false
end

function slot0.addEventListeners(slot0)
	slot0:addClickCb(slot0.btnClick, slot0._onItemClick, slot0)
end

function slot0.removeEventListeners(slot0)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1
	slot0.itemInfo = Activity191Model.instance:getActInfo():getGameInfo():getItemInfoInWarehouse(slot1.uid)
	slot3 = Activity191Config.instance:getCollectionCo(slot0.itemInfo.itemId)

	UISpriteSetMgr.instance:setAct174Sprite(slot0.imageRare, "act174_propitembg_" .. slot3.rare)
	slot0.simageIcon:LoadImage(ResUrl.getRougeSingleBgCollection(slot3.icon))

	if slot1.heroId then
		slot0.simageHeroIcon:LoadImage(Activity191Helper.getHeadIconSmall(Activity191Config.instance:getRoleCoByNativeId(slot1.heroId, 1)))
	end

	gohelper.setActive(slot0.simageHeroIcon, slot1.heroId)
end

function slot0.onSelect(slot0, slot1)
	slot0.isSelect = slot1

	gohelper.setActive(slot0.goSelect, slot1)

	if slot1 then
		Activity191Controller.instance:dispatchEvent(Activity191Event.OnClickCollectionGroupItem, slot0._mo)
	end
end

function slot0._onItemClick(slot0)
	if not slot0.isSelect then
		slot0._view:selectCell(slot0._index, true)
	end
end

function slot0.onDestroy(slot0)
end

function slot0.getAnimator(slot0)
	return slot0._animator
end

return slot0
