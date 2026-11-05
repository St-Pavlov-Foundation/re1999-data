-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/controller/game/ArcadeSurvivorStatHelper.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.controller.game.ArcadeSurvivorStatHelper", package.seeall)

local ArcadeSurvivorStatHelper = class("ArcadeSurvivorStatHelper")
local SettleTypeName = {
	[ArcadeSurvivorGameEnum.SettleType.Abandon] = "abandon",
	[ArcadeSurvivorGameEnum.SettleType.Win] = "win",
	[ArcadeSurvivorGameEnum.SettleType.Fail] = "fail"
}

function ArcadeSurvivorStatHelper:ctor()
	self.gameStartTime = 0
	self.levelStartTime = 0
	self.levelRespawnUseTimes = 0
	self.collectionAppearCountDict = {}
end

function ArcadeSurvivorStatHelper:_buildOutsideObj()
	local unlockRoleList = {}
	local moList = ArcadeSurvivorHandBookModel.instance:getMOListByType(ArcadeSurvivorHallEnum.HandBookType.Character)

	if moList then
		for _, mo in ipairs(moList) do
			if not mo:isLock() then
				table.insert(unlockRoleList, mo:getId())
			end
		end
	end

	local talentList = {}
	local talentMOList = ArcadeSurvivorHeroModel.instance:getTalentMOList()

	for _, talentMO in ipairs(talentMOList) do
		table.insert(talentList, string.format("%s_%s", talentMO:getId(), talentMO:getLevel()))
	end

	local outsideObj = {
		gem = ArcadeSurvivorOutSideModel.instance:getOutsideCurrencyCount(ArcadeSurvivorEnum.Currency.Diamond),
		unlock_role_list = unlockRoleList,
		talent_list = talentList
	}

	return outsideObj
end

function ArcadeSurvivorStatHelper:_buildGameObj(serverSaveInfo)
	if serverSaveInfo then
		local propInfo = serverSaveInfo.prop
		local playerInfo = serverSaveInfo.player
		local difficulty = propInfo and propInfo.difficulty or 0
		local stageIndex = propInfo and propInfo.stageIndex or 0
		local levelIndex = propInfo and propInfo.LevelIndex or 0
		local stageId, levelId

		if difficulty and stageIndex then
			stageId = ArcadeSurvivorConfig.instance:getDifficultyStageId(difficulty, stageIndex)

			if stageId then
				levelId = ArcadeSurvivorConfig.instance:getStageLevelId(stageId, levelIndex)
			end
		end

		local gameObj = {
			character = playerInfo and playerInfo.id or 0,
			difficulty = difficulty,
			stage = stageId or 0,
			level = levelId or 0
		}

		return gameObj
	end

	local gameModel = ArcadeSurvivorGameModel.instance
	local characterMO = gameModel:getCharacterMO()
	local gameObj = {
		character = characterMO and characterMO:getId() or 0,
		difficulty = gameModel:getDifficulty(),
		stage = gameModel:getCurStageId(),
		level = gameModel:getCurLevelId()
	}

	return gameObj
end

function ArcadeSurvivorStatHelper:_buildLevelObj()
	local characterMO = ArcadeSurvivorGameModel.instance:getCharacterMO()
	local hp = 0
	local hpCap = 0
	local respawnTimes = 0

	if characterMO then
		hp = characterMO:getHp()
		hpCap = characterMO:getAttrValue(ArcadeSurvivorEnum.Attribute.hpCap)
		respawnTimes = characterMO:getAttrValue(ArcadeSurvivorEnum.Attribute.respawnTimes)
	end

	local levelObj = {
		hp = hp,
		hp_max = hpCap,
		have_respawns = respawnTimes,
		use_respawns = self.levelRespawnUseTimes
	}

	return levelObj
end

