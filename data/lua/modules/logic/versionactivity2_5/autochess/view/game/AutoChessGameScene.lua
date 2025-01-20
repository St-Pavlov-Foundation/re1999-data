module("modules.logic.versionactivity2_5.autochess.view.game.AutoChessGameScene", package.seeall)

slot0 = class("AutoChessGameScene", BaseView)

function slot0.onInitView(slot0)
	slot0.gotouch = gohelper.findChild(slot0.viewGO, "UI/#go_touch")
	slot0.layerBg = gohelper.findChild(slot0.viewGO, "Scene/BgLayer")
	slot0.simageBg = gohelper.findChildSingleImage(slot0.viewGO, "Scene/BgLayer/simage_Bg")
	slot0.layerChess = gohelper.findChild(slot0.viewGO, "Scene/ChessLayer")
	slot0.goBoarder = gohelper.findChild(slot0.viewGO, "Scene/BoardLayer/Boader")
	slot0.goChess = gohelper.findChild(slot0.viewGO, "Scene/ChessLayer/Chess")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._click:AddClickListener(slot0.onClickScene, slot0)
end

function slot0.removeEvents(slot0)
	slot0._click:RemoveClickListener()
end

function slot0._editableInitView(slot0)
	slot0.moduleId = AutoChessModel.instance:getCurModuleId()
	slot0.chessMo = AutoChessModel.instance:getChessMo()
	slot0._tfTouch = slot0.gotouch.transform
	slot0._click = gohelper.getClickWithDefaultAudio(slot0.gotouch)

	CommonDragHelper.instance:registerDragObj(slot0.gotouch, slot0._beginDrag, slot0._onDrag, slot0._endDrag, slot0._checkDrag, slot0, nil, true)

	slot0.tileItemDic = {}
end

function slot0.onOpen(slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, slot0.onOpenViewFinish, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0.onCloseViewFinish, slot0)
	slot0:addEventCb(AutoChessController.instance, AutoChessEvent.PlayStepList, slot0.startImmediatelyFlow, slot0)
	slot0:addEventCb(AutoChessController.instance, AutoChessEvent.EnterFightReply, slot0.onEnterFightReply, slot0)
	slot0:addEventCb(AutoChessController.instance, AutoChessEvent.StopFight, slot0.onStopFight, slot0)
	slot0:addEventCb(AutoChessController.instance, AutoChessEvent.SkipFight, slot0.onSkipFight, slot0)
	slot0:addEventCb(AutoChessController.instance, AutoChessEvent.NextRound, slot0.onNextRound, slot0)
	slot0:addEventCb(AutoChessController.instance, AutoChessEvent.CheckEnemyTeam, slot0.onCheckEnemy, slot0)
	AutoChessEntityMgr.instance:init(slot0)
	AutoChessEffectMgr.instance:init()
	slot0:changeScene(AutoChessEnum.ViewType.Player)
	slot0:checkBeforeBuy()
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0.delayAddEnemy, slot0)
	TaskDispatcher.cancelTask(slot0.startFightFlow, slot0)
	CommonDragHelper.instance:unregisterDragObj(slot0.gotouch)
	AutoChessEntityMgr.instance:dispose()
	AutoChessEffectMgr.instance:dispose()
end

function slot0.changeScene(slot0, slot1, slot2)
	slot0.viewType = slot1
	slot0.tileNodes = AutoChessGameModel.instance:initTileNodes(slot1)

	if slot1 == AutoChessEnum.ViewType.Player then
		slot0.simageBg:LoadImage(ResUrl.getAutoChessIcon("scene_player_" .. slot0.moduleId, "scene"))
	elseif slot1 == AutoChessEnum.ViewType.All then
		slot0.simageBg:LoadImage(ResUrl.getAutoChessIcon("scene_all_" .. slot0.moduleId, "scene"))
	elseif slot1 == AutoChessEnum.ViewType.Enemy then
		slot0.simageBg:LoadImage(ResUrl.getAutoChessIcon("scene_enemy_" .. slot0.moduleId, "scene"))
	end

	AutoChessEntityMgr.instance:cacheAllEntity()
	slot0:initTile()

	if not slot2 then
		slot0:initEntity()
	end
end

