module("modules.logic.versionactivity2_7.act191.model.Act191CollectionEditListModel", package.seeall)

slot0 = class("Act191CollectionEditListModel", ListScrollModel)

function slot0.initData(slot0, slot1)
	slot0.specialItem = slot1
	slot2 = {}

	for slot7, slot8 in ipairs(Activity191Model.instance:getActInfo():getGameInfo().warehouseInfo.item) do
		slot10, slot11 = slot3:isItemInTeam(({
			uid = slot8.uid,
			itemId = slot8.itemId
		}).uid)

		if slot10 then
			slot9.inTeam = slot9.uid == slot0.specialItem and 2 or 1

			if slot11 and slot11 ~= 0 then
				slot9.heroId = slot11
			end
		else
			slot9.inTeam = 0
		end

		slot2[#slot2 + 1] = slot9
	end

	table.sort(slot2, function (slot0, slot1)
		return slot1.inTeam < slot0.inTeam
	end)
	slot0:setList(slot2)

	if slot0.specialItem and slot0.specialItem ~= 0 then
		slot0:selectItem(slot0.specialItem, true)
	end
end

function slot0.selectItem(slot0, slot1, slot2)
	for slot7, slot8 in ipairs(slot0:getList()) do
		if slot8.uid == slot1 then
			for slot12, slot13 in ipairs(slot0._scrollViews) do
				slot13:selectCell(slot7, slot2)
			end

			break
		end
	end
end

slot0.instance = slot0.New()

return slot0