function ArcadeSurvivorStatHelper:_buildCollectionInfo(serverSaveInfo)
	if serverSaveInfo then
		local collectionCountDict = {}
		local collectionContainer = serverSaveInfo.collectionContainer
		local collectionList = collectionContainer and collectionContainer.collections

		if collectionList then
			for _, collection in ipairs(collectionList) do
				local collectionId = collection.id

				if collectionId then
					collectionCountDict[collectionId] = collection.count or 0
				end
			end
		end

		local collectionInfo = self:_buildCollectionList(collectionCountDict)

		return collectionInfo
	end

	local characterMO = ArcadeSurvivorGameModel.instance:getCharacterMO()
	local collectionCountDict = characterMO and characterMO:getCollectionDict()
	local collectionInfo = self:_buildCollectionList(collectionCountDict)

	return collectionInfo
end

function ArcadeSurvivorStatHelper:_buildCollectionAppearInfo()
	return self:_buildCollectionList(self.collectionAppearCountDict)
end

function ArcadeSurvivorStatHelper:_buildCollectionList(collectionCountDict)
	local collectionList = {}

	if collectionCountDict then
		for collectionId, count in pairs(collectionCountDict) do
			local data = {
				id = collectionId,
				count = count
			}

			table.insert(collectionList, data)
		end
	end

	table.sort(collectionList, function(a, b)
		return a.id < b.id
	end)

	return collectionList
end

function ArcadeSurvivorStatHelper:_buildSettleGameBaseObj(serverSaveInfo)
	if serverSaveInfo then
		local resultStatisticsDict = {}
		local propInfo = serverSaveInfo.prop
		local customMap = propInfo and propInfo.customMap

		if customMap then
			for _, mapEntry in ipairs(customMap) do
				local key = mapEntry.key

				if ArcadeSurvivorGameEnum.CustomSaveResultStatisticsKeyDict[key] then
					resultStatisticsDict[key] = tonumber(mapEntry.val) or 0
				end
			end
		end

		local gainGem = 0
		local extendInfo = serverSaveInfo.extendInfo
		local currencyList = extendInfo and extendInfo.currency

		if currencyList then
			for _, currencyInfo in ipairs(currencyList) do
				if currencyInfo.id == ArcadeSurvivorEnum.Currency.Diamond then
					gainGem = currencyInfo.count or 0
				end
			end
		end

		local gameBaseObj = {
			all_coin = resultStatisticsDict[ArcadeSurvivorGameEnum.CustomSaveInfoKey.TotalGainCoin] or 0,
			max_kill = resultStatisticsDict[ArcadeSurvivorGameEnum.CustomSaveInfoKey.KillMonsterNum] or 0,
			all_rooms = resultStatisticsDict[ArcadeSurvivorGameEnum.CustomSaveInfoKey.PassLevelCount] or 0,
			gain_gem = gainGem
		}

		return gameBaseObj
	end

	local gameModel = ArcadeSurvivorGameModel.instance
	local gameBaseObj = {
		all_coin = gameModel:getResultStatistics(ArcadeSurvivorGameEnum.CustomSaveInfoKey.TotalGainCoin),
		max_kill = gameModel:getResultStatistics(ArcadeSurvivorGameEnum.CustomSaveInfoKey.KillMonsterNum),
		all_rooms = gameModel:getResultStatistics(ArcadeSurvivorGameEnum.CustomSaveInfoKey.PassLevelCount),
		gain_gem = gameModel:getCurrencyCount(ArcadeSurvivorEnum.Currency.Diamond)
	}

	return gameBaseObj
end

function ArcadeSurvivorStatHelper:recordEnterLevel()
	self.levelStartTime = UnityEngine.Time.realtimeSinceStartup
	self.levelRespawnUseTimes = 0
end

function ArcadeSurvivorStatHelper:recordRespawn()
	self.levelRespawnUseTimes = self.levelRespawnUseTimes + 1
end

