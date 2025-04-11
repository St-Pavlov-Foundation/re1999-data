module("modules.logic.versionactivity2_7.lengzhou6.view.LengZhou6EliminateView", package.seeall)

slot0 = class("LengZhou6EliminateView", BaseView)

function slot0.onInitView(slot0)
	slot0.viewGO = gohelper.findChild(slot0.viewGO, "#go_Right")
	slot0._simageGrid = gohelper.findChildSingleImage(slot0.viewGO, "#simage_Grid")
	slot0._goTimes = gohelper.findChild(slot0.viewGO, "#go_Times")
	slot0._btnLeft = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_Times/#btn_Left")
	slot0._txtTimes = gohelper.findChildText(slot0.viewGO, "#go_Times/#txt_Times")
	slot0._btnRight = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_Times/#btn_Right")
	slot0._goChessBG = gohelper.findChild(slot0.viewGO, "#go_ChessBG")
	slot0._gochessBoard = gohelper.findChild(slot0.viewGO, "#go_ChessBG/#go_chessBoard")
	slot0._gochess = gohelper.findChild(slot0.viewGO, "#go_ChessBG/#go_chess")
	slot0._btnclick = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_ChessBG/#go_chess/#btn_click")
	slot0._goChessEffect = gohelper.findChild(slot0.viewGO, "#go_ChessEffect")
	slot0._goLoading = gohelper.findChild(slot0.viewGO, "#go_Loading")
	slot0._sliderloading = gohelper.findChildSlider(slot0.viewGO, "#go_Loading/#slider_loading")
	slot0._goContinue = gohelper.findChild(slot0.viewGO, "#go_Continue")
	slot0._simageMask = gohelper.findChildSingleImage(slot0.viewGO, "#go_Continue/#simage_Mask")
	slot0._btnContinue = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_Continue/#btn_Continue")
	slot0._goMask = gohelper.findChild(slot0.viewGO, "#go_Mask")
	slot0._goAssess = gohelper.findChild(slot0.viewGO, "#go_Assess")
	slot0._imageAssess = gohelper.findChildImage(slot0.viewGO, "#go_Assess/#image_Assess")
	slot0._goAssess2 = gohelper.findChild(slot0.viewGO, "#go_Assess2")
	slot0._imageAssess2 = gohelper.findChildImage(slot0.viewGO, "#go_Assess2/#image_Assess2")
	slot0._txtNum = gohelper.findChildText(slot0.viewGO, "#go_Assess2/#txt_Num")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnLeft:AddClickListener(slot0._btnLeftOnClick, slot0)
	slot0._btnRight:AddClickListener(slot0._btnRightOnClick, slot0)
	slot0._btnclick:AddClickListener(slot0._btnclickOnClick, slot0)
	slot0._btnContinue:AddClickListener(slot0._btnContinueOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnLeft:RemoveClickListener()
	slot0._btnRight:RemoveClickListener()
	slot0._btnclick:RemoveClickListener()
	slot0._btnContinue:RemoveClickListener()
end

function slot0._btnLeftOnClick(slot0)
end

function slot0._btnRightOnClick(slot0)
end

function slot0._btnclickOnClick(slot0)
end

function slot0._btnContinueOnClick(slot0)
	if #LengZhou6GameModel.instance:getSelectSkillIdList() < LengZhou6Enum.defaultPlayerSkillSelectMax then
		GameFacade.showMessageBox(MessageBoxIdDefine.LengZhou6EndLessContinue, MsgBoxEnum.BoxType.Yes_No, slot0._continueGame, nil, , slot0)
	else
		slot0:_continueGame()
	end
end

function slot0._continueGame(slot0)
	LengZhou6GameModel.instance:enterNextLayer()
	LengZhou6GameModel.instance:resetSelectSkillId()

	for slot5 = 1, #LengZhou6GameModel.instance:getSelectSkillIdList() do
		LengZhou6GameModel.instance:setPlayerSelectSkillId(slot5, slot1[slot5])
	end
end

function slot0._editableInitView(slot0)
	gohelper.setActiveCanvasGroup(slot0._gochess, false)

	if LengZhou6EliminateChessItemController.instance:InitCloneGo(slot0._gochess, slot0._gochessBoard, slot0._goChessBG, slot0._goChessBG) then
		LengZhou6EliminateChessItemController.instance:InitChess()
	end

	gohelper.setActive(slot0._goeffect, false)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	gohelper.setActive(slot0._goAssess, false)
	slot0:addEventCb(LengZhou6EliminateController.instance, LengZhou6Event.OnChessSelect, slot0.onSelectItem, slot0)
	slot0:addEventCb(LengZhou6EliminateController.instance, LengZhou6Event.UpdateGameInfo, slot0.updateRound, slot0)
	slot0:addEventCb(LengZhou6EliminateController.instance, LengZhou6Event.PerformBegin, slot0.onPerformBegin, slot0)
	slot0:addEventCb(LengZhou6EliminateController.instance, LengZhou6Event.PerformEnd, slot0.onPerformEnd, slot0)
	slot0:addEventCb(LengZhou6EliminateController.instance, LengZhou6Event.ReleaseSkill, slot0.onReleaseSkill, slot0)
	slot0:addEventCb(LengZhou6EliminateController.instance, LengZhou6Event.ShowAssess, slot0.OnShowAssess, slot0)
	slot0:addEventCb(LengZhou6EliminateController.instance, LengZhou6Event.CancelSkill, slot0.cancelSkill, slot0)
	slot0:addEventCb(LengZhou6EliminateController.instance, LengZhou6Event.ShowEffect, slot0.showEffect, slot0)
	slot0:addEventCb(LengZhou6EliminateController.instance, LengZhou6Event.HideEffect, slot0.hideEffect, slot0)
	slot0:addEventCb(LengZhou6EliminateController.instance, LengZhou6Event.ClearEliminateEffect, slot0.clearAllEffect, slot0)
	slot0:addEventCb(LengZhou6GameController.instance, LengZhou6Event.OnEndlessChangeSelectState, slot0.endLessModelRefreshView, slot0)
	slot0:addEventCb(LengZhou6GameController.instance, LengZhou6Event.GameReStart, slot0._gameReStart, slot0)
	slot0:initView()
end

function slot0._gameReStart(slot0)
	gohelper.setActive(slot0._goAssess, false)
	slot0:initView()
end

function slot0.onSelectItem(slot0, slot1, slot2, slot3)
	if slot0._mask then
		return
	end

	if LocalEliminateChessModel.instance:getCell(slot1, slot2) then
		if slot0._needReleaseSkill == nil and (slot4:haveStatus(EliminateEnum_2_7.ChessState.Frost) or slot4:getEliminateID() == EliminateEnum_2_7.ChessType.stone) then
			return
		end
	end

	if slot0._needReleaseSkill ~= nil then
		if slot0._lastSelectX and slot0._lastSelectY then
			slot0:setSelect(false, slot0._lastSelectX, slot0._lastSelectY)
			slot0:recordLastSelect(nil, )
		end

		slot0:setSkillParams(slot1, slot2)

		return
	end

	AudioMgr.instance:trigger(AudioEnum2_7.LengZhou6.play_ui_yuzhou_lzl_click)

	if slot0._lastSelectX and slot0._lastSelectY then
		if slot0._lastSelectX ~= slot1 or slot0._lastSelectY ~= slot2 then
			slot0:setSelect(false, slot0._lastSelectX, slot0._lastSelectY)
			LengZhou6EliminateController.instance:exchangeCell(slot0._lastSelectX, slot0._lastSelectY, slot1, slot2)
			slot0:recordLastSelect(nil, )
			slot0:setSelect(false, slot1, slot2)
		else
			slot0:setSelect(false, slot0._lastSelectX, slot0._lastSelectY)
			slot0:recordLastSelect(nil, )
		end
	else
		if slot3 then
			slot0:setSelect(true, slot1, slot2)
		end

		slot0:recordLastSelect(slot1, slot2)
	end
end

function slot0.setSelect(slot0, slot1, slot2, slot3)
	slot4 = nil

	if ((not slot2 or not slot3 or LengZhou6EliminateChessItemController.instance:getChessItem(slot2, slot3)) and LengZhou6EliminateChessItemController.instance:getChessItem(slot0._lastSelectX, slot0._lastSelectY)) ~= nil then
		slot4:setSelect(slot1)
	end
end

function slot0.recordLastSelect(slot0, slot1, slot2)
	slot0._lastSelectX = slot1
	slot0._lastSelectY = slot2

	slot0:updateTipTime()
	slot0:tip(false)
end

function slot0.initView(slot0)
	TaskDispatcher.cancelTask(slot0.showViewByModel, slot0)

	if LengZhou6GameModel.instance:getBattleModel() == LengZhou6Enum.BattleModel.normal then
		slot0:updateRound()
		slot0:showLoading(true)
	else
		slot0:endLessModelRefreshView(true)
	end
end

function slot0.endLessModelRefreshView(slot0, slot1)
	slot3 = LengZhou6GameModel.instance:getEndLessBattleProgress() == LengZhou6Enum.BattleProgress.selectSkill

	gohelper.setActive(slot0._goContinue, slot3)
	gohelper.setActive(slot0._goLoading, not slot3)
	gohelper.setActive(slot0._goChessBG, not slot3)
	gohelper.setActive(slot0._goChessEffect, not slot3)
	slot0:setMaskActive(false)
	slot0:updateRound()

	if slot2 == LengZhou6Enum.BattleProgress.selectFinish then
		slot0:showLoading(slot1)
	else
		slot0:changeTipState(false, true, false)
		LengZhou6GameModel.instance:recordChessData()
		LengZhou6Controller.instance:dispatchEvent(LengZhou6Event.ChangePlayerSkill, LengZhou6GameModel.instance:getEndLessModelLayer())
	end
end

function slot0.updateRound(slot0)
	slot0._txtTimes.text = LengZhou6GameModel.instance:getCurRound()
end

function slot0.setMaskActive(slot0, slot1)
	gohelper.setActive(slot0._goMask, slot1)

	slot0._mask = slot1
end

function slot0.onPerformBegin(slot0)
	slot0:setMaskActive(true)
	slot0:changeTipState(false, true, false)
end

function slot0.onPerformEnd(slot0)
	slot0:setMaskActive(false)
	slot0:changeTipState(true, false, true)
end

function slot0.showLoading(slot0, slot1)
	slot0:setMaskActive(true)
	gohelper.setActive(slot0._goLoading, true)
	gohelper.setActive(slot0._goChessBG, false)
	gohelper.setActive(slot0._goContinue, false)
	gohelper.setActive(slot0._goChessEffect, false)
	slot0:setMaskActive(true)
	slot0._sliderloading:SetValue(0)

	if slot1 then
		TaskDispatcher.runDelay(slot0._showLoading, slot0, LengZhou6Enum.openViewAniTime)
	else
		slot0:_showLoading()
	end
end

function slot0._showLoading(slot0)
	if slot0._conTweenId then
		ZProj.TweenHelper.KillById(slot0._conTweenId)

		slot0._conTweenId = nil
	end

	AudioMgr.instance:trigger(AudioEnum2_7.LengZhou6.play_ui_yuzhou_lzl_loading)

	slot0._conTweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, LengZhou6Enum.LoadingTime, slot0._updateLoading, slot0._finishLoading, slot0, nil, EaseType.Linear)
