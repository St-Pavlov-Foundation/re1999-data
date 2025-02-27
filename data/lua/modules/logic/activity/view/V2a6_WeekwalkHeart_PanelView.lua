module("modules.logic.activity.view.V2a6_WeekwalkHeart_PanelView", package.seeall)

slot0 = class("V2a6_WeekwalkHeart_PanelView", Activity189BaseView)
slot0.SigninId = 530007
slot0.ConstItemId = 1261301

function slot0.onInitView(slot0)
	slot0._simageFullBG = gohelper.findChildSingleImage(slot0.viewGO, "#simage_FullBG")
	slot0._btnreward = gohelper.findChildButtonWithAudio(slot0.viewGO, "Root/Left/reward/btn_reward")
	slot0._btnright = gohelper.findChildButtonWithAudio(slot0.viewGO, "Root/Right/rightbg/reward/btn")
	slot0._goreceive = gohelper.findChild(slot0.viewGO, "Root/Left/go_receive")
	slot0._gohasget = gohelper.findChild(slot0.viewGO, "Root/Left/go_receive/go_hasget")
	slot0._animGet = slot0._gohasget:GetComponent(typeof(UnityEngine.Animator))
	slot0._gocanget = gohelper.findChild(slot0.viewGO, "Root/Left/go_canget")
	slot0._txtLimitTime = gohelper.findChildText(slot0.viewGO, "Root/Top/#txt_LimitTime")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "Root/Top/#btn_close")
	slot0._btngoto = gohelper.findChildButtonWithAudio(slot0.viewGO, "Root/Right/#btn_goto")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0._btngoto:AddClickListener(slot0._btngotoOnClick, slot0)
	slot0._btnreward:AddClickListener(slot0._btnrewardOnClick, slot0)
	slot0._btnright:AddClickListener(slot0._btnrightOnClick, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseViewFinish, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
	slot0._btngoto:RemoveClickListener()
	slot0._btnreward:RemoveClickListener()
	slot0._btnright:RemoveClickListener()
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseViewFinish, slot0)
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._btngotoOnClick(slot0)
	ActivityModel.instance:setTargetActivityCategoryId(slot0:actId())
	ActivityController.instance:openActivityBeginnerView()
end

function slot0._btnrewardOnClick(slot0)
	if slot0.rewardMo.hasFinished and slot0.rewardMo.finishCount <= 0 then
		TaskRpc.instance:sendFinishTaskRequest(uv0.SigninId)
	end
end

function slot0._btnrightOnClick(slot0)
	MaterialTipController.instance:showMaterialInfo(slot0._itemCo[1], slot0._itemCo[2])
end

function slot0._editableInitView(slot0)
	slot0:_initTip()
end

function slot0._initTip(slot0)
	slot1 = slot0:getUserDataTb_()
	slot1.go = gohelper.findChild(slot0.viewGO, "Root/Left")
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

	slot0._rewardItem = slot1
end

function slot0.onUpdateParam(slot0)
end

function slot0._onCloseViewFinish(slot0, slot1)
	if slot1 == ViewName.CommonPropView then
		slot0:_refresh()
		slot0._animGet:Play("open")
	end
end

function slot0._refresh(slot0)
	slot0._txtLimitTime.text = slot0:getRemainTimeStr()

	if TaskModel.instance:getTaskMoList(TaskEnum.TaskType.Activity189, slot0:actId()) and #slot1 > 0 then
		for slot5, slot6 in ipairs(slot1) do
			if slot6.id == uv0.SigninId then
				slot0.rewardMo = slot6

				break
			end
		end
	end

	if slot0.rewardMo.finishCount > 0 then
		gohelper.setActive(slot0._gocanget, false)
		gohelper.setActive(slot0._goreceive, true)
		gohelper.setActive(slot0._btnreward.gameObject, false)
	elseif slot0.rewardMo.hasFinished then
		gohelper.setActive(slot0._gocanget, true)
		gohelper.setActive(slot0._goreceive, false)
		gohelper.setActive(slot0._btnreward.gameObject, true)
	else
		gohelper.setActive(slot0._gocanget, false)
		gohelper.setActive(slot0._goreceive, false)
		gohelper.setActive(slot0._btnreward.gameObject, false)
	end
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.NewTurnabck.play_ui_call_back_Interface_entry_04)

	slot0._itemCo = string.split(Activity189Config.instance:getConstCoById(uv0.ConstItemId).numValue, "#")

	slot0:_refresh()
end

function slot0.onClose(slot0)
	slot0._rewardItem.btnlikeclick:RemoveClickListener()
	slot0._rewardItem.btnunlikeclick:RemoveClickListener()
end

function slot0.onDestroyView(slot0)
end

return slot0
