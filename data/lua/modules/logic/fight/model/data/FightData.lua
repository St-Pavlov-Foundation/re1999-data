module("modules.logic.fight.model.data.FightData", package.seeall)

slot0 = FightDataClass("FightData")

function slot0.onConstructor(slot0, slot1)
	slot0.attacker = FightTeamData.New(slot1.attacker)
	slot0.defender = FightTeamData.New(slot1.defender)
	slot0.curRound = slot1.curRound
	slot0.maxRound = slot1.maxRound
	slot0.isFinish = slot1.isFinish
	slot0.curWave = slot1.curWave
	slot0.battleId = slot1.battleId

	if slot1:HasField("magicCircle") then
		slot0.magicCircle = FightMagicCircleInfoData.New(slot1.magicCircle)
	end

	slot0.version = slot1.version
	slot0.isRecord = slot1.isRecord
	slot0.episodeId = slot1.episodeId
	slot0.fightActType = slot1.fightActType
	slot0.lastChangeHeroUid = slot1.lastChangeHeroUid
	slot0.progress = slot1.progress
	slot0.progressMax = slot1.progressMax
	slot0.param = FightParamData.New(slot1.param)
	slot0.customData = FightCustomData.New(slot1.customData)
	slot0.fightTaskBox = FightTaskBoxData.New(slot1.fightTaskBox)
end

return slot0
