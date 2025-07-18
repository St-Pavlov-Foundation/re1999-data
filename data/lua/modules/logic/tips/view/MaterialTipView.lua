﻿module("modules.logic.tips.view.MaterialTipView", package.seeall)

local var_0_0 = class("MaterialTipView", BaseView)

function var_0_0.onInitView(arg_1_0)
	local var_1_0 = GMController.instance:getGMNode("materialtipview", arg_1_0.viewGO)

	if var_1_0 then
		arg_1_0._gogm = gohelper.findChild(var_1_0, "#go_gm")
		arg_1_0._txtmattip = gohelper.findChildText(var_1_0, "#go_gm/bg/#txt_mattip")
		arg_1_0._btnone = gohelper.findChildButtonWithAudio(var_1_0, "#go_gm/#btn_one")
		arg_1_0._btnten = gohelper.findChildButtonWithAudio(var_1_0, "#go_gm/#btn_ten")
		arg_1_0._btnhundred = gohelper.findChildButtonWithAudio(var_1_0, "#go_gm/#btn_hundred")
		arg_1_0._btnthousand = gohelper.findChildButtonWithAudio(var_1_0, "#go_gm/#btn_thousand")
		arg_1_0._btntenthousand = gohelper.findChildButtonWithAudio(var_1_0, "#go_gm/#btn_tenthousand")
		arg_1_0._btntenmillion = gohelper.findChildButtonWithAudio(var_1_0, "#go_gm/#btn_tenmillion")
		arg_1_0._btninput = gohelper.findChildButtonWithAudio(var_1_0, "#go_gm/#btn_input")
	end

	arg_1_0._simageblur = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_blur")
	arg_1_0._simagepropicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "iconbg/#simage_propicon")
	arg_1_0._goequipicon = gohelper.findChild(arg_1_0.viewGO, "iconbg/#go_equipicon")
	arg_1_0._simageequipicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "iconbg/#go_equipicon/#simage_equipicon")
	arg_1_0._gohadnumber = gohelper.findChild(arg_1_0.viewGO, "iconbg/#go_hadnumber")
	arg_1_0._txthadnumber = gohelper.findChildText(arg_1_0.viewGO, "iconbg/#go_hadnumber/#txt_hadnumber")
	arg_1_0._btndetail = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "iconbg/#btn_detail")
	arg_1_0._btnplayerbg = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "iconbg/#btn_playerbg")
	arg_1_0._txtpropname = gohelper.findChildText(arg_1_0.viewGO, "#txt_propname")
	arg_1_0._txtproptip = gohelper.findChildText(arg_1_0.viewGO, "#txt_proptip")
	arg_1_0._txtexpire = gohelper.findChildText(arg_1_0.viewGO, "#txt_expire")
	arg_1_0._scrolldesc = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_desc")
	arg_1_0._gojumptxt = gohelper.findChild(arg_1_0.viewGO, "#scroll_desc/#go_jumptxt")
	arg_1_0._gojumpItem = gohelper.findChild(arg_1_0.viewGO, "#scroll_desc/#go_jumpItem")
	arg_1_0._gosource = gohelper.findChild(arg_1_0.viewGO, "#scroll_desc/viewport/content/#go_source")
	arg_1_0._txtsource = gohelper.findChildText(arg_1_0.viewGO, "#scroll_desc/viewport/content/#go_source/#txt_source")
	arg_1_0._gouse = gohelper.findChild(arg_1_0.viewGO, "#go_use")
	arg_1_0._gouseDetail = gohelper.findChild(arg_1_0.viewGO, "#go_use/#go_usedetail")
	arg_1_0._inputvalue = gohelper.findChildTextMeshInputField(arg_1_0.viewGO, "#go_use/#go_usedetail/valuebg/#input_value")
	arg_1_0._btnmin = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_use/#go_usedetail/#btn_min")
	arg_1_0._btnsub = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_use/#go_usedetail/#btn_sub")
	arg_1_0._btnadd = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_use/#go_usedetail/#btn_add")
	arg_1_0._btnmax = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_use/#go_usedetail/#btn_max")
	arg_1_0._btnuse = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_use/#btn_use")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "bg/#btn_close")
	arg_1_0._simagebg1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_bg1")
	arg_1_0._simagebg2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_bg2")
	arg_1_0._goinclude = gohelper.findChild(arg_1_0.viewGO, "#go_include")
	arg_1_0._goplayericon = gohelper.findChild(arg_1_0.viewGO, "iconbg/#go_playericon")
	arg_1_0._simageheadicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "iconbg/#go_playericon/#simage_headicon")
	arg_1_0._goupgrade = gohelper.findChild(arg_1_0.viewGO, "iconbg/#go_upgrade")
	arg_1_0._goframe = gohelper.findChild(arg_1_0.viewGO, "iconbg/#go_playericon/#go_frame")
	arg_1_0._goframenode = gohelper.findChild(arg_1_0.viewGO, "iconbg/#go_playericon/#go_framenode")
	arg_1_0._goSummonsimulationtips = gohelper.findChild(arg_1_0.viewGO, "#go_summonpicktips")
	arg_1_0._btnsummonsimulation = gohelper.findChildButton(arg_1_0.viewGO, "#btn_summonSiumlationTips")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end

	arg_1_0._loader = MultiAbLoader.New()
end

