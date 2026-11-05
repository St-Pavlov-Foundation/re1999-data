-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/view/game/scene/comp/ArcadeSurvivorBaseSceneComp.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.view.game.scene.comp.ArcadeSurvivorBaseSceneComp", package.seeall)

local ArcadeSurvivorBaseSceneComp = class("ArcadeSurvivorBaseSceneComp", LuaCompBase)

function ArcadeSurvivorBaseSceneComp:ctor(compName)
	self._compName = compName
end

function ArcadeSurvivorBaseSceneComp:init(go)
	self.go = go
	self.trans = go.transform

	self:onInit()

	self._initialized = true
end

function ArcadeSurvivorBaseSceneComp:isInitialized()
	return self._initialized
end

function ArcadeSurvivorBaseSceneComp:getGO()
	return self.go
end

function ArcadeSurvivorBaseSceneComp:getTrans()
	return self.trans
end

function ArcadeSurvivorBaseSceneComp:onInit()
	return
end

function ArcadeSurvivorBaseSceneComp:onPreGameStart()
	return
end

function ArcadeSurvivorBaseSceneComp:onClear()
	return
end

function ArcadeSurvivorBaseSceneComp:clear()
	if not self._initialized then
		return
	end

	self._initialized = false

	self:onClear()

	self._compName = nil
end

function ArcadeSurvivorBaseSceneComp:onDestroy()
	self:clear()
end

return ArcadeSurvivorBaseSceneComp
