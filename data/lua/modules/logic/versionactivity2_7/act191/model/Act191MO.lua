module("modules.logic.versionactivity2_7.act191.model.Act191MO", package.seeall)

slot0 = pureTable("Act191MO")

function slot0.ctor(slot0)
	slot0.triggerEffectIds = {}
	slot0.triggerParams = {}
end

function slot0.initBadgeInfo(slot0, slot1)
	slot0.badgeMoDic = {}
	slot0.badgeScoreChangeDic = {}

	for slot6, slot7 in pairs(lua_activity191_badge.configDict[slot1]) do
		slot8 = Act191BadgeMO.New()

		slot8:init(slot7)

		slot0.badgeMoDic[slot6] = slot8
	end
end

function slot0.init(slot0, slot1)
	for slot5, slot6 in ipairs(slot1.badgeInfoList) do
		slot0.badgeMoDic[slot6.id]:update(slot6)
	end

	slot0.gameInfo = Act191GameMO.New()

	slot0.gameInfo:init(slot1.gameInfo)
	Activity191Controller.instance:dispatchEvent(Activity191Event.UpdateBadgeMo)
end

function slot0.updateGameInfo(slot0, slot1)
	slot0.gameInfo:update(slot1)
	Activity191Controller.instance:dispatchEvent(Activity191Event.UpdateGameInfo)
end

function slot0.getGameInfo(slot0)
	return slot0.gameInfo
end

function slot0.triggerEffectPush(slot0, slot1, slot2)
	for slot6, slot7 in ipairs(slot1) do
		slot0.triggerEffectIds[#slot0.triggerEffectIds + 1] = slot7
	end

	if not string.nilorempty(slot2) then
		slot0.triggerParams[#slot0.triggerParams + 1] = slot2
	end
end

function slot0.cleanTriggerEffect(slot0)
	tabletool.clear(slot0.triggerEffectIds)
end

function slot0.cleanTriggerParams(slot0)
	tabletool.clear(slot0.triggerParams)
end

function slot0.getGameEndInfo(slot0)
	return slot0.gameEndInfo
end

function slot0.setEnfInfo(slot0, slot1)
	for slot5, slot6 in ipairs(slot1.badgeInfoList) do
		slot7 = slot6.id
		slot0.badgeScoreChangeDic[slot7] = slot6.count - slot0.badgeMoDic[slot7].count

		slot0.badgeMoDic[slot7]:update(slot6)
	end

	slot0.gameEndInfo = slot1

	Activity191Controller.instance:dispatchEvent(Activity191Event.UpdateBadgeMo)
end

function slot0.getBadgeScoreChangeDic(slot0)
	return slot0.badgeScoreChangeDic
end

function slot0.clearEndInfo(slot0)
	slot0.gameEndInfo = nil

	tabletool.clear(slot0.badgeScoreChangeDic)
	slot0:cleanTriggerEffect()
end

function slot0.getBadgeMoList(slot0)
	slot1 = {}

	for slot5, slot6 in pairs(slot0.badgeMoDic) do
		slot1[#slot1 + 1] = slot6
	end

	table.sort(slot1, function (slot0, slot1)
		return slot0.id < slot1.id
	end)

	return slot1
end

return slot0
