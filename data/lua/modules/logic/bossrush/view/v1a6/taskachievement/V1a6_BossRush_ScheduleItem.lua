module("modules.logic.bossrush.view.v1a6.taskachievement.V1a6_BossRush_ScheduleItem", package.seeall)

local var_0_0 = class("V1a6_BossRush_ScheduleItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goNormal = gohelper.findChild(arg_1_0.viewGO, "#go_Normal")
	arg_1_0._txtDescr = gohelper.findChildText(arg_1_0.viewGO, "#go_Normal/#txt_Descr")
	arg_1_0._imgIcon = gohelper.findChildImage(arg_1_0.viewGO, "#go_Normal/image_Icon")
	arg_1_0._scrollRewards = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_Normal/#scroll_Rewards")
	arg_1_0._gorewards = gohelper.findChild(arg_1_0.viewGO, "#go_Normal/#scroll_Rewards/Viewport/#go_rewards")
	arg_1_0._btnNotFinish = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_Normal/#btn_NotFinish")
	arg_1_0._btnFinished = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_Normal/#btn_Finished")
	arg_1_0._goAllFinished = gohelper.findChild(arg_1_0.viewGO, "#go_Normal/#go_AllFinished")
	arg_1_0._goGetAll = gohelper.findChild(arg_1_0.viewGO, "#go_GetAll")
	arg_1_0._btngetall = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_GetAll/#btn_getall/click")
	arg_1_0.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(arg_1_0._goNormal)
	arg_1_0.animator = arg_1_0._goNormal:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0.animatorGetAll = arg_1_0._goGetAll:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0.animatorPlayerGetAll = ZProj.ProjAnimatorPlayer.Get(arg_1_0._goGetAll)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnNotFinish:AddClickListener(arg_2_0._btnNotFinishOnClick, arg_2_0)
	arg_2_0._btnFinished:AddClickListener(arg_2_0._btnFinishedOnClick, arg_2_0)
	arg_2_0._btngetall:AddClickListener(arg_2_0._btngetallOnClick, arg_2_0)
	arg_2_0:addEventCb(BossRushController.instance, BossRushEvent.OnClickGetAllScheduleBouns, arg_2_0._OnClickGetAllScheduleBouns, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnNotFinish:RemoveClickListener()
	arg_3_0._btnFinished:RemoveClickListener()
	arg_3_0._btngetall:RemoveClickListener()
	arg_3_0:removeEventCb(BossRushController.instance, BossRushEvent.OnClickGetAllScheduleBouns, arg_3_0._OnClickGetAllScheduleBouns, arg_3_0)
end

var_0_0.UI_CLICK_BLOCK_KEY = "V1a6_BossRush_ScheduleItemClick"

function var_0_0._btngetallOnClick(arg_4_0)
	arg_4_0:_btnFinishedOnClick()
	BossRushController.instance:dispatchEvent(BossRushEvent.OnClickGetAllScheduleBouns)
end

function var_0_0._btnNotFinishOnClick(arg_5_0)
	return
end

function var_0_0._btnFinishedOnClick(arg_6_0)
	UIBlockMgr.instance:startBlock(var_0_0.UI_CLICK_BLOCK_KEY)
	arg_6_0:getAnimatorPlayer():Play(BossRushEnum.V1a6_BonusViewAnimName.Finish, arg_6_0.firstAnimationDone, arg_6_0)
end

function var_0_0._OnClickGetAllScheduleBouns(arg_7_0)
	if arg_7_0._mo and arg_7_0._mo.isCanClaim then
		arg_7_0:getAnimator():Play(BossRushEnum.V1a6_BonusViewAnimName.Finish, 0, 0)
	end
end

function var_0_0._editableInitView(arg_8_0)
	return
end

function var_0_0._editableAddEvents(arg_9_0)
	return
end

function var_0_0._editableRemoveEvents(arg_10_0)
	return
end

function var_0_0.onUpdateMO(arg_11_0, arg_11_1)
	arg_11_0._mo = arg_11_1

	if not arg_11_1.getAll then
		arg_11_0:refreshNormalUI(arg_11_1)
	else
		arg_11_0:refreshGetAllUI(arg_11_1)
	end
end

function var_0_0.refreshNormalUI(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_1.isGot
	local var_12_1 = arg_12_1.stageRewardCO
	local var_12_2 = var_12_1.stage
	local var_12_3 = BossRushModel.instance:getLastPointInfo(var_12_2).cur >= var_12_1.rewardPointNum
	local var_12_4 = ItemModel.instance:getItemDataListByConfigStr(var_12_1.reward)
	local var_12_5 = var_12_3 and GameUtil.parseColor("#c48152") or GameUtil.parseColor("#919191")

	arg_12_0._imgIcon.color = var_12_5
	arg_12_0._mo.isCanClaim = not var_12_0 and var_12_3

	gohelper.setActive(arg_12_0._goAllFinished, var_12_0)
	gohelper.setActive(arg_12_0._btnFinished.gameObject, arg_12_0._mo.isCanClaim)
	gohelper.setActive(arg_12_0._btnNotFinish.gameObject, not var_12_0 and not var_12_3)
	gohelper.setActive(arg_12_0._goGetAll, false)
	gohelper.setActive(arg_12_0._goNormal, true)
	IconMgr.instance:getCommonPropItemIconList(arg_12_0, arg_12_0._onRewardItemShow, var_12_4, arg_12_0._gorewards)

	arg_12_0._txtDescr.text = string.format(luaLang("v1a6_bossrush_scheduleview_desc"), var_12_1.rewardPointNum)
end

function var_0_0.refreshGetAllUI(arg_13_0, arg_13_1)
	gohelper.setActive(arg_13_0._goGetAll, true)
	gohelper.setActive(arg_13_0._goNormal, false)
end

function var_0_0._onRewardItemShow(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	arg_14_1:onUpdateMO(arg_14_2)
	arg_14_1:showStackableNum2()
	arg_14_1:setCountFontSize(48)
end

function var_0_0.onSelect(arg_15_0, arg_15_1)
	return
end

function var_0_0.onDestroyView(arg_16_0)
	return
end

function var_0_0.firstAnimationDone(arg_17_0)
	local var_17_0 = arg_17_0._view.viewContainer:getScrollAnimRemoveItem(BossRushEnum.BonusViewTab.ScheduleTab)

	if var_17_0 then
		var_17_0:removeByIndex(arg_17_0._index, arg_17_0.secondAnimationDone, arg_17_0)
	else
		arg_17_0:secondAnimationDone()
	end
end

function var_0_0.secondAnimationDone(arg_18_0)
	if arg_18_0._mo then
		if arg_18_0._mo.getAll then
			BossRushRpc.instance:sendAct128GetTotalRewardsRequest(arg_18_0._mo.stage)
		elseif arg_18_0._mo.stageRewardCO then
			BossRushRpc.instance:sendAct128GetTotalSingleRewardRequest(arg_18_0._mo.stage, arg_18_0._mo.stageRewardCO.id)
		end

		UIBlockMgr.instance:endBlock(var_0_0.UI_CLICK_BLOCK_KEY)
	end
end

function var_0_0.getAnimator(arg_19_0)
	return arg_19_0._mo.getAll and arg_19_0.animatorGetAll or arg_19_0.animator
end

function var_0_0.getAnimatorPlayer(arg_20_0)
	return arg_20_0._mo.getAll and arg_20_0.animatorPlayerGetAll or arg_20_0.animatorPlayer
end

return var_0_0
