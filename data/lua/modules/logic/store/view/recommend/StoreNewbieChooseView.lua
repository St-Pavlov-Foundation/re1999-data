module("modules.logic.store.view.recommend.StoreNewbieChooseView", package.seeall)

local var_0_0 = class("StoreNewbieChooseView", StoreRecommendBaseSubView)
local var_0_1 = 3
local var_0_2 = 3
local var_0_3 = {
	3082,
	3020,
	3076
}
local var_0_4 = {
	[3020] = 105,
	[3076] = 103,
	[3082] = 104
}
local var_0_5 = 10170

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goNewbieChar1 = gohelper.findChild(arg_1_0.viewGO, "recommend/anibg/#simage_char1")
	arg_1_0._goNewbieChar2 = gohelper.findChild(arg_1_0.viewGO, "recommend/anibg/#simage_char2")
	arg_1_0._goNewbieChar3 = gohelper.findChild(arg_1_0.viewGO, "recommend/anibg/#simage_char3")
	arg_1_0._charAnim = gohelper.findChild(arg_1_0.viewGO, "recommend/anibg"):GetComponent(typeof(UnityEngine.Animation))

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
	arg_4_0._newbieCharGoList = arg_4_0:getUserDataTb_()
	arg_4_0._newbieCharGoList[1] = arg_4_0._goNewbieChar3
	arg_4_0._newbieCharGoList[2] = arg_4_0._goNewbieChar2
	arg_4_0._newbieCharGoList[3] = arg_4_0._goNewbieChar1
end

function var_0_0.onOpen(arg_5_0)
	StoreRecommendBaseSubView.onOpen(arg_5_0)
	StoreController.instance:dispatchEvent(StoreEvent.SetAutoToNextPage, false)

	arg_5_0._curCharIdx = 0

	arg_5_0:_toNextChar()
	arg_5_0._charAnim:Play()
end

function var_0_0.onClose(arg_6_0)
	TaskDispatcher.cancelTask(arg_6_0._toNextChar, arg_6_0)
	StoreRecommendBaseSubView.onClose(arg_6_0)
	arg_6_0._charAnim:Stop()
	StoreController.instance:dispatchEvent(StoreEvent.SetAutoToNextPage, true)
end

function var_0_0.onUpdateParam(arg_7_0)
	return
end

function var_0_0._toNextChar(arg_8_0)
	if arg_8_0._curCharIdx >= var_0_1 then
		arg_8_0._curCharIdx = 0
	end

	arg_8_0._curCharIdx = arg_8_0._curCharIdx + 1

	if arg_8_0._curCharIdx == var_0_1 then
		StoreController.instance:dispatchEvent(StoreEvent.SetAutoToNextPage, true)
	end

	local var_8_0 = arg_8_0._newbieCharGoList[arg_8_0._curCharIdx]
	local var_8_1 = var_0_3[arg_8_0._curCharIdx]
	local var_8_2 = gohelper.findChildText(var_8_0, "name/image_NameBG/#txt_Name")
	local var_8_3 = gohelper.findChildImage(var_8_0, "name/#image_Attr")
	local var_8_4 = HeroConfig.instance:getHeroCO(var_8_1)

	var_8_2.text = var_8_4.name

	UISpriteSetMgr.instance:setCommonSprite(var_8_3, "lssx_" .. var_8_4.career)
	TaskDispatcher.runDelay(arg_8_0._toNextChar, arg_8_0, var_0_2)
end

function var_0_0._onClick(arg_9_0)
	GameFacade.jumpByAdditionParam(var_0_5 .. "#" .. StoreEnum.NewbiePackId)
	AudioMgr.instance:trigger(2000001)
	StatController.instance:track(StatEnum.EventName.ClickRecommendPage, {
		[StatEnum.EventProperties.RecommendPageType] = StatEnum.RecommendType.Store,
		[StatEnum.EventProperties.RecommendPageId] = "712",
		[StatEnum.EventProperties.RecommendPageName] = "新人邀约"
	})
end

function var_0_0.onDestroyView(arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0._toNextChar, arg_10_0)
end

return var_0_0
