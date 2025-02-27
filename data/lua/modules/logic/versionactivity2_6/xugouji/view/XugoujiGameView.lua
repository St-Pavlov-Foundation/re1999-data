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
	slot0._goMyTurnTips = gohelper.findChild(slot0.viewGO, "#go_cameraMain/Bottom/#go_SelfTurn")
	slot0._goEnemyTurnTips = gohelper.findChild(slot0.viewGO, "#go_cameraMain/Bottom/#go_EnemyTurn")
	slot0._goTurnEffect = gohelper.findChild(slot0.viewGO, "#go_cameraMain/Left/#go_Turn/vx_fresh")
	slot0._txtRound = gohelper.findChildText(slot0.viewGO, "#go_cameraMain/Middle/Title/#txt_Turns")
	slot0._goRoundEffect = gohelper.findChild(slot0.viewGO, "#go_cameraMain/Middle/Title/vx_fresh")
	slot0._btnCardBox = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_cameraMain/Right/#btn_WarehouseBtn")
	slot0._goWarehouseInfo = gohelper.findChild(slot0.viewGO, "#go_warehouseInfo")
	slot0._btnCardBoxHide = gohelper.findChildButtonWithAudio(slot0._goWarehouseInfo, "#btnCardHouseHide")
	slot0._goCardBoxItemRoot = gohelper.findChild(slot0._goWarehouseInfo, "#scroll_Detail/Viewport/Content/#go_escaperulecontainer")
	slot0._goCardBoxItem = gohelper.findChild(slot0._goWarehouseInfo, "#scroll_Detail/Viewport/Content/#go_escaperulecontainer/#go_ItemList")
	slot0._goTaskPanel = gohelper.findChild(slot0.viewGO, "#go_cameraMain/Left/Task/#go_TaskPanel")
	slot0._warehouseAnimator = ZProj.ProjAnimatorPlayer.Get(slot0._goWarehouseInfo)
	slot0._taskTipsAnimator = ZProj.ProjAnimatorPlayer.Get(slot0._goTaskPanel)

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
	slot0:addEventCb(XugoujiController.instance, XugoujiEvent.ExitGame, slot0._onGameResultExit, slot0)
	slot0:addEventCb(XugoujiController.instance, XugoujiEvent.GameRestart, slot0._onGameReStart, slot0)
	slot0:addEventCb(XugoujiController.instance, XugoujiEvent.AutoShowTargetTips, slot0._onShowTargetTips, slot0)
	slot0:addEventCb(XugoujiController.instance, XugoujiEvent.AutoHideTargetTips, slot0._autoHideTargetTips, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btntarget:RemoveClickListener()
	slot0._btntargetHide:RemoveClickListener()
	slot0._btnCardBox:RemoveClickListener()
	slot0._btnCardBoxHide:RemoveClickListener()
	slot0:removeEventCb(XugoujiController.instance, XugoujiEvent.TurnChanged, slot0._onTurnChanged, slot0)
	slot0:removeEventCb(XugoujiController.instance, XugoujiEvent.NewCards, slot0._createCardItems, slot0)
	slot0:removeEventCb(XugoujiController.instance, XugoujiEvent.GameResult, slot0._onGameResultPush, slot0)
	slot0:removeEventCb(XugoujiController.instance, XugoujiEvent.ExitGame, slot0._onGameResultExit, slot0)
	slot0:removeEventCb(XugoujiController.instance, XugoujiEvent.GameRestart, slot0._onGameReStart, slot0)
	slot0:removeEventCb(XugoujiController.instance, XugoujiEvent.AutoShowTargetTips, slot0._onShowTargetTips, slot0)
	slot0:removeEventCb(XugoujiController.instance, XugoujiEvent.AutoHideTargetTips, slot0._autoHideTargetTips, slot0)
end

function slot0._btntaskOnClick(slot0)
	gohelper.setActive(slot0._gotargetPanel, true)
	gohelper.setActive(slot0._btntargetHide.gameObject, true)
	AudioMgr.instance:trigger(AudioEnum2_6.Xugouji.showGameTarget)
	slot0._taskTipsAnimator:Play(UIAnimationName.Open, nil, )
end

function slot0._btntaskHideOnClick(slot0)
	XugoujiController.instance:dispatchEvent(XugoujiEvent.HideTargetTips)
	gohelper.setActive(slot0._btntargetHide.gameObject, false)
	slot0._taskTipsAnimator:Play(UIAnimationName.Close, slot0.onTaskPanelCloseAniFinish, slot0)
end

function slot0.onTaskPanelCloseAniFinish(slot0)
	gohelper.setActive(slot0._gotargetPanel, false)
end

function slot0._btnCardBoxOnClick(slot0)
	gohelper.setActive(slot0._goWarehouseInfo, true)
	gohelper.setActive(slot0._btnCardBoxHide.gameObject, true)
	AudioMgr.instance:trigger(AudioEnum2_6.Xugouji.cardBoxOpen)
	slot0._warehouseAnimator:Play(UIAnimationName.Open, nil, )
	slot0:_createCardBoxItems()
end

function slot0._btnCardBoxHideOnClick(slot0)
	AudioMgr.instance:trigger(AudioEnum2_6.Xugouji.cardBoxClose)
	gohelper.setActive(slot0._btnCardBoxHide.gameObject, false)
	slot0._warehouseAnimator:Play(UIAnimationName.Close, slot0.onCardBoxCloseAniFinish, slot0)
end

function slot0.onCardBoxCloseAniFinish(slot0)
	gohelper.setActive(slot0._goWarehouseInfo, false)
end

function slot0._onShowTargetTips(slot0)
	slot0:_btntaskOnClick()
end

function slot0._autoHideTargetTips(slot0)
	slot0:_btntaskHideOnClick()
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._goTipsRoot, false)
end

