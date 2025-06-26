module("modules.logic.store.view.recommend.StoreNew6StarsChooseView", package.seeall)

local var_0_0 = class("StoreNew6StarsChooseView", StoreRecommendBaseSubView)

function var_0_0.ctor(arg_1_0, ...)
	var_0_0.super.ctor(arg_1_0, ...)

	arg_1_0.config = StoreConfig.instance:getStoreRecommendConfig(StoreEnum.RecommendSubStoreId.New6StarsChoose)
end

function var_0_0.onInitView(arg_2_0)
	arg_2_0._txtduration = gohelper.findChildText(arg_2_0.viewGO, "recommend/txt_tips/#txt_duration")
	arg_2_0._imageAttr1 = gohelper.findChildImage(arg_2_0.viewGO, "recommend/Name1/#image_Attr")
	arg_2_0._txtName1 = gohelper.findChildText(arg_2_0.viewGO, "recommend/Name1/#txt_Name")
	arg_2_0._imageAttr2 = gohelper.findChildImage(arg_2_0.viewGO, "recommend/Name2/#image_Attr")
	arg_2_0._txtName2 = gohelper.findChildText(arg_2_0.viewGO, "recommend/Name2/#txt_Name")
	arg_2_0._imageAttr3 = gohelper.findChildImage(arg_2_0.viewGO, "recommend/Name3/#image_Attr")
	arg_2_0._txtName3 = gohelper.findChildText(arg_2_0.viewGO, "recommend/Name3/#txt_Name")
	arg_2_0._txtChar = gohelper.findChildText(arg_2_0.viewGO, "recommend/image_Char/#txt_Char")
	arg_2_0._txtProp = gohelper.findChildText(arg_2_0.viewGO, "recommend/image_Prop/#txt_Prop")

	if arg_2_0._editableInitView then
		arg_2_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_3_0)
	return
end

function var_0_0.removeEvents(arg_4_0)
	if arg_4_0._clickBuy then
		arg_4_0._clickBuy:RemoveClickListener()
	end
end

function var_0_0._btnbuyOnClick(arg_5_0)
	StatController.instance:track(StatEnum.EventName.ClickRecommendPage, {
		[StatEnum.EventProperties.RecommendPageType] = StatEnum.RecommendType.Store,
		[StatEnum.EventProperties.RecommendPageId] = tostring(arg_5_0.config and arg_5_0.config.id or ""),
		[StatEnum.EventProperties.RecommendPageName] = arg_5_0.config and arg_5_0.config.name or arg_5_0.__cname
	})

	local var_5_0 = string.splitToNumber(arg_5_0.config.systemJumpCode, "#")

	if var_5_0[2] then
		local var_5_1 = var_5_0[2]
		local var_5_2 = StoreModel.instance:getGoodsMO(var_5_1)

		StoreController.instance:openPackageStoreGoodsView(var_5_2)
	else
		GameFacade.jumpByAdditionParam(arg_5_0.config.systemJumpCode)
	end
end

function var_0_0._editableInitView(arg_6_0)
	var_0_0.super._editableInitView(arg_6_0)

	local var_6_0 = gohelper.findChild(arg_6_0.viewGO, "recommend/Buy")

	arg_6_0._clickBuy = SLFramework.UGUI.UIClickListener.Get(var_6_0)

	arg_6_0._clickBuy:AddClickListener(arg_6_0._btnbuyOnClick, arg_6_0)
end

function var_0_0.onOpen(arg_7_0)
	var_0_0.super.onOpen(arg_7_0)
	arg_7_0:addEventCb(StoreController.instance, StoreEvent.UpdatePackageStore, arg_7_0.refreshUI, arg_7_0)
	arg_7_0:addEventCb(StoreController.instance, StoreEvent.StoreInfoChanged, arg_7_0.refreshUI, arg_7_0)
	arg_7_0:refreshUI()
end

function var_0_0.onClose(arg_8_0)
	arg_8_0:removeEventCb(StoreController.instance, StoreEvent.UpdatePackageStore, arg_8_0.refreshUI, arg_8_0)
	arg_8_0:removeEventCb(StoreController.instance, StoreEvent.StoreInfoChanged, arg_8_0.refreshUI, arg_8_0)
end

function var_0_0.refreshUI(arg_9_0)
	arg_9_0._txtduration.text = StoreController.instance:getRecommendStoreTime(arg_9_0.config)
end

return var_0_0
