module("modules.logic.versionactivity2_6.xugouji.view.XugoujiGameView", package.seeall)

slot0 = class("XugoujiGameView", BaseView)
slot1 = VersionActivity2_6Enum.ActivityId.Xugouji

function slot0.onInitView(slot0)
	slot0._goCardItemRoot = gohelper.findChild(slot0.viewGO, "#go_cameraMain/Middle/Middle/#scroll_FileList/Viewport/#go_Content")
	slot0._cardGridlayout = slot0._goCardItemRoot:GetComponent(gohelper.Type_GridLayoutGroup)
	slot0._goCardItem = gohelper.findChild(slot0._goCardItemRoot, "#go_FlieItem")
	slot0._gotargetPanel = gohelper.findChild(slot0.viewGO, "#go_cameraMain/Left/Task/#go_TaskPanel")
	slot0._gotargetItemRoot = gohelper.findChild(slot0.viewGO, "#go_cameraMain/Left/Task/#go_TaskPanel/#image_TaskBG")
	slot0._gotargetItem = gohelper.findChild(slot0.viewGO, "#go_cameraMain/Left/Task/#go_TaskPanel/#image_TaskBG/#go_Item")
	slot0._btntarget = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_cameraMain/Left/Task/#btn_Task")
	slot0._btntargetHide = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_cameraMain/Left/Task/#btn_Task_cancel")
	slot0._goTipsRoot = gohelper.findChild(slot0.viewGO, "#go_cameraMain/Left/#go_TipsRoot")
	slot0._goMyTurnTips = gohelper.findChild(slot0.viewGO, "#go_cameraMain/Left/#go_Turn/txt_Turn")
	slot0._txtRound = gohelper.findChildText(slot0.viewGO, "#go_cameraMain/Middle/Title/#txt_Turns")
	slot0._btnCardBox = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_cameraMain/Right/#btn_WarehouseBtn")
	slot0._goWarehouseInfo = gohelper.findChild(slot0.viewGO, "#go_cameraMain/#go_warehouseInfo")
	slot0._btnCardBoxHide = gohelper.findChildButtonWithAudio(slot0._goWarehouseInfo, "#btnCardHouseHide")
	slot0._goCardBoxItemRoot = gohelper.findChild(slot0._goWarehouseInfo, "#scroll_Detail/Viewport/Content/#go_escaperulecontainer")
	slot0._goCardBoxItem = gohelper.findChild(slot0._goWarehouseInfo, "#scroll_Detail/Viewport/Content/#go_escaperulecontainer/#go_ItemList")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btntarget:AddClickListener(slot0._btntaskOnClick, slot0)
	slot0._btntargetHide:AddClickListener(slot0._btntaskHideOnClick, slot0)
	slot0._btnCardBox:AddClickListener(slot0._btnCardBoxOnClick, slot0)
	slot0._btnCardBoxHide:AddClickListener(slot0._btnCardBoxHideOnClick, slot0)
	slot0:addEventCb(XugoujiController.instance, XugoujiEvent.TurnChanged, slot0._onTurnChanged, slot0)
	slot0:addEventCb(XugoujiController.instance, XugoujiEvent.NewCards, slot0._createCardItems, slot0)
	slot0:addEventCb(XugoujiController.instance, XugoujiEvent.GameResult, slot0._onGameResultPush, slot0)
	slot0:addEventCb(XugoujiController.instance, XugoujiEvent.HpUpdated, slot0._onHpUpdated, slot0)
	slot0:addEventCb(XugoujiController.instance, XugoujiEvent.ExitGame, slot0._onGameResultExit, slot0)
	slot0:addEventCb(XugoujiController.instance, XugoujiEvent.GameRestart, slot0._onGameReStart, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btntarget:RemoveClickListener()
	slot0._btntargetHide:RemoveClickListener()
	slot0._btnCardBox:RemoveClickListener()
	slot0._btnCardBoxHide:RemoveClickListener()
	slot0:removeEventCb(XugoujiController.instance, XugoujiEvent.TurnChanged, slot0._onTurnChanged, slot0)
	slot0:removeEventCb(XugoujiController.instance, XugoujiEvent.NewCards, slot0._createCardItems, slot0)
	slot0:removeEventCb(XugoujiController.instance, XugoujiEvent.GameResult, slot0._onGameResultPush, slot0)
	slot0:removeEventCb(XugoujiController.instance, XugoujiEvent.HpUpdated, slot0._onHpUpdated, slot0)
	slot0:removeEventCb(XugoujiController.instance, XugoujiEvent.ExitGame, slot0._onGameResultExit, slot0)
	slot0:removeEventCb(XugoujiController.instance, XugoujiEvent.GameRestart, slot0._onGameReStart, slot0)
end

function slot0._btntaskOnClick(slot0)
	gohelper.setActive(slot0._gotargetPanel, true)
	gohelper.setActive(slot0._btntargetHide.gameObject, true)
end

function slot0._btntaskHideOnClick(slot0)
	gohelper.setActive(slot0._gotargetPanel, false)
	gohelper.setActive(slot0._btntargetHide.gameObject, false)
end

function slot0._btnCardBoxOnClick(slot0)
	gohelper.setActive(slot0._goWarehouseInfo, true)
	slot0:_createCardBoxItems()
end

function slot0._btnCardBoxHideOnClick(slot0)
	gohelper.setActive(slot0._goWarehouseInfo, false)
end

function slot0._btnSkillOnClick(slot0)
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._goTipsRoot, false)
end

