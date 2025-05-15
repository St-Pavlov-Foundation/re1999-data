module("modules.logic.versionactivity2_5.challenge.view.enter.Act183DailyGroupEntranceItem", package.seeall)

local var_0_0 = class("Act183DailyGroupEntranceItem", Act183BaseGroupEntranceItem)
local var_0_1 = 7
local var_0_2 = 30

function var_0_0.Get(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = arg_1_2 and arg_1_2:getGroupType()
	local var_1_1 = "daily_" .. arg_1_3
	local var_1_2 = "root/right/#scroll_daily/Viewport/Content/" .. var_1_1
	local var_1_3 = gohelper.findChild(arg_1_0, var_1_2)

	if gohelper.isNil(var_1_3) then
		var_1_3 = gohelper.cloneInPlace(arg_1_1, var_1_1)
	end

	local var_1_4 = Act183Enum.GroupEntranceItemClsType[var_1_0]

	return MonoHelper.addNoUpdateLuaComOnceToGo(var_1_3, var_1_4, arg_1_3)
end

function var_0_0.init(arg_2_0, arg_2_1)
	var_0_0.super.init(arg_2_0, arg_2_1)

	arg_2_0._golock = gohelper.findChild(arg_2_1, "go_lock")
	arg_2_0._gounlock = gohelper.findChild(arg_2_1, "go_unlock")
	arg_2_0._goempty = gohelper.findChild(arg_2_1, "go_Empty")
	arg_2_0._gofinish = gohelper.findChild(arg_2_1, "go_unlock/go_Finished")
	arg_2_0._txtunlocktime = gohelper.findChildText(arg_2_1, "go_lock/txt_unlocktime")
	arg_2_0._txtindex = gohelper.findChildText(arg_2_1, "go_unlock/txt_index")
	arg_2_0._txtprogress = gohelper.findChildText(arg_2_1, "go_unlock/txt_progress")
	arg_2_0._btnclick = gohelper.findChildButtonWithAudio(arg_2_1, "btn_click")
	arg_2_0._animlock = gohelper.onceAddComponent(arg_2_0._golock, gohelper.Type_Animator)
	arg_2_0._animfinish = gohelper.onceAddComponent(arg_2_0._gofinish, gohelper.Type_Animator)
end

function var_0_0.addEventListeners(arg_3_0)
	var_0_0.super.addEventListeners(arg_3_0)
	arg_3_0._btnclick:AddClickListener(arg_3_0._btnclickOnClick, arg_3_0)
end

function var_0_0.removeEventListeners(arg_4_0)
	var_0_0.super.removeEventListeners(arg_4_0)
	arg_4_0._btnclick:RemoveClickListener()
	TaskDispatcher.cancelTask(arg_4_0.checkGroupUnlock, arg_4_0)
end

function var_0_0._btnclickOnClick(arg_5_0)
	if not arg_5_0._groupMo then
		return
	end

	if arg_5_0._status == Act183Enum.GroupStatus.Locked then
		GameFacade.showToast(ToastEnum.Act183GroupNotOpen)

		return
	end

	local var_5_0 = arg_5_0._groupMo:getGroupId()
	local var_5_1 = Act183Helper.generateDungeonViewParams(Act183Enum.GroupType.Daily, var_5_0)

	Act183Controller.instance:openAct183DungeonView(var_5_1)
end

function var_0_0.onUpdateMO(arg_6_0, arg_6_1)
	var_0_0.super.onUpdateMO(arg_6_0, arg_6_1)
	TaskDispatcher.cancelTask(arg_6_0.checkGroupUnlock, arg_6_0)

	local var_6_0 = arg_6_0._status == Act183Enum.GroupStatus.Locked

	if var_6_0 and arg_6_0._index > var_0_1 then
		arg_6_0:startCheckGroupUnlock()
		gohelper.setActive(arg_6_0.go, false)

		return
	end

	gohelper.setActive(arg_6_0.go, true)
	gohelper.setActive(arg_6_0._goempty, var_6_0)

	if var_6_0 then
		gohelper.setActive(arg_6_0._golock, false)
		gohelper.setActive(arg_6_0._gounlock, false)
		arg_6_0:startCheckGroupUnlock()

		return
	end

	local var_6_1 = arg_6_1:getGroupId()
	local var_6_2 = arg_6_1:getStatus() == Act183Enum.GroupStatus.Locked

	gohelper.setActive(arg_6_0._golock, var_6_2)
	gohelper.setActive(arg_6_0._gounlock, not var_6_2)

	local var_6_3 = false

	if var_6_2 then
		local var_6_4, var_6_5 = TimeUtil.secondToRoughTime(arg_6_1:getUnlockRemainTime())

		arg_6_0._txtunlocktime.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("v2a5_challenge_mainview_unlock"), var_6_4, var_6_5)
	else
		local var_6_6, var_6_7 = Act183Helper.getGroupEpisodeTaskProgress(arg_6_0._actId, var_6_1)
		local var_6_8 = var_6_6 <= var_6_7

		arg_6_0._txtindex.text = string.format("<color=#E1E1E14D>RT</color><color=#E1E1E180><size=77>%s</size></color>", arg_6_0._index)
		arg_6_0._txtprogress.text = string.format("%s/%s", var_6_7, var_6_6)

		gohelper.setActive(arg_6_0._gofinish, var_6_8)
	end
end

function var_0_0.startCheckGroupUnlock(arg_7_0)
	TaskDispatcher.cancelTask(arg_7_0.checkGroupUnlock, arg_7_0)
	TaskDispatcher.runRepeat(arg_7_0.checkGroupUnlock, arg_7_0, var_0_2)
end

function var_0_0.checkGroupUnlock(arg_8_0)
	if not arg_8_0._groupMo then
		TaskDispatcher.cancelTask(arg_8_0.checkGroupUnlock, arg_8_0)

		return
	end

	if arg_8_0._groupMo:getStatus() ~= Act183Enum.GroupStatus.Locked then
		arg_8_0:onUpdateMO(arg_8_0._groupMo)
	end
end

function var_0_0.startPlayUnlockAnim(arg_9_0)
	gohelper.setActive(arg_9_0._golock, true)
	arg_9_0._animlock:Play("unlock", 0, 0)
	arg_9_0:onPlayUnlockAnimDone()
end

return var_0_0
