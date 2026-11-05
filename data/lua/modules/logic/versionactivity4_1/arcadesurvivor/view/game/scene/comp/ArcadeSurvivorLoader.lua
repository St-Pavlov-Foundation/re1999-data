-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/view/game/scene/comp/ArcadeSurvivorLoader.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.view.game.scene.comp.ArcadeSurvivorLoader", package.seeall)

local ArcadeSurvivorLoader = class("ArcadeSurvivorLoader", ArcadeSurvivorBaseSceneComp)

function ArcadeSurvivorLoader:onInit()
	self._assetItemDict = {}
	self._loaderDict = {}
end

function ArcadeSurvivorLoader:loadRes(resPath, cb, cbObj, cbParam)
	if not self._initialized then
		return
	end

	local assetItem = self:_getAssetItem(resPath)

	if not assetItem then
		local loader = MultiAbLoader.New()

		self._loaderDict[loader] = {
			cb = cb,
			cbObj = cbObj,
			cbParam = cbParam
		}

		loader:addPath(resPath)
		loader:startLoad(self._onLoadFinish, self)
	else
		GameUtil.handleCallbackFunc(cb, cbObj, cbParam)
	end
end

function ArcadeSurvivorLoader:loadResList(resPathList, cb, cbObj, cbParam)
	if not self._initialized then
		return
	end

	local needLoadList = {}

	for _, resPath in ipairs(resPathList) do
		local assetItem = self:_getAssetItem(resPath)

		if not assetItem then
			table.insert(needLoadList, resPath)
		end
	end

	if #needLoadList > 0 then
		local loader = MultiAbLoader.New()

		self._loaderDict[loader] = {
			cb = cb,
			cbObj = cbObj,
			cbParam = cbParam
		}

		loader:setPathList(needLoadList)
		loader:startLoad(self._onLoadFinish, self)
	else
		GameUtil.handleCallbackFunc(cb, cbObj, cbParam)
	end
end

function ArcadeSurvivorLoader:_onLoadFinish(loader)
	if not self._initialized then
		return
	end

	local assetItemDict = loader:getAssetItemDict()

	for url, assetItem in pairs(assetItemDict) do
		self:_addAssetItem(url, assetItem)
	end

	local loaderData = self._loaderDict[loader]

	self._loaderDict[loader] = nil

	loader:dispose()

	if loaderData then
		local cb = loaderData.cb
		local cbObj = loaderData.cbObj
		local cbParam = loaderData.cbParam

		GameUtil.handleCallbackFunc(cb, cbObj, cbParam)
	end
end

function ArcadeSurvivorLoader:_addAssetItem(url, assetItem)
	if not self._initialized or self._assetItemDict[url] then
		return
	end

	local arcadeAssetItem = ArcadeAssetItem.New()

	arcadeAssetItem:init(assetItem, url)
	arcadeAssetItem:retain()

	self._assetItemDict[url] = arcadeAssetItem
end

function ArcadeSurvivorLoader:getResource(res, ab)
	local url = res

	url = not GameResMgr.IsFromEditorDir and ab or url

	local assetItem = self:_getAssetItem(url)

	if assetItem then
		return assetItem:getResource(res)
	end
end

function ArcadeSurvivorLoader:_getAssetItem(url)
	return self._assetItemDict and self._assetItemDict[url]
end

function ArcadeSurvivorLoader:onClear()
	self:_clearLoaderDict()
	self:_releaseAssetItemDict()
end

function ArcadeSurvivorLoader:_clearLoaderDict()
	for loader, _ in pairs(self._loaderDict) do
		loader:dispose()
	end

	self._loaderDict = nil
end

function ArcadeSurvivorLoader:_releaseAssetItemDict()
	if self._assetItemDict then
		for _, assetItem in pairs(self._assetItemDict) do
			assetItem:release()
		end
	end

	self._assetItemDict = nil
end

return ArcadeSurvivorLoader
