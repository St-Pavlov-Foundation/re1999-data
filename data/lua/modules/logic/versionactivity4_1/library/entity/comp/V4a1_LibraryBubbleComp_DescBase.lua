-- chunkname: @modules/logic/versionactivity4_1/library/entity/comp/V4a1_LibraryBubbleComp_DescBase.lua

module("modules.logic.versionactivity4_1.library.entity.comp.V4a1_LibraryBubbleComp_DescBase", package.seeall)

local V4a1_LibraryBubbleComp_DescBase = class("V4a1_LibraryBubbleComp_DescBase", V4a1_LibraryBubbleComp_Impl)

function V4a1_LibraryBubbleComp_DescBase:ctor(...)
	V4a1_LibraryBubbleComp_DescBase.super.ctor(self, ...)
end

function V4a1_LibraryBubbleComp_DescBase:chatCanvasSortingOrder()
	return self:getSortingOrderByCO() + 10
end

return V4a1_LibraryBubbleComp_DescBase
