module("modules.logic.activity.view.V2a6_WeekwalkHeart_FullView", package.seeall)

slot0 = class("V2a6_WeekwalkHeart_FullView", Activity189BaseView)
slot0.SignInState = {
	CanGet = 1,
	HasGet = 2,
	NotFinish = 0
}
slot0.ReadTaskId = 530008

function slot0.onInitView(slot0)
	slot0._simageFullBG = gohelper.findChildSingleImage(slot0.viewGO, "#simage_FullBG")
	slot0._txtLimitTime = gohelper.findChildText(slot0.viewGO, "Root/Top/#txt_LimitTime")
	slot0._btngoto = gohelper.findChildButtonWithAudio(slot0.viewGO, "Root/Right/#btn_goto")
	slot0._rewardItemList = {}
	slot0._tipItemList = {}

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btngoto:AddClickListener(slot0._btngotoOnClick, slot0)
	TaskController.instance:registerCallback(TaskEvent.onReceiveFinishReadTaskReply, slot0._onFinishReadTask, slot0)
	TaskController.instance:registerCallback(TaskEvent.OnFinishTask, slot0._onGetReward, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseViewFinish, slot0)
	slot0:addEventCb(TimeDispatcher.instance, TimeDispatcher.OnDailyRefresh, slot0._refresh, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btngoto:RemoveClickListener()
	TaskController.instance:unregisterCallback(TaskEvent.onReceiveFinishReadTaskReply, slot0._onFinishReadTask, slot0)
	TaskController.instance:unregisterCallback(TaskEvent.OnFinishTask, slot0._onGetReward, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseViewFinish, slot0)
	slot0:removeEventCb(TimeDispatcher.instance, TimeDispatcher.OnDailyRefresh, slot0._refresh, slot0)
end

function slot0._btngotoOnClick(slot0)
	GameFacade.jump(JumpEnum.JumpView.WeekWalk)
	slot0:_trySendReadTask()
end

function slot0._onFinishReadTask(slot0)
	slot0:_updateRewardState()
end

function slot0._onGetReward(slot0, slot1)
	slot0._taskId = slot1
end

function slot0._onCloseViewFinish(slot0, slot1)
	if slot1 == ViewName.CommonPropView then
		slot0:_updateRewardState()
	end
end

function slot0._editableInitView(slot0)
	slot0:_initReward()
	slot0:_initTipList()
end

function slot0._initReward(slot0)
	for slot5 = 1, 3 do
		slot6 = slot0:getUserDataTb_()
		slot6.co = Activity189Config.instance:getAllTaskList(slot0:actId())[slot5]
		slot6.go = gohelper.findChild(slot0.viewGO, "Root/Right/rightbg/taskitem" .. slot5)
		slot6.txttask = gohelper.findChildText(slot6.go, "#txt_task")
		slot6.goreward = gohelper.findChild(slot6.go, "#go_rewarditem")
		slot6.gorewardicon = gohelper.findChild(slot6.goreward, "go_icon")
		slot6.gocanget = gohelper.findChild(slot6.goreward, "go_canget")
		slot6.goreceive = gohelper.findChild(slot6.goreward, "go_receive")
		slot6.gohasget = gohelper.findChild(slot6.goreward, "go_receive/go_hasget")
		slot6.btnclick = gohelper.findChildButton(slot6.goreward, "btnclick")
		slot6.animget = slot6.gohasget:GetComponent(typeof(UnityEngine.Animator))

		if slot6.co then
			slot7 = string.splitToNumber(slot6.co.bonus, "#")
			slot6.txttask.text = slot6.co.desc
			slot6.itemIcon = IconMgr.instance:getCommonPropItemIcon(slot6.gorewardicon)

			slot6.itemIcon:setMOValue(slot7[1], slot7[2], slot7[3], nil, true)

			if slot5 ~= 2 then
				slot6.itemIcon:setItemIconScale(0.8)
			end

			slot6.itemIcon:setCountFontSize(36)
			slot6.btnclick:AddClickListener(function ()
				TaskRpc.instance:sendFinishTaskRequest(uv0.co.id)
			end, slot0, slot6)
		end

		table.insert(slot0._rewardItemList, slot6)
	end
end

function slot0._initTipList(slot0)
	for slot4 = 1, 3 do
		slot5 = slot0:getUserDataTb_()
		slot5.go = gohelper.findChild(slot0.viewGO, "Root/Left/tips" .. slot4 .. "/root")

		slot0:_initTipItem(slot5)
	end

	slot1 = slot0:getUserDataTb_()
	slot1.go = gohelper.findChild(slot0.viewGO, "Root/Right/rightbg/title")

	slot0:_initTipItem(slot1)
end

function slot0._initTipItem(slot0, slot1)
	slot1.isLike = false
	slot1.isUnLike = false
	slot1.golike = gohelper.findChild(slot1.go, "like")
	slot1.txtlike = gohelper.findChildText(slot1.golike, "num")
	slot1.likenum = math.random(50, 99)
	slot1.txtlike.text = slot1.likenum
	slot1.govxlike = gohelper.findChild(slot1.golike, "vx_like")
	slot1.golikeSelect = gohelper.findChild(slot1.golike, "go_selected")
	slot1.btnlikeclick = gohelper.findChildButton(slot1.golike, "#btn_click")

	slot1.btnlikeclick:AddClickListener(function ()
		if not uv0.isUnLike then
			if uv0.isLike then
				uv0.likenum = uv0.likenum - 1
			else
				uv0.likenum = uv0.likenum + 1
			end

			uv0.isLike = not uv0.isLike
		end

		gohelper.setActive(uv0.govxlike, uv0.isLike)
		gohelper.setActive(uv0.golikeSelect, uv0.isLike)

		uv0.txtlike.text = uv0.likenum

		AudioMgr.instance:trigger(AudioEnum.NewTurnabck.play_ui_call_back_nameplate_switch)
	end, slot0, slot1)

	slot1.gounlike = gohelper.findChild(slot1.go, "unlike")
	slot1.txtunlike = gohelper.findChildText(slot1.gounlike, "num")
	slot1.unlikenum = math.random(50, 99)
	slot1.txtunlike.text = slot1.unlikenum
	slot1.govxunlike = gohelper.findChild(slot1.gounlike, "vx_unlike")
	slot1.gounlikeSelect = gohelper.findChild(slot1.gounlike, "go_selected")
	slot1.btnunlikeclick = gohelper.findChildButton(slot1.gounlike, "#btn_click")

	slot1.btnunlikeclick:AddClickListener(function ()
		if not uv0.isLike then
			if uv0.isUnLike then
				uv0.unlikenum = uv0.unlikenum - 1
			else
				uv0.unlikenum = uv0.unlikenum + 1
			end

			uv0.isUnLike = not uv0.isUnLike
		end

		gohelper.setActive(uv0.govxunlike, uv0.isUnLike)
		gohelper.setActive(uv0.gounlikeSelect, uv0.isUnLike)

		uv0.txtunlike.text = uv0.unlikenum

		AudioMgr.instance:trigger(AudioEnum.NewTurnabck.play_ui_call_back_nameplate_switch)
	end, slot0, slot1)
	gohelper.setActive(slot1.govxlike, slot1.isLike)
	gohelper.setActive(slot1.golikeSelect, slot1.isLike)
	gohelper.setActive(slot1.govxunlike, slot1.isUnLike)
	gohelper.setActive(slot1.gounlikeSelect, slot1.isUnLike)
	table.insert(slot0._tipItemList, slot1)
end

function slot0._refresh(slot0)
	slot0:_updateRewardState()
end

function slot0._updateRewardState(slot0)
	slot5 = slot0

	for slot5, slot6 in ipairs(TaskModel.instance:getTaskMoList(TaskEnum.TaskType.Activity189, slot0.actId(slot5))) do
		for slot10, slot11 in ipairs(slot0._rewardItemList) do
			if slot11.co.id == slot6.id then
				slot11.mo = slot6

				if slot6.finishCount > 0 then
					gohelper.setActive(slot11.gocanget, false)
					gohelper.setActive(slot11.goreceive, true)

					if slot0._taskId == slot6.id then
						slot11.animget:Play("go_hasget_in")

						slot0._taskId = nil
					end

					gohelper.setActive(slot11.btnclick.gameObject, false)
				elseif slot6.hasFinished then
					gohelper.setActive(slot11.gocanget, true)
					gohelper.setActive(slot11.goreceive, false)
					gohelper.setActive(slot11.btnclick.gameObject, true)
				else
					gohelper.setActive(slot11.goreceive, false)
					gohelper.setActive(slot11.gocanget, false)
					gohelper.setActive(slot11.btnclick.gameObject, false)
				end
			end
		end
	end
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	gohelper.addChild(slot0.viewParam.parent, slot0.viewGO)

	slot0._txtLimitTime.text = slot0:getRemainTimeStr()

	AudioMgr.instance:trigger(AudioEnum.AudioEnum2_6.WeekwalkHeart.play_ui_wenming_popup)
	Activity189Controller.instance:sendGetTaskInfoRequest(slot0._refresh, slot0)
end

function slot0._trySendReadTask(slot0)
	slot5 = slot0

	for slot5, slot6 in ipairs(TaskModel.instance:getTaskMoList(TaskEnum.TaskType.Activity189, slot0.actId(slot5))) do
		if slot6.id == uv0.ReadTaskId and not slot6.hasFinished and slot6.finishCount <= 0 then
			TaskRpc.instance:sendFinishReadTaskRequest(uv0.ReadTaskId)
		end
	end
end

function slot0.onClose(slot0)
	for slot4, slot5 in ipairs(slot0._rewardItemList) do
		slot5.btnclick:RemoveClickListener()
	end

	for slot4, slot5 in ipairs(slot0._tipItemList) do
		slot5.btnlikeclick:RemoveClickListener()
		slot5.btnunlikeclick:RemoveClickListener()
	end

	TaskDispatcher.cancelTask(slot0._cb, slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
