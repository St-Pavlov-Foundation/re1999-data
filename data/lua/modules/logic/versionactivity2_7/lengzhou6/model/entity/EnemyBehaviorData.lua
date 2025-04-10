module("modules.logic.versionactivity2_7.lengzhou6.model.entity.EnemyBehaviorData", package.seeall)

slot0 = class("EnemyBehaviorData")

function slot0.ctor(slot0)
	slot0._cd = 0
	slot0._skillList = {}
	slot0._skillProbability = {}
	slot0._needReGenerate = false
end

function slot0.cd(slot0)
	return slot0._cd
end

function slot0.init(slot0, slot1)
	slot0._cd = slot1.round or 0

	for slot5 = 1, 3 do
		if slot1["list" .. slot5] ~= "" and string.splitToNumber(slot6, "#") ~= nil then
			table.insert(slot0._skillList, slot7)
		end

		if slot1["prob" .. slot5] ~= "" and string.splitToNumber(slot7, "#") ~= nil then
			table.insert(slot0._skillProbability, slot8)
		end
	end
end

function slot0.getSkillList(slot0, slot1)
	slot0:_generateUseSkillList()

	if slot1 then
		slot0._needReGenerate = true
	end

	return slot0._needReleaseSkillList
end

function slot0._generateUseSkillList(slot0)
	slot1 = slot0._needReleaseSkillList == nil or slot0._needReGenerate

	if slot0._needReleaseSkillList == nil then
		slot0._needReleaseSkillList = {}
	end

	if slot0._needReGenerate then
		tabletool.clear(slot0._needReleaseSkillList)

		slot0._needReGenerate = false
	end

	if slot1 then
		for slot5 = 1, #slot0._skillList do
			slot6 = slot0._skillList[slot5]
			slot7 = slot6[1]

			if #slot6 > 1 then
				slot7 = slot6[EliminateModelUtils.getRandomNumberByWeight(slot0._skillProbability[slot5])]
			end

			if slot7 ~= nil then
				table.insert(slot0._needReleaseSkillList, LengZhou6SkillUtils.instance.createSkill(slot7))
			end
		end
	end
end

return slot0
