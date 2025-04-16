module("modules.logic.versionactivity2_7.lengzhou6.model.LengZhou6GameModel", package.seeall)

slot0 = class("LengZhou6GameModel", BaseModel)

function slot0.ctor(slot0)
	slot0._round = 0
	slot0._enemySettleCount = 1
	slot0._battleModel = LengZhou6Enum.BattleModel.normal
	slot0._recordServerData = nil
	slot0._endlessBattleProgress = nil
	slot0._isFirstEnterLayer = true
end

function slot0.enterLevel(slot0, slot1)
	slot0._isFirstEnterLayer = true
	slot0._episodeConfig = slot1
	slot0._levelId = slot1.episodeId

	slot0:setBattleModel(slot1.type)

	if slot1.type == LengZhou6Enum.BattleModel.infinite then
		slot0:initSelectSkillId()

		if slot0._recordServerData == nil then
			slot0._recordServerData = RecordServerDataMO.New()
		end
	end

	if LengZhou6Model.instance:getEpisodeInfoMo(slot1.episodeId) ~= nil and not string.nilorempty(slot2.progress) then
		slot0._recordServerData:initFormJson(slot2.progress)
		slot0:initByServerData()
	else
		slot0:initByConfig(slot1)

		if slot1.type == LengZhou6Enum.BattleModel.infinite then
			slot0:setEndLessBattleProgress(LengZhou6Enum.BattleProgress.selectSkill)
		end
	end

	slot0._lineEliminateRate = 0

	slot0:setCurGameStep(LengZhou6Enum.BattleStep.gameBegin)
end

function slot0.initByConfig(slot0, slot1)
	slot0._playerEntity = PlayerEntity.New()

	if slot1.masterId then
		slot0:initPlayer(slot2)
	end

	slot0:_initEnemyByConfig(slot1)

	slot0._round = slot1.maxRound

	if slot0:getBattleModel() == LengZhou6Enum.BattleModel.infinite then
		slot0._round = slot0:calRound()
	end
end

function slot0._initEnemyByConfig(slot0, slot1)
	slot0._enemyEntity = EnemyEntity.New()

	if string.splitToNumber(slot1.enemyId, "#")[1] == 1 and slot2[2] or slot0:calEnemyId() then
		slot0:initEnemy(slot3)
		slot0._enemyEntity:setHp(slot0:calEnemyHpUp() + slot0._enemyEntity:getHp())
	end
end

function slot0.initByServerData(slot0)
	if slot0._recordServerData ~= nil then
		slot1 = slot0._recordServerData:getData()
		slot0._round = slot1.round
		slot0._playerEntity = PlayerEntity.New()

		if slot1.playerId then
			slot0:initPlayer(slot2, slot1.playerSkillList)

			if slot1.playerSkillList ~= nil then
				for slot6 = 1, #slot1.playerSkillList do
					slot0:setPlayerSelectSkillId(slot6, slot1.playerSkillList[slot6])
				end
			end

			slot0._playerEntity:setHp(slot1.playerHp)
		end

		if slot1.enemyConfigId then
			LengZhou6Config.instance:recordEnemyLastRandomId(slot1.endLessLayer)
			LengZhou6Config.instance:setSelectEnemyRandomId(slot1.endLessLayer, slot3)

			slot0._enemyEntity = EnemyEntity.New()

			slot0:initEnemy(slot3)
			slot0._enemyEntity:setHp(slot1.enemyHp)
			slot0._enemyEntity:setActionStepIndexAndRound(slot1.curActionStepIndex, slot1.skillRound)
		end

		slot0._round = slot1.round

		slot0:setEndLessModelLayer(slot1.endLessLayer)
		slot0:setEndLessBattleProgress(slot1.endLessBattleProgress)

		if slot1.endLessBattleProgress == LengZhou6Enum.BattleProgress.selectSkill and slot1.endLessLayer ~= LengZhou6Enum.DefaultEndLessBeginRound then
			slot0._isFirstEnterLayer = false
		end
	end
end

