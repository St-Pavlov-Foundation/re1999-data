module("modules.logic.versionactivity2_7.act191.view.Act191InitBuildView", package.seeall)

local var_0_0 = class("Act191InitBuildView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._scrollbuild = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_build")
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "#go_topleft")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0.actId = Activity191Model.instance:getCurActId()
end

function var_0_0.onOpen(arg_5_0)
	Act191StatController.instance:onViewOpen(arg_5_0.viewName)

	arg_5_0.initBuildInfo = Activity191Model.instance:getActInfo():getGameInfo().initBuildInfo

	arg_5_0:refreshUI()
end

function var_0_0.onClose(arg_6_0)
	local var_6_0 = arg_6_0.viewContainer:isManualClose()

	Act191StatController.instance:statViewClose(arg_6_0.viewName, var_6_0)
end

function var_0_0.onDestroyView(arg_7_0)
	TaskDispatcher.cancelTask(arg_7_0.nextStep, arg_7_0)
end

function var_0_0.refreshUI(arg_8_0)
	arg_8_0.buildCoList = lua_activity191_init_build.configDict[arg_8_0.actId]
	arg_8_0.bagAnimList = arg_8_0:getUserDataTb_()

	local var_8_0 = gohelper.findChild(arg_8_0.viewGO, "#scroll_build/Viewport/Content")
	local var_8_1 = gohelper.findChild(arg_8_0.viewGO, "#scroll_build/Viewport/Content/SelectItem")

	gohelper.CreateObjList(arg_8_0, arg_8_0._onInitBuildItem, arg_8_0.initBuildInfo, var_8_0, var_8_1)
	gohelper.setActive(var_8_1, false)

	local var_8_2 = 0

	if arg_8_0.extraBuildIndex and not GuideModel.instance:isGuideFinish(31504) then
		if arg_8_0.extraBuildIndex ~= 1 then
			var_8_2 = 0.15
		end

		Activity191Controller.instance:dispatchEvent(Activity191Event.ZTrigger31504)
	end

	arg_8_0._scrollbuild.horizontalNormalizedPosition = var_8_2
end

function var_0_0._onInitBuildItem(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = lua_activity191_init_build.configDict[arg_9_0.actId][arg_9_2.id]

	gohelper.findChildText(arg_9_1, "name/txt_name").text = var_9_0.name or ""
	gohelper.findChildText(arg_9_1, "Coin/txt_Coin").text = arg_9_2.coin

	local var_9_1 = gohelper.findChild(arg_9_1, "Coin/effect")

	gohelper.setActive(var_9_1, arg_9_2.coin ~= var_9_0.coin)

	local var_9_2 = gohelper.findChildButtonWithAudio(arg_9_1, "btn_select")

	arg_9_0:addClickCb(var_9_2, arg_9_0.selectInitBuild, arg_9_0, arg_9_3)

	local var_9_3 = gohelper.findChild(arg_9_1, "hero/heroitem")
	local var_9_4 = gohelper.findChild(arg_9_1, "collection/collectionitem")

	for iter_9_0, iter_9_1 in ipairs(arg_9_2.detail) do
		if arg_9_0.extraBuildIndex and iter_9_1.type == Activity191Enum.InitBuildType.Random then
			arg_9_0.extraBuildIndex = arg_9_3
		end

		local var_9_5 = iter_9_1.type == Activity191Enum.InitBuildType.Extra

		for iter_9_2, iter_9_3 in ipairs(iter_9_1.addHero) do
			arg_9_0:addHero(var_9_3, iter_9_3, var_9_5)
		end

		for iter_9_4, iter_9_5 in ipairs(iter_9_1.addItem) do
			arg_9_0:addCollection(var_9_4, iter_9_5, var_9_5)
		end
	end

	gohelper.setActive(var_9_3, false)
	gohelper.setActive(var_9_4, false)

	arg_9_0.bagAnimList[arg_9_3] = arg_9_1:GetComponent(gohelper.Type_Animator)
end

function var_0_0.addHero(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = gohelper.cloneInPlace(arg_10_1)
	local var_10_1 = arg_10_0:getResInst(Activity191Enum.PrefabPath.HeroHeadItem, var_10_0)
	local var_10_2 = MonoHelper.addNoUpdateLuaComOnceToGo(var_10_1, Act191HeroHeadItem)

	var_10_2:setData(nil, arg_10_2)
	var_10_2:setPreview()
	var_10_2:setExtraEffect(arg_10_3)
end

function var_0_0.addCollection(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = gohelper.cloneInPlace(arg_11_1)
	local var_11_1 = Activity191Config.instance:getCollectionCo(arg_11_2)
	local var_11_2 = gohelper.findChildImage(var_11_0, "rare")

	UISpriteSetMgr.instance:setAct174Sprite(var_11_2, "act174_propitembg_" .. var_11_1.rare)
	gohelper.findChildSingleImage(var_11_0, "collectionicon"):LoadImage(ResUrl.getRougeSingleBgCollection(var_11_1.icon))

	local var_11_3 = gohelper.findChildButtonWithAudio(var_11_0, "collectionicon")

	arg_11_0:addClickCb(var_11_3, arg_11_0.clickCollection, arg_11_0, arg_11_2)

	local var_11_4 = gohelper.findChild(var_11_0, "effect")

	gohelper.setActive(var_11_4, arg_11_3)
end

function var_0_0.selectInitBuild(arg_12_0, arg_12_1)
	if arg_12_0.selectIndex then
		return
	end

	local var_12_0 = arg_12_0.initBuildInfo[arg_12_1]

	Activity191Rpc.instance:sendSelect191InitBuildRequest(arg_12_0.actId, var_12_0.id, arg_12_0.buildReply, arg_12_0)

	arg_12_0.selectIndex = arg_12_1
end

function var_0_0.buildReply(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_2 == 0 then
		local var_13_0 = arg_13_0.selectIndex

		if var_13_0 and arg_13_0.bagAnimList[var_13_0] then
			arg_13_0.bagAnimList[var_13_0]:Play(UIAnimationName.Close)
			AudioMgr.instance:trigger(AudioEnum.Act174.play_ui_shuori_qiyuan_reset)
		end

		TaskDispatcher.runDelay(arg_13_0.nextStep, arg_13_0, 0.67)

		local var_13_1 = Activity191Helper.getPlayerPrefs(arg_13_0.actId, "Act191GameCostTime", 0)

		Activity191Helper.setPlayerPrefs(arg_13_0.actId, "Act191GameCostTime", var_13_1 + 1)
	end
end

function var_0_0.clickCollection(arg_14_0, arg_14_1)
	local var_14_0 = {
		itemId = arg_14_1
	}

	Activity191Controller.instance:openCollectionTipView(var_14_0)
end

function var_0_0.nextStep(arg_15_0)
	arg_15_0.selectIndex = nil

	Activity191Controller.instance:nextStep()
	ViewMgr.instance:closeView(arg_15_0.viewName)
end

return var_0_0
