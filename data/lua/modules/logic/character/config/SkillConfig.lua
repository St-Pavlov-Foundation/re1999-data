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
		"hero_upgrade_breaklevel"
	}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "character_talent" then
		arg_3_0.talentConfig = arg_3_2
	elseif arg_3_1 == "skill_ex_level" then
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
	end
end

function var_0_0.getGrowCo(arg_4_0)
	return arg_4_0.growConfig.configDict
end

function var_0_0.getGrowCO(arg_5_0, arg_5_1)
	return arg_5_0.growConfig.configDict[arg_5_1]
end

function var_0_0.gettalentCO(arg_6_0, arg_6_1, arg_6_2)
	return arg_6_0.talentConfig.configDict[arg_6_1][arg_6_2]
end

function var_0_0.getherotalentsCo(arg_7_0, arg_7_1)
	return arg_7_0.talentConfig.configDict[arg_7_1]
end

function var_0_0.getpassiveskillCO(arg_8_0, arg_8_1, arg_8_2)
	return arg_8_0.passiveskillConfig.configDict[arg_8_1][arg_8_2]
end

function var_0_0.getpassiveskillsCO(arg_9_0, arg_9_1)
	return arg_9_0.passiveskillConfig.configDict[arg_9_1]
end

function var_0_0.getHeroExSkillLevelByLevel(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = 0
	local var_10_1 = 1
	local var_10_2 = arg_10_0:getheroranksCO(arg_10_1)

	for iter_10_0 = 1, #var_10_2 do
		local var_10_3 = GameUtil.splitString2(var_10_2[iter_10_0].effect, true)
		local var_10_4 = false

		for iter_10_1, iter_10_2 in pairs(var_10_3) do
			if iter_10_2[1] == 1 and arg_10_2 <= iter_10_2[2] then
				var_10_1 = iter_10_0
				var_10_4 = true

				break
			end
		end

		if var_10_4 then
			for iter_10_3, iter_10_4 in pairs(var_10_3) do
				if iter_10_4[1] == 2 then
					var_10_0 = iter_10_4[2]

					break
				end
			end
		end

		if var_10_4 then
			break
		end
	end

	return var_10_0, var_10_1
end

function var_0_0.getPassiveSKillsCoByExSkillLevel(arg_11_0, arg_11_1, arg_11_2)
	arg_11_2 = arg_11_2 or 1

	local var_11_0 = arg_11_0:getpassiveskillsCO(arg_11_1)
	local var_11_1 = tabletool.copy(var_11_0)
	local var_11_2

	for iter_11_0 = arg_11_2, 1, -1 do
		local var_11_3 = arg_11_0:getherolevelexskillCO(arg_11_1, iter_11_0)

		if not string.nilorempty(var_11_3.passiveSkill) then
			arg_11_0:_handleReplacePassiveSkill(var_11_3.passiveSkill, var_11_1)
		end
	end

	return var_11_1
end

function var_0_0._handleReplacePassiveSkill(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = string.split(arg_12_1, "|")
	local var_12_1
	local var_12_2
	local var_12_3

	for iter_12_0, iter_12_1 in ipairs(var_12_0) do
		local var_12_4 = string.splitToNumber(iter_12_1, "#")
		local var_12_5 = var_12_4[1]
		local var_12_6 = var_12_4[2]

		for iter_12_2, iter_12_3 in pairs(arg_12_2) do
			if iter_12_3.skillPassive == var_12_5 then
				arg_12_2[iter_12_2] = {
					skillPassive = var_12_6
				}

				break
			end
		end
	end
end

function var_0_0.getherolevelexskillCO(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_0.exskillConfig.configDict[arg_13_1]

	if not var_13_0 then
		logError(string.format("ex skill not found heroid : %s `s config ", arg_13_1))

		return nil
	end

	if var_13_0[arg_13_2] == nil then
		logError(string.format("ex skill config gei nil, heroid : %s, skillLevel : %s", arg_13_1, arg_13_2))
	end

	return var_13_0[arg_13_2]
end

function var_0_0.getheroexskillco(arg_14_0, arg_14_1)
	return arg_14_0.exskillConfig.configDict[arg_14_1]
end

function var_0_0.getExSkillLevel(arg_15_0, arg_15_1)
	if not arg_15_0._exSkillLevel then
		arg_15_0._exSkillLevel = {}

		for iter_15_0, iter_15_1 in ipairs(arg_15_0.exskillConfig.configList) do
			arg_15_0._exSkillLevel[iter_15_1.skillEx] = iter_15_1.skillLevel
		end
	end

	return arg_15_0._exSkillLevel[arg_15_1]
end

function var_0_0.getherolevelCO(arg_16_0, arg_16_1, arg_16_2)
	return arg_16_0.levelConfig.configDict[arg_16_1][arg_16_2]
end

function var_0_0.getherolevelsCO(arg_17_0, arg_17_1)
	return arg_17_0.levelConfig.configDict[arg_17_1]
end

function var_0_0.getherorankCO(arg_18_0, arg_18_1, arg_18_2)
	return arg_18_0.rankConfig.configDict[arg_18_1][arg_18_2]
end

function var_0_0.getheroranksCO(arg_19_0, arg_19_1)
	return arg_19_0.rankConfig.configDict[arg_19_1]
end

function var_0_0.getHeroRankAttribute(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = {}

	var_20_0.hp = 0
	var_20_0.atk = 0
	var_20_0.def = 0
	var_20_0.mdef = 0
	var_20_0.technic = 0

	local var_20_1 = arg_20_0:getheroranksCO(arg_20_1)

	for iter_20_0, iter_20_1 in pairs(var_20_1) do
		if arg_20_2 >= iter_20_1.rank then
			local var_20_2 = arg_20_0:getHeroAttributeByRankConfig(iter_20_1)

			var_20_0.hp = var_20_0.hp + var_20_2.hp
			var_20_0.atk = var_20_0.atk + var_20_2.atk
			var_20_0.def = var_20_0.def + var_20_2.def
			var_20_0.mdef = var_20_0.mdef + var_20_2.mdef
			var_20_0.technic = var_20_0.technic + var_20_2.technic
		end
	end

	return var_20_0
end

function var_0_0.getHeroAttributeByRankConfig(arg_21_0, arg_21_1)
	local var_21_0 = {}

	var_21_0.hp = 0
	var_21_0.atk = 0
	var_21_0.def = 0
	var_21_0.mdef = 0
	var_21_0.technic = 0

	local var_21_1 = arg_21_1.effect

	if string.nilorempty(var_21_1) then
		return var_21_0
	end

	local var_21_2 = string.split(var_21_1, "|")

	for iter_21_0, iter_21_1 in ipairs(var_21_2) do
		local var_21_3 = string.split(iter_21_1, "#")

		if tonumber(var_21_3[1]) == 4 then
			local var_21_4 = tonumber(var_21_3[2]) / 1000
			local var_21_5 = arg_21_0:getherolevelCO(arg_21_1.heroId, 1)

			var_21_0.hp = var_21_0.hp + math.floor(var_21_5.hp * var_21_4)
			var_21_0.atk = var_21_0.atk + math.floor(var_21_5.atk * var_21_4)
			var_21_0.def = var_21_0.def + math.floor(var_21_5.def * var_21_4)
			var_21_0.mdef = var_21_0.mdef + math.floor(var_21_5.mdef * var_21_4)
			var_21_0.technic = var_21_0.technic + math.floor(var_21_5.technic * var_21_4)
		end
	end

	return var_21_0
end

function var_0_0.getcosumeCO(arg_22_0, arg_22_1, arg_22_2)
	return arg_22_0.cosumeConfig.configDict[arg_22_1][arg_22_2]
end

function var_0_0.getSkillEffectDescsCo(arg_23_0)
	return arg_23_0.skillEffectDescConfig.configDict
end

function var_0_0.getSkillEffectDescCo(arg_24_0, arg_24_1)
	return arg_24_0.skillEffectDescConfig.configDict[arg_24_1]
end

function var_0_0.getSkillEffectDescCoByName(arg_25_0, arg_25_1)
	if not arg_25_0.skillBuffDescConfigByName then
		arg_25_0.skillBuffDescConfigByName = {}

		for iter_25_0, iter_25_1 in ipairs(arg_25_0.skillEffectDescConfig.configList) do
			arg_25_0.skillBuffDescConfigByName[iter_25_1.name] = iter_25_1
		end
	end

	local var_25_0 = arg_25_0.skillBuffDescConfigByName[arg_25_1]

	if not var_25_0 then
		logError(string.format("技能概要 '%s' 不存在!!!", tostring(arg_25_1)))
	end

	return var_25_0
end

function var_0_0.processSkillDesKeyWords(arg_26_0, arg_26_1)
	return string.gsub(arg_26_1, "<id:(.-)>", "")
end

function var_0_0.getSkillBuffDescsCo(arg_27_0)
	return arg_27_0.skillBuffDescConfig.configDict
end

function var_0_0.getSkillBuffDescCo(arg_28_0, arg_28_1)
	return arg_28_0.skillBuffDescConfig.configDict[arg_28_1]
end

function var_0_0.isGetNewSkin(arg_29_0, arg_29_1, arg_29_2)
	local var_29_0 = arg_29_0:getherorankCO(arg_29_1, arg_29_2)

	if not var_29_0 then
		logError("获取角色升级信息失败， heroId : " .. tostring(arg_29_1) .. ", rank : " .. tostring(arg_29_2))

		return false
	end

	local var_29_1 = string.split(var_29_0.effect, "|")

	for iter_29_0 = 1, #var_29_1 do
		if string.splitToNumber(var_29_1[iter_29_0], "#")[1] == 3 then
			return true
		end
	end

	return false
end

function var_0_0.getBaseAttr(arg_30_0, arg_30_1, arg_30_2)
	local var_30_0 = {}
	local var_30_1 = arg_30_0:getherolevelCO(arg_30_1, arg_30_2)

	if not var_30_1 then
		local var_30_2 = arg_30_0:getherolevelsCO(arg_30_1)
		local var_30_3
		local var_30_4
		local var_30_5 = {}

		for iter_30_0, iter_30_1 in pairs(var_30_2) do
			table.insert(var_30_5, iter_30_1)
		end

		table.sort(var_30_5, function(arg_31_0, arg_31_1)
			return arg_31_0.level < arg_31_1.level
		end)

		for iter_30_2, iter_30_3 in ipairs(var_30_5) do
			if arg_30_2 > iter_30_3.level then
				var_30_3 = iter_30_3.level
				var_30_4 = var_30_5[iter_30_2 + 1].level
			end
		end

		local var_30_6 = arg_30_0:getherolevelCO(arg_30_1, var_30_3)
		local var_30_7 = arg_30_0:getherolevelCO(arg_30_1, var_30_4)

		var_30_0.hp = arg_30_0:_lerpAttr(var_30_6.hp, var_30_7.hp, var_30_3, var_30_4, arg_30_2)
		var_30_0.atk = arg_30_0:_lerpAttr(var_30_6.atk, var_30_7.atk, var_30_3, var_30_4, arg_30_2)
		var_30_0.def = arg_30_0:_lerpAttr(var_30_6.def, var_30_7.def, var_30_3, var_30_4, arg_30_2)
		var_30_0.mdef = arg_30_0:_lerpAttr(var_30_6.mdef, var_30_7.mdef, var_30_3, var_30_4, arg_30_2)
		var_30_0.technic = arg_30_0:_lerpAttr(var_30_6.technic, var_30_7.technic, var_30_3, var_30_4, arg_30_2)
		var_30_0.cri = arg_30_0:_lerpAttr(var_30_6.cri, var_30_7.cri, var_30_3, var_30_4, arg_30_2)
		var_30_0.recri = arg_30_0:_lerpAttr(var_30_6.recri, var_30_7.recri, var_30_3, var_30_4, arg_30_2)
		var_30_0.cri_dmg = arg_30_0:_lerpAttr(var_30_6.cri_dmg, var_30_7.cri_dmg, var_30_3, var_30_4, arg_30_2)
		var_30_0.cri_def = arg_30_0:_lerpAttr(var_30_6.cri_def, var_30_7.cri_def, var_30_3, var_30_4, arg_30_2)
		var_30_0.add_dmg = arg_30_0:_lerpAttr(var_30_6.add_dmg, var_30_7.add_dmg, var_30_3, var_30_4, arg_30_2)
		var_30_0.drop_dmg = arg_30_0:_lerpAttr(var_30_6.drop_dmg, var_30_7.drop_dmg, var_30_3, var_30_4, arg_30_2)
	else
		var_30_0.hp = var_30_1.hp
		var_30_0.atk = var_30_1.atk
		var_30_0.def = var_30_1.def
		var_30_0.mdef = var_30_1.mdef
		var_30_0.technic = var_30_1.technic
		var_30_0.cri = var_30_1.cri
		var_30_0.recri = var_30_1.recri
		var_30_0.cri_dmg = var_30_1.cri_dmg
		var_30_0.cri_def = var_30_1.cri_def
		var_30_0.add_dmg = var_30_1.add_dmg
		var_30_0.drop_dmg = var_30_1.drop_dmg
	end

	return var_30_0
end

function var_0_0._lerpAttr(arg_32_0, arg_32_1, arg_32_2, arg_32_3, arg_32_4, arg_32_5)
	return math.floor((arg_32_2 - arg_32_1) * (arg_32_5 - arg_32_3) / (arg_32_4 - arg_32_3)) + arg_32_1
end

function var_0_0.getTalentDamping(arg_33_0)
	if arg_33_0.talent_damping then
		return arg_33_0.talent_damping
	end

	arg_33_0.talent_damping = {}

	local var_33_0 = string.split(lua_fight_const.configDict[10][2], "|")

	for iter_33_0, iter_33_1 in ipairs(var_33_0) do
		local var_33_1 = string.splitToNumber(iter_33_1, "#")

		table.insert(arg_33_0.talent_damping, var_33_1)
	end

	return arg_33_0.talent_damping
end

function var_0_0.getExSkillDesc(arg_34_0, arg_34_1, arg_34_2)
	if arg_34_1 == nil then
		return ""
	end

	local var_34_0 = arg_34_1.desc

	arg_34_2 = arg_34_2 or arg_34_1.heroId

	local var_34_1, var_34_2, var_34_3 = string.find(var_34_0, "▩(%d)%%s")

	if not var_34_3 then
		logError("not fount skillIndex in desc : " .. var_34_0)

		return var_34_0
	end

	local var_34_4 = tonumber(var_34_3)
	local var_34_5

	if var_34_4 == 0 then
		var_34_5 = var_0_0.instance:getpassiveskillsCO(arg_34_2)[1].skillPassive
	else
		var_34_5 = var_0_0.instance:getHeroBaseSkillIdDict(arg_34_2)[var_34_4]
	end

	if not var_34_5 then
		logError("not fount skillId, skillIndex : " .. var_34_4)

		return var_34_0
	end

	return var_34_0, lua_skill.configDict[var_34_5].name, var_34_4
end

function var_0_0.getHeroBaseSkillIdDict(arg_35_0, arg_35_1)
	local var_35_0 = HeroConfig.instance:getHeroCO(arg_35_1)

	return arg_35_0:getHeroBaseSkillIdDictByStr(var_35_0.skill, var_35_0.exSkill)
end

function var_0_0.getHeroBaseSkillIdDictByStr(arg_36_0, arg_36_1, arg_36_2)
	local var_36_0 = {}
	local var_36_1 = string.split(arg_36_1, "|")
	local var_36_2
	local var_36_3
	local var_36_4

	for iter_36_0 = 1, #var_36_1 do
		local var_36_5 = string.splitToNumber(var_36_1[iter_36_0], "#")

		var_36_0[var_36_5[1]] = var_36_5[2]
	end

	var_36_0[3] = arg_36_2

	return var_36_0
end

function var_0_0.getHeroAllSkillIdDict(arg_37_0, arg_37_1)
	local var_37_0 = HeroConfig.instance:getHeroCO(arg_37_1)

	return arg_37_0:getHeroAllSkillIdDictByStr(var_37_0.skill, var_37_0.exSkill)
end

function var_0_0.getHeroAllSkillIdDictByStr(arg_38_0, arg_38_1, arg_38_2)
	local var_38_0 = {}
	local var_38_1 = string.split(arg_38_1, "|")
	local var_38_2
	local var_38_3

	for iter_38_0 = 1, #var_38_1 do
		local var_38_4 = string.splitToNumber(var_38_1[iter_38_0], "#")

		var_38_0[table.remove(var_38_4, 1)] = var_38_4
	end

	var_38_0[3] = {
		arg_38_2
	}

	return var_38_0
end

function var_0_0.getHeroBaseSkillIdDictByExSkillLevel(arg_39_0, arg_39_1, arg_39_2, arg_39_3)
	if arg_39_3 and arg_39_3.trialAttrCo then
		local var_39_0 = arg_39_0:getHeroBaseSkillIdDictByStr(arg_39_3.trialAttrCo.activeSkill, arg_39_3.trialAttrCo.uniqueSkill)

		return (arg_39_0:_checkDestinyEffect(var_39_0, arg_39_3))
	end

	local var_39_1 = arg_39_0:getHeroBaseSkillIdDict(arg_39_1)

	arg_39_3 = arg_39_3 or HeroModel.instance:getByHeroId(arg_39_1)
	arg_39_2 = arg_39_2 or CharacterEnum.showAttributeOption.ShowCurrent

	local var_39_2 = 0

	if arg_39_2 == CharacterEnum.showAttributeOption.ShowMax then
		var_39_2 = CharacterModel.instance:getMaxexskill(arg_39_1)
	else
		var_39_2 = arg_39_2 == CharacterEnum.showAttributeOption.ShowMin and 0 or arg_39_3.exSkillLevel
	end

	if var_39_2 < 1 then
		var_39_1 = arg_39_0:_checkDestinyEffect(var_39_1, arg_39_3)

		return var_39_1
	end

	local var_39_3 = math.min(var_39_2, CharacterEnum.MaxSkillExLevel)
	local var_39_4

	for iter_39_0 = 1, var_39_3 do
		local var_39_5 = arg_39_0:getherolevelexskillCO(arg_39_1, iter_39_0)

		if not string.nilorempty(var_39_5.skillGroup1) then
			var_39_1[1] = string.splitToNumber(var_39_5.skillGroup1, "|")[1]
		end

		if not string.nilorempty(var_39_5.skillGroup2) then
			var_39_1[2] = string.splitToNumber(var_39_5.skillGroup2, "|")[1]
		end

		if var_39_5.skillEx ~= 0 then
			var_39_1[3] = var_39_5.skillEx
		end
	end

	return (arg_39_0:_checkDestinyEffect(var_39_1, arg_39_3))
end

function var_0_0._checkDestinyEffect(arg_40_0, arg_40_1, arg_40_2)
	if arg_40_1 and arg_40_2 and arg_40_2.destinyStoneMo then
		arg_40_1 = arg_40_2.destinyStoneMo:_replaceSkill(arg_40_1)
	end

	return arg_40_1
end

function var_0_0.getHeroAllSkillIdDictByExSkillLevel(arg_41_0, arg_41_1, arg_41_2, arg_41_3, arg_41_4)
	if arg_41_3 and arg_41_3.trialAttrCo then
		return arg_41_0:getHeroAllSkillIdDictByStr(arg_41_3.trialAttrCo.activeSkill, arg_41_3.trialAttrCo.uniqueSkill)
	end

	local var_41_0 = arg_41_0:getHeroAllSkillIdDict(arg_41_1)

	arg_41_3 = arg_41_3 or HeroModel.instance:getByHeroId(arg_41_1)
	arg_41_2 = arg_41_2 or CharacterEnum.showAttributeOption.ShowCurrent

	local var_41_1 = 0

	if arg_41_2 == CharacterEnum.showAttributeOption.ShowMax then
		var_41_1 = CharacterModel.instance:getMaxexskill(arg_41_1)
	elseif arg_41_2 == CharacterEnum.showAttributeOption.ShowMin then
		var_41_1 = 0
	elseif arg_41_4 then
		var_41_1 = arg_41_4
	elseif arg_41_3 then
		var_41_1 = arg_41_3.exSkillLevel
	end

	if var_41_1 < 1 then
		return var_41_0
	end

	local var_41_2

	for iter_41_0 = 1, var_41_1 do
		local var_41_3 = arg_41_0:getherolevelexskillCO(arg_41_1, iter_41_0)

		if not string.nilorempty(var_41_3.skillGroup1) then
			var_41_0[1] = string.splitToNumber(var_41_3.skillGroup1, "|")
		end

		if not string.nilorempty(var_41_3.skillGroup2) then
			var_41_0[2] = string.splitToNumber(var_41_3.skillGroup2, "|")
		end

		if var_41_3.skillEx ~= 0 then
			var_41_0[3] = {
				var_41_3.skillEx
			}
		end
	end

	return (arg_41_0:_checkDestinyEffect(var_41_0, arg_41_3))
end

function var_0_0.getRankLevelByLevel(arg_42_0, arg_42_1, arg_42_2)
	local var_42_0 = arg_42_0.rankConfig.configDict[arg_42_1]

	if not var_42_0 then
		return 0
	end

	local var_42_1 = {}

	for iter_42_0, iter_42_1 in pairs(var_42_0) do
		table.insert(var_42_1, iter_42_1)
	end

	table.sort(var_42_1, function(arg_43_0, arg_43_1)
		return arg_43_0.rank < arg_43_1.rank
	end)

	local var_42_2 = 1

	for iter_42_2, iter_42_3 in ipairs(var_42_1) do
		local var_42_3 = 0

		for iter_42_4, iter_42_5 in pairs(GameUtil.splitString2(iter_42_3.effect, true, "|", "#")) do
			if iter_42_5[1] == 1 then
				var_42_3 = iter_42_5[2]

				break
			end
		end

		if arg_42_2 <= var_42_3 then
			return iter_42_3.rank
		end
	end

	return var_42_2
end

function var_0_0.getConstNum(arg_44_0, arg_44_1)
	local var_44_0 = arg_44_0:getConstStr(arg_44_1)

	if string.nilorempty(var_44_0) then
		return 0
	else
		return tonumber(var_44_0)
	end
end

function var_0_0.getConstStr(arg_45_0, arg_45_1)
	local var_45_0 = lua_fight_const.configDict[arg_45_1]

	if not var_45_0 then
		printError("fight const not exist: ", arg_45_1)

		return nil
	end

	local var_45_1 = var_45_0.value

	if not string.nilorempty(var_45_1) then
		return var_45_1
	end

	return var_45_0.value2
end

function var_0_0.getHeroUpgradeSkill(arg_46_0, arg_46_1, arg_46_2, arg_46_3)
	local var_46_0 = arg_46_0.heroUpgradeBreakLevelConfig.configDict[arg_46_1]

	if not var_46_0 then
		return false, nil
	end

	local var_46_1 = var_46_0[arg_46_2]
	local var_46_2

	if arg_46_3 == CharacterEnum.skillIndex.Skill1 and not string.nilorempty(var_46_1.skillGroup1) then
		var_46_2 = string.splitToNumber(var_46_1.skillGroup1, "|")
	end

	if arg_46_3 == CharacterEnum.skillIndex.Skill2 and not string.nilorempty(var_46_1.skillGroup2) then
		var_46_2 = string.splitToNumber(var_46_1.skillGroup2, "|")
	end

	if arg_46_3 == CharacterEnum.skillIndex.SkillEx and var_46_1.skillEx ~= 0 then
		var_46_2 = {
			var_46_1.skillEx
		}
	end

	return var_46_2 ~= nil, var_46_2
end

var_0_0.instance = var_0_0.New()

return var_0_0
