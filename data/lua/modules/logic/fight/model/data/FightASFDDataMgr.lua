module("modules.logic.fight.model.data.FightASFDDataMgr", package.seeall)

slot0 = FightDataClass("FightASFDDataMgr", FightDataMgrBase)

function slot0.onConstructor(slot0)
end

function slot0.updateData(slot0, slot1)
	if slot1.attacker.emitterInfo then
		slot0.attackerEmitterInfo = FightASFDEmitterInfoMO.New()

		slot0.attackerEmitterInfo:init(slot1.attacker.emitterInfo)
	end

	if slot1.defender.emitterInfo then
		slot0.defenderEmitterInfo = FightASFDEmitterInfoMO.New()

		slot0.defenderEmitterInfo:init(slot1.defender.emitterInfo)
	end

	slot0.mySideEnergy = slot1.attacker.energy or 0
	slot0.enemySideEnergy = slot1.defender.energy or 0
end

function slot0.getEmitterInfo(slot0, slot1)
	if slot1 == FightEnum.EntitySide.MySide then
		return slot0.attackerEmitterInfo
	end

	if slot1 == FightEnum.EntitySide.EnemySide then
		return slot0.defenderEmitterInfo
	end
end

function slot0.getMySideEmitterInfo(slot0)
	return slot0.attackerEmitterInfo
end

function slot0.getEnemySideEmitterInfo(slot0)
	return slot0.defenderEmitterInfo
end

function slot0.changeEnergy(slot0, slot1, slot2)
	if slot1 == FightEnum.EntitySide.MySide then
		slot0.mySideEnergy = slot0.mySideEnergy or 0
		slot0.mySideEnergy = slot0.mySideEnergy + slot2

		return
	end

	if slot1 == FightEnum.EntitySide.EnemySide then
		slot0.enemySideEnergy = slot0.enemySideEnergy or 0
		slot0.enemySideEnergy = slot0.enemySideEnergy + slot2

		return
	end
end

function slot0.getEnergy(slot0, slot1)
	if slot1 == FightEnum.EntitySide.MySide then
		return slot0.mySideEnergy
	else
		return slot0.enemySideEnergy
	end
end

function slot0.getEmitterEnergy(slot0, slot1)
	if slot1 == FightEnum.EntitySide.MySide then
		return slot0.attackerEmitterInfo and slot0.attackerEmitterInfo.energy or 0
	else
		return slot0.defenderEmitterInfo and slot0.defenderEmitterInfo.energy or 0
	end
end

function slot0.changeEmitterEnergy(slot0, slot1, slot2)
	if slot1 == FightEnum.EntitySide.MySide then
		if slot0.attackerEmitterInfo then
			slot0.attackerEmitterInfo:changeEnergy(slot2)
		end

		return
	end

	if slot1 == FightEnum.EntitySide.EnemySide then
		if slot0.defenderEmitterInfo then
			slot0.defenderEmitterInfo:changeEnergy(slot2)
		end

		return
	end
end

function slot0.setEmitterInfo(slot0, slot1, slot2)
	if slot1 == FightEnum.EntitySide.MySide then
		slot0.attackerEmitterInfo = slot2

		return
	end

	if slot1 == FightEnum.EntitySide.EnemySide then
		slot0.defenderEmitterInfo = slot2

		return
	end
end

slot0.EmitterId = "99998"

function slot0.setEmitterEntityMo(slot0, slot1)
	slot0.emitterMo = slot1
end

function slot0.getEmitterEmitterMo(slot0)
	return slot0.emitterMo
end

function slot0.addEntityResidualData(slot0, slot1, slot2)
	slot0.alfResidualDataDict = slot0.alfResidualDataDict or {}

	if not slot0.alfResidualDataDict[slot1] then
		slot0.alfResidualDataDict[slot1] = {}
	end

	table.insert(slot3, slot2)
end

function slot0.popEntityResidualData(slot0, slot1)
	if not slot0.alfResidualDataDict then
		return
	end

	if not slot0.alfResidualDataDict[slot1] then
		return
	end

	return table.remove(slot2, 1)
end

function slot0.checkCanAddALFResidual(slot0, slot1)
	slot0:initALFResidualCountDict()

	return (slot0.alfResidualCountDict[slot1] or 0) < FightASFDConfig.instance.alfMaxShowEffectCount
end

function slot0.addALFResidual(slot0, slot1, slot2)
	if slot2 < 1 then
		return
	end

	slot0:initALFResidualCountDict()

	slot0.alfResidualCountDict[slot1] = math.min(FightASFDConfig.instance.alfMaxShowEffectCount, (slot0.alfResidualCountDict[slot1] or 0) + slot2)
end

function slot0.removeALFResidual(slot0, slot1, slot2)
	if slot2 < 1 then
		return
	end

	slot0:initALFResidualCountDict()

	slot0.alfResidualCountDict[slot1] = math.max(0, (slot0.alfResidualCountDict[slot1] or 0) - slot2)
end

function slot0.initALFResidualCountDict(slot0)
	slot0.alfResidualCountDict = slot0.alfResidualCountDict or {}
end

return slot0
