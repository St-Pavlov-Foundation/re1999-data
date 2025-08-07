module("modules.logic.summon.config.SummonConfig", package.seeall)

local var_0_0 = class("SummonConfig", BaseConfig)

function var_0_0.reqConfigNames(arg_1_0)
	return {
		"summon_pool",
		"summon",
		"summon_character",
		"summon_pool_detail",
		"summon_equip_detail",
		"lucky_bag_heroes"
	}
end

function var_0_0.onInit(arg_2_0)
	return
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "summon_equip_detail" then
		arg_3_0:_initEquipDetails()
	end
end

function var_0_0._initEquipDetails(arg_4_0)
	arg_4_0._equipPoolDict = {}

	local var_4_0 = lua_summon_equip_detail.configList

	for iter_4_0, iter_4_1 in ipairs(var_4_0) do
		arg_4_0._equipPoolDict[iter_4_1.poolId] = arg_4_0._equipPoolDict[iter_4_1.poolId] or {}
		arg_4_0._equipPoolDict[iter_4_1.poolId][iter_4_1.location] = iter_4_1
	end
end

function var_0_0.getSummonPoolList(arg_5_0)
	return lua_summon_pool.configList
end

function var_0_0.getSummon(arg_6_0, arg_6_1)
	return lua_summon.configDict[arg_6_1]
end

function var_0_0.getCharacterDetailConfig(arg_7_0, arg_7_1)
	return lua_summon_character.configDict[arg_7_1]
end

function var_0_0.getPoolDetailConfig(arg_8_0, arg_8_1)
	return lua_summon_pool_detail.configDict[arg_8_1]
end

function var_0_0.getPoolDetailConfigList(arg_9_0)
	return lua_summon_pool_detail.configList
end

function var_0_0.getEquipDetailByPoolId(arg_10_0, arg_10_1)
	return arg_10_0._equipPoolDict[arg_10_1]
end

function var_0_0.getSummonPool(arg_11_0, arg_11_1)
	return lua_summon_pool.configDict[arg_11_1]
end

function var_0_0.getSummonLuckyBag(arg_12_0, arg_12_1)
	if not arg_12_0._pool2luckyBagMap then
		arg_12_0._pool2luckyBagMap = {}
	end

	local var_12_0 = arg_12_0._pool2luckyBagMap[arg_12_1]

	if not var_12_0 then
		var_12_0 = var_12_0 or {}

		local var_12_1 = var_0_0.instance:getSummon(arg_12_1)

		if var_12_1 then
			for iter_12_0, iter_12_1 in pairs(var_12_1) do
				if not string.nilorempty(iter_12_1.luckyBagId) then
					tabletool.addValues(var_12_0, string.splitToNumber(iter_12_1.luckyBagId, "#"))
				end
			end
		end

		arg_12_0._pool2luckyBagMap[arg_12_1] = var_12_0
	end

	return var_12_0
end

function var_0_0.getLuckyBag(arg_13_0, arg_13_1, arg_13_2)
	if lua_lucky_bag_heroes.configDict[arg_13_1] then
		return lua_lucky_bag_heroes.configDict[arg_13_1][arg_13_2]
	end
end

function var_0_0.getLuckyBagHeroIds(arg_14_0, arg_14_1, arg_14_2)
	if VersionValidator.instance:isInReviewing() then
		if #lua_app_include.configList > 0 then
			return lua_app_include.configList[1].character
		else
			return {}
		end
	end

	if not arg_14_0._luckyBagHerosMap then
		arg_14_0._luckyBagHerosMap = {}
	end

	if not arg_14_0._luckyBagHerosMap[arg_14_1] then
		arg_14_0._luckyBagHerosMap[arg_14_1] = {}
	end

	local var_14_0 = arg_14_0._luckyBagHerosMap[arg_14_1][arg_14_2]

	if not var_14_0 then
		local var_14_1 = arg_14_0:getLuckyBag(arg_14_1, arg_14_2)

		if var_14_1 then
			var_14_0 = string.splitToNumber(var_14_1.heroChoices, "#")
		else
			logError("summon luckyBag config not found, id = " .. tostring(arg_14_2))

			var_14_0 = {}
		end

		arg_14_0._luckyBagHerosMap[arg_14_1][arg_14_2] = var_14_0
	end

	return var_14_0
end

function var_0_0.getValidPoolList(arg_15_0)
	local var_15_0 = arg_15_0:getSummonPoolList()
	local var_15_1 = {}

	for iter_15_0, iter_15_1 in ipairs(var_15_0) do
		if not string.nilorempty(iter_15_1.customClz) and not string.nilorempty(iter_15_1.prefabPath) then
			table.insert(var_15_1, iter_15_1)
		end
	end

	table.sort(var_15_1, function(arg_16_0, arg_16_1)
		if arg_16_0.priority == arg_16_1.priority then
			return arg_16_0.id < arg_16_1.id
		end

		return arg_16_0.priority > arg_16_1.priority
	end)

	return var_15_1
