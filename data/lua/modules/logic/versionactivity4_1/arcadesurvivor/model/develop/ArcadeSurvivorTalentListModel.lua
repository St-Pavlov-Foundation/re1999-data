-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/model/develop/ArcadeSurvivorTalentListModel.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.model.develop.ArcadeSurvivorTalentListModel", package.seeall)

local ArcadeSurvivorTalentListModel = class("ArcadeSurvivorTalentListModel", ListScrollModel)

local function _sortById(a, b)
	return a.id < b.id
end

function ArcadeSurvivorTalentListModel:setMOList()
	local moList = ArcadeSurvivorHeroModel.instance:getTalentMOList()

	table.sort(moList, _sortById)
	self:setList(moList)
end

ArcadeSurvivorTalentListModel.instance = ArcadeSurvivorTalentListModel.New()

return ArcadeSurvivorTalentListModel