function slot0.initTile(slot0)
	slot0:clearTile()

	slot2 = nil
	slot2 = slot0.viewType == AutoChessEnum.ViewType.All and AutoChessEnum.BoardSize.Column * 2 or AutoChessEnum.BoardSize.Column

	for slot6 = 1, AutoChessEnum.BoardSize.Row do
		slot0.tileItemDic[slot6] = slot0.tileItemDic[slot6] or {}

		for slot10 = 1, slot2 do
			slot12 = slot0.tileNodes[slot6][slot10]
			slot13 = AutoChessEnum.TileSize[slot0.viewType][slot6]

			if not slot0.tileItemDic[slot6][slot10] then
				slot11 = slot0:getUserDataTb_()
				slot11.go = gohelper.cloneInPlace(slot0.goBoarder, string.format("Boarder%d_%d", slot6, slot10))
				slot11.transform = slot11.go.transform
				slot0.tileItemDic[slot6][slot10] = slot11
			end

			recthelper.setSize(slot11.transform, slot13.x, slot13.y)
			recthelper.setAnchor(slot11.transform, slot12.x, slot12.y)
			gohelper.setActive(slot11.go, true)
		end
	end
end

function slot0.clearTile(slot0)
	for slot4, slot5 in ipairs(slot0.tileItemDic) do
		for slot9, slot10 in ipairs(slot5) do
			gohelper.setActive(slot10.go, false)
		end
	end
end

function slot0.createLeaderEntity(slot0, slot1)
	slot3 = MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(AutoChessEnum.ChessLeaderEntityPath, slot0.layerChess, "Leader" .. slot1.uid), AutoChessLeaderEntity, slot0)

	slot3:setData(slot1)

	return slot3
end

function slot0.initEntity(slot0)
	if slot0.viewType == AutoChessEnum.ViewType.Player then
		AutoChessEntityMgr.instance:addLeaderEntity(slot0.chessMo.svrFight.mySideMaster)
	else
		AutoChessEntityMgr.instance:addLeaderEntity(slot1.enemyMaster)
	end

	for slot5, slot6 in ipairs(slot1.warZones) do
		for slot11 = 1, #slot6.positions do
			if tonumber(slot6.positions[slot11].chess.uid) ~= 0 and (slot0.viewType == AutoChessEnum.ViewType.Player and slot12.index < AutoChessEnum.BoardSize.Column or slot0.viewType == AutoChessEnum.ViewType.Enemy and slot12.index > AutoChessEnum.BoardSize.Column - 1) then
				AutoChessEntityMgr.instance:addEntity(slot6.id, slot12.chess, slot12.index)
			end
		end
	end
end

function slot0.createEntity(slot0, slot1, slot2, slot3)
	slot5 = MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(AutoChessEnum.ChessEntityPath, slot0.layerChess, "Chess" .. slot2.uid), AutoChessEntity, slot0)

	slot5:setData(slot2, slot1, slot3)

	return slot5
end

function slot0.onOpenViewFinish(slot0, slot1)
	if slot1 == ViewName.AutoChessStartFightView then
		slot0:changeScene(AutoChessEnum.ViewType.All, true)
	end
end

function slot0.onCloseViewFinish(slot0, slot1)
	if slot1 == ViewName.AutoChessStartFightView then
		AutoChessHelper.lockScreen("AutoChessGameStartFight", true)

		slot2 = slot0.chessMo.lastSvrFight

		AutoChessEntityMgr.instance:addLeaderEntity(slot2.mySideMaster)
		AutoChessEntityMgr.instance:addLeaderEntity(slot2.enemyMaster)

		for slot6, slot7 in ipairs(slot2.warZones) do
			for slot12 = 1, #slot7.positions do
				if slot12 <= AutoChessEnum.BoardSize.Column and tonumber(slot7.positions[slot12].chess.uid) ~= 0 then
					AutoChessEntityMgr.instance:addEntity(slot7.id, slot13.chess, slot13.index)
				end
			end
		end

		TaskDispatcher.runDelay(slot0.delayAddEnemy, slot0, 0.5)
		TaskDispatcher.runDelay(slot0.startFightFlow, slot0, 0.8)
	end
end

function slot0.delayAddEnemy(slot0)
	for slot5, slot6 in ipairs(slot0.chessMo.lastSvrFight.warZones) do
		for slot11 = 1, #slot6.positions do
			if AutoChessEnum.BoardSize.Column < slot11 and tonumber(slot6.positions[slot11].chess.uid) ~= 0 then
				AutoChessEntityMgr.instance:addEntity(slot6.id, slot12.chess, slot12.index)
			end
		end
	end
end

function slot0.onNextRound(slot0)
	AutoChessEntityMgr.instance:clearEntity()
	slot0:changeScene(AutoChessEnum.ViewType.Player)
	slot0:checkBeforeBuy()
end

function slot0.onStopFight(slot0, slot1)
	if slot1 then
		slot0.fightFlow:stop()
	else
		slot0.fightFlow:resume()
	end
end

function slot0.onSkipFight(slot0)
	slot0:fightFlowDone()
end

function slot0.onEnterFightReply(slot0)
	slot0:checkAfterBuy()
end

function slot0.onCheckEnemy(slot0, slot1)
	if slot1 then
		slot0:changeScene(AutoChessEnum.ViewType.Enemy)
	else
		slot0:changeScene(AutoChessEnum.ViewType.Player)
	end
