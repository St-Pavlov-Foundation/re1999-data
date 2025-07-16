module("modules.logic.store.view.recommend.GiftPacksView", package.seeall)

local var_0_0 = class("GiftPacksView", StoreRecommendBaseSubView)

function var_0_0.onInitView(arg_1_0)
	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btn:AddClickListener(arg_2_0._onClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btn:RemoveClickListener()
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._animator = arg_4_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_4_0._animatorPlayer = SLFramework.AnimatorPlayer.Get(arg_4_0.viewGO)
	arg_4_0._btn = gohelper.findChildClickWithAudio(arg_4_0.viewGO, "view/#simage_bg")
	arg_4_0._simagebg = gohelper.findChildSingleImage(arg_4_0.viewGO, "view/#simage_bg")

	arg_4_0._simagebg:LoadImage(ResUrl.getStoreGiftPackBg("bg"))
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0._onClick(arg_6_0)
	GameFacade.jumpByAdditionParam("10170")
	AudioMgr.instance:trigger(2000001)
	StatController.instance:track(StatEnum.EventName.ClickRecommendPage, {
		[StatEnum.EventProperties.RecommendPageType] = StatEnum.RecommendType.Store,
		[StatEnum.EventProperties.RecommendPageId] = "713",
		[StatEnum.EventProperties.RecommendPageName] = "精选组合推荐",
		[StatEnum.EventProperties.RecommendPageRank] = arg_6_0:getTabIndex()
	})
end

function var_0_0.onDestroyView(arg_7_0)
	arg_7_0._simagebg:UnLoadImage()
end

return var_0_0
