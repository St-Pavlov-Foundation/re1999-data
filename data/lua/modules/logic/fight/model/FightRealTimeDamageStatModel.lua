-- chunkname: @modules/logic/fight/model/FightRealTimeDamageStatModel.lua

module("modules.logic.fight.model.FightRealTimeDamageStatModel", package.seeall)

local FightRealTimeDamageStatModel = class("FightRealTimeDamageStatModel")

function FightRealTimeDamageStatModel:ctor()
	self._eventsRegisted = false

	self:clearStat()
end

function FightRealTimeDamageStatModel:onFightStart()
	self:_unregisterEvents()
	self:clearStat()

	self._isEnable = nil

	if not self:isEnabled() then
		return
	end

	self:_ensureRegistEvents()
end

function FightRealTimeDamageStatModel:isEnabled()
	if self._isEnable == nil then
		if GameFacade.isKOLTest() or isDebugBuild then
			local fieldMgr = FightDataHelper.fieldMgr

			self._isEnable = fieldMgr ~= nil and fieldMgr:isStandardFight()
		else
			self._isEnable = false
		end
	end

	return self._isEnable ~= nil and self._isEnable or false
end

function FightRealTimeDamageStatModel:_unregisterEvents()
	if not self._eventsRegisted then
		return
	end

	FightController.instance:unregisterCallback(FightEvent.OnGMDamageChange, self._onDamageTotal, self)
	FightController.instance:unregisterCallback(FightEvent.RespBeginFight, self._onRespBeginFight, self)
	FightController.instance:unregisterCallback(FightEvent.OnPlayHandCard, self._onPlayHandCard, self)
	FightController.instance:unregisterCallback(FightEvent.FightRoundEnd, self._onFightRoundEnd, self)
	FightController.instance:unregisterCallback(FightEvent.OnRoundSequenceStart, self._onRoundSequenceStart, self)

	self._eventsRegisted = false
end

function FightRealTimeDamageStatModel:_ensureRegistEvents()
	self:_unregisterEvents()
	FightController.instance:registerCallback(FightEvent.OnGMDamageChange, self._onDamageTotal, self)
	FightController.instance:registerCallback(FightEvent.RespBeginFight, self._onRespBeginFight, self)
	FightController.instance:registerCallback(FightEvent.OnPlayHandCard, self._onPlayHandCard, self)
	FightController.instance:registerCallback(FightEvent.FightRoundEnd, self._onFightRoundEnd, self)
	FightController.instance:registerCallback(FightEvent.OnRoundSequenceStart, self._onRoundSequenceStart, self)

	self._eventsRegisted = true
end

function FightRealTimeDamageStatModel:clearStat()
	self._id2Damage = {}
	self._records = {}
	self._myId2Damage = {}
	self._myRoundId2Damage = {}
	self._myRoundTotal = {}
	self._damageRound = nil
	self._serverRoundIndex = 0
	self._serverMyRoundId2Damage = {}
	self._entityId2Side = {}
	self._curRoundPlayRecords = {}
	self._playHistory = {}
end

function FightRealTimeDamageStatModel:_onRespBeginFight()
	self:clearStat()
	self:_cacheEntitySides()
end

function FightRealTimeDamageStatModel:_cacheEntitySides()
	local entityMgr = FightDataHelper.entityMgr

	if not entityMgr then
		return
	end

	for _, entityMO in ipairs(entityMgr:getAllEntityList(nil, true)) do
		self._entityId2Side[entityMO.uid] = entityMO.side

		if entityMO.side == FightEnum.EntitySide.MySide then
			self._myId2Damage[entityMO.uid] = self._myId2Damage[entityMO.uid] or 0
		end
	end
end

function FightRealTimeDamageStatModel:_getEntitySide(entityId, entity)
	if not entityId then
		return
	end

	local entityMgr = FightDataHelper.entityMgr
	local entityMO = entityMgr and entityMgr:getById(entityId)
	local side = entityMO and entityMO.side or self._entityId2Side[entityId] or entity and entity:getSide()

	if side ~= nil then
		self._entityId2Side[entityId] = side

		return side
	end

	return self._entityId2Side[entityId]
end

function FightRealTimeDamageStatModel:_isEnemyDamage(fromId, targetId, defender)
	local fromSide = self:_getEntitySide(fromId)
	local targetSide = self:_getEntitySide(targetId, defender)

	if not fromId or not targetId or fromId == targetId then
		return false
	end

	local mySide = FightEnum.EntitySide.MySide
	local enemySide = FightEnum.EntitySide.EnemySide

	return fromSide == mySide and targetSide == enemySide or fromSide == enemySide and targetSide == mySide
end