end

function slot0.onClickScene(slot0)
	if slot0.isDraging then
		return
	end

	slot2 = recthelper.screenPosToAnchorPos(GamepadController.instance:getMousePosition(), slot0._tfTouch)
	slot3, slot4 = AutoChessGameModel.instance:getNearestTileXY(slot2.x, slot2.y)

	if slot4 then
		if slot0.viewType == AutoChessEnum.ViewType.Enemy then
			slot4 = slot4 + 5
		end

		if tonumber(slot0.chessMo:getChessPosition(slot3, slot4, slot0.viewType == AutoChessEnum.ViewType.All and slot0.chessMo.lastSvrFight or slot0.chessMo.svrFight).chess.uid) ~= 0 then
			AutoChessController.instance:openCardInfoView({
				chessEntity = AutoChessEntityMgr.instance:getEntity(slot7)
			})
		end

		return
	end

	if AutoChessGameModel.instance:getNearestLeader(slot2) and lua_auto_chess_master.configDict[slot5.id].isSelf then
		ViewMgr.instance:openView(ViewName.AutoChessLeaderShowView, {
			leader = slot5
		})
	end
end

function slot0._beginDrag(slot0, slot1, slot2)
	slot0.isDraging = true
	slot3 = recthelper.screenPosToAnchorPos(slot2.position, slot0._tfTouch)
	slot4, slot5 = AutoChessGameModel.instance:getNearestTileXY(slot3.x, slot3.y)

	if slot4 and tonumber(slot0.chessMo:getChessPosition(slot4, slot5).chess.uid) ~= 0 and AutoChessEntityMgr.instance:getEntity(slot7).teamType == AutoChessEnum.TeamType.Player then
		slot0.chessAvatar = AutoChessGameModel.instance.avatar

		if slot0.chessAvatar then
			slot0.selectChess = slot8

			slot0.selectChess:hide()

			slot10 = slot8.meshComp
			slot11 = gohelper.findChildUIMesh(slot0.chessAvatar)
			slot11.material = slot10.uiMesh.material
			slot11.mesh = slot10.uiMesh.mesh

			slot11:SetVerticesDirty()
			slot11:SetMaterialDirty()
			recthelper.setAnchor(slot0.chessAvatar.transform, slot3.x, slot3.y)
			transformhelper.setLocalScale(slot0.chessAvatar.transform, transformhelper.getLocalScale(slot8.dirTrs), 1, 1)

			slot12 = gohelper.findChildImage(slot0.chessAvatar, "role")
			slot12.sprite = slot10.imageRole.sprite

			slot12:SetNativeSize()
			gohelper.setActive(slot0.chessAvatar, true)
			AutoChessController.instance:dispatchEvent(AutoChessEvent.DragChessEntity, slot6.chess.id)
		end
	end
end

function slot0._onDrag(slot0, slot1, slot2)
	if slot0.selectChess then
		slot0:_moveToPos(slot0.chessAvatar.transform, recthelper.screenPosToAnchorPos(slot2.position, slot0._tfTouch))
	end
end

function slot0._endDrag(slot0, slot1, slot2)
	slot0.isDraging = false

	if slot0.selectChess then
		slot3 = slot0.selectChess.data.uid
		slot7 = recthelper.screenPosToAnchorPos(slot2.position, slot0._tfTouch)
		slot8, slot9 = AutoChessGameModel.instance:getNearestTileXY(slot7.x, slot7.y)

		if slot9 and slot9 < 6 then
			if slot8 == slot0.selectChess.warZone and slot9 == slot0.selectChess.index + 1 then
				slot0.selectChess:show()
			elseif AutoChessEntityMgr.instance:tryGetEntity(slot0.chessMo:getChessPosition(slot8, slot9).chess.uid) then
				slot12 = AutoChessHelper.hasUniversalBuff(slot0.selectChess.data.buffContainer.buffs)

				if AutoChessController.instance:isDragDisable() then
					slot0.selectChess:show()
				elseif slot12 or AutoChessHelper.sameWarZoneType(slot4, slot8) then
					AudioMgr.instance:trigger(AudioEnum.UI.play_ui_lvhu_building_click)
					AutoChessRpc.instance:sendAutoChessBuildRequest(slot0.moduleId, AutoChessEnum.BuildType.Exchange, slot4, slot5, slot3, slot8, slot9 - 1, slot11.data.uid)
				else
					GameFacade.showToast(ToastEnum.AutoChessExchangeError)
					slot0.selectChess:show()
				end
			elseif AutoChessHelper.sameWarZoneType(slot4, slot8) then
				AutoChessRpc.instance:sendAutoChessBuildRequest(slot0.moduleId, AutoChessEnum.BuildType.Exchange, slot4, slot5, slot3, slot8, slot9 - 1, 0)
			else
				GameFacade.showToast(ToastEnum.AutoChessExchangeError)
				slot0.selectChess:show()
			end
		elseif slot2.pointerEnter and slot10.name == "#go_CheckSell" and AutoChessController.instance:isEnableSale() and not AutoChessController.instance:isDragDisable(GuideModel.GuideFlag.AutoChessEnableSale) then
			AutoChessRpc.instance:sendAutoChessBuildRequest(slot0.moduleId, AutoChessEnum.BuildType.Sell, slot4, slot5, slot3)
		else
			slot0.selectChess:show()
		end

		gohelper.setActive(slot0.chessAvatar, false)

		slot0.chessAvatar = nil
		slot0.selectChess = nil

		AutoChessController.instance:dispatchEvent(AutoChessEvent.DragChessEntityEnd)
	end
