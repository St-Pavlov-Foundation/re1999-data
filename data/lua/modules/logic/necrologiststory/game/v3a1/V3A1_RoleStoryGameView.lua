module("modules.logic.necrologiststory.game.v3a1.V3A1_RoleStoryGameView", package.seeall)

local var_0_0 = class("V3A1_RoleStoryGameView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.itemGO = gohelper.findChild(arg_1_0.viewGO, "Map/Content/go_mapitem")

	gohelper.setActive(arg_1_0.itemGO, false)

	arg_1_0.itemList = {}
	arg_1_0.goHero = gohelper.findChild(arg_1_0.viewGO, "Map/Content/go_hero")
	arg_1_0.heroComp = MonoHelper.addNoUpdateLuaComOnceToGo(arg_1_0.goHero, V3A1_RoleStoryGameHero)
	arg_1_0.goTitile = gohelper.findChild(arg_1_0.viewGO, "Map/Title")
	arg_1_0.animTitle = arg_1_0.goTitile:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0.txtPlace = gohelper.findChildTextMesh(arg_1_0.viewGO, "Map/Title/#txt_place")
	arg_1_0.txtTime = gohelper.findChildTextMesh(arg_1_0.viewGO, "Map/Title/#txt_time")
	arg_1_0.goNum = gohelper.findChild(arg_1_0.viewGO, "Map/Title/num")
	arg_1_0.txtNum = gohelper.findChildTextMesh(arg_1_0.viewGO, "Map/Title/num/#txt_num")
	arg_1_0.goTarget = gohelper.findChild(arg_1_0.viewGO, "#go_target")
	arg_1_0.animTarget = arg_1_0.goTarget:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0.txtTarget = gohelper.findChildTextMesh(arg_1_0.viewGO, "#go_target/taskDesc/txt_taskDesc")
	arg_1_0.goTargetFinished = gohelper.findChild(arg_1_0.viewGO, "#go_target/taskDesc/bg/go_finished")
	arg_1_0.goTargetUnFinish = gohelper.findChild(arg_1_0.viewGO, "#go_target/taskDesc/bg/go_unfinish")
	arg_1_0.btnReward = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_reward")
	arg_1_0.goRewardRed = gohelper.findChild(arg_1_0.viewGO, "#btn_reward/#go_reddot")
	arg_1_0.goRewardTime = gohelper.findChild(arg_1_0.viewGO, "#btn_reward/#go_time")
	arg_1_0.txtRewardTime = gohelper.findChildTextMesh(arg_1_0.viewGO, "#btn_reward/#go_time/#txt_time")
	arg_1_0.txtRewardTimeFormat = gohelper.findChildTextMesh(arg_1_0.viewGO, "#btn_reward/#go_time/#txt_time/#txt_format")
	arg_1_0.btnReview = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_review")
	arg_1_0.fogList = {}

	for iter_1_0 = 1, 4 do
		local var_1_0 = arg_1_0:getUserDataTb_()

		var_1_0.goFog = gohelper.findChild(arg_1_0.viewGO, string.format("Map/fog/#fog%02d", iter_1_0))
		var_1_0.animFog = var_1_0.goFog:GetComponent(typeof(UnityEngine.Animator))

		table.insert(arg_1_0.fogList, var_1_0)
	end

	arg_1_0:initLineList()

	arg_1_0.imageWeather = gohelper.findChildImage(arg_1_0.viewGO, "Map/Title/#image_weather")
	arg_1_0.goFinish = gohelper.findChild(arg_1_0.viewGO, "#go_finish")
	arg_1_0.animFinish = arg_1_0.goFinish:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0.btnReset = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_reset")
end

function var_0_0.initLineList(arg_2_0)
	arg_2_0.lineList = {}

	local var_2_0 = gohelper.findChild(arg_2_0.viewGO, "Map/#go_line_light").transform
	local var_2_1 = var_2_0.childCount

	for iter_2_0 = 1, var_2_1 do
		local var_2_2 = var_2_0:GetChild(iter_2_0 - 1)
		local var_2_3, var_2_4 = arg_2_0:extractNumbers(var_2_2.name)

		if var_2_3 and var_2_4 then
			local var_2_5 = arg_2_0:getUserDataTb_()

			var_2_5.baseId1 = var_2_3
			var_2_5.baseId2 = var_2_4
			var_2_5.goLine = var_2_2.gameObject

			table.insert(arg_2_0.lineList, var_2_5)
		end
	end
end

function var_0_0.extractNumbers(arg_3_0, arg_3_1)
	local var_3_0, var_3_1 = string.match(arg_3_1, "^line(%d+)_(%d+)$")

	if var_3_0 and var_3_1 then
		return tonumber(var_3_0), tonumber(var_3_1)
	end

	return nil, nil
end

function var_0_0.addEvents(arg_4_0)
	arg_4_0:addEventCb(NecrologistStoryController.instance, NecrologistStoryEvent.V3A1_GameReset, arg_4_0._onGameReset, arg_4_0)
	arg_4_0:addEventCb(NecrologistStoryController.instance, NecrologistStoryEvent.V3A1_MoveToBase, arg_4_0._onMoveToBase, arg_4_0)
	arg_4_0:addEventCb(NecrologistStoryController.instance, NecrologistStoryEvent.V3A1_UnlockArea, arg_4_0._onUnlockArea, arg_4_0)
	arg_4_0:addEventCb(NecrologistStoryController.instance, NecrologistStoryEvent.OnStoryStateChange, arg_4_0._onStoryStateChange, arg_4_0)
	arg_4_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_4_0._onCloseViewFinish, arg_4_0)
	arg_4_0:addClickCb(arg_4_0.btnReward, arg_4_0.onClickBtnReward, arg_4_0)
	arg_4_0:addClickCb(arg_4_0.btnReview, arg_4_0.onClickBtnReview, arg_4_0)
	arg_4_0:addClickCb(arg_4_0.btnReset, arg_4_0.onClickBtnReset, arg_4_0)
