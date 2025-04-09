module("modules.logic.versionactivity2_7.act191.view.Act191CollectionEditView", package.seeall)

slot0 = class("Act191CollectionEditView", BaseView)

function slot0.onInitView(slot0)
	slot0._imageTeamNum = gohelper.findChildImage(slot0.viewGO, "left_container/title/#image_TeamNum")
	slot0._goHero = gohelper.findChild(slot0.viewGO, "left_container/#go_Hero")
	slot0._goCollection1 = gohelper.findChild(slot0.viewGO, "left_container/#go_Collection1")
	slot0._goCollection2 = gohelper.findChild(slot0.viewGO, "left_container/#go_Collection2")
	slot0._goCollectionTip = gohelper.findChild(slot0.viewGO, "left_container/#go_CollectionTip")
	slot0._txtCollectionName = gohelper.findChildText(slot0.viewGO, "left_container/#go_CollectionTip/scroll_tips/viewport/content/Title/#txt_CollectionName")
	slot0._txtCollectionDec = gohelper.findChildText(slot0.viewGO, "left_container/#go_CollectionTip/scroll_tips/viewport/content/#txt_CollectionDec")
	slot0._btnLast = gohelper.findChildButtonWithAudio(slot0.viewGO, "left_container/#btn_Last")
	slot0._btnNext = gohelper.findChildButtonWithAudio(slot0.viewGO, "left_container/#btn_Next")
	slot0._goSort = gohelper.findChild(slot0.viewGO, "right_container/#go_Sort")
	slot0._goArrow = gohelper.findChild(slot0.viewGO, "right_container/#go_Sort/#drop_Mature/#go_Arrow")
	slot0._txtLabel = gohelper.findChildText(slot0.viewGO, "right_container/#go_Sort/#drop_Mature/#txt_Label")
	slot0._goListEmpty = gohelper.findChild(slot0.viewGO, "right_container/CollectionList/#go_ListEmpty")
	slot0._btnEquip = gohelper.findChildButtonWithAudio(slot0.viewGO, "right_container/#btn_Equip")
	slot0._btnUnEquip = gohelper.findChildButtonWithAudio(slot0.viewGO, "right_container/#btn_UnEquip")
	slot0._gotopleft = gohelper.findChild(slot0.viewGO, "#go_topleft")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnLast:AddClickListener(slot0._btnLastOnClick, slot0)
	slot0._btnNext:AddClickListener(slot0._btnNextOnClick, slot0)
	slot0._btnEquip:AddClickListener(slot0._btnEquipOnClick, slot0)
	slot0._btnUnEquip:AddClickListener(slot0._btnUnEquipOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnLast:RemoveClickListener()
	slot0._btnNext:RemoveClickListener()
	slot0._btnEquip:RemoveClickListener()
	slot0._btnUnEquip:RemoveClickListener()
end

function slot0._btnLastOnClick(slot0)
	if slot0.curTeamIndex <= 1 then
		return
	end

	slot0.curTeamIndex = slot0.curTeamIndex - 1

	slot0.animSwitch:Play("switch", 0, 0)
	TaskDispatcher.runDelay(slot0._delaySwitch, slot0, 0.16)
end

function slot0._btnNextOnClick(slot0)
	if slot0.curTeamIndex >= 4 then
		return
	end

	slot0.curTeamIndex = slot0.curTeamIndex + 1

	slot0.animSwitch:Play("switch", 0, 0)
	TaskDispatcher.runDelay(slot0._delaySwitch, slot0, 0.16)
end

function slot0._delaySwitch(slot0)
	slot0:refreshUI()
end

function slot0._btnEquipOnClick(slot0)
	if not slot0._itemMo then
		return
	end

	slot0.equiping = true

	slot0.gameInfo:repleaceItemInTeam(slot0._itemMo.uid, slot0.curTeamIndex, slot0.curSlotIndex)
end

function slot0._btnUnEquipOnClick(slot0)
	if slot0.battleHeroInfo["itemUid" .. slot0.curSlotIndex] and slot1 ~= 0 then
		slot0.gameInfo:removeItemInTeam(slot1)
	end
end

function slot0._editableInitView(slot0)
	slot0.heroHeadItem = MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(Activity191Enum.PrefabPath.HeroHeadItem, slot0._goHero), Act191HeroHeadItem)
	slot0.slotItemList = {}

	for slot5 = 1, 2 do
		slot6 = slot0:getUserDataTb_()
		slot7 = slot0["_goCollection" .. slot5]
		slot6.goEmpty = gohelper.findChild(slot7, "go_Empty")
		slot6.goCollection = gohelper.findChild(slot7, "go_Collection")
		slot6.imageRare = gohelper.findChildImage(slot7, "go_Collection/image_Rare")
		slot6.simageIcon = gohelper.findChildSingleImage(slot7, "go_Collection/simage_Icon")
		slot6.goSelect = gohelper.findChild(slot7, "go_Select")

		slot0:addClickCb(gohelper.findChildButtonWithAudio(slot7, "btn_Click"), slot0.onSlotClick, slot0, slot5)

		slot0.slotItemList[slot5] = slot6
	end

	slot0.animSwitch = gohelper.findChild(slot0.viewGO, "left_container"):GetComponent(gohelper.Type_Animator)
