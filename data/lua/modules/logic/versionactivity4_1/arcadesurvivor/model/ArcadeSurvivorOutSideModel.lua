-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/model/ArcadeSurvivorOutSideModel.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.model.ArcadeSurvivorOutSideModel", package.seeall)

local ArcadeSurvivorOutSideModel = class("ArcadeSurvivorOutSideModel", BaseModel)

function ArcadeSurvivorOutSideModel:onInit()
	self:reInit()
end

function ArcadeSurvivorOutSideModel:reInit()
	if self._rewardModel then
		self._rewardModel:clear()
	end

	self._rewardModel = nil
	self._currencyDict = {}
	self._difficultyPassDict = {}
	self._accumKillCount = 0
end

function ArcadeSurvivorOutSideModel:refreshInfo(info)
	ArcadeSurvivorHandBookModel.instance:refreshInfo(info.bookInfo)
	ArcadeSurvivorHeroModel.instance:refreshTalentInfo(info.talentInfo)
	ArcadeSurvivorHeroModel.instance:refreshPlayerInfo(info.role)
	self:_refreshPropInfo(info.prop)
end

function ArcadeSurvivorOutSideModel:_refreshPropInfo(propInfo)
	self:_refreshHotfixInfo(propInfo.hotfix)
	self:_refreshRewardInfo(propInfo.gain)
	self:_refreshHeroInfo(propInfo.unlockRoleIds)
	self:_refreshUnlockDifficultyInfo(propInfo.unlockDifficultyIds)
	self:_refreshDifficultyPassCount(propInfo.difficultyId2passCount)
	self:refreshCurrencyCount(propInfo.currency)

	self._accumKillCount = propInfo.accumKillCount or 0
end

function ArcadeSurvivorOutSideModel:_refreshHotfixInfo(hotfix)
	return
end

function ArcadeSurvivorOutSideModel:_refreshRewardInfo(gain)
	local dict = {}

	if gain then
		for i = 1, #gain do
			local rewardId = gain[i]

			dict[rewardId] = true
		end
	end

	local rewardList = self:getRewardList()

	for _, mo in ipairs(rewardList) do
		local id = mo:getId()
		local isGain = dict[id]

		mo:onGain(isGain)
	end
end

function ArcadeSurvivorOutSideModel:_refreshHeroInfo(unlockRoleIds)
	local dict = {}

	if unlockRoleIds then
		for i = 1, #unlockRoleIds do
			local roleId = unlockRoleIds[i]

			dict[roleId] = true
		end
	end

	local moList = ArcadeSurvivorHandBookModel.instance:getMOListByType(ArcadeSurvivorHallEnum.HandBookType.Character)

	for _, mo in pairs(moList) do
		local id = mo:getId()
		local isUnlock = dict[id]

		mo:setLock(not isUnlock)
	end
end

function ArcadeSurvivorOutSideModel:_refreshUnlockDifficultyInfo(unlockDifficultyIds)
	self._unlockDifficulty = {}

	if unlockDifficultyIds then
		for i = 1, #unlockDifficultyIds do
			local difficulty = unlockDifficultyIds[i]

			self._unlockDifficulty[difficulty] = true
		end
	end
end

function ArcadeSurvivorOutSideModel:_refreshDifficultyPassCount(strPassCount)
	self._difficultyPassDict = {}

	if string.nilorempty(strPassCount) then
		return
	end

	local split = GameUtil.splitString2(strPassCount, true, "|", "#")

	for _, v in ipairs(split) do
		local difficulty = v[1]
		local passCount = v[2]

		self._difficultyPassDict[difficulty] = passCount
	end
end

function ArcadeSurvivorOutSideModel:refreshCurrencyCount(currencyInfo)
	self._currencyDict = {}

	if currencyInfo then
		for i = 1, #currencyInfo do
			local info = currencyInfo[i]
			local currencyId = info.id

			self._currencyDict[currencyId] = info.count
		end
	end