end

function slot0._updateLoading(slot0, slot1)
	if slot0._sliderloading then
		slot0._sliderloading:SetValue(slot1)
	end
end

function slot0._finishLoading(slot0)
	LengZhou6EliminateController.instance:createInitMoveStepAndUpdatePos()
	gohelper.setActive(slot0._goLoading, false)
	gohelper.setActive(slot0._goChessBG, true)
	gohelper.setActive(slot0._goChessEffect, true)
	slot0:setMaskActive(false)

	if LengZhou6GameModel.instance:getBattleModel() == LengZhou6Enum.BattleModel.infinite then
		if LengZhou6GameModel.instance:getEndLessBattleProgress() == LengZhou6Enum.BattleProgress.selectFinish then
			if not LengZhou6GameModel.instance:isFirstEnterLayer() then
				slot0:clearAllEffect()
			end

			LengZhou6GameModel.instance:recordChessData()
		end
	else
		LengZhou6Controller.instance:dispatchEvent(LengZhou6Event.EnterGameLevel, LengZhou6Model.instance:getCurEpisodeId())
	end

	slot0:changeTipState(true, false, true)
end

function slot0.onReleaseSkill(slot0, slot1)
	if not slot1:paramIsFull() then
		slot0._needReleaseSkill = slot1

		slot0:changeTipState(false, true, false)
	end
