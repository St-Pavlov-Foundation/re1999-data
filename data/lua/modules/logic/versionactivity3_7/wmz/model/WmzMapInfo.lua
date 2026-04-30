-- chunkname: @modules/logic/versionactivity3_7/wmz/model/WmzMapInfo.lua

module("modules.logic.versionactivity3_7.wmz.model.WmzMapInfo", package.seeall)

local WmzMapInfo = class("WmzMapInfo")
local decode = cjson.decode
local ti = table.insert
local sf = string.format

function WmzMapInfo.s_makeEmpty(x, y)
	return {
		x = x,
		y = y,
		floorType = WmzEnum.FloorType.PassableEmpty,
		pathType = WmzEnum.FloorType.None
	}
end

function WmzMapInfo.s_makeVoid(x, y)
	return {
		x = x,
		y = y,
		floorType = WmzEnum.FloorType.Void,
		pathType = WmzEnum.FloorType.None
	}
end

function WmzMapInfo:ctor()
	self:clear()
end

function WmzMapInfo:clear()
	self.mapId = 0
	self._mapCO = false
end

local kMapModulePath = "modules.configs.wmz.map_"

function WmzMapInfo:_getMapRequireLuaPath()
	local path = kMapModulePath .. tostring(self.mapId)

	return path
end

function WmzMapInfo:_loadMapConfig()
	local path = self:_getMapRequireLuaPath()

	return require(path)
end

function WmzMapInfo:reset(mapId)
	self:clear()

	self.mapId = mapId

	return self:mapCO()
end

function WmzMapInfo:mapCO()
	if not self._mapCO then
		self._mapCO = self:_loadMapConfig()
	end

	if isDebugBuild then
		if not self._mapCO then
			logError("Not Found MapCO!! mapId=" .. tostring(self.mapId))
		elseif WmzEnum.rDir then
			local list = self._mapCO.girds
			local strBuf = {}

			for _, cellInfo in ipairs(list) do
				local ptStr = WmzEnum.nameOfPT(cellInfo.pathType or WmzEnum.PathType.None)
				local ftStr = WmzEnum.nameOfFT(cellInfo.floorType or WmzEnum.FloorType.Void)

				ti(strBuf, sf("(%s,%s): pt:%s, ft:%s, gp:%s, sprite:%s", cellInfo.x, cellInfo.y, ptStr, ftStr, cellInfo.groupId or 0, cellInfo.sprite or "None"))
			end

			logError(table.concat(strBuf, "\n"))
		end
	end

	return self._mapCO or {}
end

function WmzMapInfo:girds()
	return self:mapCO().girds
end

function WmzMapInfo:mapSize()
	local w = self:mapCO().width
	local h = self:mapCO().height

	return w, h
end

return WmzMapInfo