function slot0.getRecordServerData(slot0)
	return slot0._recordServerData
end

function slot0.initPlayer(slot0, slot1, slot2, slot3)
	slot0._playerEntity:init(slot1)

	if slot2 ~= nil then
		slot0._playerEntity:resetData(slot2)
	end
end

function slot0.initEnemy(slot0, slot1, slot2, slot3)
	slot0._enemyEntity:init(slot1)
end

function slot0.getBattleModel(slot0)
	return slot0._battleModel
end

function slot0.setBattleModel(slot0, slot1)
	slot0._battleModel = slot1
end

function slot0.getEpisodeConfig(slot0)
	return slot0._episodeConfig
end

function slot0.getPlayer(slot0)
	return slot0._playerEntity
end

function slot0.getEnemy(slot0)
	return slot0._enemyEntity
end

function slot0.changeRound(slot0, slot1)
	slot0._round = math.max(slot0._round + slot1, 0)

	LengZhou6StatHelper.instance:updateRound()
end

function slot0.getCurRound(slot0)
	return slot0._round
end

function slot0.gameIsOver(slot0)
	if slot0._enemyEntity == nil or slot0._playerEntity == nil then
		return false
	end

	return slot0._round == 0 or slot0._enemyEntity:getHp() <= 0 or slot0._playerEntity:getHp() <= 0
end

function slot0.playerIsWin(slot0)
	if slot0._enemyEntity == nil then
		return false
	end

	return slot0._enemyEntity:getHp() <= 0 and slot0._playerEntity:getHp() > 0 and slot0._round > 0
end

function slot0.enemySettle(slot0)
end

slot1 = "\n"

function slot0.getTotalPlayerSettle(slot0)
	slot1 = 0
	slot2 = 0

	if slot0._playerTempDamages ~= nil then
		for slot6 = 1, #slot0._playerTempDamages do
			slot1 = slot1 + slot0._playerTempDamages[slot6] * (1 + slot0._lineEliminateRate * (slot6 - 1))

			if isDebugBuild then
				uv0 = uv0 .. "消除第 " .. slot6 .. " 次 连消伤害：" .. slot8 .. " = " .. slot0._playerTempDamages[slot6] .. " * " .. slot7 .. "\n"
			end
		end
	end

	if slot0._playerTempHps ~= nil then
		for slot6 = 1, #slot0._playerTempHps do
			slot2 = slot2 + slot0._playerTempHps[slot6]
		end
	end

	if isDebugBuild then
		uv0 = uv0 .. "消除伤害总值：" .. math.floor(slot1) .. "\n"

		logNormal(uv0)

		uv0 = "\n"

		logNormal("消除治疗总值：" .. math.floor(slot2))
	end

	return math.floor(slot1), math.floor(slot2)
end

function slot0.setLineEliminateRate(slot0, slot1)
	slot0._lineEliminateRate = slot1
end

function slot0.clearTempData(slot0)
	if slot0._playerTempDamages == nil or slot0._playerTempHps == nil then
		return
	end

	tabletool.clear(slot0._playerTempDamages)
	tabletool.clear(slot0._playerTempHps)
end

function slot0._playerSettle(slot0)
	slot1 = LocalEliminateChessModel.instance:getCurEliminateRecordData()

	return slot0._playerEntity:calDamage(slot1), slot0._playerEntity:calTreatment(slot1)
end

function slot0.playerSettle(slot0)
	uv0.instance:setCurGameStep(LengZhou6Enum.BattleStep.calHpBefore)

	slot1, slot2 = slot0:_playerSettle()

	uv0.instance:setCurGameStep(LengZhou6Enum.BattleStep.calHpAfter)

	if slot0._playerTempDamages == nil then
		slot0._playerTempDamages = {}
	end

	table.insert(slot0._playerTempDamages, slot1)

	if slot0._playerTempHps == nil then
		slot0._playerTempHps = {}
	end

	table.insert(slot0._playerTempHps, slot2)
end

function slot0.addBuffIdToEntity(slot0)
end

