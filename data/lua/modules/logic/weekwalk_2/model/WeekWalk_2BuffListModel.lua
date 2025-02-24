module("modules.logic.weekwalk_2.model.WeekWalk_2BuffListModel", package.seeall)

slot0 = class("WeekWalk_2BuffListModel", ListScrollModel)

function slot0.initBuffList(slot0, slot1)
	slot5 = #string.split(lua_weekwalk_ver2_time.configDict[WeekWalk_2Model.instance:getTimeId()].optionalSkills, "#")

	if slot1 then
		slot5 = WeekWalk_2Model.instance:getCurMapInfo():getChooseSkillNum()
	end

	for slot10, slot11 in ipairs(slot4) do
		if slot10 <= slot5 then
			if lua_weekwalk_ver2_skill.configDict[tonumber(slot11)] then
				table.insert({}, slot13)
			end
		else
			break
		end
	end

	slot0.prevBattleSkillId = nil
	slot0.isBattle = slot1
	slot7 = 1

	if slot1 then
		slot8 = WeekWalk_2Model.instance:getCurMapInfo()
		slot10 = slot8:getBattleInfoByBattleId(HeroGroupModel.instance.battleId)
		slot11 = slot10:getChooseSkillId()
		slot0.prevBattleSkillId = slot8:getBattleInfo(slot10.index - 1) and slot12:getChooseSkillId()

		if slot0.prevBattleSkillId then
			for slot16, slot17 in ipairs(slot6) do
				if slot0.prevBattleSkillId == slot17.id then
					table.remove(slot6, slot16)
					table.insert(slot6, slot17)

					break
				end
			end
		end

		for slot16, slot17 in ipairs(slot6) do
			if slot11 == slot17.id then
				slot7 = slot16

				break
			end
		end
	end

	slot0:setList(slot6)
	slot0:selectCell(slot7, true)
end

slot0.instance = slot0.New()

return slot0
