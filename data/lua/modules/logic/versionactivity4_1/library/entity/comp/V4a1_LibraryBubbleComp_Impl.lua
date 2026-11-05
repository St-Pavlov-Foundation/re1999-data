-- chunkname: @modules/logic/versionactivity4_1/library/entity/comp/V4a1_LibraryBubbleComp_Impl.lua

module("modules.logic.versionactivity4_1.library.entity.comp.V4a1_LibraryBubbleComp_Impl", package.seeall)

local V4a1_LibraryBubbleComp_Impl = class("V4a1_LibraryBubbleComp_Impl", LibSimpleLuaCompBase)

function V4a1_LibraryBubbleComp_Impl:ctor(...)
	V4a1_LibraryBubbleComp_Impl.super.ctor(self, ...)

	self._isPlaying = false
end

function V4a1_LibraryBubbleComp_Impl:beforeDestroy()
	assert(false, "please override this function")
end

function V4a1_LibraryBubbleComp_Impl:charCO()
	return V4a1_LibraryConfig.instance:getCharCO(self:skinId())
end

function V4a1_LibraryBubbleComp_Impl:getChatPosByCO()
	return V4a1_LibraryConfig.instance:getChatPosByCO(self:charCO())
end

function V4a1_LibraryBubbleComp_Impl:getEmojiPosByCO()
	return V4a1_LibraryConfig.instance:getEmojiPosByCO(self:charCO())
end

function V4a1_LibraryBubbleComp_Impl:getSortingOrderByCO()
	return V4a1_LibraryConfig.instance:getSortingOrderByCO(self:charCO())
end

function V4a1_LibraryBubbleComp_Impl:getScaleByCO()
	return V4a1_LibraryConfig.instance:getScaleByCO(self:charCO())
end

function V4a1_LibraryBubbleComp_Impl:getChatDescCO(descId)
	return V4a1_LibraryConfig.instance:getChatDescCO(descId)
end

function V4a1_LibraryBubbleComp_Impl:skinId()
	return self:unitObj():skinId()
end

function V4a1_LibraryBubbleComp_Impl:getUnitPosition()
	return self:unitObj():getPosition()
end

function V4a1_LibraryBubbleComp_Impl:getMainViewObj()
	return self:unitObj():sceneViewComp():getMainViewObj()
end

function V4a1_LibraryBubbleComp_Impl:getBubbleDescTemplate()
	return self:unitObj():scenePreloaderComp():getBubbleDescTemplate()
end

function V4a1_LibraryBubbleComp_Impl:getBubbleEmojiTemplate()
	return self:unitObj():scenePreloaderComp():getBubbleEmojiTemplate()
end

function V4a1_LibraryBubbleComp_Impl:makeSureLoaded(...)
	return self:unitObj():sceneLoaderComp():makeSureLoaded(...)
end

function V4a1_LibraryBubbleComp_Impl:isPlaying()
	return self._isPlaying and true or false
end

return V4a1_LibraryBubbleComp_Impl