function slot0.setEnemySettleCount(slot0, slot1)
	slot0._enemySettleCount = slot1
end

function slot0.getEnemySettleCount(slot0)
	return slot0._enemySettleCount
end

function slot0.resetEnemySettleCount(slot0)
	slot0:setEnemySettleCount(1)
end

function slot0.triggerPlayerBuffOrSkill(slot0)
	if slot0._playerEntity then
		slot0._playerEntity:triggerBuffAndSkill()
	end

	if slot0._enemyEntity then
		slot0._enemyEntity:triggerBuffAndSkill()
	end
end

function slot0.setCurGameStep(slot0, slot1)
	slot0._curGameStep = slot1

	slot0:triggerPlayerBuffOrSkill()
end

function slot0.getCurGameStep(slot0)
	return slot0._curGameStep
end

function slot0.getCurEliminateSpEliminateCount(slot0, slot1)
	slot4 = 0

	for slot8, slot9 in pairs(LocalEliminateChessModel.instance:getCurEliminateRecordData():getEliminateTypeMap()) do
		if slot8 == slot1 then
			for slot13 = 1, #slot9 do
				if slot9[slot13].spEliminateCount ~= nil then
					slot4 = slot4 + slot15
				end
			end
		end
	end

	return slot4
end

function slot0.clear(slot0)
	slot0._endLessModelLayer = nil
	slot0._isFirstEnterLayer = true
	slot0._episodeConfig = nil
	slot0._playerEntity = nil
	slot0._enemyEntity = nil
	slot0._round = 0
	slot0._enemySettleCount = 1
	slot0._playerTempDamages = nil
	slot0._playerTempHps = nil
	slot0._recordServerData = nil
	slot0._recordLayerId = nil
	slot0._playerSelectSkillIds = nil

	LengZhou6Config.instance:clearLevelCache()
end

function slot0.setEndLessModelLayer(slot0, slot1)
	slot0._endLessModelLayer = slot1
end

function slot0.getEndLessModelLayer(slot0)
	return slot0._endLessModelLayer or 1
end

function slot0.setEndLessBattleProgress(slot0, slot1)
	slot0._endlessBattleProgress = slot1

	LengZhou6GameController.instance:dispatchEvent(LengZhou6Event.OnEndlessChangeSelectState)
end

function slot0.getEndLessBattleProgress(slot0)
	return slot0._endlessBattleProgress
end

