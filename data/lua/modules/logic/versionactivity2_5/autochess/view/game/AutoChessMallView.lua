module("modules.logic.versionactivity2_5.autochess.view.game.AutoChessMallView", package.seeall)

slot0 = class("AutoChessMallView", BaseView)

function slot0.onInitView(slot0)
	slot0._goViewSelf = gohelper.findChild(slot0.viewGO, "#go_ViewSelf")
	slot0._goFrame = gohelper.findChild(slot0.viewGO, "#go_ViewSelf/#go_Frame")
	slot0._goMallItem = gohelper.findChild(slot0.viewGO, "#go_ViewSelf/#go_MallItem")
	slot0._txtCoin = gohelper.findChildText(slot0.viewGO, "#go_ViewSelf/Coin/#txt_Coin")
	slot0._goStarProgress = gohelper.findChild(slot0.viewGO, "#go_ViewSelf/#go_StarProgress")
	slot0._imageFreeP = gohelper.findChildImage(slot0.viewGO, "#go_ViewSelf/#go_StarProgress/#image_FreeP")
	slot0._txtFreeP = gohelper.findChildText(slot0.viewGO, "#go_ViewSelf/#go_StarProgress/#txt_FreeP")
	slot0._goRound = gohelper.findChild(slot0.viewGO, "#go_ViewSelf/#go_Round")
	slot0._txtRound = gohelper.findChildText(slot0.viewGO, "#go_ViewSelf/#go_Round/#txt_Round")
	slot0._btnStartFight = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_ViewSelf/#btn_StartFight")
	slot0._goStartLight = gohelper.findChild(slot0.viewGO, "#go_ViewSelf/#btn_StartFight/#go_StartLight")
	slot0._btnCheckEnemy = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_ViewSelf/#btn_CheckEnemy")
	slot0._goCheckCost = gohelper.findChild(slot0.viewGO, "#go_ViewSelf/#btn_CheckEnemy/#go_CheckCost")
	slot0._txtCheckCost = gohelper.findChildText(slot0.viewGO, "#go_ViewSelf/#btn_CheckEnemy/#go_CheckCost/#txt_CheckCost")
	slot0._btnLederSkill = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_ViewSelf/#btn_LederSkill")
	slot0._simageLeaderSkill = gohelper.findChildSingleImage(slot0.viewGO, "#go_ViewSelf/#btn_LederSkill/#simage_LeaderSkill")
	slot0._txtLeaderSkillCost = gohelper.findChildText(slot0.viewGO, "#go_ViewSelf/#btn_LederSkill/#txt_LeaderSkillCost")
	slot0._imageLeaderSkillCost = gohelper.findChildImage(slot0.viewGO, "#go_ViewSelf/#btn_LederSkill/#txt_LeaderSkillCost/#image_LeaderSkillCost")
	slot0._goSkillLock = gohelper.findChild(slot0.viewGO, "#go_ViewSelf/#btn_LederSkill/#go_SkillLock")
	slot0._goLeaderSkillLight = gohelper.findChild(slot0.viewGO, "#go_ViewSelf/#btn_LederSkill/#go_LeaderSkillLight")
	slot0._goLeaderEnergyP = gohelper.findChild(slot0.viewGO, "#go_ViewSelf/#go_LeaderEnergyP")
	slot0._txtLeaderEnergyP = gohelper.findChildText(slot0.viewGO, "#go_ViewSelf/#go_LeaderEnergyP/#txt_LeaderEnergyP")
	slot0._goChargeRoot = gohelper.findChild(slot0.viewGO, "#go_ViewSelf/Bottom/#go_ChargeRoot")
	slot0._imageLevel = gohelper.findChildImage(slot0.viewGO, "#go_ViewSelf/Bottom/#go_ChargeRoot/#image_Level")
	slot0._txtMallLvl = gohelper.findChildText(slot0.viewGO, "#go_ViewSelf/Bottom/#go_ChargeRoot/#image_Level/#txt_MallLvl")
	slot0._goChargeFrame = gohelper.findChild(slot0.viewGO, "#go_ViewSelf/Bottom/#go_ChargeRoot/#go_ChargeFrame")
	slot0._goFreeFrame = gohelper.findChild(slot0.viewGO, "#go_ViewSelf/Bottom/#go_ChargeRoot/#go_ChargeFrame/#go_FreeFrame")
	slot0._btnFresh = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_ViewSelf/Bottom/#go_ChargeRoot/#btn_Fresh")
	slot0._txtFreshCost = gohelper.findChildText(slot0.viewGO, "#go_ViewSelf/Bottom/#go_ChargeRoot/#btn_Fresh/#txt_FreshCost")
	slot0._btnLock = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_ViewSelf/Bottom/#go_ChargeRoot/#btn_Lock")
	slot0._btnUnlock = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_ViewSelf/Bottom/#go_ChargeRoot/#btn_Unlock")
	slot0._goChargeContent = gohelper.findChild(slot0.viewGO, "#go_ViewSelf/Bottom/#go_ChargeRoot/#go_ChargeContent")
	slot0._goCheckSell = gohelper.findChild(slot0.viewGO, "#go_ViewSelf/#go_CheckSell")
	slot0._txtSellPrice = gohelper.findChildText(slot0.viewGO, "#go_ViewSelf/#go_CheckSell/cost/#txt_SellPrice")
	slot0._goChessAvatar = gohelper.findChild(slot0.viewGO, "#go_ViewSelf/#go_ChessAvatar")
	slot0._goViewEnemy = gohelper.findChild(slot0.viewGO, "#go_ViewEnemy")
	slot0._txtGoal = gohelper.findChildText(slot0.viewGO, "#go_ViewEnemy/ScoreTarget/tips/#txt_Goal")
	slot0._btnBack = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_ViewEnemy/#btn_Back")
	slot0._goLeaderEnergyE = gohelper.findChild(slot0.viewGO, "#go_ViewEnemy/#go_LeaderEnergyE")
	slot0._txtLeaderEnergyE = gohelper.findChildText(slot0.viewGO, "#go_ViewEnemy/#go_LeaderEnergyE/#txt_LeaderEnergyE")
	slot0._goPickView = gohelper.findChild(slot0.viewGO, "#go_PickView")
	slot0._btnBackPick = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_PickView/#btn_BackPick")
	slot0._goexcessive = gohelper.findChild(slot0.viewGO, "#go_excessive")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnStartFight:AddClickListener(slot0._btnStartFightOnClick, slot0)
	slot0._btnCheckEnemy:AddClickListener(slot0._btnCheckEnemyOnClick, slot0)
	slot0._btnLederSkill:AddClickListener(slot0._btnLederSkillOnClick, slot0)
	slot0._btnFresh:AddClickListener(slot0._btnFreshOnClick, slot0)
	slot0._btnLock:AddClickListener(slot0._btnLockOnClick, slot0)
	slot0._btnUnlock:AddClickListener(slot0._btnUnlockOnClick, slot0)
	slot0._btnBack:AddClickListener(slot0._btnBackOnClick, slot0)
	slot0._btnBackPick:AddClickListener(slot0._btnBackPickOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnStartFight:RemoveClickListener()
	slot0._btnCheckEnemy:RemoveClickListener()
	slot0._btnLederSkill:RemoveClickListener()
	slot0._btnFresh:RemoveClickListener()
	slot0._btnLock:RemoveClickListener()
	slot0._btnUnlock:RemoveClickListener()
	slot0._btnBack:RemoveClickListener()
	slot0._btnBackPick:RemoveClickListener()
end

function slot0._btnBackPickOnClick(slot0)
	if AutoChessController.instance:isClickDisable() then
		return
	end

	gohelper.setActive(slot0._btnLederSkill, true)
	gohelper.setActive(slot0._goLeaderEnergyP, true)
	gohelper.setActive(slot0._goStarProgress, true)
	gohelper.setActive(slot0._btnCheckEnemy, true)
	gohelper.setActive(slot0._btnStartFight, true)
	gohelper.setActive(slot0._goRound, true)
	gohelper.setActive(slot0._btnFresh, true)
	gohelper.setActive(slot0._btnLock, true)
	gohelper.setActive(slot0._goPickView, false)
	slot0:checkForcePick()
end

function slot0._btnCheckEnemyOnClick(slot0)
	if AutoChessController.instance:isClickDisable(GuideModel.GuideFlag.AutoChessEnablePreviewEnemy) then
		return
	end

	if slot0.chessMo.preview then
		slot0:previewCallback(0, 0)
	elseif slot0.previewCostEnough then
		AutoChessRpc.instance:sendAutoChessPreviewFightRequest(slot0.moduleId, slot0.previewCallback, slot0)
	else
		GameFacade.showToast(ToastEnum.AutoChessCoinNotEnough)
	end
end

function slot0._btnLederSkillOnClick(slot0)
	if AutoChessController.instance:isClickDisable(GuideModel.GuideFlag.AutoChessEnableUseSkill) then
		return
	end

	if slot0:checkCanUseLeaderSkill(true) then
		AutoChessRpc.instance:sendAutoChessUseMasterSkillRequest(slot0.moduleId, slot0.chessMo.svrFight.mySideMaster.skill.id)
	end
end

function slot0._btnBackOnClick(slot0)
	if AutoChessController.instance:isClickDisable() then
		return
	end

	slot0.checkingEnemy = false

	slot0.animSwitch:Play("story", 0, 0)
	TaskDispatcher.runDelay(slot0.delaySwitch, slot0, 0.35)
end

function slot0.previewCallback(slot0, slot1, slot2)
	if slot2 == 0 then
		slot0.checkingEnemy = true

		slot0.animSwitch:Play("hard", 0, 0)
		TaskDispatcher.runDelay(slot0.delaySwitch, slot0, 0.35)
	end
end

function slot0.delaySwitch(slot0)
	if slot0.checkingEnemy then
		gohelper.setActive(slot0._goCheckCost, false)
		gohelper.setActive(slot0._goViewSelf, false)
		gohelper.setActive(slot0._goViewEnemy, true)
		AutoChessController.instance:dispatchEvent(AutoChessEvent.CheckEnemyTeam, true)
		AutoChessController.instance:dispatchEvent(AutoChessEvent.ZClickPreviewEnemy, true)
	else
		gohelper.setActive(slot0._goViewSelf, true)
		gohelper.setActive(slot0._goViewEnemy, false)
		AutoChessController.instance:dispatchEvent(AutoChessEvent.CheckEnemyTeam, false)
		AutoChessController.instance:dispatchEvent(AutoChessEvent.ZClickBackSelf, false)
	end
end

function slot0._btnFreshOnClick(slot0)
	if not AutoChessController.instance:isEnableRefresh() or AutoChessController.instance:isClickDisable() then
		return
	end

	if slot0.freshCost <= tonumber(slot0.chessMo.svrMall.coin) then
		slot0.animBtnFresh:Play("click", 0, 0)
		slot0.animBottom:Play("flushed", 0, 0)
		TaskDispatcher.runDelay(slot0.delayRefreshStore, slot0, 0.16)
	else
		GameFacade.showToast(ToastEnum.AutoChessCoinNotEnough)
	end
end

function slot0.delayRefreshStore(slot0)
	AutoChessRpc.instance:sendAutoChessRefreshMallRequest(slot0.moduleId)
end

function slot0._btnLockOnClick(slot0)
	if AutoChessController.instance:isClickDisable() then
		return
	end

	AutoChessRpc.instance:sendAutoChessFreezeItemRequest(slot0.moduleId, slot0.chargeMall.mallId, 0, AutoChessEnum.FreeZeType.Freeze, slot0.freezeReply, slot0)
end

function slot0._btnUnlockOnClick(slot0)
	if AutoChessController.instance:isClickDisable() then
		return
	end

	AutoChessRpc.instance:sendAutoChessFreezeItemRequest(slot0.moduleId, slot0.chargeMall.mallId, 0, AutoChessEnum.FreeZeType.UnFreeze, slot0.freezeReply, slot0)
end

function slot0._btnStartFightOnClick(slot0)
	if AutoChessController.instance:isClickDisable() then
		return
	end

	if #AutoChessHelper.getMallRegionByType(slot0.chessMo.svrMall.regions, AutoChessEnum.MallType.Free).items ~= 0 then
		GameFacade.showOptionMessageBox(MessageBoxIdDefine.AutoChessFreeChessClean, MsgBoxEnum.BoxType.Yes_No, MsgBoxEnum.optionType.Daily, slot0._fightYesCallback, nil, , slot0)
	else
		slot0:_fightYesCallback()
	end
end

function slot0._fightYesCallback(slot0)
	AutoChessRpc.instance:sendAutoChessEnterFightRequest(slot0.moduleId)
end

function slot0._onEscapeBtnClick(slot0)
	if not slot0._goPickView.activeInHierarchy then
		AutoChessController.instance:exitGame()
	end
end

function slot0._editableInitView(slot0)
	slot0.animFreeFrame = gohelper.findChild(slot0.viewGO, "#go_ViewSelf/Bottom/Left/FreeFrame"):GetComponent(gohelper.Type_Animator)
	slot0.animBottom = gohelper.findChild(slot0.viewGO, "#go_ViewSelf/Bottom"):GetComponent(gohelper.Type_Animator)
	slot0.animBtnFresh = slot0._btnFresh.gameObject:GetComponent(gohelper.Type_Animator)
	slot0.animSwitch = slot0._goexcessive:GetComponent(gohelper.Type_Animator)
	slot0.animCoin = slot0._txtCoin.gameObject:GetComponent(gohelper.Type_Animator)
	slot0.animStarProgress = slot0._goStarProgress:GetComponent(gohelper.Type_Animator)

	NavigateMgr.instance:addEscape(slot0.viewName, slot0._onEscapeBtnClick, slot0)
	slot0:initMallItemList()
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.AutoChess.play_ui_tangren_shopping_enter)
	slot0:addEventCb(AutoChessController.instance, AutoChessEvent.StartFight, slot0.closeThis, slot0)
	slot0:addEventCb(AutoChessController.instance, AutoChessEvent.UpdateMallData, slot0.refreshUI, slot0)
	slot0:addEventCb(AutoChessController.instance, AutoChessEvent.DragChessEntity, slot0.onDragChess, slot0)
	slot0:addEventCb(AutoChessController.instance, AutoChessEvent.DragChessEntityEnd, slot0.onDragChessEnd, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0.onCloseView, slot0)
	slot0:addEventCb(AutoChessController.instance, AutoChessEvent.MallCoinChange, slot0.refreshCoinRelative, slot0)
	slot0:addEventCb(AutoChessController.instance, AutoChessEvent.ForcePickViewBoard, slot0.onViewBoard, slot0)
	slot0:addEventCb(AutoChessController.instance, AutoChessEvent.ForcePickReply, slot0.onForcePickReply, slot0)
	slot0:addEventCb(AutoChessController.instance, AutoChessEvent.UpdateMasterSkill, slot0.refreshLeaderSkillRelative, slot0)
	slot0:addEventCb(AutoChessController.instance, AutoChessEvent.UpdateLeaderEnergy, slot0.refreshLeaderEnergy, slot0)
	slot0:addEventCb(AutoChessController.instance, AutoChessEvent.DrageMallItem, slot0.onDragMallItem, slot0)
	slot0:addEventCb(AutoChessController.instance, AutoChessEvent.DrageMallItemEnd, slot0.onDragMallItemEnd, slot0)
	AutoChessGameModel.instance:setChessAvatar(slot0._goChessAvatar)

	slot0.moduleId = AutoChessModel.instance:getCurModuleId()
	slot0.chessMo = AutoChessModel.instance:getChessMo()

	slot0:refreshUI()
	slot0:refreshMallLock()
