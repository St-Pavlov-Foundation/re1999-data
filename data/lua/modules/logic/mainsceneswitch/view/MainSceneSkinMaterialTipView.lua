module("modules.logic.mainsceneswitch.view.MainSceneSkinMaterialTipView", package.seeall)

local var_0_0 = class("MainSceneSkinMaterialTipView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageblur = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_blur")
	arg_1_0._simagebg1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_bg1")
	arg_1_0._simagebg2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_bg2")
	arg_1_0._gobannerContent = gohelper.findChild(arg_1_0.viewGO, "left/banner/#go_bannerContent")
	arg_1_0._goroominfoItem = gohelper.findChild(arg_1_0.viewGO, "left/banner/#go_bannerContent/#go_roominfoItem")
	arg_1_0._simagepic = gohelper.findChildSingleImage(arg_1_0.viewGO, "left/banner/#go_bannerContent/#go_roominfoItem/#simage_pic")
	arg_1_0._goSceneLogo = gohelper.findChild(arg_1_0.viewGO, "left/banner/#go_bannerContent/#go_roominfoItem/image_frame/#go_SceneLogo")
	arg_1_0._goSceneLogo2 = gohelper.findChild(arg_1_0.viewGO, "left/banner/#go_bannerContent/#go_roominfoItem/image_frame/#go_SceneLogo2")
	arg_1_0._goSceneLogo3 = gohelper.findChild(arg_1_0.viewGO, "left/banner/#go_bannerContent/#go_roominfoItem/image_frame/#go_SceneLogo3")
	arg_1_0._gotag = gohelper.findChild(arg_1_0.viewGO, "left/banner/#go_bannerContent/#go_roominfoItem/#go_tag")
	arg_1_0._gotag2 = gohelper.findChild(arg_1_0.viewGO, "left/banner/#go_bannerContent/#go_roominfoItem/#go_tag2")
	arg_1_0._gobannerscroll = gohelper.findChild(arg_1_0.viewGO, "left/banner/#go_bannerscroll")
	arg_1_0._gobuyContent = gohelper.findChild(arg_1_0.viewGO, "right/#go_buyContent")
	arg_1_0._goblockInfoItem = gohelper.findChild(arg_1_0.viewGO, "right/#go_buyContent/#go_blockInfoItem")
	arg_1_0._gopay = gohelper.findChild(arg_1_0.viewGO, "right/#go_buyContent/#go_pay")
	arg_1_0._gopayitem = gohelper.findChild(arg_1_0.viewGO, "right/#go_buyContent/#go_pay/#go_payitem")
	arg_1_0._gochange = gohelper.findChild(arg_1_0.viewGO, "right/#go_buyContent/#go_change")
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "right/#go_buyContent/#go_change/#txt_desc")
	arg_1_0._btninsight = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/#go_buyContent/buy/#btn_insight")
	arg_1_0._txtcostnum = gohelper.findChildText(arg_1_0.viewGO, "right/#go_buyContent/buy/#txt_costnum")
	arg_1_0._simagecosticon = gohelper.findChildSingleImage(arg_1_0.viewGO, "right/#go_buyContent/buy/#txt_costnum/#simage_costicon")
	arg_1_0._gosource = gohelper.findChild(arg_1_0.viewGO, "right/#go_source")
	arg_1_0._txttime = gohelper.findChildText(arg_1_0.viewGO, "right/#go_source/title/#txt_time")
	arg_1_0._scrolljump = gohelper.findChildScrollRect(arg_1_0.viewGO, "right/#go_source/#scroll_jump")
	arg_1_0._gojumpItem = gohelper.findChild(arg_1_0.viewGO, "right/#go_source/#scroll_jump/Viewport/Content/#go_jumpItem")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._gotopright = gohelper.findChild(arg_1_0.viewGO, "#go_topright")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btninsight:AddClickListener(arg_2_0._btninsightOnClick, arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btninsight:RemoveClickListener()
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._btninsightOnClick(arg_4_0)
	return
end

function var_0_0._btncloseOnClick(arg_5_0)
	arg_5_0:closeThis()
end

function var_0_0._editableInitView(arg_6_0)
	gohelper.setActive(arg_6_0._gojumpItem, false)
	gohelper.setActive(arg_6_0._gobuyContent, false)
	gohelper.setActive(arg_6_0._gosource, true)

	arg_6_0._jumpParentGo = gohelper.findChild(arg_6_0.viewGO, "right/#go_source/#scroll_jump/Viewport/Content")
	arg_6_0.jumpItemGos = {}

	arg_6_0._simagebg1:LoadImage(ResUrl.getCommonIcon("bg_1"))
	arg_6_0._simagebg2:LoadImage(ResUrl.getCommonIcon("bg_2"))
	NavigateMgr.instance:addEscape(arg_6_0.viewName, arg_6_0.closeThis, arg_6_0)
end

function var_0_0._refreshUI(arg_7_0)
	arg_7_0._canJump = arg_7_0.viewParam.canJump
	arg_7_0._config = ItemModel.instance:getItemConfig(arg_7_0.viewParam.type, arg_7_0.viewParam.id)
	arg_7_0._sceneConfig = MainSceneSwitchConfig.instance:getConfigByItemId(arg_7_0.viewParam.id)

	arg_7_0:_cloneJumpItem()
	arg_7_0:_refreshSubType()
end

function var_0_0._refreshSubType(arg_8_0)
	local var_8_0 = arg_8_0._config.subType == ItemEnum.SubType.MainSceneSkin
	local var_8_1 = arg_8_0._config.subType == ItemEnum.SubType.FightFloatType
	local var_8_2 = arg_8_0._config.subType == ItemEnum.SubType.FightCard

	gohelper.setActive(arg_8_0._goSceneLogo, var_8_0)
	gohelper.setActive(arg_8_0._goSceneLogo2, var_8_1)
	gohelper.setActive(arg_8_0._goSceneLogo3, var_8_2)
	gohelper.setActive(arg_8_0._gotag, var_8_0)
	gohelper.setActive(arg_8_0._gotag2, var_8_1 or var_8_2)
end

function var_0_0._cloneJumpItem(arg_9_0)
	arg_9_0._scrolljump.verticalNormalizedPosition = 1

	local var_9_0 = {}

	if arg_9_0._config then
		var_9_0 = arg_9_0:_sourcesStrToTables(arg_9_0._config.sources)
	end

	for iter_9_0 = 1, #var_9_0 do
		local var_9_1 = arg_9_0.jumpItemGos[iter_9_0]

		if not var_9_1 then
			local var_9_2 = iter_9_0 == 1 and arg_9_0._gojumpItem or gohelper.clone(arg_9_0._gojumpItem, arg_9_0._jumpParentGo, "item" .. iter_9_0)

			var_9_1 = arg_9_0:getUserDataTb_()
			var_9_1.go = var_9_2
			var_9_1.originText = gohelper.findChildText(var_9_2, "frame/txt_chapter")
			var_9_1.indexText = gohelper.findChildText(var_9_2, "frame/txt_name")
			var_9_1.jumpBtn = gohelper.findChildButtonWithAudio(var_9_2, "frame/btn_jump")
			var_9_1.jumpBgGO = gohelper.findChild(var_9_2, "frame/btn_jump/jumpbg")

			table.insert(arg_9_0.jumpItemGos, var_9_1)
			var_9_1.jumpBtn:AddClickListener(function(arg_10_0)
				if arg_10_0.cantJumpTips then
					GameFacade.showToastWithTableParam(arg_10_0.cantJumpTips, arg_10_0.cantJumpParam)
				elseif arg_10_0.canJump then
					if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.ForceJumpToMainView) then
						NavigateButtonsView.homeClick()

						return
					end

					GameFacade.jump(arg_10_0.jumpId, arg_9_0._onJumpFinish, arg_9_0, arg_9_0.viewParam.recordFarmItem)
				else
					GameFacade.showToast(ToastEnum.MaterialTipJump)
				end
			end, var_9_1)
		end

		local var_9_3 = var_9_0[iter_9_0]

		var_9_1.canJump = arg_9_0._canJump
		var_9_1.jumpId = var_9_3.sourceId

		local var_9_4, var_9_5 = JumpConfig.instance:getJumpName(var_9_3.sourceId)

		var_9_1.originText.text = var_9_4 or ""
		var_9_1.indexText.text = var_9_5 or ""

		local var_9_6, var_9_7 = arg_9_0:_getCantJump(var_9_3)

		ZProj.UGUIHelper.SetGrayscale(var_9_1.jumpBgGO, var_9_6 ~= nil)

		var_9_1.cantJumpTips = var_9_6
		var_9_1.cantJumpParam = var_9_7

		gohelper.setActive(var_9_1.go, true)

		local var_9_8 = JumpController.instance:isOnlyShowJump(var_9_3.sourceId)

		gohelper.setActive(var_9_1.jumpBtn, not var_9_8)
	end

	gohelper.setActive(arg_9_0._gosource, #var_9_0 > 0)

	for iter_9_1 = #var_9_0 + 1, #arg_9_0.jumpItemGos do
		gohelper.setActive(arg_9_0.jumpItemGos[iter_9_1].go, false)
	end
end

function var_0_0._sourcesStrToTables(arg_11_0, arg_11_1)
	local var_11_0 = {}

	if not string.nilorempty(arg_11_1) then
		local var_11_1 = string.split(arg_11_1, "|")

		for iter_11_0, iter_11_1 in ipairs(var_11_1) do
			local var_11_2 = string.splitToNumber(iter_11_1, "#")
			local var_11_3 = {
				sourceId = var_11_2[1],
				probability = var_11_2[2]
			}

			var_11_3.episodeId = JumpConfig.instance:getJumpEpisodeId(var_11_3.sourceId)

			if var_11_3.probability ~= MaterialEnum.JumpProbability.Normal or not DungeonModel.instance:hasPassLevel(var_11_3.episodeId) then
				table.insert(var_11_0, var_11_3)
			end
		end
	end

	return var_11_0
end

function var_0_0._getCantJump(arg_12_0, arg_12_1)
	local var_12_0 = JumpController.instance:isJumpOpen(arg_12_1.sourceId)
	local var_12_1
	local var_12_2
	local var_12_3 = JumpConfig.instance:getJumpConfig(arg_12_1.sourceId)

	if not var_12_0 then
		var_12_1, var_12_2 = OpenHelper.getToastIdAndParam(var_12_3.openId)
	else
		var_12_1, var_12_2 = JumpController.instance:cantJump(var_12_3.param)
	end

	return var_12_1, var_12_2
end

function var_0_0.onUpdateParam(arg_13_0)
	arg_13_0:_refreshUI()
end

function var_0_0.onOpen(arg_14_0)
	arg_14_0:_refreshUI()
end

function var_0_0.onClickModalMask(arg_15_0)
	arg_15_0:closeThis()
end

function var_0_0.onClose(arg_16_0)
	for iter_16_0 = 1, #arg_16_0.jumpItemGos do
		arg_16_0.jumpItemGos[iter_16_0].jumpBtn:RemoveClickListener()
	end
end

function var_0_0.onDestroyView(arg_17_0)
	arg_17_0._simagebg1:UnLoadImage()
	arg_17_0._simagebg2:UnLoadImage()
end

return var_0_0