end

function slot0.onOpen(slot0)
	slot0:addEventCb(Activity191Controller.instance, Activity191Event.UpdateTeamInfo, slot0.onUpdateTeam, slot0)
	slot0:addEventCb(Activity191Controller.instance, Activity191Event.OnClickCollectionGroupItem, slot0._onItemClick, slot0)

	slot0.gameInfo = Activity191Model.instance:getActInfo():getGameInfo()
	slot0.curTeamIndex = math.ceil(slot0.viewParam.index / 2)
	slot0.curSlotIndex = slot0.viewParam.index % 2 == 0 and 2 or 1

	slot0:refreshUI()
end

function slot0.refreshUI(slot0)
	slot0.teamInfo = slot0.gameInfo:getTeamInfo()
	slot0.battleHeroInfo = Activity191Helper.getWithBuildBattleHeroInfo(slot0.teamInfo.battleHeroInfo, slot0.curTeamIndex)

	UISpriteSetMgr.instance:setAct174Sprite(slot0._imageTeamNum, "act174_ready_num_0" .. slot0.curTeamIndex)

	if slot0.battleHeroInfo["itemUid" .. slot0.curSlotIndex] and slot1 ~= 0 then
		slot0._itemMo = slot0.gameInfo:getItemInfoInWarehouse(slot1)
	end

	Act191CollectionEditListModel.instance:initData(slot1)

	if slot0.battleHeroInfo.heroId ~= 0 then
		slot0.heroHeadItem:setData(slot0.battleHeroInfo.heroId)
	end

	gohelper.setActive(slot0._goHero, slot0.battleHeroInfo.heroId ~= 0)

	for slot5 = 1, 2 do
		slot0:refreshSlotItem(slot5)
	end

	slot0:refreshBtnStatus()
	slot0:refreshItemTip()
end

function slot0.refreshSlotItem(slot0, slot1, slot2)
	slot4 = slot0.slotItemList[slot1]

	if (slot2 or slot0.battleHeroInfo["itemUid" .. slot1]) ~= 0 then
		slot6 = Activity191Config.instance:getCollectionCo(slot0.gameInfo:getItemInfoInWarehouse(slot3).itemId)

		UISpriteSetMgr.instance:setAct174Sprite(slot4.imageRare, "act174_propitembg_" .. slot6.rare)
		slot4.simageIcon:LoadImage(ResUrl.getRougeSingleBgCollection(slot6.icon))

		if slot1 == slot0.curSlotIndex then
			gohelper.setActive(slot4.goCollection, false)
			gohelper.setActive(slot4.goCollection, true)
		else
			gohelper.setActive(slot4.goCollection, true)
		end

		gohelper.setActive(slot4.goEmpty, false)
	else
		gohelper.setActive(slot4.goCollection, false)
		gohelper.setActive(slot4.goEmpty, true)
	end

	gohelper.setActive(slot4.goSelect, slot1 == slot0.curSlotIndex)
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0._delaySwitch, slot0)
end

function slot0.onSlotClick(slot0, slot1)
	slot0.curSlotIndex = slot1

	for slot5, slot6 in ipairs(slot0.slotItemList) do
		gohelper.setActive(slot6.goSelect, slot5 == slot0.curSlotIndex)
	end

	slot0:refreshBtnStatus()
end

function slot0._onItemClick(slot0, slot1)
	slot0._itemMo = slot1

	slot0:refreshSlotItem(slot0.curSlotIndex, slot1 and slot1.uid or 0)
	slot0:refreshBtnStatus()
	slot0:refreshItemTip()
end

function slot0.refreshItemTip(slot0)
	if slot0._itemMo then
		slot1 = Activity191Config.instance:getCollectionCo(slot0._itemMo.itemId)
		slot0._txtCollectionName.text = slot1.title
		slot0._txtCollectionDec.text = slot1.desc

		gohelper.setActive(slot0._goCollectionTip, true)
	else
		gohelper.setActive(slot0._goCollectionTip, false)
	end
end

function slot0.refreshBtnStatus(slot0)
	if slot0._itemMo then
		if slot0._itemMo.uid == slot0.battleHeroInfo["itemUid" .. slot0.curSlotIndex] then
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

function slot0.onUpdateTeam(slot0)
	if slot0.equiping then
		slot0:selectEmptySlot()
		GameFacade.showToast(ToastEnum.Act191EquipTip)

		slot0.equiping = false
	end

	slot0:refreshUI()
end

function slot0.selectEmptySlot(slot0)
	for slot4 = 1, 2 do
		if slot0.battleHeroInfo["itemUid" .. slot4] and slot5 ~= 0 then
			slot0:onSlotClick(slot4)

			break
		end
	end
end

return slot0