function ArcadeSurvivorStatHelper:recordCollectionAppear(collectionId)
	if not collectionId then
		return
	end

	self.collectionAppearCountDict[collectionId] = (self.collectionAppearCountDict[collectionId] or 0) + 1
end

function ArcadeSurvivorStatHelper:sendTalentUpgrade(talentId, level)
	StatController.instance:track(StatEnum.EventName.ArcadeTalentUpgrade, {
		[StatEnum.EventProperties.ArcadeTalentId] = talentId,
		[StatEnum.EventProperties.ArcadeTalentLevel] = level
	})
end

function ArcadeSurvivorStatHelper:sendStartGame(isRestart, isReset)
	self.collectionAppearCountDict = {}
	self.gameStartTime = UnityEngine.Time.realtimeSinceStartup
	self.isRestartGame = isRestart

	StatController.instance:track(StatEnum.EventName.ArcadeSurvivorStart, {
		[StatEnum.EventProperties.ArcadeSurvivorOutsideObj] = self:_buildOutsideObj(),
		[StatEnum.EventProperties.ArcadeSurvivorGameObj] = self:_buildGameObj(),
		[StatEnum.EventProperties.ArcadeSurvivorIsReset] = isReset == true,
		[StatEnum.EventProperties.ArcadeSurvivorIsRestart] = isRestart == true
	})
end

function ArcadeSurvivorStatHelper:sendEndGame(settleType, isReset, serverSaveInfo)
	local outsideObj = self:_buildOutsideObj()
	local gameObj = self:_buildGameObj(serverSaveInfo)
	local collectionInfo = self:_buildCollectionInfo(serverSaveInfo)
	local collectionAppearInfo = self:_buildCollectionAppearInfo()
	local gameBaseObj = self:_buildSettleGameBaseObj(serverSaveInfo)
	local useTime = 0

	if not serverSaveInfo then
		useTime = UnityEngine.Time.realtimeSinceStartup - self.gameStartTime
	end

	StatController.instance:track(StatEnum.EventName.ArcadeSurvivorGame, {
		[StatEnum.EventProperties.ArcadeSurvivorOutsideObj] = outsideObj,
		[StatEnum.EventProperties.ArcadeSurvivorGameObj] = gameObj,
		[StatEnum.EventProperties.ArcadeSurvivorCollectionInfo] = collectionInfo,
		[StatEnum.EventProperties.ArcadeSurvivorCollectionAppearInfo] = collectionAppearInfo,
		[StatEnum.EventProperties.ArcadeGameBaseObj] = gameBaseObj,
		[StatEnum.EventProperties.Usetime_Num] = useTime,
		[StatEnum.EventProperties.OperationType] = SettleTypeName[settleType],
		[StatEnum.EventProperties.ArcadeSurvivorIsReset] = isReset == true,
		[StatEnum.EventProperties.ArcadeSurvivorIsRestart] = self.isRestartGame == true
	})
end

function ArcadeSurvivorStatHelper:sendFinishLevel()
	StatController.instance:track(StatEnum.EventName.ArcadeSurvivorLevel, {
		[StatEnum.EventProperties.ArcadeSurvivorOutsideObj] = self:_buildOutsideObj(),
		[StatEnum.EventProperties.ArcadeSurvivorGameObj] = self:_buildGameObj(),
		[StatEnum.EventProperties.ArcadeSurvivorLevelObj] = self:_buildLevelObj(),
		[StatEnum.EventProperties.ArcadeSurvivorCollectionInfo] = self:_buildCollectionInfo(),
		[StatEnum.EventProperties.ArcadeSurvivorCollectionAppearInfo] = self:_buildCollectionAppearInfo(),
		[StatEnum.EventProperties.Usetime_Num] = UnityEngine.Time.realtimeSinceStartup - self.levelStartTime
	})
end

ArcadeSurvivorStatHelper.instance = ArcadeSurvivorStatHelper.New()

return ArcadeSurvivorStatHelper
