module("modules.logic.store.view.recommend.StoreRoleSkinView", package.seeall)

local var_0_0 = class("StoreRoleSkinView", StoreRecommendBaseSubView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "view/#simage_bg")
	arg_1_0._simagesignature1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "view/left/role1/#simage_signature1")
	arg_1_0._simagesignature2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "view/left/role2/#simage_signature2")
	arg_1_0._txtdurationTime = gohelper.findChildText(arg_1_0.viewGO, "view/right/time/#txt_durationTime")
	arg_1_0._btnbuy = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "view/right/#btn_buy")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnbuy:AddClickListener(arg_2_0._btnbuyOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnbuy:RemoveClickListener()
end

function var_0_0._btnbuyOnClick(arg_4_0)
	StatController.instance:track(StatEnum.EventName.ClickRecommendPage, {
		[StatEnum.EventProperties.RecommendPageType] = StatEnum.RecommendType.Store,
		[StatEnum.EventProperties.RecommendPageId] = tostring(arg_4_0.config and arg_4_0.config.id or ""),
		[StatEnum.EventProperties.RecommendPageName] = arg_4_0.config and arg_4_0.config.name or "StoreRoleSkinView"
	})
	GameFacade.jumpByAdditionParam(arg_4_0.config.systemJumpCode)
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._animator = arg_5_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_5_0._animatorPlayer = SLFramework.AnimatorPlayer.Get(arg_5_0.viewGO)
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	var_0_0.super.onOpen(arg_7_0)
	arg_7_0:refreshUI()
end

function var_0_0.refreshUI(arg_8_0)
	arg_8_0.config = arg_8_0.config or StoreConfig.instance:getStoreRecommendConfig(StoreEnum.RecommendSubStoreId.StoreRoleSkinView)
	arg_8_0._txtdurationTime.text = StoreController.instance:getRecommendStoreTime(arg_8_0.config)
end

function var_0_0.onClose(arg_9_0)
	return
end

function var_0_0.onDestroyView(arg_10_0)
	return
end

return var_0_0
