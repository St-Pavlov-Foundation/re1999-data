module("modules.logic.survival.view.shelter.SurvivalReportView", package.seeall)

local var_0_0 = class("SurvivalReportView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageFullBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBG")
	arg_1_0._simageMask = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_Mask")
	arg_1_0._simagePanelBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "Panel/#simage_PanelBG")
	arg_1_0._simagePanelBG1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "Panel/#simage_PanelBG1")
	arg_1_0._simagePanelBG2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "Panel/#simage_PanelBG2")
	arg_1_0._scrollcontentlist = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_contentlist")
	arg_1_0._txtdec1 = gohelper.findChildText(arg_1_0.viewGO, "#scroll_contentlist/viewport/content/#txt_dec1")
	arg_1_0._goNpc = gohelper.findChild(arg_1_0.viewGO, "#scroll_contentlist/viewport/content/#go_Npc")
	arg_1_0._txtNpc = gohelper.findChildText(arg_1_0.viewGO, "#scroll_contentlist/viewport/content/#go_Npc/#txt_Npc")
	arg_1_0._goMonster = gohelper.findChild(arg_1_0.viewGO, "#scroll_contentlist/viewport/content/#go_Monster")
	arg_1_0._txtMonster = gohelper.findChildText(arg_1_0.viewGO, "#scroll_contentlist/viewport/content/#go_Monster/#txt_Monster")
	arg_1_0._goBuilding = gohelper.findChild(arg_1_0.viewGO, "#scroll_contentlist/viewport/content/#go_Building")
	arg_1_0._txtBuilding = gohelper.findChildText(arg_1_0.viewGO, "#scroll_contentlist/viewport/content/#go_Building/#txt_Building")
	arg_1_0._goTask = gohelper.findChild(arg_1_0.viewGO, "#scroll_contentlist/viewport/content/#go_Task")
	arg_1_0._txtTask = gohelper.findChildText(arg_1_0.viewGO, "#scroll_contentlist/viewport/content/#go_Task/#txt_Task")
	arg_1_0._goTaskScore = gohelper.findChild(arg_1_0.viewGO, "#scroll_contentlist/viewport/content/#go_Task/#go_TaskScore")
	arg_1_0._txtnpcScore = gohelper.findChildText(arg_1_0.viewGO, "#scroll_contentlist/viewport/content/#go_Task/#go_TaskScore/#txt_npcScore")
	arg_1_0._txtdec2 = gohelper.findChildText(arg_1_0.viewGO, "#scroll_contentlist/viewport/content/#txt_dec2")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._editableInitView(arg_5_0)
	return
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onClickModalMask(arg_7_0)
	arg_7_0:_btncloseOnClick()
end

function var_0_0.onOpen(arg_8_0)
	local var_8_0 = SurvivalModel.instance:getDailyReport()

	arg_8_0._report = nil

	if not string.nilorempty(var_8_0) then
		arg_8_0._report = cjson.decode(var_8_0)
	end

	SurvivalModel.instance:setDailyReport()
	arg_8_0:_initView()
end

function var_0_0._initView(arg_9_0)
	arg_9_0:_initNpc()
	arg_9_0:_initMonster()
	gohelper.setActive(arg_9_0._goBuilding, false)
	arg_9_0:_initTask()
end

function var_0_0._initNpc(arg_10_0)
	local var_10_0 = luaLang("survivalreportview_npc_empty")

	if arg_10_0._report ~= nil then
		local var_10_1 = arg_10_0._report.leaveNpcIds

		if var_10_1 ~= nil and #var_10_1 > 0 then
			local var_10_2 = #var_10_1
			local var_10_3 = ""

			for iter_10_0 = 1, var_10_2 do
				local var_10_4 = var_10_1[iter_10_0]
				local var_10_5 = SurvivalConfig.instance:getNpcConfig(var_10_4)

				if var_10_5 then
					local var_10_6 = var_10_5.name

					if iter_10_0 ~= var_10_2 then
						var_10_3 = var_10_3 .. var_10_6 .. ","
					else
						var_10_3 = var_10_3 .. var_10_6
					end
				end
			end

			var_10_0 = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("survivalreportview_npc"), var_10_2, var_10_3)
		end
	end

	arg_10_0._txtNpc.text = var_10_0
end

