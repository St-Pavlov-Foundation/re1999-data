module("modules.logic.character.model.HeroSkillModel", package.seeall)

local var_0_0 = class("HeroSkillModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0._skillTagInfos = {}
end

function var_0_0._initSkillTagInfos(arg_2_0)
	local var_2_0 = SkillConfig.instance:getSkillEffectDescsCo()

	for iter_2_0, iter_2_1 in pairs(var_2_0) do
		arg_2_0._skillTagInfos[iter_2_1.name] = iter_2_1
	end
end

function var_0_0.isTagSkillInfo(arg_3_0, arg_3_1)
	return arg_3_0._skillTagInfos[arg_3_1]
end

function var_0_0.getSkillTagInfoColorType(arg_4_0, arg_4_1)
	return arg_4_0._skillTagInfos[arg_4_1].color
end

function var_0_0.getSkillTagInfoDesc(arg_5_0, arg_5_1)
	return arg_5_0._skillTagInfos[arg_5_1].desc
end

function var_0_0.getEffectTagIDsFromDescNotRecursion(arg_6_0, arg_6_1)
	if not arg_6_0._skillTagInfos or not next(arg_6_0._skillTagInfos) then
		arg_6_0:_initSkillTagInfos()
	end

	local var_6_0 = {}

	arg_6_1 = not arg_6_1 and "" or arg_6_1
	arg_6_1 = string.gsub(arg_6_1, "【", "[")
	arg_6_1 = string.gsub(arg_6_1, "】", "]")

	for iter_6_0 in string.gmatch(arg_6_1, "%[(.-)%]") do
		if string.nilorempty(iter_6_0) or arg_6_0._skillTagInfos[iter_6_0] == nil then
			logError(string.format(" '%s' 技能描述中， '%s' tag 不存在", arg_6_1, iter_6_0))
		else
			table.insert(var_6_0, arg_6_0._skillTagInfos[iter_6_0].id)
		end
	end

	return var_6_0
end

function var_0_0.getEffectTagIDsFromDescRecursion(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0:getEffectTagIDsFromDescNotRecursion(arg_7_1)

	return arg_7_0:treeLevelTraversal(var_7_0, {}, {})
end

function var_0_0.getEffectTagDescFromDescRecursion(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = var_0_0.instance:getEffectTagIDsFromDescRecursion(arg_8_1)
	local var_8_1 = ""
	local var_8_2 = {}

	for iter_8_0 = 1, #var_8_0 do
		local var_8_3 = SkillConfig.instance:getSkillEffectDescCo(var_8_0[iter_8_0])

		if var_8_3 then
			local var_8_4 = var_8_3.name

			if var_0_0.instance:canShowSkillTag(var_8_4) and not var_8_2[var_8_4] then
				var_8_2[var_8_4] = true
				var_8_1 = var_8_1 .. string.format("<color=%s>[%s]</color>:%s\n", arg_8_2, var_8_4, var_8_3.desc)
			end
		end
	end

	return var_8_1
end

function var_0_0.getEffectTagDescIdList(arg_9_0, arg_9_1)
	local var_9_0 = var_0_0.instance:getEffectTagIDsFromDescRecursion(arg_9_1)
	local var_9_1 = {}
	local var_9_2 = {}

	for iter_9_0 = 1, #var_9_0 do
		local var_9_3 = SkillConfig.instance:getSkillEffectDescCo(var_9_0[iter_9_0])

		if var_9_3 then
			local var_9_4 = var_9_3.name

			if var_0_0.instance:canShowSkillTag(var_9_4) and not var_9_2[var_9_4] then
				var_9_2[var_9_4] = true

				table.insert(var_9_1, var_9_3.id)
			end
		end
	end

	return var_9_1
end

function var_0_0.canShowSkillTag(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = SkillConfig.instance:getSkillEffectDescCoByName(arg_10_1)

	return SkillHelper.canShowTag(var_10_0)
end

function var_0_0.getSkillEffectTagIdsFormDescTabRecursion(arg_11_0, arg_11_1)
	local var_11_0 = {}
	local var_11_1 = {}
	local var_11_2 = {}

	for iter_11_0, iter_11_1 in pairs(arg_11_1) do
		local var_11_3 = arg_11_0:getEffectTagIDsFromDescNotRecursion(iter_11_1)

		var_11_2[iter_11_0] = arg_11_0:treeLevelTraversal(var_11_3, {}, var_11_0)
	end

	return var_11_2
end

function var_0_0.treeLevelTraversal(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	if #arg_12_1 == 0 then
		return arg_12_2
	end

	for iter_12_0 = 1, #arg_12_1 do
		local var_12_0 = table.remove(arg_12_1, 1)

		if not arg_12_3[var_12_0] then
			arg_12_3[var_12_0] = true

			table.insert(arg_12_2, var_12_0)

			local var_12_1 = arg_12_0:getEffectTagIDsFromDescNotRecursion(SkillConfig.instance:getSkillEffectDescCo(var_12_0).desc)

			for iter_12_1, iter_12_2 in ipairs(var_12_1) do
				if not arg_12_3[iter_12_2] then
					table.insert(arg_12_1, iter_12_2)
				end
			end
		end
	end

	return arg_12_0:treeLevelTraversal(arg_12_1, arg_12_2, arg_12_3)
end

function var_0_0.skillDesToSpot(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	if string.nilorempty(arg_13_2) then
		arg_13_2 = "#C66030"
	end

	if string.nilorempty(arg_13_3) then
		arg_13_3 = "#4e6698"
	end

	local var_13_0 = string.gsub(arg_13_1, "(%-%d+%%)", "{%1}")
	local var_13_1 = string.gsub(var_13_0, "(%+%d+%%)", "{%1}")
	local var_13_2 = string.gsub(var_13_1, "(%-%d+%.*%d*%%)", "{%1}")
	local var_13_3 = string.gsub(var_13_2, "(%d+%.*%d*%%)", "{%1}")
	local var_13_4 = string.gsub(var_13_3, "%[", string.format("<color=%s>[", arg_13_3))
	local var_13_5 = string.gsub(var_13_4, "%【", string.format("<color=%s>[", arg_13_3))
	local var_13_6 = string.gsub(var_13_5, "%]", "]</color>")
	local var_13_7 = string.gsub(var_13_6, "%】", "]</color>")
	local var_13_8 = string.gsub(var_13_7, "%{", string.format("<color=%s>", arg_13_2))
	local var_13_9 = string.gsub(var_13_8, "%}", "</color>")
	local var_13_10 = arg_13_0:spotSkillAttribute(var_13_9, arg_13_4)

	return (SkillConfig.instance:processSkillDesKeyWords(var_13_10))
end

function var_0_0.spotSkillAttribute(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = arg_14_1
	local var_14_1 = HeroConfig.instance:getHeroAttributesCO()

	for iter_14_0, iter_14_1 in pairs(var_14_1) do
		if iter_14_1.showcolor == 1 and not arg_14_2 then
			var_14_0 = string.gsub(var_14_0, iter_14_1.name, string.format("<u>%s</u>", iter_14_1.name))
		end
	end

	return var_14_0
end

function var_0_0.formatDescWithColor(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	arg_15_2 = arg_15_2 or "#d7a270"
	arg_15_3 = arg_15_3 or "#5f7197"

	local var_15_0 = arg_15_1

	if arg_15_4 ~= true then
		local var_15_1 = {}
		local var_15_2 = 0

		var_15_0 = string.gsub(var_15_0, "(%[.-%])", function(arg_16_0)
			var_15_2 = var_15_2 + 1
			var_15_1[var_15_2] = arg_16_0

			return "▩replace▩"
		end)
		var_15_0 = string.gsub(var_15_0, "(【.-】)", function(arg_17_0)
			var_15_2 = var_15_2 + 1
			var_15_1[var_15_2] = arg_17_0

			return "▩replace▩"
		end)
		var_15_0 = string.gsub(var_15_0, "([%d%-%+%%%./]+)", string.format("<color=%s>%%1</color>", arg_15_2))

		local var_15_3 = 0

		var_15_0 = string.gsub(var_15_0, "▩replace▩", function()
			var_15_3 = var_15_3 + 1

			return var_15_1[var_15_3]
		end)
	end

	local var_15_4 = string.gsub(var_15_0, "(%[.-%])", string.format("<color=%s>%%1</color>", arg_15_3))

	return (string.gsub(var_15_4, "(【.-】)", string.format("<color=%s>%%1</color>", arg_15_3)))
end

var_0_0.instance = var_0_0.New()

return var_0_0
