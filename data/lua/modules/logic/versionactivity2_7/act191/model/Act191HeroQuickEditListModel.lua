module("modules.logic.versionactivity2_7.act191.model.Act191HeroQuickEditListModel", package.seeall)

slot0 = class("Act191HeroQuickEditListModel", ListScrollModel)

function slot0.initData(slot0)
	slot0.moList = {}
	slot0._index2HeroIdMap = {}

	for slot5, slot6 in ipairs(Activity191Model.instance:getActInfo():getGameInfo().warehouseInfo.hero) do
		slot7 = {
			heroId = slot6.heroId,
			star = slot6.star,
			exp = slot6.exp
		}
		slot7.config = Activity191Config.instance:getRoleCoByNativeId(slot7.heroId, slot7.star)

		if slot1:getBattleHeroInfoInTeam(slot7.heroId) then
			slot0._index2HeroIdMap[slot8.index] = slot7.heroId
		elseif slot1:getSubHeroInfoInTeam(slot7.heroId) then
			slot0._index2HeroIdMap[slot9.index + 4] = slot7.heroId
		end

		slot0.moList[#slot0.moList + 1] = slot7
	end

	slot5 = Activity191Enum.SortRule.Down

	slot0:filterData(nil, slot5)

	for slot5, slot6 in ipairs(slot0._scrollViews) do
		slot6:selectCell(1, false)
	end
end

function slot0.selectHero(slot0, slot1, slot2)
	if slot2 then
		if slot0:findEmptyPos() ~= 0 then
			slot0._index2HeroIdMap[slot3] = slot1
		end
	else
		slot0._index2HeroIdMap[slot0:getHeroTeamPos(slot1)] = nil
	end
end

function slot0.getHeroTeamPos(slot0, slot1)
	if slot0._index2HeroIdMap then
		for slot5, slot6 in pairs(slot0._index2HeroIdMap) do
			if slot6 == slot1 then
				return slot5
			end
		end
	end

	return 0
end

function slot0.findEmptyPos(slot0)
	for slot4 = 1, 8 do
		if not slot0._index2HeroIdMap[slot4] then
			return slot4
		end
	end

	return 0
end

function slot0.filterData(slot0, slot1, slot2)
	slot3 = nil

	if slot1 then
		slot3 = {}

		for slot7, slot8 in ipairs(slot0.moList) do
			if tabletool.indexOf(string.split(slot8.config.tag, "#"), slot1) then
				slot3[#slot3 + 1] = slot8
			end
		end
	else
		slot3 = tabletool.copy(slot0.moList)
	end

	table.sort(slot3, function (slot0, slot1)
		if uv0:getHeroTeamPos(slot0.heroId) == 0 then
			slot2 = 999
		end

		if uv0:getHeroTeamPos(slot1.heroId) == 0 then
			slot3 = 999
		end

		if slot2 == slot3 then
			if slot0.config.quality == slot1.config.quality then
				if slot0.config.exLevel == slot1.config.exLevel then
					return slot0.config.id < slot1.config.id
				else
					return slot1.config.exLevel < slot0.config.exLevel
				end
			elseif uv1 == Activity191Enum.SortRule.Down then
				return slot1.config.quality < slot0.config.quality
			else
				return slot0.config.quality < slot1.config.quality
			end
		else
			return slot2 < slot3
		end
	end)
	slot0:setList(slot3)
end

function slot0.getHeroIdMap(slot0)
	return slot0._index2HeroIdMap or {}
end

slot0.instance = slot0.New()

return slot0