end

function var_0_0.removeEvents(arg_5_0)
	arg_5_0:removeEventCb(NecrologistStoryController.instance, NecrologistStoryEvent.V3A1_GameReset, arg_5_0._onGameReset, arg_5_0)
	arg_5_0:removeEventCb(NecrologistStoryController.instance, NecrologistStoryEvent.V3A1_MoveToBase, arg_5_0._onMoveToBase, arg_5_0)
	arg_5_0:removeEventCb(NecrologistStoryController.instance, NecrologistStoryEvent.V3A1_UnlockArea, arg_5_0._onUnlockArea, arg_5_0)
	arg_5_0:removeEventCb(NecrologistStoryController.instance, NecrologistStoryEvent.OnStoryStateChange, arg_5_0._onStoryStateChange, arg_5_0)
	arg_5_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_5_0._onCloseViewFinish, arg_5_0)
	arg_5_0:removeClickCb(arg_5_0.btnReward)
	arg_5_0:removeClickCb(arg_5_0.btnReview)
	arg_5_0:removeClickCb(arg_5_0.btnReset)
end

function var_0_0.onClickBtnReset(arg_6_0)
	MessageBoxController.instance:showSystemMsgBox(MessageBoxIdDefine.V3A1NecrologistStory_ResetGame, MsgBoxEnum.BoxType.Yes_No, arg_6_0.resetGameProgress, nil, nil, arg_6_0)
end

function var_0_0.resetGameProgress(arg_7_0)
	if not arg_7_0.gameBaseMO then
		return
	end

	arg_7_0.gameBaseMO:resetProgressByFail()
end

function var_0_0.onClickBtnReward(arg_8_0)
	if not arg_8_0.gameBaseMO then
		return
	end

	NecrologistStoryController.instance:openTaskView(arg_8_0.gameBaseMO.id)
end

function var_0_0.onClickBtnReview(arg_9_0)
	if not arg_9_0.gameBaseMO then
		return
	end

	NecrologistStoryController.instance:openReviewView(arg_9_0.gameBaseMO.id)
end

function var_0_0._onGameReset(arg_10_0)
	NecrologistStoryStatController.instance:startGameStat()

	arg_10_0._lastTime = nil

	arg_10_0:refreshView()
end

function var_0_0._onStoryStateChange(arg_11_0, arg_11_1)
	arg_11_0:refreshGameState()
	arg_11_0:onStoryStateChangeRefresh()
end

function var_0_0.onStoryStateChangeRefresh(arg_12_0)
	if not ViewHelper.instance:checkViewOnTheTop(arg_12_0.viewName) then
		arg_12_0._waitRefreshState = true

		return
	end

	arg_12_0._waitRefreshState = nil

	arg_12_0:refreshBaseItemList()
	arg_12_0:refreshButton()
end

