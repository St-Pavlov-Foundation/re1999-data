-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/model/handbook/ArcadeSurvivorHandBookMO.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.model.handbook.ArcadeSurvivorHandBookMO", package.seeall)

local ArcadeSurvivorHandBookMO = class("ArcadeSurvivorHandBookMO")

function ArcadeSurvivorHandBookMO:ctor(id, type)
	self.id = id
	self.categoryType = type

	self:_initAttribute()
	self:_initEffect()
	self:_initIconSize()
	self:setLock(true)
	self:setCount()
	self:setNew()
end

function ArcadeSurvivorHandBookMO:_initIconSize()
	local minSize = ArcadeSurvivorHallEnum.HandBookItemParams.MinSize
	local icon = self:getIcon()

	if icon then
		self._sizeX, self._sizeY = string.match(icon, "(%d+)x(%d+)")
	end

	self._sizeX = self._sizeX and tonumber(self._sizeX) * minSize or minSize
	self._sizeY = self._sizeY and tonumber(self._sizeY) * minSize or minSize
end

function ArcadeSurvivorHandBookMO:setLock(lock)
	self._isLock = lock
end

function ArcadeSurvivorHandBookMO:setCount(count)
	self._count = count
end

function ArcadeSurvivorHandBookMO:setNew(isNew)
	self._isNew = isNew and true or false
end

function ArcadeSurvivorHandBookMO:setAnchorX(x)
	self._anchorX = x
end

function ArcadeSurvivorHandBookMO:setAnchorY(y)
	self._anchorY = y
end

function ArcadeSurvivorHandBookMO:setRowInfo(count, index)
	self._rowCount = count
	self._rowIndex = index
end

function ArcadeSurvivorHandBookMO:getId()
	return self.id
end

function ArcadeSurvivorHandBookMO:getType()
	return self.categoryType
end

function ArcadeSurvivorHandBookMO:isLock()
	return self._isLock
end

function ArcadeSurvivorHandBookMO:getCount()
	return self._count or 1
end

function ArcadeSurvivorHandBookMO:isNew()
	return self._isNew
end

function ArcadeSurvivorHandBookMO:getAnchor()
	return self._anchorX or 0, self._anchorY or 0
end

function ArcadeSurvivorHandBookMO:getRowInfo()
	return self._rowCount, self._rowIndex
end

function ArcadeSurvivorHandBookMO:getIconSize()
	return self._sizeX or 1, self._sizeY or 1
end

function ArcadeSurvivorHandBookMO:getAttributeDict()
	return self._attributeDict
end

function ArcadeSurvivorHandBookMO:getLockShowAttrIdList()
	local attrIdList = {}
	local attrDict = self:getAttributeDict()

	if attrDict then
		for attrId in pairs(attrDict) do
			attrIdList[#attrIdList + 1] = attrId
		end
	end

	return attrIdList
end

function ArcadeSurvivorHandBookMO:getEffectDict()
	return self._effectDict
end

function ArcadeSurvivorHandBookMO:getName()
	local cfg = self:getCfg()

	return cfg and cfg.name
end

function ArcadeSurvivorHandBookMO:getDesc()
	local cfg = self:getCfg()

	return cfg and cfg.desc or ""
end

function ArcadeSurvivorHandBookMO:getIcon()
	local cfg = self:getCfg()

	return cfg and cfg.icon
end

function ArcadeSurvivorHandBookMO:_initAttribute()
	self._attributeDict = {}
end

function ArcadeSurvivorHandBookMO:_initEffect()
	self._effectDict = {}
end

function ArcadeSurvivorHandBookMO:getCfg()
	logError("ArcadeSurvivorHandBookMO.getCfg error, need override this func")
end

function ArcadeSurvivorHandBookMO:getLockTip()
	return luaLang("p_v3a3_eliminate_handbook_lock")
end

function ArcadeSurvivorHandBookMO:getBigIcon()
	return self:getIcon()
end

function ArcadeSurvivorHandBookMO:getBigIconTrans()
	local anchorX, anchorY = 0, 0
	local scaleX, scaleY = 1, 1

	return anchorX, anchorY, scaleX, scaleY
end

function ArcadeSurvivorHandBookMO:getIconRectSize()
	return self:getIconSize()
end

function ArcadeSurvivorHandBookMO:isSpecialIconSize()
	return false
end

return ArcadeSurvivorHandBookMO
