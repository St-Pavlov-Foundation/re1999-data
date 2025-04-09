module("modules.logic.versionactivity2_7.act191.model.Act191HeroEditListModel", package.seeall)

slot0 = class("Act191HeroEditListModel", ListScrollModel)

function slot0.initData(slot0, slot1)
	slot0.specialHero = slot1.heroId
	slot0.specialIndex = slot1.index
	slot0.moList = {}
	slot0._index2HeroIdMap = {}

	for slot6, slot7 in ipairs(Activity191Model.instance:getActInfo():getGameInfo().warehouseInfo.hero) do
		if slot2:getBattleHeroInfoInTeam(({
			heroId = slot7.heroId,
			star = slot7.star,
			exp = slot7.exp,
			inTeam = 0,
			config = Activity191Config.instance:getRoleCoByNativeId(slot7.heroId, slot7.star)
		}).heroId) then
			slot8.inTeam = 1
			slot0._index2HeroIdMap[slot9.index] = slot8.heroId
		elseif slot2:getSubHeroInfoInTeam(slot8.heroId) then
			slot8.inTeam = 1
			slot0._index2HeroIdMap[slot10.index + 4] = slot8.heroId
		end

		if slot8.heroId == slot0.specialHero then
			slot8.inTeam = 2
		end

		slot0.moList[#slot0.moList + 1] = slot8
	end

	slot0:sortData(Activity191Enum.SortRule.Down, slot0.moList)

	if #slot0._scrollViews > 0 and slot0.specialHero and slot0.specialHero ~= 0 then
		for slot6, slot7 in ipairs(slot0._scrollViews) do
			slot7:selectCell(1, true)
		end
	end
end

function slot0.filterData(slot0)
	slot1 = {}

	for slot5, slot6 in ipairs(slot0.moList) do
		slot1[#slot1 + 1] = slot6
	end

	table.sort(slot1, function (slot0, slot1)
		if slot0.inTeam == slot1.inTeam then
			if rule == Activity191Enum.SortRule.Down then
				return slot1.config.quality < slot0.config.quality
			else
				return slot0.config.quality < slot1.config.quality
			end
		else
			return slot1.inTeam < slot0.inTeam
		end
	end)
	slot0:setList(slot1)
end

function slot0.sortData(slot0, slot1, slot2)
	slot2 = slot2 or slot0:getList()

	table.sort(slot2, function (slot0, slot1)
		if slot0.inTeam == slot1.inTeam then
			if uv0 == Activity191Enum.SortRule.Down then
				return slot1.config.quality < slot0.config.quality
			else
				return slot0.config.quality < slot1.config.quality
			end
		else
			return slot1.inTeam < slot0.inTeam
		end
	end)
	slot0:setList(slot2)
end

function slot0.getHeroIdMap(slot0)
	if slot0._scrollViews[1] then
		if slot1:getFirstSelect() then
			slot3 = true

			for slot7, slot8 in pairs(slot0._index2HeroIdMap) do
				if slot8 == slot2.heroId then
					slot3 = false

					break
				end
			end

			if slot3 then
				slot0._index2HeroIdMap[slot0.specialIndex] = slot2.heroId
			end
		else
			slot0._index2HeroIdMap[slot0.specialIndex] = nil
		end
	end

	return slot0._index2HeroIdMap or {}
end

slot0.instance = slot0.New()

return slot0
