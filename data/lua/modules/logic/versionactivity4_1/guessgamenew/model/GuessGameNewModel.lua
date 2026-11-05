-- chunkname: @modules/logic/versionactivity4_1/guessgamenew/model/GuessGameNewModel.lua

module("modules.logic.versionactivity4_1.guessgamenew.model.GuessGameNewModel", package.seeall)

local GuessGameNewModel = class("GuessGameNewModel", BaseModel)

function GuessGameNewModel:onInit()
	self:reInit()
end

function GuessGameNewModel:reInit()
	return
end

function GuessGameNewModel:initGameData()
	self._gameScore = GuessGameNewConfig.instance:getConstNumberValue(GuessGameNewEnum.ConstId.GameBaseScore)
	self._searchCount = GuessGameNewConfig.instance:getConstNumberValue(GuessGameNewEnum.ConstId.GuideTimes)
	self._curPlayRole = 0
	self._curRound = 0
	self._targetBelieveTimes = 0
	self._targetDoubtTimes = 0
	self._lastRoundPlayRole = 0

	self:_initRoleData()
	self:initRoundData()
end

function GuessGameNewModel:_initRoleData()
	self._roleList = {}

	for _, roleType in pairs(GuessGameNewEnum.RoleType) do
		local roleMo = GuessGameNewRoleMo.New()

		roleMo:init(roleType)

		self._roleList[roleType] = roleMo
	end

	self:_setRoleNpcs()
end

function GuessGameNewModel:_setRoleNpcs()
	local dt = ServerTime.nowDateInLocal()
	local weekDay = TimeUtil.getTodayWeedDay(dt)
	local roleCo = GuessGameNewConfig.instance:getWeekRoleCo(weekDay)

	if not roleCo then
		logError("Please check weekRoleCo, it has not match weekDay Config!")

		return
	end

	local gameRoles = string.splitToNumber(roleCo.gameroles, "#")

	gameRoles = GameUtil.randomTable(gameRoles)

	if #gameRoles < GuessGameNewEnum.NpcCount then
		logError("Please check gameroles, it has not match Roles!")

		return
	end

	local npcIndex = 0

	for _, roleMo in ipairs(self._roleList) do
		if roleMo.roleType ~= GuessGameNewEnum.RoleType.Player then
			npcIndex = npcIndex + 1

			self._roleList[roleMo.roleType]:setNpc(gameRoles[npcIndex])
		end
	end
end

