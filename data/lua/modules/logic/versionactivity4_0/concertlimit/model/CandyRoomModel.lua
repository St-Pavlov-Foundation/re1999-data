-- chunkname: @modules/logic/versionactivity4_0/concertlimit/model/CandyRoomModel.lua

module("modules.logic.versionactivity4_0.concertlimit.model.CandyRoomModel", package.seeall)

local CandyRoomModel = class("CandyRoomModel", BaseModel)

function CandyRoomModel:onInit()
	self:reInit()
end

function CandyRoomModel:reInit()
	self._summonInfoMOs = {}
end

function CandyRoomModel:setAct245Infos(msg)
	local actId = msg.activitiyId or VersionActivity4_0Enum.ActivityId.ConcertCandyRoom

	if not self._summonInfoMOs[actId] then
		self._summonInfoMOs[actId] = {}
	end

	for _, info in ipairs(msg.summonedInfos) do
		if not self._summonInfoMOs[actId][info.rewardId] then
			self._summonInfoMOs[actId][info.rewardId] = CandyRoomSummonInfoMO.New()

			self._summonInfoMOs[actId][info.rewardId]:init()
		end

		self._summonInfoMOs[actId][info.rewardId]:refresh(info)
	end
end

function CandyRoomModel:getSummonedCountByRewardId(rewardId, actId)
	actId = actId or VersionActivity4_0Enum.ActivityId.ConcertCandyRoom

	if self._summonInfoMOs[actId] and self._summonInfoMOs[actId][rewardId] then
		return self._summonInfoMOs[actId][rewardId]:getSummonedCount()
	end

	return 0
end

function CandyRoomModel:updateSummonedCounts(rewardIds, actId)
	actId = actId or VersionActivity4_0Enum.ActivityId.ConcertCandyRoom

	for _, rewardId in ipairs(rewardIds) do
		if not self._summonInfoMOs[actId] then
			self._summonInfoMOs[actId] = {}
		end

		if not self._summonInfoMOs[actId][rewardId] then
			self._summonInfoMOs[actId][rewardId] = CandyRoomSummonInfoMO.New()

			self._summonInfoMOs[actId][rewardId]:init()
		end

		self._summonInfoMOs[actId][rewardId]:addSummonedCount(1)
	end
end

function CandyRoomModel:getLimitTimeCount(actId)
	actId = actId or VersionActivity4_0Enum.ActivityId.ConcertCandyRoom

	local act245Co = CandyRoomConfig.instance:getActivity245Co(actId)
	local currencyId = act245Co.ticketId
	local itemCount = ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Currency, currencyId)
	local totalSummonCount = self:getTotalSummonCount(actId)
	local hasSummonCount = self:getHasSummonCount(actId)
	local couldSummonCount = totalSummonCount - hasSummonCount > 0 and totalSummonCount - hasSummonCount or 0

	return math.min(itemCount, couldSummonCount)
end

function CandyRoomModel:getTotalSummonCount(actId)
	actId = actId or VersionActivity4_0Enum.ActivityId.ConcertCandyRoom

	local count = 0
	local rewardCos = CandyRoomConfig.instance:getActivity245RewardCos(actId)

	for _, rewardCo in pairs(rewardCos) do
		count = count + rewardCo.availableTime
	end

	return count
end

function CandyRoomModel:getHasSummonCount(actId)
	actId = actId or VersionActivity4_0Enum.ActivityId.ConcertCandyRoom

	local count = 0

	if not self._summonInfoMOs[actId] then
		return count
	end

	for _, info in pairs(self._summonInfoMOs[actId]) do
		count = count + info:getSummonedCount()
	end

	return count
end

function CandyRoomModel:getActRewardCos(actId)
	actId = actId or VersionActivity4_0Enum.ActivityId.ConcertCandyRoom

	local rewardCos = CandyRoomConfig.instance:getActivity245RewardCos(actId)

	table.sort(rewardCos, function(a, b)
		return a.sort < b.sort
	end)

	return rewardCos
end

function CandyRoomModel:isAllRewardGet(actId)
	local rewardCos = CandyRoomConfig.instance:getActivity245RewardCos(actId)

	for _, rewardCo in pairs(rewardCos) do
		if not self._summonInfoMOs[actId] or not self._summonInfoMOs[actId][rewardCo.id] or self._summonInfoMOs[actId][rewardCo.id]:getSummonedCount() < rewardCo.availableTime then
			return false
		end
	end

	return true
end

function CandyRoomModel:getActShowSortRewardCos(actId)
	actId = actId or VersionActivity4_0Enum.ActivityId.ConcertCandyRoom

	local sortRewards = {}
	local rewardCos = CandyRoomModel.instance:getActRewardCos(actId)

	for i = 1, #rewardCos do
		if (i - 1) % 2 == 0 then
			table.insert(sortRewards, 1, rewardCos[i])
		else
			table.insert(sortRewards, rewardCos[i])
		end
	end

	return sortRewards
end

function CandyRoomModel:getActShowRewardCosByMiddleRewardId(rewardId, actId)
	actId = actId or VersionActivity4_0Enum.ActivityId.ConcertCandyRoom

	local sortRewards = self:getActShowSortRewardCos(actId)
	local targetIndex = 0

	for i = 1, #sortRewards do
		if sortRewards[i].id == rewardId then
			targetIndex = i

			break
		end
	end

	local results = {}

	for i = targetIndex, #sortRewards do
		table.insert(results, sortRewards[i])
	end

	for i = 1, #sortRewards - #results do
		table.insert(results, sortRewards[i])
	end

	return results
end

function CandyRoomModel:getActRewardSortIndex(rewardId, actId)
	actId = actId or VersionActivity4_0Enum.ActivityId.ConcertCandyRoom

	local sortRewards = self:getActShowSortRewardCos(actId)

	for i = 1, #sortRewards do
		if sortRewards[i].id == rewardId then
			return i
		end
	end

	return math.floor(0.5 * #sortRewards) + 1
end

function CandyRoomModel:getLoginActivityId(actId)
	actId = actId or VersionActivity4_0Enum.ActivityId.ConcertCandyRoom

	local act245Co = CandyRoomConfig.instance:getActivity245Co(actId)

	return act245Co.loginActivityId
end

function CandyRoomModel:getLoginActRewardCos(actId)
	actId = actId or self:getLoginActivityId()

	local co = ActivityConfig.instance:getNorSignActivityCo(actId, 1)
	local rewards = GameUtil.splitString2(co.bonus, true)

	return rewards
end

function CandyRoomModel:setWaitShowRewards(rewards)
	self._waitShowRewards = rewards
end

function CandyRoomModel:getWaitShowRewardsCount(rewardId)
	local count = 0

	if not self._waitShowRewards then
		return count
	end

	for _, waitShowReward in pairs(self._waitShowRewards) do
		if waitShowReward == rewardId then
			count = count + 1
		end
	end

	return count
end

function CandyRoomModel:getWaitShowRewards()
	return self._waitShowRewards or {}
end

function CandyRoomModel:clearWaitShowRewards()
	self._waitShowRewards = {}
end

function CandyRoomModel:removeOneWaitShowReward()
	if self._waitShowRewards and #self._waitShowRewards > 0 then
		table.remove(self._waitShowRewards, 1)
	end
end

CandyRoomModel.instance = CandyRoomModel.New()

return CandyRoomModel
