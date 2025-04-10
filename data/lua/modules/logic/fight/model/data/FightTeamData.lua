module("modules.logic.fight.model.data.FightTeamData", package.seeall)

slot0 = FightDataClass("FightTeamData")

function slot0.onConstructor(slot0, slot1)
	slot0.entitys = {}

	for slot5, slot6 in ipairs(slot1.entitys) do
		table.insert(slot0.entitys, FightEntityInfoData.New(slot6))
	end

	slot0.subEntitys = {}

	for slot5, slot6 in ipairs(slot1.subEntitys) do
		table.insert(slot0.subEntitys, FightEntityInfoData.New(slot6))
	end

	slot0.power = slot1.power
	slot0.clothId = slot1.clothId
	slot0.skillInfos = {}

	for slot5, slot6 in ipairs(slot1.skillInfos) do
		table.insert(slot0.skillInfos, FightPlayerSkillInfoData.New(slot6))
	end

	slot0.spEntitys = {}

	for slot5, slot6 in ipairs(slot1.spEntitys) do
		table.insert(slot0.spEntitys, FightEntityInfoData.New(slot6))
	end

	slot0.indicators = {}

	for slot5, slot6 in ipairs(slot1.indicators) do
		table.insert(slot0.indicators, FightIndicatorInfoData.New(slot6))
	end

	slot0.exTeamStr = slot1.exTeamStr

	if slot1:HasField("assistBoss") then
		slot0.assistBoss = FightEntityInfoData.New(slot1.assistBoss)
	end

	if slot1:HasField("assistBossInfo") then
		slot0.assistBossInfo = FightAssistBossInfoData.New(slot1.assistBossInfo)
	end

	if slot1:HasField("emitter") then
		slot0.emitter = FightEntityInfoData.New(slot1.emitter)
	end

	if slot1:HasField("emitterInfo") then
		slot0.emitterInfo = FightEmitterInfoData.New(slot1.emitterInfo)
	end

	if slot1:HasField("playerEntity") then
		slot0.playerEntity = FightEntityInfoData.New(slot1.playerEntity)
	end

	if slot1:HasField("playerFinisherInfo") then
		slot0.playerFinisherInfo = FightPlayerFinisherInfoData.New(slot1.playerFinisherInfo)
	end

	slot0.energy = slot1.energy

	if slot1:HasField("cardHeat") then
		slot0.cardHeat = FightCardHeatInfoData.New(slot1.cardHeat)
	end

	slot0.cardDeckSize = slot1.cardDeckSize

	if slot1:HasField("bloodPool") then
		slot0.bloodPool = FightDataBloodPool.New(slot1.bloodPool)
	end
end

return slot0