function GuessGameNewModel:_setGiftDistribution()
	if not self._roleList or #self._roleList <= 0 then
		return
	end

	local cards = self:getInitTableCards()

	if not cards then
		return
	end

	local playerRoleType = GuessGameNewEnum.RoleType.Player
	local cardCount = GuessGameNewEnum.lineCardCount
	local wildCardId = self:getWildCardId()
	local firstDistributeRate = GuessGameNewConfig.instance:getConstNumberValue(GuessGameNewEnum.ConstId.FirstWildCardWeight)
	local isSuccess = wildCardId and wildCardId > 0 and firstDistributeRate >= math.random(1, 10000)

	cards = GameUtil.randomTable(cards)

	if isSuccess then
		local remainCards = self:_removeFirstCardById(cards, wildCardId)
		local npcDealCount = 0

		for _, roleMo in ipairs(self._roleList) do
			if roleMo:getRoleType() ~= playerRoleType then
				local from = npcDealCount * cardCount + 1
				local gifts = GuessGameNewUtil.extractTab(remainCards, from, from + cardCount - 1)

				roleMo:setGifts(gifts)

				npcDealCount = npcDealCount + 1

				logNormal(string.format("distribute card check first player wild card success! role %s get %s", roleMo:getRoleType(), table.concat(gifts, ",")))
			end
		end

		local playerGifts = {
			wildCardId
		}
		local playerRandomGifts = GuessGameNewUtil.extractTab(remainCards, npcDealCount * cardCount + 1, #remainCards)

		for _, giftId in ipairs(playerRandomGifts) do
			table.insert(playerGifts, giftId)
		end

		self._roleList[playerRoleType]:setGifts(playerGifts)
		logNormal(string.format("distribute card check first player wild card success! role %s get %s", playerRoleType, table.concat(playerGifts, ",")))
		logNormal("distribute card check first player wild card success! first distribute player one wild card and other random distribute!")
	else
		for index, roleMo in ipairs(self._roleList) do
			local from = (index - 1) * cardCount + 1
			local gifts = GuessGameNewUtil.extractTab(cards, from, from + cardCount - 1)

			roleMo:setGifts(gifts)
			logNormal(string.format("distribute card check first player wild card fail! role %s get %s", roleMo:getRoleType(), table.concat(gifts, ",")))
		end

		logNormal("distribute card check first player wild card fail! all distribute random!")
	end
end

function GuessGameNewModel:getWildCardId()
	local boxGiftCos = GuessGameNewConfig.instance:getBoxGiftCos()

	for _, boxGiftCo in ipairs(boxGiftCos) do
		if boxGiftCo.type == GuessGameNewEnum.GiftType.Wild then
			return boxGiftCo.id
		end
	end

	return 0
end

function GuessGameNewModel:initRoundData()
	self._giftTabs = {}
	self._giftDistributes = {}
	self._targetGiftId = 0
	self._unlockGifts = {}

	if self._roleList and #self._roleList > 0 then
		for _, roleMo in ipairs(self._roleList) do
			roleMo:resetGiftsState()
		end
	end

	self:_setGiftDistribution()
end

function GuessGameNewModel:getTargetGiftId()
	if self._targetGiftId == 0 then
		self._targetGiftId = math.random(1, 3)
	end

	return self._targetGiftId
end

function GuessGameNewModel:getGiftUnlockCount(giftId)
	return self._unlockGifts[giftId] or 0
end

function GuessGameNewModel:getUnlockGifts()
	return self._unlockGifts or {}
end

function GuessGameNewModel:setUnlockGifts(gifts)
	for _, giftId in pairs(gifts) do
		if not self._unlockGifts[giftId] then
			self._unlockGifts[giftId] = 1
		else
			self._unlockGifts[giftId] = 1 + self._unlockGifts[giftId]
		end
	end
end

function GuessGameNewModel:getCurRound()
	if self._curRound == 0 then
		self._curRound = 1
	end

	return self._curRound
end

function GuessGameNewModel:increaseCurRound()
	self._curRound = self._curRound + 1
end

function GuessGameNewModel:getCurPlayRole()
	if not self._roleList or #self._roleList <= 0 then
		return 0
	end

	if not self._roleList[GuessGameNewEnum.RoleType.Player] then
		return 0
	end

	if self._roleList[GuessGameNewEnum.RoleType.Player].hp <= 0 then
		return 0
	end

	if self._curPlayRole == 0 then
		local roles = self:getCouldPlayPlayRoles()

		if roles and #roles > 1 then
			if self._lastRoundPlayRole == 0 then
				local roleIndex = GuessGameNewEnum.RoleType.Npc1

				self._curPlayRole = roles[roleIndex]
				self._lastRoundPlayRole = self._curPlayRole
			else
				for i = 1, #roles do
					if roles[i] == self._lastRoundPlayRole and roles[i + 1] then
						self._curPlayRole = roles[i + 1]
					end
				end
			end
		end
	end

	return self._curPlayRole
end

function GuessGameNewModel:setCurPlayRole(roleType)
	if self._curPlayRole and self._curPlayRole ~= 0 and self._curPlayRole ~= roleType then
		self._lastRoundPlayRole = self._curPlayRole
	end

	self._curPlayRole = roleType
end

function GuessGameNewModel:getLastRoundPlayRole()
	return self._lastRoundPlayRole or 0
end

function GuessGameNewModel:getCouldPlayPlayRoles()
	local roles = {}

	for _, roleMo in ipairs(self._roleList) do
		if roleMo.hp > 0 then
			table.insert(roles, roleMo.roleType)
		end
	end

	return roles
end

function GuessGameNewModel:getNextPlayRole()
	if not self._roleList or #self._roleList <= 0 then
		return 0
	end

	if not self._roleList[GuessGameNewEnum.RoleType.Player] then
		return 0
	end

	if self._roleList[GuessGameNewEnum.RoleType.Player].hp <= 0 then
		return 0
	end

	local roles = self:getCouldPlayPlayRoles()
	local roleType = self:getCurPlayRole()

	if roles and #roles > 1 then
		for i = 1, #roles do
			if roles[i] == roleType then
				if roles[i + 1] then
					return roles[i + 1]
				else
					return roles[1]
				end
			end
		end

		return roles[1]
	end

	return 0
end

function GuessGameNewModel:getInitTableCards()
	local episodeCo = GuessGameNewConfig.instance:getEpisodeCo(1)

	if not episodeCo then
		logError("Please check trad_episode, it has not match episode Config for 1!")

		return
	end

	local lays = GameUtil.splitString2(episodeCo.layout, true, "|", "#")

	if not lays then
		logError("Please check trad_episode layout, it has not match episode Config for 1!")

		return
	end

	local cards = {}

	for _, lay in ipairs(lays) do
		for i = 1, lay[2] do
			table.insert(cards, lay[1])
		end
	end

	return cards
end

function GuessGameNewModel:getRoleGifts(roleType)
	local roleMo = self:getRoleData(roleType)

	return roleMo.gifts
end

function GuessGameNewModel:getRoleTemperType(roleType)
	local roleMo = self:getRoleData(roleType)

	if not roleMo or not roleMo.npcConfig then
		return GuessGameNewEnum.TemperType.Radical
	end

	local tabs = GameUtil.splitString2(roleMo.npcConfig.type, true)

	return GuessGameNewUtil.getRandomValueInTabs(tabs)
end

function GuessGameNewModel:recordRolePlay(roleType, selectIndexs)
	local roleMo = self:getRoleData(roleType)

	if not roleMo or not selectIndexs or #selectIndexs <= 0 then
		return
	end

	local targetGiftId = self:getTargetGiftId()
	local hasFake = false

	for _, index in ipairs(selectIndexs) do
		local giftId = roleMo.gifts[index]
		local giftCo = giftId and GuessGameNewConfig.instance:getBoxGiftCo(giftId)
		local isReal = giftId == targetGiftId or giftCo and giftCo.type == GuessGameNewEnum.GiftType.Wild

		if not isReal then
			hasFake = true

			break
		end
	end

	roleMo.playTimes = roleMo.playTimes + 1

	if hasFake then
		roleMo.fakePlayTimes = roleMo.fakePlayTimes + 1
	else
		roleMo.realPlayTimes = roleMo.realPlayTimes + 1
	end

	local isAllReal = not hasFake

	roleMo.lastPlayIsReal = isAllReal
	roleMo.truthStreak = isAllReal and roleMo.truthStreak + 1 or 0
end

function GuessGameNewModel:recordRoleGuessResult(playRoleType, chooseType)
	local roleMo = self:getRoleData(playRoleType)

	if not roleMo then
		return
	end

	if chooseType == GuessGameNewEnum.ChooseType.Doubt then
		roleMo.doubtedStreak = roleMo.doubtedStreak + 1
		self._targetDoubtTimes = self._targetDoubtTimes + 1
	else
		roleMo.doubtedStreak = 0
		self._targetBelieveTimes = self._targetBelieveTimes + 1
	end
end

function GuessGameNewModel:getTargetBelieveTimes()
	return self._targetBelieveTimes or 0
end

function GuessGameNewModel:getTargetDoubtTimes()
	return self._targetDoubtTimes or 0
end

function GuessGameNewModel:setRoleGiftsSelect(roleType, giftIndexs)
	local roleMo = self:getRoleData(roleType)

	roleMo:setGiftsSelect(giftIndexs)
end

function GuessGameNewModel:recordRoleRevealedGiftIndexs(roleType, indexs)
	local roleMo = self:getRoleData(roleType)

	if roleMo then
		roleMo:addRevealedGiftIndexs(indexs)
	end
end

function GuessGameNewModel:reduceRoleHp(roleType)
	local roleMo = self:getRoleData(roleType)

	roleMo:reduceHp()
end

function GuessGameNewModel:_removeFirstCardById(cards, cardId)
	local remainCards = {}
	local removed = false

	for _, card in ipairs(cards) do
		if not removed and card == cardId then
			removed = true
		else
			table.insert(remainCards, card)
		end
	end

	return remainCards
end

function GuessGameNewModel:getRoleDatas()
	return self._roleList
end

function GuessGameNewModel:getRoleData(roleType)
	return self._roleList[roleType]
end

function GuessGameNewModel:addGameScore(score)
	self._gameScore = self._gameScore + score
end

function GuessGameNewModel:getGameScore()
	return self._gameScore
end

function GuessGameNewModel:reduceSearchCount()
	self._searchCount = self._searchCount - 1
end

function GuessGameNewModel:getSearchCount()
	return self._searchCount
end

function GuessGameNewModel:hasMultiRewardCouldGet(actId)
	actId = actId or VersionActivity4_1Enum.ActivityId.GuessGameNew

	local isFirstShow = self:isFirstShow(actId)

	if not isFirstShow then
		return false
	end

	local firstShowTime = PlayerPrefsHelper.getString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.GuessGameNewFirstShowTime), "")

	if not LuaUtil.isEmptyStr(firstShowTime) then
		local nowTime = ServerTime.now()
		local isSameDay = TimeUtil.isSameDay(tonumber(firstShowTime) - TimeDispatcher.DailyRefreshSecond, nowTime - TimeDispatcher.DailyRefreshSecond)

		if isSameDay then
			return false
		end
	end

	local bonusCos = GuessGameNewConfig.instance:getBonusCos(actId)

	for _, bonusCo in pairs(bonusCos) do
		local rewardGet = self:isRewardGet(bonusCo.rewardId, actId)

		if not rewardGet then
			return true
		end
	end

	return false