end

function slot0.onClose(slot0)
	AutoChessGameModel.instance.avatar = nil
end

function slot0.onDestroyView(slot0)
	if slot0._tweenId then
		ZProj.TweenHelper.KillById(slot0._tweenId)

		slot0._tweenId = nil
	end

	TaskDispatcher.cancelTask(slot0.checkPopUp, slot0)
	TaskDispatcher.cancelTask(slot0.recordItemPos, slot0)
	TaskDispatcher.cancelTask(slot0.delaySwitch, slot0)
end

function slot0.initMallItemList(slot0)
	slot0.freeFrameList = slot0:getUserDataTb_()
	slot0.chargeFrameList = slot0:getUserDataTb_()
	slot0.freeItemList = {}
	slot0.chargeItemList = {}

	for slot4 = 1, 7 do
		if slot4 == 1 then
			slot0.freeFrameList[slot4] = slot0._goFreeFrame.transform
			slot0.freeItemList[slot4] = MonoHelper.addNoUpdateLuaComOnceToGo(gohelper.clone(slot0._goMallItem, slot0._goChargeContent, "freeItem" .. slot4), AutoChessMallItem, slot0)
		end

		slot0.chargeFrameList[slot4] = gohelper.clone(slot0._goFrame, slot0._goChargeFrame, "chargeFrame" .. slot4).transform
		slot0.chargeItemList[slot4] = MonoHelper.addNoUpdateLuaComOnceToGo(gohelper.clone(slot0._goMallItem, slot0._goChargeContent, "chargeItem" .. slot4), AutoChessMallItem, slot0)
	end

	gohelper.setActive(slot0._goFrame, false)
	gohelper.setActive(slot0._goMallItem, false)
	TaskDispatcher.runDelay(slot0.recordItemPos, slot0, 0.01)