function FightRealTimeDamageStatModel:_onDamageTotal(fightStepData, defender, damage, isLastHit, targetId)
	if not self:isEnabled() then
		return
	end

	if not fightStepData or not fightStepData.fromId or not damage or damage <= 0 then
		return
	end

	local fromId = fightStepData.fromId

	targetId = targetId or defender and defender.id

	local isMySide = self:_getEntitySide(fromId) == FightEnum.EntitySide.MySide
	local isOutputDamage = self:_isEnemyDamage(fromId, targetId, defender)
	local round = self._damageRound or self:getCurRoundId()
	local totalDamage = self._id2Damage[fromId] or 0

	if isOutputDamage then
		totalDamage = totalDamage + damage
		self._id2Damage[fromId] = totalDamage
	end

	local record = {
		fromId = fromId,
		targetId = targetId,
		actId = fightStepData.actId,
		cardIndex = fightStepData.cardIndex,
		round = round,
		isMySide = isMySide,
		isOutputDamage = isOutputDamage,
		damage = damage
	}

	if isMySide and isOutputDamage then
		self._myId2Damage[fromId] = (self._myId2Damage[fromId] or 0) + damage

		local roundDict = self._myRoundId2Damage[round]

		if not roundDict then
			roundDict = {}
			self._myRoundId2Damage[round] = roundDict
		end

		roundDict[fromId] = (roundDict[fromId] or 0) + damage
		self._myRoundTotal[round] = (self._myRoundTotal[round] or 0) + damage
	end

	table.insert(self._records, record)
	FightController.instance:dispatchEvent(FightEvent.OnRealTimeDamageChange, fromId, totalDamage, record)
end

function FightRealTimeDamageStatModel:getDamageByEntityId(entityId)
	return self._id2Damage[entityId] or 0
end

function FightRealTimeDamageStatModel:getId2Damage()
	return self._id2Damage
end

function FightRealTimeDamageStatModel:getRecords()
	return self._records
end

function FightRealTimeDamageStatModel:getCurRoundId()
	return FightModel.instance and FightModel.instance:getCurRoundId() or 0
end

function FightRealTimeDamageStatModel:getMySideId2Damage()
	return self._myId2Damage
end

function FightRealTimeDamageStatModel:getMySideTotalDamageByEntityId(entityId)
	return self._myId2Damage[entityId] or 0
end

function FightRealTimeDamageStatModel:getMySideTotalDamage()
	local total = 0

	for _, damage in pairs(self._myId2Damage) do
		total = total + damage
	end

	return total
end

function FightRealTimeDamageStatModel:getMySideRoundDamageByEntityId(entityId, round)
	round = round or self:getCurRoundId()

	local roundDict = self._myRoundId2Damage[round]

	return roundDict and roundDict[entityId] or 0
end

function FightRealTimeDamageStatModel:getMySideRoundTotalDamage(round)
	round = round or self:getCurRoundId()

	return self._myRoundTotal[round] or 0
end

function FightRealTimeDamageStatModel:getMySideDamagePercent(entityId)
	local total = self:getMySideTotalDamage()

	if total <= 0 then
		return 0
	end

	return (self._myId2Damage[entityId] or 0) / total * 100
end

function FightRealTimeDamageStatModel:getDamageExportData()
	if not isDebugBuild then
		return
	end

	if next(self._id2Damage) == nil and next(self._myId2Damage) == nil and next(self._myRoundId2Damage) == nil and #self._records == 0 then
		return
	end

	local function copyDamageMap(source)
		local result = {}

		for key, value in pairs(source) do
			result[tostring(key)] = type(value) == "table" and copyDamageMap(value) or value
		end

		return result
	end

	local fieldMgr = FightDataHelper.fieldMgr
	local data = {
		damageScope = "仅敌对阵营之间的伤害；自伤、同队及阵营未知的伤害不计入聚合。",
		formatVersion = 1,
		recordsNote = "records 为原始跳字流水，未应用回合校正；聚合数据包含已执行的校正，不保证流水求和等于聚合值或 FightStatistics.harm。",
		damageBasis = "hurtInfo.damage",
		exportedAt = os.date("%Y-%m-%d %H:%M:%S"),
		battleId = fieldMgr and fieldMgr.battleId and tostring(fieldMgr.battleId) or nil,
		episodeId = fieldMgr and fieldMgr.episodeId and tostring(fieldMgr.episodeId) or nil,
		currentRound = self:getCurRoundId(),
		damageRound = self._damageRound,
		id2Damage = copyDamageMap(self._id2Damage),
		mySideId2Damage = copyDamageMap(self._myId2Damage),
		mySideTotalDamage = self:getMySideTotalDamage(),
		mySideDamagePercent = {},
		mySideRoundId2Damage = copyDamageMap(self._myRoundId2Damage),
		mySideRoundTotal = copyDamageMap(self._myRoundTotal),
		serverRoundIndex = self._serverRoundIndex,
		serverMySideRoundId2Damage = copyDamageMap(self._serverMyRoundId2Damage),
		records = {}
	}

	for entityId in pairs(self._myId2Damage) do
		data.mySideDamagePercent[tostring(entityId)] = self:getMySideDamagePercent(entityId)
	end

	for index, record in ipairs(self._records) do
		data.records[index] = {
			fromId = record.fromId and tostring(record.fromId) or nil,
			targetId = record.targetId and tostring(record.targetId) or nil,
			actId = record.actId,
			cardIndex = record.cardIndex,
			round = record.round,
			isMySide = record.isMySide,
			isOutputDamage = record.isOutputDamage,
			damage = record.damage
		}
	end

	return data
