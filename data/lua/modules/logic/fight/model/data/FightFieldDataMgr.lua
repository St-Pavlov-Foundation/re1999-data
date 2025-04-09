module("modules.logic.fight.model.data.FightFieldDataMgr", package.seeall)

slot0 = FightDataClass("FightFieldDataMgr", FightDataMgrBase)

function slot0.onConstructor(slot0)
	slot0.deckNum = 0
end

function slot0.onStageChanged(slot0)
end

function slot0.updateData(slot0, slot1)
	slot0.version = slot1.version
	slot0.fightActType = slot1.fightActType or FightEnum.FightActType.Normal
	slot0.curRound = slot1.curRound
	slot0.maxRound = slot1.maxRound
	slot0.isFinish = slot1.isFinish
	slot0.curWave = slot1.curWave
	slot0.battleId = slot1.battleId
	slot0.magicCircle = FightDataUtil.coverData(slot1.magicCircle, slot0.magicCircle)
	slot0.isRecord = slot1.isRecord
	slot0.episodeId = slot1.episodeId
	slot0.episodeCo = DungeonConfig.instance:getEpisodeCO(slot0.episodeId)
	slot0.lastChangeHeroUid = slot1.lastChangeHeroUid
	slot0.progress = slot1.progress
	slot0.progressMax = slot1.progressMax
	slot0.param = FightDataUtil.coverData(slot1.param, slot0.param)
	slot0.indicatorDict = slot0:buildIndicators(slot1)
	slot0.playerFinisherInfo = slot0:buildPlayerFinisherInfo(slot1)
	slot0.customData = FightDataUtil.coverData(slot1.customData, slot0.customData)
	slot0.fightTaskBox = FightDataUtil.coverData(slot1.fightTaskBox, slot0.fightTaskBox)
end

function slot0.buildIndicators(slot0, slot1)
	slot2 = {}

	if slot1.attacker then
		for slot6, slot7 in ipairs(slot1.attacker.indicators) do
			slot8 = tonumber(slot7.inticatorId)
			slot2[slot8] = {
				id = slot8,
				num = slot7.num
			}
		end
	end

	return FightDataUtil.coverData(slot2, slot0.indicatorDict)
end

function slot0.buildPlayerFinisherInfo(slot0, slot1)
	slot2 = nil

	if slot1.attacker and slot1.attacker.playerFinisherInfo then
		slot2 = slot1.attacker.playerFinisherInfo
	end

	return slot0:setPlayerFinisherInfo(slot2)
end

function slot0.setPlayerFinisherInfo(slot0, slot1)
	if slot1 then
		slot3 = slot1

		for slot8, slot9 in ipairs(slot3.skills) do
			table.insert(({
				skills = {},
				roundUseLimit = 0,
				roundUseLimit = slot3.roundUseLimit
			}).skills, {
				skillId = slot9.skillId,
				needPower = slot9.needPower
			})
		end
	end

	return FightDataUtil.coverData(slot2, slot0.playerFinisherInfo)
end

function slot0.getIndicatorNum(slot0, slot1)
	slot2 = slot0.indicatorDict and slot0.indicatorDict[slot1]

	return slot2 and slot2.num or 0
end

function slot0.isDouQuQu(slot0)
	return slot0.fightActType == FightEnum.FightActType.Act174
end

function slot0.isSeason2(slot0)
	return slot0.fightActType == FightEnum.FightActType.Season2
end

function slot0.isDungeonType(slot0, slot1)
	return slot0.episodeCo and slot0.episodeCo.type == slot1
end

function slot0.isPaTa(slot0)
	return slot0:isDungeonType(DungeonEnum.EpisodeType.TowerBoss) or slot0:isDungeonType(DungeonEnum.EpisodeType.TowerLimited) or slot0:isDungeonType(DungeonEnum.EpisodeType.TowerPermanent) or slot0:isDungeonType(DungeonEnum.EpisodeType.TowerBossTeach)
end

function slot0.isTowerLimited(slot0)
	return slot0:isDungeonType(DungeonEnum.EpisodeType.TowerLimited)
end

function slot0.isAct183(slot0)
	return slot0:isDungeonType(DungeonEnum.EpisodeType.Act183)
end

function slot0.dirSetDeckNum(slot0, slot1)
	slot0.deckNum = slot1
end

function slot0.changeDeckNum(slot0, slot1)
	slot0.deckNum = slot0.deckNum + slot1
end

function slot0.is191DouQuQu(slot0)
	return slot0.customData and slot0.customData[FightCustomData.CustomDataType.Act191]
end

return slot0