function slot0.onOpen(slot0)
	slot0:_createCardItems()
	slot0:_createTargetList()
	slot0:_refreshRoundNum()
end

function slot0._createCardItems(slot0)
	slot0._cardGridlayout.constraintCount = Activity188Model.instance:getCardColNum()
	slot0._cardInfoList = Activity188Model.instance:getCardsInfoSortedList()

	gohelper.CreateObjList(slot0, slot0._createCardItem, slot0._cardInfoList, slot0._goCardItemRoot, slot0._goCardItem, XugoujiCardItem)
end

function slot0._createCardItem(slot0, slot1, slot2, slot3)
	slot1:onUpdateData(slot2)

	slot1._view = slot0
end

function slot0._createCardBoxItems(slot0)
	gohelper.setActive(slot0._goCardBoxAttackItemFlag, false)
	gohelper.setActive(slot0._goCardBoxFuncItemFlag, false)
	gohelper.setActive(slot0._goCardBoxImmediateItemFlag, false)

	for slot7, slot8 in ipairs(slot0._cardInfoList) do
		slot9 = slot8.id

		if slot8.status ~= XugoujiEnum.CardStatus.Disappear and slot8.status ~= XugoujiEnum.CardStatus.Front then
			if Activity188Config.instance:getCardCfg(uv0, slot9).type == XugoujiEnum.CardType.Attack then
				slot1 = nil or {}
				slot1[slot9] = slot1[slot9] or 0
				slot1[slot9] = slot1[slot9] + 1
			elseif slot10.type == XugoujiEnum.CardType.Func then
				slot2 = slot2 or {}
				slot2[slot9] = slot2[slot9] or 0
				slot2[slot9] = slot2[slot9] + 1
			elseif slot10.type == XugoujiEnum.CardType.Immediate then
				slot3 = slot3 or {}
				slot3[slot9] = slot3[slot9] or 0
				slot3[slot9] = slot3[slot9] + 1
			end
		end
	end

	if slot1 then
		slot8 = {
			cardFlag = slot9
		}
		slot9 = XugoujiEnum.CardType.Attack

		table.insert({}, slot8)

		for slot8, slot9 in pairs(slot1) do
			table.insert(slot4, {
				cardId = slot8,
				count = slot9
			})
		end
	end

	if slot2 then
		slot8 = {
			cardFlag = slot9
		}
		slot9 = XugoujiEnum.CardType.Func

		table.insert(slot4, slot8)

		for slot8, slot9 in pairs(slot2) do
			table.insert(slot4, {
				cardId = slot8,
				count = slot9
			})
		end
	end

	if slot3 then
		slot8 = {
			cardFlag = slot9
		}
		slot9 = XugoujiEnum.CardType.Immediate

		table.insert(slot4, slot8)

		for slot8, slot9 in pairs(slot3) do
			table.insert(slot4, {
				cardId = slot8,
				count = slot9
			})
		end
	end

	slot0.cardBoxItems = slot0:getUserDataTb_()

	gohelper.CreateObjList(slot0, slot0._createCardBoxItem, slot4, slot0._goCardBoxItemRoot, slot0._goCardBoxItem)