end

function FightRealTimeDamageStatModel:_onRoundSequenceStart()
	if not self:isEnabled() then
		return
	end

	self._damageRound = self:getCurRoundId()

	self:_cacheEntitySides()
end

function FightRealTimeDamageStatModel:_collectServerDamage(stepList, id2Damage)
	for _, step in ipairs(stepList or {}) do
		for _, effect in ipairs(step.actEffect or {}) do
			if effect.fightStep then
				self:_collectServerDamage({
					effect.fightStep
				}, id2Damage)
			end

			local hurtInfo = effect.hurtInfo
			local damage = hurtInfo and hurtInfo.damage

			if damage and damage > 0 then
				local fromId = hurtInfo.fromUid

				if not fromId or fromId == "0" or fromId == 0 or fromId == "" then
					fromId = step.fromId
				end

				if self:_getEntitySide(fromId) == FightEnum.EntitySide.MySide and self:_isEnemyDamage(fromId, effect.targetId) then
					id2Damage[fromId] = (id2Damage[fromId] or 0) + damage
				end
			end
		end
	end
end

function FightRealTimeDamageStatModel:_correctRoundDamage(round)
	if not self:isEnabled() then
		return
	end

	local roundMgr = FightDataHelper.roundMgr
	local history = roundMgr and roundMgr:getAllOriginRoundData()
	local count = history and #history or 0

	if count <= self._serverRoundIndex then
		return
	end

	for index = self._serverRoundIndex + 1, count do
		if not history[index].fightStep then
			return
		end
	end

	local serverDamage = self._serverMyRoundId2Damage[round] or {}

	self._serverMyRoundId2Damage[round] = serverDamage

	local previous = history[self._serverRoundIndex]

	if previous then
		self:_collectServerDamage(previous.nextRoundBeginStep, serverDamage)
	end

	for index = self._serverRoundIndex + 1, count do
		local data = history[index]

		self:_collectServerDamage(data.fightStep, serverDamage)

		if index < count then
			self:_collectServerDamage(data.nextRoundBeginStep, serverDamage)
		end
	end

	self._serverRoundIndex = count

	local roundDamage = self._myRoundId2Damage[round] or {}

	for entityId in pairs(roundDamage) do
		if serverDamage[entityId] == nil then
			serverDamage[entityId] = 0
		end
	end

	local total = 0

	for entityId, damage in pairs(serverDamage) do
		local delta = damage - (roundDamage[entityId] or 0)

		self._myId2Damage[entityId] = (self._myId2Damage[entityId] or 0) + delta
		self._id2Damage[entityId] = (self._id2Damage[entityId] or 0) + delta
		roundDamage[entityId] = damage
		total = total + damage
	end

	self._myRoundId2Damage[round] = roundDamage
	self._myRoundTotal[round] = total

	FightController.instance:dispatchEvent(FightEvent.OnRealTimeDamageChange, nil, nil, {
		isCorrection = true,
		round = round
	})
end

function FightRealTimeDamageStatModel:_onPlayHandCard(card_mo)
	if not self:isEnabled() then
		return
	end

	if not card_mo or not card_mo.uid or not card_mo.skillId then
		return
	end

	table.insert(self._curRoundPlayRecords, {
		uid = card_mo.uid,
		heroId = card_mo.heroId,
		skillId = card_mo.skillId,
		targetUid = card_mo.targetUid,
		cardType = card_mo.cardType
	})
end

function FightRealTimeDamageStatModel:_onFightRoundEnd()
	if not self:isEnabled() then
		return
	end

	local round = self:getCurRoundId() - 1

	self._playHistory[round] = self._curRoundPlayRecords
	self._curRoundPlayRecords = {}

	if self._damageRound ~= nil then
		self:_correctRoundDamage(self._damageRound)

		self._damageRound = nil
	end
end

function FightRealTimeDamageStatModel:getCurRoundPlayRecords()
	return self._curRoundPlayRecords
end

function FightRealTimeDamageStatModel:getRoundPlayRecords(round)
	round = round or self:getCurRoundId() - 1

	return self._playHistory[round] or {}
end

function FightRealTimeDamageStatModel:getAllRoundPlayRecords()
	return self._playHistory
end

FightRealTimeDamageStatModel.instance = FightRealTimeDamageStatModel.New()

return FightRealTimeDamageStatModel
