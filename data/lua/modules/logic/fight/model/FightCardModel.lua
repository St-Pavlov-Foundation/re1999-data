module("modules.logic.fight.model.FightCardModel", package.seeall)

local var_0_0 = class("FightCardModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0._cardMO = FightCardMO.New()
	arg_1_0._distributeQueue = {}
	arg_1_0._cardOps = {}
	arg_1_0.curSelectEntityId = 0
	arg_1_0.nextRoundActPoint = nil
	arg_1_0.nextRoundMoveNum = nil
	arg_1_0._universalCardMO = nil
	arg_1_0._beCombineCardMO = nil
	arg_1_0.redealCardInfoList = nil
	arg_1_0._dissolvingCard = nil
	arg_1_0._changingCard = nil
	arg_1_0.areaSize = 0
end

function var_0_0.clear(arg_2_0)
	arg_2_0.redealCardInfoList = nil
	arg_2_0._dissolvingCard = nil
	arg_2_0._changingCard = nil
	arg_2_0.areaSize = 0

	arg_2_0:clearCardOps()

	if arg_2_0._cardMO then
		arg_2_0._cardMO:reset()
	end

	arg_2_0:clearDistributeQueue()
end

function var_0_0.setDissolving(arg_3_0, arg_3_1)
	if FightModel.instance:getVersion() >= 1 then
		return
	end

	arg_3_0._dissolvingCard = arg_3_1
end

function var_0_0.setChanging(arg_4_0, arg_4_1)
	arg_4_0._changingCard = arg_4_1
end

function var_0_0.isDissolving(arg_5_0)
	return arg_5_0._dissolvingCard
end

function var_0_0.isChanging(arg_6_0)
	return arg_6_0._changingCard
end

function var_0_0.setUniversalCombine(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0._universalCardMO = arg_7_1
	arg_7_0._beCombineCardMO = arg_7_2
end

function var_0_0.getUniversalCardMO(arg_8_0)
	return arg_8_0._universalCardMO
end

function var_0_0.getBeCombineCardMO(arg_9_0)
	return arg_9_0._beCombineCardMO
end

function var_0_0.enqueueDistribute(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = tabletool.copy(arg_10_1)
	local var_10_1 = tabletool.copy(arg_10_2)

	if #var_10_1 > 0 then
		while #var_10_1 > 0 do
			local var_10_2 = #var_10_1
			local var_10_3 = 1
			local var_10_4 = tabletool.copy(var_10_0)

			while #var_10_1 > 0 do
				table.insert(var_10_4, table.remove(var_10_1, 1))

				if var_0_0.getCombineIndexOnce(var_10_4) then
					break
				end
			end

			local var_10_5 = {}

			for iter_10_0 = #var_10_0 + 1, #var_10_4 do
				table.insert(var_10_5, var_10_4[iter_10_0])
			end

			table.insert(arg_10_0._distributeQueue, {
				var_10_0,
				var_10_5
			})

			var_10_0 = var_0_0.calcCardsAfterCombine(var_10_4)
		end
	else
		table.insert(arg_10_0._distributeQueue, {
			var_10_0,
			var_10_1
		})
	end
end

function var_0_0.dequeueDistribute(arg_11_0)
	if #arg_11_0._distributeQueue > 0 then
		local var_11_0 = table.remove(arg_11_0._distributeQueue, 1)

		return var_11_0[1], var_11_0[2]
	end
end

function var_0_0.clearDistributeQueue(arg_12_0)
	arg_12_0._distributeQueue = {}
end

function var_0_0.getDistributeQueueLen(arg_13_0)
	return #arg_13_0._distributeQueue
end

function var_0_0.applyNextRoundActPoint(arg_14_0)
	if arg_14_0.nextRoundActPoint and arg_14_0.nextRoundActPoint > 0 then
		arg_14_0._cardMO.actPoint = arg_14_0.nextRoundActPoint
		arg_14_0._cardMO.moveNum = arg_14_0.nextRoundMoveNum
		arg_14_0.nextRoundActPoint = nil
		arg_14_0.nextRoundMoveNum = nil
	end
end

function var_0_0.getEntityOps(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = {}

	for iter_15_0, iter_15_1 in ipairs(arg_15_0._cardOps) do
		if iter_15_1.belongToEntityId == arg_15_1 and (not arg_15_2 or iter_15_1.operType == arg_15_2) then
			table.insert(var_15_0, iter_15_1)
		end
	end

	return var_15_0
end

function var_0_0.setCurSelectEntityId(arg_16_0, arg_16_1)
	arg_16_0.curSelectEntityId = arg_16_1
end

function var_0_0.resetCurSelectEntityIdDefault(arg_17_0)
	if FightDataHelper.stateMgr:getIsAuto() then
		if FightHelper.canSelectEnemyEntity(arg_17_0.curSelectEntityId) then
			arg_17_0:setCurSelectEntityId(arg_17_0.curSelectEntityId)
		else
			arg_17_0:setCurSelectEntityId(0)
		end
	else
		local var_17_0 = FightDataHelper.entityMgr:getById(arg_17_0.curSelectEntityId)

		if var_17_0 and var_17_0:isStatusDead() then
			var_17_0 = nil
		end

		if var_17_0 and var_17_0.side == FightEnum.EntitySide.MySide then
			arg_17_0.curSelectEntityId = 0
			var_17_0 = nil
		end

		local var_17_1 = var_17_0 ~= nil
		local var_17_2 = var_17_0 and var_17_0:hasBuffFeature(FightEnum.BuffType_CantSelect)
		local var_17_3 = var_17_0 and var_17_0:hasBuffFeature(FightEnum.BuffType_CantSelectEx)

		if arg_17_0.curSelectEntityId ~= 0 and var_17_1 and not var_17_2 and not var_17_3 then
			return
		end

		local var_17_4 = FightDataHelper.entityMgr:getEnemyNormalList()

		for iter_17_0 = #var_17_4, 1, -1 do
			local var_17_5 = var_17_4[iter_17_0]

			if var_17_5:hasBuffFeature(FightEnum.BuffType_CantSelect) or var_17_5:hasBuffFeature(FightEnum.BuffType_CantSelectEx) then
				table.remove(var_17_4, iter_17_0)
			end
		end

		if #var_17_4 > 0 then
			table.sort(var_17_4, function(arg_18_0, arg_18_1)
				return arg_18_0.position < arg_18_1.position
			end)
			arg_17_0:setCurSelectEntityId(var_17_4[1].id)
		end
	end
end

function var_0_0.getSelectEnemyPosLOrR(arg_19_0, arg_19_1)
	local var_19_0 = FightDataHelper.entityMgr:getEnemyNormalList()

	for iter_19_0 = #var_19_0, 1, -1 do
		local var_19_1 = var_19_0[iter_19_0]

		if var_19_1:hasBuffFeature(FightEnum.BuffType_CantSelect) or var_19_1:hasBuffFeature(FightEnum.BuffType_CantSelectEx) then
			table.remove(var_19_0, iter_19_0)
		end
	end

	if #var_19_0 > 0 then
		table.sort(var_19_0, function(arg_20_0, arg_20_1)
			return arg_20_0.position < arg_20_1.position
		end)

		for iter_19_1 = 1, #var_19_0 do
			if var_19_0[iter_19_1].id == arg_19_0.curSelectEntityId then
				if arg_19_1 == 1 and iter_19_1 < #var_19_0 then
					return var_19_0[iter_19_1 + 1].id
				elseif arg_19_1 == 2 and iter_19_1 > 1 then
					return var_19_0[iter_19_1 - 1].id
				end
			end
		end
	end
end

function var_0_0.onStartRound(arg_21_0)
	arg_21_0:getCardMO():setExtraMoveAct(0)
end

function var_0_0.onEndRound(arg_22_0)
	return
end

function var_0_0.getCardMO(arg_23_0)
	return arg_23_0._cardMO
end

function var_0_0.getCardOps(arg_24_0)
	return arg_24_0._cardOps
end

function var_0_0.resetCardOps(arg_25_0)
	arg_25_0._cardOps = {}

	local var_25_0 = FightDataHelper.entityMgr:getAllEntityData()

	for iter_25_0, iter_25_1 in pairs(var_25_0) do
		iter_25_1:resetSimulateExPoint()
	end
end

function var_0_0.clearCardOps(arg_26_0)
	arg_26_0._cardOps = {}
end

function var_0_0.getShowOpActList(arg_27_0)
	local var_27_0 = {}

	for iter_27_0, iter_27_1 in ipairs(arg_27_0._cardOps) do
		if var_0_0.instance:canShowOpAct(iter_27_1) then
			table.insert(var_27_0, iter_27_1)
		end
	end

	return var_27_0
end

function var_0_0.canShowOpAct(arg_28_0, arg_28_1)
	if not arg_28_1:isMoveUniversal() and (not (arg_28_1:isMoveCard() and arg_28_0._cardMO:isUnlimitMoveCard()) or arg_28_1:isPlayCard()) then
		return true
	end
end

function var_0_0.getPlayCardOpList(arg_29_0)
	local var_29_0 = {}

	for iter_29_0, iter_29_1 in ipairs(arg_29_0._cardOps) do
		if iter_29_1:isPlayCard() then
			table.insert(var_29_0, iter_29_1)
		end
	end

	return var_29_0
end

function var_0_0.getMoveCardOpList(arg_30_0)
	local var_30_0 = {}

	for iter_30_0, iter_30_1 in ipairs(arg_30_0._cardOps) do
		if iter_30_1:isMoveCard() then
			table.insert(var_30_0, iter_30_1)
		end
	end

	return var_30_0
end

function var_0_0.getMoveCardOpCostActList(arg_31_0)
	local var_31_0 = {}

	for iter_31_0, iter_31_1 in ipairs(arg_31_0._cardOps) do
		if iter_31_1:isMoveCard() then
			table.insert(var_31_0, iter_31_1)
		end
	end

	return var_31_0
end

function var_0_0.updateCard(arg_32_0, arg_32_1)
	arg_32_0:clearCardOps()
	arg_32_0._cardMO:init(arg_32_1)
end

function var_0_0.coverCard(arg_33_0, arg_33_1)
	if not arg_33_1 then
		logError("覆盖卡牌序列,传入的数据为空")
	end

	arg_33_0._cardMO:setCards(arg_33_1)
end

function var_0_0.getHandCards(arg_34_0)
	return arg_34_0:getHandCardsByOps(arg_34_0._cardOps)
end

function var_0_0.getHandCardData(arg_35_0)
	return arg_35_0._cardMO and arg_35_0._cardMO.cardGroup
end

function var_0_0.getHandCardsByOps(arg_36_0, arg_36_1)
	return arg_36_0:tryGettingHandCardsByOps(arg_36_1) or {}
end

function var_0_0.tryGettingHandCardsByOps(arg_37_0, arg_37_1)
	if not arg_37_0._cardMO then
		return nil
	end

	local var_37_0
	local var_37_1
	local var_37_2 = tabletool.copy(arg_37_0._cardMO.cardGroup)

	for iter_37_0, iter_37_1 in ipairs(arg_37_1) do
		local var_37_3 = false

		if iter_37_1:isMoveCard() then
			var_37_0 = nil
			var_37_1 = nil

			if not var_37_2[iter_37_1.param1] then
				return nil
			end

			if not var_37_2[iter_37_1.param2] then
				return nil
			end

			var_0_0.moveOnly(var_37_2, iter_37_1.param1, iter_37_1.param2)
		elseif iter_37_1:isPlayCard() then
			var_37_0 = nil
			var_37_1 = nil

			if not var_37_2[iter_37_1.param1] then
				return nil
			end

			table.remove(var_37_2, iter_37_1.param1)

			if iter_37_1.param2 and iter_37_1.params ~= 0 then
				var_37_3 = true
			end
		elseif iter_37_1:isMoveUniversal() then
			var_37_0 = var_37_2[iter_37_1.param1]
			var_37_1 = var_37_2[iter_37_1.param2]

			if not var_37_2[iter_37_1.param1] then
				return nil
			end

			if not var_37_2[iter_37_1.param2] then
				return nil
			end

			var_0_0.moveOnly(var_37_2, iter_37_1.param1, iter_37_1.moveToIndex)
		elseif iter_37_1:isSimulateDissolveCard() then
			table.remove(var_37_2, iter_37_1.dissolveIndex)
		end

		if var_37_3 then
			table.remove(var_37_2, iter_37_1.param2)

			local var_37_4 = var_0_0.getCombineIndexOnce(var_37_2, var_37_0, var_37_1)

			while #var_37_2 >= 2 and var_37_4 do
				var_37_2[var_37_4] = var_0_0.combineTwoCard(var_37_2[var_37_4], var_37_2[var_37_4 + 1], var_37_1)

				table.remove(var_37_2, var_37_4 + 1)

				var_37_0 = nil
				var_37_1 = nil
				var_37_4 = var_0_0.getCombineIndexOnce(var_37_2)
			end
		end

		local var_37_5 = var_0_0.getCombineIndexOnce(var_37_2, var_37_0, var_37_1)

		while #var_37_2 >= 2 and var_37_5 do
			var_37_2[var_37_5] = var_0_0.combineTwoCard(var_37_2[var_37_5], var_37_2[var_37_5 + 1], var_37_1)

			table.remove(var_37_2, var_37_5 + 1)

			var_37_0 = nil
			var_37_1 = nil
			var_37_5 = var_0_0.getCombineIndexOnce(var_37_2)
		end
	end

	return var_37_2
end

function var_0_0.isCardOpEnd(arg_38_0)
	local var_38_0 = var_0_0.instance:getCardMO()

	if not var_38_0 then
		return true
	end

	local var_38_1 = var_0_0.instance:getHandCards()

	if #var_38_1 == 0 then
		return true
	end

	local var_38_2 = var_0_0.instance:getCardOps()
	local var_38_3 = 0
	local var_38_4 = 0

	for iter_38_0, iter_38_1 in ipairs(var_38_2) do
		if iter_38_1:isPlayCard() then
			var_38_3 = var_38_3 + iter_38_1.costActPoint
		elseif iter_38_1:isMoveCard() then
			var_38_4 = var_38_4 + 1

			if not arg_38_0._cardMO:isUnlimitMoveCard() and var_38_4 > arg_38_0._cardMO.extraMoveAct then
				var_38_3 = var_38_3 + iter_38_1.costActPoint
			end
		end
	end

	local var_38_5 = var_38_0.actPoint

	if FightModel.instance:isSeason2() then
		var_38_5 = 1

		if #var_38_2 >= 1 then
			return true
		end
	end

	if var_38_5 <= var_38_3 then
		return true
	end

	if FightCardDataHelper.allFrozenCard(var_38_1) then
		return true
	end

	return false
end

function var_0_0.calcCardsAfterCombine(arg_39_0, arg_39_1)
	local var_39_0 = tabletool.copy(arg_39_0)
	local var_39_1 = var_0_0.getCombineIndexOnce(var_39_0)
	local var_39_2 = 0

	while var_39_1 do
		var_39_0[var_39_1] = var_0_0.combineTwoCard(var_39_0[var_39_1], var_39_0[var_39_1 + 1])

		table.remove(var_39_0, var_39_1 + 1)

		var_39_1 = var_0_0.getCombineIndexOnce(var_39_0)
		var_39_2 = var_39_2 + 1

		if var_39_2 == arg_39_1 then
			break
		end
	end

	return var_39_0, var_39_2
end

function var_0_0.combineTwoCard(arg_40_0, arg_40_1, arg_40_2)
	local var_40_0 = arg_40_2 and arg_40_2:clone() or arg_40_0:clone()

	var_40_0.skillId = var_0_0.getCombineSkillId(arg_40_0, arg_40_1, arg_40_2)
	var_40_0.tempCard = false

	FightCardDataHelper.enchantsAfterCombine(var_40_0, arg_40_1)

	if not var_40_0.uid or tonumber(var_40_0.uid) == 0 then
		var_40_0.uid = arg_40_1.uid
		var_40_0.cardType = arg_40_1.cardType
	end

	if var_40_0.heroId ~= arg_40_1.heroId then
		var_40_0.heroId = arg_40_1.heroId
	end

	var_40_0.energy = arg_40_0.energy + arg_40_1.energy
	var_40_0.heatId = var_40_0.uid and var_40_0.uid ~= "0" and var_40_0.heatId or arg_40_1.heatId

	return var_40_0
end

function var_0_0.getCombineSkillId(arg_41_0, arg_41_1, arg_41_2)
	local var_41_0 = arg_41_0.uid
	local var_41_1 = arg_41_0.skillId

	if arg_41_2 then
		if arg_41_0 == arg_41_2 then
			var_41_1 = arg_41_0.skillId
			var_41_0 = arg_41_2.uid
		elseif arg_41_1 == arg_41_2 then
			var_41_1 = arg_41_1.skillId
			var_41_0 = arg_41_2.uid
		end
	end

	local var_41_2 = var_0_0.instance:getSkillNextLvId(var_41_0, var_41_1)
	local var_41_3 = true

	if FightCardDataHelper.isSkill3(arg_41_0) or FightCardDataHelper.isSkill3(arg_41_1) then
		var_41_3 = false
	end

	if var_41_3 and not FightEnum.UniversalCard[arg_41_0.skillId] and not FightEnum.UniversalCard[arg_41_1.skillId] then
		local var_41_4 = FightEnum.BuffFeature.ChangeComposeCardSkill
		local var_41_5 = {}

		tabletool.addValues(var_41_5, FightDataHelper.entityMgr:getMyPlayerList())
		tabletool.addValues(var_41_5, FightDataHelper.entityMgr:getMyNormalList())
		tabletool.addValues(var_41_5, FightDataHelper.entityMgr:getMySpList())

		local var_41_6 = 0

		for iter_41_0, iter_41_1 in ipairs(var_41_5) do
			local var_41_7 = iter_41_1.buffDic

			for iter_41_2, iter_41_3 in pairs(var_41_7) do
				local var_41_8 = FightConfig.instance:hasBuffFeature(iter_41_3.buffId, var_41_4)

				if var_41_8 then
					local var_41_9 = string.splitToNumber(var_41_8.featureStr, "#")

					if var_41_9[2] then
						var_41_6 = var_41_6 + var_41_9[2]
					end
				end
			end
		end

		if var_41_6 == 0 then
			return var_41_2
		elseif var_41_6 > 0 then
			for iter_41_4 = 1, var_41_6 do
				var_41_2 = var_0_0.instance:getSkillNextLvId(var_41_0, var_41_2) or var_41_2
			end
		else
			for iter_41_5 = 1, math.abs(var_41_6) do
				var_41_2 = var_0_0.instance:getSkillPrevLvId(var_41_0, var_41_2) or var_41_2
			end
		end
	end

	return var_41_2
end

function var_0_0.moveOnly(arg_42_0, arg_42_1, arg_42_2)
	if arg_42_2 < arg_42_1 then
		local var_42_0 = arg_42_0[arg_42_1]

		for iter_42_0 = arg_42_1, arg_42_2 + 1, -1 do
			arg_42_0[iter_42_0] = arg_42_0[iter_42_0 - 1]
		end

		arg_42_0[arg_42_2] = var_42_0
	elseif arg_42_1 < arg_42_2 then
		local var_42_1 = arg_42_0[arg_42_1]

		for iter_42_1 = arg_42_1, arg_42_2 - 1 do
			arg_42_0[iter_42_1] = arg_42_0[iter_42_1 + 1]
		end

		arg_42_0[arg_42_2] = var_42_1
	end
end

function var_0_0.getCombineIndexOnce(arg_43_0, arg_43_1, arg_43_2)
	if not arg_43_0 then
		return
	end

	for iter_43_0 = 1, #arg_43_0 - 1 do
		if arg_43_1 and arg_43_2 then
			if arg_43_1 == arg_43_0[iter_43_0] and arg_43_2 == arg_43_0[iter_43_0 + 1] then
				return iter_43_0
			elseif arg_43_2 == arg_43_0[iter_43_0] and arg_43_1 == arg_43_0[iter_43_0 + 1] then
				return iter_43_0
			end
		elseif FightCardDataHelper.canCombineCardForPerformance(arg_43_0[iter_43_0], arg_43_0[iter_43_0 + 1]) then
			return iter_43_0
		end
	end
end

function var_0_0.revertOp(arg_44_0)
	if #arg_44_0._cardOps > 0 then
		return table.remove(arg_44_0._cardOps, #arg_44_0._cardOps)
	end
end

function var_0_0.moveHandCardOp(arg_45_0, arg_45_1, arg_45_2, arg_45_3, arg_45_4)
	if arg_45_1 ~= arg_45_2 then
		local var_45_0 = FightBeginRoundOp.New()

		var_45_0:moveCard(arg_45_1, arg_45_2, arg_45_3, arg_45_4)
		table.insert(arg_45_0._cardOps, var_45_0)

		return var_45_0
	end
end

function var_0_0.moveUniversalCardOp(arg_46_0, arg_46_1, arg_46_2, arg_46_3, arg_46_4, arg_46_5)
	if arg_46_1 ~= arg_46_2 then
		local var_46_0 = FightBeginRoundOp.New()

		var_46_0:moveUniversalCard(arg_46_1, arg_46_2, arg_46_3, arg_46_4, arg_46_5)
		table.insert(arg_46_0._cardOps, var_46_0)

		return var_46_0
	end
end

function var_0_0.playHandCardOp(arg_47_0, arg_47_1, arg_47_2, arg_47_3, arg_47_4, arg_47_5, arg_47_6)
	local var_47_0 = FightBeginRoundOp.New()
	local var_47_1 = arg_47_2 or arg_47_0.curSelectEntityId

	if var_47_1 == 0 then
		local var_47_2 = FightHelper.getTargetLimits(FightEnum.EntitySide.MySide, arg_47_3)

		if #var_47_2 > 0 then
			var_47_1 = var_47_2[1]
		end
	end

	var_47_0:playCard(arg_47_1, var_47_1, arg_47_3, arg_47_4, arg_47_5, arg_47_6)
	table.insert(arg_47_0._cardOps, var_47_0)

	return var_47_0
end

function var_0_0.playAssistBossHandCardOp(arg_48_0, arg_48_1, arg_48_2)
	local var_48_0 = FightBeginRoundOp.New()
	local var_48_1 = arg_48_2 or arg_48_0.curSelectEntityId

	if var_48_1 == 0 then
		local var_48_2 = FightHelper.getTargetLimits(FightEnum.EntitySide.MySide, arg_48_1)

		if #var_48_2 > 0 then
			var_48_1 = var_48_2[1]
		end
	end

	var_48_0:playAssistBossHandCard(arg_48_1, var_48_1)
	table.insert(arg_48_0._cardOps, var_48_0)

	return var_48_0
end

function var_0_0.playPlayerFinisherSkill(arg_49_0, arg_49_1, arg_49_2)
	local var_49_0 = FightBeginRoundOp.New()

	var_49_0:playPlayerFinisherSkill(arg_49_1, arg_49_2)
	table.insert(arg_49_0._cardOps, var_49_0)

	return var_49_0
end

function var_0_0.playBloodPoolCardOp(arg_50_0, arg_50_1, arg_50_2)
	local var_50_0 = FightBeginRoundOp.New()

	arg_50_2 = arg_50_2 or arg_50_0.curSelectEntityId

	var_50_0:playBloodPoolCard(arg_50_1, arg_50_2)
	table.insert(arg_50_0._cardOps, var_50_0)

	return var_50_0
end

function var_0_0.simulateDissolveCard(arg_51_0, arg_51_1)
	local var_51_0 = FightBeginRoundOp.New()

	var_51_0:simulateDissolveCard(arg_51_1)
	table.insert(arg_51_0._cardOps, var_51_0)

	return var_51_0
end

local var_0_1 = {
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	0.9,
	0.8,
	0.73,
	0.67,
	0.62,
	0.57,
	0.53,
	0.5,
	0.47,
	0.44,
	0.42,
	0.4
}

function var_0_0.getHandCardContainerScale(arg_52_0, arg_52_1, arg_52_2)
	local var_52_0 = #(arg_52_2 or arg_52_0:getHandCards())
	local var_52_1 = var_0_1[var_52_0] or 1

	if var_52_0 > 20 then
		var_52_1 = 0.4
	end

	if arg_52_1 and var_52_0 >= 8 then
		var_52_1 = var_52_1 * 0.9
	end

	return var_52_1
end

function var_0_0.getSkillLv(arg_53_0, arg_53_1, arg_53_2)
	local var_53_0 = FightDataHelper.entityMgr:getById(arg_53_1)

	if var_53_0 then
		return var_53_0:getSkillLv(arg_53_2)
	end

	return FightConfig.instance:getSkillLv(arg_53_2)
end

function var_0_0.getSkillNextLvId(arg_54_0, arg_54_1, arg_54_2)
	local var_54_0 = lua_skill_next.configDict[arg_54_2]

	if var_54_0 and var_54_0.nextId ~= 0 then
		return var_54_0.nextId
	end

	local var_54_1 = FightDataHelper.entityMgr:getById(arg_54_1)

	if var_54_1 then
		return var_54_1:getSkillNextLvId(arg_54_2)
	end

	return FightConfig.instance:getSkillNextLvId(arg_54_2)
end

function var_0_0.getSkillPrevLvId(arg_55_0, arg_55_1, arg_55_2)
	local var_55_0 = FightDataHelper.entityMgr:getById(arg_55_1)

	if var_55_0 then
		return var_55_0:getSkillPrevLvId(arg_55_2)
	end

	return FightConfig.instance:getSkillPrevLvId(arg_55_2)
end

function var_0_0.isActiveSkill(arg_56_0, arg_56_1, arg_56_2)
	local var_56_0 = FightDataHelper.entityMgr:getById(arg_56_1)

	if var_56_0 then
		return var_56_0:isActiveSkill(arg_56_2)
	end

	return FightConfig.instance:isActiveSkill(arg_56_2)
end

function var_0_0.isUnlimitMoveCard(arg_57_0)
	return arg_57_0._cardMO and arg_57_0._cardMO:isUnlimitMoveCard()
end

var_0_0.instance = var_0_0.New()

return var_0_0
