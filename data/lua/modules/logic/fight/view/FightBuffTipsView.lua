﻿module("modules.logic.fight.view.FightBuffTipsView", package.seeall)

local var_0_0 = class("FightBuffTipsView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gobuffinfocontainer = gohelper.findChild(arg_1_0.viewGO, "root/#go_buffinfocontainer/buff")
	arg_1_0._scrollbuff = gohelper.findChildScrollRect(arg_1_0.viewGO, "root/#go_buffinfocontainer/buff/#scroll_buff")
	arg_1_0._gobuffitem = gohelper.findChild(arg_1_0.viewGO, "root/#go_buffinfocontainer/buff/#scroll_buff/viewport/content/#go_buffitem")
	arg_1_0._btnclosebuffinfocontainer = gohelper.findChildButton(arg_1_0.viewGO, "root/#go_buffinfocontainer/#btn_click")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclosebuffinfocontainer:AddClickListener(arg_2_0._onCloseBuffInfoContainer, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclosebuffinfocontainer:RemoveClickListener()
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0.rectTrScrollBuff = arg_4_0._scrollbuff:GetComponent(gohelper.Type_RectTransform)
	arg_4_0.rectTrBuffContent = gohelper.findChildComponent(arg_4_0.viewGO, "root/#go_buffinfocontainer/buff/#scroll_buff/viewport/content", gohelper.Type_RectTransform)

	gohelper.setActive(arg_4_0._gobuffitem, false)

	arg_4_0._buffItemList = {}
end

function var_0_0._onCloseBuffInfoContainer(arg_5_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_click)
	arg_5_0:closeThis()
end

function var_0_0.onOpen(arg_6_0)
	gohelper.setActive(gohelper.findChild(arg_6_0.viewGO, "root/tips"), true)

	local var_6_0 = FightDataHelper.entityMgr:getById(arg_6_0.viewParam.entityId or arg_6_0.viewParam)

	arg_6_0:_updateBuffs(var_6_0)

	if arg_6_0.viewParam.viewname and arg_6_0.viewParam.viewname == "FightView" then
		arg_6_0:_setPos(var_6_0)
	else
		local var_6_1 = var_6_0.side == FightEnum.EntitySide.MySide and 207 or -161

		recthelper.setAnchorX(arg_6_0._gobuffinfocontainer.transform, var_6_1)
	end
end

function var_0_0._setPos(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0.viewParam.iconPos
	local var_7_1 = arg_7_0.viewParam.offsetX
	local var_7_2 = arg_7_0.viewParam.offsetY

	arg_7_0.enemyBuffTipPosY = 80

	local var_7_3 = recthelper.rectToRelativeAnchorPos(var_7_0, arg_7_0._gobuffinfocontainer.transform.parent)
	local var_7_4 = recthelper.getWidth(arg_7_0.rectTrScrollBuff)
	local var_7_5 = recthelper.getHeight(arg_7_0.rectTrScrollBuff)
	local var_7_6 = 0
	local var_7_7 = 0

	if arg_7_1.side == FightEnum.EntitySide.MySide then
		var_7_6 = var_7_3.x - var_7_1
		var_7_7 = var_7_3.y + var_7_2
	else
		var_7_6 = var_7_3.x + var_7_1
		var_7_7 = arg_7_0.enemyBuffTipPosY
	end

	local var_7_8 = UnityEngine.Screen.width * 0.5
	local var_7_9 = 10
	local var_7_10 = {
		min = -var_7_8 + var_7_4 + var_7_9,
		max = var_7_8 - var_7_4 - var_7_9
	}
	local var_7_11 = GameUtil.clamp(var_7_6, var_7_10.min, var_7_10.max)

	recthelper.setAnchor(arg_7_0._gobuffinfocontainer.transform, var_7_11, var_7_7)
end

function var_0_0._updateBuffs(arg_8_0, arg_8_1)
	arg_8_0:updateBuffDesc(arg_8_1, arg_8_0._buffItemList, arg_8_0._gobuffitem, arg_8_0, arg_8_0.getCommonBuffTipScrollAnchor)
end

var_0_0.Interval = 10

function var_0_0.getCommonBuffTipScrollAnchor(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = GameUtil.getViewSize() / 2
	local var_9_1 = arg_9_0.rectTrScrollBuff
	local var_9_2 = arg_9_0.rectTrBuffContent
	local var_9_3, var_9_4 = recthelper.uiPosToScreenPos2(var_9_1)
	local var_9_5, var_9_6 = SLFramework.UGUI.RectTrHelper.ScreenPosXYToAnchorPosXY(var_9_3, var_9_4, arg_9_1, CameraMgr.instance:getUICamera(), nil, nil)
	local var_9_7 = recthelper.getWidth(var_9_1) / 2
	local var_9_8 = var_9_0 + var_9_5 - var_9_7 - var_0_0.Interval
	local var_9_9 = recthelper.getWidth(arg_9_2)
	local var_9_10 = var_9_9 <= var_9_8

	arg_9_2.pivot = CommonBuffTipEnum.Pivot.Right

	local var_9_11 = var_9_5
	local var_9_12 = var_9_6

	if var_9_10 then
		var_9_11 = var_9_11 - var_9_7 - var_0_0.Interval
	else
		var_9_11 = var_9_11 + var_9_7 + var_0_0.Interval + var_9_9
	end

	local var_9_13 = math.min(recthelper.getHeight(var_9_1), recthelper.getHeight(var_9_2)) / 2

	recthelper.setAnchor(arg_9_2, var_9_11, var_9_12 + var_9_13)
end

var_0_0.filterTypeKey = {
	[2] = true
}

local var_0_1 = 635
local var_0_2 = 597
local var_0_3 = 300
local var_0_4 = 141

function var_0_0.updateBuffDesc(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4, arg_10_5)
	local var_10_0 = arg_10_1 and arg_10_1:getBuffList() or {}
	local var_10_1 = tabletool.copy(var_10_0)
	local var_10_2 = FightBuffHelper.filterBuffType(var_10_1, var_0_0.filterTypeKey)

	FightSkillBuffMgr.instance:dealStackerBuff(var_10_2)
	table.sort(var_10_2, function(arg_11_0, arg_11_1)
		if arg_11_0.time ~= arg_11_1.time then
			return arg_11_0.time < arg_11_1.time
		end

		return arg_11_0.id < arg_11_1.id
	end)

	for iter_10_0, iter_10_1 in ipairs(arg_10_2) do
		gohelper.setActive(iter_10_1.go, false)
	end

	local var_10_3 = var_10_2 and #var_10_2 or 0
	local var_10_4 = 0
	local var_10_5 = var_0_1
	local var_10_6 = var_0_2
	local var_10_7 = {}

	for iter_10_2 = 1, var_10_3 do
		local var_10_8 = var_10_2[iter_10_2]
		local var_10_9 = lua_skill_buff.configDict[var_10_8.buffId]

		if var_10_9 and var_10_9.isNoShow == 0 then
			local var_10_10 = lua_skill_bufftype.configDict[var_10_9.typeId]
			local var_10_11 = lua_skill_buff_desc.configDict[var_10_10.type]

			var_10_4 = var_10_4 + 1

			local var_10_12 = arg_10_2[var_10_4]

			if not var_10_12 then
				var_10_12 = arg_10_4:getUserDataTb_()
				var_10_12.go = gohelper.cloneInPlace(arg_10_3, "buff" .. var_10_4)
				var_10_12.getAnchorFunc = arg_10_5
				var_10_12.viewClass = arg_10_4

				table.insert(arg_10_2, var_10_12)
			end

			local var_10_13 = var_10_12.go

			lastIndex = #arg_10_2

			local var_10_14 = gohelper.findChildText(var_10_13, "title/txt_time")
			local var_10_15 = gohelper.findChildText(var_10_13, "txt_desc")

			SkillHelper.addHyperLinkClick(var_10_15, var_0_0.onClickBuffHyperLink, var_10_12)

			local var_10_16 = var_10_15.transform
			local var_10_17 = gohelper.findChild(var_10_13, "title").transform
			local var_10_18 = gohelper.findChildText(var_10_13, "title/txt_name")
			local var_10_19 = gohelper.findChildImage(var_10_13, "title/simage_icon")
			local var_10_20 = gohelper.findChild(var_10_13, "txt_desc/image_line")
			local var_10_21 = gohelper.findChild(var_10_13, "title/txt_name/go_tag")
			local var_10_22 = gohelper.findChildText(var_10_13, "title/txt_name/go_tag/bg/txt_tagname")
			local var_10_23 = var_10_13.transform

			gohelper.setActive(var_10_13, true)
			gohelper.setActive(var_10_20, var_10_4 ~= var_10_3)

			var_10_7[#var_10_7 + 1] = var_10_16
			var_10_7[#var_10_7 + 1] = var_10_17
			var_10_7[#var_10_7 + 1] = var_10_23
			var_10_7[#var_10_7 + 1] = var_10_15
			var_10_7[#var_10_7 + 1] = var_10_8

			var_0_0.showBuffTime(var_10_14, var_10_8, var_10_9, arg_10_1)

			var_10_18.text = var_10_9.name

			local var_10_24 = var_10_18.preferredWidth

			if var_10_19 then
				UISpriteSetMgr.instance:setBuffSprite(var_10_19, var_10_9.iconId)
			end

			if var_10_11 then
				var_10_22.text = var_10_11.name
				var_10_24 = var_10_24 + var_10_22.preferredWidth
			end

			local var_10_25 = var_10_14.preferredWidth

			if var_10_25 > var_0_4 then
				var_10_24 = var_10_24 + math.max(0, var_10_25 - var_0_4)
			end

			if var_10_24 > var_0_3 then
				local var_10_26 = var_10_24 - var_0_3
				local var_10_27 = var_0_2 + var_10_26

				var_10_5 = math.max(var_10_5, var_10_27)
				var_10_6 = math.max(var_10_6, var_10_27)
			end

			gohelper.setActive(var_10_21, var_10_11)
		end
	end

	if #var_10_7 > 0 then
		for iter_10_3 = 0, #var_10_7 - 1, 5 do
			local var_10_28 = var_10_7[iter_10_3 + 1]
			local var_10_29 = var_10_7[iter_10_3 + 2]
			local var_10_30 = var_10_7[iter_10_3 + 3]
			local var_10_31 = var_10_7[iter_10_3 + 4]
			local var_10_32 = var_10_7[iter_10_3 + 5]
			local var_10_33 = var_10_32.buffId
			local var_10_34 = lua_skill_buff.configDict[var_10_33]

			recthelper.setWidth(var_10_29, var_10_6 - 10)
			recthelper.setWidth(var_10_28, var_10_6 - 46)
			ZProj.UGUIHelper.RebuildLayout(var_10_30)
			recthelper.setWidth(var_10_30, var_10_6)

			var_10_31.text = FightBuffGetDescHelper.getBuffDesc(var_10_32)
			var_10_31.text = var_10_31.text

			local var_10_35 = var_10_31.preferredHeight + 52.1 + 10

			recthelper.setHeight(var_10_30, var_10_35)
		end
	end

	for iter_10_4 in pairs(var_10_7) do
		rawset(var_10_7, iter_10_4, nil)
	end

	local var_10_36

	if lastIndex ~= -1 then
		local var_10_37 = arg_10_2[lastIndex].go
		local var_10_38 = gohelper.findChild(var_10_37, "txt_desc/image_line")

		gohelper.setActive(var_10_38, false)
	end

	if arg_10_4 then
		arg_10_4._scrollbuff.verticalNormalizedPosition = 1

		recthelper.setWidth(arg_10_4._scrollbuff.transform, var_10_5)
	end
end

function var_0_0.onClickBuffHyperLink(arg_12_0, arg_12_1, arg_12_2)
	CommonBuffTipController.instance:openCommonTipViewWithCustomPosCallback(arg_12_1, arg_12_0.getAnchorFunc, arg_12_0.viewClass)
end

function var_0_0.showBuffTime(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	if FightBuffHelper.isCountContinueChanelBuff(arg_13_1) then
		arg_13_0.text = string.format(luaLang("enemytip_buff_time"), arg_13_1.exInfo)

		return
	end

	if arg_13_1 and FightConfig.instance:hasBuffFeature(arg_13_1.buffId, FightEnum.BuffFeature.CountUseSelfSkillContinueChannel) then
		arg_13_0.text = string.format(luaLang("enemytip_buff_time"), arg_13_1.exInfo)

		return
	end

	if FightBuffHelper.isDuduBoneContinueChannelBuff(arg_13_1) then
		arg_13_0.text = string.format(luaLang("buff_tip_duration"), arg_13_1.exInfo)

		return
	end

	if FightBuffHelper.isDeadlyPoisonBuff(arg_13_1) then
		local var_13_0 = FightSkillBuffMgr.instance:getStackedCount(arg_13_1.entityId, arg_13_1)

		arg_13_0.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("buff_tip_round_and_layer"), arg_13_1.duration, var_13_0)

		return
	end

	local var_13_1 = lua_skill_bufftype.configDict[arg_13_2.typeId]
	local var_13_2, var_13_3 = FightSkillBuffMgr.instance:buffIsStackerBuff(arg_13_2)

	if var_13_2 then
		local var_13_4 = string.format(luaLang("enemytip_buff_stacked_count"), FightSkillBuffMgr.instance:getStackedCount(arg_13_3.id, arg_13_1))

		if var_13_3 == FightEnum.BuffIncludeTypes.Stacked12 then
			arg_13_0.text = var_13_4 .. " " .. string.format(luaLang("enemytip_buff_time"), arg_13_1.duration)
		else
			arg_13_0.text = var_13_4
		end
	elseif arg_13_1.duration == 0 then
		if arg_13_1.count == 0 then
			arg_13_0.text = luaLang("forever")
		else
			local var_13_5 = arg_13_1.count
			local var_13_6 = "enemytip_buff_count"
			local var_13_7 = var_13_1 and var_13_1.includeTypes or ""

			if string.split(var_13_7, "#")[1] == "11" then
				var_13_6 = "enemytip_buff_stacked_count"
				var_13_5 = arg_13_1.layer
			end

			arg_13_0.text = string.format(luaLang(var_13_6), var_13_5)
		end
	elseif arg_13_1.count == 0 then
		arg_13_0.text = string.format(luaLang("enemytip_buff_time"), arg_13_1.duration)
	else
		local var_13_8 = arg_13_1.count
		local var_13_9 = "round_or_times"
		local var_13_10 = var_13_1 and var_13_1.includeTypes or ""

		if string.split(var_13_10, "#")[1] == "11" then
			var_13_9 = "round_or_stacked_count"
			var_13_8 = arg_13_1.layer
		end

		local var_13_11 = {
			arg_13_1.duration,
			var_13_8
		}

		arg_13_0.text = GameUtil.getSubPlaceholderLuaLang(luaLang(var_13_9), var_13_11)
	end
end

return var_0_0
