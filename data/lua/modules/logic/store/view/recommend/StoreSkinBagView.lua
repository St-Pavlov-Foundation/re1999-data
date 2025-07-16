module("modules.logic.store.view.recommend.StoreSkinBagView", package.seeall)

local var_0_0 = class("StoreSkinBagView", GiftrecommendViewBase)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "view/#simage_bg")
	arg_1_0._txtdurationTime = gohelper.findChildText(arg_1_0.viewGO, "view/time/#txt_durationTime")
	arg_1_0._btnbuy = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "view/#btn_buy")

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
		[StatEnum.EventProperties.RecommendPageName] = arg_4_0.config and arg_4_0.config.name or "StoreSkinBagView",
		[StatEnum.EventProperties.RecommendPageRank] = arg_4_0:getTabIndex()
	})
	GameFacade.jumpByAdditionParam(arg_4_0.config.systemJumpCode)
end

function var_0_0._editableInitView(arg_5_0)
	var_0_0.super._editableInitView(arg_5_0)
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0.config = arg_6_0.config or StoreConfig.instance:getStoreRecommendConfig(StoreEnum.RecommendSubStoreId.StoreSkinBagView)

	var_0_0.super.onOpen(arg_6_0)
end

function var_0_0.onClose(arg_7_0)
	var_0_0.super.onClose(arg_7_0)
end

function var_0_0.refreshUI(arg_8_0)
	arg_8_0._txtdurationTime.text = StoreController.instance:getRecommendStoreTime(arg_8_0.config)
end

function var_0_0.onDestroyView(arg_9_0)
	var_0_0.super.onDestroyView(arg_9_0)
end

return var_0_0
