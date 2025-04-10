module("modules.logic.versionactivity2_7.lengzhou6.model.damage.EliminateDamageComp", package.seeall)

slot0 = class("EliminateDamageComp", HpCompBase)

function slot0.ctor(slot0)
	slot0._baseDamage = 0
	slot0._exDamage = 0
	slot0._damageRate = 0
	slot0._normalEliminateDamageRate = 0
	slot0._FourEliminateDamageRate = 0
	slot0._FiveEliminateDamageRate = 0
	slot0._CrossEliminateDamageRate = 0
	slot0._eliminateTypeExDamage = {}
end

function slot0.reset(slot0)
	slot0._baseDamage = 0
	slot0._exDamage = 0
	slot0._damageRate = 0
	slot0._normalEliminateDamageRate = 0
	slot0._FourEliminateDamageRate = 0
	slot0._FiveEliminateDamageRate = 0
	slot0._CrossEliminateDamageRate = 0
	slot0._eliminateTypeExDamage = {}
end

function slot0.setSpEliminateRate(slot0, slot1, slot2, slot3)
	slot0._FourEliminateDamageRate = slot1 / 1000
	slot0._CrossEliminateDamageRate = slot2 / 1000
	slot0._FiveEliminateDamageRate = slot3 / 1000
end

function slot0.setEliminateTypeExDamage(slot0, slot1, slot2)
	slot0._eliminateTypeExDamage[slot1] = slot2
end

function slot0.setExDamage(slot0, slot1)
	slot0._exDamage = slot1
end

function slot0.setDamageRate(slot0, slot1)
	slot0._damageRate = slot1 / 1000
end

slot1 = "\n"

function slot0.damage(slot0, slot1)
	slot2 = 0

	for slot7, slot8 in pairs(slot1:getEliminateTypeMap()) do
		slot9 = 0

		for slot13, slot14 in pairs(slot8) do
			if not string.nilorempty(slot7) and slot7 ~= EliminateEnum_2_7.ChessType.stone then
				slot17 = slot14.spEliminateCount
				slot18, slot19 = LengZhou6Config.instance:getDamageValue(slot7, slot14.eliminateType)
				slot20 = slot0._exDamage

				if slot19 ~= nil and (slot15 == EliminateEnum_2_7.eliminateType.cross or slot15 == EliminateEnum_2_7.eliminateType.five) then
					slot19 = (slot14.eliminateCount - 5) * slot19
				end

				if slot15 == EliminateEnum_2_7.eliminateType.four then
					slot9 = slot0._FourEliminateDamageRate
				end

				if slot15 == EliminateEnum_2_7.eliminateType.five then
					slot9 = slot0._FiveEliminateDamageRate
				end

				if slot15 == EliminateEnum_2_7.eliminateType.cross then
					slot9 = slot0._CrossEliminateDamageRate
				end

				if slot15 == EliminateEnum_2_7.eliminateType.base then
					slot18 = slot18 * slot16
					slot20 = 0
				end

				if slot17 ~= 0 and slot0._eliminateTypeExDamage[slot7] ~= nil then
					slot19 = slot19 + slot0._eliminateTypeExDamage[slot7] * slot17
				end

				if slot18 ~= 0 then
					if isDebugBuild then
						uv0 = uv0 .. "eliminateId = " .. slot7 .. " eliminateType = " .. slot15 .. " eliminateCount = " .. slot16 .. " spEliminateCount = " .. slot17 .. " baseDamage = " .. slot18 .. " baseExDamage = " .. slot19 .. " exDamage = " .. slot20 .. " damageRate = " .. slot9 .. "\n"
					end

					slot2 = slot2 + (slot18 + slot19 + slot20) * (1 + slot9)
				end
			end
		end
	end

	if isDebugBuild then
		logNormal("消除伤害详情 = " .. uv0)

		uv0 = "\n"

		logNormal("消除单次伤害 = " .. slot2)
	end

	return slot2
end

return slot0
