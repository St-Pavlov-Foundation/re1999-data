module("modules.logic.versionactivity2_7.v2a7_selfselectsix_1.model.V2a7_SelfSelectSix_PickChoiceListModel", package.seeall)

slot0 = class("V2a7_SelfSelectSix_PickChoiceListModel", MixScrollModel)

function slot0.onInit(slot0)
	slot0._selectIdList = {}
	slot0._selectIdMap = {}
	slot0._pickChoiceMap = {}
	slot0.maxSelectCount = nil
	slot0._lastUnLock = nil
	slot0._lastUnlockEpisodeId = nil
	slot0._allPass = false
	slot0._arrcount = 0
end

function slot0.reInit(slot0)
	slot0:onInit()
end

function slot0.initData(slot0, slot1, slot2)
	slot0:onInit()
	slot0:initList(slot1)

	slot0.maxSelectCount = slot2 or 1
end

function slot0.initList(slot0, slot1)
	if not slot1 then
		return
	end

	slot2 = {}
	slot0._arrcount = #slot1
	slot3 = true

	for slot7, slot8 in ipairs(slot1) do
		slot9 = {}
		slot11 = {}

		if string.split(slot8, ":")[2] and #slot10[2] > 0 then
			slot0._pickChoiceMap[tonumber(slot10[1])] = string.splitToNumber(slot10[2], ",")
		end

		slot9.episodeId = tonumber(slot10[1])
		slot9.heroIdList = slot11
		slot12 = DungeonModel.instance:hasPassLevel(slot9.episodeId)
		slot9.isUnlock = slot12

		if slot12 then
			slot0._lastUnLock = slot7
		else
			slot3 = false
		end

		if not slot12 and not slot0._lastUnlockEpisodeId then
			slot0._lastUnlockEpisodeId = slot9.episodeId
		end

		if slot7 == #slot1 and slot3 then
			slot0._lastUnlockEpisodeId = slot9.episodeId
		end

		table.insert(slot2, {
			isTitle = true,
			episodeId = slot9.episodeId,
			isUnlock = slot12
		})
		table.insert(slot2, slot9)

		slot0._allPass = slot3
	end

	slot0:setList(slot2)
end

function slot0.getLastUnlockIndex(slot0)
	return slot0._lastUnLock
end

function slot0.getLastUnlockEpisodeId(slot0)
	return slot0._lastUnlockEpisodeId, slot0._allPass
end

function slot0.getArrCount(slot0)
	return slot0._arrcount
end

function slot0.setSelectId(slot0, slot1)
	if not slot0._selectIdList then
		return
	end

	if slot0._selectIdMap[slot1] then
		slot0._selectIdMap[slot1] = nil

		tabletool.removeValue(slot0._selectIdList, slot1)
	else
		slot0._selectIdMap[slot1] = true

		table.insert(slot0._selectIdList, slot1)
	end
end

function slot0.clearAllSelect(slot0)
	slot0._selectIdMap = {}
	slot0._selectIdList = {}
end

function slot0.getSelectIds(slot0)
	return slot0._selectIdList
end

function slot0.getSelectCount(slot0)
	if slot0._selectIdList then
		return #slot0._selectIdList
	end

	return 0
end

function slot0.getMaxSelectCount(slot0)
	return slot0.maxSelectCount
end

function slot0.isHeroIdSelected(slot0, slot1)
	if slot0._selectIdMap then
		return slot0._selectIdMap[slot1] ~= nil
	end

	return false
end

function slot0.getInfoList(slot0, slot1)
	slot0._mixCellInfo = {}

	for slot6, slot7 in ipairs(slot0:getList()) do
		table.insert(slot0._mixCellInfo, SLFramework.UGUI.MixCellInfo.New(slot7.isTitle and 0 or 1, slot8 and 66 or 200, nil))
	end

	return slot0._mixCellInfo
end

slot0.instance = slot0.New()

return slot0
