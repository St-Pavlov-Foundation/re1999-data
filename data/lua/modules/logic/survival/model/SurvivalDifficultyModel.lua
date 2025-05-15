module("modules.logic.survival.model.SurvivalDifficultyModel", package.seeall)

local var_0_0 = class("SurvivalDifficultyModel", ListScrollModel)

function var_0_0.refreshDifficulty(arg_1_0)
	arg_1_0.difficultyIndex = 1
	arg_1_0.customDifficulty = {}
	arg_1_0._customDifficultyDict = {}
	arg_1_0.difficultyList = arg_1_0:getDifficultyList()
	arg_1_0.customDifficultyList = arg_1_0:getCustomDifficultyList()
	arg_1_0.customSelectIndex = 1
end

function var_0_0.getDifficultyId(arg_2_0)
	local var_2_0 = arg_2_0.difficultyList[arg_2_0.difficultyIndex]

	return var_2_0 and var_2_0.id or 0
end

function var_0_0.getCustomDifficulty(arg_3_0)
	return arg_3_0.customDifficulty
end

function var_0_0.hasSelectCustomDifficulty(arg_4_0)
	local var_4_0 = arg_4_0:getCustomDifficulty()

	return next(var_4_0) ~= nil
end

function var_0_0.isCustomDifficulty(arg_5_0)
	return arg_5_0:getDifficultyId() == SurvivalEnum.CustomDifficulty
end

function var_0_0.changeDifficultyIndex(arg_6_0, arg_6_1)
	local var_6_0
	local var_6_1 = arg_6_0:isCustomDifficulty()

	arg_6_0.difficultyIndex = arg_6_0.difficultyIndex + arg_6_1

	if arg_6_0.difficultyIndex < 1 then
		arg_6_0.difficultyIndex = #arg_6_0.difficultyList
	end

	if arg_6_0.difficultyIndex > #arg_6_0.difficultyList then
		arg_6_0.difficultyIndex = 1
	end

	local var_6_2 = arg_6_0:isCustomDifficulty()

	if var_6_1 and not var_6_2 then
		var_6_0 = "panel_out"
	elseif not var_6_1 and var_6_2 then
		var_6_0 = "panel_in"
	elseif not var_6_1 and not var_6_2 then
		var_6_0 = arg_6_1 > 0 and "switch_right" or "switch_left"
	end

	return var_6_0
end

function var_0_0.getArrowStatus(arg_7_0)
	local var_7_0 = arg_7_0.difficultyIndex > 1
	local var_7_1 = arg_7_0.difficultyIndex < #arg_7_0.difficultyList

	return var_7_0, var_7_1
end

function var_0_0.getDifficultyList(arg_8_0)
	local var_8_0 = SurvivalModel.instance:getOutSideInfo()
	local var_8_1 = {}

	for iter_8_0, iter_8_1 in ipairs(lua_survival_hardness_mod.configList) do
		if iter_8_1.optional == 1 and var_8_0:isUnlockDifficultyMod(iter_8_1.id) then
			table.insert(var_8_1, iter_8_1)
		end
	end

	table.sort(var_8_1, SortUtil.keyLower("id"))

	return var_8_1
end

function var_0_0.getCustomDifficultyList(arg_9_0)
	local var_9_0 = {}

	for iter_9_0, iter_9_1 in ipairs(lua_survival_hardness.configList) do
		if iter_9_1.optional == 1 then
			if not var_9_0[iter_9_1.type] then
				var_9_0[iter_9_1.type] = {}
			end

			if not var_9_0[iter_9_1.type][iter_9_1.subtype] then
				var_9_0[iter_9_1.type][iter_9_1.subtype] = {}
			end

			table.insert(var_9_0[iter_9_1.type][iter_9_1.subtype], iter_9_1)
		end
	end

	for iter_9_2, iter_9_3 in pairs(var_9_0) do
		for iter_9_4, iter_9_5 in pairs(iter_9_3) do
			local var_9_1 = {}

			for iter_9_6, iter_9_7 in ipairs(iter_9_5) do
				var_9_1[iter_9_7.level] = iter_9_7
			end

			local var_9_2 = {}

			for iter_9_8 = 1, 5 do
				table.insert(var_9_2, var_9_1[iter_9_8] or {})
			end

			iter_9_3[iter_9_4] = var_9_2
		end
	end

	return var_9_0
end

function var_0_0.getDifficultyAssess(arg_10_0)
	local var_10_0 = arg_10_0:getList()
	local var_10_1 = 0

	for iter_10_0, iter_10_1 in pairs(var_10_0) do
		local var_10_2 = iter_10_1.hardId

		if var_10_2 then
			var_10_1 = var_10_1 + lua_survival_hardness.configDict[var_10_2].level
		end
	end

	return var_10_1
end

