-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/model/game/ArcadeSurvivorGameModel.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.model.game.ArcadeSurvivorGameModel", package.seeall)

local ArcadeSurvivorGameModel = class("ArcadeSurvivorGameModel", BaseModel)

function ArcadeSurvivorGameModel:onInit()
	self._gridModel = BaseModel.New()
	self._ruleModel = ArcadeSurvivorGameRuleModel.New()

	self:clearAllData()
end

function ArcadeSurvivorGameModel:reInit()
	self:clearAllData()
end

function ArcadeSurvivorGameModel:clearAllData()
	self._pendingGameStart = nil

	self:setGameIsEnd()
	self:setDifficulty()
	self:setCurStageIndex()
	self:setCurLevelIndex()
	self:setRestartShopStatus()
	self:setRestartOpenEventSelect()
	self:setIsPlayerTurn()
	self:clearAllEntityMO(true)
	math.randomseed(os.time())

	self._genUid = 0
	self._mapSizeX = 0
	self._mapSizeY = 0
	self._viewSizeX = 0
	self._viewSizeY = 0
	self._waveIndex2ExtraAddDict = {}
	self._curRound = 0
	self._totalRound = 0
	self._curMonsterGroupId = nil
	self._shopRefreshBaseCount = 0
	self._lockGoodsDict = {}
	self._stopSourceDict = {}
	self._unlockCharacterDict = {}
	self._unlockHandBookDict = {}
	self._currencyDict = {}
	self._eventIdList = {}
	self._monsterExtraSkillDict = {}
	self._resultStatisticsDict = {}
	self._curLevelScore = 0
	self._levelScoreList = {}
	self._levelScoreCommitted = false
	self._roundKillCount = 0
	self._roundHitTargetCount = 0
	self._roundIsHurt = false
	self._roundScoreCalculated = false
	self._consecutiveUnhurtRounds = 0
	self._entity2GridDict = {}
	self._grid2EntityDict = {}

	self:_clearDelayHitData()
	self._gridModel:clear()
	self._ruleModel:clear()
end

function ArcadeSurvivorGameModel:_clearDelayHitData()
	self._delayHitRecordHead = nil
	self._delayHitRecordTail = nil
	self._delayHitRecordPrevDict = {}
	self._delayHitRecordNextDict = {}
	self._delayHitActiveRecordDict = {}
	self._grid2DelayHitRecord = {}
	self._delayHitGridIndexByRecordDict = {}
	self._delayHitWaitCountByCasterSkillDict = {}
end

function ArcadeSurvivorGameModel:onEnterGame()
	local talentAddCoin, talentAddShopRefresh = self:_initCharacterMO()

	self._ruleModel:rebuildFromCharacter()
	self:_initMonsterExtraSkill()
	self:setGameIsEnd(false)

	self._curLevelScore = 0
	self._levelScoreList = {}
	self._levelScoreCommitted = false

	local difficulty = self:getDifficulty()

	if difficulty then
		local startShopRefresh = ArcadeSurvivorConfig.instance:getDifficultyStartShopRefresh(difficulty)

		self:setShopRefreshBaseCount(startShopRefresh + talentAddShopRefresh)

		local startCoin = ArcadeSurvivorConfig.instance:getDifficultyStartCoin(difficulty)

		self:changeCurrencyCount(ArcadeSurvivorEnum.Currency.Coin, startCoin + talentAddCoin, false)
	end

	self._pendingGameStart = true
end

function ArcadeSurvivorGameModel:triggerGameStart()
	if not self._pendingGameStart then
		return
	end

	self._pendingGameStart = nil

	local triggerPoint = ArcadeSurvivorGameEnum.TriggerPoint.GameStart
	local context = ArcadeSurvivorGameTriggerContext.New(triggerPoint, nil, self:getCharacterMO())

	ArcadeSurvivorGameTriggerController.instance:trigger(triggerPoint, nil, context)
end

function ArcadeSurvivorGameModel:_initMonsterExtraSkill()
	local difficulty = self:getDifficulty()

	if difficulty then
		local skillIdList = ArcadeSurvivorConfig.instance:getDifficultyMonsterAddSkillIdList(difficulty)

		for _, skillId in ipairs(skillIdList) do
			self:addMonsterExtraSkill(skillId)
		end
	end

	local characterMO = self:getCharacterMO()
	local characterId = characterMO and characterMO:getId()

	if not characterId then
		return
	end

	local weaponCollectionId = ArcadeSurvivorConfig.instance:getCharacterWeaponCollectionId(characterId)
	local weaponMonsterExtraSkills = ArcadeSurvivorConfig.instance:getCollectionMonsterAddSkillIdList(weaponCollectionId)

	for _, skillId in ipairs(weaponMonsterExtraSkills) do
		self:addMonsterExtraSkill(skillId)
	end

	local collectionId = ArcadeSurvivorConfig.instance:getCharacterCollectionId(characterId)
	local collectionMonsterExtraSkills = ArcadeSurvivorConfig.instance:getCollectionMonsterAddSkillIdList(collectionId)

	for _, skillId in ipairs(collectionMonsterExtraSkills) do
		self:addMonsterExtraSkill(skillId)
	end
end

