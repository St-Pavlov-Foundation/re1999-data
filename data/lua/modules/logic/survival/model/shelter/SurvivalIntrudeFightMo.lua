module("modules.logic.survival.model.shelter.SurvivalIntrudeFightMo", package.seeall)

local var_0_0 = pureTable("SurvivalIntrudeFightMo")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.fightId = arg_1_1.fightId
	arg_1_0.status = arg_1_1.status
	arg_1_0.stageNo = arg_1_1.stageNo
	arg_1_0.beginTime = arg_1_1.beginTime
	arg_1_0.endTime = arg_1_1.endTime
	arg_1_0.currRound = arg_1_1.currRound
	arg_1_0.schemes = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.schemes) do
		arg_1_0.schemes[iter_1_1.id] = iter_1_1.repress
	end

	arg_1_0.repressNpcIds = arg_1_1.repressNpcIds
	arg_1_0.usedHeroId = {}
	arg_1_0.usedEquipPlan = {}

	for iter_1_2, iter_1_3 in ipairs(arg_1_1.rounds) do
		for iter_1_4, iter_1_5 in ipairs(iter_1_3.heroes) do
			arg_1_0.usedHeroId[iter_1_5.heroId] = iter_1_2
		end

		arg_1_0.usedEquipPlan[iter_1_3.equipPlanId] = iter_1_2
	end

	arg_1_0.fightCo = lua_survival_shelter_intrude_fight.configDict[arg_1_0.fightId]

	SurvivalShelterNpcMonsterListModel.instance:setSelectNpcByList(arg_1_0.repressNpcIds)
end

function var_0_0.isNotStart(arg_2_0)
	return SurvivalShelterModel.instance:getWeekInfo().day < arg_2_0.beginTime
end

function var_0_0.canShowEntity(arg_3_0)
	local var_3_0 = SurvivalShelterModel.instance:getWeekInfo().day

	return var_3_0 >= arg_3_0.beginTime and var_3_0 <= arg_3_0.endTime and arg_3_0.status <= SurvivalEnum.ShelterMonsterFightState.Fail
end

function var_0_0.canFight(arg_4_0)
	return SurvivalShelterModel.instance:getWeekInfo().day == arg_4_0.endTime and (arg_4_0.status == SurvivalEnum.ShelterMonsterFightState.NoStart or arg_4_0.status == SurvivalEnum.ShelterMonsterFightState.Fighting)
end

function var_0_0.canSelectNpc(arg_5_0)
	return arg_5_0:canFight() and arg_5_0.status == SurvivalEnum.ShelterMonsterFightState.NoStart
end

function var_0_0.getUseRoundByHeroId(arg_6_0, arg_6_1)
	if arg_6_0.usedHeroId ~= nil then
		for iter_6_0, iter_6_1 in pairs(arg_6_0.usedHeroId) do
			if iter_6_0 == arg_6_1 then
				return iter_6_1
			end
		end
	end

	return nil
end

function var_0_0.canShowReset(arg_7_0)
	return arg_7_0.status == SurvivalEnum.ShelterMonsterFightState.Fighting or arg_7_0.status == SurvivalEnum.ShelterMonsterFightState.Fail
end

function var_0_0.canShowFightBtn(arg_8_0)
	return arg_8_0.status ~= SurvivalEnum.ShelterMonsterFightState.Fail
end

function var_0_0.canAbandon(arg_9_0)
	return arg_9_0.status == SurvivalEnum.ShelterMonsterFightState.NoStart or arg_9_0.status == SurvivalEnum.ShelterMonsterFightState.Fighting
end

function var_0_0.isFighting(arg_10_0)
	return arg_10_0.status == SurvivalEnum.ShelterMonsterFightState.Fighting
end

function var_0_0.setWin(arg_11_0)
	arg_11_0.status = SurvivalEnum.ShelterMonsterFightState.Win
end

function var_0_0.getBattleId(arg_12_0)
	return arg_12_0.fightCo.battleId
end

return var_0_0