function slot0.onOpen(slot0)
	slot0:_createCardItems()
	slot0:_createTargetList()
	slot0:_refreshRoundNum()
	slot0:_refreshTurnTips(true)
end

function slot0.onOpenFinish(slot0)
	XugoujiController.instance:dispatchEvent(XugoujiEvent.OpenGameViewFinish)
end

function slot0._createCardItems(slot0)
	slot0._cardGridlayout.constraintCount = Activity188Model.instance:getCardColNum()
	slot0._cardInfoList = Activity188Model.instance:getCardsInfoSortedList()
	slot0._cardIdNumDict = {}

	gohelper.CreateObjList(slot0, slot0._createCardItem, slot0._cardInfoList, slot0._goCardItemRoot, slot0._goCardItem, XugoujiCardItem)
end

function slot0._createCardItem(slot0, slot1, slot2, slot3)
	slot1:onUpdateData(slot2)
	slot1:refreshUI()
	slot1:refreshCardIcon()

	slot1._view = slot0

	if not slot0._cardIdNumDict[slot2.id] then
		slot0._cardIdNumDict[slot2.id] = 1
	else
		slot0._cardIdNumDict[slot2.id] = slot0._cardIdNumDict[slot2.id] + 1
	end

	slot1.viewGO.name = slot2.id .. slot0._cardIdNumDict[slot2.id]
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

	slot0._cardboxCfgList = {}

	if slot1 then
		slot7 = XugoujiEnum.CardType.Attack

		table.insert(slot0._cardboxCfgList, {
			cardFlag = slot7
		})

		for slot7, slot8 in pairs(slot1) do
			table.insert(slot0._cardboxCfgList, {
				cardId = slot7,
				count = slot8
			})
		end
	end

	if slot2 then
		slot7 = XugoujiEnum.CardType.Func

		table.insert(slot0._cardboxCfgList, {
			cardFlag = slot7
		})

		for slot7, slot8 in pairs(slot2) do
			table.insert(slot0._cardboxCfgList, {
				cardId = slot7,
				count = slot8
			})
		end
	end

	if slot3 then
		slot7 = XugoujiEnum.CardType.Immediate

		table.insert(slot0._cardboxCfgList, {
			cardFlag = slot7
		})

		for slot7, slot8 in pairs(slot3) do
			table.insert(slot0._cardboxCfgList, {
				cardId = slot7,
				count = slot8
			})
		end
	end

	slot0.cardBoxItems = slot0:getUserDataTb_()

	gohelper.CreateObjList(slot0, slot0._createCardBoxItem, slot0._cardboxCfgList, slot0._goCardBoxItemRoot, slot0._goCardBoxItem)
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
		UISpriteSetMgr.instance:setXugoujiSprite(gohelper.findChildImage(slot7, "image_icon"), slot13)
	end

	slot10.text = string.format("x%d", slot2.count)
	slot9.text = slot12.desc
	slot0.cardBoxItems[slot11] = slot7

	gohelper.setActive(gohelper.findChild(slot7, "image_Line"), slot3 ~= #slot0._cardboxCfgList)
end

function slot0._onTurnChanged(slot0)
	slot0:_refreshTurnTips(Activity188Model.instance:isMyTurn())
	slot0:_refreshRoundNum()
end

function slot0._refreshRoundNum(slot0)
	if Activity188Config.instance:getGameCfg(uv0, Activity188Model.instance:getCurGameId()).round < Activity188Model.instance:getRound() or slot1 == slot0._curRoundNum then
		return
	end

	slot0._txtRound.text = string.format("%d/%d", slot1, slot4)

	gohelper.setActive(slot0._goRoundEffect, false)
	gohelper.setActive(slot0._goRoundEffect, true)

	slot0._curRoundNum = slot1
end

function slot0._refreshTurnTips(slot0, slot1)
	gohelper.setActive(slot0._goMyTurnTips, slot1)
	gohelper.setActive(slot0._goEnemyTurnTips, not slot1)
	gohelper.setActive(slot0._goTurnEffect, slot1)
end

function slot0._createTargetList(slot0)
	slot0._targetDataList = {}
	slot0._targetItemList = slot0:getUserDataTb_()

	for slot7, slot8 in ipairs(string.split(Activity188Config.instance:getGameCfg(uv0, Activity188Model.instance:getCurGameId()).passRound, "#")) do
		table.insert(slot0._targetDataList, slot8)
	end

	gohelper.CreateObjList(slot0, slot0._createTargetItem, slot0._targetDataList, slot0._gotargetItemRoot, slot0._gotargetItem)
end

function slot0._createTargetItem(slot0, slot1, slot2, slot3)
	gohelper.setActive(slot1, true)
	ZProj.UGUIHelper.SetGrayFactor(gohelper.findChild(slot1, "image_Star"), 1)

	gohelper.findChildText(slot1, "#txt_TaskTarget").text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("xugouji_round_target"), slot2)
	slot0._targetItemList[slot3] = slot1
end

function slot0._onGameResultPush(slot0, slot1)
	for slot6, slot7 in ipairs(slot0._targetItemList) do
		ZProj.UGUIHelper.SetGrayFactor(gohelper.findChild(slot7, "image_Star"), slot1.star < slot6 and 1 or 0)
	end

	slot0._resultParams = slot1

	TaskDispatcher.runDelay(slot0._delayOpenResultView, slot0, 0.5)
end

function slot0._delayOpenResultView(slot0)
	XugoujiController.instance:openGameResultView(slot0._resultParams)
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
end

return slot0