end

function slot0.setSkillParams(slot0, slot1, slot2)
	if slot0._needReleaseSkill ~= nil then
		slot0._needReleaseSkill:setParams(slot1, slot2)
	end

	if slot0._needReleaseSkill:paramIsFull() then
		slot0._needReleaseSkill:execute()

		slot0._needReleaseSkill = nil

		slot0:changeTipState(true, false, true)
	end
end

function slot0.cancelSkill(slot0)
	slot0._needReleaseSkill = nil

	slot0:changeTipState(true, false, true)
end

function slot0.OnShowAssess(slot0, slot1)
	if slot1 == nil then
		return
	end

	UISpriteSetMgr.instance:setHisSaBethSprite(slot0._imageAssess, EliminateEnum_2_7.AssessLevelToImageName[slot1], false)
	gohelper.setActive(slot0._goAssess, true)
	AudioMgr.instance:trigger(AudioEnum2_7.LengZhou6.play_ui_yuzhou_lzl_result)
	TaskDispatcher.runDelay(slot0.hideAssess, slot0, EliminateEnum_2_7.AssessShowTime)
end

function slot0.hideAssess(slot0)
	gohelper.setActive(slot0._goAssess, false)
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0.hideAssess, slot0)
	TaskDispatcher.cancelTask(slot0.checkTip, slot0)

	if slot0.effectPool ~= nil then
		slot0.effectPool:dispose()

		slot0.flyItemPool = nil
	end
