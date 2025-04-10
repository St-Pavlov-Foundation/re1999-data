module("modules.logic.versionactivity2_7.v2a7_selfselectsix_1.view.V2a7_SelfSelectSix_FullView", package.seeall)

slot0 = class("V2a7_SelfSelectSix_FullView", BaseView)

function slot0.onInitView(slot0)
	slot0._btncheck = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/#btn_check")
	slot0._gocanget = gohelper.findChild(slot0.viewGO, "root/reward/#go_canget")
	slot0._btnClaim = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/reward/#go_canget/#btn_Claim")
	slot0._gocanuse = gohelper.findChild(slot0.viewGO, "root/reward/#go_canuse")
	slot0._btnuse = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/reward/#go_canuse/#btn_use")
	slot0._txtcanuse = gohelper.findChildText(slot0.viewGO, "root/reward/#go_canuse/tips/#txt_canuse")
	slot0._gouesd = gohelper.findChild(slot0.viewGO, "root/reward/#go_uesd")
	slot0._txtdesc = gohelper.findChildText(slot0.viewGO, "root/simage_fullbg/#txt_desc")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btncheck:AddClickListener(slot0._btncheckOnClick, slot0)
	slot0._btnClaim:AddClickListener(slot0._btnClaimOnClick, slot0)
	slot0._btnuse:AddClickListener(slot0._btnuseOnClick, slot0)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshNorSignActivity, slot0.refreshUI, slot0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, slot0._onCloseView, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btncheck:RemoveClickListener()
	slot0._btnClaim:RemoveClickListener()
	slot0._btnuse:RemoveClickListener()
	ActivityController.instance:unregisterCallback(ActivityEvent.RefreshNorSignActivity, slot0.refreshUI, slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, slot0._onCloseView, slot0)
end

function slot0._btncheckOnClick(slot0)
	if string.nilorempty(ItemConfig.instance:getItemCo(V2a7_SelfSelectSix_Enum.RewardId).effect) then
		return
	end

	V2a7_SelfSelectSix_PickChoiceListModel.instance:initData(string.split(slot1.effect, "|"), 1)
	ViewMgr.instance:openView(ViewName.V2a7_SelfSelectSix_PickChoiceView, {
		isPreview = true
	})
end

function slot0._btnClaimOnClick(slot0)
	if not slot0:checkReceied() and slot0:checkCanGet() then
		Activity101Rpc.instance:sendGet101BonusRequest(slot0._actId, 1)
	end
end

function slot0._btnuseOnClick(slot0)
	if ItemModel.instance:getItemCount(V2a7_SelfSelectSix_Enum.RewardId) > 0 then
		if string.nilorempty(ItemConfig.instance:getItemCo(V2a7_SelfSelectSix_Enum.RewardId).effect) then
			return
		end

		V2a7_SelfSelectSix_PickChoiceController.instance:openCustomPickChoiceView(string.split(slot2.effect, "|"), MaterialTipController.onUseSelfSelectSixHeroGift, MaterialTipController, {
			quantity = 1,
			id = slot2.id
		}, nil, , 1)
	end
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.Meilanni.play_ui_mln_day_night)

	slot0._actId = slot0.viewParam.actId

	gohelper.addChild(slot0.viewParam.parent, slot0.viewGO)
	Activity101Rpc.instance:sendGet101InfosRequest(slot0._actId)

	slot0._actCo = ActivityConfig.instance:getActivityCo(slot0._actId)
	slot0._txtdesc.text = slot0._actCo.actDesc

	slot0:refreshUI()
end

function slot0.refreshUI(slot0)
	slot1 = slot0:checkReceied()
	slot2 = slot0:checkCanUse()

	gohelper.setActive(slot0._gocanget, not slot1)
	gohelper.setActive(slot0._gocanuse, slot1 and slot2)
	gohelper.setActive(slot0._gouesd, slot1 and not slot2)

	if slot2 then
		slot0:_initListModel()

		slot3, slot4 = V2a7_SelfSelectSix_PickChoiceListModel.instance:getLastUnlockEpisodeId()

		if slot4 then
			slot0._txtcanuse.text = luaLang("v2a7_newbie_rewardclaim_texts")
		else
			slot0._txtcanuse.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("v2a7_newbie_storyprocess_locate_eventiterface"), DungeonHelper.getEpisodeName(slot3))
		end
	end
end

function slot0._initListModel(slot0)
	if string.nilorempty(ItemConfig.instance:getItemCo(V2a7_SelfSelectSix_Enum.RewardId).effect) then
		return
	end

	V2a7_SelfSelectSix_PickChoiceListModel.instance:initData(string.split(slot1.effect, "|"), 1)
end

function slot0._onCloseView(slot0, slot1)
	if slot1 == ViewName.CharacterGetView then
		slot0:refreshUI()
	end
end

function slot0.checkReceied(slot0)
	return ActivityType101Model.instance:isType101RewardGet(slot0._actId, 1)
end

function slot0.checkCanGet(slot0)
	return ActivityType101Model.instance:isType101RewardCouldGet(slot0._actId, 1)
end

function slot0.checkCanUse(slot0)
	return ItemModel.instance:getItemCount(V2a7_SelfSelectSix_Enum.RewardId) > 0
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