end

function slot0.recordItemPos(slot0)
	for slot4 = 1, 7 do
		if slot4 == 1 then
			slot5, slot6 = recthelper.getAnchor(slot0._goFreeFrame.transform)

			slot0.freeItemList[slot4]:setPos(slot5, slot6)
		end

		slot5, slot6 = recthelper.getAnchor(slot0.chargeFrameList[slot4])

		slot0.chargeItemList[slot4]:setPos(slot5, slot6)
	end
end

function slot0.refreshUI(slot0)
	slot1 = slot0.chessMo.svrMall

	slot0:refreshMallItem(slot1)

	slot4 = lua_auto_chess_mall.configDict[AutoChessHelper.getMallRegionByType(slot1.regions, AutoChessEnum.MallType.Normal).mallId] and slot3.showLevel or 0

	UISpriteSetMgr.instance:setAutoChessSprite(slot0._imageLevel, "v2a5_autochess_quality3_" .. slot4)

	slot0._txtMallLvl.text = "Lv." .. slot4
	slot0._txtSellPrice.text = lua_auto_chess_const.configDict[AutoChessEnum.ConstKey.ChessSellPrice].value

	gohelper.setActive(slot0._goCheckCost, not slot0.chessMo.preview)
	slot0:refreshLeaderEnergy()
	slot0:refreshCoinRelative()
	slot0:refreshRoundRelative()
	slot0:refreshLeaderSkillRelative()

	slot0.maxStarCnt = tonumber(lua_auto_chess_const.configDict[AutoChessEnum.ConstKey.RewardMaxStar].value)

	if slot0:playStartProgressAnim() == 0 then
		slot0:refreshStarProgress()
		slot0:checkPopUp()
	else
		TaskDispatcher.runDelay(slot0.checkPopUp, slot0, slot7)
	end
