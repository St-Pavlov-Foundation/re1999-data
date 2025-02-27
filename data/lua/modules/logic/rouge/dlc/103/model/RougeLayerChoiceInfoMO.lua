module("modules.logic.rouge.dlc.103.model.RougeLayerChoiceInfoMO", package.seeall)

slot0 = pureTable("RougeLayerChoiceInfoMO")

function slot0.init(slot0, slot1)
	slot0.layerId = slot1.layerId
	slot0.mapRuleId = slot1.mapRuleId
	slot0.mapRuleCo = RougeDLCConfig103.instance:getMapRuleConfig(slot0.mapRuleId)
	slot0.curLayerCollection = {}

	tabletool.addValues(slot0.curLayerCollection, slot1.curLayerCollection)

	slot0.mapRuleCanFreshNum = slot1.mapRuleCanFreshNum
end

function slot0.getMapRuleCo(slot0)
	return slot0.mapRuleCo
end

function slot0.getMapRuleType(slot0)
	return slot0:getMapRuleCo() and slot1.type
end

function slot0.getCurLayerCollection(slot0)
	return slot0.curLayerCollection
end

function slot0.getMapRuleCanFreshNum(slot0)
	return slot0.mapRuleCanFreshNum
end

return slot0
