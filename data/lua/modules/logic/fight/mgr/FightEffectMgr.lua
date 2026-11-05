-- chunkname: @modules/logic/fight/mgr/FightEffectMgr.lua

module("modules.logic.fight.mgr.FightEffectMgr", package.seeall)

local FightEffectMgr = class("FightEffectMgr", FightBaseClass)

FightEffectMgr.isForbidEffect = nil

function FightEffectMgr:onConstructor()
	self._uniqueIdCounter = 1
	self._path2PoolDict = {}
	self._id2UsingItemDict = {}
	self._poolContainerGO = nil
	self._poolContainerTrs = nil
	self._preloadPoolContainerGO = nil
	self._preloadPoolContainerTrs = nil
end

function FightEffectMgr:getPoolContainerGO()
	if not self._poolContainerGO or gohelper.isNil(self._poolContainerGO) then
		local fightSceneRoot = GameSceneMgr.instance:getScene(SceneType.Fight):getSceneContainerGO()

		self._poolContainerGO = gohelper.create3d(fightSceneRoot, "EffectPool")
		self._poolContainerTrs = self._poolContainerGO.transform
		self._preloadPoolContainerGO = gohelper.create3d(fightSceneRoot, "EffectPreloadPool")
		self._preloadPoolContainerTrs = self._preloadPoolContainerGO.transform
	end

	return self._poolContainerGO
end

function FightEffectMgr:getPreloadPoolContainerGO()
	self:getPoolContainerGO()

	return self._preloadPoolContainerGO
end

function FightEffectMgr:hasLoaded(path)
	return FightGameMgr.loaderMgr:getAsset(path) ~= nil
end

function FightEffectMgr:isLoading(path)
	return FightGameMgr.loaderMgr:isLoading(path)
end

function FightEffectMgr:getId2UsingWrapDict()
	return self._id2UsingItemDict
end

function FightEffectMgr:isUsingEffect(item)
	return item ~= nil and self._id2UsingItemDict[item.uniqueId] == item
end

function FightEffectMgr:hasIdleEffect(path, side)
	local pool = self._path2PoolDict[path]
	local sidePool = pool and pool[side]

	if not sidePool then
		return false
	end

	for i = 1, #sidePool do
		if sidePool[i].isLoaded then
			return true
		end
	end

	return false
end

function FightEffectMgr:getEffect(path, side, callback, callbackObj, hangPointGO, dontPlay)
	local item = self:_popFromPool(path, side, hangPointGO)

	if item then
		self._id2UsingItemDict[item.uniqueId] = item

		item:setCallback(callback, callbackObj)
		item:doCallback(true)
		item:setTimeScale(FightModel.instance:getSpeed())

		item.dontPlay = dontPlay

		item:play()

		return item
	end

	return self:_createItem(path, side, hangPointGO, dontPlay, callback, callbackObj)
end

function FightEffectMgr:_popFromPool(path, side, hangPointGO)
	local pool = self._path2PoolDict[path]
	local sidePool = pool and pool[side]

	if not sidePool or #sidePool == 0 then
		return nil
	end

	local targetGO = hangPointGO or self:getPoolContainerGO()
	local index

	for i, item in ipairs(sidePool) do
		if item.isLoaded and item.hangPointGO == targetGO then
			index = i

			break
		end
	end

	if not index then
		for i = #sidePool, 1, -1 do
			if sidePool[i].isLoaded then
				index = i

				break
			end
		end
	end

	if not index then
		return nil
	end

	local item = table.remove(sidePool, index)

	item:setHangPointGO(targetGO)

	return item
end

function FightEffectMgr:_createItem(path, side, hangPointGO, dontPlay, callback, callbackObj)
	local uniqueId = self._uniqueIdCounter

	self._uniqueIdCounter = self._uniqueIdCounter + 1

	local item = self:newClass(FightEffectItem, self, uniqueId, path, side, hangPointGO, dontPlay)

	self._id2UsingItemDict[uniqueId] = item

	item:setCallback(callback, callbackObj)

	if not FightEffectMgr.isForbidEffect or self:hasLoaded(path) then
		item:startLoad()
	end

	return item
end

function FightEffectMgr:returnEffect(item)
	if not item or item.IS_DISPOSED then
		return
	end

	self._id2UsingItemDict[item.uniqueId] = nil

	if gohelper.isNil(item.containerGO) then
		return
	end

	item:setActive(false)
	item:onReturnPool()

	local pool = self._path2PoolDict[item.path]

	if not pool then
		pool = {}
		self._path2PoolDict[item.path] = pool
	end

	local sidePool = pool[item.side]

	if not sidePool then
		sidePool = {}
		pool[item.side] = sidePool
	end

	if not tabletool.indexOf(sidePool, item) then
		table.insert(sidePool, item)
	end
end

function FightEffectMgr:returnEffectToPoolContainer(item)
	if item and not item.IS_DISPOSED then
		item:setHangPointGO(self:getPoolContainerGO())
	end
end

function FightEffectMgr:releasePreloadEffect(item)
	if not item or item.IS_DISPOSED then
		return
	end

	if self._id2UsingItemDict[item.uniqueId] == item then
		return
	end

	local pool = self._path2PoolDict[item.path]
	local sidePool = pool and pool[item.side]

	if sidePool then
		local index = tabletool.indexOf(sidePool, item)

		if index then
			table.remove(sidePool, index)
		end
	end

	item:setCallback(nil, nil)
	item:markCanDestroy()
	item:disposeSelf()
end

function FightEffectMgr:releaseUnuseEffect()
	for _, pool in pairs(self._path2PoolDict) do
		for _, sidePool in pairs(pool) do
			for i = #sidePool, 1, -1 do
				local item = sidePool[i]

				sidePool[i] = nil

				item:markCanDestroy()
				item:disposeSelf()
			end
		end
	end

	self._path2PoolDict = {}
end

function FightEffectMgr:dispose()
	self:releaseUnuseEffect()

	for _, item in pairs(self._id2UsingItemDict) do
		item:markCanDestroy()
		item:disposeSelf()
	end

	self._id2UsingItemDict = {}

	if self._poolContainerGO and not gohelper.isNil(self._poolContainerGO) then
		gohelper.destroy(self._poolContainerGO)
	end

	self._poolContainerGO = nil
	self._poolContainerTrs = nil

	if self._preloadPoolContainerGO and not gohelper.isNil(self._preloadPoolContainerGO) then
		gohelper.destroy(self._preloadPoolContainerGO)
	end

	self._preloadPoolContainerGO = nil
	self._preloadPoolContainerTrs = nil
	self._uniqueIdCounter = 1
end

function FightEffectMgr:onDestructor()
	self:dispose()
end

return FightEffectMgr
