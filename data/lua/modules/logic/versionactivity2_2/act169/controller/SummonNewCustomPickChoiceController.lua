module("modules.logic.versionactivity2_2.act169.controller.SummonNewCustomPickChoiceController", package.seeall)

local var_0_0 = class("SummonNewCustomPickChoiceController", BaseController)

function var_0_0.onSelectActivity(arg_1_0, arg_1_1)
	SummonNewCustomPickChoiceListModel.instance:initDatas(arg_1_1)

	arg_1_0._actId = arg_1_1

	arg_1_0:dispatchEvent(SummonNewCustomPickEvent.OnCustomPickListChanged)
end

function var_0_0.trySendChoice(arg_2_0)
	local var_2_0 = SummonNewCustomPickChoiceListModel.instance:getActivityId()
	local var_2_1 = ActivityModel.instance:getActMO(var_2_0)

	if not var_2_1 or not var_2_1:isOpen() or var_2_1:isExpired() then
		GameFacade.showToast(ToastEnum.ActivityNotInOpenTime)

		return false
	end

	local var_2_2 = SummonNewCustomPickChoiceListModel.instance:getSelectIds()

	if not var_2_2 then
		GameFacade.showToast(ToastEnum.SummonCustomPickOneMoreSelect)

		return false
	end

	local var_2_3 = SummonNewCustomPickChoiceListModel.instance:getMaxSelectCount()

	if var_2_3 > #var_2_2 then
		if var_2_3 == 1 then
			GameFacade.showToast(ToastEnum.SummonCustomPickOneMoreSelect)
		end

		return false
	end

	if SummonNewCustomPickViewModel.instance:isGetReward(var_2_0) then
		GameFacade.showToast(ToastEnum.ActivityRewardHasReceive)

		return false
	end

	local var_2_4 = arg_2_0:getSelectHeroNameStr(var_2_2)
	local var_2_5, var_2_6 = arg_2_0:getConfirmParam(var_2_2)

	GameFacade.showMessageBox(var_2_5, MsgBoxEnum.BoxType.Yes_No, arg_2_0.realSendChoice, nil, nil, arg_2_0, nil, nil, var_2_4, var_2_6)
end

function var_0_0.realSendChoice(arg_3_0)
	local var_3_0 = SummonNewCustomPickChoiceListModel.instance:getSelectIds()
	local var_3_1 = SummonNewCustomPickViewModel.instance:getCurActId()
	local var_3_2 = var_3_0[1]

	SummonNewCustomPickViewRpc.instance:sendAct169SummonRequest(var_3_1, var_3_2)
end

function var_0_0.trySendSummon(arg_4_0)
	local var_4_0 = SummonNewCustomPickChoiceListModel.instance:getActivityId()
	local var_4_1 = ActivityModel.instance:getActMO(var_4_0)

	if not var_4_1 or not var_4_1:isOpen() or var_4_1:isExpired() then
		GameFacade.showToast(ToastEnum.ActivityNotInOpenTime)

		return false
	end

	if SummonNewCustomPickViewModel.instance:isGetReward(var_4_0) then
		GameFacade.showToast(ToastEnum.ActivityRewardHasReceive)

		return false
	end

	local var_4_2 = SummonNewCustomPickViewModel.instance:isNewbiePoolExist() == false and MessageBoxIdDefine.Act167SummonNeTip or MessageBoxIdDefine.Act167SummonNewTipWithNewBiePool

	GameFacade.showMessageBox(var_4_2, MsgBoxEnum.BoxType.Yes_No, arg_4_0.realSendSummon, nil, nil, arg_4_0, nil, nil, var_4_1.config.name)
end

function var_0_0.realSendSummon(arg_5_0)
	local var_5_0 = SummonNewCustomPickViewModel.instance:getCurActId()

	CharacterModel.instance:setGainHeroViewShowState(true)
	SummonNewCustomPickViewRpc.instance:sendAct169SummonRequest(var_5_0, 0)
end

function var_0_0.getSelectHeroNameStr(arg_6_0, arg_6_1)
	local var_6_0 = ""

	for iter_6_0 = 1, #arg_6_1 do
		local var_6_1 = HeroConfig.instance:getHeroCO(arg_6_1[iter_6_0])

		if iter_6_0 == 1 then
			var_6_0 = var_6_1.name
		else
			var_6_0 = var_6_0 .. ", " .. var_6_1.name
		end
	end

	return var_6_0
end