end

function slot0.refreshRoundRelative(slot0)
	slot3 = lua_auto_chess_round.configDict[Activity182Model.instance:getCurActId()][slot0.chessMo.sceneRound]

	if slot0.chessMo.svrMall.freeRefreshCount > 0 then
		slot0.freshCost = 0
	else
		slot0.freshCost = tonumber(lua_auto_chess_mall_refresh.configDict[slot2].cost)
	end

	slot0._txtFreshCost.text = slot0.freshCost
	slot0._txtRound.text = string.format("%d/%d", slot2, lua_auto_chess_episode.configDict[AutoChessModel.instance.episodeId].maxRound)
	slot6 = string.split(slot3.assess, "#")
	slot0._txtGoal.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("autochess_gameview_startarget"), string.format("%s/%s/%s", slot6[1], slot6[2], slot6[3]))
end

function slot0.refreshMallLock(slot0)
	slot1 = slot0.chargeMall.items[1] and slot0.chargeMall.items[1].freeze and true or false

	gohelper.setActive(slot0._btnLock, not slot1)
	gohelper.setActive(slot0._btnUnlock, slot1)
end

function slot0.refreshLeaderSkillRelative(slot0)
	ZProj.UGUIHelper.SetGrayscale(slot0._simageLeaderSkill.gameObject, not slot0.chessMo.svrFight.mySideMaster.skill.canUse)
	gohelper.setActive(slot0._goSkillLock, not slot0.chessMo.svrFight.mySideMaster.skill.unlock)
	slot0:refreshLeaderSkillLight()
