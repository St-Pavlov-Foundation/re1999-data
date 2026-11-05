-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/view/hall/ArcadeSurvivorHallEntityEffectComp.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.view.hall.ArcadeSurvivorHallEntityEffectComp", package.seeall)

local ArcadeSurvivorHallEntityEffectComp = class("ArcadeSurvivorHallEntityEffectComp", LuaCompBase)

function ArcadeSurvivorHallEntityEffectComp:ctor(param)
	self._entity = param.entity
	self._compName = param.compName
	self._loader = param.loader
end

function ArcadeSurvivorHallEntityEffectComp:init(go)
	self.go = go
	self.trans = go.transform
	self._initialized = true
	self._effectGODict = {}
end

function ArcadeSurvivorHallEntityEffectComp:playShow(showId)
	local resName = ArcadeSurvivorConfig.instance:getShowResName(showId)

	if not self._loader or string.nilorempty(resName) then
		return
	end

	local effectGO = self._effectGODict[resName]

	if not gohelper.isNil(effectGO) then
		gohelper.setActive(effectGO, false)
		gohelper.setActive(effectGO, true)
		transformhelper.setLocalPos(self.trans, 0, 0, 0)
	else
		local resPath = ResUrl.getArcadeSurvivorEffectRes(resName)

		self._loader:loadRes(resPath, self.onLoadEffectFinished, self, {
			resName = resName,
			resPath = resPath
		})
	end
end

function ArcadeSurvivorHallEntityEffectComp:onLoadEffectFinished(param)
	if not self._initialized or not self._loader then
		return
	end

	local assetRes = self._loader:getResource(param.resPath)
	local effGO = gohelper.clone(assetRes, self.go)

	self._effectGODict[param.resName] = effGO
end

function ArcadeSurvivorHallEntityEffectComp:clear()
	if not self._initialized then
		return
	end

	self._initialized = false
	self._entity = nil
	self._compName = nil
	self._effectGODict = {}
end

function ArcadeSurvivorHallEntityEffectComp:onDestroy()
	self:clear()
end

return ArcadeSurvivorHallEntityEffectComp
