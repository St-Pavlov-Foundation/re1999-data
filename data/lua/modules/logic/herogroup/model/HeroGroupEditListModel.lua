module("modules.logic.herogroup.model.HeroGroupEditListModel", package.seeall)

slot0 = class("HeroGroupEditListModel", ListScrollModel)

function slot0.setMoveHeroId(slot0, slot1)
	slot0._moveHeroId = slot1
end

function slot0.getMoveHeroIndex(slot0)
	return slot0._moveHeroIndex
end

function slot0.copyCharacterCardList(slot0, slot1)
	slot2 = nil
	slot2 = (not HeroGroupTrialModel.instance:isOnlyUseTrial() or {}) and CharacterBackpackCardListModel.instance:getCharacterCardList()
	slot4 = {}
	slot0._inTeamHeroUids = {}
	slot5 = 1
	slot6 = 1

	for slot11, slot12 in ipairs(HeroSingleGroupModel.instance:getList()) do
		if slot12.trial or not slot12.aid and tonumber(slot12.heroUid) > 0 and not slot4[slot12.heroUid] then
			if slot12.trial then
				table.insert({}, HeroGroupTrialModel.instance:getById(slot12.heroUid))
			else
				table.insert(slot3, HeroModel.instance:getById(slot12.heroUid))
			end

			if slot0.specialHero == slot12.heroUid then
				slot0._inTeamHeroUids[slot12.heroUid] = 2
				slot5 = slot6
			else
				slot0._inTeamHeroUids[slot12.heroUid] = 1
				slot6 = slot6 + 1
			end

			slot4[slot12.heroUid] = true
		end
	end

	HeroGroupTrialModel.instance:sortByLevelAndRare(CharacterModel.instance:getBtnTag(CharacterEnum.FilterType.HeroGroup) == 1, CharacterModel.instance:getRankState()[slot9] == 1)

	for slot14, slot15 in ipairs(HeroGroupTrialModel.instance:getFilterList()) do
		if not slot4[slot15.uid] then
			table.insert(slot3, slot15)
		end
	end

	for slot14, slot15 in ipairs(slot3) do
		if slot0._moveHeroId and slot15.heroId == slot0._moveHeroId then
			slot0._moveHeroId = nil
			slot0._moveHeroIndex = slot14

			break
		end
	end

	slot11 = #slot3
	slot13 = slot0.isWeekWalk_2
	slot14 = {}

	if slot0.isTowerBattle then
		for slot18 = #slot3, 1, -1 do
			if TowerModel.instance:isHeroBan(slot3[slot18].heroId) then
				table.insert(slot14, slot3[slot18])
				table.remove(slot3, slot18)
			end
		end
	end

	for slot18, slot19 in ipairs(slot2) do
		if not slot4[slot19.uid] then
			slot4[slot19.uid] = true

			if slot0.adventure then
				if WeekWalkModel.instance:getCurMapHeroCd(slot19.heroId) > 0 then
					table.insert(slot14, slot19)
				else
					table.insert(slot3, slot19)
				end
			elseif slot13 then
				if WeekWalk_2Model.instance:getCurMapHeroCd(slot19.heroId) > 0 then
					table.insert(slot14, slot19)
				else
					table.insert(slot3, slot19)
				end
			elseif slot12 then
				if TowerModel.instance:isHeroBan(slot19.heroId) then
					table.insert(slot14, slot19)
				else
					table.insert(slot3, slot19)
				end
			elseif slot0._moveHeroId and slot19.heroId == slot0._moveHeroId then
				slot0._moveHeroId = nil
				slot0._moveHeroIndex = slot11 + 1

				table.insert(slot3, slot0._moveHeroIndex, slot19)
			else
				table.insert(slot3, slot19)
			end
		end
	end

	if slot0.adventure or slot12 or slot13 then
		tabletool.addValues(slot3, slot14)
	end

	slot0:setList(slot3)

	if slot1 and #slot3 > 0 and slot5 > 0 and #slot0._scrollViews > 0 then
		for slot18, slot19 in ipairs(slot0._scrollViews) do
			slot19:selectCell(slot5, true)
		end

		if slot3[slot5] then
			return slot3[slot5]
		end
	end
end

function slot0.isRepeatHero(slot0, slot1, slot2)
	if not slot0._inTeamHeroUids then
		return false
	end

	for slot6 in pairs(slot0._inTeamHeroUids) do
		if not slot0:getById(slot6) then
			logError("heroId:" .. slot1 .. ", " .. "uid:" .. slot2 .. "数据为空")

			return false
		end

		if slot7.heroId == slot1 and slot2 ~= slot7.uid then
			return true
		end
	end

	return false
end

function slot0.isTrialLimit(slot0)
	if not slot0._inTeamHeroUids then
		return false
	end

	for slot5 in pairs(slot0._inTeamHeroUids) do
		if slot0:getById(slot5):isTrial() then
			slot1 = 0 + 1
		end
	end

	return HeroGroupTrialModel.instance:getLimitNum() <= slot1
end

function slot0.cancelAllSelected(slot0)
	if slot0._scrollViews then
		for slot4, slot5 in ipairs(slot0._scrollViews) do
			slot5:selectCell(slot0:getIndex(slot5:getFirstSelect()), false)
		end
	end
end

function slot0.isInTeamHero(slot0, slot1)
	return slot0._inTeamHeroUids and slot0._inTeamHeroUids[slot1]
end

function slot0.setParam(slot0, slot1, slot2, slot3, slot4)
	slot0.specialHero = slot1
	slot0.adventure = slot2
	slot0.isTowerBattle = slot3
	slot0._groupType = slot4
	slot0.isWeekWalk_2 = slot4 == HeroGroupEnum.GroupType.WeekWalk_2
end

slot0.instance = slot0.New()

return slot0