function var_0_0.getDifficultyShowList(arg_11_0)
	local var_11_0 = {}
	local var_11_1 = lua_survival_hardness_mod.configDict[arg_11_0:getDifficultyId()]
	local var_11_2 = string.splitToNumber(var_11_1.hardness, "#")

	if var_11_2 then
		for iter_11_0, iter_11_1 in pairs(var_11_2) do
			table.insert(var_11_0, {
				hardId = iter_11_1
			})
		end
	end

	if arg_11_0:isCustomDifficulty() then
		local var_11_3 = arg_11_0:getCustomDifficulty()

		if var_11_3 then
			for iter_11_2, iter_11_3 in pairs(var_11_3) do
				table.insert(var_11_0, {
					hardId = iter_11_3
				})
			end
		end
	end

	return var_11_0
end

function var_0_0.refreshDifficultyShowList(arg_12_0)
	local var_12_0 = arg_12_0:getDifficultyShowList()
	local var_12_1 = {}
	local var_12_2 = {}

	for iter_12_0, iter_12_1 in ipairs(var_12_0) do
		local var_12_3 = iter_12_1.hardId

		if var_12_3 then
			local var_12_4 = lua_survival_hardness.configDict[var_12_3]

			if var_12_4 and var_12_4.isShow == 0 then
				local var_12_5 = string.format("%s_%s", var_12_4.type, var_12_4.subtype)

				if var_12_2[var_12_5] then
					local var_12_6 = lua_survival_hardness.configDict[var_12_2[var_12_5].hardId]

					if var_12_4.level > var_12_6.level then
						var_12_2[var_12_5] = iter_12_1
					end
				else
					var_12_2[var_12_5] = iter_12_1
				end
			end
		end
	end

	for iter_12_2, iter_12_3 in pairs(var_12_2) do
		table.insert(var_12_1, iter_12_3)
	end

	local var_12_7 = #var_12_1

	if var_12_7 > 1 then
		-- block empty
	end

	if var_12_7 < 4 then
		for iter_12_4 = var_12_7 + 1, 4 do
			table.insert(var_12_1, {})
		end
	end

	arg_12_0:setList(var_12_1)
end

function var_0_0.sendDifficultyChoose(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_0:getDifficultyId()

	if arg_13_0:isCustomDifficulty() then
		local var_13_1 = arg_13_0:getDifficultyShowList()
		local var_13_2 = {}

		if var_13_1 then
			for iter_13_0, iter_13_1 in pairs(var_13_1) do
				local var_13_3 = iter_13_1.hardId

				if var_13_3 then
					local var_13_4 = lua_survival_hardness.configDict[var_13_3]

					if var_13_4 and var_13_4.optional == 1 then
						table.insert(var_13_2, var_13_3)
					end
				end
			end
		end

		SurvivalWeekRpc.instance:sendSurvivalStartWeekChooseDiff(var_13_0, var_13_2, arg_13_1, arg_13_2)
	else
		SurvivalWeekRpc.instance:sendSurvivalStartWeekChooseDiff(var_13_0, nil, arg_13_1, arg_13_2)
	end
end

function var_0_0.setCustomSelectIndex(arg_14_0, arg_14_1)
	if arg_14_0.customSelectIndex == arg_14_1 then
		return
	end

	arg_14_0.customSelectIndex = arg_14_1

	return true
end

function var_0_0.getCustomSelectIndex(arg_15_0)
	return arg_15_0.customSelectIndex
end

function var_0_0.getCustomDifficultyAssess(arg_16_0, arg_16_1)
	local var_16_0 = 0
	local var_16_1 = arg_16_0:getCustomDifficulty()

	if var_16_1 then
		for iter_16_0, iter_16_1 in pairs(var_16_1) do
			local var_16_2 = lua_survival_hardness.configDict[iter_16_1]

			if var_16_2 and var_16_2.type == arg_16_1 then
				var_16_0 = var_16_0 + var_16_2.level
			end
		end
	end

	return var_16_0
end

function var_0_0.isSelectCustomDifficulty(arg_17_0, arg_17_1)
	return arg_17_0._customDifficultyDict[arg_17_1] ~= nil
end

function var_0_0.selectCustomDifficulty(arg_18_0, arg_18_1)
	local var_18_0 = lua_survival_hardness.configDict[arg_18_1]
	local var_18_1
	local var_18_2

	for iter_18_0, iter_18_1 in ipairs(arg_18_0.customDifficulty) do
		if iter_18_1 ~= arg_18_1 then
			local var_18_3 = lua_survival_hardness.configDict[iter_18_1]

			if var_18_0.type == var_18_3.type and var_18_0.subtype == var_18_3.subtype then
				var_18_1 = iter_18_0
				var_18_2 = iter_18_1

				break
			end
		end
	end

	if var_18_1 then
		arg_18_0._customDifficultyDict[var_18_2] = nil

		table.remove(arg_18_0.customDifficulty, var_18_1)
	end

	if arg_18_0:isSelectCustomDifficulty(arg_18_1) then
		arg_18_0._customDifficultyDict[arg_18_1] = nil

		tabletool.removeValue(arg_18_0.customDifficulty, arg_18_1)
	else
		arg_18_0._customDifficultyDict[arg_18_1] = true

		table.insert(arg_18_0.customDifficulty, arg_18_1)
	end

	return true
end

var_0_0.instance = var_0_0.New()

return var_0_0
