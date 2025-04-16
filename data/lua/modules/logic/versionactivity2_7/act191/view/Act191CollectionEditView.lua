module("modules.logic.versionactivity2_7.act191.view.Act191CollectionEditView", package.seeall)

slot0 = class("Act191CollectionEditView", BaseView)

function slot0.onInitView(slot0)
	slot0._goCollectionTip = gohelper.findChild(slot0.viewGO, "left_container/#go_CollectionTip")
	slot0._txtCollectionName = gohelper.findChildText(slot0.viewGO, "left_container/#go_CollectionTip/scroll_tips/viewport/content/Title/#txt_CollectionName")
	slot0._txtCollectionDec = gohelper.findChildText(slot0.viewGO, "left_container/#go_CollectionTip/scroll_tips/viewport/content/#txt_CollectionDec")
	slot0._goListEmpty = gohelper.findChild(slot0.viewGO, "right_container/CollectionList/#go_ListEmpty")
	slot0._btnEquip = gohelper.findChildButtonWithAudio(slot0.viewGO, "right_container/#btn_Equip")
	slot0._btnUnEquip = gohelper.findChildButtonWithAudio(slot0.viewGO, "right_container/#btn_UnEquip")
	slot0._gotopleft = gohelper.findChild(slot0.viewGO, "#go_topleft")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnEquip:AddClickListener(slot0._btnEquipOnClick, slot0)
	slot0._btnUnEquip:AddClickListener(slot0._btnUnEquipOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnEquip:RemoveClickListener()
	slot0._btnUnEquip:RemoveClickListener()
end

function slot0._btnEquipOnClick(slot0)
	slot0.equipping = true

	slot0.gameInfo:replaceItemInTeam(slot0._itemMo.uid, slot0.curSlotIndex)
end

function slot0._btnUnEquipOnClick(slot0)
	if Activity191Helper.getWithBuildBattleHeroInfo(slot0.teamInfo.battleHeroInfo, slot0.curSlotIndex).itemUid1 and slot2 ~= 0 then
		slot0.gameInfo:removeItemInTeam(slot2)
	end
end

function slot0._editableInitView(slot0)
	slot0.heroItemList = {}
	slot0.slotItemList = {}

	for slot4 = 1, 4 do
		slot0.heroItemList[slot4] = MonoHelper.addNoUpdateLuaComOnceToGo(gohelper.findChild(slot0.viewGO, string.format("left_container/%s/Hero", slot4)), Act191HeroGroupItem1)
		slot6 = slot0:getUserDataTb_()
		slot7 = gohelper.findChild(slot0.viewGO, string.format("left_container/%s/Collection", slot4))
		slot6.goEmpty = gohelper.findChild(slot7, "go_Empty")
		slot6.goCollection = gohelper.findChild(slot7, "go_Collection")
		slot6.imageRare = gohelper.findChildImage(slot7, "go_Collection/image_Rare")
		slot6.simageIcon = gohelper.findChildSingleImage(slot7, "go_Collection/simage_Icon")
		slot6.goSelect = gohelper.findChild(slot7, "go_Select")

		slot0:addClickCb(gohelper.findChildButtonWithAudio(slot7, "btn_Click"), slot0.onSlotClick, slot0, slot4)

		slot0.slotItemList[slot4] = slot6
	end

	slot0.itemUidDic = {}
end

function slot0.onOpen(slot0)
	slot0:addEventCb(Activity191Controller.instance, Activity191Event.UpdateTeamInfo, slot0.onUpdateTeam, slot0)
	slot0:addEventCb(Activity191Controller.instance, Activity191Event.OnClickCollectionGroupItem, slot0._onItemClick, slot0)

	slot0.gameInfo = Activity191Model.instance:getActInfo():getGameInfo()
	slot0.teamInfo = slot0.gameInfo:getTeamInfo()
	slot0.curSlotIndex = slot0.viewParam.index

	slot0:refreshUI()
end

function slot0.refreshUI(slot0)
	for slot4 = 1, 4 do
		slot0.heroItemList[slot4]:setData(Activity191Helper.matchKeyInArray(slot0.teamInfo.battleHeroInfo, slot4) and slot5.heroId or 0)

		slot0.itemUidDic[slot4] = slot5 and slot5.itemUid1 or 0
	end

	slot0:refreshSlotItem()

	slot1 = slot0.itemUidDic[slot0.curSlotIndex]

	Act191CollectionEditListModel.instance:initData(slot1)

	if slot1 == 0 then
		slot0:refreshBtnStatus()
		gohelper.setActive(slot0._goCollectionTip, false)
	end
end

function slot0.refreshSlotItem(slot0)
	for slot4 = 1, 4 do
		gohelper.setActive(slot0.slotItemList[slot4].goSelect, slot4 == slot0.curSlotIndex)

		if slot0.itemUidDic[slot4] ~= 0 then
			slot8 = Activity191Config.instance:getCollectionCo(slot0.gameInfo:getItemInfoInWarehouse(slot6).itemId)

			UISpriteSetMgr.instance:setAct174Sprite(slot5.imageRare, "act174_propitembg_" .. slot8.rare)
			slot5.simageIcon:LoadImage(ResUrl.getRougeSingleBgCollection(slot8.icon))

			if slot0.equipping and slot4 == slot0.curSlotIndex then
				AudioMgr.instance:trigger(AudioEnum2_7.Act191.play_ui_yuzhou_dqq_equip_creation)
				gohelper.setActive(slot5.goCollection, false)
				gohelper.setActive(slot5.goCollection, true)
			else
				gohelper.setActive(slot5.goCollection, true)
			end

			gohelper.setActive(slot5.goEmpty, false)
		else
			gohelper.setActive(slot5.goCollection, false)
			gohelper.setActive(slot5.goEmpty, true)
		end
	end
end

function slot0.onSlotClick(slot0, slot1)
	slot0.curSlotIndex = slot1

	for slot5 = 1, 4 do
		gohelper.setActive(slot0.slotItemList[slot5].goSelect, slot5 == slot1)
	end

	if slot0.itemUidDic[slot0.curSlotIndex] == 0 then
		slot0:refreshBtnStatus()
	else
		Act191CollectionEditListModel.instance:selectItem(slot2, true)
	end
end

function slot0._onItemClick(slot0, slot1)
	slot0._itemMo = slot1

	slot0:refreshItemTip()
	slot0:refreshBtnStatus()
	gohelper.setActive(slot0._goCollectionTip, true)
end

function slot0.refreshBtnStatus(slot0)
	if slot0._itemMo then
		if slot0._itemMo.uid == slot0.itemUidDic[slot0.curSlotIndex] then
			gohelper.setActive(slot0._btnEquip, false)
			gohelper.setActive(slot0._btnUnEquip, true)
		else
			gohelper.setActive(slot0._btnEquip, true)
			gohelper.setActive(slot0._btnUnEquip, false)
		end
	else
		gohelper.setActive(slot0._btnEquip, false)
		gohelper.setActive(slot0._btnUnEquip, slot1 ~= 0)
	end
end

function slot0.refreshItemTip(slot0)
	if slot0._itemMo then
		slot1 = Activity191Config.instance:getCollectionCo(slot0._itemMo.itemId)
		slot0._txtCollectionName.text = slot1.title
		slot0._txtCollectionDec.text = slot0.gameInfo:isItemEnhance(slot1.id) and slot1.replaceDesc or slot1.desc

		gohelper.setActive(slot0._goCollectionTip, true)
	else
		gohelper.setActive(slot0._goCollectionTip, false)
	end
end

function slot0.onUpdateTeam(slot0)
	slot0.teamInfo = slot0.gameInfo:getTeamInfo()

	if slot0.equipping then
		GameFacade.showToast(ToastEnum.Act191EquipTip)
	end

	slot0:refreshUI()
	slot0:selectEmptySlot()

	slot0.equipping = false
end

function slot0.selectEmptySlot(slot0)
	for slot4 = 1, 4 do
		if slot0.itemUidDic[slot4] == 0 then
			slot0:onSlotClick(slot4)

			break
		end
	end
end

return slot0
