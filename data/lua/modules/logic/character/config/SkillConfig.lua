module("modules.logic.character.config.SkillConfig", package.seeall)

local var_0_0 = class("SkillConfig", BaseConfig)

function var_0_0.ctor(arg_1_0)
	arg_1_0.passiveskillConfig = nil
	arg_1_0.exskillConfig = nil
	arg_1_0.levelConfig = nil
	arg_1_0.rankConfig = nil
	arg_1_0.cosumeConfig = nil
	arg_1_0.talentConfig = nil
	arg_1_0.growConfig = nil
	arg_1_0.skillBuffDescConfig = nil
	arg_1_0.skillBuffDescConfigByName = nil
	arg_1_0.heroUpgradeBreakLevelConfig = nil
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"character_level",
		"skill_ex_level",
		"character_rank",
		"character_talent",
		"character_grow",
		"skill_passive_level",
		"character_cosume",
		"skill_eff_desc",
		"fight_const",
		"skill_buff_desc",
		"hero_upgrade_breaklevel",
		"fight_card_footnote"
	}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "character_talent" then
		arg_3_0.talentConfig = arg_3_2
	elseif arg_3_1 == "skill_ex_level" then
		local function var_3_0(arg_4_0, arg_4_1, arg_4_2)
			logError("Can't modify config field: " .. arg_4_1)
		end

		for iter_3_0, iter_3_1 in ipairs(arg_3_2.configList) do
			local var_3_1 = getmetatable(iter_3_1)

			var_3_1.__newindex = nil
			iter_3_1.skillGroup1 = string.split(iter_3_1.skillGroup1, ",")[1]
			iter_3_1.skillGroup2 = string.split(iter_3_1.skillGroup2, ",")[1]
			var_3_1.__newindex = var_3_0
		end

		arg_3_0.exskillConfig = arg_3_2
	elseif arg_3_1 == "skill_passive_level" then
		arg_3_0.passiveskillConfig = arg_3_2
	elseif arg_3_1 == "character_level" then
		arg_3_0.levelConfig = arg_3_2
	elseif arg_3_1 == "character_rank" then
		arg_3_0.rankConfig = arg_3_2
	elseif arg_3_1 == "character_cosume" then
		arg_3_0.cosumeConfig = arg_3_2
	elseif arg_3_1 == "character_grow" then
		arg_3_0.growConfig = arg_3_2
	elseif arg_3_1 == "skill_eff_desc" then
		arg_3_0.skillEffectDescConfig = arg_3_2
	elseif arg_3_1 == "skill_buff_desc" then
		arg_3_0.skillBuffDescConfig = arg_3_2
	elseif arg_3_1 == "hero_upgrade_breaklevel" then
		arg_3_0.heroUpgradeBreakLevelConfig = arg_3_2
	elseif arg_3_1 == "fight_card_footnote" then
		arg_3_0.fightCardFootnoteConfig = arg_3_2
	end
end

function var_0_0.getGrowCo(arg_5_0)
	return arg_5_0.growConfig.configDict
end

function var_0_0.getGrowCO(arg_6_0, arg_6_1)
	return arg_6_0.growConfig.configDict[arg_6_1]
end

function var_0_0.gettalentCO(arg_7_0, arg_7_1, arg_7_2)
	return arg_7_0.talentConfig.configDict[arg_7_1][arg_7_2]
end

function var_0_0.getherotalentsCo(arg_8_0, arg_8_1)
	return arg_8_0.talentConfig.configDict[arg_8_1]
end

function var_0_0.getpassiveskillCO(arg_9_0, arg_9_1, arg_9_2)
	return arg_9_0.passiveskillConfig.configDict[arg_9_1][arg_9_2]
end

function var_0_0.getpassiveskillsCO(arg_10_0, arg_10_1)
	return arg_10_0.passiveskillConfig.configDict[arg_10_1]
end