end

function ArcadeSurvivorOutSideModel:updateCurrencyCount(currencyInfo)
	if not currencyInfo then
		return
	end

	for i = 1, #currencyInfo do
		local info = currencyInfo[i]
		local currencyId = info.id

		self._currencyDict[currencyId] = info.count or 0
	end
end

function ArcadeSurvivorOutSideModel:onFinishReward()
	local rewardList = self:getRewardList()

	for _, mo in ipairs(rewardList) do
		local rewardState = mo:getRewardState()

		if rewardState == ArcadeSurvivorHallEnum.RewardItemStatus.CanGet then
			mo:onGain(true)
		end
	end
end

function ArcadeSurvivorOutSideModel:getAccumKillCount()
	return self._accumKillCount or 0
end

function ArcadeSurvivorOutSideModel:isUnlockDifficulty(difficulty)
	return self._unlockDifficulty and self._unlockDifficulty[difficulty]
end

function ArcadeSurvivorOutSideModel:getOutsideCurrencyCount(currencyId)
	local value = self._currencyDict[currencyId] or 0

	return value
end

function ArcadeSurvivorOutSideModel:getScore()
	return self:getOutsideCurrencyCount(ArcadeSurvivorEnum.Currency.Cassette)
end

function ArcadeSurvivorOutSideModel:getFinishDifficultyCount(difficulty, isMergeGreater)
	local passDict = self._difficultyPassDict

	if not isMergeGreater then
		local passCount = passDict and passDict[difficulty] or 0

		return passCount
	end

	local finishCount = 0

	if passDict then
		for passDifficulty, passCount in pairs(passDict) do
			if difficulty <= passDifficulty then
				finishCount = finishCount + passCount
			end
		end
	end

	return finishCount
end

function ArcadeSurvivorOutSideModel:getRewardModel()
	if not self._rewardModel then
		self._rewardModel = BaseModel.New()

		local actId = ArcadeSurvivorModel.instance:getAct247Id()

		for _, cfg in ipairs(lua_arcade_survivor_reward.configList) do
			if cfg.activityId == actId then
				local mo = ArcadeSurvivorRewardMO.New(cfg)

				self._rewardModel:addAtLast(mo)
			end
		end
	end

	return self._rewardModel
end

function ArcadeSurvivorOutSideModel:getRewardList()
	local model = self:getRewardModel()

	return model:getList()
end

function ArcadeSurvivorOutSideModel:hasRewardReddot()
	local reddot = ArcadeSurvivorConfig.instance:getHallUnitReddot(ArcadeSurvivorHallEnum.HallInteractiveUnitId.Task)

	return RedDotModel.instance:isDotShow(reddot, 0)
end

function ArcadeSurvivorOutSideModel:getPlayerPrefsKey(pref, key)
	local actId = ArcadeSurvivorModel.instance:getAct247Id()

	return string.format("ArcadeSurvivor_%s_%s_%s", pref, actId, key)
end

function ArcadeSurvivorOutSideModel:getPlayerPrefsValue(pref, key, defaultValue, isNumber)
	local tKey = self:getPlayerPrefsKey(pref, key or "")

	if isNumber then
		return GameUtil.playerPrefsGetNumberByUserId(tKey, defaultValue)
	else
		return GameUtil.playerPrefsGetStringByUserId(tKey, defaultValue)
	end
end

function ArcadeSurvivorOutSideModel:setPlayerPrefsValue(pref, key, value, isNumber)
	local tKey = self:getPlayerPrefsKey(pref, key or "")

	if isNumber then
		GameUtil.playerPrefsSetNumberByUserId(tKey, value)
	else
		GameUtil.playerPrefsSetStringByUserId(tKey, value)
	end
end

ArcadeSurvivorOutSideModel.instance = ArcadeSurvivorOutSideModel.New()

return ArcadeSurvivorOutSideModel