function var_0_0.addEvents(arg_2_0)
	if arg_2_0._btnone then
		arg_2_0._btnone:AddClickListener(arg_2_0._btnoneOnClick, arg_2_0)
	end

	if arg_2_0._btnten then
		arg_2_0._btnten:AddClickListener(arg_2_0._btntenOnClick, arg_2_0)
	end

	if arg_2_0._btnhundred then
		arg_2_0._btnhundred:AddClickListener(arg_2_0._btnhundredOnClick, arg_2_0)
	end

	if arg_2_0._btnthousand then
		arg_2_0._btnthousand:AddClickListener(arg_2_0._btnthousandOnClick, arg_2_0)
	end

	if arg_2_0._btntenthousand then
		arg_2_0._btntenthousand:AddClickListener(arg_2_0._btntenthousandOnClick, arg_2_0)
	end

	if arg_2_0._btntenmillion then
		arg_2_0._btntenmillion:AddClickListener(arg_2_0._btntenmillionOnClick, arg_2_0)
	end

	if arg_2_0._btninput then
		arg_2_0._btninput:AddClickListener(arg_2_0._btninputOnClick, arg_2_0)
	end

	if arg_2_0._btnplayerbg then
		arg_2_0._btnplayerbg:AddClickListener(arg_2_0._btnplayerbgOnClick, arg_2_0)
	end

	if arg_2_0._btnsummonsimulation then
		arg_2_0._btnsummonsimulation:AddClickListener(arg_2_0._btnsummonsimulationOnClick, arg_2_0)
	end

	arg_2_0._btndetail:AddClickListener(arg_2_0._btndetailOnClick, arg_2_0)
	arg_2_0._btnmin:AddClickListener(arg_2_0._btnminOnClick, arg_2_0)
	arg_2_0._btnsub:AddClickListener(arg_2_0._btnsubOnClick, arg_2_0)
	arg_2_0._btnadd:AddClickListener(arg_2_0._btnaddOnClick, arg_2_0)
	arg_2_0._btnmax:AddClickListener(arg_2_0._btnmaxOnClick, arg_2_0)
	arg_2_0._btnuse:AddClickListener(arg_2_0._btnuseOnClick, arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._inputvalue:AddOnEndEdit(arg_2_0._onEndEdit, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	if arg_3_0._btnone then
		arg_3_0._btnone:RemoveClickListener()
	end

	if arg_3_0._btnten then
		arg_3_0._btnten:RemoveClickListener()
	end

	if arg_3_0._btnhundred then
		arg_3_0._btnhundred:RemoveClickListener()
	end

	if arg_3_0._btnthousand then
		arg_3_0._btnthousand:RemoveClickListener()
	end

	if arg_3_0._btntenthousand then
		arg_3_0._btntenthousand:RemoveClickListener()
	end

	if arg_3_0._btntenmillion then
		arg_3_0._btntenmillion:RemoveClickListener()
	end

	if arg_3_0._btninput then
		arg_3_0._btninput:RemoveClickListener()
	end

	if arg_3_0._btnplayerbg then
		arg_3_0._btnplayerbg:RemoveClickListener()
	end

	if arg_3_0._btnsummonsimulation then
		arg_3_0._btnsummonsimulation:RemoveClickListener()
	end

	arg_3_0._btndetail:RemoveClickListener()
	arg_3_0._btnmin:RemoveClickListener()
	arg_3_0._btnsub:RemoveClickListener()
	arg_3_0._btnadd:RemoveClickListener()
	arg_3_0._btnmax:RemoveClickListener()
	arg_3_0._btnuse:RemoveClickListener()
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._inputvalue:RemoveOnEndEdit()
end

local var_0_1 = math.floor
local var_0_2 = string.format
local var_0_3 = table.insert
local var_0_4 = {
	[MaterialEnum.MaterialType.Item] = {
		[BpEnum.ScoreItemId] = true
	},
	[MaterialEnum.MaterialType.Currency] = {
		[CurrencyEnum.CurrencyType.V1a6CachotCoin] = true,
		[CurrencyEnum.CurrencyType.V1a6CachotCurrency] = true
	}
}

function var_0_0._btndetailOnClick(arg_4_0)
	if not arg_4_0._canJump then
		GameFacade.showToast(ToastEnum.MaterialTipJump)

		return
	end

	JumpController.instance:jumpByParamWithCondition(var_0_2("51#%d", arg_4_0.viewParam.id), arg_4_0._onJumpFinish, arg_4_0)
end

function var_0_0._btnplayerbgOnClick(arg_5_0)
	ViewMgr.instance:openView(ViewName.PlayerChangeBgView, {
		itemMo = arg_5_0.viewParam
	})
end

function var_0_0._btnsummonsimulationOnClick(arg_6_0)
	if not arg_6_0._config then
		return
	end

	if arg_6_0:_isPackageSkin() then
		HelpController.instance:openBpRuleTipsView(luaLang("ruledetail"), "Rule Details", arg_6_0:_getPackageSkinDesc())
	elseif arg_6_0._config.activityId then
		SummonSimulationPickController.instance:openSummonTips(arg_6_0._config.activityId)
	end
end

function var_0_0._onEndEdit(arg_7_0, arg_7_1)
	arg_7_0._valueChanged = false
	arg_7_0._value = tonumber(arg_7_1)

	if arg_7_0._value > arg_7_0:_getMaxValue() then
		arg_7_0._value = arg_7_0:_getMaxValue()

		arg_7_0._inputvalue:SetText(tostring(arg_7_0._value))

		arg_7_0._valueChanged = true

		GameFacade.showToast(ToastEnum.MaterialTipBtnSub)

		return
	end

	if arg_7_0._value < 1 then
		arg_7_0._value = 1

		arg_7_0._inputvalue:SetText(tostring(arg_7_0._value))

		arg_7_0._valueChanged = true

		GameFacade.showToast(ToastEnum.MaterialTipBtnSub)

		return
	end
end

function var_0_0._btncloseOnClick(arg_8_0)
	arg_8_0:closeThis()
end

function var_0_0._btninputOnClick(arg_9_0)
	local var_9_0 = CommonInputMO.New()

	var_9_0.title = "请输入增加道具数量！"
	var_9_0.defaultInput = "Enter Item Num"

	function var_9_0.sureCallback(arg_10_0)
		GameFacade.closeInputBox()

		local var_10_0 = tonumber(arg_10_0)

		if var_10_0 and var_10_0 > 0 then
			arg_9_0:sendGMRequest(var_10_0)
		end
	end

	GameFacade.openInputBox(var_9_0)
end

function var_0_0._btntenmillionOnClick(arg_11_0)
	arg_11_0:sendGMRequest(10000000)
end

function var_0_0._btnoneOnClick(arg_12_0)
	arg_12_0:sendGMRequest(1)
end

function var_0_0._btntenOnClick(arg_13_0)
	arg_13_0:sendGMRequest(10)
end

function var_0_0._btnhundredOnClick(arg_14_0)
	arg_14_0:sendGMRequest(100)
end

function var_0_0._btnthousandOnClick(arg_15_0)
	arg_15_0:sendGMRequest(1000)
end

function var_0_0._btntenthousandOnClick(arg_16_0)
	arg_16_0:sendGMRequest(10000)
end

function var_0_0.sendGMRequest(arg_17_0, arg_17_1)
	GameFacade.showToast(ToastEnum.GMTool5, arg_17_0.viewParam.id)

	if arg_17_0.viewParam.type == MaterialEnum.MaterialType.Item and arg_17_0.viewParam.id == 510001 then
		GMRpc.instance:sendGMRequest(var_0_2("add heroStoryTicket %d", arg_17_1))
	else
		GMRpc.instance:sendGMRequest(var_0_2("add material %d#%d#%d", arg_17_0.viewParam.type, arg_17_0.viewParam.id, arg_17_1))
	end
end

function var_0_0._editableInitView(arg_18_0)
	if arg_18_0._gogm then
		gohelper.setActive(arg_18_0._gogm, GMController.instance:isOpenGM())
	end

	arg_18_0._txtdesc = SLFramework.GameObjectHelper.FindChildComponent(arg_18_0.viewGO, "#scroll_desc/viewport/content/desc", typeof(TMPro.TextMeshProUGUI))
	arg_18_0._txtusedesc = SLFramework.GameObjectHelper.FindChildComponent(arg_18_0.viewGO, "#scroll_desc/viewport/content/usedesc", typeof(TMPro.TextMeshProUGUI))

	gohelper.setActive(arg_18_0._gojumpItem, false)
	gohelper.setActive(arg_18_0._gojumptxt, false)

	arg_18_0.jumpItemGos = {}
	arg_18_0._boxItemGos = {}
	arg_18_0._iconItemList = {}
	arg_18_0._value = 1
	arg_18_0._goincludeScroll = gohelper.findChild(arg_18_0._goinclude, "#scroll_product")
	arg_18_0._goincludeContent = gohelper.findChild(arg_18_0._goinclude, "#scroll_product/viewport/content")
	arg_18_0._contentHorizontal = arg_18_0._goincludeContent:GetComponent(typeof(UnityEngine.UI.HorizontalLayoutGroup))

	arg_18_0._simagebg1:LoadImage(ResUrl.getCommonIcon("bg_1"))
	arg_18_0._simagebg2:LoadImage(ResUrl.getCommonIcon("bg_2"))

	arg_18_0._txtsource.text = luaLang("materialview_source")
	arg_18_0._txtSummonsimulationtips = gohelper.findChildText(arg_18_0._goSummonsimulationtips, "txt_tips")
end

function var_0_0._cloneJumpItem(arg_19_0)
	local var_19_0 = gohelper.findChild(arg_19_0.viewGO, "#scroll_desc/viewport/content")

	arg_19_0._scrolldesc.verticalNormalizedPosition = 1

	local var_19_1 = {}
	local var_19_2 = ViewMgr.instance:isOpen(ViewName.GiftMultipleChoiceView)
	local var_19_3 = ItemModel.instance:getOptionalGiftBySubTypeAndRare(arg_19_0._config.subType, arg_19_0._config.rare, arg_19_0._config.id)

	if var_19_3 then
		for iter_19_0, iter_19_1 in pairs(var_19_3) do
			local var_19_4 = {}

			var_19_4.sourceId = 1
			var_19_4.sourceParam = iter_19_1.id

			table.insert(var_19_1, var_19_4)
		end
	end

	if not string.nilorempty(arg_19_0._config.boxOpen) and not var_19_2 then
		local var_19_5 = string.split(arg_19_0._config.boxOpen, "|")

		for iter_19_2, iter_19_3 in ipairs(var_19_5) do
			local var_19_6 = string.splitToNumber(iter_19_3, "#")
			local var_19_7 = {
				sourceId = var_19_6[1],
				sourceParam = var_19_6[2]
			}

			table.insert(var_19_1, var_19_7)
		end
	end

	if var_19_1 then
		for iter_19_4, iter_19_5 in ipairs(var_19_1) do
			if ItemModel.instance:getItemCount(iter_19_5.sourceParam) > 0 then
				if not arg_19_0._boxItemGos[iter_19_4] then
					local var_19_8 = gohelper.clone(arg_19_0._gojumpItem, var_19_0, "boxitem" .. iter_19_4)
					local var_19_9 = arg_19_0:getUserDataTb_()

					var_19_9.go = var_19_8
					var_19_9.originText = gohelper.findChildText(var_19_8, "layout/originText")
					var_19_9.indexText = gohelper.findChildText(var_19_8, "indexText")
					var_19_9.jumpBtn = gohelper.findChildButtonWithAudio(var_19_8, "jump/jumpBtn")
					var_19_9.hasjump = gohelper.findChild(var_19_8, "jump")
					var_19_9.jumpText = gohelper.findChildText(var_19_8, "jump/jumpBtn/jumpText")
					var_19_9.jumpHardTagGO = gohelper.findChild(var_19_8, "layout/hardtag")
					var_19_9.jumpBgGO = gohelper.findChild(var_19_8, "jump/bg")
					var_19_9.probalityBg = gohelper.findChild(var_19_8, "layout/bg")
					var_19_9.txtProbality = gohelper.findChildText(var_19_8, "layout/bg/probality")

					local var_19_10 = ItemConfig.instance:getItemCo(tonumber(iter_19_5.sourceParam)).name

					var_19_9.jumpText.text = var_0_2(luaLang("level_limit_unlock"), "")
					var_19_9.originText.text = var_0_2("<color=#3f485f><size=32>%s</size></color>", var_0_2(luaLang("material_storage"), var_19_10))
					var_19_9.indexText.text = ""

					table.insert(arg_19_0._boxItemGos, var_19_9)
					var_19_9.jumpBtn:AddClickListener(function(arg_20_0)
						local var_20_0 = ItemModel.instance:getItemCount(arg_19_0._config.id)
						local var_20_1 = ItemModel.instance:getItemCount(iter_19_5.sourceParam)

						GiftModel.instance:reset()

						if arg_19_0.viewParam.needQuantity then
							if var_20_0 > arg_19_0.viewParam.needQuantity or not arg_19_0.viewParam.isConsume then
								arg_19_0._value = 1
							else
								if var_20_1 > arg_19_0.viewParam.needQuantity - var_20_0 then
									arg_19_0._value = arg_19_0.viewParam.needQuantity - var_20_0 == 0 and 1 or arg_19_0.viewParam.needQuantity - var_20_0
								else
									arg_19_0._value = var_20_1
								end

								if var_20_0 < arg_19_0.viewParam.needQuantity then
									GiftModel.instance:setNeedGift(arg_19_0.viewParam.id)
								end
							end
						else
							arg_19_0._value = 1
						end

						MaterialTipController.instance:showMaterialInfo(iter_19_5.sourceId, iter_19_5.sourceParam, true)
					end, var_19_9)
				end

				gohelper.setActive(arg_19_0._boxItemGos[iter_19_4].go, true)
			elseif arg_19_0._boxItemGos[iter_19_4] then
				gohelper.setActive(arg_19_0._boxItemGos[iter_19_4].go, false)
			end
		end
	end

	local var_19_11 = arg_19_0._config.sources
	local var_19_12 = {}

	if not string.nilorempty(var_19_11) then
		local var_19_13 = string.split(var_19_11, "|")

		for iter_19_6, iter_19_7 in ipairs(var_19_13) do
			local var_19_14 = string.splitToNumber(iter_19_7, "#")
			local var_19_15 = {
				sourceId = var_19_14[1],
				probability = var_19_14[2]
			}

			var_19_15.episodeId = JumpConfig.instance:getJumpEpisodeId(var_19_15.sourceId)

			if JumpConfig.instance:isOpenJumpId(var_19_15.sourceId) and (var_19_15.probability ~= MaterialEnum.JumpProbability.Normal or not DungeonModel.instance:hasPassLevel(var_19_15.episodeId)) then
				table.insert(var_19_12, var_19_15)
			end
		end
	end

	local var_19_16 = DungeonConfig.instance:getMaterialSource(arg_19_0.viewParam.type, arg_19_0.viewParam.id)

	if var_19_16 then
		for iter_19_8, iter_19_9 in ipairs(var_19_16) do
			local var_19_17 = {}

			var_19_17.sourceId = -1
			var_19_17.probability = iter_19_9.probability
			var_19_17.episodeId = iter_19_9.episodeId
			var_19_17.jumpParam = var_0_2("4#%s", iter_19_9.episodeId)

			local var_19_18 = false
			local var_19_19 = iter_19_9.episodeId and DungeonConfig.instance:getEpisodeCO(iter_19_9.episodeId)

			if var_19_19 then
				var_19_18 = ResSplitConfig.instance:isSaveChapter(var_19_19.chapterId)
			end

			var_19_17.isOpen = var_19_18

			table.insert(var_19_12, var_19_17)
		end
	end

	for iter_19_10 = 1, #var_19_12 do
		local var_19_20 = arg_19_0.jumpItemGos[iter_19_10]

		if not var_19_20 then
			local var_19_21 = gohelper.clone(arg_19_0._gojumpItem, var_19_0, "item" .. iter_19_10)

			var_19_20 = arg_19_0:getUserDataTb_()
			var_19_20.go = var_19_21
			var_19_20.originText = gohelper.findChildText(var_19_21, "layout/originText")
			var_19_20.indexText = gohelper.findChildText(var_19_21, "indexText")
			var_19_20.jumpBtn = gohelper.findChildButtonWithAudio(var_19_21, "jump/jumpBtn")
			var_19_20.hasjump = gohelper.findChild(var_19_21, "jump")
			var_19_20.jumpText = gohelper.findChildText(var_19_21, "jump/jumpBtn/jumpText")
			var_19_20.jumpHardTagGO = gohelper.findChild(var_19_21, "layout/hardtag")
			var_19_20.jumpBgGO = gohelper.findChild(var_19_21, "jump/bg")
			var_19_20.probalityBg = gohelper.findChild(var_19_21, "layout/bg")
			var_19_20.txtProbality = gohelper.findChildText(var_19_21, "layout/bg/probality")

			table.insert(arg_19_0.jumpItemGos, var_19_20)
			var_19_20.jumpBtn:AddClickListener(function(arg_21_0)
				if arg_21_0.cantJumpTips then
					GameFacade.showToastWithTableParam(arg_21_0.cantJumpTips, arg_21_0.cantJumpParam)
				elseif arg_21_0.canJump then
					if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.ForceJumpToMainView) then
						NavigateButtonsView.homeClick()

						return
					end

					if arg_21_0.jumpParam then
						ViewMgr.instance:closeView(ViewName.RoomInitBuildingView)
						JumpController.instance:jumpTo(arg_21_0.jumpParam, arg_19_0._onJumpFinish, arg_19_0, arg_19_0.viewParam.recordFarmItem)
					else
						JumpController.instance:dispatchEvent(JumpEvent.JumpBtnClick, arg_21_0.jumpId)
						GameFacade.jump(arg_21_0.jumpId, arg_19_0._onJumpFinish, arg_19_0, arg_19_0.viewParam.recordFarmItem)
						arg_19_0:statJump(arg_21_0.jumpId)
					end
				else
					GameFacade.showToast(ToastEnum.MaterialTipJump)
				end
			end, var_19_20)
		end

		local var_19_22 = var_19_12[iter_19_10]

		var_19_20.canJump = arg_19_0._canJump
		var_19_20.jumpId = var_19_22.sourceId
		var_19_20.jumpParam = var_19_22.jumpParam

		local var_19_23 = var_19_22.sourceId ~= -1 and JumpConfig.instance:getJumpConfig(var_19_22.sourceId)
		local var_19_24 = ""
		local var_19_25 = ""

		if var_19_22.sourceId == -1 then
			var_19_24, var_19_25 = JumpConfig.instance:getEpisodeNameAndIndex(var_19_22.episodeId)
		elseif string.nilorempty(var_19_23.param) then
			var_19_24 = var_19_23.name
		else
			var_19_24, var_19_25 = JumpConfig.instance:getJumpName(var_19_22.sourceId)
		end

		var_19_20.originText.text = var_19_24 or ""
		var_19_20.indexText.text = var_19_25 or ""

		local var_19_26 = var_19_22.episodeId and var_19_22.probability and MaterialEnum.JumpProbabilityDisplay[var_19_22.probability]

		var_19_20.txtProbality.text = var_19_26 and var_0_2("%s", luaLang(MaterialEnum.JumpProbabilityDisplay[var_19_22.probability])) or ""
		var_19_20.jumpText.text = luaLang("p_materialtip_jump")

		gohelper.setActive(var_19_20.probalityBg, var_19_26 and true or false)

		local var_19_27 = var_19_23 and var_19_23.param or var_19_22.jumpParam
		local var_19_28

		if var_19_22.sourceId == -1 then
			var_19_28 = var_19_22.isOpen
		elseif var_19_22.sourceId == JumpEnum.BPChargeView then
			var_19_28 = not BpModel.instance:isEnd() and JumpController.instance:isJumpOpen(var_19_22.sourceId)
		else
			var_19_28 = JumpController.instance:isJumpOpen(var_19_22.sourceId)
		end

		local var_19_29
		local var_19_30

		if not var_19_28 and var_19_22.sourceId ~= -1 then
			var_19_29, var_19_30 = OpenHelper.getToastIdAndParam(var_19_23.openId)
		else
			var_19_29, var_19_30 = JumpController.instance:cantJump(var_19_27)
		end

		local var_19_31 = string.split(var_19_27, "#")

		if tonumber(var_19_31[1]) == JumpEnum.JumpView.RoomProductLineView and not var_19_29 then
			local var_19_32
			local var_19_33
			local var_19_34
			local var_19_35, var_19_36, var_19_37 = RoomProductionHelper.isChangeFormulaUnlock(arg_19_0.viewParam.type, arg_19_0.viewParam.id)
			local var_19_38 = var_19_37
			local var_19_39 = var_19_36

			if not var_19_35 then
				var_19_29 = var_19_39
				var_19_30 = var_19_38 and {
					var_19_38
				} or nil
			end
		end

		local var_19_40 = var_19_22.sourceId ~= -1 and JumpController.instance:isOnlyShowJump(var_19_22.sourceId)

		gohelper.setActive(var_19_20.hasjump, not var_19_40)
		ZProj.UGUIHelper.SetGrayscale(var_19_20.jumpText.gameObject, var_19_29 ~= nil)
		ZProj.UGUIHelper.SetGrayscale(var_19_20.jumpBgGO, var_19_29 ~= nil)

		var_19_20.cantJumpTips = var_19_29
		var_19_20.cantJumpParam = var_19_30

		gohelper.setActive(var_19_20.jumpHardTagGO, JumpConfig.instance:isJumpHardDungeon(var_19_22.episodeId))
		gohelper.setActive(var_19_20.go, true)
	end

	gohelper.setActive(arg_19_0._gosource, #var_19_12 > 0 or #var_19_1 > 0)

	for iter_19_11 = #var_19_1 + 1, #arg_19_0._boxItemGos do
		gohelper.setActive(arg_19_0._boxItemGos[iter_19_11].go, false)
	end

	for iter_19_12 = #var_19_12 + 1, #arg_19_0.jumpItemGos do
		gohelper.setActive(arg_19_0.jumpItemGos[iter_19_12].go, false)
	end
end

function var_0_0._setJumpMaxIndexWidth(arg_22_0, arg_22_1)
	local var_22_0 = 0

	for iter_22_0 = 1, arg_22_1 do
		local var_22_1 = arg_22_0.jumpItemGos[iter_22_0]

		if var_22_1 then
			local var_22_2 = var_22_1.indexText.preferredWidth

			if var_22_0 < var_22_2 then
				var_22_0 = var_22_2
			end
		end
	end

	for iter_22_1 = 1, arg_22_1 do
		local var_22_3 = arg_22_0.jumpItemGos[iter_22_1]

		if var_22_3 then
			local var_22_4 = var_22_3.indexText.text

			recthelper.setAnchorX(var_22_3.originText.transform, var_22_0 > 0 and var_22_0 + 15 or -4)
		end
	end
end

function var_0_0._onJumpFinish(arg_23_0)
	ViewMgr.instance:closeView(ViewName.MaterialPackageTipView)
	arg_23_0:closeThis()

	if arg_23_0.viewParam.jumpFinishCallback then
		arg_23_0.viewParam.jumpFinishCallback(arg_23_0.viewParam.jumpFinishCallbackObj, arg_23_0.viewParam.jumpFinishCallbackParam)
	end
end

function var_0_0._btnuseOnClick(arg_24_0)
	if arg_24_0._valueChanged then
		arg_24_0._valueChanged = false

		return
	end

	arg_24_0._value = tonumber(arg_24_0._inputvalue:GetText())

	if arg_24_0._value > arg_24_0:_getMaxValue() then
		arg_24_0._value = arg_24_0:_getMaxValue()

		arg_24_0._inputvalue:SetText(tostring(arg_24_0._value))
		GameFacade.showToast(ToastEnum.MaterialTipBtnSub)

		return
	end

	if arg_24_0._value < 1 then
		arg_24_0._value = 1

		arg_24_0._inputvalue:SetText(tostring(arg_24_0._value))
		GameFacade.showToast(ToastEnum.MaterialTipBtnSub)

		return
	end

	local var_24_0 = arg_24_0._config.id
	local var_24_1 = arg_24_0._value

	if arg_24_0.viewParam.type == MaterialEnum.MaterialType.PowerPotion then
		CurrencyController.instance:openPowerView()

		return
	elseif arg_24_0.viewParam.type == MaterialEnum.MaterialType.NewInsight then
		arg_24_0:closeThis()
		GiftController.instance:openGiftInsightHeroChoiceView(arg_24_0.viewParam)

		return
	end

	if arg_24_0:_isSummonSkin() then
		MaterialTipController.instance:_openView_LifeCirclePickChoice(arg_24_0._config, var_24_1)
	elseif arg_24_0:_isPackageSkin() then
		CharacterModel.instance:setGainHeroViewShowState(false)
		CharacterModel.instance:setGainHeroViewNewShowState(false)
		ItemRpc.instance:simpleSendUseItemRequest(var_24_0, var_24_1)
	elseif arg_24_0._config.subType == ItemEnum.SubType.SpecifiedGift then
		local var_24_2 = {
			param = arg_24_0.viewParam,
			quantity = var_24_1,
			subType = arg_24_0._config.subType
		}

		GiftController.instance:openGiftMultipleChoiceView(var_24_2)
	elseif arg_24_0._config.subType == ItemEnum.SubType.OptionalGift then
		local var_24_3 = {
			param = arg_24_0.viewParam,
			quantity = var_24_1,
			subType = arg_24_0._config.subType
		}

		GiftController.instance:openOptionalGiftMultipleChoiceView(var_24_3)
	elseif arg_24_0._config.subType == ItemEnum.SubType.OptionalHeroGift then
		if string.nilorempty(arg_24_0._config.effect) then
			return
		end

		local var_24_4 = string.splitToNumber(arg_24_0._config.effect, "#")
		local var_24_5 = CustomPickChoiceEnum.style.OptionalHeroGift
		local var_24_6 = {
			id = arg_24_0._config.id,
			quantity = var_24_1,
			styleId = var_24_5
		}

		if arg_24_0._config.id == ItemEnum.NewbiePackGiftId then
			CustomPickChoiceController.instance:openNewBiePickChoiceView(var_24_4, MaterialTipController.onUseOptionalHeroGift, MaterialTipController, var_24_6)
		else
			CustomPickChoiceController.instance:openCustomPickChoiceView(var_24_4, MaterialTipController.onUseOptionalHeroGift, MaterialTipController, var_24_6)
		end
	elseif arg_24_0._config.subType == ItemEnum.SubType.SkinTicket then
		StoreController.instance:openStoreView(500)
	elseif arg_24_0._config.subType == ItemEnum.SubType.DecorateDiscountTicket then
		StoreController.instance:openStoreView(801)
	elseif arg_24_0._config.subType == ItemEnum.SubType.RoomTicket then
		GameFacade.showMessageBox(MessageBoxIdDefine.GoToUseRoomTicket, MsgBoxEnum.BoxType.Yes_No, arg_24_0._useRoomTicket, nil, nil, arg_24_0, nil, nil)
	elseif arg_24_0._config.subType == ItemEnum.SubType.SummonSimulationPick then
		local var_24_7 = arg_24_0._config.activityId

		arg_24_0:_tryUseSummonSimulation(var_24_7)

		return
	elseif arg_24_0._config.subType == ItemEnum.SubType.SelfSelectSix then
		if string.nilorempty(arg_24_0._config.effect) then
			return
		end

		local var_24_8 = string.split(arg_24_0._config.effect, "|")
		local var_24_9 = {
			quantity = 1,
			id = arg_24_0._config.id
		}

		V2a7_SelfSelectSix_PickChoiceController.instance:openCustomPickChoiceView(var_24_8, MaterialTipController.onUseSelfSelectSixHeroGift, MaterialTipController, var_24_9)
	elseif arg_24_0._config.subType == ItemEnum.SubType.DestinyStoneUp then
		if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.DestinyStone) then
			local var_24_10 = lua_open.configDict[OpenEnum.UnlockFunc.DestinyStone].episodeId

			if not DungeonModel.instance:hasPassLevel(var_24_10) then
				local var_24_11 = DungeonConfig.instance:getEpisodeDisplay(var_24_10)

				GameFacade.showToast(ToastEnum.DungeonMapLevel, var_24_11)
			end

			return
		end

		local var_24_12 = arg_24_0._config.effect
		local var_24_13

		if not string.nilorempty(var_24_12) then
			local var_24_14 = GameUtil.splitString2(var_24_12, true)

			if var_24_14[2] then
				var_24_13 = var_24_14[2]
			end
		end

		local var_24_15 = HeroModel.instance:getAllHero()
		local var_24_16 = {}

		for iter_24_0, iter_24_1 in pairs(var_24_15) do
			if iter_24_1 and arg_24_0:checkHeroOpenDestinyStone(iter_24_1) and not iter_24_1.destinyStoneMo:checkAllUnlock() and not arg_24_0:checkIgnoreAllDestinyStone(iter_24_1.destinyStoneMo, var_24_13) then
				table.insert(var_24_16, iter_24_1)
			end
		end

		if #var_24_16 > 0 then
			local var_24_17 = {
				materialId = var_24_0,
				ignoreIds = var_24_13
			}

			ViewMgr.instance:openView(ViewName.DestinyStoneGiftPickChoiceView, var_24_17)
		else
			GameFacade.showToast(ToastEnum.NoHeroCanDestinyUp)
		end
	elseif arg_24_0._config.subType == ItemEnum.SubType.RoomBlockGiftNew then
		local function var_24_18()
			RoomBlockGiftController.instance:openBlockView(arg_24_0._config.id, arg_24_0.closeThis, arg_24_0)
		end

		RoomRpc.instance:sendGetRoomInfoRequest(var_24_18, arg_24_0)

		return
	else
		ItemRpc.instance:simpleSendUseItemRequest(var_24_0, var_24_1)
	end

	arg_24_0:closeThis()
end

function var_0_0.checkIgnoreAllDestinyStone(arg_26_0, arg_26_1, arg_26_2)
	local var_26_0 = arg_26_1:getStoneMoList()

	for iter_26_0, iter_26_1 in pairs(var_26_0) do
		if not LuaUtil.tableContains(arg_26_2, iter_26_1.stoneId) then
			return false
		end
	end

	return true
end

function var_0_0.checkHeroOpenDestinyStone(arg_27_0, arg_27_1)
	if not arg_27_1:isHasDestinySystem() then
		return false
	end

	local var_27_0 = arg_27_1.config.rare or 5
	local var_27_1 = CharacterDestinyEnum.DestinyStoneOpenLevelConstId[var_27_0]
	local var_27_2 = CommonConfig.instance:getConstStr(var_27_1)

	if arg_27_1.level >= tonumber(var_27_2) then
		return true
	end

	return false
end

function var_0_0._useRoomTicket(arg_28_0)
	GameFacade.jump(JumpEnum.JumpId.RoomStore, arg_28_0._onJumpFinish, arg_28_0)
end

function var_0_0._tryUseSummonSimulation(arg_29_0, arg_29_1)
	SummonSimulationPickController.instance:registerCallback(SummonSimulationEvent.onGetSummonInfo, arg_29_0._realUseSummonSimulation, arg_29_0)
	SummonSimulationPickController.instance:getActivityInfo(arg_29_1)
end

function var_0_0._realUseSummonSimulation(arg_30_0, arg_30_1)
	SummonSimulationPickController.instance:unregisterCallback(SummonSimulationEvent.onGetSummonInfo, arg_30_0._realUseSummonSimulation, arg_30_0)
	SummonSimulationPickController.instance:trySummonSimulation(arg_30_1)
	arg_30_0:closeThis()
end

function var_0_0._btnaddOnClick(arg_31_0)
	if arg_31_0._valueChanged then
		arg_31_0._valueChanged = false

		return
	end

	arg_31_0._value = tonumber(arg_31_0._inputvalue:GetText())

	if arg_31_0._value >= arg_31_0:_getMaxValue() then
		arg_31_0._value = arg_31_0:_getMaxValue()

		arg_31_0._inputvalue:SetText(tostring(arg_31_0._value))
		GameFacade.showToast(ToastEnum.MaterialTipBtnSub)

		return
	end

	arg_31_0._value = arg_31_0._value + 1

	arg_31_0:_refreshValue()
end

function var_0_0._btnsubOnClick(arg_32_0)
	if arg_32_0._valueChanged then
		arg_32_0._valueChanged = false

		return
	end

	arg_32_0._value = tonumber(arg_32_0._inputvalue:GetText())

	if arg_32_0._value <= 1 then
		arg_32_0._value = 1

		arg_32_0._inputvalue:SetText(tostring(arg_32_0._value))
		GameFacade.showToast(ToastEnum.MaterialTipBtnSub)

		return
	end

	arg_32_0._value = arg_32_0._value - 1

	arg_32_0:_refreshValue()
end

function var_0_0._btnmaxOnClick(arg_33_0)
	arg_33_0._value = arg_33_0:_getMaxValue()

	arg_33_0:_refreshValue()
end

function var_0_0._btnminOnClick(arg_34_0)
	arg_34_0._value = 1

	arg_34_0:_refreshValue()
end

function var_0_0.onDestroyView(arg_35_0)
	return
end

function var_0_0._refreshValue(arg_36_0)
	arg_36_0._inputvalue:SetText(tostring(arg_36_0._value))
end

function var_0_0._getMaxValue(arg_37_0)
	if arg_37_0._config.isStackable == 1 then
		local var_37_0 = ItemModel.instance:getItemCount(arg_37_0._config.id)
		local var_37_1 = ItemConfig.instance:getItemUseCo(arg_37_0._config.subType)

		if var_37_1.useType == 2 then
			return 1
		elseif var_37_1.useType == 6 then
			return var_37_0 > var_37_1.use_max and var_37_1.use_max or var_37_0
		end
	end

	return 1
end

function var_0_0.onOpen(arg_38_0)
	arg_38_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_38_0._refreshItemQuantity, arg_38_0)
	arg_38_0:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, arg_38_0._refreshItemQuantity, arg_38_0)
	arg_38_0:addGmBtnAudio()
	arg_38_0:_refreshUI()
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Tipsopen)
end

