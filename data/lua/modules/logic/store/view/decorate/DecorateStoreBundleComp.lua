-- chunkname: @modules/logic/store/view/decorate/DecorateStoreBundleComp.lua

module("modules.logic.store.view.decorate.DecorateStoreBundleComp", package.seeall)

local DecorateStoreBundleComp = class("DecorateStoreBundleComp", LuaCompBase)

function DecorateStoreBundleComp.Get(go)
	return MonoHelper.addNoUpdateLuaComOnceToGo(go, DecorateStoreBundleComp)
end

function DecorateStoreBundleComp:init(go)
	self.go = go
	self._prefabLoader = PrefabInstantiate.Create(self.go)
	self._buddleTypeItems = {}

	self:_addEvents()
end

function DecorateStoreBundleComp:_addEvents()
	return
end

function DecorateStoreBundleComp:_removeEvents()
	return
end

function DecorateStoreBundleComp:refresh(goodId, storeId)
	if self._goodId == goodId then
		self:refreshUI()

		return
	end

	self._goodId = goodId

	local decorateConfig = DecorateStoreConfig.instance:getDecorateConfig(goodId)

	if decorateConfig and decorateConfig.fatherGoods > 0 then
		self._goodId = decorateConfig.fatherGoods
	end

	self._storeId = storeId
	self._decorateCo = DecorateStoreConfig.instance:getDecorateConfig(self._goodId)
	self._type = self._decorateCo.bundleType or 1

	if not self._buddleTypeItems[self._type] then
		local prefabPath = string.format("ui/viewres/store/decoratebundle/decoratebundletype%s.prefab", self._type)

		UIBlockMgr.instance:startBlock("waitloadbundle")
		self._prefabLoader:startLoad(prefabPath, self._onLoadResDone, self)
	else
		self:refreshUI()
	end
end

function DecorateStoreBundleComp:_onLoadResDone(loader)
	UIBlockMgr.instance:endBlock("waitloadbundle")

	local goBundle = self._prefabLoader:getInstGO()
	local compFuncs = _G[string.format("DecorateStoreBundleCompType%s", self._type)]

	if compFuncs then
		self._buddleTypeItems[self._type] = {}
		self._buddleTypeItems[self._type].go = goBundle

		local comptype = compFuncs.Get(goBundle)

		self._buddleTypeItems[self._type].comp = comptype
	end

	self:refreshUI()
end

function DecorateStoreBundleComp:refreshUI()
	for type, com in pairs(self._buddleTypeItems) do
		gohelper.setActive(com.go, type == self._type)
	end

	if self._buddleTypeItems[self._type] then
		self._buddleTypeItems[self._type].comp:refresh(self._goodId, self._storeId)
	end
end

function DecorateStoreBundleComp:destroy()
	MonoHelper.removeLuaComFromGo(self.go, DecorateStoreBundleComp)
	UIBlockMgr.instance:endBlock("waitloadbundle")

	if self._prefabLoader then
		self._prefabLoader:dispose()

		self._prefabLoader = nil
	end

	if self._buddleTypeItems then
		for _, item in pairs(self._buddleTypeItems) do
			item.comp:destroy()
		end

		self._buddleTypeItems = nil
	end

	self:_removeEvents()
end

return DecorateStoreBundleComp