function var_0_0._onCloseViewFinish(arg_13_0, arg_13_1)
	arg_13_0:refreshRewardTime()

	if arg_13_0._waitRefreshState then
		arg_13_0:onStoryStateChangeRefresh()
	end

	if arg_13_0._waitUnlockAreaId then
		arg_13_0:unlockArea(arg_13_0._waitUnlockAreaId)
	end

	if arg_13_0.waitPlayFinishAnim then
		arg_13_0:refreshFinish(true)
	end
end

function var_0_0._onMoveToBase(arg_14_0, arg_14_1)
	arg_14_0:moveToBase(arg_14_1, true, arg_14_0.onMoveBaseEnd, arg_14_0)
	arg_14_0:refreshBaseItemList()
	arg_14_0:refreshTitle()
	arg_14_0:refreshTask()
	arg_14_0:refreshGameState()
end

function var_0_0.onMoveBaseEnd(arg_15_0)
	local var_15_0 = arg_15_0.gameBaseMO:getCurBaseId()

	for iter_15_0, iter_15_1 in pairs(arg_15_0.itemList) do
		if iter_15_1.baseConfig and iter_15_1.baseConfig.id == var_15_0 then
			local var_15_1 = arg_15_0.gameBaseMO:isBaseEntered(var_15_0)

			if not var_15_1 then
				arg_15_0.gameBaseMO:setBaseEntered(var_15_0)
			end

			if iter_15_1.baseConfig.storyId > 0 and not var_15_1 then
				TipDialogController.instance:openTipDialogView(iter_15_1.baseConfig.storyId, iter_15_1.onClickBtn, iter_15_1)

				break
			end

			iter_15_1:onClickBtn()

			break
		end
	end
end

function var_0_0._onUnlockArea(arg_16_0, arg_16_1)
	arg_16_0:unlockArea(arg_16_1)
end

function var_0_0.unlockArea(arg_17_0, arg_17_1)
	if not ViewHelper.instance:checkViewOnTheTop(arg_17_0.viewName) then
		arg_17_0._waitUnlockAreaId = arg_17_1

		return
	end

	arg_17_0._waitUnlockAreaId = nil

	AudioMgr.instance:trigger(AudioEnum.NecrologistStory.play_ui_shuori_start_1)
	arg_17_0:refreshBaseItemList()
	arg_17_0:refreshFog(arg_17_1)
	arg_17_0:refreshLine()

	arg_17_0._waitMoveAreaId = arg_17_1

	TaskDispatcher.cancelTask(arg_17_0._moveToArea, arg_17_0)
	TaskDispatcher.runDelay(arg_17_0._moveToArea, arg_17_0, 1)
end

function var_0_0._moveToArea(arg_18_0)
	local var_18_0 = arg_18_0._waitMoveAreaId

	arg_18_0._waitMoveAreaId = nil

	if not var_18_0 then
		return
	end

	local var_18_1 = NecrologistStoryV3A1Config.instance:getBigBaseInArea(var_18_0)

	if var_18_1 then
		local var_18_2 = NecrologistStoryV3A1Config.instance:getFugaorenBaseCo(var_18_1)

		arg_18_0.gameBaseMO:setTime(var_18_2.startTime)
		arg_18_0.gameBaseMO:setCurBaseId(var_18_1)
	end
end

function var_0_0.onOpen(arg_19_0)
	NecrologistStoryStatController.instance:startGameStat()
	arg_19_0:refreshData()
	arg_19_0:refreshView()
end

function var_0_0.refreshData(arg_20_0)
	local var_20_0 = arg_20_0.viewParam.roleStoryId

	arg_20_0.gameBaseMO = NecrologistStoryModel.instance:getGameMO(var_20_0)

	arg_20_0.gameBaseMO:setIsExitGame(false)
	RedDotController.instance:addRedDot(arg_20_0.goRewardRed, RedDotEnum.DotNode.NecrologistStoryTask, var_20_0)
end

function var_0_0.refreshView(arg_21_0)
	arg_21_0:refreshBaseItemList()
	arg_21_0:refreshHero()
	arg_21_0:refreshFog()
	arg_21_0:refreshTitle()
	arg_21_0:refreshTask()
	arg_21_0:refreshButton()
	arg_21_0:refreshRewardTime()
	arg_21_0:refreshFinish()
end

