-- chunkname: @modules/logic/rouge2/outside/model/Rouge2_OutsideModel.lua

module("modules.logic.rouge2.outside.model.Rouge2_OutsideModel", package.seeall)

local Rouge2_OutsideModel = class("Rouge2_OutsideModel", BaseModel)

function Rouge2_OutsideModel:onInit()
	self:reInit()
end

function Rouge2_OutsideModel:reInit()
	self._reviewInfoList = {}
	self._rougeGameRecord = nil
	self.newUnlockCollectionList = {}
	self._unlockCollectionDic = {}

	self:_setRougeOutSideInfo()
end

function Rouge2_OutsideModel:onReceiveGetRougeOutsideInfoReply(msg)
	self:updateRougeOutsideInfo(msg.rougeInfo)
end

function Rouge2_OutsideModel:updateRougeOutsideInfo(rougeInfo)
	self:_setRougeOutSideInfo()

	self._rougeGameRecord = self._rougeGameRecord or Rouge2_GameRecordInfoMO.New()

	if rougeInfo.totalRecordInfo then
		self._rougeGameRecord:init(rougeInfo.totalRecordInfo)
	end

	tabletool.clear(self._reviewInfoList)

	if rougeInfo.review then
		for _, info in ipairs(rougeInfo.review) do
			local mo = Rouge2_ReviewMO.New()

			mo:init(info)
			table.insert(self._reviewInfoList, mo)
		end
	end

	Rouge2_OutsideController.instance:dispatchEvent(Rouge2_OutsideEvent.OnUpdateRougeOutsideInfo)
end

function Rouge2_OutsideModel:onGetCollectionInfo(relicts, buffs, autoBuffs)
	tabletool.clear(self.newUnlockCollectionList)
	tabletool.addValues(relicts, buffs)
	tabletool.addValues(relicts, autoBuffs)

	for _, itemId in ipairs(relicts) do
		local config = Rouge2_OutSideConfig.getItemConfig(itemId)

		if config and not string.nilorempty(config.outUnlock) and not self._unlockCollectionDic[itemId] then
			table.insert(self.newUnlockCollectionList, itemId)
			logNormal("肉鸽2 新增解锁造物 id:" .. itemId)
		end
	end

	tabletool.clear(self._unlockCollectionDic)

	for _, itemId in ipairs(relicts) do
		local config = Rouge2_OutSideConfig.getItemConfig(itemId)

		if config and not string.nilorempty(config.outUnlock) and not self._unlockCollectionDic[itemId] then
			-- block empty
		end

		self._unlockCollectionDic[itemId] = true
	end
end

function Rouge2_OutsideModel:getNewUnlockCollectionList()
	return self.newUnlockCollectionList
end

function Rouge2_OutsideModel:getReviewInfoList()
	return self._reviewInfoList
end

function Rouge2_OutsideModel:getRougeGameRecord()
	return self._rougeGameRecord
end

function Rouge2_OutsideModel:_setRougeOutSideInfo()
	self._config = Rouge2_OutSideConfig.instance
end

function Rouge2_OutsideModel:config()
	return self._config
end

function Rouge2_OutsideModel:passedDifficulty()
	if not self._rougeGameRecord then
		return 0
	end

	return self._rougeGameRecord.maxDifficulty or 0
end

function Rouge2_OutsideModel:isPassedDifficulty(difficulty)
	return difficulty <= self:passedDifficulty()
end

function Rouge2_OutsideModel:isOpenedDifficulty(difficulty)
	local difficultyCO = Rouge2_Config.instance:getDifficultyCoById(difficulty)
	local difficultyConfigList = Rouge2_Config.instance:getDifficultyCoList()
	local difficultyCount = #difficultyConfigList

	if difficultyConfigList and difficulty == difficultyConfigList[difficultyCount].difficulty or difficulty == difficultyConfigList[math.max(1, difficultyCount - 1)].difficulty then
		return false
	end

	return self:isPassedDifficulty(difficultyCO.preDifficulty)
end

function Rouge2_OutsideModel:isUnlockCareer(careerId)
	local careerConfig = Rouge2_CareerConfig.instance:getCareerConfig(careerId)
	local unlockCondition = careerConfig and careerConfig.unlock
	local unlockRemainTime = self:getCareerUnlockRemainTime(careerId)

	if unlockRemainTime > 0 then
		return
	end

	if string.nilorempty(unlockCondition) then
		return true
	end

	return true
end

function Rouge2_OutsideModel:getCareerUnlockRemainTime(careerId)
	local careerConfig = Rouge2_CareerConfig.instance:getCareerConfig(careerId)
	local unlockTimeStr = careerConfig and careerConfig.unlockTime

	if string.nilorempty(unlockTimeStr) then
		return 0
	end

	local unlockTime = TimeUtil.stringToTimestamp(unlockTimeStr) - ServerTime.clientToServerOffset()

	return unlockTime - ServerTime.now()
end

function Rouge2_OutsideModel:endCdTs()
	if not self._rougeGameRecord then
		return 0
	end

	local fromTs = self._rougeGameRecord:lastGameEndTimestamp()

	if fromTs <= 0 then
		return 0
	end

	local duration = self._config:getAbortCDDuration()

	if duration == 0 then
		return 0
	end

	return fromTs + duration
end

function Rouge2_OutsideModel:leftCdSec()
	return self:endCdTs() - ServerTime.now()
end

function Rouge2_OutsideModel:isInCdStart()
	return self:leftCdSec() > 0
