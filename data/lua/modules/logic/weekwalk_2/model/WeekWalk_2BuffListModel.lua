module("modules.logic.weekwalk_2.model.WeekWalk_2BuffListModel", package.seeall)

slot0 = class("WeekWalk_2BuffListModel", ListScrollModel)

function slot0.getPrevBattleSkillId()
	slot0 = WeekWalk_2Model.instance:getCurMapInfo()

	return slot0:getBattleInfo(slot0:getBattleInfoByBattleId(HeroGroupModel.instance.battleId).index - 1) and slot3:getChooseSkillId()
end

function slot0.getCurHeroGroupSkillId()
	if uv0._getCurHeroGroupSkillId() then
		if not tabletool.indexOf(WeekWalk_2Model.instance:getInfo():getOptionSkills(), slot0) or WeekWalk_2Model.instance:getCurMapInfo():getChooseSkillNum() < slot5 then
			slot0 = nil
		end
	end

	return slot0
end

function slot0._getCurHeroGroupSkillId()
	slot1 = WeekWalk_2Model.instance:getInfo() and slot0:getHeroGroupSkill(HeroGroupModel.instance.curGroupSelectIndex)

	return slot1 ~= uv0.getPrevBattleSkillId() and slot1 or nil
end

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
		slot0.prevBattleSkillId = uv0.getPrevBattleSkillId()
		slot8 = uv0.getCurHeroGroupSkillId()

		if slot0.prevBattleSkillId then
			for slot12, slot13 in ipairs(slot6) do
				if slot0.prevBattleSkillId == slot13.id then
					table.remove(slot6, slot12)
					table.insert(slot6, slot13)

					break
				end
			end
		end

		for slot12, slot13 in ipairs(slot6) do
			if slot8 == slot13.id then
				slot7 = slot12

				break
			end
		end
	end

	slot0:setList(slot6)
	slot0:selectCell(slot7, true)
end

slot0.instance = slot0.New()

return slot0
