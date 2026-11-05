-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/view/game/entity/comp/ArcadeSurvivorEntityBaseComp.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.view.game.entity.comp.ArcadeSurvivorEntityBaseComp", package.seeall)

local ArcadeSurvivorEntityBaseComp = class("ArcadeSurvivorEntityBaseComp", LuaCompBase)

function ArcadeSurvivorEntityBaseComp:ctor(params)
	self._compName = params.compName
	self._entity = params.entity
end

function ArcadeSurvivorEntityBaseComp:init(go)
	self.go = go
	self.trans = go.transform

	self:onInit()

	self._initialized = true
end

function ArcadeSurvivorEntityBaseComp:getGO()
	return self.go
end

function ArcadeSurvivorEntityBaseComp:getTrans()
	return self.trans
end

function ArcadeSurvivorEntityBaseComp:onInit()
	return
end

function ArcadeSurvivorEntityBaseComp:onClear()
	return
end

function ArcadeSurvivorEntityBaseComp:clear()
	if not self._initialized then
		return
	end

	self._initialized = false

	self:onClear()

	self._entity = nil
	self._compName = nil
end

function ArcadeSurvivorEntityBaseComp:onDestroy()
	self:clear()
end

return ArcadeSurvivorEntityBaseComp
