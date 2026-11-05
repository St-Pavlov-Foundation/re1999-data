-- chunkname: @modules/logic/versionactivity4_1/library/scene/comp/V4a1_LibrarySceneLoaderComp.lua

module("modules.logic.versionactivity4_1.library.scene.comp.V4a1_LibrarySceneLoaderComp", package.seeall)

local V4a1_LibrarySceneLoaderComp = class("V4a1_LibrarySceneLoaderComp", V4a1_LibraryBaseSceneComp)

function V4a1_LibrarySceneLoaderComp:ctor(...)
	V4a1_LibrarySceneLoaderComp.super.ctor(self, ...)

	self._initialized = false
end

function V4a1_LibrarySceneLoaderComp:onSceneStart(...)
	V4a1_LibrarySceneLoaderComp.super.onSceneStart(self, ...)
end

function V4a1_LibrarySceneLoaderComp:onScenePrepared(...)
	V4a1_LibrarySceneLoaderComp.super.onScenePrepared(self, ...)

	self._assetItemDict = {}
	self._loaderDataList = {}
	self._initialized = true
end

function V4a1_LibrarySceneLoaderComp:onSceneClose()
	self._initialized = false

	self:_releaseLoaderDataList()
	self:_releaseAssetItemDict()
	V4a1_LibrarySceneLoaderComp.super.onSceneClose(self)
end

function V4a1_LibrarySceneLoaderComp:makeSureLoaded(resPathList, cb, cbObj)
	if not self._initialized then
		return
	end

	local needLoadList = {}

	for _, resPath in ipairs(resPathList) do
		local hasLoaded = self:hasLoadedAsset(resPath)

		if not hasLoaded then
			table.insert(needLoadList, resPath)
		end
	end

	if #needLoadList <= 0 then
		if cb then
			callWithCatch(cb, cbObj, self)
		end

		return
	end

	local loader = MultiAbLoader.New()

	table.insert(self._loaderDataList, {
		loader = loader,
		cb = cb,
		cbObj = cbObj
	})
	loader:setPathList(needLoadList)
	loader:startLoad(self._onLoadFinish, self)
end

function V4a1_LibrarySceneLoaderComp:_onLoadFinish(loader)
	local assetItemDict = loader:getAssetItemDict()

	for url, assetItem in pairs(assetItemDict) do
		self:_addAssetItem(url, assetItem)
	end

	local findIndex, loadData

	for i, tmpData in ipairs(self._loaderDataList) do
		if tmpData.loader == loader then
			findIndex = i
			loadData = tmpData

			break
		end
	end

	if findIndex and loadData then
		loadData.loader:dispose()

		if loadData.cb then
			callWithCatch(loadData.cb, loadData.cbObj, self)
		end

		table.remove(self._loaderDataList, findIndex)
	end
end

function V4a1_LibrarySceneLoaderComp:_addAssetItem(url, assetItem)
	if not self._initialized or self._assetItemDict[url] then
		return
	end

	local udimoAssetItem = UdimoSceneAssetItem.New()

	udimoAssetItem:init(assetItem, url)
	udimoAssetItem:retain()

	self._assetItemDict[url] = udimoAssetItem
end

function V4a1_LibrarySceneLoaderComp:_getAssetItem(url)
	return self._assetItemDict and self._assetItemDict[url]
end

function V4a1_LibrarySceneLoaderComp:hasLoadedAsset(url)
	local assetItem = self:_getAssetItem(url)

	return assetItem and true or false
end

function V4a1_LibrarySceneLoaderComp:getResource(res, ab)
	local url = res

	url = not GameResMgr.IsFromEditorDir and ab or url

	local assetItem = self:_getAssetItem(url)

	if assetItem then
		return assetItem:getResource(res)
	end
end

function V4a1_LibrarySceneLoaderComp:_releaseAssetItemDict()
	if self._assetItemDict then
		for _, assetItem in pairs(self._assetItemDict) do
			assetItem:release()
		end

		self._assetItemDict = nil
	end
end

function V4a1_LibrarySceneLoaderComp:_releaseLoaderDataList()
	if self._loaderDataList then
		for _, loaderData in ipairs(self._loaderDataList) do
			loaderData.loader:dispose()
		end

		self._loaderDataList = nil
	end
end

return V4a1_LibrarySceneLoaderComp
