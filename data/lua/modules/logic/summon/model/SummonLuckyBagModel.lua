-- chunkname: @modules/logic/summon/model/SummonLuckyBagModel.lua

module("modules.logic.summon.model.SummonLuckyBagModel", package.seeall)

local SummonLuckyBagModel = class("SummonLuckyBagModel", BaseModel)

function SummonLuckyBagModel:isLuckyBagOpened(poolId, luckyBagId)
	local summonServerMO = SummonMainModel.instance:getPoolServerMO(poolId)

	if summonServerMO and summonServerMO.luckyBagMO then
		return summonServerMO.luckyBagMO:isOpened()
	end

	return false
end

function SummonLuckyBagModel:getGachaRemainTimes(poolId)
	local poolCo = SummonConfig.instance:getSummonPool(poolId)
	local summonServerMO = SummonMainModel.instance:getPoolServerMO(poolId)
	local times = SummonConfig.getSummonSSRTimes(poolCo)

	if summonServerMO and summonServerMO.luckyBagMO then
		return times - summonServerMO.luckyBagMO.summonTimes
	end

	return times
end

function SummonLuckyBagModel:isLuckyBagGot(poolId)
	local summonServerMO = SummonMainModel.instance:getPoolServerMO(poolId)

	if summonServerMO and summonServerMO.luckyBagMO then
		return summonServerMO.luckyBagMO:isGot(), summonServerMO.luckyBagMO.luckyBagId
	end

	return false
end

function SummonLuckyBagModel:needAutoPopup(poolId)
	local playerInfo = PlayerModel.instance:getPlayinfo()

	if not playerInfo or playerInfo.userId == 0 then
		return nil
	end

	local localKey = string.format("LuckyBagAutoPopup_%s_%s", playerInfo.userId, poolId)

	if string.nilorempty(PlayerPrefsHelper.getString(localKey, "")) then
		return true
	end

	return false
end

function SummonLuckyBagModel:recordAutoPopup(poolId)
	local playerInfo = PlayerModel.instance:getPlayinfo()

	if not playerInfo or playerInfo.userId == 0 then
		return nil
	end

	local localKey = string.format("LuckyBagAutoPopup_%s_%s", playerInfo.userId, poolId)

	PlayerPrefsHelper.setString(localKey, "1")
end

SummonLuckyBagModel.instance = SummonLuckyBagModel.New()

return SummonLuckyBagModel
