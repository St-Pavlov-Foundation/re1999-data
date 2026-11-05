-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/model/reward/ArcadeSurvivorRewardListModel.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.model.reward.ArcadeSurvivorRewardListModel", package.seeall)

local ArcadeSurvivorRewardListModel = class("ArcadeSurvivorRewardListModel", ListScrollModel)

local function _sortByScore(a, b)
	local aCfg = a:getCfg()
	local bCfg = b:getCfg()
	local aScore = aCfg.score or 0
	local bScore = bCfg.score or 0

	return aScore < bScore
end

function ArcadeSurvivorRewardListModel:refreshList()
	local moList = ArcadeSurvivorOutSideModel.instance:getRewardList()

	table.sort(moList, _sortByScore)
	self:setList(moList)
end

ArcadeSurvivorRewardListModel.instance = ArcadeSurvivorRewardListModel.New()

return ArcadeSurvivorRewardListModel
