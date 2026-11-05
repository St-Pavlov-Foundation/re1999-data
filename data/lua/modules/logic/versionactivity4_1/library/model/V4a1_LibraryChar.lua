-- chunkname: @modules/logic/versionactivity4_1/library/model/V4a1_LibraryChar.lua

module("modules.logic.versionactivity4_1.library.model.V4a1_LibraryChar", package.seeall)

local V4a1_LibraryChar = pureTable("V4a1_LibraryChar")

function V4a1_LibraryChar:ctor(mapMO, info)
	self._mapMO = mapMO
	self._info = info

	self:resetToInit()
end

function V4a1_LibraryChar:resetToInit()
	self._bInUsed = false
end

function V4a1_LibraryChar:setInUsed(bInUsed)
	self._bInUsed = bInUsed
end

function V4a1_LibraryChar:bInUsed()
	return self._bInUsed
end

return V4a1_LibraryChar