function slot0.calEnemyId(slot0)
	if (slot0:getEndLessModelLayer() or 1) <= LengZhou6Config.instance:getEliminateBattleCost(9) then
		if LengZhou6Config.instance:getEnemyRandomIdsConfig(slot1) then
			slot4 = slot3[math.random(1, #slot3)]

			LengZhou6Config.instance:setSelectEnemyRandomId(slot1, slot4)

			return slot4
		else
			return LengZhou6Enum.defaultEnemy
		end
	end

	slot3 = slot1 - slot2

	if slot0._recordLayerId == nil then
		slot0._recordLayerId = {}
	end

	if slot0._recordLayerId[math.ceil(slot3 / 5)] == nil and string.splitToNumber(LengZhou6Config.instance:getEliminateBattleCostStr(16), "#") then
		slot0._recordLayerId[slot4] = slot6[math.random(1, #slot6)]
	end

	return slot0._recordLayerId[slot4]
end

function slot0.initSelectSkillId(slot0)
	if slot0._playerSelectSkillIds == nil then
		slot0._playerSelectSkillIds = {}
	end
end

function slot0.getSelectSkillIdList(slot0)
	slot1 = {}

	if slot0._playerSelectSkillIds ~= nil then
		for slot5, slot6 in pairs(slot0._playerSelectSkillIds) do
			table.insert(slot1, slot6)
		end
	end

	return slot1
end

function slot0.getSelectSkillId(slot0)
	return slot0._playerSelectSkillIds
end

function slot0.isSelectSkill(slot0, slot1)
	if slot0._playerSelectSkillIds == nil then
		return false
	end

	for slot5, slot6 in pairs(slot0._playerSelectSkillIds) do
		if slot6 == slot1 then
			return true
		end
	end

	return false
end

function slot0.resetSelectSkillId(slot0)
	if slot0._playerSelectSkillIds then
		tabletool.clear(slot0._playerSelectSkillIds)
	end
end

function slot0.setPlayerSelectSkillId(slot0, slot1, slot2)
	if slot0._playerSelectSkillIds == nil then
		slot0._playerSelectSkillIds = {}
	end

	slot0._playerSelectSkillIds[slot1] = slot2
end

function slot0.calRound(slot0)
	slot2 = slot0:getEndLessModelLayer() or 1

	if slot0:getBattleModel() == LengZhou6Enum.BattleModel.normal or slot2 == 0 then
		return slot0._round
	end

	if slot2 - 1 ~= 0 then
		slot3 = (slot0._round or 0) + (slot7 % LengZhou6Config.instance:getEliminateBattleCost(8) == 0 and LengZhou6Config.instance:getEliminateBattleCost(7) or LengZhou6Config.instance:getEliminateBattleCost(6))
	end

	return slot3
end

function slot0.getSkillEffectUp(slot0, slot1)
	if slot0:getBattleModel() == LengZhou6Enum.BattleModel.normal or (slot0:getEndLessModelLayer() or 1) == 0 then
		return 0
	end

	return LengZhou6Config.instance:getEliminateBattleEndlessMode(math.min(slot0:getEndLessModelLayer() or 1, LengZhou6Config.instance:getEliminateBattleCost(9))) and slot5[slot1] or 0
end

function slot0.calEnemyHpUp(slot0)
	slot2 = slot0:getEndLessModelLayer() or 1

	if slot0:getBattleModel() == LengZhou6Enum.BattleModel.normal or slot2 == 0 then
		return 0
	end

	slot3 = LengZhou6Config.instance:getEliminateBattleCost(9)

	if slot2 > 0 and slot2 <= slot3 then
		return LengZhou6Config.instance:getEliminateBattleEndlessMode(slot2).hp
	end

	for slot11 = 1, slot2 - slot3 do
		slot5 = LengZhou6Config.instance:getEliminateBattleEndlessMode(slot3).hp + (slot11 % 5 == 0 and LengZhou6Config.instance:getEliminateBattleCost(11) or LengZhou6Config.instance:getEliminateBattleCost(10))
	end

	return slot5
end

function slot0.enterNextLayer(slot0)
	if slot0._playerEntity then
		slot0._playerEntity:resetData(uv0.instance:getSelectSkillIdList())
	end

	slot1 = slot0:getEndLessModelLayer()

	if slot0._isFirstEnterLayer then
		slot0:setEndLessModelLayer(LengZhou6Enum.DefaultEndLessBeginRound)

		slot0._isFirstEnterLayer = false
	else
		LocalEliminateChessModel.instance:createInitMoveState()
		slot0:setEndLessModelLayer(slot1 + 1)
		slot0:_initEnemyByConfig(slot0._episodeConfig)
	end

	if slot0:getBattleModel() == LengZhou6Enum.BattleModel.infinite then
		slot0._round = slot0:calRound()
	end

	slot0:setCurGameStep(LengZhou6Enum.BattleStep.gameBegin)
	uv0.instance:setEndLessBattleProgress(LengZhou6Enum.BattleProgress.selectFinish)
end

function slot0.recordChessData(slot0)
	slot1 = LocalEliminateChessModel.instance:getInitData()

	if slot0._recordServerData and slot1 ~= nil then
		slot0._recordServerData:record(slot1)
	end
end

function slot0.canSelectSkill(slot0)
	if uv0.instance:getEndLessModelLayer() % LengZhou6Enum.EndLessChangeSkillLayer == 0 then
		return true
	end

	return false
end

function slot0.isFirstEnterLayer(slot0)
	return slot0._isFirstEnterLayer
end

slot0.instance = slot0.New()

return slot0