function var_0_0.refreshHero(arg_22_0)
	local var_22_0 = arg_22_0.gameBaseMO:getCurBaseId()

	arg_22_0:moveToBase(var_22_0)

	local var_22_1 = NecrologistStoryV3A1Config.instance:getFugaorenBaseCo(var_22_0)

	if var_22_1.unlockAreaId > 0 and arg_22_0.gameBaseMO:isAreaUnlock(var_22_1.unlockAreaId) then
		arg_22_0._waitMoveAreaId = var_22_1.unlockAreaId

		TaskDispatcher.cancelTask(arg_22_0._moveToArea, arg_22_0)
		TaskDispatcher.runDelay(arg_22_0._moveToArea, arg_22_0, 1)
	end
end

function var_0_0.moveToBase(arg_23_0, arg_23_1, arg_23_2, arg_23_3, arg_23_4)
	local var_23_0 = gohelper.findChild(arg_23_0.viewGO, string.format("Map/Content/go_item%s", arg_23_1))
	local var_23_1, var_23_2 = recthelper.getAnchor(var_23_0.transform)

	arg_23_0.heroComp:setHeroPos(var_23_1, var_23_2, arg_23_2, arg_23_3, arg_23_4)
end

function var_0_0.refreshBaseItemList(arg_24_0)
	local var_24_0 = NecrologistStoryV3A1Config.instance:getBaseList()

	for iter_24_0, iter_24_1 in ipairs(var_24_0) do
		arg_24_0:getOrCreateItem(iter_24_1.id):refreshView(iter_24_1, arg_24_0.gameBaseMO)
	end

	arg_24_0:refreshLine()
end

