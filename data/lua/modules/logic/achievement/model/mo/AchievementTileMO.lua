module("modules.logic.achievement.model.mo.AchievementTileMO", package.seeall)

slot0 = pureTable("AchievementTileMO")

function slot0.init(slot0, slot1, slot2, slot3)
	slot0.achievementCfgs = slot1
	slot0.groupId = slot2
	slot0.count = slot1 and #slot1 or 0
	slot0.isGroupTop = slot3
	slot0.isFold = false
	slot0.firstAchievementCo = slot1 and slot1[1]
end

function slot0.getLineHeightFunction(slot0, slot1, slot2)
	if slot2 then
		if slot0.isGroupTop then
			return AchievementEnum.SpGroupTitleBarHeight
		else
			return 0
		end
	elseif slot0.groupId == 0 then
		return AchievementEnum.MainTileLineItemHeight
	else
		if AchievementUtils.isGamePlayGroup(slot0.firstAchievementCo.id) then
			return (slot0.isGroupTop and AchievementEnum.SpGroupTitleBarHeight or 0) + AchievementEnum.MainTileLineItemHeight
		end

		return AchievementEnum.MainTileGroupItemHeight
	end
end

function slot0.getAchievementType(slot0)
	return slot0.groupId and slot0.groupId ~= 0 and AchievementEnum.AchievementType.Group or AchievementEnum.AchievementType.Single
end

function slot0.isAchievementMatch(slot0, slot1, slot2)
	slot3 = false

	if slot1 == AchievementEnum.AchievementType.Single then
		if slot0.achievementCfgs then
			for slot7, slot8 in ipairs(slot0.achievementCfgs) do
				if slot8.id == slot2 then
					slot3 = true

					break
				end
			end
		end
	else
		slot3 = slot2 == slot0.groupId
	end

	return slot3
end

function slot0.overrideLineHeight(slot0, slot1)
	slot0._cellHeight = slot1
end

function slot0.clearOverrideLineHeight(slot0)
	slot0._cellHeight = nil
end

function slot0.getLineHeight(slot0, slot1, slot2)
	if slot0._cellHeight then
		return slot0._cellHeight
	end

	return slot0:getLineHeightFunction(slot1, slot2)
end

function slot0.setIsFold(slot0, slot1)
	slot0.isFold = slot1
end

function slot0.getIsFold(slot0)
	return slot0.isFold
end

function slot0.getGroupId(slot0)
	return slot0.groupId
end

return slot0
