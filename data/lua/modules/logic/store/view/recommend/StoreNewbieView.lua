module("modules.logic.store.view.recommend.StoreNewbieView", package.seeall)

local var_0_0 = class("StoreNewbieView", StoreRecommendBaseSubView)

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

	local var_4_0 = gohelper.findChild(arg_4_0.viewGO, "recommend")

	arg_4_0._animatorPlayer = SLFramework.AnimatorPlayer.Get(var_4_0)
	arg_4_0._btn = gohelper.getClickWithAudio(arg_4_0.viewGO)
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0._onClick(arg_6_0)
	StatController.instance:track(StatEnum.EventName.ClickRecommendPage, {
		[StatEnum.EventProperties.RecommendPageType] = StatEnum.RecommendType.Store,
		[StatEnum.EventProperties.RecommendPageId] = "712",
		[StatEnum.EventProperties.RecommendPageName] = "新人邀约",
		[StatEnum.EventProperties.RecommendPageRank] = arg_6_0:getTabIndex()
	})
	GameFacade.jumpByAdditionParam("10170#610002")
	AudioMgr.instance:trigger(2000001)
end

function var_0_0.onDestroyView(arg_7_0)
	return
end

return var_0_0