end

function slot0.showEffect(slot0, slot1, slot2, slot3)
	if slot1 == nil or slot2 == nil or slot3 == nil then
		return
	end

	slot4 = slot0:getEffectIndex(slot1, slot2)

	if slot0._effectList == nil then
		slot0._effectList = slot0:getUserDataTb_()
	end

	if slot0._effectList[slot4] == nil then
		slot0._effectList[slot4] = slot0:getResInst(slot0.viewContainer:getSetting().otherRes[4], slot0._goChessEffect, "effect_" .. slot4)
	end

	slot0:updateEffectInfo(slot5, slot1, slot2, slot3)
	LocalEliminateChessModel.instance:recordSpEffect(slot1, slot2, slot3)
end

function slot0.hideEffect(slot0, slot1, slot2, slot3)
	if slot1 == nil or slot2 == nil or slot3 == nil or slot0._effectList == nil then
		return
	end

	if LocalEliminateChessModel.instance:getSpEffect(slot1, slot2) and slot3 == slot4 then
		if slot0._effectList[slot0:getEffectIndex(slot1, slot2)] ~= nil and slot3 == EliminateEnum_2_7.ChessEffect.frost then
			gohelper.findChild(slot6, "#image_sprite2"):GetComponent(typeof(UnityEngine.Animator)):Play("out", 0, 0)

			if slot0._needHidePos == nil then
				slot0._needHidePos = {}
			end

			table.insert(slot0._needHidePos, {
				slot1,
				slot2
			})
			TaskDispatcher.cancelTask(slot0._delayHideEffect, slot0)
			TaskDispatcher.runDelay(slot0._delayHideEffect, slot0, 0.5)
		else
			slot0:_realHideEffect(slot1, slot2)
		end
	end
end

function slot0._delayHideEffect(slot0)
	TaskDispatcher.cancelTask(slot0._delayHideEffect, slot0)

	if slot0._needHidePos == nil then
		return
	end

	for slot5 = 1, #slot0._needHidePos do
		slot6 = table.remove(slot0._needHidePos, 1)

		slot0:_realHideEffect(slot6[1], slot6[2])
	end
