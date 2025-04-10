module("modules.logic.versionactivity2_7.lengzhou6.model.mo.RecordServerDataMO", package.seeall)

slot0 = class("RecordServerDataMO")
slot1 = {
	endLessBattleProgress = nil,
	round = nil,
	endLessLayer = nil,
	playerId = nil,
	playerHp = nil,
	playerSkillList = {},
	enemyConfigId = nil,
	enemyHp = nil,
	curActionStepIndex = nil,
	skillRound = nil,
	chessData = {}
}

function slot0.ctor(slot0)
	slot0._data = uv0
end

function slot0.initFormJson(slot0, slot1)
	slot0:_fromJson(slot1)
end

function slot0.toJson(slot0)
	return cjson.encode(slot0._data)
end

function slot0._fromJson(slot0, slot1)
	slot0._data = cjson.decode(slot1)
end

function slot0.getRecordData(slot0)
	return slot0:toJson()
end

function slot0.record(slot0, slot1)
	tabletool.clear(slot0._data)

	if slot0._data ~= nil then
		slot0._data.chessData = slot1
		slot0._data.endLessBattleProgress = LengZhou6GameModel.instance:getEndLessBattleProgress()
		slot0._data.round = LengZhou6GameModel.instance:getCurRound()
		slot0._data.endLessLayer = LengZhou6GameModel.instance:getEndLessModelLayer()
		slot0._data.playerId = LengZhou6GameModel.instance:getPlayer():getConfigId()
		slot4 = LengZhou6GameModel.instance:getEnemy()
		slot0._data.enemyConfigId = slot4:getConfigId()
		slot0._data.curActionStepIndex = slot4:getAction() and slot4:getAction():getCurBehaviorId()
		slot0._data.skillRound = slot4:getAction() and slot4:getAction():getCurRound()
		slot6 = {}

		for slot10 = 1, #slot3:getActiveSkills() do
			table.insert(slot6, slot5[slot10]:getConfig().id)
		end

		slot0._data.playerSkillList = slot6
		slot0._data.playerHp = slot3:getHp()
		slot0._data.enemyHp = slot4:getHp()
	end
end

function slot0.getData(slot0)
	return slot0._data
end

return slot0