end

function slot0.refreshLeaderSkillLight(slot0)
	gohelper.setActive(slot0._goLeaderSkillLight, slot0:checkCanUseLeaderSkill())
end

function slot0.refreshLeaderEnergy(slot0)
	slot3 = lua_auto_chess_master.configDict[slot0.chessMo.svrFight.mySideMaster.id]

	slot0._simageLeaderSkill:LoadImage(ResUrl.getAutoChessIcon(slot3.skillIcon, "skillicon"))

	if not string.nilorempty(lua_auto_chess_master_skill.configDict[slot3.skillId].cost) then
		slot6 = string.split(slot5, "#")

		UISpriteSetMgr.instance:setAutoChessSprite(slot0._imageLeaderSkillCost, "v2a5_autochess_cost" .. slot6[1])

		slot0._txtLeaderSkillCost.text = slot6[2] ~= 0 and slot6[2] or luaLang("autochess_mallview_nocost")
	else
		slot0._txtLeaderSkillCost.text = luaLang("autochess_mallview_nocost")
	end

	slot6 = AutoChessHelper.getBuffEnergy(slot1.mySideMaster.buffContainer.buffs)
	slot0._txtLeaderEnergyP.text = slot6

	gohelper.setActive(slot0._goLeaderEnergyP, slot6 ~= 0)

	slot6 = AutoChessHelper.getBuffEnergy(slot1.enemyMaster.buffContainer.buffs)
	slot0._txtLeaderEnergyE.text = slot6

	gohelper.setActive(slot0._goLeaderEnergyE, slot6 ~= 0)
