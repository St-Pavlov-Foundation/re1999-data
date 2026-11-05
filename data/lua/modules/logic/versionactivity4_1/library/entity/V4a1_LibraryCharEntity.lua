-- chunkname: @modules/logic/versionactivity4_1/library/entity/V4a1_LibraryCharEntity.lua

local math_random = math.random

module("modules.logic.versionactivity4_1.library.entity.V4a1_LibraryCharEntity", package.seeall)

local V4a1_LibraryCharEntity = class("V4a1_LibraryCharEntity", V4a1_LibraryBaseUnitSpawn)

function V4a1_LibraryCharEntity:ctor(...)
	V4a1_LibraryCharEntity.super.ctor(self, ...)

	self._nextClickTime = 0
end

function V4a1_LibraryCharEntity:skinId()
	return self:getId()
end

function V4a1_LibraryCharEntity:getCharCO()
	return V4a1_LibraryConfig.instance:getCharCO(self:skinId())
end

function V4a1_LibraryCharEntity:getCharSpeedByCO()
	return V4a1_LibraryConfig.instance:getCharSpeedByCO(self:getCharCO())
end

function V4a1_LibraryCharEntity:getCharWalkableAreaByCO()
	return V4a1_LibraryConfig.instance:getCharWalkableAreaByCO(self:getCharCO())
end

function V4a1_LibraryCharEntity:getCharIdleDurationRangeByCO()
	return V4a1_LibraryConfig.instance:getCharIdleDurationRangeByCO(self:getCharCO())
end

function V4a1_LibraryCharEntity:init(...)
	V4a1_LibraryCharEntity.super.init(self, ...)
	self:_initPos()
end

function V4a1_LibraryCharEntity:onDestroy()
	self.fsm = nil
	self.spine = nil
	self.bubble = nil

	V4a1_LibraryCharEntity.super.onDestroy(self)
end

function V4a1_LibraryCharEntity:_randomXZ(minX, maxX, minZ, maxZ)
	local newX = math_random(minX * 100, maxX * 100) / 100
	local newZ = math_random(minZ * 100, maxZ * 100) / 100

	return newX, newZ
end

function V4a1_LibraryCharEntity:_initPos()
	local area = self:getCharWalkableAreaByCO()
	local newX, newZ = self:_randomXZ(area.minX, area.maxX, area.minZ, area.maxZ)

	self:setPosition(newX, 0, newZ)
end

function V4a1_LibraryCharEntity:initComponents()
	self:addComp("spine", V4a1_LibrarySpineComp, self)
	self:addComp("bubble", V4a1_LibraryBubbleComp)
	self:addComp("fsm", V4a1_LibraryFsmComp)
end

function V4a1_LibraryCharEntity:spineComp()
	return self.spine
end

function V4a1_LibraryCharEntity:bubbleComp()
	return self.bubble
end

function V4a1_LibraryCharEntity:fsmComp()
	return self.fsm
end

function V4a1_LibraryCharEntity:onUpdate()
	if self.fsm then
		self.fsm:onUpdate()
	end

	if self.bubble then
		self.bubble:onUpdate()
	end
end

function V4a1_LibraryCharEntity:getPosition()
	return self._pos or self._trans.position
end

function V4a1_LibraryCharEntity:setPosition(x, y, z)
	local pos = self:getPosition()

	x = x or pos.x
	y = y or pos.y
	z = z or pos.z
	self._pos = {
		x = x,
		y = y,
		z = z
	}

	transformhelper.setPos(self._trans, x, y, z)
end

local kEdgeWidth = 2
local kEdgeDepth = 1

function V4a1_LibraryCharEntity:getRandomWalkTarget()
	local area = self:getCharWalkableAreaByCO()
	local width = area.width
	local depth = area.depth
	local centerX = area.cx
	local centerZ = area.cz
	local pos = self:getPosition()
	local minX, maxX

	if pos.x <= area.minX + kEdgeWidth then
		minX, maxX = centerX, area.maxX
	elseif pos.x >= area.maxX - kEdgeWidth then
		minX, maxX = area.minX, centerX
	else
		minX, maxX = area.minX, area.maxX
	end

	local minZ, maxZ

	if pos.z <= area.minZ + kEdgeDepth then
		minZ, maxZ = centerZ, area.maxZ
	elseif pos.z >= area.maxZ - kEdgeDepth then
		minZ, maxZ = area.minZ, centerZ
	else
		minZ, maxZ = area.minZ, area.maxZ
	end

	local newX, newZ = self:_randomXZ(minX, maxX, minZ, maxZ)

	return newX, newZ
end

function V4a1_LibraryCharEntity:setSpineLookDir(dir)
	if self.spine then
		self.spine:changeLookDir(dir)
	end
end

function V4a1_LibraryCharEntity:getSpineLookDir()
	if self.spine then
		return self.spine:getLookDir()
	end
end

function V4a1_LibraryCharEntity:onClick()
	if not self.bubble then
		return
	end

	if self.bubble:isPlaying() then
		return
	end

	if Time.realtimeSinceStartup < self._nextClickTime then
		return
	end

	self._nextClickTime = Time.realtimeSinceStartup + V4a1_LibraryConfig.instance:getCharClickCooldown()

	self.bubble:playRandomChat()
end

function V4a1_LibraryCharEntity:triggerEvent(eventId, param)
	if self.fsm then
		self.fsm:triggerEvent(eventId, param)
	end
end

return V4a1_LibraryCharEntity