function var_0_0._initMonster(arg_11_0)
	local var_11_0 = luaLang("survivalreportview_monster_empty")

	if arg_11_0._report ~= nil then
		local var_11_1 = SurvivalShelterModel.instance:getWeekInfo()
		local var_11_2 = var_11_1:getMonsterFight()

		if var_11_2 ~= nil and var_11_2:canShowEntity() then
			local var_11_3 = lua_survival_shelter_intrude_fight.configDict[var_11_2.fightId]
			local var_11_4 = var_11_2.endTime - var_11_1.day - 1

			if var_11_3 then
				var_11_4 = var_11_4 > 0 and var_11_4 or 0

				if var_11_4 == 0 then
					var_11_0 = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("survivalreportview_monster_today"), var_11_3.name)
				else
					var_11_0 = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("survivalreportview_monster"), var_11_4, var_11_3.name)
				end
			end
		end
	end

	arg_11_0._txtMonster.text = var_11_0
end

function var_0_0._initBuilding(arg_12_0)
	local var_12_0 = luaLang("survivalreportview_build_empty")

	if arg_12_0._report ~= nil then
		local var_12_1 = arg_12_0._report.desBuildingIds
		local var_12_2 = SurvivalShelterModel.instance:getWeekInfo()

		if var_12_1 ~= nil and #var_12_1 > 0 then
			local var_12_3 = #var_12_1
			local var_12_4 = ""

			for iter_12_0 = 1, var_12_3 do
				local var_12_5 = var_12_1[iter_12_0]
				local var_12_6 = var_12_2:getBuildingInfo(var_12_5)

				if var_12_6 then
					local var_12_7 = var_12_6.baseCo

					if var_12_7 then
						local var_12_8 = var_12_7.name

						if iter_12_0 ~= var_12_3 then
							var_12_4 = var_12_4 .. var_12_8 .. ","
						else
							var_12_4 = var_12_4 .. var_12_8
						end
					end
				end
			end

			if not string.nilorempty(var_12_4) then
				var_12_0 = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("survivalreportview_build"), var_12_4)
			end
		end
	end

	arg_12_0._txtBuilding.text = var_12_0
end

function var_0_0._initTask(arg_13_0)
	local var_13_0

	if arg_13_0._report ~= nil then
		local var_13_1 = arg_13_0._report.totalScore

		if var_13_1 ~= nil and var_13_1 > 0 then
			local var_13_2 = arg_13_0._report.itemId2Count
			local var_13_3 = arg_13_0._report.npc2GetCount
			local var_13_4 = 0

			if var_13_3 ~= nil then
				var_13_4 = tabletool.len(var_13_3)
			end

			local var_13_5 = 0
			local var_13_6 = 0
			local var_13_7 = 0
			local var_13_8 = 0
			local var_13_9 = 0

			for iter_13_0, iter_13_1 in pairs(var_13_2) do
				local var_13_10 = lua_survival_item.configDict[tonumber(iter_13_0)]

				if var_13_10 then
					if var_13_10.type == SurvivalEnum.ItemType.Equip then
						var_13_7 = var_13_7 + iter_13_1
					elseif var_13_10.type == SurvivalEnum.ItemType.Currency then
						if var_13_10.subType == SurvivalEnum.CurrencyType.Gold then
							var_13_8 = var_13_8 + iter_13_1
						elseif var_13_10.subType == SurvivalEnum.CurrencyType.Build then
							var_13_5 = var_13_5 + iter_13_1
						elseif var_13_10.subType == SurvivalEnum.CurrencyType.Food then
							var_13_6 = var_13_6 + iter_13_1
						else
							var_13_9 = var_13_9 + iter_13_1
						end
					else
						var_13_9 = var_13_9 + iter_13_1
					end
				end
			end

			local var_13_11 = ""

			local function var_13_12(arg_14_0, arg_14_1)
				if arg_14_0 > 0 then
					var_13_11 = var_13_11 .. GameUtil.getSubPlaceholderLuaLangOneParam(luaLang(arg_14_1), arg_14_0) .. ","
				end
			end

			var_13_12(var_13_5, "survivalreportview_score_buildItem")
			var_13_12(var_13_6, "survivalreportview_score_foodItem")
			var_13_12(var_13_7, "survivalreportview_score_equipItem")
			var_13_12(var_13_8, "survivalreportview_score_goldItem")
			var_13_12(var_13_9, "survivalreportview_score_otherItem")
			var_13_12(var_13_4, "survivalreportview_score_npc")

			if not string.nilorempty(var_13_11) then
				var_13_0 = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("survivalreportview_score"), var_13_11, var_13_1)
			end
		end
	end

	if var_13_0 ~= nil then
		arg_13_0._txtTask.text = var_13_0
		arg_13_0._txtnpcScore.text = arg_13_0._report.totalScore
	end

	gohelper.setActive(arg_13_0._goTask, var_13_0 ~= nil)
end

function var_0_0.onClose(arg_15_0)
	return
end

function var_0_0.onDestroyView(arg_16_0)
	return
end

return var_0_0