end

function slot0.refreshCoinRelative(slot0)
	slot0._txtCoin.text = slot0.chessMo.svrMall.coin
	slot0.previewCostEnough = slot0.chessMo:checkCostEnough(AutoChessStrEnum.CostType.Coin, slot0.chessMo.previewCoin)
	slot0._txtCheckCost.text = slot0.previewCostEnough and slot2 or string.format("<color=#BD2C2C>%s</color>", slot2)

	gohelper.setActive(slot0._goStartLight, slot1.coin == 0)
	slot0:refreshLeaderSkillLight()
end

function slot0.refreshMallItem(slot0, slot1)
	for slot5, slot6 in ipairs(slot1.regions) do
		if lua_auto_chess_mall.configDict[slot6.mallId].type == AutoChessEnum.MallType.Normal then
			slot0.chargeMall = slot6

			table.sort(slot6.items, function (slot0, slot1)
				return lua_auto_chess_mall_item.configDict[slot0.id].order < lua_auto_chess_mall_item.configDict[slot1.id].order
			end)

			for slot11 = 1, 7 do
				slot0.chargeItemList[slot11]:setData(slot6.mallId, slot6.items[slot11])
				gohelper.setActive(slot0.chargeFrameList[slot11].gameObject, slot11 <= slot7.capacity)
			end
		else
			slot0.freeMall = slot6

			slot0.freeItemList[1]:setData(slot6.mallId, slot6.items[1], true)
		end
	end
end

function slot0.checkPopUp(slot0)
	if slot0.chessMo.mallUpgrade then
		ViewMgr.instance:openView(ViewName.AutoChessMallLevelUpView)

		slot0.chessMo.mallUpgrade = false
	else
		slot0:checkForcePick()
	end
end

function slot0.checkForcePick(slot0)
	if #slot0.freeMall.selectItems > 0 then
		ViewMgr.instance:openView(ViewName.AutoChessForcePickView, slot0.freeMall)
	end
end

function slot0.onDragChess(slot0)
	gohelper.setActive(slot0._goCheckSell, true)
	gohelper.setActive(slot0._goChargeRoot, false)
end

function slot0.onDragChessEnd(slot0)
	gohelper.setActive(slot0._goCheckSell, false)
	gohelper.setActive(slot0._goChargeRoot, true)
end

function slot0.onCloseView(slot0, slot1)
	if slot1 == ViewName.AutoChessMallLevelUpView then
		slot0:checkForcePick()
	end
end

function slot0.onViewBoard(slot0)
	gohelper.setActive(slot0._btnLederSkill, false)
	gohelper.setActive(slot0._goLeaderEnergyP, false)
	gohelper.setActive(slot0._goStarProgress, false)
	gohelper.setActive(slot0._btnCheckEnemy, false)
	gohelper.setActive(slot0._btnStartFight, false)
	gohelper.setActive(slot0._goRound, false)
	gohelper.setActive(slot0._btnFresh, false)
	gohelper.setActive(slot0._btnLock, false)
	gohelper.setActive(slot0._goPickView, true)
end

function slot0.onForcePickReply(slot0, slot1)
	if not slot1 then
		slot0.animFreeFrame:Play("open", 0, 0)
		slot0:refreshUI()
	end
end

