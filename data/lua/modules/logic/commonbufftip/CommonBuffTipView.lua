module("modules.logic.commonbufftip.CommonBuffTipView", package.seeall)

local var_0_0 = class("CommonBuffTipView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.goclose = gohelper.findChild(arg_1_0.viewGO, "#go_close")
	arg_1_0.goscrolltip = gohelper.findChild(arg_1_0.viewGO, "#scroll_tip")
	arg_1_0.gocontent = gohelper.findChild(arg_1_0.viewGO, "#scroll_tip/Viewport/Content")
	arg_1_0.gotipitem = gohelper.findChild(arg_1_0.viewGO, "#scroll_tip/Viewport/Content/#go_tipitem")

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
	arg_4_0.effectTipItemList = {}
	arg_4_0.effectTipItemPool = {}
	arg_4_0.addEffectIdDict = {}
	arg_4_0.rectTrScrollTip = arg_4_0.goscrolltip:GetComponent(gohelper.Type_RectTransform)
	arg_4_0.rectTrViewGo = arg_4_0.viewGO:GetComponent(gohelper.Type_RectTransform)
	arg_4_0.rectTrContent = arg_4_0.gocontent:GetComponent(gohelper.Type_RectTransform)

	gohelper.setActive(arg_4_0.gotipitem, false)

	arg_4_0.closeClick = gohelper.getClickWithDefaultAudio(arg_4_0.goclose)

	arg_4_0.closeClick:AddClickListener(arg_4_0.closeThis, arg_4_0)

	arg_4_0.scrollTip = SLFramework.UGUI.ScrollRectWrap.Get(arg_4_0.goscrolltip)
end

function var_0_0.setIsShowUI(arg_5_0, arg_5_1)
	if not arg_5_1 then
		arg_5_0:closeThis()
	end
end

function var_0_0.initViewParam(arg_6_0)
	arg_6_0.effectId = arg_6_0.viewParam.effectId
	arg_6_0.scrollAnchorPos = arg_6_0.viewParam.scrollAnchorPos
	arg_6_0.pivot = arg_6_0.viewParam.pivot
	arg_6_0.clickPosition = arg_6_0.viewParam.clickPosition
	arg_6_0.setScrollPosCallback = arg_6_0.viewParam.setScrollPosCallback
	arg_6_0.setScrollPosCallbackObj = arg_6_0.viewParam.setScrollPosCallbackObj
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0:initViewParam()
	arg_7_0:setScrollPos()
	arg_7_0:calculateMaxHeight()
	arg_7_0:addBuffTip(arg_7_0.effectId)
	arg_7_0:addEventCb(FightController.instance, FightEvent.SetIsShowUI, arg_7_0.setIsShowUI, arg_7_0)
end

function var_0_0.setScrollPos(arg_8_0)
	if arg_8_0.setScrollPosCallback then
		arg_8_0.setScrollPosCallback(arg_8_0.setScrollPosCallbackObj, arg_8_0.rectTrViewGo, arg_8_0.rectTrScrollTip)

		return
	end

	if arg_8_0.scrollAnchorPos then
		arg_8_0.rectTrScrollTip.pivot = arg_8_0.pivot

		recthelper.setAnchor(arg_8_0.rectTrScrollTip, arg_8_0.scrollAnchorPos.x, arg_8_0.scrollAnchorPos.y)

		return
	end

	local var_8_0 = GameUtil.checkClickPositionInRight(arg_8_0.clickPosition)

	arg_8_0.rectTrScrollTip.pivot = var_8_0 and CommonBuffTipEnum.Pivot.Right or CommonBuffTipEnum.Pivot.Left

	local var_8_1, var_8_2 = recthelper.screenPosToAnchorPos2(arg_8_0.clickPosition, arg_8_0.rectTrViewGo)

	var_8_1 = var_8_0 and var_8_1 - CommonBuffTipEnum.DefaultInterval or var_8_1 + CommonBuffTipEnum.DefaultInterval

	recthelper.setAnchor(arg_8_0.rectTrScrollTip, var_8_1, var_8_2 + CommonBuffTipEnum.DefaultInterval)
end

function var_0_0.calculateMaxHeight(arg_9_0)
	local var_9_0 = recthelper.getHeight(arg_9_0.rectTrViewGo)
	local var_9_1 = recthelper.getAnchorY(arg_9_0.rectTrScrollTip)

	arg_9_0.maxHeight = var_9_0 / 2 + var_9_1 - CommonBuffTipEnum.BottomMargin
end

function var_0_0.addBuffTip(arg_10_0, arg_10_1)
	local var_10_0 = tonumber(arg_10_1)

	if arg_10_0.addEffectIdDict[var_10_0] then
		return
	end

	local var_10_1 = lua_skill_eff_desc.configDict[var_10_0]

	if not var_10_1 then
		logError("not found skill_eff_desc , id : " .. tostring(arg_10_1))

		return
	end

	arg_10_0.addEffectIdDict[var_10_0] = true

	local var_10_2 = arg_10_0:getTipItem()

	table.insert(arg_10_0.effectTipItemList, var_10_2)
	gohelper.setActive(var_10_2.go, true)
	gohelper.setAsLastSibling(var_10_2.go)

	local var_10_3 = var_10_1.name
	local var_10_4 = SkillHelper.removeRichTag(var_10_3)

	var_10_2.txtName.text = var_10_4
	var_10_2.txtDesc.text = SkillHelper.getSkillDesc(nil, var_10_1)

	local var_10_5 = CommonBuffTipController.instance:getBuffTagName(var_10_3)
	local var_10_6 = not string.nilorempty(var_10_5)

	gohelper.setActive(var_10_2.goTag, var_10_6)

	if var_10_6 then
		var_10_2.txtTag.text = var_10_5
	end

	arg_10_0:refreshScrollHeight()
end

function var_0_0.refreshScrollHeight(arg_11_0)
	ZProj.UGUIHelper.RebuildLayout(arg_11_0.rectTrContent)

	local var_11_0 = recthelper.getHeight(arg_11_0.rectTrContent)
	local var_11_1 = math.min(arg_11_0.maxHeight, var_11_0)

	recthelper.setHeight(arg_11_0.rectTrScrollTip, var_11_1)

	arg_11_0.scrollTip.verticalNormalizedPosition = 0
end

function var_0_0.getTipItem(arg_12_0)
	if #arg_12_0.effectTipItemPool > 0 then
		return table.remove(arg_12_0.effectTipItemPool)
	end

	local var_12_0 = arg_12_0:getUserDataTb_()

	var_12_0.go = gohelper.cloneInPlace(arg_12_0.gotipitem)
	var_12_0.txtName = gohelper.findChildText(var_12_0.go, "title/txt_name")
	var_12_0.txtDesc = gohelper.findChildText(var_12_0.go, "txt_desc")
	var_12_0.goTag = gohelper.findChild(var_12_0.go, "title/txt_name/go_tag")
	var_12_0.txtTag = gohelper.findChildText(var_12_0.go, "title/txt_name/go_tag/bg/txt_tagname")

	SkillHelper.addHyperLinkClick(var_12_0.txtDesc, arg_12_0.onClickHyperLinkText, arg_12_0)

	return var_12_0
end

function var_0_0.onClickHyperLinkText(arg_13_0, arg_13_1, arg_13_2)
	arg_13_0:addBuffTip(arg_13_1)
end

function var_0_0.recycleTipItem(arg_14_0, arg_14_1)
	gohelper.setActive(arg_14_1.go, false)
	table.insert(arg_14_0.effectTipItemPool, arg_14_1)
end

function var_0_0.recycleAllTipItem(arg_15_0)
	for iter_15_0, iter_15_1 in ipairs(arg_15_0.effectTipItemList) do
		gohelper.setActive(iter_15_1.go, false)
		table.insert(arg_15_0.effectTipItemPool, iter_15_1)
	end

	tabletool.clear(arg_15_0.effectTipItemList)
end

function var_0_0.onClose(arg_16_0)
	tabletool.clear(arg_16_0.addEffectIdDict)
	arg_16_0:recycleAllTipItem()
	arg_16_0:removeEventCb(FightController.instance, FightEvent.SetIsShowUI, arg_16_0.setIsShowUI, arg_16_0)
end

function var_0_0.onDestroyView(arg_17_0)
	arg_17_0.closeClick:RemoveClickListener()

	arg_17_0.closeClick = nil
end

return var_0_0
