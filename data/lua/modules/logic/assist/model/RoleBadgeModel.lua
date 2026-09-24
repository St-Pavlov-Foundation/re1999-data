-- chunkname: @modules/logic/assist/model/RoleBadgeModel.lua

module("modules.logic.assist.model.RoleBadgeModel", package.seeall)

local RoleBadgeModel = class("RoleBadgeModel", BaseModel)

function RoleBadgeModel:onInit()
	self.badgeInfoMo = nil
end

function RoleBadgeModel:reInit()
	self:onInit()
end

function RoleBadgeModel:setBadgeInfo(info)
	self.badgeInfoMo = GameUtil.rpcInfoToMo(info, RoleBadgeInfoMo, self.badgeInfoMo)
end

function RoleBadgeModel:getBadgeInfo()
	return self.badgeInfoMo
end

RoleBadgeModel.instance = RoleBadgeModel.New()

return RoleBadgeModel