function slot0.onDragMallItem(slot0, slot1, slot2)
	if slot2 ~= 0 then
		slot0._txtCoin.text = string.format("%d(-%d)", slot0.chessMo.svrMall.coin, slot2)

		slot0.animCoin:Play("loop", 0, 0)
	end
end

function slot0.onDragMallItemEnd(slot0)
	slot0._txtCoin.text = slot0.chessMo.svrMall.coin

	slot0.animCoin:Play("idle", 0, 0)
end

function slot0.freezeReply(slot0, slot1, slot2, slot3)
	if slot2 ~= 0 then
		return
	end

	slot4 = slot3.type == AutoChessEnum.FreeZeType.Freeze

	gohelper.setActive(slot0._btnLock, not slot4)
	gohelper.setActive(slot0._btnUnlock, slot4)

	for slot8, slot9 in ipairs(slot0.chargeItemList) do
		slot9:setLock(slot4)
	end
end

function slot0.checkCanUseLeaderSkill(slot0, slot1)
	slot2 = slot0.chessMo.svrFight.mySideMaster
	slot3 = lua_auto_chess_master.configDict[slot2.id]

	if lua_auto_chess_master_skill.configDict[slot2.skill.id].type == AutoChessStrEnum.SkillType.Passive then
		if slot1 then
			GameFacade.showToast(ToastEnum.AutoChessMasterSkill1)
		end

		return false
	else
		if not slot2.skill.unlock then
			if slot1 then
				GameFacade.showToast(ToastEnum.AutoChessMasterSkill4)
			end

			return false
		end

		if not slot2.skill.canUse then
			if slot1 then
				GameFacade.showToast(ToastEnum.AutoChessMasterSkill2)
			end

			return false
		end

		if slot3.roundTriggerCountLimit ~= 0 then
			slot8 = 0

			for slot12, slot13 in ipairs(slot0.chessMo.svrFight.mySideMaster.skill.roundUseCounts) do
				if slot13.round == slot0.chessMo.sceneRound then
					slot8 = slot13.count

					break
				end
			end

			if slot6 <= slot8 then
				if slot1 then
					GameFacade.showToast(ToastEnum.AutoChessMasterSkill2)
				end

				return false
			end
		end

		if slot3.totalTriggerCountLimit ~= 0 then
			for slot12, slot13 in ipairs(slot0.chessMo.svrFight.mySideMaster.skill.roundUseCounts) do
				slot8 = 0 + slot13.count
			end

			if slot6 <= slot8 then
				if slot1 then
					GameFacade.showToast(ToastEnum.AutoChessMasterSkill3)
				end

				return false
			end
		end

		slot7 = string.split(slot5.cost, "#")

		if not slot0.chessMo:checkCostEnough(slot7[1], tonumber(slot7[2])) then
			if slot1 then
				GameFacade.showToast(ToastEnum.AutoChessCoinNotEnough)
			end

			return false
		end
	end

	return true
end

function slot0.refreshStarProgress(slot0)
	slot1 = slot0.chessMo.svrMall.rewardProgress
	slot0._imageFreeP.fillAmount = slot1 / slot0.maxStarCnt
	slot0._txtFreeP.text = string.format("%d/%d", slot1, slot0.maxStarCnt)
end

function slot0.playStartProgressAnim(slot0)
	if not slot0.chessMo.lastRewardProgress then
		return 0
	end

	slot0.chessMo.lastRewardProgress = nil

	if slot0.chessMo.svrMall.rewardProgress - slot1 > 0 then
		slot0.animStarProgress:Play("add", 0, 0)

		slot0._tweenId = ZProj.TweenHelper.DOTweenFloat(slot1, slot2, 0.67, slot0._tweenFrameCb, slot0._tweenFinish, slot0)

		return 0.67
	elseif slot2 - slot1 < 0 then
		slot0.animStarProgress:Play("add", 0, 0)

		slot0._tweenId = ZProj.TweenHelper.DOTweenFloat(slot1, slot0.maxStarCnt, 0.67, slot0._tweenFrameCb, slot0._tweenFinish, slot0)

		return 0.67
	end

	return 0
end

function slot0._tweenFrameCb(slot0, slot1)
	slot0._imageFreeP.fillAmount = slot1 / slot0.maxStarCnt
	slot0._txtFreeP.text = string.format("%d/%d", slot1, slot0.maxStarCnt)
end

function slot0._tweenFinish(slot0)
	slot0:refreshStarProgress()
end

return slot0
