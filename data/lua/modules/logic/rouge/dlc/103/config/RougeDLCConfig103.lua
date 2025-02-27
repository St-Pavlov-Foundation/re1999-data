module("modules.logic.rouge.dlc.103.config.RougeDLCConfig103", package.seeall)

slot0 = class("RougeDLCConfig103", BaseConfig)

function slot0.reqConfigNames(slot0)
	return {
		"rouge_map_rule",
		"rouge_monster_rule"
	}
end

function slot0.getMapRuleConfig(slot0, slot1)
	return lua_rouge_map_rule.configDict[slot1]
end

function slot0.getMonsterRuleConfig(slot0, slot1)
	return lua_rouge_monster_rule.configDict[slot1]
end

slot0.instance = slot0.New()

return slot0
