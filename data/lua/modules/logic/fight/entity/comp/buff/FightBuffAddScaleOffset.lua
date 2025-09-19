module("modules.logic.fight.entity.comp.buff.FightBuffAddScaleOffset", package.seeall)

local var_0_0 = class("FightBuffAddScaleOffset")

function var_0_0.onBuffStart(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = arg_1_1.id

	FightDataHelper.entityExMgr:getById(var_1_0).scaleOffsetDic.FightBuffAddScaleOffset = 1.3

	local var_1_1 = FightDataHelper.entityMgr:getById(var_1_0)

	if var_1_1 then
		local var_1_2, var_1_3, var_1_4, var_1_5 = FightHelper.getEntityStandPos(var_1_1)

		arg_1_1:setScale(var_1_5)
	end
end

function var_0_0.onBuffEnd(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = arg_2_1.id

	FightDataHelper.entityExMgr:getById(var_2_0).scaleOffsetDic.FightBuffAddScaleOffset = nil

	local var_2_1 = FightDataHelper.entityMgr:getById(var_2_0)

	if var_2_1 then
		local var_2_2, var_2_3, var_2_4, var_2_5 = FightHelper.getEntityStandPos(var_2_1)

		arg_2_1:setScale(var_2_5)
	end
end

return var_0_0
