module("modules.logic.gm.model.GMHelpViewBrowseModel", package.seeall)

local var_0_0 = class("GMHelpViewBrowseModel", ListScrollModel)

var_0_0.tabModeEnum = {
	weekWalkRuleView = 5,
	fightTechniqueView = 3,
	helpView = 1,
	fightTechniqueTipView = 4,
	fightGuideView = 2
}

function var_0_0.ctor(arg_1_0)
	var_0_0.super.ctor(arg_1_0)
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.getCurrentTabMode(arg_3_0)
	return arg_3_0._currentTabMode
end

function var_0_0.setListByTabMode(arg_4_0, arg_4_1)
	if arg_4_0._currentTabMode and arg_4_0._currentTabMode == arg_4_1 then
		return
	end

	local var_4_0 = {}

	if arg_4_1 == var_0_0.tabModeEnum.helpView then
		var_4_0 = arg_4_0:_getHelpViewList()
	elseif arg_4_1 == var_0_0.tabModeEnum.fightGuideView then
		var_4_0 = arg_4_0:_getFightGuideList()
	elseif arg_4_1 == var_0_0.tabModeEnum.fightTechniqueView then
		var_4_0 = arg_4_0:_getFightTechniqueList()
	elseif arg_4_1 == var_0_0.tabModeEnum.fightTechniqueTipView then
		var_4_0 = arg_4_0:_getFightTechniqueTipList()
	elseif arg_4_1 == var_0_0.tabModeEnum.weekWalkRuleView then
		var_4_0 = arg_4_0:_getWeekWalkRuleList()
	else
		logError("GMHelpViewBrowseModel错误，tabMode获取列表未定义：" .. arg_4_1)

		return
	end

	arg_4_0._currentTabMode = arg_4_1

	arg_4_0:setList(var_4_0)
	arg_4_0:onModelUpdate()
end

function var_0_0._getHelpViewList(arg_5_0)
	local var_5_0 = {}

	for iter_5_0, iter_5_1 in ipairs(lua_helppage.configList) do
		if not string.nilorempty(iter_5_1.icon) then
			local var_5_1 = ResUrl.getHelpItem(iter_5_1.icon, iter_5_1.isCn == 1)
			local var_5_2 = System.IO.Path.Combine(SLFramework.FrameworkSettings.AssetRootDir, var_5_1)

			if SLFramework.FileHelper.IsFileExists(var_5_2) then
				table.insert(var_5_0, iter_5_1)
			end
		end
	end

	return var_5_0
end

function var_0_0._getFightGuideList(arg_6_0)
	local var_6_0 = {}
	local var_6_1 = ResUrl.getFightGuideLangDir()

	arg_6_0:_fillFightGuideListByDirPath(var_6_0, var_6_1)

	local var_6_2 = ResUrl.getFightGuideDir()

	arg_6_0:_fillFightGuideListByDirPath(var_6_0, var_6_2)

	return var_6_0
end

function var_0_0._fillFightGuideListByDirPath(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = SLFramework.FileHelper.GetDirFilePaths(arg_7_2)

	if not var_7_0 then
		return
	end

	for iter_7_0 = 0, var_7_0.Length - 1 do
		local var_7_1 = var_7_0[iter_7_0]:match(".+/([^/]+)%.png$")

		if var_7_1 then
			local var_7_2 = var_7_1:match("%d+$")

			if var_7_2 then
				local var_7_3 = {
					id = tonumber(var_7_2),
					icon = var_7_1
				}

				table.insert(arg_7_1, var_7_3)
			end
		end
	end
end

function var_0_0._getFightTechniqueList(arg_8_0)
	local var_8_0 = {}

	for iter_8_0, iter_8_1 in ipairs(lua_fight_technique.configList) do
		local var_8_1 = {
			id = iter_8_1.id,
			icon = iter_8_1.picture1
		}

		table.insert(var_8_0, var_8_1)
	end

	return var_8_0
end

function var_0_0._getFightTechniqueTipList(arg_9_0)
	local var_9_0 = {}

	for iter_9_0, iter_9_1 in ipairs(lua_fight_technique.configList) do
		if not string.nilorempty(iter_9_1.picture2) then
			local var_9_1 = {
				id = iter_9_1.id,
				icon = iter_9_1.picture2
			}

			table.insert(var_9_0, var_9_1)
		end
	end

	return var_9_0
end

function var_0_0._getWeekWalkRuleList(arg_10_0)
	local var_10_0 = {}

	for iter_10_0, iter_10_1 in ipairs(lua_weekwalk_rule.configList) do
		local var_10_1 = {
			id = iter_10_1.id,
			icon = iter_10_1.icon
		}

		table.insert(var_10_0, var_10_1)
	end

	return var_10_0
end

var_0_0.instance = var_0_0.New()

return var_0_0