end

function slot0._realHideEffect(slot0, slot1, slot2)
	if slot0._effectList == nil then
		return
	end

	if slot0._effectList[slot0:getEffectIndex(slot1, slot2)] ~= nil then
		LocalEliminateChessModel.instance:recordSpEffect(slot1, slot2, nil)
		gohelper.setActive(slot0._effectList[slot3], false)
	end
end

function slot0.clearAllEffect(slot0)
	if slot0._effectList == nil then
		return
	end

	LocalEliminateChessModel.instance:clearAllEffect()

	for slot4, slot5 in pairs(slot0._effectList) do
		if slot5 ~= nil then
			gohelper.setActive(slot5, false)
			gohelper.destroy(slot5)
		end
	end

	if slot0._needHidePos ~= nil then
		tabletool.clear(slot0._needHidePos)
	end

	if slot0._effectList ~= nil then
		tabletool.clear(slot0._effectList)
	end
end

function slot0.getEffectIndex(slot0, slot1, slot2)
	return slot1 .. "_" .. slot2
end

function slot0.updateEffectInfo(slot0, slot1, slot2, slot3, slot4)
	if slot2 == nil or slot3 == nil or slot4 == nil then
		return
	end

	slot7 = slot4 == EliminateEnum_2_7.ChessEffect.frost

	gohelper.setActive(gohelper.findChildImage(slot1, "#image_sprite").gameObject, not slot7)
	gohelper.setActive(gohelper.findChildImage(slot1, "#image_sprite2").gameObject, slot7)

	slot8, slot9 = LocalEliminateChessUtils.instance.getChessPos(slot2, slot3)

	transformhelper.setLocalPosXY(slot1.transform, slot8, slot9)
	gohelper.setActive(slot1, true)
end

function slot0.updateTipTime(slot0)
	slot0._lastClickTime = os.time()
end

function slot0.checkTip(slot0)
	if slot0._lastClickTime == nil then
		slot0._lastClickTime = os.time()
	end

	if EliminateEnum.DotMoveTipInterval <= os.time() - slot0._lastClickTime then
		slot0:tip(true)
	end
end

function slot0.tip(slot0, slot1)
	if slot0._lastTipActive ~= nil and slot0._lastTipActive == slot1 then
		return
	end

	if slot1 and not slot0.canTip then
		return
	end

	if slot1 then
		if LocalEliminateChessModel.instance:canEliminate() and #slot2 >= 3 then
			for slot6 = 1, #slot2 do
				slot7 = slot2[slot6]

				if LengZhou6EliminateChessItemController.instance:getChessItem(slot7.x, slot7.y) ~= nil then
					slot10:toTip(slot1)
				end
			end
		end
	else
		for slot6 = 1, #LengZhou6EliminateChessItemController.instance:getChess() do
			for slot11 = 1, #slot2[slot6] do
				if slot7[slot11] ~= nil then
					slot12:toTip(slot1)
				end
			end
		end
	end

	slot0._lastTipActive = slot1
end

function slot0.changeTipState(slot0, slot1, slot2, slot3)
	slot0.canTip = slot1

	if slot2 then
		slot0:tip(false)

		slot0._lastClickTime = nil

		TaskDispatcher.cancelTask(slot0.checkTip, slot0)
	end

	if slot3 then
		slot0._lastClickTime = nil

		TaskDispatcher.cancelTask(slot0.checkTip, slot0)
		TaskDispatcher.runRepeat(slot0.checkTip, slot0, 1)
	end
end

function slot0.onDestroyView(slot0)
	if slot0._conTweenId then
		ZProj.TweenHelper.KillById(slot0._conTweenId)

		slot0._conTweenId = nil
	end

	slot0._needHidePos = nil

	TaskDispatcher.cancelTask(slot0._delayHideEffect, slot0)
	TaskDispatcher.cancelTask(slot0._showLoading, slot0)
	TaskDispatcher.cancelTask(slot0.checkTip, slot0)
end

return slot0
