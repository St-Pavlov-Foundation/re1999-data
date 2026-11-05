-- chunkname: @modules/logic/versionactivity4_1/library/scene/comp/V4a1_LibraryScenePreloaderComp.lua

module("modules.logic.versionactivity4_1.library.scene.comp.V4a1_LibraryScenePreloaderComp", package.seeall)

local V4a1_LibraryScenePreloaderComp = class("V4a1_LibraryScenePreloaderComp", V4a1_LibraryBaseSceneComp)

function V4a1_LibraryScenePreloaderComp:ctor(...)
	V4a1_LibraryScenePreloaderComp.super.ctor(self, ...)
end

function V4a1_LibraryScenePreloaderComp:onExec_LibAsyncTaskWork()
	self:_destroyLoader()

	self._abLoader = MultiAbLoader.New()

	self._abLoader:addPath(V4a1_LibraryEnum.ResPath.v4a1_library_bubble_desc)
	self._abLoader:addPath(V4a1_LibraryEnum.ResPath.v4a1_m_s22_dytsg_icon)
	self._abLoader:startLoad(self._onPreloadFinish, self)
end

function V4a1_LibraryScenePreloaderComp:_onPreloadFinish()
	self:dispatchEvent(V4a1_LibraryEvent.OnPreloadFinish)
end

function V4a1_LibraryScenePreloaderComp:getRes(resPath)
	if not self._abLoader or self._abLoader.isLoading then
		return nil
	end

	local assetItem = self._abLoader:getAssetItem(resPath)

	if not assetItem then
		return nil
	end

	return assetItem:GetResource(resPath)
end

function V4a1_LibraryScenePreloaderComp:getResInst(resPath, parentGO, name)
	local assetItem = self._abLoader:getAssetItem(resPath)

	if assetItem then
		local prefab = assetItem:GetResource(resPath)

		if prefab then
			return gohelper.clone(prefab, parentGO, name)
		else
			logError(self.__cname .. " prefab not exist: " .. resPath)
		end
	else
		logError(self.__cname .. " resource not load: " .. resPath)
	end

	return nil
end

function V4a1_LibraryScenePreloaderComp:onSceneClose(...)
	self:_destroyLoader()
	V4a1_LibraryScenePreloaderComp.super.onSceneClose(self, ...)
end

function V4a1_LibraryScenePreloaderComp:_destroyLoader()
	if self._abLoader then
		self._abLoader:dispose()

		self._abLoader = nil
	end
end

function V4a1_LibraryScenePreloaderComp:getBubbleDescTemplate()
	return self:getRes(V4a1_LibraryEnum.ResPath.v4a1_library_bubble_desc)
end

function V4a1_LibraryScenePreloaderComp:getBubbleEmojiTemplate()
	return self:getRes(V4a1_LibraryEnum.ResPath.v4a1_m_s22_dytsg_icon)
end

return V4a1_LibraryScenePreloaderComp