function var_0_0.getConfirmParam(arg_7_0)
	local var_7_0 = SummonNewCustomPickViewModel.instance:getCurActId()
	local var_7_1 = ActivityConfig.instance:getActivityCo(var_7_0)

	return MessageBoxIdDefine.SummonLuckyBagSelectChar, var_7_1.name
end

function var_0_0.setSelect(arg_8_0, arg_8_1)
	local var_8_0 = SummonNewCustomPickChoiceListModel.instance:getSelectIds()
	local var_8_1 = SummonNewCustomPickViewModel.instance:getMaxSelectCount()

	if not SummonNewCustomPickChoiceListModel.instance:isHeroIdSelected(arg_8_1) and var_8_1 <= #var_8_0 and var_8_1 == 1 then
		SummonNewCustomPickChoiceListModel.instance:clearSelectIds()
	end

	SummonNewCustomPickChoiceListModel.instance:setSelectId(arg_8_1)
	arg_8_0:dispatchEvent(SummonNewCustomPickEvent.OnCustomPickListChanged)
end

function var_0_0.backPage(arg_9_0)
	arg_9_0:backHome()
	arg_9_0:checkRewardPop()
	NavigateMgr.instance:registerCallback(NavigateEvent.BeforeClickHome, arg_9_0.onClickHome, arg_9_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, arg_9_0.onCloseActivityPage, arg_9_0)
end

function var_0_0.onClickHome(arg_10_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, arg_10_0.onCloseActivityPage, arg_10_0)
end

function var_0_0.getCurrentListenViewName(arg_11_0)
	if SummonNewCustomPickChoiceListModel.instance:haveAllRole() then
		return ViewName.CommonPropView
	else
		return ViewName.CommonPropView
	end
end

function var_0_0.onCloseActivityPage(arg_12_0, arg_12_1)
	if arg_12_1 == arg_12_0:getCurrentListenViewName() then
		arg_12_0:startBlack()
		ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, arg_12_0.onOpenActivityPageFinish, arg_12_0)
		ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, arg_12_0.onCloseActivityPage, arg_12_0)

		local var_12_0 = ActivityConfig.instance:getActivityCo(arg_12_0._actId)
		local var_12_1 = var_12_0 and var_12_0.achievementJumpId

		if var_12_1 then
			JumpController.instance:jump(var_12_1)
		else
			ActivityController.instance:openActivityBeginnerView()
		end
	end
end

function var_0_0.onOpenActivityPageFinish(arg_13_0, arg_13_1)
	if arg_13_1 == ViewName.ActivityBeginnerView then
		arg_13_0:endBlack()
		ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, arg_13_0.onOpenActivityPage, arg_13_0)
	end
end

function var_0_0.backFullPage(arg_14_0)
	arg_14_0:backHome()
	arg_14_0:checkRewardPop()

	local var_14_0 = arg_14_0._actId
	local var_14_1 = {
		actId = var_14_0
	}

	var_14_1.refreshData = false

	PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.SummonNewCustomPickFullView, var_14_1)
end

function var_0_0.backHome(arg_15_0)
	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Main then
		MainController.instance:enterMainScene(true)
	end

	VirtualSummonScene.instance:close(true)
end

function var_0_0.setSummonReward(arg_16_0, arg_16_1)
	arg_16_0._summonReward = arg_16_1
end

function var_0_0.checkRewardPop(arg_17_0)
	if arg_17_0._summonReward and #arg_17_0._summonReward > 0 then
		arg_17_0:startBlack()
		ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, arg_17_0.onCommonPropViewOpenFinish, arg_17_0)
		RoomController.instance:popUpRoomBlockPackageView(arg_17_0._summonReward)
		PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.CommonPropView, arg_17_0._summonReward, true)
	end

	arg_17_0._summonReward = nil
end

function var_0_0.onCommonPropViewOpenFinish(arg_18_0, arg_18_1)
	if arg_18_1 == ViewName.CommonPropView then
		arg_18_0:endBlack()
		ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, arg_18_0.onCommonPropViewOpenFinish, arg_18_0)
	end
end

function var_0_0.startBlack(arg_19_0)
	ViewMgr.instance:openView(ViewName.LoadingBlackView, nil, true)
end

function var_0_0.endBlack(arg_20_0)
	ViewMgr.instance:closeView(ViewName.LoadingBlackView, true)
end

var_0_0.instance = var_0_0.New()

LuaEventSystem.addEventMechanism(var_0_0.instance)

return var_0_0
