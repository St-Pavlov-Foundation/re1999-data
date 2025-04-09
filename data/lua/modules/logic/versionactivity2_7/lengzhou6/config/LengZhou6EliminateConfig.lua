module("modules.logic.versionactivity2_7.lengzhou6.config.LengZhou6EliminateConfig", package.seeall)

slot0 = class("LengZhou6EliminateConfig", EliminateConfig)

function slot0._initEliminateChessConfig(slot0)
	uv0.super._initEliminateChessConfig(slot0)

	slot0._eliminateLevelConfig = {}

	for slot4 = 1, #T_lua_eliminate_level do
		slot5 = T_lua_eliminate_level[slot4]
		slot0._eliminateLevelConfig[slot5.id] = slot5
	end
end

function slot0.getEliminateChessLevelConfig(slot0, slot1)
	if slot0._eliminateLevelConfig == nil then
		slot0:_initEliminateChessConfig()
	end

	return slot0._eliminateLevelConfig[slot1] and slot0._eliminateLevelConfig[slot1].chess or ""
end

slot0.instance = slot0.New()

return slot0
