-- chunkname: @modules/logic/gm/model/GMFightEnterFightModel.lua

module("modules.logic.gm.model.GMFightEnterFightModel", package.seeall)

local GMFightEnterFightModel = class("GMFightEnterFightModel", ListScrollModel)

function GMFightEnterFightModel:setEpisodeType(episodeType)
	local list = GMFightEnterHandler.getEpisodeList(episodeType)

	self:setList(list)
end

GMFightEnterFightModel.instance = GMFightEnterFightModel.New()

return GMFightEnterFightModel