end

function slot0._createCardBoxItem(slot0, slot1, slot2, slot3)
	gohelper.setActive(gohelper.findChild(slot1, "Attack"), slot2.cardFlag and slot2.cardFlag == XugoujiEnum.CardType.Attack)
	gohelper.setActive(gohelper.findChild(slot1, "Function"), slot2.cardFlag and slot2.cardFlag == XugoujiEnum.CardType.Func)
	gohelper.setActive(gohelper.findChild(slot1, "Immediate"), slot2.cardFlag and slot2.cardFlag == XugoujiEnum.CardType.Immediate)
	gohelper.setActive(gohelper.findChild(slot1, "#go_item"), not slot2.cardFlag)

	if slot2.cardFlag then
		return
	end

	slot9 = gohelper.findChildText(slot7, "txt_desc")
	slot10 = gohelper.findChildText(slot7, "image_icon/image_Count/#txt_Count")

	if Activity188Config.instance:getCardCfg(uv0, slot2.cardId).resource and slot13 ~= "" then
		gohelper.findChildSingleImage(slot7, "image_icon"):LoadImage(slot13)
	end

	slot10.text = string.format("x%d", slot2.count)
	slot9.text = slot12.desc
	slot0.cardBoxItems[slot11] = slot7
end

function slot0._onTurnChanged(slot0)
	slot0:_refreshTurnTips(Activity188Model.instance:isMyTurn())
	slot0:_refreshRoundNum()
end

function slot0._refreshRoundNum(slot0)
	slot0._txtRound.text = string.format("%d/%d", Activity188Model.instance:getRound(), Activity188Config.instance:getGameCfg(uv0, Activity188Model.instance:getCurGameId()).round)
end

function slot0._refreshTurnTips(slot0, slot1)
	gohelper.setActive(slot0._goMyTurnTips, slot1)
end

function slot0._createTargetList(slot0)
	slot0._targetDataList = {}

	for slot7, slot8 in ipairs(string.split(Activity188Config.instance:getGameCfg(uv0, Activity188Model.instance:getCurGameId()).passRound, "#")) do
		table.insert(slot0._targetDataList, slot8)
	end

	gohelper.CreateObjList(slot0, slot0._createTargetItem, slot0._targetDataList, slot0._gotargetItemRoot, slot0._gotargetItem)
end

function slot0._createTargetItem(slot0, slot1, slot2, slot3)
	gohelper.setActive(slot1, true)

	gohelper.findChildText(slot1, "#txt_TaskTarget").text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("xugouji_round_target"), slot2)
end

function slot0._onGameResultPush(slot0, slot1)
	XugoujiController.instance:openGameResultView(slot1)
end

function slot0._onHpUpdated(slot0)
	slot1 = Activity188Model.instance:getCurHP()
	slot2 = Activity188Model.instance:getEnemyHP()
end

function slot0._onGameResultExit(slot0)
	slot0:closeThis()
end

function slot0._onGameReStart(slot0)
	slot0:_createCardItems()
	slot0:_createTargetList()
	slot0:_refreshRoundNum()
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	if slot0.cardBoxItems then
		for slot4, slot5 in pairs(slot0.cardBoxItems) do
			gohelper.findChildSingleImage(slot5, "image_icon"):UnLoadImage()
		end
	end
end

return slot0
