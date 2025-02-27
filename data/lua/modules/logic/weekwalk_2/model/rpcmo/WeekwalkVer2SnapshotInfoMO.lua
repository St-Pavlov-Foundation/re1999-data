module("modules.logic.weekwalk_2.model.rpcmo.WeekwalkVer2SnapshotInfoMO", package.seeall)

slot0 = pureTable("WeekwalkVer2SnapshotInfoMO")

function slot0.init(slot0, slot1)
	slot0.no = slot1.no
	slot0.skillIds = {}

	for slot5, slot6 in ipairs(slot1.skillIds) do
		table.insert(slot0.skillIds, slot6)
	end
end

function slot0.getChooseSkillId(slot0)
	return slot0.skillIds[1]
end

function slot0.setChooseSkillId(slot0, slot1)
	slot0.skillIds = {}

	if slot1 then
		for slot5, slot6 in ipairs(slot1) do
			table.insert(slot0.skillIds, slot6)
		end
	end
end

return slot0
