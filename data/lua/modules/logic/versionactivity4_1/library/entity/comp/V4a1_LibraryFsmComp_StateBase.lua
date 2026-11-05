-- chunkname: @modules/logic/versionactivity4_1/library/entity/comp/V4a1_LibraryFsmComp_StateBase.lua

module("modules.logic.versionactivity4_1.library.entity.comp.V4a1_LibraryFsmComp_StateBase", package.seeall)

local V4a1_LibraryFsmComp_StateBase = class("V4a1_LibraryFsmComp_StateBase", LibSimpleLuaCompBase)

function V4a1_LibraryFsmComp_StateBase:ctor(...)
	V4a1_LibraryFsmComp_StateBase.super.ctor(self, ...)
end

function V4a1_LibraryFsmComp_StateBase:spineComp()
	return self:unitObj():spineComp()
end

function V4a1_LibraryFsmComp_StateBase:bubbleComp()
	return self:unitObj():bubbleComp()
end

function V4a1_LibraryFsmComp_StateBase:fsmComp()
	return self:unitObj():fsmComp()
end

function V4a1_LibraryFsmComp_StateBase:onEnter()
	assert(false, "please override this function")
end

function V4a1_LibraryFsmComp_StateBase:onUpdate()
	return
end

function V4a1_LibraryFsmComp_StateBase:onExit()
	assert(false, "please override this function")
end

function V4a1_LibraryFsmComp_StateBase:type()
	assert(false, "please override this function")
end

return V4a1_LibraryFsmComp_StateBase