end

function slot0._checkDrag(slot0)
	if slot0.fightFlow then
		return true
	end
end

function slot0._moveToPos(slot0, slot1, slot2)
	slot3, slot4 = transformhelper.getPos(slot1)

	if math.abs(slot3 - slot2.x) > 50 or math.abs(slot4 - slot2.y) > 50 then
		if slot0.tweenId then
			ZProj.TweenHelper.KillById(slot0.tweenId)

			slot0.tweenId = nil
		end

		slot0.tweenId = ZProj.TweenHelper.DOAnchorPos(slot1, slot2.x, slot2.y, 0.2)
	else
		recthelper.setAnchor(slot1, slot2.x, slot2.y)
	end
end

function slot0.startImmediatelyFlow(slot0, slot1)
	slot2 = FlowSequence.New()

	slot2:addWork(AutoChessSideWork.New(slot1))
	slot2:start(AutoChessEnum.ContextType.Immediately)
end

function slot0.startFightFlow(slot0)
	AutoChessHelper.lockScreen("AutoChessGameStartFight", false)

	if slot0.chessMo.fightEffectList then
		slot0.fightFlow = FlowSequence.New()

		slot0.fightFlow:addWork(AutoChessSideWork.New(slot1))
		slot0.fightFlow:registerDoneListener(slot0.fightFlowDone, slot0)
		slot0.fightFlow:start(AutoChessEnum.ContextType.Fight)

		slot0.chessMo.fightEffectList = nil
	else
		AutoChessController.instance:openResultView()
	end
end

function slot0.fightFlowDone(slot0)
	slot0.fightFlow:unregisterDoneListener(slot0.fightFlowDone, slot0)
	slot0.fightFlow:destroy()

	slot0.fightFlow = nil

	AutoChessController.instance:openResultView()
end

function slot0.checkBeforeBuy(slot0)
	if slot0.chessMo.startBuyEffectList then
		slot0.beforeBuyFlow = FlowSequence.New()

		slot0.beforeBuyFlow:addWork(AutoChessSideWork.New(slot1))
		slot0.beforeBuyFlow:registerDoneListener(slot0.beforeBuyFlowDone, slot0)
		AutoChessHelper.lockScreen("AutoChessGameScene", true)
		slot0.beforeBuyFlow:start(AutoChessEnum.ContextType.StartBuy)

		slot0.chessMo.startBuyEffectList = nil
	end
end

function slot0.beforeBuyFlowDone(slot0)
	slot0.beforeBuyFlow:unregisterDoneListener(slot0.beforeBuyFlowDone, slot0)
	slot0.beforeBuyFlow:destroy()

	slot0.beforeBuyFlow = nil

	AutoChessHelper.lockScreen("AutoChessGameScene", false)
end

function slot0.checkAfterBuy(slot0)
	if slot0.chessMo.endBuyEffectList then
		slot0.afterBuyFlow = FlowSequence.New()

		slot0.afterBuyFlow:addWork(AutoChessSideWork.New(slot1))
		slot0.afterBuyFlow:registerDoneListener(slot0.afterBuyFlowDone, slot0)
		AutoChessHelper.lockScreen("AutoChessGameScene", true)
		slot0.afterBuyFlow:start(AutoChessEnum.ContextType.EndBuy)

		slot0.chessMo.endBuyEffectList = nil
	else
		slot0:afterBuyFlowDone()
	end
end

function slot0.afterBuyFlowDone(slot0)
	if slot0.afterBuyFlow then
		slot0.afterBuyFlow:unregisterDoneListener(slot0.beforeBuyFlowDone, slot0)
		slot0.afterBuyFlow:destroy()

		slot0.afterBuyFlow = nil

		AutoChessHelper.lockScreen("AutoChessGameScene", false)
	end

	AutoChessController.instance:dispatchEvent(AutoChessEvent.StartFight)
end

return slot0
