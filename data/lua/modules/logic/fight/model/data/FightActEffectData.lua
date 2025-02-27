module("modules.logic.fight.model.data.FightActEffectData", package.seeall)

slot0 = FightDataClass("FightActEffectData")

function slot0.onConstructor(slot0, slot1)
	slot0.targetId = slot1.targetId
	slot0.effectType = slot1.effectType
	slot0.effectNum = slot1.effectNum
	slot0.buff = FightBuffInfoData.New(slot1.buff)
	slot0.entity = FightEntityInfoData.New(slot1.entity)
	slot0.configEffect = slot1.configEffect
	slot0.buffActId = slot1.buffActId
	slot0.reserveId = slot1.reserveId
	slot0.reserveStr = slot1.reserveStr
	slot0.summoned = FightSummonedInfoData.New(slot1.summoned)
	slot0.magicCircle = FightMagicCircleInfoData.New(slot1.magicCircle)
	slot0.cardInfo = FightCardInfoData.New(slot1.cardInfo)
	slot0.cardInfoList = {}

	for slot5, slot6 in ipairs(slot1.cardInfoList) do
		table.insert(slot0.cardInfoList, FightCardInfoData.New(slot6))
	end

	slot0.teamType = slot1.teamType
	slot0.fightStep = FightStepData.New(slot1.fightStep)
	slot0.assistBossInfo = FightAssistBossInfoData.New(slot1.assistBossInfo)
	slot0.effectNum1 = slot1.effectNum1
	slot0.emitterInfo = FightEmitterInfoData.New(slot1.emitterInfo)
	slot0.playerFinisherInfo = FightPlayerFinisherInfoData.New(slot1.playerFinisherInfo)
	slot0.powerInfo = FightPowerInfoData.New(slot1.powerInfo)
	slot0.cardHeatValue = FightCardHeatValueData.New(slot1.cardHeatValue)
	slot0.fightTasks = {}

	for slot5, slot6 in ipairs(slot1.fightTasks) do
		table.insert(slot0.fightTasks, FightTaskData.New(slot6))
	end
end

return slot0
