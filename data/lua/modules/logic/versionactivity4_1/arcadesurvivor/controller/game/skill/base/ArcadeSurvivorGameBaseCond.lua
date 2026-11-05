-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/controller/game/skill/base/ArcadeSurvivorGameBaseCond.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.controller.game.skill.base.ArcadeSurvivorGameBaseCond", package.seeall)

local ArcadeSurvivorGameBaseCond = class("ArcadeSurvivorGameBaseCond")

function ArcadeSurvivorGameBaseCond:ctor(param)
	self:onCtor(param)
end

function ArcadeSurvivorGameBaseCond:isCondSuccess(context)
	local isOk, isSuccess = callWithCatch(self._onIsCondSuccess, self, context)

	return isOk and isSuccess
end

function ArcadeSurvivorGameBaseCond:onCtor(param)
	return
end

function ArcadeSurvivorGameBaseCond:_onIsCondSuccess(context)
	return true
end

return ArcadeSurvivorGameBaseCond
