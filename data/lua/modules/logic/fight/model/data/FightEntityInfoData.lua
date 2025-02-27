module("modules.logic.fight.model.data.FightEntityInfoData", package.seeall)

slot0 = FightDataClass("FightEntityInfoData")

function slot0.onConstructor(slot0, slot1)
	slot0.uid = slot1.uid
	slot0.modelId = slot1.modelId
	slot0.skin = slot1.skin
	slot0.position = slot1.position
	slot0.entityType = slot1.entityType
	slot0.userId = slot1.userId
	slot0.exPoint = slot1.exPoint
	slot0.level = slot1.level
	slot0.currentHp = slot1.currentHp
	slot0.attr = FightHeroAttributeData.New(slot1.attr)
	slot0.buffDic = {}

	slot0:buildBuffs(slot1.buffs)

	slot0.skillGroup1 = {}

	for slot5, slot6 in ipairs(slot1.skillGroup1) do
		table.insert(slot0.skillGroup1, slot6)
	end

	slot0.skillGroup2 = {}

	for slot5, slot6 in ipairs(slot1.skillGroup2) do
		table.insert(slot0.skillGroup2, slot6)
	end

	slot0.passiveSkill = {}

	for slot5, slot6 in ipairs(slot1.passiveSkill) do
		table.insert(slot0.passiveSkill, slot6)
	end

	slot0.exSkill = slot1.exSkill
	slot0.shieldValue = slot1.shieldValue
	slot0.expointMaxAdd = slot1.expointMaxAdd
	slot0.equipUid = slot1.equipUid

	if slot1.trialEquip then
		slot0.trialEquip = {
			equipUid = slot2.equipUid,
			equipId = slot2.equipId,
			equipLv = slot2.equipLv,
			refineLv = slot2.refineLv
		}
	else
		slot0.trialEquip = nil
	end

	slot0.exSkillLevel = slot1.exSkillLevel
	slot0.powerDataDic = {}

	slot0:buildPowerInfos(slot1.powerInfos)

	slot0.summonedDataDic = {}

	slot0:buildSummonedInfoData(slot1.SummonedList)

	slot0.exSkillPointChange = slot1.exSkillPointChange
	slot0.teamType = slot1.teamType
	slot0.enhanceInfoBox = FightEnhanceInfoBoxData.New(slot1.enhanceInfoBox)
	slot0.trialId = slot1.trialId
	slot0.career = slot1.career
	slot0.status = slot1.status
	slot0.guard = slot1.guard
	slot0.subCd = slot1.subCd
end

function slot0.buildBuffs(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		slot0.buffDic[slot6.uid] = FightBuffInfoData.New(slot6)
	end
end

function slot0.buildPowerInfos(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		slot0.powerDataDic[slot6.powerId] = FightPowerInfoData.New(slot6)
	end
end

function slot0.buildSummonedInfoData(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		slot0.summonedDataDic[slot6.summonedId] = FightSummonedInfoData.New(slot6)
	end
end

return slot0
