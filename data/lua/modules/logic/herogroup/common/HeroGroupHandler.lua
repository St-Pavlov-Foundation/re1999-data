module("modules.logic.herogroup.common.HeroGroupHandler", package.seeall)

slot0 = class("HeroGroupHandler")
slot0.EpisodeTypeDict = {
	[DungeonEnum.EpisodeType.TowerPermanent] = 1,
	[DungeonEnum.EpisodeType.TowerBoss] = 1,
	[DungeonEnum.EpisodeType.TowerLimited] = 1,
	[DungeonEnum.EpisodeType.TowerBossTeach] = 1,
	[DungeonEnum.EpisodeType.Act183] = 1
}

function slot0.checkIsEpisodeType(slot0)
	return uv0.EpisodeTypeDict[slot0] ~= nil
end

function slot0.checkIsEpisodeTypeByEpisodeId(slot0)
	return uv0.checkIsEpisodeType(DungeonConfig.instance:getEpisodeCO(slot0).type)
end

function slot0.checkIsTowerEpisodeByEpisodeId(slot0)
	if not DungeonConfig.instance:getEpisodeCO(slot0) then
		return false
	end

	return slot1.type == DungeonEnum.EpisodeType.TowerPermanent or slot2 == DungeonEnum.EpisodeType.TowerBoss or slot2 == DungeonEnum.EpisodeType.TowerLimited
end

function slot0.getTowerBossSnapShot(slot0)
	return ModuleEnum.HeroGroupSnapshotType.TowerBoss, {
		TowerConfig.instance:getBossTowerIdByEpisodeId(slot0)
	}
end

function slot0.getTowerPermanentSnapShot(slot0)
	return ModuleEnum.HeroGroupSnapshotType.TowerPermanentAndLimit, {
		1,
		2,
		3,
		4
	}
end

function slot0.getAct183SnapShot(slot0)
	return Act183Helper.getEpisodeSnapShotType(slot0), {
		1
	}
end

slot0.getSnapShotHandleFunc = {
	[DungeonEnum.EpisodeType.TowerPermanent] = slot0.getTowerPermanentSnapShot,
	[DungeonEnum.EpisodeType.TowerBoss] = slot0.getTowerBossSnapShot,
	[DungeonEnum.EpisodeType.TowerLimited] = slot0.getTowerPermanentSnapShot,
	[DungeonEnum.EpisodeType.Act183] = slot0.getAct183SnapShot
}

function slot0.getSnapShot(slot0)
	if uv0.getSnapShotHandleFunc[DungeonConfig.instance:getEpisodeCO(slot0).type] then
		return slot3(slot0)
	end
end

function slot0.getTowerTrialHeros(slot0)
	return TowerConfig.instance:getHeroTrialConfig(TowerModel.instance:getTrialHeroSeason()) and slot2.heroIds
end

slot0.getTrialHerosHandleFunc = {
	[DungeonEnum.EpisodeType.TowerPermanent] = slot0.getTowerTrialHeros,
	[DungeonEnum.EpisodeType.TowerBoss] = slot0.getTowerTrialHeros,
	[DungeonEnum.EpisodeType.TowerLimited] = slot0.getTowerTrialHeros
}

function slot0.getTrialHeros(slot0)
	if uv0.getTrialHerosHandleFunc[DungeonConfig.instance:getEpisodeCO(slot0).type] then
		return slot3(slot0)
	else
		return (HeroGroupModel.instance.battleId and lua_battle.configDict[slot4]).trialHeros
	end
end

function slot0.setTowerHeroListData(slot0)
	if HeroGroupSnapshotModel.instance:getCurGroup() then
		for slot5, slot6 in ipairs(slot1.heroList) do
			if tonumber(slot6) < 0 then
				slot7 = -tonumber(slot6)

				if HeroGroupTrialModel.instance:getById(slot6) then
					slot7 = slot8.trialCo.id
				end

				slot9 = TowerModel.instance:getTrialHeroSeason() > 0
				slot12 = slot9 and tabletool.indexOf(slot9 and string.splitToNumber(TowerConfig.instance:getHeroTrialConfig(TowerModel.instance:getTrialHeroSeason()).heroIds, "|") or {}, slot7) and tonumber(slot7) > 0
				slot13 = slot12 and lua_hero_trial.configDict[slot7][0] or {}
				slot1.heroList[slot5] = slot12 and tostring(tonumber(slot13.id .. "." .. slot13.trialTemplate) - 1099511627776.0) or "0"

				if slot12 then
					if not slot1.trialDict then
						slot1.trialDict = {}
					end

					if not slot1.trialDict[slot5] then
						slot1.trialDict[slot5] = {}
					end

					slot1.trialDict[slot5][1] = slot13.id
				end
			end
		end
	end
end

slot0.getHeroListDataHandlerFunc = {
	[DungeonEnum.EpisodeType.TowerPermanent] = slot0.setTowerHeroListData,
	[DungeonEnum.EpisodeType.TowerBoss] = slot0.setTowerHeroListData,
	[DungeonEnum.EpisodeType.TowerLimited] = slot0.setTowerHeroListData
}

function slot0.hanldeHeroListData(slot0)
	if not slot0 then
		return
	end

	if uv0.getHeroListDataHandlerFunc[DungeonConfig.instance:getEpisodeCO(slot0).type] then
		return slot3(slot0)
	end
end

return slot0