function var_0_0.onUpdateParam(arg_39_0)
	arg_39_0:_refreshUI()
end

function var_0_0.addGmBtnAudio(arg_40_0)
	if arg_40_0._btnone then
		gohelper.addUIClickAudio(arg_40_0._btnone.gameObject, AudioEnum.UI.Play_UI_Tipsopen)
	end

	if arg_40_0._btnten then
		gohelper.addUIClickAudio(arg_40_0._btnten.gameObject, AudioEnum.UI.Play_UI_Tipsopen)
	end

	if arg_40_0._btnhundred then
		gohelper.addUIClickAudio(arg_40_0._btnhundred.gameObject, AudioEnum.UI.Play_UI_Tipsopen)
	end

	if arg_40_0._btnthousand then
		gohelper.addUIClickAudio(arg_40_0._btnthousand.gameObject, AudioEnum.UI.Play_UI_Tipsopen)
	end

	if arg_40_0._btntenthousand then
		gohelper.addUIClickAudio(arg_40_0._btntenthousand.gameObject, AudioEnum.UI.Play_UI_Tipsopen)
	end

	if arg_40_0._btntenmillion then
		gohelper.addUIClickAudio(arg_40_0._btntenmillion.gameObject, AudioEnum.UI.Play_UI_Tipsopen)
	end

	if arg_40_0._btninput then
		gohelper.addUIClickAudio(arg_40_0._btninput.gameObject, AudioEnum.UI.Play_UI_Tipsopen)
	end
