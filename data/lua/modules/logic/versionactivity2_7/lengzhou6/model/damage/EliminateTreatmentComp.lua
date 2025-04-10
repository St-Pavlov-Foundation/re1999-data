module("modules.logic.versionactivity2_7.lengzhou6.model.damage.EliminateTreatmentComp", package.seeall)

slot0 = class("EliminateTreatmentComp", HpCompBase)

function slot0.ctor(slot0)
	slot0._baseTreatment = 0
	slot0._exTreatment = 0
	slot0._treatmentRate = 0
	slot0._eliminateTypeExTreatment = {}
end

function slot0.reset(slot0)
	slot0._baseTreatment = 0
	slot0._exTreatment = 0
	slot0._treatmentRate = 0
	slot0._eliminateTypeExTreatment = {}
end

function slot0.setExTreatment(slot0, slot1)
	slot0._exTreatment = slot1
end

function slot0.setEliminateTypeExTreatment(slot0, slot1, slot2)
	slot0._eliminateTypeExTreatment[slot1] = slot2
end

function slot0.setTreatmentRate(slot0, slot1)
	slot0._treatmentRate = slot1 / 1000
end

slot1 = "\n"

function slot0.treatment(slot0, slot1)
	slot2 = 0

	for slot7, slot8 in pairs(slot1:getEliminateTypeMap()) do
		for slot12, slot13 in pairs(slot8) do
			if not string.nilorempty(slot7) and slot7 ~= EliminateEnum_2_7.ChessType.stone then
				slot16 = slot13.spEliminateCount
				slot17, slot18 = LengZhou6Config.instance:getHealValue(slot7, slot13.eliminateType)

				if slot18 ~= nil and (slot14 == EliminateEnum_2_7.eliminateType.cross or slot14 == EliminateEnum_2_7.eliminateType.five) then
					slot18 = (slot13.eliminateCount - 5) * slot18
				end

				if slot14 == EliminateEnum_2_7.eliminateType.base then
					slot17 = slot17 * slot15
				end

				if slot16 ~= 0 and slot0._eliminateTypeExTreatment[slot7] ~= nil then
					slot18 = slot18 + slot0._eliminateTypeExTreatment[slot7] * slot16
				end

				if isDebugBuild then
					uv0 = uv0 .. "eliminateId = " .. slot7 .. " eliminateType = " .. slot14 .. " eliminateCount = " .. slot15 .. " spEliminateCount = " .. slot16 .. " baseTreatment = " .. slot17 .. " baseExTreatment = " .. slot18 .. "\n"
				end

				slot2 = slot2 + (slot17 + slot0._exTreatment + slot18) * (1 + slot0._treatmentRate)
			end
		end
	end

	if isDebugBuild then
		logNormal("消除治疗计算详情 = " .. uv0)

		uv0 = "\n"

		logNormal("消除单次治疗 = ：" .. slot2)
	end

	return slot2
end

return slot0