end

local TRUE = 1
local FALSE = 0

function Rouge2_OutsideModel:getIsNewUnlockDifficulty(difficulty)
	return self:_getUnlockDifficulty(difficulty, FALSE) == TRUE
end

function Rouge2_OutsideModel:setIsNewUnlockDifficulty(difficulty, isNew)
	self:_saveUnlockDifficulty(difficulty, isNew and TRUE or FALSE)
end

local kPrefix = "RougeOutside|"
local kLastMarkPrefix = "LastMark|"

function Rouge2_OutsideModel:_getPrefsKeyPrefix()
	return kPrefix
end

function Rouge2_OutsideModel:_saveInteger(key, value)
	GameUtil.playerPrefsSetNumberByUserId(key, value)
end

function Rouge2_OutsideModel:_getInteger(key, defaultValue)
	return GameUtil.playerPrefsGetNumberByUserId(key, defaultValue)
end

local kDifficultyPrefix = "D|"

function Rouge2_OutsideModel:_getPrefsKeyDifficulty(difficulty)
	assert(type(difficulty) == "number")

	return self:_getPrefsKeyPrefix() .. kDifficultyPrefix .. tostring(difficulty)
end

function Rouge2_OutsideModel:_saveUnlockDifficulty(difficulty, value)
	local playerPrefsKey = self:_getPrefsKeyDifficulty(difficulty)

	self:_saveInteger(playerPrefsKey, value)
end

function Rouge2_OutsideModel:_getUnlockDifficulty(difficulty, defaultValue)
	local playerPrefsKey = self:_getPrefsKeyDifficulty(difficulty)

	return self:_getInteger(playerPrefsKey, defaultValue)
end

function Rouge2_OutsideModel:_getPrefsKeyLastMarkDifficulty()
	return self:_getPrefsKeyPrefix() .. kLastMarkPrefix .. kDifficultyPrefix
end

function Rouge2_OutsideModel:setLastMarkSelectedDifficulty(value)
	local playerPrefsKey = self:_getPrefsKeyLastMarkDifficulty()

	self:_saveInteger(playerPrefsKey, value)
end

function Rouge2_OutsideModel:getLastMarkSelectedDifficulty(defaultValue)
	local playerPrefsKey = self:_getPrefsKeyLastMarkDifficulty()

	return self:_getInteger(playerPrefsKey, defaultValue)
end

function Rouge2_OutsideModel:passedLayerId(layerId)
	if layerId then
		return true
	end

	if not self._rougeGameRecord then
		return false
	end

	return self._rougeGameRecord:passedLayerId(layerId)
end

function Rouge2_OutsideModel:collectionIsPass(id)
	if not self._rougeGameRecord then
		return false
	end

	return self._rougeGameRecord:collectionIsPass(id)
end

function Rouge2_OutsideModel:storyIsPass(id)
	if not self._rougeGameRecord then
		return false
	end

	return self._rougeGameRecord:storyIsPass(id)
end

function Rouge2_OutsideModel:collectionIsUnlock(id)
	return self._unlockCollectionDic[id]
end

function Rouge2_OutsideModel:passedAnyEventId(list)
	for i, v in ipairs(list) do
		if self:passedEventId(v) then
			return true
		end
	end

	return false
end

function Rouge2_OutsideModel:passedEventId(eventId)
	if not self._rougeGameRecord then
		return false
	end

	return self._rougeGameRecord:passedEventId(eventId)
end

function Rouge2_OutsideModel:passAnyOneEnd()
	return self._rougeGameRecord and self._rougeGameRecord:passAnyOneEnd()
end

function Rouge2_OutsideModel:passEndId(endId)
	return self._rougeGameRecord and self._rougeGameRecord:passEndId(endId)
end

function Rouge2_OutsideModel:passEntrustId(entrustId)
	return self._rougeGameRecord and self._rougeGameRecord:passEntrustId(entrustId)
end

function Rouge2_OutsideModel:switchCollectionInfoType()
	local curInfoType = self:getCurCollectionInfoType()
	local isCurComplex = curInfoType == Rouge2_OutsideEnum.CollectionInfoType.Complex

	self._curInfoType = isCurComplex and Rouge2_OutsideEnum.CollectionInfoType.Simple or Rouge2_OutsideEnum.CollectionInfoType.Complex

	Rouge2_OutsideController.instance:dispatchEvent(Rouge2_OutsideEvent.SwitchCollectionInfoType)
	self:_saveCollectionInfoType(self._curInfoType)
end

function Rouge2_OutsideModel:getCurCollectionInfoType()
	if not self._curInfoType then
		local key = self:_getCollectionInfoTypeSaveKey()

		self._curInfoType = tonumber(PlayerPrefsHelper.getNumber(key, Rouge2_OutsideEnum.DefaultCollectionInfoType))
	end

	return self._curInfoType
end

function Rouge2_OutsideModel:_saveCollectionInfoType(infoType)
	infoType = infoType or Rouge2_OutsideEnum.DefaultCollectionInfoType

	local key = self:_getCollectionInfoTypeSaveKey()

	PlayerPrefsHelper.setNumber(key, infoType)
end

function Rouge2_OutsideModel:_getCollectionInfoTypeSaveKey()
	local key = string.format("%s_%s", PlayerModel.instance:getMyUserId(), PlayerPrefsKey.Rouge2CollectionInfoType)

	return key
end

Rouge2_OutsideModel.instance = Rouge2_OutsideModel.New()

return Rouge2_OutsideModel
