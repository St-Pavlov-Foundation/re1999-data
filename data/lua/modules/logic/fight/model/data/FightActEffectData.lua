module("modules.logic.fight.model.data.FightActEffectData", package.seeall)

slot0 = FightDataClass("FightActEffectData")
slot1 = 1

function slot0.onConstructor(slot0, slot1)
	slot0.clientId = uv0
	uv0 = uv0 + 1

	if not slot1 then
		return
	end

	slot0.targetId = slot1.targetId
	slot0.effectType = slot1.effectType
	slot0.effectNum = slot1.effectNum

	if slot1:HasField("buff") then
		slot0.buff = FightBuffInfoData.New(slot1.buff, slot0.targetId)
	end

	if slot1:HasField("entity") then
		slot0.entity = FightEntityInfoData.New(slot1.entity)
	end

	slot0.configEffect = slot1.configEffect
	slot0.buffActId = slot1.buffActId
	slot0.reserveId = slot1.reserveId
	slot0.reserveStr = slot1.reserveStr

	if slot1:HasField("summoned") then
		slot0.summoned = FightSummonedInfoData.New(slot1.summoned)
	end

	if slot1:HasField("magicCircle") then
		slot0.magicCircle = FightMagicCircleInfoData.New(slot1.magicCircle)
	end

	if slot1:HasField("cardInfo") then
		slot0.cardInfo = FightCardInfoData.New(slot1.cardInfo)
	end

	slot0.cardInfoList = {}

	for slot5, slot6 in ipairs(slot1.cardInfoList) do
		table.insert(slot0.cardInfoList, FightCardInfoData.New(slot6))
	end

	slot0.teamType = slot1.teamType

	if slot1:HasField("fightStep") then
		slot0.fightStep = FightStepData.New(slot1.fightStep)
	end

	if slot1:HasField("assistBossInfo") then
		slot0.assistBossInfo = FightAssistBossInfoData.New(slot1.assistBossInfo)
	end

	slot0.effectNum1 = slot1.effectNum1

	if slot1:HasField("emitterInfo") then
		slot0.emitterInfo = FightEmitterInfoData.New(slot1.emitterInfo)
	end

	if slot1:HasField("playerFinisherInfo") then
		slot0.playerFinisherInfo = FightPlayerFinisherInfoData.New(slot1.playerFinisherInfo)
	end

	if slot1:HasField("powerInfo") then
		slot0.powerInfo = FightPowerInfoData.New(slot1.powerInfo)
	end

	if slot1:HasField("cardHeatValue") then
		slot0.cardHeatValue = FightCardHeatValueData.New(slot1.cardHeatValue)
	end

	slot0.fightTasks = {}

	for slot5, slot6 in ipairs(slot1.fightTasks) do
		table.insert(slot0.fightTasks, FightTaskData.New(slot6))
	end

	if slot1:HasField("fight") then
		slot0.fight = FightData.New(slot1.fight)
	end
end

function slot0.isDone(slot0)
	return slot0.CUSTOM_ISDONE
end

function slot0.setDone(slot0)
	slot0.CUSTOM_ISDONE = true
end

function slot0.revertDone(slot0)
	slot0.CUSTOM_ISDONE = false
end

return slot0
