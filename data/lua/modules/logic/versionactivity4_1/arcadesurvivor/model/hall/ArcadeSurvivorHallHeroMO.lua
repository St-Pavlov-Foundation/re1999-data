-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/model/hall/ArcadeSurvivorHallHeroMO.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.model.hall.ArcadeSurvivorHallHeroMO", package.seeall)

local ArcadeSurvivorHallHeroMO = class("ArcadeSurvivorHallHeroMO", ArcadeSurvivorHallEntityMO)

function ArcadeSurvivorHallHeroMO:onCtor()
	local minimumSize = ArcadeSurvivorEnum.Const.MinimumEntitySize

	self._sizeX, self._sizeY = minimumSize, minimumSize

	local gridX, gridY = ArcadeSurvivorHeroModel.instance:getCharacterPos()

	self:setGridPos(gridX, gridY)
end

function ArcadeSurvivorHallHeroMO:setGridPos(x, y)
	self._gridX, self._gridY = x, y

	ArcadeSurvivorHallModel.instance:setHeroGrid(x, y)
end

function ArcadeSurvivorHallHeroMO:getCfg()
	local id = self:getId()

	return ArcadeSurvivorConfig.instance:getCharacterCfg(id, true)
end

function ArcadeSurvivorHallHeroMO:getHeroMO()
	return ArcadeSurvivorHeroModel.instance:getHeroMOById(self.id)
end

return ArcadeSurvivorHallHeroMO