end

function GuessGameNewModel:getFinishGameCount(actId)
	local finishGameCount = GuessGameModel.instance:getFinishGameCount(actId)

	return finishGameCount
end

function GuessGameNewModel:isFirstShow(actId)
	local isFirstShow = GuessGameModel.instance:isFirstShow(actId)

	return isFirstShow
end

function GuessGameNewModel:getTotalScore(actId)
	local totalScore = GuessGameModel.instance:getTotalScore(actId)

	return totalScore
end

function GuessGameNewModel:getMaxTotalScore(actId)
	local maxTotalScore = GuessGameModel.instance:getMaxTotalScore(actId)

	return maxTotalScore
end

function GuessGameNewModel:getAcceptedRewardId(actId)
	local acceptedRewardId = GuessGameModel.instance:getAcceptedRewardId(actId)

	return acceptedRewardId
end

function GuessGameNewModel:isRewardLock(rewardId, actId)
	local isLock = GuessGameModel.instance:isRewardLock(rewardId, actId)

	return isLock
end

function GuessGameNewModel:isRewardGet(rewardId, actId)
	local isReceive = GuessGameModel.instance:isRewardGet(rewardId, actId)

	return isReceive
end

function GuessGameNewModel:isRewardCanGet(rewardId, actId)
	local canGet = GuessGameModel.instance:isRewardCanGet(rewardId, actId)

	return canGet
end

GuessGameNewModel.instance = GuessGameNewModel.New()

return GuessGameNewModel
