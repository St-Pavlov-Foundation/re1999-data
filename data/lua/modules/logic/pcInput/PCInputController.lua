module("modules.logic.pcInput.PCInputController", package.seeall)

local var_0_0 = class("PCInputController", BaseController)

function var_0_0.onInit(arg_1_0)
	arg_1_0.Adapters = arg_1_0.Adapters or {}
	arg_1_0.eventMgr = ZProj.GamepadEvent

	arg_1_0.eventMgr.Instance:AddLuaLisenter(arg_1_0.eventMgr.UpKey, arg_1_0.OnKeyUp, arg_1_0)
	arg_1_0.eventMgr.Instance:AddLuaLisenter(arg_1_0.eventMgr.DownKey, arg_1_0.OnKeyDown, arg_1_0)

	arg_1_0.inputInst = ZProj.PCInputManager.Instance

	if not arg_1_0:getIsUse() then
		arg_1_0.init = false
	else
		arg_1_0.init = true
	end

	logNormal("PCInputController:onInit()" .. tostring(arg_1_0.init))
end

function var_0_0.getIsUse(arg_2_0)
	if ZProj.PCInputManager and ZProj.PCInputManager.Instance:isWindows() then
		if UnityEngine.Application.isEditor then
			return UnityEngine.PlayerPrefs.GetInt("PCInputSwitch", 0) == 1
		else
			return true
		end
	end

	return false
end

function var_0_0.Switch(arg_3_0)
	arg_3_0.init = arg_3_0:getIsUse()
end

function var_0_0.getCurrentPresskey(arg_4_0)
	if arg_4_0.init then
		return arg_4_0.inputInst:getCurrentPresskey()
	end

	return nil
end

function var_0_0.onInitFinish(arg_5_0)
	return
end

function var_0_0.reInit(arg_6_0)
	return
end

function var_0_0.addConstEvents(arg_7_0)
	arg_7_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_7_0.onOpenViewCallBack, arg_7_0)
	arg_7_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_7_0.onCloseViewCallBack, arg_7_0)
end

function var_0_0.onOpenViewCallBack(arg_8_0, arg_8_1)
	TaskDispatcher.runDelay(function()
		if arg_8_1 == ViewName.MainView then
			if arg_8_0.Adapters[PCInputModel.Activity.MainActivity] == nil then
				arg_8_0.Adapters[PCInputModel.Activity.MainActivity] = MainActivityAdapter.New()
			end
		elseif arg_8_1 == ViewName.ExploreView then
			if arg_8_0.Adapters[PCInputModel.Activity.thrityDoor] == nil then
				arg_8_0.Adapters[PCInputModel.Activity.thrityDoor] = ThirdDoorActivtiyAdapter.New()
			end
		elseif arg_8_1 == ViewName.FightView then
			if arg_8_0.Adapters[PCInputModel.Activity.battle] == nil then
				arg_8_0.Adapters[PCInputModel.Activity.battle] = BattleActivityAdapter.New()
			end
		elseif arg_8_1 == ViewName.RoomView then
			if arg_8_0.Adapters[PCInputModel.Activity.room] == nil then
				arg_8_0.Adapters[PCInputModel.Activity.room] = RoomActivityAdapter.New()
			end
		elseif arg_8_1 == ViewName.WeekWalkDialogView or arg_8_1 == ViewName.StoryFrontView or arg_8_1 == ViewName.ExploreInteractView or arg_8_1 == ViewName.RoomBranchView or arg_8_1.StoryBranchView then
			if arg_8_0.Adapters[PCInputModel.Activity.storyDialog] == nil then
				arg_8_0.Adapters[PCInputModel.Activity.storyDialog] = StoryDialogAdapter.New()
			end
		elseif (arg_8_1 == ViewName.MessageBoxView or arg_8_1 == ViewName.TopMessageBoxView or arg_8_1 == ViewName.SDKExitGameView or arg_8_1 == ViewName.FightQuitTipView) and arg_8_0.Adapters[PCInputModel.Activity.CommonDialog] == nil then
			arg_8_0.Adapters[PCInputModel.Activity.CommonDialog] = CommonActivityAdapter.New()
		end
	end, arg_8_0, 0.01)
end

function var_0_0.onCloseViewCallBack(arg_10_0, arg_10_1)
	TaskDispatcher.runDelay(function()
		if arg_10_1 == ViewName.MainView then
			arg_10_0:_removeAdapter(PCInputModel.Activity.MainActivity)
		elseif arg_10_1 == ViewName.ExploreView then
			arg_10_0:_removeAdapter(PCInputModel.Activity.thrityDoor)
		elseif arg_10_1 == ViewName.FightView then
			arg_10_0:_removeAdapter(PCInputModel.Activity.battle)
		elseif arg_10_1 == ViewName.RoomView then
			arg_10_0:_removeAdapter(PCInputModel.Activity.room)
		elseif arg_10_1 == ViewName.WeekWalkDialogView or arg_10_1 == ViewName.StoryFrontView or arg_10_1 == ViewName.ExploreInteractView or arg_10_1 == ViewName.RoomBranchView or arg_10_1.StoryBranchView then
			arg_10_0:_removeAdapter(PCInputModel.Activity.storyDialog)
		elseif arg_10_1 == ViewName.MessageBoxView or arg_10_1 == ViewName.TopMessageBoxView or arg_10_1 == ViewName.SDKExitGameView or arg_10_1 == ViewName.FightQuitTipView then
			arg_10_0:_removeAdapter(PCInputModel.Activity.CommonDialog)
		elseif arg_10_1 == ViewName.SettingsView then
			arg_10_0:ReRegisterKeys()
		end
	end, arg_10_0, 0.01)
