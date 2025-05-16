module("modules.logic.character.model.HeroDestinyStoneMO", package.seeall)

local var_0_0 = class("HeroDestinyStoneMO")

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.rank = 0
	arg_1_0.level = 0
	arg_1_0.curUseStoneId = 0
	arg_1_0.unlockStoneIds = nil
	arg_1_0.stoneMoList = nil
	arg_1_0.upStoneId = nil
	arg_1_0.heroId = arg_1_1
	arg_1_0.maxRank = 0
	arg_1_0.maxLevel = {}

	local var_1_0 = CharacterDestinyConfig.instance:getDestinySlotCosByHeroId(arg_1_1)

	if var_1_0 then
		for iter_1_0, iter_1_1 in ipairs(var_1_0) do
			arg_1_0.maxRank = math.max(iter_1_0, arg_1_0.maxRank)
			arg_1_0.maxLevel[iter_1_0] = tabletool.len(iter_1_1)
		end
	end
end

function var_0_0.refreshMo(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	arg_2_0.rank = arg_2_1
	arg_2_0.level = arg_2_2
	arg_2_0.curUseStoneId = arg_2_3
	arg_2_0.unlockStoneIds = arg_2_4 or {}

	arg_2_0:setStoneMo()
end

function var_0_0.isUnlockSlot(arg_3_0)
	return arg_3_0.rank > 0
end

function var_0_0.isCanUpSlotRank(arg_4_0)
	local var_4_0 = arg_4_0:getNextDestinySlotCo()

	return var_4_0 and var_4_0.node == 1
end

function var_0_0.isSlotMaxLevel(arg_5_0)
	return not arg_5_0:getNextDestinySlotCo()
end

function var_0_0.isAllFacetUnlock(arg_6_0)
	if not arg_6_0.stoneMoList then
		return false
	end

	for iter_6_0, iter_6_1 in pairs(arg_6_0.stoneMoList) do
		if not arg_6_0:isUnlockStone(iter_6_1) then
			return false
		end
	end

	return true
end

function var_0_0.setUpStoneId(arg_7_0, arg_7_1)
	arg_7_0.upStoneId = arg_7_1
end

function var_0_0.getUpStoneId(arg_8_0)
	return arg_8_0.upStoneId
end

function var_0_0.clearUpStoneId(arg_9_0)
	arg_9_0.upStoneId = nil
end

function var_0_0.checkAllUnlock(arg_10_0)
	return arg_10_0:isSlotMaxLevel() and arg_10_0:isAllFacetUnlock()
end

function var_0_0.setStoneMo(arg_11_0)
	local var_11_0 = CharacterDestinyConfig.instance:getFacetIdsByHeroId(arg_11_0.heroId)

	if not arg_11_0.stoneMoList then
		arg_11_0.stoneMoList = {}
	end

	if var_11_0 then
		for iter_11_0, iter_11_1 in ipairs(var_11_0) do
			if not arg_11_0.stoneMoList[iter_11_1] then
				local var_11_1 = DestinyStoneMO.New()

				var_11_1:initMo(iter_11_1)

				arg_11_0.stoneMoList[iter_11_1] = var_11_1

				var_11_1:refresUnlock(arg_11_0:isUnlockStone(var_11_1))
				var_11_1:refreshUse(arg_11_0:isUseStone(var_11_1))
			end
		end
	end
end

function var_0_0.isUnlockStone(arg_12_0, arg_12_1)
	if not arg_12_1 then
		return
	end

	return LuaUtil.tableContains(arg_12_0.unlockStoneIds, arg_12_1.stoneId)
end

function var_0_0.isUseStone(arg_13_0, arg_13_1)
	if not arg_13_1 then
		return
	end

	return arg_13_1.stoneId == arg_13_0.curUseStoneId
end

function var_0_0.getStoneMoList(arg_14_0)
	return arg_14_0.stoneMoList and arg_14_0.stoneMoList
end

function var_0_0.getStoneMo(arg_15_0, arg_15_1)
	return arg_15_0.stoneMoList and arg_15_0.stoneMoList[arg_15_1]
end

function var_0_0.getCurUseStoneCo(arg_16_0)
	if arg_16_0.curUseStoneId ~= 0 then
		return CharacterDestinyConfig.instance:getDestinyFacets(arg_16_0.curUseStoneId, arg_16_0.rank)
	end
end

function var_0_0.getAddAttrValues(arg_17_0)
	return (arg_17_0:getAddAttrValueByLevel(arg_17_0.rank, arg_17_0.level))
end

function var_0_0.getAddAttrValueByLevel(arg_18_0, arg_18_1, arg_18_2)
	return (CharacterDestinyConfig.instance:getCurDestinySlotAddAttr(arg_18_0.heroId, arg_18_1, arg_18_2))
end

function var_0_0.getAddValueByAttrId(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	arg_19_1 = arg_19_1 or arg_19_0:getAddAttrValues()

	local var_19_0 = arg_19_1[arg_19_2]

	if not var_19_0 then
		local var_19_1 = CharacterDestinyEnum.DestinyUpBaseParseAttr[arg_19_2]

		if var_19_1 then
			local var_19_2 = var_19_1[1]

			if var_19_2 then
				var_19_0 = arg_19_1[var_19_2] or 0
				var_19_0 = var_19_0 + (arg_19_0:getPercentAddValueByAttrId(arg_19_1, arg_19_2, arg_19_3) or 0)

				return var_19_0
			end
		end
	else
		return var_19_0
	end

	return 0
end

function var_0_0.getPercentAddValueByAttrId(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	arg_20_1 = arg_20_1 or arg_20_0:getAddAttrValues()

	if not arg_20_3 then
		arg_20_3 = HeroModel.instance:getById(arg_20_0.heroId)

		if not arg_20_3 then
			return 0
		end
	end

	local var_20_0 = arg_20_3:getHeroBaseAttrDict()[arg_20_2] or 0
	local var_20_1 = CharacterDestinyEnum.DestinyUpBaseParseAttr[arg_20_2]
	local var_20_2 = var_20_0 * (arg_20_1[var_20_1 and var_20_1[2]] or 0) * 0.01

	return math.floor(var_20_2)
end

function var_0_0.getRankLevelCount(arg_21_0)
	return arg_21_0.maxLevel[arg_21_0.rank] or 0
end

function var_0_0.getNextDestinySlotCo(arg_22_0)
	return (CharacterDestinyConfig.instance:getNextDestinySlotCo(arg_22_0.heroId, arg_22_0.rank, arg_22_0.level))
end

function var_0_0.getCurStoneNameAndIcon(arg_23_0)
	if arg_23_0.curUseStoneId == 0 then
		return
	end

	return arg_23_0:getStoneMo(arg_23_0.curUseStoneId):getNameAndIcon()
end

function var_0_0.isCanPlayAttrUnlockAnim(arg_24_0, arg_24_1, arg_24_2)
	if not arg_24_0:isUnlockSlot() then
		return
	end

	if arg_24_2 > arg_24_0.rank then
		return
	end

	local var_24_0 = arg_24_0:getStoneMo(arg_24_1)

	if not var_24_0 then
		return
	end

	if not arg_24_0:isUnlockStone(var_24_0) then
		return
	end

	local var_24_1 = "HeroDestinyStoneMO_isCanPlayAttrUnlockAnim_" .. arg_24_0.heroId .. "_" .. arg_24_2 .. "_" .. arg_24_1

	if GameUtil.playerPrefsGetNumberByUserId(var_24_1, 0) == 0 then
		GameUtil.playerPrefsSetNumberByUserId(var_24_1, 1)

		return true
	end
end

function var_0_0._replaceSkill(arg_25_0, arg_25_1)
	if arg_25_1 then
		var_0_0.replaceSkillList(arg_25_1, arg_25_0.curUseStoneId, arg_25_0.rank)
	end

	return arg_25_1
end

function var_0_0.replaceSkillList(arg_26_0, arg_26_1, arg_26_2)
	if arg_26_1 and arg_26_1 ~= 0 then
		local var_26_0 = CharacterDestinyConfig.instance:getDestinyFacets(arg_26_1, arg_26_2)

		if var_26_0 then
			local var_26_1 = var_26_0.exchangeSkills

			if not string.nilorempty(var_26_1) then
				local var_26_2 = GameUtil.splitString2(var_26_1, true)

				for iter_26_0 = 1, #arg_26_0 do
					for iter_26_1, iter_26_2 in ipairs(var_26_2) do
						local var_26_3 = iter_26_2[1]
						local var_26_4 = iter_26_2[2]

						if arg_26_0[iter_26_0] == var_26_3 then
							arg_26_0[iter_26_0] = var_26_4
						end
					end
				end
			end
		end
	end

	return arg_26_0
end

function var_0_0.setRedDot(arg_27_0, arg_27_1)
	arg_27_0.reddot = arg_27_1
end

function var_0_0.getRedDot(arg_28_0)
	return arg_28_0.reddot or 0
end

function var_0_0.setTrial(arg_29_0)
	if arg_29_0.maxLevel and arg_29_0.maxRank then
		arg_29_0.level = arg_29_0.maxLevel[arg_29_0.maxRank] or 1
	end
end

return var_0_0
