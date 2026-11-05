-- chunkname: @modules/logic/gm/model/GMFightEnterLeftModel.lua

module("modules.logic.gm.model.GMFightEnterLeftModel", package.seeall)

local GMFightEnterLeftModel = class("GMFightEnterLeftModel", ListScrollModel)

function GMFightEnterLeftModel:onOpen()
	local list = {}

	for episodeType, _ in pairs(GMFightEnterHandler.EpisodeEnterDict) do
		table.insert(list, {
			type = episodeType
		})
	end

	self:setList(list)
end

GMFightEnterLeftModel.instance = GMFightEnterLeftModel.New()

return GMFightEnterLeftModel