end

function var_0_0.ReRegisterKeys(arg_12_0)
	for iter_12_0, iter_12_1 in pairs(arg_12_0.Adapters) do
		if iter_12_1 then
			iter_12_1:unRegisterFunction()
			iter_12_1:registerFunction()
		end
	end
end

function var_0_0._removeAdapter(arg_13_0, arg_13_1)
	if arg_13_0.Adapters[arg_13_1] then
		arg_13_0.Adapters[arg_13_1]:destroy()

		arg_13_0.Adapters[arg_13_1] = nil
	end
end

function var_0_0.registerKey(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_1 and arg_14_0.inputInst then
		arg_14_0.inputInst:RegisterKey(arg_14_1, arg_14_2)
	end
end

function var_0_0.unregisterKey(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_1 and arg_15_0.inputInst then
		arg_15_0.inputInst:UnregisterKey(arg_15_1, arg_15_2)
	end
end

function var_0_0.registerKeys(arg_16_0, arg_16_1, arg_16_2)
	if arg_16_1 and arg_16_0.inputInst then
		for iter_16_0, iter_16_1 in pairs(arg_16_1) do
			if iter_16_1 then
				arg_16_0.inputInst:RegisterKey(iter_16_1, arg_16_2)
			end
		end
	end
end

function var_0_0.unregisterKeys(arg_17_0, arg_17_1, arg_17_2)
	if arg_17_1 and arg_17_0.inputInst then
		for iter_17_0, iter_17_1 in pairs(arg_17_1) do
			if iter_17_1 then
				arg_17_0.inputInst:UnregisterKey(iter_17_1, arg_17_2)
			end
		end
	end
end

function var_0_0.getKeyPress(arg_18_0, arg_18_1)
	if arg_18_0.init and arg_18_0.inputInst and not ViewMgr.instance:isOpen(ViewName.GuideView) then
		return arg_18_0.inputInst:getKeyPress(arg_18_1)
	end

	return false
end

function var_0_0.getActivityFunPress(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = PCInputModel.instance:getActivityKeys(arg_19_1)

	if var_19_0 then
		local var_19_1 = var_19_0[arg_19_2]

		if var_19_1 then
			return arg_19_0:getKeyPress(var_19_1[4])
		else
			return false
		end
	end

	return false
end

function var_0_0.OnKeyDown(arg_20_0, arg_20_1)
	if not arg_20_0.init or not arg_20_0.inputInst then
		return
	end

	if ViewMgr.instance:isOpen(ViewName.GuideView) or ViewMgr.instance:isOpen(ViewName.SettingsView) then
		return
	end

	local var_20_0 = arg_20_0.inputInst:keyCodeToKey(arg_20_1)

	for iter_20_0, iter_20_1 in pairs(arg_20_0.Adapters) do
		if iter_20_1 then
			iter_20_1:OnkeyDown(var_20_0)
		end
	end
end

function var_0_0.OnKeyUp(arg_21_0, arg_21_1)
	if not arg_21_0.init or not arg_21_0.inputInst then
		return
	end

	if ViewMgr.instance:isOpen(ViewName.GuideView) then
		return
	end

	local var_21_0 = arg_21_0.inputInst:keyCodeToKey(arg_21_1)

	for iter_21_0, iter_21_1 in pairs(arg_21_0.Adapters) do
		if iter_21_1 then
			iter_21_1:OnkeyUp(var_21_0)
		end
	end
end

function var_0_0.getThirdMoveKey(arg_22_0)
	return PCInputModel.instance:getThirdDoorMoveKey()
end

function var_0_0.getKeyMap(arg_23_0)
	local var_23_0 = PCInputModel.instance:getKeyBinding()

	return LuaUtil.deepCopy(var_23_0)
end

function var_0_0.saveKeyMap(arg_24_0, arg_24_1)
	PCInputModel.instance:Save(arg_24_1)
end

function var_0_0.showkeyTips(arg_25_0, arg_25_1, arg_25_2, arg_25_3, arg_25_4)
	if arg_25_1 == nil or not arg_25_0.init then
		return
	end

	local var_25_0 = MonoHelper.addLuaComOnceToGo(arg_25_1, keyTipsView, {
		keyname = arg_25_4,
		activityId = arg_25_2,
		keyid = arg_25_3
	})

	if not arg_25_4 then
		var_25_0:Refresh(arg_25_2, arg_25_3)
	else
		var_25_0:RefreshByKeyName(arg_25_4)
	end

	return var_25_0
end

function var_0_0.KeyNameToDescName(arg_26_0, arg_26_1)
	return PCInputModel.instance:ReplaceKeyName(arg_26_1)
end

var_0_0.instance = var_0_0.New()

return var_0_0
