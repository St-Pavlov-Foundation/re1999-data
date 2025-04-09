module("modules.logic.versionactivity2_7.act191.model.Act191NodeDetailMO", package.seeall)

slot0 = pureTable("Act191NodeDetailMO")

function slot0.init(slot0, slot1)
	slot2 = cjson.decode(slot1)
	slot0.type = slot2.type
	slot0.shopId = slot2.shopId
	slot0.shopFreshNum = slot2.shopFreshNum
	slot0.shopPosMap = slot2.shopPosMap
	slot0.boughtSet = slot2.boughtSet
	slot0.enhanceList = slot2.enhanceList
	slot0.enhanceNumList = slot2.enhanceNumList
	slot0.eventId = slot2.eventId
	slot0.fightEventId = slot2.fightEventId

	if slot2.matchInfo then
		slot0.matchInfo = Act191MatchMO.New()

		slot0.matchInfo:init(slot2.matchInfo)
	end
end

return slot0
