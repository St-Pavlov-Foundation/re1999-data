-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/model/ArcadeSurvivorModel.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.model.ArcadeSurvivorModel", package.seeall)

local ArcadeSurvivorModel = class("ArcadeSurvivorModel", BaseModel)

function ArcadeSurvivorModel:onInit()
	return
end

function ArcadeSurvivorModel:reInit()
	return
end

function ArcadeSurvivorModel:getAct247Id()
	return VersionActivity4_1Enum.ActivityId.ArcadeSurvivor
end

function ArcadeSurvivorModel:isAct247Open(isToast)
	local actId = self:getAct247Id()

	return ActivityHelper.isOpen2(actId, isToast, true)
end

ArcadeSurvivorModel.instance = ArcadeSurvivorModel.New()

return ArcadeSurvivorModel