end

function var_0_0.getSummonSSRTimes(arg_17_0)
	if arg_17_0 then
		var_0_0.instance.ssrTimesMap = var_0_0.instance.ssrTimesMap or {}

		local var_17_0 = var_0_0.instance.ssrTimesMap[arg_17_0.id]

		if not var_17_0 then
			local var_17_1 = string.split(arg_17_0.awardTime, "|")

			if #var_17_1 >= 2 then
				var_17_0 = tonumber(var_17_1[2])
				var_0_0.instance.ssrTimesMap[arg_17_0.id] = var_17_0
			end
		end

		return var_17_0
	end

	return nil
end

function var_0_0.getRewardItems(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	local var_18_0 = {}
	local var_18_1
	local var_18_2 = HeroConfig.instance:getHeroCO(arg_18_1)

	if arg_18_2 <= 0 then
		var_18_1 = var_18_2.firstItem

		if arg_18_3 then
			local var_18_3 = {
				type = MaterialEnum.MaterialType.Hero,
				id = arg_18_1
			}

			var_18_3.quantity = 1

			table.insert(var_18_0, var_18_3)
		end
	elseif arg_18_2 < CommonConfig.instance:getConstNum(ConstEnum.HeroDuplicateGetCount) - 1 then
		var_18_1 = var_18_2.duplicateItem
	else
		var_18_1 = var_18_2.duplicateItem2
	end

	if not string.nilorempty(var_18_1) then
		local var_18_4 = string.split(var_18_1, "|")

		for iter_18_0, iter_18_1 in ipairs(var_18_4) do
			local var_18_5 = {}
			local var_18_6 = string.split(iter_18_1, "#")

			var_18_5.type = tonumber(var_18_6[1])
			var_18_5.id = tonumber(var_18_6[2])
			var_18_5.quantity = tonumber(var_18_6[3])

			table.insert(var_18_0, var_18_5)
		end
	end

	return var_18_0
end

function var_0_0.canShowSingleFree(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0:getSummonPool(arg_19_1)

	return var_19_0 ~= nil and var_19_0.totalFreeCount ~= nil and var_19_0.totalFreeCount > 0
end

function var_0_0.isLuckyBagPoolExist(arg_20_0)
	local var_20_0 = arg_20_0:getSummonPoolList()

	for iter_20_0, iter_20_1 in pairs(var_20_0) do
		if iter_20_1.type == SummonEnum.Type.LuckyBag then
			return true
		end
	end

	return false
end

function var_0_0.poolIsLuckyBag(arg_21_0)
	local var_21_0 = var_0_0.instance:getSummonPool(arg_21_0)

	if var_21_0 then
		return var_0_0.poolTypeIsLuckyBag(var_21_0.type)
	end

	return false
end

function var_0_0.poolTypeIsLuckyBag(arg_22_0)
	return arg_22_0 == SummonEnum.Type.LuckyBag
end

function var_0_0.getSummonDetailIdByHeroId(arg_23_0, arg_23_1)
	for iter_23_0, iter_23_1 in ipairs(lua_summon_character.configList) do
		if iter_23_1.heroId == arg_23_1 then
			return iter_23_1.id
		end
	end
end

function var_0_0.isStrongCustomChoice(arg_24_0, arg_24_1)
	local var_24_0 = var_0_0.instance:getSummonPool(arg_24_1)

	if var_24_0 then
		return var_24_0.type == SummonEnum.Type.StrongCustomOnePick
	end

	return false
end

function var_0_0.getStrongCustomChoiceIds(arg_25_0, arg_25_1)
	local var_25_0 = var_0_0.instance:getSummonPool(arg_25_1)

	if var_25_0 and var_25_0.type == SummonEnum.Type.StrongCustomOnePick then
		return string.splitToNumber(var_25_0.param, "#")
	end

	return nil
end

function var_0_0.getProgressRewardsByPoolId(arg_26_0, arg_26_1)
	if not arg_26_0._poolProgressRewardsDic then
		arg_26_0._poolProgressRewardsDic = {}

		local var_26_0 = arg_26_0:getSummonPoolList()

		for iter_26_0, iter_26_1 in ipairs(var_26_0) do
			if iter_26_1 and not string.nilorempty(iter_26_1.progressRewards) then
				arg_26_0._poolProgressRewardsDic[iter_26_1.id] = GameUtil.splitString2(iter_26_1.progressRewards, true)
			end
		end
	end

	return arg_26_0._poolProgressRewardsDic[arg_26_1]
end

var_0_0.instance = var_0_0.New()

return var_0_0
