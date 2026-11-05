-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/model/hall/ArcadeSurvivorHallEntityMO.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.model.hall.ArcadeSurvivorHallEntityMO", package.seeall)

local ArcadeSurvivorHallEntityMO = class("ArcadeSurvivorHallEntityMO")

function ArcadeSurvivorHallEntityMO:ctor(id)
	self.id = id

	self:setGridSize()
	self:setGridPos()
	self:onCtor()
end

function ArcadeSurvivorHallEntityMO:setGridSize(x, y)
	local minimumSize = ArcadeSurvivorEnum.Const.MinimumEntitySize

	self._sizeX = x or minimumSize
	self._sizeY = y or minimumSize
end

function ArcadeSurvivorHallEntityMO:setGridPos(x, y)
	self._gridX = x or 0
	self._gridY = y or 0
end

function ArcadeSurvivorHallEntityMO:setPosZ(z)
	self._posZ = z
end

function ArcadeSurvivorHallEntityMO:getId()
	return self.id
end

function ArcadeSurvivorHallEntityMO:getGridSize()
	return self._sizeX, self._sizeY
end

function ArcadeSurvivorHallEntityMO:getGridPos()
	return self._gridX, self._gridY
end

function ArcadeSurvivorHallEntityMO:getGridRange()
	local sizeX, sizeY = self:getGridSize()
	local gridX, gridY = self:getGridPos()
	local maxPosX = gridX + sizeX - 1
	local maxPosY = gridY + sizeY - 1

	return gridX, gridY, maxPosX, maxPosY
end

function ArcadeSurvivorHallEntityMO:isEnterRange(x, y)
	local minPosX, minPosY, maxPosX, maxPosY = self:getGridRange()

	return minPosX <= x and x <= maxPosX and minPosY <= y and y <= maxPosY
end

function ArcadeSurvivorHallEntityMO:getEntityPos()
	return self:_getPos(self._gridX, self._gridY)
end

function ArcadeSurvivorHallEntityMO:getCenterPos()
	local x1, y1 = self:getEntityPos()
	local x2, _ = self:_getPos(self._gridX + self._sizeX - 1, self._gridY + self._sizeY - 1)

	return (x1 + x2) * 0.5, y1
end

function ArcadeSurvivorHallEntityMO:_getPos(gridX, gridY)
	if not gridX or not gridY then
		gridX, gridY = ArcadeSurvivorHallModel.instance:getHeroGrid()
	end

	local x = ArcadeSurvivorHallEnum.Const.StartX + (gridX - 1) * ArcadeSurvivorHallEnum.Const.GridSize
	local y = ArcadeSurvivorHallEnum.Const.StartY + (gridY - 1) * ArcadeSurvivorHallEnum.Const.GridSize

	return x, y
end

function ArcadeSurvivorHallEntityMO:getPosZ()
	return self._posZ or 0
end

function ArcadeSurvivorHallEntityMO:getResPath()
	local cfg = self:getCfg()
	local resName = cfg and cfg.resName

	if string.nilorempty(resName) then
		return
	end

	local resPath = ResUrl.getArcadeSurvivorScenePrefabRes(ArcadeSurvivorEnum.ResDir.EntityPrefab, resName)

	return resPath
end

function ArcadeSurvivorHallEntityMO:onCtor()
	return
end

function ArcadeSurvivorHallEntityMO:getCfg()
	logError("ArcadeSurvivorHallEntityMO.getCfg error, need override this func")
end

return ArcadeSurvivorHallEntityMO
