﻿module("modules.logic.fight.entity.comp.skinCustomComp.FightSkinCustomCompBase", package.seeall)

local var_0_0 = class("FightSkinCustomCompBase")

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.entity = arg_1_1
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.go = arg_2_1
end

function var_0_0.addEventListeners(arg_3_0)
	return
end

function var_0_0.removeEventListeners(arg_4_0)
	return
end

function var_0_0.canPlayAnimState(arg_5_0, arg_5_1)
	return true
end

function var_0_0.replaceAnimState(arg_6_0, arg_6_1)
	return arg_6_1
end

function var_0_0.onDestroy(arg_7_0)
	return
end

return var_0_0