function var_0_0.getHeroExSkillLevelByLevel(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = 0
	local var_11_1 = 1
	local var_11_2 = arg_11_0:getheroranksCO(arg_11_1)

	for iter_11_0 = 1, #var_11_2 do
		local var_11_3 = GameUtil.splitString2(var_11_2[iter_11_0].effect, true)
		local var_11_4 = false

		for iter_11_1, iter_11_2 in pairs(var_11_3) do
			if iter_11_2[1] == 1 and arg_11_2 <= iter_11_2[2] then
				var_11_1 = iter_11_0
				var_11_4 = true

				break
			end
		end

		if var_11_4 then
			for iter_11_3, iter_11_4 in pairs(var_11_3) do
				if iter_11_4[1] == 2 then
					var_11_0 = iter_11_4[2]

					break
				end
			end
		end

		if var_11_4 then
			break
		end
	end

	return var_11_0, var_11_1
end

function var_0_0.getPassiveSKillsCoByExSkillLevel(arg_12_0, arg_12_1, arg_12_2)
	arg_12_2 = arg_12_2 or 1

	local var_12_0 = arg_12_0:getpassiveskillsCO(arg_12_1)
	local var_12_1 = tabletool.copy(var_12_0)
	local var_12_2

	for iter_12_0 = arg_12_2, 1, -1 do
		local var_12_3 = arg_12_0:getherolevelexskillCO(arg_12_1, iter_12_0)

		if not string.nilorempty(var_12_3.passiveSkill) then
			arg_12_0:_handleReplacePassiveSkill(var_12_3.passiveSkill, var_12_1)
		end
	end

	return var_12_1
end

function var_0_0._handleReplacePassiveSkill(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = string.split(arg_13_1, "|")
	local var_13_1
	local var_13_2
	local var_13_3

	for iter_13_0, iter_13_1 in ipairs(var_13_0) do
		local var_13_4 = string.splitToNumber(iter_13_1, "#")
		local var_13_5 = var_13_4[1]
		local var_13_6 = var_13_4[2]

		for iter_13_2, iter_13_3 in pairs(arg_13_2) do
			if iter_13_3.skillPassive == var_13_5 then
				arg_13_2[iter_13_2] = {
					skillPassive = var_13_6
				}

				break
			end
		end
	end
end

function var_0_0.getherolevelexskillCO(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = arg_14_0.exskillConfig.configDict[arg_14_1]

	if not var_14_0 then
		logError(string.format("ex skill not found heroid : %s `s config ", arg_14_1))

		return nil
	end

	if var_14_0[arg_14_2] == nil then
		logError(string.format("ex skill config gei nil, heroid : %s, skillLevel : %s", arg_14_1, arg_14_2))
	end

	return var_14_0[arg_14_2]
end

function var_0_0.getheroexskillco(arg_15_0, arg_15_1)
	return arg_15_0.exskillConfig.configDict[arg_15_1]
end

function var_0_0.getExSkillLevel(arg_16_0, arg_16_1)
	if not arg_16_0._exSkillLevel then
		arg_16_0._exSkillLevel = {}

		for iter_16_0, iter_16_1 in ipairs(arg_16_0.exskillConfig.configList) do
			arg_16_0._exSkillLevel[iter_16_1.skillEx] = iter_16_1.skillLevel
		end
	end

	return arg_16_0._exSkillLevel[arg_16_1]
end

function var_0_0.getherolevelCO(arg_17_0, arg_17_1, arg_17_2)
	return arg_17_0.levelConfig.configDict[arg_17_1][arg_17_2]
end

function var_0_0.getherolevelsCO(arg_18_0, arg_18_1)
	return arg_18_0.levelConfig.configDict[arg_18_1]
end

function var_0_0.getherorankCO(arg_19_0, arg_19_1, arg_19_2)
	return arg_19_0.rankConfig.configDict[arg_19_1][arg_19_2]
end

function var_0_0.getheroranksCO(arg_20_0, arg_20_1)
	return arg_20_0.rankConfig.configDict[arg_20_1]
end

function var_0_0.getHeroRankAttribute(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = {}

	var_21_0.hp = 0
	var_21_0.atk = 0
	var_21_0.def = 0
	var_21_0.mdef = 0
	var_21_0.technic = 0

	local var_21_1 = arg_21_0:getheroranksCO(arg_21_1)

	for iter_21_0, iter_21_1 in pairs(var_21_1) do
		if arg_21_2 >= iter_21_1.rank then
			local var_21_2 = arg_21_0:getHeroAttributeByRankConfig(iter_21_1)

			var_21_0.hp = var_21_0.hp + var_21_2.hp
			var_21_0.atk = var_21_0.atk + var_21_2.atk
			var_21_0.def = var_21_0.def + var_21_2.def
			var_21_0.mdef = var_21_0.mdef + var_21_2.mdef
			var_21_0.technic = var_21_0.technic + var_21_2.technic
		end
	end

	return var_21_0
end

function var_0_0.getHeroAttributeByRankConfig(arg_22_0, arg_22_1)
	local var_22_0 = {}

	var_22_0.hp = 0
	var_22_0.atk = 0
	var_22_0.def = 0
	var_22_0.mdef = 0
	var_22_0.technic = 0

	local var_22_1 = arg_22_1.effect

	if string.nilorempty(var_22_1) then
		return var_22_0
	end

	local var_22_2 = string.split(var_22_1, "|")

	for iter_22_0, iter_22_1 in ipairs(var_22_2) do
		local var_22_3 = string.split(iter_22_1, "#")

		if tonumber(var_22_3[1]) == 4 then
			local var_22_4 = tonumber(var_22_3[2]) / 1000
			local var_22_5 = arg_22_0:getherolevelCO(arg_22_1.heroId, 1)

			var_22_0.hp = var_22_0.hp + math.floor(var_22_5.hp * var_22_4)
			var_22_0.atk = var_22_0.atk + math.floor(var_22_5.atk * var_22_4)
			var_22_0.def = var_22_0.def + math.floor(var_22_5.def * var_22_4)
			var_22_0.mdef = var_22_0.mdef + math.floor(var_22_5.mdef * var_22_4)
			var_22_0.technic = var_22_0.technic + math.floor(var_22_5.technic * var_22_4)
		end
	end

	return var_22_0
end

function var_0_0.getcosumeCO(arg_23_0, arg_23_1, arg_23_2)
	return arg_23_0.cosumeConfig.configDict[arg_23_1][arg_23_2]
end

function var_0_0.getSkillEffectDescsCo(arg_24_0)
	return arg_24_0.skillEffectDescConfig.configDict
end

function var_0_0.getSkillEffectDescCo(arg_25_0, arg_25_1)
	return arg_25_0.skillEffectDescConfig.configDict[arg_25_1]
end

function var_0_0.getSkillEffectDescCoByName(arg_26_0, arg_26_1)
	if not arg_26_0.skillBuffDescConfigByName then
		arg_26_0.skillBuffDescConfigByName = {}

		for iter_26_0, iter_26_1 in ipairs(arg_26_0.skillEffectDescConfig.configList) do
			arg_26_0.skillBuffDescConfigByName[iter_26_1.name] = iter_26_1
		end
	end

	local var_26_0 = arg_26_0.skillBuffDescConfigByName[arg_26_1]

	if not var_26_0 then
		logError(string.format("技能概要 '%s' 不存在!!!", tostring(arg_26_1)))
	end

	return var_26_0
end

function var_0_0.processSkillDesKeyWords(arg_27_0, arg_27_1)
	return string.gsub(arg_27_1, "<id:(.-)>", "")
end

function var_0_0.getSkillBuffDescsCo(arg_28_0)
	return arg_28_0.skillBuffDescConfig.configDict
end

function var_0_0.getSkillBuffDescCo(arg_29_0, arg_29_1)
	return arg_29_0.skillBuffDescConfig.configDict[arg_29_1]
end

function var_0_0.isGetNewSkin(arg_30_0, arg_30_1, arg_30_2)
	local var_30_0 = arg_30_0:getherorankCO(arg_30_1, arg_30_2)

	if not var_30_0 then
		logError("获取角色升级信息失败， heroId : " .. tostring(arg_30_1) .. ", rank : " .. tostring(arg_30_2))

		return false
	end

	local var_30_1 = string.split(var_30_0.effect, "|")

	for iter_30_0 = 1, #var_30_1 do
		if string.splitToNumber(var_30_1[iter_30_0], "#")[1] == 3 then
			return true
		end
	end

	return false
end

function var_0_0.getBaseAttr(arg_31_0, arg_31_1, arg_31_2)
	local var_31_0 = {}
	local var_31_1 = arg_31_0:getherolevelCO(arg_31_1, arg_31_2)

	if not var_31_1 then
		local var_31_2 = arg_31_0:getherolevelsCO(arg_31_1)
		local var_31_3
		local var_31_4
		local var_31_5 = {}

		for iter_31_0, iter_31_1 in pairs(var_31_2) do
			table.insert(var_31_5, iter_31_1)
		end

		table.sort(var_31_5, function(arg_32_0, arg_32_1)
			return arg_32_0.level < arg_32_1.level
		end)

		for iter_31_2, iter_31_3 in ipairs(var_31_5) do
			if arg_31_2 > iter_31_3.level then
				var_31_3 = iter_31_3.level
				var_31_4 = var_31_5[iter_31_2 + 1].level
			end
		end

		local var_31_6 = arg_31_0:getherolevelCO(arg_31_1, var_31_3)
		local var_31_7 = arg_31_0:getherolevelCO(arg_31_1, var_31_4)

		var_31_0.hp = arg_31_0:_lerpAttr(var_31_6.hp, var_31_7.hp, var_31_3, var_31_4, arg_31_2)
		var_31_0.atk = arg_31_0:_lerpAttr(var_31_6.atk, var_31_7.atk, var_31_3, var_31_4, arg_31_2)
		var_31_0.def = arg_31_0:_lerpAttr(var_31_6.def, var_31_7.def, var_31_3, var_31_4, arg_31_2)
		var_31_0.mdef = arg_31_0:_lerpAttr(var_31_6.mdef, var_31_7.mdef, var_31_3, var_31_4, arg_31_2)
		var_31_0.technic = arg_31_0:_lerpAttr(var_31_6.technic, var_31_7.technic, var_31_3, var_31_4, arg_31_2)
		var_31_0.cri = arg_31_0:_lerpAttr(var_31_6.cri, var_31_7.cri, var_31_3, var_31_4, arg_31_2)
		var_31_0.recri = arg_31_0:_lerpAttr(var_31_6.recri, var_31_7.recri, var_31_3, var_31_4, arg_31_2)
		var_31_0.cri_dmg = arg_31_0:_lerpAttr(var_31_6.cri_dmg, var_31_7.cri_dmg, var_31_3, var_31_4, arg_31_2)
		var_31_0.cri_def = arg_31_0:_lerpAttr(var_31_6.cri_def, var_31_7.cri_def, var_31_3, var_31_4, arg_31_2)
		var_31_0.add_dmg = arg_31_0:_lerpAttr(var_31_6.add_dmg, var_31_7.add_dmg, var_31_3, var_31_4, arg_31_2)
		var_31_0.drop_dmg = arg_31_0:_lerpAttr(var_31_6.drop_dmg, var_31_7.drop_dmg, var_31_3, var_31_4, arg_31_2)
	else
		var_31_0.hp = var_31_1.hp
		var_31_0.atk = var_31_1.atk
		var_31_0.def = var_31_1.def
		var_31_0.mdef = var_31_1.mdef
		var_31_0.technic = var_31_1.technic
		var_31_0.cri = var_31_1.cri
		var_31_0.recri = var_31_1.recri
		var_31_0.cri_dmg = var_31_1.cri_dmg
		var_31_0.cri_def = var_31_1.cri_def
		var_31_0.add_dmg = var_31_1.add_dmg
		var_31_0.drop_dmg = var_31_1.drop_dmg
	end

	return var_31_0
end

function var_0_0._lerpAttr(arg_33_0, arg_33_1, arg_33_2, arg_33_3, arg_33_4, arg_33_5)
	return math.floor((arg_33_2 - arg_33_1) * (arg_33_5 - arg_33_3) / (arg_33_4 - arg_33_3)) + arg_33_1
end

function var_0_0.getTalentDamping(arg_34_0)
	if arg_34_0.talent_damping then
		return arg_34_0.talent_damping
	end

	arg_34_0.talent_damping = {}

	local var_34_0 = string.split(lua_fight_const.configDict[10][2], "|")

	for iter_34_0, iter_34_1 in ipairs(var_34_0) do
		local var_34_1 = string.splitToNumber(iter_34_1, "#")

		table.insert(arg_34_0.talent_damping, var_34_1)
	end

	return arg_34_0.talent_damping
end

function var_0_0.getExSkillDesc(arg_35_0, arg_35_1, arg_35_2)
	if arg_35_1 == nil then
		return ""
	end

	local var_35_0 = arg_35_1.desc

	arg_35_2 = arg_35_2 or arg_35_1.heroId

	local var_35_1 = {}

	for iter_35_0, iter_35_1 in string.gmatch(var_35_0, "▩(%d)%%s<(%d)>") do
		local var_35_2 = arg_35_0:_matchChioceSkill(iter_35_0, iter_35_1, arg_35_2)

		if var_35_2 then
			table.insert(var_35_1, var_35_2)
		end
	end

	local var_35_3, var_35_4 = next(var_35_1)

	if var_35_4 then
		return var_35_0, var_35_4.skillName, var_35_4.skillIndex, var_35_1
	end

	local var_35_5, var_35_6, var_35_7 = string.find(var_35_0, "▩(%d)%%s")

	if not var_35_7 then
		logError("not fount skillIndex in desc : " .. var_35_0)

		return var_35_0
	end

	local var_35_8 = tonumber(var_35_7)
	local var_35_9

	if var_35_8 == 0 then
		var_35_9 = var_0_0.instance:getpassiveskillsCO(arg_35_2)[1].skillPassive
	else
		local var_35_10 = var_0_0.instance:getHeroBaseSkillIdDict(arg_35_2, true)

		var_35_9 = var_35_10 and var_35_10[var_35_8]
	end

	if not var_35_9 then
		logError("not fount skillId, skillIndex : " .. var_35_8)

		return var_35_0
	end

	return var_35_0, lua_skill.configDict[var_35_9].name, var_35_8
end

function var_0_0._getHeroWeaponReplaceSkill(arg_36_0, arg_36_1)
	local var_36_0 = HeroModel.instance:getByHeroId(arg_36_1)

	if var_36_0 and var_36_0.extraMo then
		local var_36_1 = var_36_0.extraMo:getWeaponMo()

		if var_36_1 then
			return var_36_1:getReplaceSkill()
		end
	end
end

function var_0_0._matchChioceSkill(arg_37_0, arg_37_1, arg_37_2, arg_37_3)
	if arg_37_2 and arg_37_1 then
		arg_37_1 = tonumber(arg_37_1)
		arg_37_2 = tonumber(arg_37_2)

		local var_37_0

		if arg_37_1 == 0 then
			var_37_0 = arg_37_0:getpassiveskillsCO(arg_37_3)[1].skillPassive
		else
			local var_37_1 = arg_37_0:getHeroBaseSkillIdDict(arg_37_3, true)

			var_37_0 = var_37_1 and var_37_1[arg_37_1]
		end

		local var_37_2 = arg_37_0:getFightCardChoiceSkillIdByIndex(var_37_0, arg_37_2)

		if var_37_2 then
			local var_37_3 = lua_skill.configDict[var_37_2].name

			return {
				skillId = var_37_0,
				skillName = var_37_3,
				skillIndex = arg_37_1,
				choiceSkillIndex = arg_37_2
			}
		end
	end
end

function var_0_0.getHeroBaseSkillIdDict(arg_38_0, arg_38_1, arg_38_2)
	local var_38_0, var_38_1, var_38_2 = arg_38_0:_getHeroSkillAndExSkill(arg_38_1, arg_38_2)

	return arg_38_0:getHeroBaseSkillIdDictByStr(var_38_0, var_38_1), var_38_2
end

function var_0_0._getHeroSkillAndExSkill(arg_39_0, arg_39_1, arg_39_2)
	local var_39_0 = HeroConfig.instance:getHeroCO(arg_39_1)
	local var_39_1 = var_39_0.skill
	local var_39_2 = var_39_0.exSkill

	if arg_39_2 then
		local var_39_3 = HeroConfig.instance:getHeroRankReplaceConfig(arg_39_1)

		if var_39_3 then
			var_39_1 = var_39_3.skill
			var_39_2 = var_39_3.exSkill

			return var_39_1, var_39_2
		end
	end

	local var_39_4, var_39_5 = arg_39_0:_getHeroWeaponReplaceSkill(arg_39_1)

	if var_39_4 or var_39_5 then
		var_39_1 = var_39_4 or var_39_1
		var_39_2 = var_39_5 or var_39_2

		return var_39_1, var_39_2, true
	end

	return var_39_1, var_39_2
end

function var_0_0.getHeroBaseSkillIdDictByStr(arg_40_0, arg_40_1, arg_40_2)
	local var_40_0 = {}
	local var_40_1 = string.split(arg_40_1, "|")
	local var_40_2
	local var_40_3
	local var_40_4

	for iter_40_0 = 1, #var_40_1 do
		local var_40_5 = string.split(var_40_1[iter_40_0], ",")
		local var_40_6 = string.splitToNumber(var_40_5[1], "#")

		var_40_0[var_40_6[1]] = var_40_6[2]
	end

	var_40_0[3] = arg_40_2

	return var_40_0
end

function var_0_0.getHeroAllSkillIdDict(arg_41_0, arg_41_1, arg_41_2)
	local var_41_0, var_41_1, var_41_2 = arg_41_0:_getHeroSkillAndExSkill(arg_41_1, arg_41_2)

	return arg_41_0:getHeroAllSkillIdDictByStr(var_41_0, var_41_1), var_41_2
end

function var_0_0.getHeroAllSkillIdDictByStr(arg_42_0, arg_42_1, arg_42_2)
	local var_42_0 = {}
	local var_42_1 = string.split(arg_42_1, "|")
	local var_42_2
	local var_42_3

	for iter_42_0 = 1, #var_42_1 do
		local var_42_4 = string.split(var_42_1[iter_42_0], ",")
		local var_42_5 = string.splitToNumber(var_42_4[1], "#")

		var_42_0[table.remove(var_42_5, 1)] = var_42_5
	end

	var_42_0[3] = {
		arg_42_2
	}

	return var_42_0
end

function var_0_0._isNeedReplaceExSkill(arg_43_0, arg_43_1)
	if arg_43_1 and lua_character_rank_replace.configDict[arg_43_1.heroId] then
		local var_43_0 = arg_43_1.rank or 0
		local var_43_1 = lua_character_limited.configDict[arg_43_1.skin]
		local var_43_2 = string.split(var_43_1.specialLive2d, "#")

		return var_43_0 > (var_43_2[2] and tonumber(var_43_2[2]) or 3) - 1
	end

	return true
end

function var_0_0.getHeroBaseSkillIdDictByExSkillLevel(arg_44_0, arg_44_1, arg_44_2, arg_44_3)
	if arg_44_3 and arg_44_3.trialAttrCo then
		local var_44_0 = arg_44_0:getHeroBaseSkillIdDictByStr(arg_44_3.trialAttrCo.activeSkill, arg_44_3.trialAttrCo.uniqueSkill)

		return (arg_44_0:_checkReplaceSkill(var_44_0, arg_44_3))
	end

	local var_44_1 = arg_44_3 and arg_44_3.rank > CharacterModel.instance:getReplaceSkillRank(arg_44_3) - 1
	local var_44_2 = arg_44_0:getHeroBaseSkillIdDict(arg_44_1, var_44_1)

	arg_44_3 = arg_44_3 or HeroModel.instance:getByHeroId(arg_44_1)

	if arg_44_0:_isNeedReplaceExSkill(arg_44_3) then
		var_44_2 = arg_44_0:getHeroExBaseSkillIdDict(arg_44_1, arg_44_3, var_44_2, arg_44_2)
	end

	return (arg_44_0:_checkDestinyEffect(var_44_2, arg_44_3))
end

function var_0_0.getHeroExBaseSkillIdDict(arg_45_0, arg_45_1, arg_45_2, arg_45_3, arg_45_4)
	arg_45_4 = arg_45_4 or CharacterEnum.showAttributeOption.ShowCurrent

	local var_45_0 = 0

	if arg_45_4 == CharacterEnum.showAttributeOption.ShowMax then
		var_45_0 = CharacterModel.instance:getMaxexskill(arg_45_1)
	else
		var_45_0 = arg_45_4 == CharacterEnum.showAttributeOption.ShowMin and 0 or arg_45_2.exSkillLevel
	end

	if var_45_0 < 1 then
		arg_45_3 = arg_45_0:_checkReplaceSkill(arg_45_3, arg_45_2)

		return arg_45_3
	end

	local var_45_1 = math.min(var_45_0, CharacterEnum.MaxSkillExLevel)
	local var_45_2

	for iter_45_0 = 1, var_45_1 do
		local var_45_3 = arg_45_0:getherolevelexskillCO(arg_45_1, iter_45_0)

		if not string.nilorempty(var_45_3.skillGroup1) then
			arg_45_3[1] = string.splitToNumber(var_45_3.skillGroup1, "|")[1]
		end

		if not string.nilorempty(var_45_3.skillGroup2) then
			arg_45_3[2] = string.splitToNumber(var_45_3.skillGroup2, "|")[1]
		end

		if var_45_3.skillEx ~= 0 then
			arg_45_3[3] = var_45_3.skillEx
		end
	end

	arg_45_3 = arg_45_0:_checkReplaceSkill(arg_45_3, arg_45_2)

	return arg_45_3
end

function var_0_0._checkReplaceSkill(arg_46_0, arg_46_1, arg_46_2)
	if arg_46_1 and arg_46_2 then
		arg_46_1 = arg_46_2:checkReplaceSkill(arg_46_1)
	end

	return arg_46_1
end

function var_0_0._checkDestinyEffect(arg_47_0, arg_47_1, arg_47_2)
	if arg_47_1 and arg_47_2 and arg_47_2.destinyStoneMo then
		arg_47_1 = arg_47_2.destinyStoneMo:_replaceSkill(arg_47_1)
	end

	return arg_47_1
end

function var_0_0.getHeroAllSkillIdDictByExSkillLevel(arg_48_0, arg_48_1, arg_48_2, arg_48_3, arg_48_4, arg_48_5)
	if arg_48_3 and arg_48_3.trialAttrCo then
		return arg_48_0:getHeroAllSkillIdDictByStr(arg_48_3.trialAttrCo.activeSkill, arg_48_3.trialAttrCo.uniqueSkill)
	end

	local var_48_0 = arg_48_5 or arg_48_3 and arg_48_3.rank > CharacterModel.instance:getReplaceSkillRank(arg_48_3) - 1
	local var_48_1, var_48_2 = arg_48_0:getHeroAllSkillIdDict(arg_48_1, var_48_0)

	if var_48_2 then
		return var_48_1
	end

	arg_48_3 = arg_48_3 or HeroModel.instance:getByHeroId(arg_48_1)

	if not arg_48_0:_isNeedReplaceExSkill(arg_48_3) then
		return var_48_1
	end

	arg_48_2 = arg_48_2 or CharacterEnum.showAttributeOption.ShowCurrent

	local var_48_3 = 0

	if arg_48_2 == CharacterEnum.showAttributeOption.ShowMax then
		var_48_3 = CharacterModel.instance:getMaxexskill(arg_48_1)
	elseif arg_48_2 == CharacterEnum.showAttributeOption.ShowMin then
		var_48_3 = 0
	elseif arg_48_4 then
		var_48_3 = arg_48_4
	elseif arg_48_3 then
		var_48_3 = arg_48_3.exSkillLevel
	end

	if var_48_3 < 1 then
		return var_48_1
	end

	local var_48_4

	for iter_48_0 = 1, var_48_3 do
		local var_48_5 = arg_48_0:getherolevelexskillCO(arg_48_1, iter_48_0)

		if not string.nilorempty(var_48_5.skillGroup1) then
			var_48_1[1] = string.splitToNumber(var_48_5.skillGroup1, "|")
		end

		if not string.nilorempty(var_48_5.skillGroup2) then
			var_48_1[2] = string.splitToNumber(var_48_5.skillGroup2, "|")
		end

		if var_48_5.skillEx ~= 0 then
			var_48_1[3] = {
				var_48_5.skillEx
			}
		end
	end

	return (arg_48_0:_checkReplaceSkill(var_48_1, arg_48_3))
end

function var_0_0.getRankLevelByLevel(arg_49_0, arg_49_1, arg_49_2)
	local var_49_0 = arg_49_0.rankConfig.configDict[arg_49_1]

	if not var_49_0 then
		return 0
	end

	local var_49_1 = {}

	for iter_49_0, iter_49_1 in pairs(var_49_0) do
		table.insert(var_49_1, iter_49_1)
	end

	table.sort(var_49_1, function(arg_50_0, arg_50_1)
		return arg_50_0.rank < arg_50_1.rank
	end)

	local var_49_2 = 1

	for iter_49_2, iter_49_3 in ipairs(var_49_1) do
		local var_49_3 = 0

		for iter_49_4, iter_49_5 in pairs(GameUtil.splitString2(iter_49_3.effect, true, "|", "#")) do
			if iter_49_5[1] == 1 then
				var_49_3 = iter_49_5[2]

				break
			end
		end

		if arg_49_2 <= var_49_3 then
			return iter_49_3.rank
		end
	end

	return var_49_2
end

function var_0_0.getConstNum(arg_51_0, arg_51_1)
	local var_51_0 = arg_51_0:getConstStr(arg_51_1)

	if string.nilorempty(var_51_0) then
		return 0
	else
		return tonumber(var_51_0)
	end
end

function var_0_0.getConstStr(arg_52_0, arg_52_1)
	local var_52_0 = lua_fight_const.configDict[arg_52_1]

	if not var_52_0 then
		printError("fight const not exist: ", arg_52_1)

		return nil
	end

	local var_52_1 = var_52_0.value

	if not string.nilorempty(var_52_1) then
		return var_52_1
	end

	return var_52_0.value2
end

function var_0_0.getHeroUpgradeSkill(arg_53_0, arg_53_1)
	if not arg_53_1 then
		return false, {}
	end

	local var_53_0 = {}

	for iter_53_0, iter_53_1 in ipairs(arg_53_1) do
		local var_53_1 = arg_53_0.heroUpgradeBreakLevelConfig.configDict[iter_53_1]

		if var_53_1 then
			var_53_0[#var_53_0 + 1] = var_53_1.upgradeSkillId
		end
	end

	return #var_53_0 > 0, var_53_0
end

function var_0_0.getFightCardChoice(arg_54_0, arg_54_1)
	if not arg_54_1 then
		return
	end

	local var_54_0 = {}

	for iter_54_0, iter_54_1 in ipairs(arg_54_1) do
		local var_54_1 = lua_fight_card_choice.configDict[iter_54_1]

		if not var_54_1 then
			return
		end

		local var_54_2 = string.splitToNumber(var_54_1.choiceSkIlls, "#")

		for iter_54_2, iter_54_3 in ipairs(var_54_2) do
			if not var_54_0[iter_54_2] then
				var_54_0[iter_54_2] = {}
			end

			table.insert(var_54_0[iter_54_2], iter_54_3)
		end
	end

	return var_54_0
end

function var_0_0.getFightCardChoiceSkillIdByIndex(arg_55_0, arg_55_1, arg_55_2)
	local var_55_0 = lua_fight_card_choice.configDict[arg_55_1]

	if var_55_0 then
		return string.splitToNumber(var_55_0.choiceSkIlls, "#")[arg_55_2]
	end
end

function var_0_0.getFightCardFootnoteConfig(arg_56_0, arg_56_1)
	return arg_56_0.fightCardFootnoteConfig.configDict[arg_56_1]
end

var_0_0.instance = var_0_0.New()

return var_0_0