function ArcadeSurvivorGameModel:_initCharacterMO()
	local talentAddCoin = 0
	local talentAddShopRefresh = 0
	local entityType = ArcadeSurvivorEnum.EntityType.Character
	local uid = ArcadeSurvivorGameEnum.Const.CharacterUid
	local id = ArcadeSurvivorHeroModel.instance:getEquipHeroId()

	self._gameCharacterMO = ArcadeSurvivorGameCharacterMO.New(entityType, id, uid)

	local difficultySkills = ArcadeSurvivorConfig.instance:getDifficultyAddSkill(self:getDifficulty())

	for _, skillId in ipairs(difficultySkills) do
		self._gameCharacterMO:addSkill(skillId)
	end

	local talentMOList = ArcadeSurvivorHeroModel.instance:getTalentMOList()

	for _, talentMO in ipairs(talentMOList) do
		local talentLevel = talentMO:getLevel()
		local skillIdList = talentMO:getSkillIdsByLevel(talentLevel)

		if skillIdList then
			for _, skillId in ipairs(skillIdList) do
				self._gameCharacterMO:addSkill(skillId)
			end
		end

		if talentLevel > 0 then
			local talentAddCoinCfg = ArcadeSurvivorConfig.instance:getTalentAddCoin(talentMO.id, talentLevel)
			local talentAddShopRefreshCfg = ArcadeSurvivorConfig.instance:getTalentAddShopRefresh(talentMO.id, talentLevel)

			talentAddCoin = talentAddCoin + talentAddCoinCfg
			talentAddShopRefresh = talentAddShopRefresh + talentAddShopRefreshCfg
		end
	end

	local typeDict = GameUtil.tabletool_checkDictTable(self._moDict, entityType)
	local typeList = GameUtil.tabletool_checkDictTable(self._moList, entityType)

	typeDict[uid] = self._gameCharacterMO
	typeList[#typeList + 1] = self._gameCharacterMO

	return talentAddCoin, talentAddShopRefresh
end

function ArcadeSurvivorGameModel:onResetGame()
	local difficulty = self:getDifficulty()

	self:clearAllData()
	self:setDifficulty(difficulty)
	self:onEnterGame()
end

function ArcadeSurvivorGameModel:onEnterNextLevelOrStage()
	local characterMO = self:getCharacterMO()

	if not characterMO then
		return
	end

	characterMO:clearSkillTriggerCounts()

	local buffSet = characterMO and characterMO:getBuffSet()
	local buffList = buffSet and buffSet:getBuffList()

	if not buffList then
		return
	end

	for i = #buffList, 1, -1 do
		local buff = buffList[i]

		if buff then
			local buffId = buff:getId()
			local levelKeep = ArcadeSurvivorConfig.instance:getBuffLevelKeep(buffId)

			if not levelKeep then
				characterMO:removeBuff(buffId)
			end
		end
	end
end

function ArcadeSurvivorGameModel:onRestartGame(serverInfo)
	self:_setRestartGameData(serverInfo.prop, serverInfo.extendInfo)

	local player = serverInfo.player
	local collectionContainer = serverInfo.collectionContainer

	self:_setRestartCharacterData(player, serverInfo.attrContainer, serverInfo.skillContainer, collectionContainer)
	self:_setRestartMonsterExtraSkillData(player, collectionContainer)
	self:_setRestartRuleModelData(serverInfo.prop)
	self:setGameIsEnd(false)
end

function ArcadeSurvivorGameModel:_parseLevelScoreList(strVal)
	self._curLevelScore = 0
	self._levelScoreList = {}
	self._levelScoreCommitted = false

	if string.nilorempty(strVal) then
		return
	end

	if not string.find(strVal, "#", 1, true) then
		self._levelScoreList[1] = tonumber(strVal) or 0

		return
	end

	for _, score in ipairs(string.splitToNumber(strVal, "#")) do
		self._levelScoreList[#self._levelScoreList + 1] = score
	end
end

function ArcadeSurvivorGameModel:_setRestartGameData(propInfo, extendInfo)
	self:setCurStageIndex(propInfo.stageIndex)
	self:setCurLevelIndex(propInfo.LevelIndex)

	self._curRound = propInfo.round

	for _, mapEntry in ipairs(propInfo.customMap) do
		local key = mapEntry.key
		local val = mapEntry.val

		if key == ArcadeSurvivorGameEnum.CustomSaveInfoKey.ShopStatus then
			self:setRestartShopStatus(val)
		elseif key == ArcadeSurvivorGameEnum.CustomSaveInfoKey.OpenEventSelect then
			self:setRestartOpenEventSelect(val == ArcadeSurvivorGameEnum.Const.CustomSaveEnableVal)
		elseif key == ArcadeSurvivorGameEnum.CustomSaveInfoKey.SelectEvent then
			if not string.nilorempty(val) then
				self._eventIdList = string.splitToNumber(val, "#")
			end
		elseif key == ArcadeSurvivorGameEnum.CustomSaveInfoKey.TotalScore then
			self:_parseLevelScoreList(val)
		elseif key == ArcadeSurvivorGameEnum.CustomSaveInfoKey.ShopRefreshCount then
			self:setShopRefreshBaseCount(tonumber(val) or 0)
		elseif key == ArcadeSurvivorGameEnum.CustomSaveInfoKey.LockGoodsDict then
			self:_setRestartLockGoodsSaveStr(val)
		elseif ArcadeSurvivorGameEnum.CustomSaveResultStatisticsKeyDict[key] then
			self:addResultStatistics(key, tonumber(val))
		end
	end

	for _, book in ipairs(extendInfo.addedBook.books) do
		local type = book.type

		for _, id in ipairs(book.eleId) do
			self:addUnlockHandBookItem(type, id)
		end
	end

	for _, characterId in ipairs(extendInfo.unlockRoleIds) do
		self:addUnlockCharacter(characterId)
	end

	for _, currency in ipairs(extendInfo.currency) do
		self:changeCurrencyCount(currency.id, currency.count, false)
	end
end

function ArcadeSurvivorGameModel:_setRestartCharacterData(playerInfo, attrInfo, skillInfo, collectionInfo)
	if not playerInfo then
		return
	end

	local entityType = ArcadeSurvivorEnum.EntityType.Character
	local uid = ArcadeSurvivorGameEnum.Const.CharacterUid
	local id = playerInfo.id

	self._gameCharacterMO = ArcadeSurvivorGameCharacterMO.New(entityType, id, uid, nil, nil, nil, nil, true)

	self._gameCharacterMO:setServerInfo(attrInfo, skillInfo, collectionInfo)

	local typeDict = GameUtil.tabletool_checkDictTable(self._moDict, entityType)
	local typeList = GameUtil.tabletool_checkDictTable(self._moList, entityType)

	typeDict[uid] = self._gameCharacterMO
	typeList[#typeList + 1] = self._gameCharacterMO
end

function ArcadeSurvivorGameModel:_setRestartMonsterExtraSkillData(playerInfo, collectionInfo)
	local difficulty = self:getDifficulty()

	if difficulty then
		local difficultyMonsterExtraSkills = ArcadeSurvivorConfig.instance:getDifficultyMonsterAddSkillIdList(difficulty)

		for _, skillId in ipairs(difficultyMonsterExtraSkills) do
			self:addMonsterExtraSkill(skillId)
		end
	end

	local characterId = playerInfo and playerInfo.id
	local weaponCollectionId = ArcadeSurvivorConfig.instance:getCharacterWeaponCollectionId(characterId)
	local weaponMonsterExtraSkills = ArcadeSurvivorConfig.instance:getCollectionMonsterAddSkillIdList(weaponCollectionId)

	for _, skillId in ipairs(weaponMonsterExtraSkills) do
		self:addMonsterExtraSkill(skillId)
	end

	if collectionInfo then
		for _, collection in ipairs(collectionInfo.collections) do
			local collectionId = collection.id
			local monsterExtraSkills = ArcadeSurvivorConfig.instance:getCollectionMonsterAddSkillIdList(collectionId)

			for _, skillId in ipairs(monsterExtraSkills) do
				self:addMonsterExtraSkill(skillId)
			end
		end
	end
end

function ArcadeSurvivorGameModel:_setRestartRuleModelData(propInfo)
	local ruleStateVal
	local customMap = propInfo and propInfo.customMap

	for _, mapEntry in ipairs(customMap) do
		local key = mapEntry.key

		if key == ArcadeSurvivorGameEnum.CustomSaveInfoKey.RuleStates then
			ruleStateVal = mapEntry.val

			break
		end
	end

	local stateDict = self:_parseRuleSaveStateDict(ruleStateVal)

	self._ruleModel:rebuildFromCharacter()
	self._ruleModel:rebuildFromEventIdList()
	self._ruleModel:restoreSourceStateDict(stateDict)
end

function ArcadeSurvivorGameModel:_parseRuleSaveStateDict(val)
	if string.nilorempty(val) then
		return {}
	end

	local isOk, stateData = pcall(cjson.decode, val)

	if not isOk or type(stateData) ~= "table" then
		return {}
	end

	local stateDict = {}
	local ruleStateList = stateData.rules or {}

	for _, ruleState in ipairs(ruleStateList) do
		local ruleId = tonumber(ruleState.ruleId)

		if ruleId then
			local sourceStateDict = {}
			local sourceStateList = ruleState.sources or {}

			for _, sourceState in ipairs(sourceStateList) do
				local sourceType = tonumber(sourceState.sourceType)
				local sourceId = tonumber(sourceState.sourceId)

				if not sourceType and sourceState.collectionId ~= nil then
					local collectionId = tonumber(sourceState.collectionId)

					if collectionId then
						sourceType = collectionId == 0 and ArcadeSurvivorGameEnum.RuleSourceType.Event or ArcadeSurvivorGameEnum.RuleSourceType.Collection
						sourceId = collectionId
					end
				end

				if sourceType and sourceId then
					local typeStateDict = sourceStateDict[sourceType]

					if not typeStateDict then
						typeStateDict = {}
						sourceStateDict[sourceType] = typeStateDict
					end

					typeStateDict[sourceId] = sourceState.state or {}
				end
			end

			stateDict[ruleId] = sourceStateDict
		end
	end

	return stateDict
end

function ArcadeSurvivorGameModel:_setRestartLockGoodsSaveStr(strVal)
	self._lockGoodsDict = {}

	if string.nilorempty(strVal) then
		return
	end

	local shopGroupList = GameUtil.splitString2(strVal, false, "|", "_")

	if not shopGroupList then
		return
	end

	for _, shopGroup in ipairs(shopGroupList) do
		local shopType = shopGroup[1]
		local strGoodsList = shopGroup[2]

		if shopType and not string.nilorempty(strGoodsList) then
			local goodsGroupList = GameUtil.splitString2(strGoodsList, false, "#", ":")

			if goodsGroupList then
				local goodsIdDict = {}

				for _, goodsGroup in ipairs(goodsGroupList) do
					local goodsId = tonumber(goodsGroup[1])
					local index = tonumber(goodsGroup[2])

					if goodsId and index and index > 0 then
						goodsIdDict[goodsId] = index
					end
				end

				self._lockGoodsDict[shopType] = goodsIdDict
			end
		end
	end
end

function ArcadeSurvivorGameModel:replaceCollection(collectionId, targetCollectionIdList)
	local characterMO = self:getCharacterMO()

	if not characterMO or not collectionId or not targetCollectionIdList then
		return
	end

	local collectionCount = characterMO:getCollectionCount(collectionId)

	self:removeCollection(collectionId, collectionCount)

	for _, targetCollectionId in ipairs(targetCollectionIdList) do
		self:addCollectionDirect(targetCollectionId)
	end
end

function ArcadeSurvivorGameModel:addCollectionDirect(collectionId)
	local characterMO = self:getCharacterMO()

	if not characterMO or not collectionId then
		return
	end

	characterMO:addCollection(collectionId)
end

function ArcadeSurvivorGameModel:removeCollection(collectionId, count)
	local characterMO = self:getCharacterMO()

	if not characterMO or not collectionId then
		return
	end

	local removeCount = count or characterMO:getCollectionCount(collectionId)
	local isRemoved = characterMO:removeCollection(collectionId, removeCount)

	if isRemoved then
		self._ruleModel:onCollectionRemoved(collectionId, removeCount)
	end
end

function ArcadeSurvivorGameModel:moveEntityMO(entityType, uid, targetGridX, targetGridY, isReturn)
	local entityMO = self:getEntityMO(entityType, uid)

	if not entityMO then
		return
	end

	if entityMO:getIsOffBoard() and not isReturn then
		return false
	end

	local oldGridX, oldGridY = entityMO:getGridPos()
	local sizeX, sizeY = entityMO:getSize()

	if not self:isCanPlaceEntity(entityType, uid, targetGridX, targetGridY, sizeX, sizeY) then
		return false
	end

	self:removeOccupyGrid(entityType, uid)
	entityMO:setGridPos(targetGridX, targetGridY)

	local entityMOType = entityMO:getEntityType()

	if entityMOType ~= ArcadeSurvivorEnum.EntityType.Character then
		local direction = ArcadeSurvivorGameHelper.getDirectionGridFromGrid(oldGridX, oldGridY, targetGridX, targetGridY, true)

		if direction then
			entityMO:setDirection(direction)
		end
	end

	self:setOccupyGrid(entityType, uid, targetGridX, targetGridY, sizeX, sizeY)

	if isReturn then
		entityMO:setOffBoard(false)
	end

	return true
end

function ArcadeSurvivorGameModel:isCanPlaceEntity(entityType, uid, gridX, gridY, sizeX, sizeY)
	if not entityType or not gridX or not gridY or not sizeX or not sizeY then
		return false
	end

	local isOutside = ArcadeSurvivorGameHelper.isOutsideMap(gridX, gridY, sizeX, sizeY)

	if isOutside then
		return false
	end

	local entityLayer = ArcadeSurvivorGameEnum.EntityType2Layer[entityType]

	for i = gridX, gridX + sizeX - 1 do
		for j = gridY, gridY + sizeY - 1 do
			local occupyEntityData = self:getEntityDataInGrid(i, j, entityLayer)

			if occupyEntityData then
				local occupyEntityType = occupyEntityData.entityType
				local occupyEntityUid = occupyEntityData.uid

				if entityType ~= occupyEntityType or uid ~= occupyEntityUid then
					return false
				end
			end
		end
	end

	return true
end

function ArcadeSurvivorGameModel:getNearestVacantPosition(mo, reservedAreas)
	local originX, originY = mo:getGridPos()
	local sizeX, sizeY = mo:getSize()
	local candidateRingIterator = ArcadeSurvivorGameHelper.iterateNearestPlacementCandidates(originX, originY, sizeX, sizeY)

	if not candidateRingIterator then
		return
	end

	for candidates in candidateRingIterator do
		local vacantCandidates = {}

		for _, candidate in ipairs(candidates) do
			if self:_isVacantCandidate(mo, candidate.x, candidate.y, reservedAreas, sizeX, sizeY) then
				vacantCandidates[#vacantCandidates + 1] = candidate
			end
		end

		local vacantCount = #vacantCandidates

		if vacantCount > 0 then
			local candidate = vacantCandidates[math.random(vacantCount)]

			return candidate.x, candidate.y
		end
	end
end

function ArcadeSurvivorGameModel:_isVacantCandidate(mo, x, y, reservedAreas, sizeX, sizeY)
	local entityType, uid = mo:getEntityType(), mo:getUid()

	if not self:isCanPlaceEntity(entityType, uid, x, y, sizeX, sizeY) then
		return false
	end

	for _, area in ipairs(reservedAreas) do
		if x < area.x + area.w and area.x < x + sizeX and y < area.y + area.h and area.y < y + sizeY then
			return false
		end
	end

	return true
end

function ArcadeSurvivorGameModel:_generateUid()
	self._genUid = self._genUid + 1

	return self._genUid
end

function ArcadeSurvivorGameModel:addEntityMOByList(dataList)
	if not dataList or #dataList <= 0 then
		return
	end

	local resultList = {}

	for _, moData in ipairs(dataList) do
		local entityType = moData.entityType
		local id = moData.id
		local gridX = moData.x
		local gridY = moData.y
		local sizeX = moData.sizeX
		local sizeY = moData.sizeY
		local mo = self:addEntityMO(entityType, id, gridX, gridY, sizeX, sizeY)

		if mo then
			resultList[#resultList + 1] = mo
		end
	end

	return resultList
end

function ArcadeSurvivorGameModel:addEntityMO(entityType, id, gridX, gridY, sizeX, sizeY, ...)
	local cfg = ArcadeSurvivorHelper.getEntityCfg(entityType, id)

	if not cfg then
		return
	end

	local isCanPlace = self:isCanPlaceEntity(entityType, nil, gridX, gridY, sizeX, sizeY)

	if not isCanPlace then
		return
	end

	local moCls = ArcadeSurvivorGameEnum.EntityTypeMOCls[entityType]

	if not moCls then
		logError(string.format("ArcadeSurvivorGameModel:addEntityMO error, entityType:%s no moCls define", entityType))

		return
	end

	local uid = self:_generateUid()
	local mo = moCls.New(entityType, id, uid, gridX, gridY, sizeX, sizeY, ...)
	local typeDict = GameUtil.tabletool_checkDictTable(self._moDict, entityType)
	local typeList = GameUtil.tabletool_checkDictTable(self._moList, entityType)

	typeDict[uid] = mo
	typeList[#typeList + 1] = mo

	local handBookType = ArcadeSurvivorHallEnum.EntityType2HandBookType[entityType]

	if handBookType then
		self:addUnlockHandBookItem(handBookType, id)
	end

	self:setOccupyGrid(entityType, uid, gridX, gridY, sizeX, sizeY)

	return mo
end

function ArcadeSurvivorGameModel:setOccupyGrid(entityType, uid, gridX, gridY, sizeX, sizeY)
	if not gridX or not gridY or not sizeX or not sizeY then
		return
	end

	local entityLayer = entityType and ArcadeSurvivorGameEnum.EntityType2Layer[entityType]

	if not entityLayer then
		return
	end

	local occupyGridDict = {}
	local occupyData = {
		entityType = entityType,
		uid = uid
	}
	local layerGridDict = GameUtil.tabletool_checkDictTable(self._grid2EntityDict, entityLayer)

	for i = gridX, gridX + sizeX - 1 do
		for j = gridY, gridY + sizeY - 1 do
			local occupyGridId = ArcadeSurvivorGameHelper.getGridId(i, j)

			occupyGridDict[occupyGridId] = true
			layerGridDict[occupyGridId] = occupyData
		end
	end

	if self._entity2GridDict then
		local entityDict = GameUtil.tabletool_checkDictTable(self._entity2GridDict, entityType)

		entityDict[uid] = occupyGridDict
	end
end

function ArcadeSurvivorGameModel:removeEntityMO(entityType, targetUid)
	if not entityType or not targetUid then
		return
	end

	self:removeOccupyGrid(entityType, targetUid)

	local dict = self._moDict[entityType]

	if dict then
		local mo = dict[targetUid]

		if mo then
			mo:setDead(true)
		end

		dict[targetUid] = nil
	end

	local list = self._moList[entityType]

	if list then
		for i, mo in ipairs(list) do
			local uid = mo:getUid()

			if uid == targetUid then
				table.remove(list, i)

				break
			end
		end
	end

	if entityType == ArcadeSurvivorEnum.EntityType.Character then
		self._gameCharacterMO = nil
	end
end

function ArcadeSurvivorGameModel:removeOccupyGrid(entityType, uid)
	local entityLayer = entityType and ArcadeSurvivorGameEnum.EntityType2Layer[entityType]

	if not entityLayer then
		return
	end

	local layerGridDict = GameUtil.tabletool_checkDictTable(self._grid2EntityDict, entityLayer)
	local occupyGridList = self:getEntityOccupyGridList(entityType, uid)

	for _, gridId in pairs(occupyGridList) do
		local data = layerGridDict[gridId]

		if data and data.entityType == entityType and data.uid == uid then
			layerGridDict[gridId] = nil
		end
	end

	local typeDict = entityType and self._entity2GridDict and self._entity2GridDict[entityType]

	if typeDict then
		typeDict[uid] = nil
	end
end

function ArcadeSurvivorGameModel:clearAllEntityMO(includeCharacter)
	self._moDict = {}
	self._moList = {}
	self._entity2GridDict = {}
	self._grid2EntityDict = {}

	if includeCharacter then
		self._gameCharacterMO = nil
	elseif self._gameCharacterMO then
		local entityType = ArcadeSurvivorEnum.EntityType.Character
		local uid = self._gameCharacterMO:getUid()
		local gridX, gridY = self._gameCharacterMO:getGridPos()
		local sizeX, sizeY = self._gameCharacterMO:getSize()
		local typeDict = GameUtil.tabletool_checkDictTable(self._moDict, entityType)
		local typeList = GameUtil.tabletool_checkDictTable(self._moList, entityType)

		typeDict[uid] = self._gameCharacterMO
		typeList[#typeList + 1] = self._gameCharacterMO

		if gridX > 0 and gridY > 0 then
			self:setOccupyGrid(entityType, uid, gridX, gridY, sizeX, sizeY)
		end
	end
end

function ArcadeSurvivorGameModel:_initGridMO()
	self._gridModel:clear()

	local mapSizeX, mapSizeY = self:getMapSize()

	if mapSizeX <= 0 or mapSizeY <= 0 then
		return
	end

	local minimumCoordinate = ArcadeSurvivorGameEnum.Const.MinimumCoordinate

	for gridX = minimumCoordinate, mapSizeX do
		for gridY = minimumCoordinate, mapSizeY do
			self:getGridMOByXY(gridX, gridY)
		end
	end
end

function ArcadeSurvivorGameModel:getGridMOByXY(gridX, gridY)
	local gridId = ArcadeSurvivorGameHelper.getGridId(gridX, gridY)
	local gridMO = self._gridModel:getById(gridId)

	if not gridMO and not ArcadeSurvivorGameHelper.isOutsideMap(gridX, gridY) then
		gridMO = ArcadeSurvivorGameGridMO.New(gridX, gridY)

		self._gridModel:addAtLast(gridMO)
	end

	return gridMO
end

function ArcadeSurvivorGameModel:getGridMOList()
	return self._gridModel:getList()
end

function ArcadeSurvivorGameModel:addRoundKillCount(count)
	self._roundKillCount = self._roundKillCount + (count or 1)
end

function ArcadeSurvivorGameModel:addRoundHitTargetCount(count)
	self._roundHitTargetCount = self._roundHitTargetCount + (count or 1)
end

function ArcadeSurvivorGameModel:setRoundIsHurt()
	self._roundIsHurt = true
end

function ArcadeSurvivorGameModel:resetRoundScore()
	self._roundKillCount = 0
	self._roundHitTargetCount = 0
	self._roundIsHurt = false
	self._roundScoreCalculated = false
end

function ArcadeSurvivorGameModel:isRoundScoreCalculated()
	return self._roundScoreCalculated == true
end

function ArcadeSurvivorGameModel:resetLevelScore()
	self._curLevelScore = 0
	self._levelScoreCommitted = false
	self._consecutiveUnhurtRounds = 0

	self:resetRoundScore()

	self._killScore = ArcadeSurvivorConfig.instance:getConst(ArcadeSurvivorEnum.ConstId.KillScore, true) or 0
	self._targetScore = ArcadeSurvivorConfig.instance:getConst(ArcadeSurvivorEnum.ConstId.TargetScore, true) or 0
	self._hurtScore = ArcadeSurvivorConfig.instance:getConst(ArcadeSurvivorEnum.ConstId.HurtScore, true) or 0
	self._hurtDeduct = ArcadeSurvivorConfig.instance:getConst(ArcadeSurvivorEnum.ConstId.HurtDeduct, true) or 0
end

function ArcadeSurvivorGameModel:commitLevelScore()
	if self._levelScoreCommitted then
		return
	end

	self._levelScoreCommitted = true
	self._levelScoreList[#self._levelScoreList + 1] = self._curLevelScore or 0
end

function ArcadeSurvivorGameModel:getLevelScoreStr()
	local strList = {}

	for i, levelScore in ipairs(self._levelScoreList) do
		strList[i] = string.format("%.2f", levelScore)
	end

	return table.concat(strList, "#")
end

function ArcadeSurvivorGameModel:getAvgScore()
	local count = #self._levelScoreList

	if count <= 0 then
		return 0
	end

	local sum = 0

	for _, levelScore in ipairs(self._levelScoreList) do
		sum = sum + levelScore
	end

	return math.floor(sum / count)
end

function ArcadeSurvivorGameModel:calcRoundScore()
	local curRound = self:getCurRound()

	if curRound <= 0 then
		curRound = 1
	end

	local baseScore = math.max(self._roundKillCount * self._killScore / curRound, 1)
	local attackBonus = baseScore

	if self._targetScore > 0 then
		attackBonus = baseScore * self._roundHitTargetCount / self._targetScore
	end

	local survivalBonus = 0
	local survivalDeduct = 0

	if self._roundIsHurt then
		survivalDeduct = self._hurtDeduct
		self._consecutiveUnhurtRounds = 0
	else
		self._consecutiveUnhurtRounds = self._consecutiveUnhurtRounds + 1
		survivalBonus = self._consecutiveUnhurtRounds * self._hurtScore
	end

	local roundScore = attackBonus + survivalBonus - survivalDeduct

	self._curLevelScore = self._curLevelScore + roundScore
	self._roundScoreCalculated = true

	logNormal(string.format("【计分】回合%d: 击杀%d 命中%d 连续未受伤%d 受伤=%s 本回合分=%.2f 本关分=%.2f", curRound, self._roundKillCount, self._roundHitTargetCount, self._consecutiveUnhurtRounds, tostring(self._roundIsHurt), roundScore, self._curLevelScore))

	return roundScore
end

function ArcadeSurvivorGameModel:getCurLevelScore()
	return self._curLevelScore or 0
end

function ArcadeSurvivorGameModel:setGameIsEnd(isEnd)
	self._isEndGame = isEnd
end

function ArcadeSurvivorGameModel:requestStopGame(sourceKey)
	if self._stopSourceDict[sourceKey] then
		return
	end

	self._stopSourceDict[sourceKey] = true
end

function ArcadeSurvivorGameModel:requestResumeGame(sourceKey)
	if not self._stopSourceDict[sourceKey] then
		return
	end

	self._stopSourceDict[sourceKey] = nil
end

function ArcadeSurvivorGameModel:setDifficulty(difficulty)
	self._difficulty = difficulty
end

function ArcadeSurvivorGameModel:setCurStageIndex(stageIndex)
	self._curStageIndex = stageIndex
end

function ArcadeSurvivorGameModel:setCurLevelIndex(levelIndex)
	self._curLevelIndex = levelIndex or 0
	self._mapSizeX = 0
	self._mapSizeY = 0
	self._viewSizeX = 0
	self._viewSizeY = 0
	self._curRound = 0
	self._totalRound = 0
	self._curMonsterGroupId = nil
	self._waveIndex2ExtraAddDict = {}

	local characterMO = self:getCharacterMO()

	if characterMO then
		characterMO:setLastWeaponSkillCastRound()
	end

	self:_clearDelayHitData()

	if self._curLevelIndex <= 0 then
		return
	end

	local curLevelId = self:getCurLevelId()
	local monsterGroupPoolList = ArcadeSurvivorConfig.instance:getLevelMonsterGroupPool(curLevelId)
	local randomIdx = math.random(#monsterGroupPoolList)

	self._curMonsterGroupId = monsterGroupPoolList[randomIdx]

	local curLevelRuleId = self:getCurLevelRule()

	if curLevelRuleId then
		self._mapSizeX, self._mapSizeY = ArcadeSurvivorConfig.instance:getLevelRuleBoardSize(curLevelRuleId)
		self._viewSizeX, self._viewSizeY = ArcadeSurvivorConfig.instance:getLevelRuleViewSize(curLevelRuleId)
		self._waveIndex2ExtraAddDict = ArcadeSurvivorConfig.instance:getLevelRuleWaveExtraAddDict(curLevelRuleId)

		local waveCount = ArcadeSurvivorConfig.instance:getLevelRuleWaveCount(curLevelRuleId)
		local waveInterval = ArcadeSurvivorConfig.instance:getLevelRuleWaveInterval(curLevelRuleId)

		self._totalRound = waveCount * (waveInterval + 1)
	end

	self:_initGridMO()
end

function ArcadeSurvivorGameModel:setRestartShopStatus(strShopStatus)
	self._restartShopStatus = strShopStatus
end

function ArcadeSurvivorGameModel:setRestartOpenEventSelect(isOpen)
	self._restartOpenEventSelect = isOpen
end

function ArcadeSurvivorGameModel:addSelectEvent(eventId)
	local cfg = ArcadeSurvivorConfig.instance:getEventCfg(eventId, true)

	if not cfg then
		return
	end

	self._eventIdList[#self._eventIdList + 1] = eventId
end

function ArcadeSurvivorGameModel:setIsPlayerTurn(isPlayerTurn)
	self._isPlayerTurn = isPlayerTurn
end

function ArcadeSurvivorGameModel:changeCurrencyCount(currencyId, changeNum, isAddGainStat, isApplyGradeRate)
	if not currencyId or not changeNum then
		return
	end

	local cfg = ArcadeSurvivorConfig.instance:getCurrencyCfg(currencyId, true)

	if not cfg then
		return
	end

	local realChangeNum = changeNum

	if isAddGainStat and isApplyGradeRate and currencyId == ArcadeSurvivorEnum.Currency.Coin and changeNum > 0 then
		local gainRate = ArcadeSurvivorConfig.instance:getGradeAddCoinRate(self:getCurLevelScore())
		local permillageBase = ArcadeSurvivorEnum.Const.PermillageBase

		realChangeNum = math.floor(changeNum * (permillageBase + gainRate) / permillageBase)
	end

	local oldCount = self._currencyDict[currencyId] or 0
	local newCount = oldCount + realChangeNum
	local minCount = ArcadeSurvivorConfig.instance:getCurrencyMin(currencyId)
	local maxCount = ArcadeSurvivorConfig.instance:getCurrencyMax(currencyId)
	local realNewCount = GameUtil.clamp(newCount, minCount, maxCount)

	self._currencyDict[currencyId] = realNewCount

	if not isAddGainStat or currencyId ~= ArcadeSurvivorEnum.Currency.Coin or changeNum <= 0 then
		return
	end

	local gain = realNewCount - oldCount

	if gain >= 0 then
		self:addResultStatistics(ArcadeSurvivorGameEnum.CustomSaveInfoKey.TotalGainCoin, gain)
	end
end

function ArcadeSurvivorGameModel:addResultStatistics(key, val)
	if not key then
		return
	end

	local oldVal = self:getResultStatistics(key)

	self._resultStatisticsDict[key] = oldVal + (val or 1)
end

function ArcadeSurvivorGameModel:addRound()
	local curRound = self:getCurRound()

	self._curRound = curRound + 1
end

function ArcadeSurvivorGameModel:setShopRefreshBaseCount(count)
	self._shopRefreshBaseCount = count
end

function ArcadeSurvivorGameModel:setGoodsIsLock(shopType, goodsId, isLock, lockIndex)
	if not shopType or not goodsId then
		return
	end

	if isLock and (not lockIndex or lockIndex <= 0) then
		return
	end

	local goodsIdDict = self._lockGoodsDict[shopType]

	if isLock then
		if not goodsIdDict then
			goodsIdDict = {}
			self._lockGoodsDict[shopType] = goodsIdDict
		end

		goodsIdDict[goodsId] = lockIndex
	elseif goodsIdDict then
		goodsIdDict[goodsId] = nil
	end
end

function ArcadeSurvivorGameModel:addUnlockCharacter(characterId)
	local cfg = ArcadeSurvivorConfig.instance:getCharacterCfg(characterId, true)

	if not cfg then
		return
	end

	self._unlockCharacterDict[characterId] = true

	self:addUnlockHandBookItem(ArcadeSurvivorHallEnum.HandBookType.Character, characterId)
end

function ArcadeSurvivorGameModel:addUnlockHandBookItem(handBookType, id)
	local typeDict = GameUtil.tabletool_checkDictTable(self._unlockHandBookDict, handBookType)

	typeDict[id] = true
end

function ArcadeSurvivorGameModel:addMonsterExtraSkill(skillId)
	if not skillId then
		return
	end

	self._monsterExtraSkillDict[skillId] = true
end

function ArcadeSurvivorGameModel:addDelayHitRecord(record)
	if not record then
		return
	end

	local skillId = record:getSkillId()
	local skillUid = record:getSkillUid()
	local triggerIndex = record:getTriggerIndex()
	local context = record:getDelayContext()
	local delayTurn = record:getRemainTurn()
	local gridIdDict = record:getGridIdDict()
	local isEmptyGridIdDict = GameUtil.tabletool_dictIsEmpty(gridIdDict)

	if not skillId or not skillUid or skillUid <= 0 or not triggerIndex or triggerIndex <= 0 or not context or not delayTurn or delayTurn <= 0 then
		return
	end

	if isEmptyGridIdDict and not record.allowEmptyGrid then
		return
	end

	if self._delayHitActiveRecordDict[record] then
		return true
	end

	local prevRecord = self._delayHitRecordTail

	if prevRecord then
		self._delayHitRecordNextDict[prevRecord] = record
	else
		self._delayHitRecordHead = record
	end

	self._delayHitRecordPrevDict[record] = prevRecord
	self._delayHitRecordNextDict[record] = nil
	self._delayHitRecordTail = record
	self._delayHitActiveRecordDict[record] = true

	local gridIndexDict = GameUtil.tabletool_checkDictTable(self._delayHitGridIndexByRecordDict, record)

	for gridId, _ in pairs(gridIdDict) do
		local recordList = GameUtil.tabletool_checkDictTable(self._grid2DelayHitRecord, gridId)
		local index = #recordList + 1

		recordList[index] = record
		gridIndexDict[gridId] = index
	end

	self:_increaseDelayHitWaitCount(record)

	return true
end

function ArcadeSurvivorGameModel:_increaseDelayHitWaitCount(record)
	local entityType = record:getEntityType()
	local uid = record:getUid()
	local skillUid = record:getSkillUid()
	local typeDict = GameUtil.tabletool_checkDictTable(self._delayHitWaitCountByCasterSkillDict, entityType)
	local uidDict = GameUtil.tabletool_checkDictTable(typeDict, uid)

	uidDict[skillUid] = (uidDict[skillUid] or 0) + 1
end

function ArcadeSurvivorGameModel:removeDelayHitByEntity(entityType, uid)
	if not entityType or not uid then
		return
	end

	local hasRemoved = false
	local record = self._delayHitRecordHead

	while record do
		local nextRecord = self._delayHitRecordNextDict[record]

		if record:getEntityType() == entityType and record:getUid() == uid then
			self:removeDelayHit(record)

			hasRemoved = true
		end

		record = nextRecord
	end

	return hasRemoved
end

function ArcadeSurvivorGameModel:removeDelayHit(record)
	if not record or not self._delayHitActiveRecordDict[record] then
		return false
	end

	local prevRecord = self._delayHitRecordPrevDict[record]
	local nextRecord = self._delayHitRecordNextDict[record]

	if prevRecord then
		self._delayHitRecordNextDict[prevRecord] = nextRecord
	else
		self._delayHitRecordHead = nextRecord
	end

	if nextRecord then
		self._delayHitRecordPrevDict[nextRecord] = prevRecord
	else
		self._delayHitRecordTail = prevRecord
	end

	self._delayHitRecordPrevDict[record] = nil
	self._delayHitRecordNextDict[record] = nil
	self._delayHitActiveRecordDict[record] = nil

	self:_removeDelayHitFromGridList(record)
	self:_decreaseDelayHitWaitCount(record)

	return true
end

function ArcadeSurvivorGameModel:_removeDelayHitFromGridList(record)
	local gridIndexDict = self._delayHitGridIndexByRecordDict[record]

	if not gridIndexDict then
		return
	end

	for gridId, index in pairs(gridIndexDict) do
		local recordList = self._grid2DelayHitRecord[gridId]
		local lastIndex = recordList and #recordList or 0

		if index < 1 or lastIndex < index or recordList[index] ~= record then
			logError(string.format("ArcadeSurvivorGameModel:_removeDelayHitFromGridList error, invalid grid index, gridId:%s index:%s", tostring(gridId), tostring(index)))
		else
			local lastRecord = recordList[lastIndex]

			recordList[index] = lastRecord
			recordList[lastIndex] = nil

			if lastRecord ~= record then
				local lastIndexDict = self._delayHitGridIndexByRecordDict[lastRecord]

				if lastIndexDict then
					lastIndexDict[gridId] = index
				end
			end

			if #recordList <= 0 then
				self._grid2DelayHitRecord[gridId] = nil
			end
		end
	end

	self._delayHitGridIndexByRecordDict[record] = nil
end

function ArcadeSurvivorGameModel:_decreaseDelayHitWaitCount(record)
	local skillUid = record:getSkillUid()
	local entityType = record:getEntityType()
	local uid = record:getUid()
	local typeDict = self._delayHitWaitCountByCasterSkillDict[entityType]
	local uidDict = typeDict and typeDict[uid]
	local count = uidDict and uidDict[skillUid]

	if not count then
		return
	end

	count = count - 1

	if count > 0 then
		uidDict[skillUid] = count

		return
	end

	uidDict[skillUid] = nil

	if not next(uidDict) then
		typeDict[uid] = nil
	end

	if not next(typeDict) then
		self._delayHitWaitCountByCasterSkillDict[entityType] = nil
	end
end

function ArcadeSurvivorGameModel:getGameIsEnd()
	return self._isEndGame
end

function ArcadeSurvivorGameModel:getIsPauseGame()
	if not self._stopSourceDict then
		return false
	end

	return next(self._stopSourceDict) ~= nil
end

function ArcadeSurvivorGameModel:getDifficulty()
	return self._difficulty
end

function ArcadeSurvivorGameModel:getCurStageIndex()
	return self._curStageIndex or 0
end

function ArcadeSurvivorGameModel:getCurStageId()
	local difficulty = self:getDifficulty()

	if difficulty then
		local stageIndex = self:getCurStageIndex()

		return ArcadeSurvivorConfig.instance:getDifficultyStageId(difficulty, stageIndex)
	end
end

function ArcadeSurvivorGameModel:getCurLevelIndex()
	return self._curLevelIndex or 0
end

function ArcadeSurvivorGameModel:getCurLevelId()
	local stageId = self:getCurStageId()

	if stageId then
		local levelIndex = self:getCurLevelIndex()

		return ArcadeSurvivorConfig.instance:getStageLevelId(stageId, levelIndex)
	end
end

function ArcadeSurvivorGameModel:getCurLevelRule()
	local curLevelId = self:getCurLevelId()

	return ArcadeSurvivorConfig.instance:getLevelRuleId(curLevelId)
end

function ArcadeSurvivorGameModel:isDifficultyCompleted()
	local difficulty = self:getDifficulty()
	local difficultyStageCount = ArcadeSurvivorConfig.instance:getDifficultyStageCount(difficulty)
	local curStageIndex = self:getCurStageIndex()

	if difficultyStageCount <= curStageIndex then
		local curStageId = self:getCurStageId()
		local stageLevelCount = ArcadeSurvivorConfig.instance:getStageLevelCount(curStageId)
		local curLevelIndex = self:getCurLevelIndex()

		if stageLevelCount <= curLevelIndex then
			return true
		end
	end

	return false
end

function ArcadeSurvivorGameModel:getCurWaveIndex()
	local curRound = self:getCurRound()

	if curRound <= 0 then
		return 0
	end

	local curLevelRuleId = self:getCurLevelRule()

	if not curLevelRuleId then
		return 0
	end

	local waveInterval = ArcadeSurvivorConfig.instance:getLevelRuleWaveInterval(curLevelRuleId)

	return math.floor((curRound - 1) / (waveInterval + 1)) + 1
end

function ArcadeSurvivorGameModel:getWaveExtraAdd(waveIndex)
	return self._waveIndex2ExtraAddDict[waveIndex] or 0
end

function ArcadeSurvivorGameModel:getRestartShopStatus()
	return self._restartShopStatus
end

function ArcadeSurvivorGameModel:getRestartOpenEventSelect()
	return self._restartOpenEventSelect
end

function ArcadeSurvivorGameModel:getEventIdList()
	return self._eventIdList
end

function ArcadeSurvivorGameModel:getIsPlayerTurn()
	return self._isPlayerTurn
end

function ArcadeSurvivorGameModel:getCurrencyCount(currencyId)
	return self._currencyDict[currencyId] or 0
end

function ArcadeSurvivorGameModel:canBuyGoods(shopGoodsType, goodsId)
	local characterMO = self:getCharacterMO()

	if self:getGameIsEnd() or not characterMO then
		return false
	end

	if shopGoodsType == ArcadeSurvivorGameEnum.ShopGoodsType.Collection and not characterMO:canAddCollection(goodsId) then
		return false
	end

	local costCount, isUseHp = self:getGoodsCost(shopGoodsType, goodsId)

	if not costCount then
		return
	end

	if isUseHp then
		return characterMO:getIsAlive() and costCount < characterMO:getHp()
	end

	local haveCount = self:getCurrencyCount(ArcadeSurvivorEnum.Currency.Coin)

	return costCount <= haveCount
end

function ArcadeSurvivorGameModel:getGoodsCost(shopGoodsType, goodsId)
	local goodsHandler = ArcadeSurvivorGameEnum.ShopGoodsHandler[shopGoodsType]

	if not goodsHandler then
		return
	end

	local price = goodsHandler.priceFunc(goodsId) or 0
	local ruleModel = self:getRuleModel()
	local discountPercent = ruleModel:getShopDiscountPercent()

	if discountPercent > 0 then
		local priceFactor = math.max(0, ArcadeSurvivorEnum.Const.PercentBase - discountPercent) / ArcadeSurvivorEnum.Const.PercentBase

		price = math.floor(price * priceFactor + 0.5)
	end

	local costCount = price
	local isUseHp = false
	local coinPerHp = ruleModel:getCoinPerHp()

	if coinPerHp and coinPerHp > 0 then
		isUseHp = true
		costCount = math.floor(price / coinPerHp + 0.5)
	end

	return costCount, isUseHp
end

function ArcadeSurvivorGameModel:getResultStatistics(key)
	return self._resultStatisticsDict and self._resultStatisticsDict[key] or 0
end

function ArcadeSurvivorGameModel:getTotalRound()
	return self._totalRound or 0
end

function ArcadeSurvivorGameModel:getCurRound()
	return self._curRound or 0
end

function ArcadeSurvivorGameModel:getRemainRound()
	local totalRound = self:getTotalRound()
	local curRound = self:getCurRound()
	local result = math.max(0, totalRound - curRound)

	return result
end

function ArcadeSurvivorGameModel:getShopId()
	local curLevelId = self:getCurLevelId()
	local defaultShopId = ArcadeSurvivorConfig.instance:getLevelShopId(curLevelId)
	local ruleShopId = self._ruleModel:getShopId()

	return ruleShopId or defaultShopId
end

function ArcadeSurvivorGameModel:getShopRefreshCount()
	local refreshBaseCount = self._shopRefreshBaseCount or 0

	return refreshBaseCount + self._ruleModel:getShopRefreshExtra()
end

function ArcadeSurvivorGameModel:getPackSelectableCount()
	local ruleOptionCount = self._ruleModel:getPackSelectableCount()

	return ruleOptionCount or 1
end

function ArcadeSurvivorGameModel:getCharacterTurnTime()
	local ruleTurnTime = self._ruleModel:getCharacterTurnTime()

	if ruleTurnTime and ruleTurnTime > 0 then
		return ruleTurnTime
	end

	local difficulty = self:getDifficulty()
	local difficultyTurnTime = ArcadeSurvivorConfig.instance:getDifficultyPlayerTurnTime(difficulty)

	if difficultyTurnTime and difficultyTurnTime > 0 then
		return difficultyTurnTime
	else
		return ArcadeSurvivorGameEnum.Const.DefaultCharacterTurnTime
	end
end

function ArcadeSurvivorGameModel:getMonsterSpawnConfig()
	local levelRuleId = self:getCurLevelRule()
	local ruleSpawnCount, ruleMaxCount = self._ruleModel:getMonsterSpawnConfig()

	if ruleSpawnCount and ruleMaxCount then
		return ruleSpawnCount, ruleMaxCount
	else
		local defaultSpawnCount = ArcadeSurvivorConfig.instance:getLevelRuleWaveAdd(levelRuleId)
		local defaultMaxCount = ArcadeSurvivorConfig.instance:getLevelRuleMaxAddCount(levelRuleId)

		return defaultSpawnCount, defaultMaxCount
	end
end

function ArcadeSurvivorGameModel:getUnlockCharacterDict()
	return self._unlockCharacterDict
end

function ArcadeSurvivorGameModel:getLockCharacterIdList()
	local result = {}
	local unlockCharacterDict = self:getUnlockCharacterDict()
	local heroMOList = ArcadeSurvivorHeroModel.instance:getHeroMOList()

	for _, heroMO in ipairs(heroMOList) do
		local characterId = heroMO:getId()
		local isGameUnlocked = unlockCharacterDict[characterId]
		local isLock = heroMO:isLock()

		if isLock and not isGameUnlocked then
			result[#result + 1] = characterId
		end
	end

	return result
end

function ArcadeSurvivorGameModel:getUnlockHandBookDict()
	return self._unlockHandBookDict
end

function ArcadeSurvivorGameModel:getMonsterExtraSkillDict()
	return self._monsterExtraSkillDict
end

function ArcadeSurvivorGameModel:getCharacterMO()
	return self._gameCharacterMO
end

function ArcadeSurvivorGameModel:getEntityMO(entityType, uid, nilError)
	local result

	if entityType == ArcadeSurvivorEnum.EntityType.Grid then
		result = self._gridModel:getById(uid)
	else
		local dict = entityType and self._moDict[entityType]

		result = dict and dict[uid]
	end

	if not result and nilError then
		logError(string.format("ArcadeSurvivorGameModel:getEntityMO error, entityType:%s uid:%s", entityType, uid))
	end

	return result
end

function ArcadeSurvivorGameModel:getEntityMOList(entityType)
	local result

	if entityType == ArcadeSurvivorEnum.EntityType.Grid then
		result = self:getGridMOList()
	else
		result = self._moList[entityType]
	end

	return result
end

function ArcadeSurvivorGameModel:getAliveBossMOList()
	local bossMOList = {}
	local monsterMOList = self:getEntityMOList(ArcadeSurvivorEnum.EntityType.Monster)

	if not monsterMOList or #monsterMOList <= 0 then
		return bossMOList
	end

	for _, monsterMO in ipairs(monsterMOList) do
		if monsterMO:getMonsterType() == ArcadeSurvivorEnum.MonsterType.Boss and monsterMO:getIsAlive() then
			bossMOList[#bossMOList + 1] = monsterMO
		end
	end

	return bossMOList
end

function ArcadeSurvivorGameModel:getEntityDataInGrid(gridX, gridY, entityLayer)
	if not gridX or not gridY then
		return
	end

	entityLayer = entityLayer or ArcadeSurvivorGameEnum.EntityLayer.Normal

	local gridId = ArcadeSurvivorGameHelper.getGridId(gridX, gridY)
	local layerGridDict = self._grid2EntityDict and self._grid2EntityDict[entityLayer]

	return layerGridDict and layerGridDict[gridId]
end

function ArcadeSurvivorGameModel:getEntityOccupyGridList(entityType, uid)
	local result = {}
	local typeDict = entityType and self._entity2GridDict and self._entity2GridDict[entityType]
	local gridDict = typeDict and typeDict[uid]

	if gridDict then
		for gridId, _ in pairs(gridDict) do
			result[#result + 1] = gridId
		end
	end

	return result
end

function ArcadeSurvivorGameModel:getSpawnMonsterDataList(count)
	if not self._curMonsterGroupId or not count or count <= 0 then
		return
	end

	local levelRuleId = self:getCurLevelRule()
	local monsterList = self:getEntityMOList(ArcadeSurvivorEnum.EntityType.Monster)
	local _, maxMonsterCount = self:getMonsterSpawnConfig()
	local monsterCount = monsterList and #monsterList or 0

	count = math.min(count, maxMonsterCount - monsterCount)

	if count <= 0 then
		return
	end

	local monsterWeightList
	local curRound = self:getCurRound()
	local normalWeight = ArcadeSurvivorConfig.instance:getLevelRuleNormalWeight(levelRuleId, curRound)
	local eliteWeight = ArcadeSurvivorConfig.instance:getLevelRuleEliteWeight(levelRuleId, curRound)
	local eliteCount = 0

	if monsterList then
		for _, monsterMO in ipairs(monsterList) do
			local type = monsterMO:getMonsterType()

			if type == ArcadeSurvivorEnum.MonsterType.Elite then
				eliteCount = eliteCount + 1
			end
		end
	end

	local maxEliteMonsterCount = ArcadeSurvivorConfig.instance:getLevelRuleMaxAddEliteCount(levelRuleId)

	if maxEliteMonsterCount <= eliteCount then
		eliteWeight = 0
	end

	local randomWeight = math.random(normalWeight + eliteWeight)

	if randomWeight <= normalWeight then
		monsterWeightList = ArcadeSurvivorConfig.instance:getMonsterGroupNormalMonsterWeightList(self._curMonsterGroupId)
	else
		count = math.min(count, maxEliteMonsterCount - eliteCount)
		monsterWeightList = ArcadeSurvivorConfig.instance:getMonsterGroupEliteMonsterWeightList(self._curMonsterGroupId)
	end

	if not monsterWeightList then
		return
	end

	local weightList = {}
	local totalWeight = 0

	for i, data in ipairs(monsterWeightList) do
		local weight = data.weight

		weightList[i] = weight
		totalWeight = totalWeight + weight
	end

	local ringData = self:_getMonsterSpawnRingData()

	if not ringData then
		return
	end

	local result = {}
	local tempOccupyGridDict = {}

	for _ = 1, count do
		local index = ArcadeGameHelper.getRandomIndex(weightList, totalWeight)
		local data = monsterWeightList[index]
		local monsterId = data and data.monsterId

		if monsterId then
			local sizeX, sizeY = ArcadeSurvivorConfig.instance:getMonsterSize(monsterId)
			local x, y = self:_getMonsterSpawnGridPos(sizeX, sizeY, tempOccupyGridDict, ringData)

			if x and y then
				result[#result + 1] = {
					entityType = ArcadeSurvivorEnum.EntityType.Monster,
					id = monsterId,
					x = x,
					y = y,
					sizeX = sizeX,
					sizeY = sizeY
				}
			end
		end
	end

	return result
end

function ArcadeSurvivorGameModel:_getMonsterSpawnRingData()
	local viewLeft, viewBottom, viewRight, viewTop = self:_getViewGridRect(true)

	if not viewLeft then
		return
	end

	local mapSizeX, mapSizeY = self:getMapSize()
	local minimumCoordinate = ArcadeSurvivorGameEnum.Const.MinimumCoordinate
	local spawnAreaWidth = ArcadeSurvivorGameEnum.Const.MonsterSpawnAreaWidth
	local ringLeft = math.max(minimumCoordinate, viewLeft - spawnAreaWidth)
	local ringBottom = math.max(minimumCoordinate, viewBottom - spawnAreaWidth)
	local ringRight = math.min(mapSizeX, viewRight + spawnAreaWidth)
	local ringTop = math.min(mapSizeY, viewTop + spawnAreaWidth)
	local ringGridList = {}
	local entityLayer = ArcadeSurvivorGameEnum.EntityType2Layer[ArcadeSurvivorEnum.EntityType.Monster]

	for x = ringLeft, ringRight do
		local isOutsideViewX = x < viewLeft or viewRight < x

		for y = ringBottom, ringTop do
			local isOutsideViewY = y < viewBottom or viewTop < y

			if isOutsideViewX or isOutsideViewY then
				local occupyEntityData = self:getEntityDataInGrid(x, y, entityLayer)

				if not occupyEntityData then
					ringGridList[#ringGridList + 1] = {
						x = x,
						y = y
					}
				end
			end
		end
	end

	if #ringGridList <= 0 then
		return
	end

	return {
		gridList = ringGridList,
		viewLeft = viewLeft,
		viewRight = viewRight,
		viewBottom = viewBottom,
		viewTop = viewTop
	}
end

function ArcadeSurvivorGameModel:isEntityMOInView(mo, isFullVisibilityRequired)
	if not mo then
		return false
	end

	local left, bottom, right, top = mo:getGridPosRect()
	local includeHalfGrid = not isFullVisibilityRequired
	local viewLeft, viewBottom, viewRight, viewTop = self:_getViewGridRect(includeHalfGrid)

	if not viewLeft then
		return false
	end

	if isFullVisibilityRequired then
		local isFullyInViewX = viewLeft <= left and right <= viewRight
		local isFullyInViewY = viewBottom <= bottom and top <= viewTop

		return isFullyInViewX and isFullyInViewY
	end

	return ArcadeSurvivorGameHelper.getIsRectIntersect(left, bottom, right, top, viewLeft, viewBottom, viewRight, viewTop)
end

function ArcadeSurvivorGameModel:getOutsideMonsterArrowDirection(mo)
	if not mo then
		return
	end

	local monsterLeft, monsterBottom, monsterRight, monsterTop = mo:getGridPosRect()

	if self:isEntityMOInView(mo, false) then
		return
	end

	local characterMO = self:getCharacterMO()

	if not characterMO then
		return
	end

	local playerLeft, playerBottom, playerRight, playerTop = characterMO:getGridPosRect()
	local monsterCenterX = (monsterLeft + monsterRight) * 0.5
	local monsterCenterY = (monsterBottom + monsterTop) * 0.5
	local playerCenterX = (playerLeft + playerRight) * 0.5
	local playerCenterY = (playerBottom + playerTop) * 0.5
	local offsetX = monsterCenterX - playerCenterX
	local offsetY = monsterCenterY - playerCenterY
	local absOffsetX = math.abs(offsetX)
	local absOffsetY = math.abs(offsetY)
	local direction

	if absOffsetX == absOffsetY and absOffsetX > 0 then
		local isOffsetXPositive = offsetX > 0
		local isOffsetYPositive = offsetY > 0

		if isOffsetXPositive then
			direction = isOffsetYPositive and ArcadeSurvivorEnum.Direction.RightUp or ArcadeSurvivorEnum.Direction.RightDown
		else
			direction = isOffsetYPositive and ArcadeSurvivorEnum.Direction.LeftUp or ArcadeSurvivorEnum.Direction.LeftDown
		end
	elseif absOffsetY < absOffsetX then
		direction = offsetX > 0 and ArcadeSurvivorEnum.Direction.Right or ArcadeSurvivorEnum.Direction.Left
	else
		direction = offsetY > 0 and ArcadeSurvivorEnum.Direction.Up or ArcadeSurvivorEnum.Direction.Down
	end

	return direction
end

function ArcadeSurvivorGameModel:_getViewGridRect(includeHalfGrid)
	local mapSizeX, mapSizeY = self:getMapSize()
	local viewSizeX, viewSizeY = self:getViewSize()

	if mapSizeX <= 0 or mapSizeY <= 0 or viewSizeX <= 0 or viewSizeY <= 0 then
		return
	end

	local characterMO = self:getCharacterMO()

	if not characterMO then
		return
	end

	local minimumCoordinate = ArcadeSurvivorGameEnum.Const.MinimumCoordinate
	local playerGridX, playerGridY = characterMO:getGridPos()
	local halfViewSizeX = viewSizeX * 0.5
	local halfViewSizeY = viewSizeY * 0.5
	local minViewCenterX = minimumCoordinate - 0.5 + halfViewSizeX
	local maxViewCenterX = mapSizeX + 0.5 - halfViewSizeX
	local minViewCenterY = minimumCoordinate - 0.5 + halfViewSizeY
	local maxViewCenterY = mapSizeY + 0.5 - halfViewSizeY
	local viewCenterX, viewCenterY

	if viewSizeX < mapSizeX then
		viewCenterX = GameUtil.clamp(playerGridX, minViewCenterX, maxViewCenterX)
	else
		viewCenterX = (mapSizeX + 1) * 0.5
	end

	if viewSizeY < mapSizeY then
		viewCenterY = GameUtil.clamp(playerGridY, minViewCenterY, maxViewCenterY)
	else
		viewCenterY = (mapSizeY + 1) * 0.5
	end

	local rawLeft, rawRight, rawBottom, rawTop
	local viewLeft = viewCenterX - halfViewSizeX
	local viewBottom = viewCenterY - halfViewSizeY
	local viewRight = viewCenterX + halfViewSizeX
	local viewTop = viewCenterY + halfViewSizeY

	if includeHalfGrid then
		rawLeft = math.floor(viewLeft + 0.5)
		rawRight = math.ceil(viewRight - 0.5)
		rawBottom = math.floor(viewBottom + 0.5)
		rawTop = math.ceil(viewTop - 0.5)
	else
		rawLeft = math.ceil(viewLeft + 0.5)
		rawRight = math.floor(viewRight - 0.5)
		rawBottom = math.ceil(viewBottom + 0.5)
		rawTop = math.floor(viewTop - 0.5)
	end

	local gridLeft = math.max(minimumCoordinate, rawLeft)
	local gridBottom = math.max(minimumCoordinate, rawBottom)
	local gridRight = math.min(mapSizeX, rawRight)
	local gridTop = math.min(mapSizeY, rawTop)

	if gridRight < gridLeft or gridTop < gridBottom then
		return
	end

	return gridLeft, gridBottom, gridRight, gridTop
end

function ArcadeSurvivorGameModel:_getMonsterSpawnGridPos(sizeX, sizeY, tempOccupyGridDict, ringData)
	if not sizeX or sizeX <= 0 or not sizeY or sizeY <= 0 then
		return
	end

	if not ringData then
		return
	end

	local ringGridList = ringData.gridList
	local viewLeft = ringData.viewLeft
	local viewRight = ringData.viewRight
	local viewBottom = ringData.viewBottom
	local viewTop = ringData.viewTop
	local ringGridCount = #ringGridList

	if ringGridCount <= 0 then
		return
	end

	local indexList = {}

	for i = 1, ringGridCount do
		indexList[i] = i
	end

	for i = ringGridCount, 2, -1 do
		local randomIndex = math.random(i)

		indexList[i], indexList[randomIndex] = indexList[randomIndex], indexList[i]
	end

	local resultX, resultY
	local monsterEntityType = ArcadeSurvivorEnum.EntityType.Monster

	for _, index in ipairs(indexList) do
		local gridData = ringGridList[index]
		local x = gridData.x
		local y = gridData.y
		local monsterLeft = x
		local monsterBottom = y
		local monsterRight = x + sizeX - 1
		local monsterTop = y + sizeY - 1
		local isOutsideView = monsterRight < viewLeft or viewRight < monsterLeft or monsterTop < viewBottom or viewTop < monsterBottom

		if isOutsideView then
			local isCanPlace = self:isCanPlaceEntity(monsterEntityType, nil, x, y, sizeX, sizeY)
			local isTempOccupy = self:_isTempOccupyGrid(x, y, sizeX, sizeY, tempOccupyGridDict)

			if isCanPlace and not isTempOccupy then
				self:_setTempOccupyGrid(x, y, sizeX, sizeY, tempOccupyGridDict)

				resultX = x
				resultY = y

				break
			end
		end
	end

	return resultX, resultY
end

function ArcadeSurvivorGameModel:_isTempOccupyGrid(gridX, gridY, sizeX, sizeY, tempOccupyGridDict)
	if not tempOccupyGridDict then
		return false
	end

	for i = gridX, gridX + sizeX - 1 do
		for j = gridY, gridY + sizeY - 1 do
			local gridId = ArcadeSurvivorGameHelper.getGridId(i, j)

			if tempOccupyGridDict[gridId] then
				return true
			end
		end
	end

	return false
end

function ArcadeSurvivorGameModel:_setTempOccupyGrid(gridX, gridY, sizeX, sizeY, tempOccupyGridDict)
	if not tempOccupyGridDict then
		return
	end

	for i = gridX, gridX + sizeX - 1 do
		for j = gridY, gridY + sizeY - 1 do
			local gridId = ArcadeSurvivorGameHelper.getGridId(i, j)

			tempOccupyGridDict[gridId] = true
		end
	end
end

function ArcadeSurvivorGameModel:isFinishGameGuide()
	local isForbidGuide = GuideController.instance:isForbidGuides()

	if isForbidGuide then
		return true
	end

	local guideId = ArcadeSurvivorConfig.instance:getConst(ArcadeSurvivorEnum.ConstId.FirstGameGuideId, true)

	if not guideId or guideId == 0 then
		return true
	end

	return GuideModel.instance:isGuideFinish(guideId)
end

function ArcadeSurvivorGameModel:getIsInGuideLevel(difficulty)
	difficulty = difficulty or self:getDifficulty()

	local isFinishGuide = self:isFinishGameGuide()

	return difficulty == ArcadeSurvivorGameEnum.Const.GuideDifficulty and not isFinishGuide
end

function ArcadeSurvivorGameModel:getRuleModel()
	return self._ruleModel
end

function ArcadeSurvivorGameModel:getMapSize()
	return self._mapSizeX or 0, self._mapSizeY or 0
end

function ArcadeSurvivorGameModel:getViewSize()
	return self._viewSizeX or 0, self._viewSizeY or 0
end

function ArcadeSurvivorGameModel:getCanPlayerAct()
	local result = true
	local isPlayerTurn = self:getIsPlayerTurn()
	local isGamePause = self:getIsPauseGame()
	local isGameEnd = self:getGameIsEnd()
	local characterMO = self:getCharacterMO()

	if not isPlayerTurn or isGamePause or isGameEnd or not characterMO then
		result = false
	end

	return result
end

function ArcadeSurvivorGameModel:getAvailableCollectionIdList(rarity, specTag, excludeDict)
	local result = {}
	local characterMO = self:getCharacterMO()

	if not characterMO then
		return result
	end

	local idList = ArcadeSurvivorConfig.instance:getCollectionIdListInCfg(rarity, specTag, excludeDict)

	for _, collectionId in ipairs(idList) do
		if characterMO:canAddCollection(collectionId) then
			result[#result + 1] = collectionId
		end
	end

	return result
end

function ArcadeSurvivorGameModel:getRuleSaveStateJson()
	local stateList = self._ruleModel:getRuleSaveStateList()
	local hasState = #stateList > 0

	if not hasState then
		return ""
	end

	return cjson.encode({
		rules = stateList
	})
end

function ArcadeSurvivorGameModel:getGoodsIdList(shopId)
	local result = {}
	local goodsCount = ArcadeSurvivorConfig.instance:getShopSlot(shopId)

	if goodsCount <= 0 then
		return result
	end

	local shopParamArr = ArcadeSurvivorConfig.instance:getShopSlotParamList(shopId)
	local shopGoodsType = ArcadeSurvivorConfig.instance:getShopGoodsType(shopId)

	if shopGoodsType == ArcadeSurvivorGameEnum.ShopGoodsType.Collection then
		local lockGoodsDict = self:getLockGoodsDict(shopGoodsType)
		local lockGoodsIdList = self:getLockGoodsIdList(shopGoodsType)
		local lockCount = #lockGoodsIdList
		local randomCount = math.max(0, goodsCount - lockCount)
		local randomGoodsIdList = self:_generateRandomGoodsIdList(shopId, randomCount, lockGoodsDict)

		for _, goodsId in ipairs(randomGoodsIdList) do
			result[#result + 1] = goodsId
		end

		for _, lockGoods in ipairs(lockGoodsIdList) do
			local insertIndex = math.min(lockGoods.index, #result + 1)

			table.insert(result, insertIndex, lockGoods.id)
		end
	elseif shopGoodsType == ArcadeSurvivorGameEnum.ShopGoodsType.Pack then
		for i = 1, goodsCount do
			result[#result + 1] = tonumber(shopParamArr[i])
		end
	else
		logError(string.format("ArcadeSurvivorGameModel:getGoodsIdList shopGoodsType error %s", shopGoodsType))
	end

	return result
end

function ArcadeSurvivorGameModel:_generateRandomGoodsIdList(shopId, randomCount, excludeIdDict)
	local result = {}
	local shopParamArr = ArcadeSurvivorConfig.instance:getShopSlotParamList(shopId)

	if randomCount <= 0 then
		return result
	end

	local pickedDict = {}

	if excludeIdDict then
		for goodsId in pairs(excludeIdDict) do
			pickedDict[goodsId] = true
		end
	end

	local goodsSpecTagDict = {}

	for _, strSlotParam in ipairs(shopParamArr) do
		local arr = string.split(strSlotParam, "#")
		local index = tonumber(arr[1])
		local tag = arr[2]

		if index then
			goodsSpecTagDict[index] = tag
		else
			logError("getGoodsIdList error: " .. tostring(strSlotParam))
		end
	end

	local totalRareWeight = 0
	local rareWeightList = ArcadeSurvivorConfig.instance:getShopWeightList(shopId)

	rareWeightList = self._ruleModel:adjustShopWeightList(rareWeightList)

	for i = 1, #rareWeightList do
		totalRareWeight = totalRareWeight + rareWeightList[i]
	end

	local collectionWeightArr = ArcadeSurvivorConfig.instance:getShopTagWeightList(shopId)
	local characterMO = self:getCharacterMO()

	for i = 1, randomCount do
		local specTag = goodsSpecTagDict[i]
		local randomRare
		local canBuyCollectionIdList = {}

		if specTag then
			local tagRareWeightList = {}
			local tagRare2IdListDict = {}
			local totalTagRareWeight = 0

			for rareIndex = 1, #rareWeightList do
				local rareIdList = self:getAvailableCollectionIdList(rareIndex, specTag, pickedDict)

				tagRare2IdListDict[rareIndex] = rareIdList

				local weight = #rareIdList > 0 and rareWeightList[rareIndex] or 0

				tagRareWeightList[rareIndex] = weight
				totalTagRareWeight = totalTagRareWeight + weight
			end

			randomRare = ArcadeGameHelper.getRandomIndex(tagRareWeightList, totalTagRareWeight)

			if randomRare then
				canBuyCollectionIdList = tagRare2IdListDict[randomRare]
			else
				specTag = nil
			end
		end

		if not randomRare then
			randomRare = ArcadeGameHelper.getRandomIndex(rareWeightList, totalRareWeight)
			canBuyCollectionIdList = self:getAvailableCollectionIdList(randomRare, specTag, pickedDict)
		end

		local totalCollectionWeight = 0
		local collectionIdList = {}
		local collectionWeightList = {}

		for _, collectionId in ipairs(canBuyCollectionIdList) do
			local haveTag = false
			local tagList = ArcadeSurvivorConfig.instance:getCollectionTagIds(collectionId)

			if tagList then
				for _, tag in ipairs(tagList) do
					haveTag = characterMO:getHaveCollectionTag(tag)

					if haveTag then
						break
					end
				end
			end

			local collectionWeight = haveTag and collectionWeightArr[2] or collectionWeightArr[1]

			collectionIdList[#collectionIdList + 1] = collectionId
			collectionWeightList[#collectionWeightList + 1] = collectionWeight
			totalCollectionWeight = totalCollectionWeight + collectionWeight
		end

		local randomIndex = ArcadeGameHelper.getRandomIndex(collectionWeightList, totalCollectionWeight)
		local collectionId = collectionIdList[randomIndex]

		if collectionId then
			result[#result + 1] = collectionId
			pickedDict[collectionId] = true
		end
	end

	return result
end

function ArcadeSurvivorGameModel:getChoiceIdList(packId, needCount, excludeIdDict)
	local result = {}
	local rarityWeightList = ArcadeSurvivorConfig.instance:getPackRarityWeightList(packId)

	needCount = needCount or ArcadeSurvivorConfig.instance:getPackOptionCount(packId)

	local totalRarityWeight = 0

	for _, weight in ipairs(rarityWeightList) do
		totalRarityWeight = totalRarityWeight + weight
	end

	if needCount <= 0 or totalRarityWeight <= 0 then
		return result
	end

	local pickedDict = {}

	if excludeIdDict then
		for id in pairs(excludeIdDict) do
			pickedDict[id] = true
		end
	end

	for _ = 1, needCount do
		local rarity = ArcadeGameHelper.getRandomIndex(rarityWeightList, totalRarityWeight)
		local collectionIdList = self:getAvailableCollectionIdList(rarity, nil, pickedDict)

		if #collectionIdList > 0 then
			local collectionId = collectionIdList[math.random(#collectionIdList)]

			result[#result + 1] = collectionId
			pickedDict[collectionId] = true
		end
	end

	return result
end

function ArcadeSurvivorGameModel:getDelayHitRecordList()
	local result = {}
	local record = self._delayHitRecordHead
	local index = 0

	while record do
		index = index + 1
		result[index] = record
		record = self._delayHitRecordNextDict[record]
	end

	return result
end

function ArcadeSurvivorGameModel:hasDelayHitRecord(entityType, uid, skillUid)
	local typeDict = self._delayHitWaitCountByCasterSkillDict[entityType]
	local uidDict = typeDict and typeDict[uid]
	local count = uidDict and uidDict[skillUid]

	return count ~= nil and count > 0
end

function ArcadeSurvivorGameModel:getDelayAlertDict()
	local result = {}

	for gridId, recordList in pairs(self._grid2DelayHitRecord) do
		local minRemainTurn

		for _, record in ipairs(recordList) do
			if record:getNeedAlert() then
				local remainTurn = record:getRemainTurn()

				if not minRemainTurn or remainTurn < minRemainTurn then
					minRemainTurn = remainTurn
				end
			end
		end

		if minRemainTurn then
			result[gridId] = minRemainTurn
		end
	end

	return result
end

function ArcadeSurvivorGameModel:getShopRefreshBaseCount()
	return self._shopRefreshBaseCount or 0
end

function ArcadeSurvivorGameModel:getIsLockGoods(shopType, goodsId)
	local goodsIdDict = shopType and self._lockGoodsDict[shopType]

	return goodsIdDict and goodsIdDict[goodsId]
end

function ArcadeSurvivorGameModel:getLockGoodsDict(shopType)
	local goodsIdDict = shopType and self._lockGoodsDict[shopType]

	return goodsIdDict
end

function ArcadeSurvivorGameModel:getLockGoodsIdList(shopType)
	local result = {}
	local goodsIdDict = self:getLockGoodsDict(shopType)

	if not goodsIdDict then
		return result
	end

	for goodsId, index in pairs(goodsIdDict) do
		result[#result + 1] = {
			id = goodsId,
			index = index
		}
	end

	table.sort(result, function(a, b)
		return a.index < b.index
	end)

	return result
end

function ArcadeSurvivorGameModel:getLockGoodsSaveStr()
	local result = {}

	for shopType, goodsIdDict in pairs(self._lockGoodsDict) do
		local goodsIdList = {}

		for goodsId, index in pairs(goodsIdDict) do
			if index then
				goodsIdList[#goodsIdList + 1] = string.format("%s:%s", tostring(goodsId), tostring(index))
			end
		end

		if #goodsIdList > 0 then
			result[#result + 1] = string.format("%s_%s", tostring(shopType), table.concat(goodsIdList, "#"))
		end
	end

	return table.concat(result, "|")
end

ArcadeSurvivorGameModel.instance = ArcadeSurvivorGameModel.New()

return ArcadeSurvivorGameModel