function var_0_0.getOrCreateItem(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_0.itemList[arg_25_1]

	if not var_25_0 then
		local var_25_1 = gohelper.findChild(arg_25_0.viewGO, string.format("Map/Content/go_item%s", arg_25_1))
		local var_25_2 = gohelper.clone(arg_25_0.itemGO, var_25_1, "go_mapitem")

		var_25_0 = MonoHelper.addNoUpdateLuaComOnceToGo(var_25_2, V3A1_RoleStoryGameBaseItem)
		arg_25_0.itemList[arg_25_1] = var_25_0
	end

	return var_25_0
end

function var_0_0.refreshLine(arg_26_0)
	local var_26_0 = false

	for iter_26_0, iter_26_1 in ipairs(arg_26_0.lineList) do
		local var_26_1 = arg_26_0.itemList[iter_26_1.baseId1]
		local var_26_2 = arg_26_0.itemList[iter_26_1.baseId2]
		local var_26_3 = var_26_1:getIsVisible() and var_26_2:getIsVisible()

		gohelper.setActive(iter_26_1.goLine, var_26_3)

		if iter_26_1.visible ~= nil and iter_26_1.visible ~= var_26_3 then
			var_26_0 = true
		end

		iter_26_1.visible = var_26_3
	end

	if var_26_0 then
		AudioMgr.instance:trigger(AudioEnum.NecrologistStory.play_ui_artificial_ui_entrance)
	end
end

function var_0_0.refreshFog(arg_27_0, arg_27_1)
	for iter_27_0, iter_27_1 in ipairs(arg_27_0.fogList) do
		if arg_27_1 == iter_27_0 then
			iter_27_1.animFog:Play("close", 0, 0)
		elseif arg_27_0.gameBaseMO:isAreaUnlock(iter_27_0) then
			iter_27_1.animFog:Play("none", 0, 0)
		else
			iter_27_1.animFog:Play("idle", 0, 0)
		end
	end
end

function var_0_0.refreshTitle(arg_28_0)
	local var_28_0 = arg_28_0.gameBaseMO:getCurBaseId()
	local var_28_1 = arg_28_0.gameBaseMO:getCurTime()

	if arg_28_0._lastTitleBaseId and arg_28_0._lastTitleBaseId ~= var_28_0 then
		arg_28_0.animTitle:Play("switch", 0, 0)
		TaskDispatcher.cancelTask(arg_28_0._refreshTitle, arg_28_0)
		TaskDispatcher.runDelay(arg_28_0._refreshTitle, arg_28_0, 0.15)
	else
		arg_28_0:_refreshTitle()
	end

	arg_28_0._lastTitleBaseId = var_28_0

	if arg_28_0._lastTime and arg_28_0._lastTime ~= var_28_1 then
		local var_28_2 = var_28_1 - arg_28_0._lastTime
		local var_28_3 = math.floor(var_28_2)
		local var_28_4 = math.floor((var_28_2 - var_28_3) * 60)

		if var_28_3 > 0 then
			if var_28_4 > 0 then
				arg_28_0.txtNum.text = string.format("+%sh%sm", var_28_3, var_28_4)
			else
				arg_28_0.txtNum.text = string.format("+%sh", var_28_3)
			end
		else
			arg_28_0.txtNum.text = string.format("+%sm", var_28_4)
		end

		gohelper.setActive(arg_28_0.goNum, false)
		gohelper.setActive(arg_28_0.goNum, true)
	end

	arg_28_0._lastTime = var_28_1
end

function var_0_0._refreshTitle(arg_29_0)
	local var_29_0 = arg_29_0.gameBaseMO:getCurBaseId()
	local var_29_1 = arg_29_0.gameBaseMO:getCurTime()
	local var_29_2 = NecrologistStoryV3A1Config.instance:getFugaorenBaseCo(var_29_0)
	local var_29_3, var_29_4 = NecrologistStoryHelper.getTimeFormat2(var_29_1)

	arg_29_0.txtTime.text = string.format("%d:%02d", var_29_3, var_29_4)
	arg_29_0.txtPlace.text = var_29_2.name

	local var_29_5 = var_29_2.weather

	if var_29_5 and var_29_5 > 0 then
		gohelper.setActive(arg_29_0.imageWeather, true)

		if var_29_5 < NecrologistStoryEnum.WeatherType.Flow then
			UISpriteSetMgr.instance:setRoleStorySprite(arg_29_0.imageWeather, string.format("rolestory_weather%s", var_29_5))
		end
	else
		gohelper.setActive(arg_29_0.imageWeather, false)
	end
end

function var_0_0.refreshTask(arg_30_0)
	local var_30_0 = arg_30_0.gameBaseMO:getCurTargetData()

	if not var_30_0 then
		gohelper.setActive(arg_30_0.goTarget, false)

		return
	end

	gohelper.setActive(arg_30_0.goTarget, true)

	local var_30_1 = var_30_0.config.id

	if arg_30_0._targetId and arg_30_0._targetId ~= var_30_1 then
		if var_30_0.isEnter and not var_30_0.isFail then
			arg_30_0.animTarget:Play("finish", 0, 0)
		else
			arg_30_0.animTarget:Play("open", 0, 0)
		end

		TaskDispatcher.cancelTask(arg_30_0._refreshTask, arg_30_0)
		TaskDispatcher.runDelay(arg_30_0._refreshTask, arg_30_0, 0.16)
	else
		arg_30_0:_refreshTask()
	end

	arg_30_0._targetId = var_30_1
end

function var_0_0._refreshTask(arg_31_0)
	local var_31_0 = arg_31_0.gameBaseMO:getCurTargetData()

	if not var_31_0 then
		gohelper.setActive(arg_31_0.goTarget, false)

		return
	end

	gohelper.setActive(arg_31_0.goTarget, true)

	local var_31_1, var_31_2 = NecrologistStoryHelper.getTimeFormat2(var_31_0.config.endTime)
	local var_31_3 = string.format("%d:%02d", var_31_1, var_31_2)

	arg_31_0.txtTarget.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("v3a1_necrologiststory_target_txt"), var_31_3, var_31_0.config.name)

	local var_31_4 = not var_31_0.isFail and var_31_0.isEnter

	gohelper.setActive(arg_31_0.goTargetFinished, var_31_4)
	gohelper.setActive(arg_31_0.goTargetUnFinish, not var_31_4)
end

function var_0_0.refreshButton(arg_32_0)
	local var_32_0 = NecrologistStoryModel.instance:isReviewCanShow(arg_32_0.gameBaseMO.id)

	gohelper.setActive(arg_32_0.btnReview, var_32_0)
end

function var_0_0.refreshGameState(arg_33_0)
	if not arg_33_0.gameBaseMO then
		return
	end

	local var_33_0 = arg_33_0.gameBaseMO:getGameState()

	if var_33_0 == NecrologistStoryEnum.GameState.Win then
		arg_33_0:statSettlement(StatEnum.Result.Success)
		ViewMgr.instance:openView(ViewName.V3A1_RoleStorySuccessView, {
			roleStoryId = arg_33_0.gameBaseMO.id
		})
	elseif var_33_0 == NecrologistStoryEnum.GameState.Fail then
		arg_33_0:statSettlement(StatEnum.Result.Fail)
		ViewMgr.instance:openView(ViewName.V3A1_RoleStoryFailView, {
			roleStoryId = arg_33_0.gameBaseMO.id
		})
	end

	arg_33_0:refreshFinish(true)