end

function var_0_0._refreshUI(arg_41_0)
	arg_41_0._canJump = arg_41_0.viewParam.canJump

	if arg_41_0._txtmattip then
		arg_41_0._txtmattip.text = tostring(arg_41_0.viewParam.type) .. "#" .. tostring(arg_41_0.viewParam.id)
	end

	arg_41_0._config, arg_41_0._icon = ItemModel.instance:getItemConfigAndIcon(arg_41_0.viewParam.type, arg_41_0.viewParam.id)

	if arg_41_0.viewParam.type == MaterialEnum.MaterialType.Equip then
		arg_41_0._icon = ResUrl.getEquipIcon(arg_41_0._config.icon)
	elseif arg_41_0._config.subType == ItemEnum.SubType.Portrait then
		arg_41_0._icon = ResUrl.getPlayerHeadIcon(arg_41_0._config.icon)
	end

	gohelper.setActive(arg_41_0._simagepropicon.gameObject, false)

	if arg_41_0:_isUseBtnShow() then
		gohelper.setActive(arg_41_0._gouse, true)

		local var_41_0 = true

		if arg_41_0.viewParam.type == MaterialEnum.MaterialType.PowerPotion then
			var_41_0 = false
		elseif arg_41_0._config.subType == ItemEnum.SubType.RoomTicket then
			var_41_0 = false
		elseif arg_41_0._config.subType == ItemEnum.SubType.SkinTicket then
			var_41_0 = false
		elseif arg_41_0._config.subType == ItemEnum.SubType.DecorateDiscountTicket then
			var_41_0 = false
		elseif arg_41_0.viewParam.type == MaterialEnum.MaterialType.NewInsight then
			var_41_0 = false
		elseif arg_41_0._config.subType == ItemEnum.SubType.SelfSelectSix then
			var_41_0 = false

			recthelper.setAnchorY(arg_41_0._btnuse.transform, -190)
		elseif arg_41_0._config.subType == ItemEnum.SubType.RoomBlockGiftNew then
			var_41_0 = false

			recthelper.setAnchorY(arg_41_0._btnuse.transform, -190)
			recthelper.setAnchorY(arg_41_0._goincludeScroll.transform, 45)
		end

		gohelper.setActive(arg_41_0._gouseDetail, var_41_0)
	else
		gohelper.setActive(arg_41_0._gouse, false)
	end

	if arg_41_0._config.subType ~= ItemEnum.SubType.Portrait then
		arg_41_0._simageequipicon:LoadImage(arg_41_0._icon)
	end

	arg_41_0._txtproptip.text = ""
	arg_41_0._txtexpire.text = ""
	arg_41_0._txtpropname.text = arg_41_0._config.name

	TaskDispatcher.cancelTask(arg_41_0._onRefreshPowerPotionDeadline, arg_41_0)
	TaskDispatcher.cancelTask(arg_41_0._onRefreshItemDeadline, arg_41_0)

	local var_41_1 = arg_41_0._config.subType == ItemEnum.SubType.Portrait

	gohelper.setActive(arg_41_0._goequipicon, false)

	if arg_41_0.viewParam.type == MaterialEnum.MaterialType.PowerPotion then
		arg_41_0:_onRefreshPowerPotionDeadline()
		gohelper.setActive(arg_41_0._simagepropicon.gameObject, true)
		arg_41_0._simagepropicon:LoadImage(arg_41_0._icon)
		TaskDispatcher.runRepeat(arg_41_0._onRefreshPowerPotionDeadline, arg_41_0, 1)
	elseif arg_41_0.viewParam.type == MaterialEnum.MaterialType.NewInsight then
		arg_41_0:_onRefreshNewInsightDeadline()
		gohelper.setActive(arg_41_0._simagepropicon.gameObject, true)
		arg_41_0._simagepropicon:LoadImage(arg_41_0._icon)
		TaskDispatcher.runRepeat(arg_41_0._onRefreshNewInsightDeadline, arg_41_0, 1)
	elseif arg_41_0.viewParam.type == MaterialEnum.MaterialType.Equip then
		gohelper.setActive(arg_41_0._goequipicon, true)
	else
		arg_41_0:_onRefreshItemDeadline()

		if var_41_1 then
			if not arg_41_0._liveHeadIcon then
				arg_41_0._liveHeadIcon = IconMgr.instance:getCommonLiveHeadIcon(arg_41_0._simageheadicon)
			end

			arg_41_0._liveHeadIcon:setLiveHead(arg_41_0._config.id, true)
		else
			if arg_41_0._liveHeadIcon then
				arg_41_0._liveHeadIcon:setVisible(false)
			end

			arg_41_0._simagepropicon:LoadImage(arg_41_0._icon, arg_41_0._setIconNativeSize, arg_41_0)
		end

		gohelper.setActive(arg_41_0._simagepropicon.gameObject, not var_41_1)
		TaskDispatcher.runRepeat(arg_41_0._onRefreshItemDeadline, arg_41_0, 1)
	end

	arg_41_0._txtdesc.text = arg_41_0._config.desc
	arg_41_0._txtusedesc.text = arg_41_0._config.useDesc

	arg_41_0:_refreshItemQuantity()
	arg_41_0:_refreshItemQuantityVisible()
	gohelper.setActive(arg_41_0._btndetail.gameObject, arg_41_0.viewParam.type == MaterialEnum.MaterialType.Equip)
	gohelper.setActive(arg_41_0._btnplayerbg, false)
	gohelper.setActive(arg_41_0._goplayericon, arg_41_0._config.subType == ItemEnum.SubType.Portrait)

	local var_41_2 = arg_41_0._config.subType == ItemEnum.SubType.SummonSimulationPick
	local var_41_3 = var_41_2 or arg_41_0:_isPackageSkin()

	gohelper.setActive(arg_41_0._goSummonsimulationtips, var_41_3)
	gohelper.setActive(arg_41_0._btnsummonsimulation, var_41_3)

	local var_41_4 = arg_41_0.viewParam.type == MaterialEnum.MaterialType.Exp

	gohelper.setActive(arg_41_0._gohadnumber, not var_41_4 and arg_41_0._config.subType ~= ItemEnum.SubType.Portrait and not arg_41_0:_checkIsFakeIcon())
	gohelper.setActive(arg_41_0._goupgrade, arg_41_0._config.subType == ItemEnum.SubType.Portrait and not string.nilorempty(arg_41_0._config.effect))

	local var_41_5 = string.split(arg_41_0._config.effect, "#")

	if arg_41_0._config.subType == ItemEnum.SubType.Portrait then
		if #var_41_5 > 1 then
			if arg_41_0._config.id == tonumber(var_41_5[#var_41_5]) then
				gohelper.setActive(arg_41_0._goupgrade, false)
				gohelper.setActive(arg_41_0._goframe, false)
				gohelper.setActive(arg_41_0._goframenode, true)

				local var_41_6 = "ui/viewres/common/effect/frame.prefab"

				arg_41_0._loader:addPath(var_41_6)
				arg_41_0._loader:startLoad(arg_41_0._onLoadCallback, arg_41_0)
			end
		else
			gohelper.setActive(arg_41_0._goframe, true)
			gohelper.setActive(arg_41_0._goframenode, false)
		end
	end

	arg_41_0:_refreshValue()
	arg_41_0:_refreshInclude()
	arg_41_0:_cloneJumpItem()

	if arg_41_0:_isUseBtnShow() then
		recthelper.setHeight(arg_41_0._scrolldesc.transform, 180)
	elseif arg_41_0._goinclude.activeInHierarchy then
		recthelper.setHeight(arg_41_0._scrolldesc.transform, 162)
	else
		recthelper.setHeight(arg_41_0._scrolldesc.transform, 415)
	end

	if var_41_3 then
		if var_41_2 then
			arg_41_0._txtSummonsimulationtips.text = luaLang("p_normalstoregoodsview_txt_summonpicktips")
		end

		if arg_41_0:_isPackageSkin() then
			arg_41_0._txtSummonsimulationtips.text = luaLang("ruledetail")
		end
	end
end

function var_0_0._checkIsFakeIcon(arg_42_0)
	if not var_0_4[arg_42_0.viewParam.type] then
		return false
	end

	return var_0_4[arg_42_0.viewParam.type][arg_42_0.viewParam.id] or false
end

function var_0_0._onRefreshPowerPotionDeadline(arg_43_0)
	local var_43_0 = ItemPowerModel.instance:getPowerItemDeadline(arg_43_0.viewParam.uid)

	if arg_43_0._config.expireType ~= 0 and arg_43_0.viewParam.uid then
		if var_43_0 <= ServerTime.now() then
			arg_43_0._txtproptip.text = ""
			arg_43_0._txtexpire.text = luaLang("hasExpire")
		else
			local var_43_1 = math.floor(var_43_0 - ServerTime.now())

			arg_43_0._txtproptip.text = arg_43_0:getRemainTimeStr(var_43_1)
		end
	else
		arg_43_0._txtproptip.text = ""
		arg_43_0._txtexpire.text = ""

		TaskDispatcher.cancelTask(arg_43_0._onRefreshPowerPotionDeadline, arg_43_0)
	end
end

function var_0_0._onRefreshNewInsightDeadline(arg_44_0)
	local var_44_0 = ItemInsightModel.instance:getInsightItemDeadline(arg_44_0.viewParam.uid)

	if arg_44_0._config.expireHours == ItemEnum.NoExpiredNum then
		arg_44_0._txtproptip.text = ""
		arg_44_0._txtexpire.text = ""
	elseif arg_44_0._config.expireType ~= 0 and arg_44_0.viewParam.uid then
		if var_44_0 <= ServerTime.now() then
			arg_44_0._txtproptip.text = ""
			arg_44_0._txtexpire.text = luaLang("hasExpire")
		else
			local var_44_1 = math.floor(var_44_0 - ServerTime.now())

			arg_44_0._txtproptip.text = arg_44_0:getRemainTimeStr(var_44_1)
		end
	else
		local var_44_2 = ItemConfig.instance:getInsightItemCo(arg_44_0.viewParam.id).expireHours

		arg_44_0._txtproptip.text = arg_44_0:getInsightItemRemainTimeStr(var_44_2)
		arg_44_0._txtexpire.text = ""

		TaskDispatcher.cancelTask(arg_44_0._onRefreshNewInsightDeadline, arg_44_0)
	end
end

function var_0_0.getRemainTimeStr(arg_45_0, arg_45_1)
	local var_45_0 = TimeUtil.secondToRoughTime3(arg_45_1, false)

	return var_45_0 and var_0_2(luaLang("remain"), " " .. var_45_0) or ""
end

function var_0_0.getInsightItemRemainTimeStr(arg_46_0, arg_46_1)
	local var_46_0 = TimeUtil.secondToRoughTime2(arg_46_1 * 3600, false)

	return var_46_0 and GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("newinsight_item_detail_remain_time"), var_46_0) or ""
end

function var_0_0._onRefreshItemDeadline(arg_47_0)
	if arg_47_0._config.isShow == 1 and arg_47_0._config.isTimeShow == 1 and arg_47_0._config.expireTime and arg_47_0._config.expireTime ~= "" then
		local var_47_0 = TimeUtil.stringToTimestamp(arg_47_0._config.expireTime)

		if var_47_0 <= ServerTime.now() then
			arg_47_0._txtproptip.text = ""
			arg_47_0._txtexpire.text = luaLang("hasExpire")
		else
			local var_47_1 = math.floor(var_47_0 - ServerTime.now())

			arg_47_0._txtproptip.text = arg_47_0:getRemainTimeStr(var_47_1)
		end
	else
		arg_47_0._txtproptip.text = ""
		arg_47_0._txtexpire.text = ""

		TaskDispatcher.cancelTask(arg_47_0._onRefreshItemDeadline, arg_47_0)
	end
end

function var_0_0._onLoadCallback(arg_48_0)
	local var_48_0 = arg_48_0._loader:getFirstAssetItem():GetResource()

	gohelper.clone(var_48_0, arg_48_0._goframenode, "frame")
end

function var_0_0._refreshItemQuantity(arg_49_0)
	local var_49_0 = tostring(GameUtil.numberDisplay(ItemModel.instance:getItemQuantity(arg_49_0.viewParam.type, arg_49_0.viewParam.id, arg_49_0.viewParam.uid, arg_49_0.viewParam.fakeQuantity)) or 0)

	arg_49_0._txthadnumber.text = formatLuaLang("materialtipview_itemquantity", var_49_0)
end

function var_0_0._refreshItemQuantityVisible(arg_50_0)
	local var_50_0 = arg_50_0.viewParam.id ~= BpEnum.ScoreItemId
	local var_50_1 = arg_50_0.viewParam.type == MaterialEnum.MaterialType.Exp

	gohelper.setActive(arg_50_0._gohadnumber, var_50_0 and not var_50_1)
	gohelper.setActive(arg_50_0._txthadnumber, var_50_0)
end

function var_0_0._setIconNativeSize(arg_51_0)
	arg_51_0._simagepropicon.gameObject:GetComponent(gohelper.Type_Image):SetNativeSize()
end

function var_0_0._refreshInclude(arg_52_0)
	MaterialTipListModel.instance:clear()

	local var_52_0 = MaterialEnum.SubTypePackages[arg_52_0._config.subType] == true

	var_52_0 = var_52_0 or arg_52_0:_isPackageSkin()
	var_52_0 = var_52_0 and arg_52_0.viewParam.inpack ~= true

	if arg_52_0._config.subType == ItemEnum.SubType.SelfSelectSix or arg_52_0._config.subType == ItemEnum.SubType.RoomBlockGiftNew then
		var_52_0 = true
	end

	gohelper.setActive(arg_52_0._goinclude, var_52_0)

	local var_52_1 = 0
	local var_52_2

	if var_52_0 then
		local var_52_3

		if arg_52_0:_isPackageSkin() then
			var_52_3 = arg_52_0:_getPackageSkinIncludeItems()
		elseif arg_52_0._config.subType == ItemEnum.SubType.OptionalGift then
			var_52_3 = GiftMultipleChoiceListModel.instance:getOptionalGiftInfo(arg_52_0._config.id)
		elseif arg_52_0._config.subType == ItemEnum.SubType.OptionalHeroGift then
			var_52_3 = {}

			local var_52_4 = string.splitToNumber(arg_52_0._config.effect, "#")

			for iter_52_0, iter_52_1 in ipairs(var_52_4) do
				var_52_3[iter_52_0] = {
					4,
					iter_52_1,
					1
				}
			end
		elseif arg_52_0._config.subType == ItemEnum.SubType.SelfSelectSix then
			local var_52_5 = string.split(arg_52_0._config.effect, "|")

			var_52_3 = {}

			for iter_52_2, iter_52_3 in ipairs(var_52_5) do
				local var_52_6 = string.split(iter_52_3, ":")
				local var_52_7 = {}

				if var_52_6[2] and #var_52_6[2] > 0 then
					local var_52_8 = string.splitToNumber(var_52_6[2], ",")

					if #var_52_8 > 0 then
						for iter_52_4, iter_52_5 in ipairs(var_52_8) do
							local var_52_9 = {
								MaterialEnum.MaterialType.Hero,
								iter_52_5
							}

							var_52_9[3] = 1

							table.insert(var_52_3, var_52_9)
						end
					end
				end
			end
		elseif arg_52_0._config.subType == ItemEnum.SubType.RoomBlockGiftNew then
			arg_52_0._contentHorizontal.enabled = false

			if not arg_52_0._content then
				arg_52_0._content = arg_52_0._goincludeContent:GetComponent(typeof(UnityEngine.UI.ContentSizeFitter))
			end

			arg_52_0._content.enabled = false
			var_52_3 = RoomBlockBuildingGiftModel.instance:getGiftBlockMos(arg_52_0._config.id)

			MaterialTipListModel.instance:setData(var_52_3)

			return
		else
			var_52_3 = GameUtil.splitString2(arg_52_0._config.effect, true)
		end

		var_52_1 = #var_52_3

		for iter_52_6, iter_52_7 in ipairs(var_52_3) do
			local var_52_10 = arg_52_0._iconItemList[iter_52_6]

			if var_52_10 == nil then
				local var_52_11 = iter_52_7[1]
				local var_52_12 = iter_52_7[2]
				local var_52_13 = iter_52_7[3]

				var_52_2 = var_52_11

				if var_52_11 == MaterialEnum.MaterialType.Equip then
					var_52_10 = IconMgr.instance:getCommonEquipIcon(arg_52_0._goincludeContent)

					var_52_10:setMOValue(var_52_11, var_52_12, var_52_13, nil, true)
					var_52_10:hideLv(true)

					local function var_52_14()
						MaterialTipController.instance:showMaterialInfo(var_52_11, var_52_12)
					end

					var_52_10:customClick(var_52_14)
				elseif var_52_11 == MaterialEnum.MaterialType.Hero then
					var_52_10 = IconMgr.instance:getCommonItemIcon(arg_52_0._goincludeContent)

					var_52_10:setMOValue(var_52_11, var_52_12, var_52_13, nil, true)
					var_52_10:isShowCount(false)
				elseif var_52_11 == MaterialEnum.MaterialType.HeroSkin then
					var_52_10 = IconMgr.instance:getCommonItemIcon(arg_52_0._goincludeContent)

					var_52_10:setMOValue(var_52_11, var_52_12, var_52_13, nil, true)
					var_52_10:isShowCount(false)
				else
					var_52_10 = IconMgr.instance:getCommonItemIcon(arg_52_0._goincludeContent)

					var_52_10:setMOValue(var_52_11, var_52_12, var_52_13, nil, true)
					var_52_10:isShowCount(true)
				end

				table.insert(arg_52_0._iconItemList, var_52_10)
			end

			var_52_10:setCountFontSize(37.142857142857146)
			gohelper.setActive(var_52_10.go, true)
		end
	end

	if var_52_2 == MaterialEnum.MaterialType.Equip then
		arg_52_0._contentHorizontal.spacing = 6.62
		arg_52_0._contentHorizontal.padding.left = -2
		arg_52_0._contentHorizontal.padding.top = 10
	end

	for iter_52_8 = var_52_1 + 1, #arg_52_0._iconItemList do
		gohelper.setActive(arg_52_0._iconItemList[iter_52_8].go, false)
	end
end

function var_0_0._isUseBtnShow(arg_54_0)
	local var_54_0 = ItemConfig.instance:getItemUseCo(arg_54_0._config.subType)
	local var_54_1 = arg_54_0.viewParam.inpack and var_54_0 and var_54_0.useType ~= 1

	if arg_54_0.viewParam.type == MaterialEnum.MaterialType.PowerPotion and arg_54_0.viewParam.inpack and arg_54_0:_isFromBackpackView() then
		return true
	end

	if arg_54_0.viewParam.type == MaterialEnum.MaterialType.NewInsight and arg_54_0.viewParam.inpack and arg_54_0:_isFromBackpackView() then
		return true
	end

	if arg_54_0._config.subType == ItemEnum.SubType.RoomTicket then
		if ViewMgr.instance:isOpen(ViewName.StoreView) then
			return false
		end

		return var_54_1
	end

	if arg_54_0._config.subType == ItemEnum.SubType.SkinTicket then
		if ViewMgr.instance:isOpen(ViewName.StoreView) then
			return false
		end

		return ItemModel.instance:getItemQuantity(arg_54_0.viewParam.type, arg_54_0.viewParam.id, arg_54_0.viewParam.uid, arg_54_0.viewParam.fakeQuantity) > 0
	end

	if arg_54_0._config.subType == ItemEnum.SubType.DecorateDiscountTicket then
		if ViewMgr.instance:isOpen(ViewName.StoreView) then
			return false
		end

		return ItemModel.instance:getItemQuantity(arg_54_0.viewParam.type, arg_54_0.viewParam.id, arg_54_0.viewParam.uid, arg_54_0.viewParam.fakeQuantity) > 0
	end

	if arg_54_0._config.subType == ItemEnum.SubType.RoomBlockGiftNew then
		return arg_54_0.viewParam.inpack
	end

	return var_54_1
end

function var_0_0._isFromBackpackView(arg_55_0)
	local var_55_0 = ViewMgr.instance:getOpenViewNameList()

	for iter_55_0, iter_55_1 in pairs(var_55_0) do
		if iter_55_1 == ViewName.BackpackView then
			return true
		end
	end

	return false
end

function var_0_0.statJump(arg_56_0, arg_56_1)
	local var_56_0 = arg_56_0.viewParam.id == MaterialEnum.PowerId.SmallPower_Expire
	local var_56_1 = arg_56_0.viewParam.id == MaterialEnum.PowerId.BigPower_Expire

	if var_56_0 or var_56_1 then
		local var_56_2

		if arg_56_1 then
			var_56_2 = JumpConfig.instance:getJumpConfig(arg_56_1)
		end

		if var_56_0 then
			StoreController.instance:statOnClickPowerPotionJump(StatEnum.PowerType.Small, var_56_2.name)
		elseif var_56_1 then
			StoreController.instance:statOnClickPowerPotionJump(StatEnum.PowerType.Big, var_56_2.name)
		end
	end
end

function var_0_0.onClose(arg_57_0)
	TaskDispatcher.cancelTask(arg_57_0._onRefreshPowerPotionDeadline, arg_57_0)
	TaskDispatcher.cancelTask(arg_57_0._onRefreshNewInsightDeadline, arg_57_0)
	TaskDispatcher.cancelTask(arg_57_0._onRefreshItemDeadline, arg_57_0)

	arg_57_0.viewContainer._isCloseImmediate = true

	for iter_57_0 = 1, #arg_57_0.jumpItemGos do
		arg_57_0.jumpItemGos[iter_57_0].jumpBtn:RemoveClickListener()
	end

	for iter_57_1 = 1, #arg_57_0._boxItemGos do
		arg_57_0._boxItemGos[iter_57_1].jumpBtn:RemoveClickListener()
	end

	if arg_57_0._loader then
		arg_57_0._loader:dispose()

		arg_57_0._loader = nil
	end

	arg_57_0._simagepropicon:UnLoadImage()
	arg_57_0._simageheadicon:UnLoadImage()
	arg_57_0._simageequipicon:UnLoadImage()
	arg_57_0._simagebg1:UnLoadImage()
	arg_57_0._simagebg2:UnLoadImage()
end

function var_0_0._isPackageSkin(arg_58_0)
	return arg_58_0._config.clienttag == ItemEnum.Tag.PackageSkin
end

function var_0_0._getPackageSkinDesc(arg_59_0)
	local var_59_0 = ItemConfig.instance:getRewardGroupRateInfoList(arg_59_0._config.effect)
	local var_59_1 = {}

	for iter_59_0, iter_59_1 in ipairs(var_59_0) do
		local var_59_2 = iter_59_1.rate * 100
		local var_59_3 = var_0_1(var_59_2)
		local var_59_4 = var_59_2 - var_59_3

		if var_59_4 ~= 0 then
			local var_59_5 = var_0_1(var_59_4 * 1000 / 100)

			var_59_2 = var_0_2("%s.%s", var_59_3, var_59_5)
		end

		local var_59_6 = iter_59_1.materialId
		local var_59_7 = lua_skin.configDict[var_59_6]
		local var_59_8 = var_59_7.characterId
		local var_59_9 = lua_character.configDict[var_59_8]
		local var_59_10 = {
			var_59_9.name,
			var_59_7.characterSkin,
			var_59_2
		}
		local var_59_11 = GameUtil.getSubPlaceholderLuaLang(luaLang("material_packageskin_rate_desc"), var_59_10)

		var_0_3(var_59_1, var_59_11)
	end

	return formatLuaLang("MaterialTipViewPackageSkinDescFmt", table.concat(var_59_1, "\n"))
end

function var_0_0._getPackageSkinIncludeItems(arg_60_0)
	local var_60_0 = ItemConfig.instance:getRewardGroupRateInfoList(arg_60_0._config.effect)
	local var_60_1 = {}

	for iter_60_0, iter_60_1 in ipairs(var_60_0) do
		var_0_3(var_60_1, {
			iter_60_1.materialType,
			iter_60_1.materialId,
			[3] = 1
		})
	end

	return var_60_1
end

function var_0_0._isSummonSkin(arg_61_0)
	return arg_61_0._config.clienttag == ItemEnum.Tag.SummonSkin
end

return var_0_0
