-- chunkname: @modules/logic/versionactivity4_1/library/entity/V4a1_LibraryBaseUnitSpawn.lua

module("modules.logic.versionactivity4_1.library.entity.V4a1_LibraryBaseUnitSpawn", package.seeall)

local V4a1_LibraryBaseUnitSpawn = class("V4a1_LibraryBaseUnitSpawn", LibSimpleUnitBase)

GameUtil.setInterface(V4a1_LibraryBaseUnitSpawn, V4a1_LibraryUnitInterface)

function V4a1_LibraryBaseUnitSpawn:ctor(...)
	V4a1_LibraryBaseUnitSpawn.super.ctor(self, ...)
end

return V4a1_LibraryBaseUnitSpawn