end

function var_0_0.refreshFinish(arg_34_0, arg_34_1)
	if not arg_34_0.gameBaseMO then
		return
	end

	arg_34_0.waitPlayFinishAnim = nil

	local var_34_0 = arg_34_0.gameBaseMO:getGameState() == NecrologistStoryEnum.GameState.Win

	gohelper.setActive(arg_34_0.goFinish, var_34_0)
	gohelper.setActive(arg_34_0.goHero, not var_34_0)

	local var_34_1 = not var_34_0 and arg_34_0.gameBaseMO:canReset()

	gohelper.setActive(arg_34_0.btnReset, var_34_1)

	if arg_34_1 and var_34_0 then
		if ViewHelper.instance:checkViewOnTheTop(arg_34_0.viewName) then
			arg_34_0.animFinish:Play("open", 0, 0)
			AudioMgr.instance:trigger(AudioEnum.NecrologistStory.play_ui_note_course_finish)
		else
			arg_34_0.waitPlayFinishAnim = true
		end
	end
end

function var_0_0.showBlock(arg_35_0)
	GameUtil.setActiveUIBlock(arg_35_0.viewName, true, false)
end

function var_0_0.closeBlock(arg_36_0)
	GameUtil.setActiveUIBlock(arg_36_0.viewName, false, false)
end

function var_0_0.statSettlement(arg_37_0, arg_37_1)
	if not arg_37_0.gameBaseMO then
		return
	end

	local var_37_0 = arg_37_0.gameBaseMO:getCurTime()
	local var_37_1, var_37_2 = NecrologistStoryHelper.getTimeFormat2(var_37_0)
	local var_37_3 = {
		heroStoryId = arg_37_0.gameBaseMO.id,
		baseId = arg_37_0.gameBaseMO:getCurBaseId(),
		time = string.format("%d:%02d", var_37_1, var_37_2)
	}

	NecrologistStoryStatController.instance:statStorySettlement(var_37_3, arg_37_1)
end

function var_0_0.refreshRewardTime(arg_38_0)
	local var_38_0 = NecrologistStoryTaskListModel.instance:hasLimitTaskNotFinish(arg_38_0.gameBaseMO.id)

	gohelper.setActive(arg_38_0.goRewardTime, var_38_0)

	if not var_38_0 then
		return
	end

	TaskDispatcher.cancelTask(arg_38_0._frameRefreshRewardTime, arg_38_0)
	TaskDispatcher.runDelay(arg_38_0._frameRefreshRewardTime, arg_38_0, 1)
	arg_38_0:_frameRefreshRewardTime()
end

function var_0_0._frameRefreshRewardTime(arg_39_0)
	if not arg_39_0.gameBaseMO then
		return
	end

	local var_39_0 = RoleStoryConfig.instance:getStoryById(arg_39_0.gameBaseMO.id).activityId
	local var_39_1 = ActivityModel.instance:getActMO(var_39_0)

	if not var_39_1 then
		return
	end

	local var_39_2 = var_39_1:getRealEndTimeStamp() - ServerTime.now()

	if var_39_2 > 0 then
		local var_39_3, var_39_4 = TimeUtil.secondToRoughTime2(var_39_2, true)

		arg_39_0.txtRewardTime.text = var_39_3
		arg_39_0.txtRewardTimeFormat.text = var_39_4
	else
		gohelper.setActive(arg_39_0.goRewardTime, false)
		TaskDispatcher.cancelTask(arg_39_0._frameRefreshRewardTime, arg_39_0)
	end
end

function var_0_0.onClose(arg_40_0)
	if arg_40_0.gameBaseMO:getGameState() == NecrologistStoryEnum.GameState.Normal and not arg_40_0.gameBaseMO:getIsExitGame() then
		arg_40_0:statSettlement(StatEnum.Result.Abort)
	end

	arg_40_0.gameBaseMO:setIsExitGame(false)
end

function var_0_0.onDestroyView(arg_41_0)
	TaskDispatcher.cancelTask(arg_41_0._frameRefreshRewardTime, arg_41_0)
	TaskDispatcher.cancelTask(arg_41_0._refreshTask, arg_41_0)
	TaskDispatcher.cancelTask(arg_41_0._moveToArea, arg_41_0)
	TaskDispatcher.cancelTask(arg_41_0._refreshTitle, arg_41_0)
end

return var_0_0
