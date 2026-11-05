-- chunkname: @configs/skill_effect_config.lua

local __result = {}

__result[24503] = true
__result[24503] = nil

local __idx = 0
local __src = require("configs.skill_effect_config_1")

for __i = 1, #__src do
	__idx = __idx + 1
	__result[__idx] = __src[__i]
end

LuaUtil.clearTable("configs.skill_effect_config_1")

local __src = require("configs.skill_effect_config_2")

for __i = 1, #__src do
	__idx = __idx + 1
	__result[__idx] = __src[__i]
end

LuaUtil.clearTable("configs.skill_effect_config_2")

local __src = require("configs.skill_effect_config_3")

for __i = 1, #__src do
	__idx = __idx + 1
	__result[__idx] = __src[__i]
end

LuaUtil.clearTable("configs.skill_effect_config_3")

local __src = require("configs.skill_effect_config_4")

for __i = 1, #__src do
	__idx = __idx + 1
	__result[__idx] = __src[__i]
end

LuaUtil.clearTable("configs.skill_effect_config_4")

return __result
