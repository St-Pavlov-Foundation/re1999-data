-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/view/game/scene/comp/ArcadeSurvivorEntityMgr.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.view.game.scene.comp.ArcadeSurvivorEntityMgr", package.seeall)

local ArcadeSurvivorEntityMgr = class("ArcadeSurvivorEntityMgr", ArcadeSurvivorBaseSceneComp)

function ArcadeSurvivorEntityMgr:onInit()
	self:clearAllEntity(true)
	transformhelper.setLocalPos(self.trans, 0, 0, ArcadeSurvivorGameEnum.Const.EntityZLevel)
end

function ArcadeSurvivorEntityMgr:_getEntityGameObjectName(entityType, id, uid)
	if isDebugBuild then
		return string.format("%s-%s-%s", entityType, id, uid)
	end

	return entityType
end

function ArcadeSurvivorEntityMgr:onPreGameStart()
	local characterMO = ArcadeSurvivorGameModel.instance:getCharacterMO()

	if not characterMO then
		logError("ArcadeSurvivorEntityMgr:onPreGameStart error, characterMO is nil")

		return
	end

	local uid = characterMO:getUid()
	local id = characterMO:getId()
	local characterEntityType = ArcadeSurvivorEnum.EntityType.Character
	local goName = self:_getEntityGameObjectName(characterEntityType, id, uid)
	local goEntity = gohelper.create3d(self.go, goName)

	self._characterEntity = MonoHelper.addNoUpdateLuaComOnceToGo(goEntity, ArcadeSurvivorGameCharacterEntity, {
		entityType = characterEntityType,
		id = id,
		uid = uid
	})

	local prefabResName = characterMO:getResName()

	self._characterEntity:change2Prefab(prefabResName)
end

function ArcadeSurvivorEntityMgr:changeEntityPrefab(entityType, uid, targetPrefabName)
	local entity = self:getEntity(entityType, uid)

	if not entity then
		return
	end

	entity:change2Prefab(targetPrefabName)
end

function ArcadeSurvivorEntityMgr:addEntity(mo, cb, cbObj)
	local scene = ArcadeSurvivorGameController.instance:getGameScene()

	if not mo or not scene then
		GameUtil.handleCallbackFunc(cb, cbObj)

		return
	end

	local entityType = mo:getEntityType()
	local entityCls = ArcadeSurvivorGameEnum.EntityTypeCls[entityType]

	if not entityCls then
		logError(string.format("ArcadeSurvivorEntityMgr:addEntity error, entityType:%s cls is nil", entityType))

		return
	end

	local id = mo:getId()
	local uid = mo:getUid()
	local entityParam = {
		entityType = entityType,
		id = id,
		uid = uid
	}
	local goName = self:_getEntityGameObjectName(entityType, id, uid)
	local goEntity = gohelper.create3d(self.go, goName)
	local entity = MonoHelper.addNoUpdateLuaComOnceToGo(goEntity, entityCls, entityParam)
	local typeDict = GameUtil.tabletool_checkDictTable(self._entityDict, entityType)

	typeDict[uid] = entity

	local resName = mo:getResName()
	local resPath = ResUrl.getArcadeSurvivorScenePrefabRes(ArcadeSurvivorEnum.ResDir.EntityPrefab, resName)

	scene.loader:loadRes(resPath, self._onLoadEntityRes, self, {
		mo = mo,
		cb = cb,
		cbObj = cbObj
	})
	ArcadeSurvivorGameController.instance:dispatchEvent(ArcadeSurvivorEvent.OnAddEntity, mo)
end

function ArcadeSurvivorEntityMgr:_onLoadEntityRes(param)
	local scene = ArcadeSurvivorGameController.instance:getGameScene()

	if not scene or not param then
		return
	end

	local mo = param.mo
	local uid = mo:getUid()
	local entityType = mo:getEntityType()
	local entity = self:getEntity(entityType, uid, true)

	if entity then
		local resName = mo:getResName()
		local resPath = ResUrl.getArcadeSurvivorScenePrefabRes(ArcadeSurvivorEnum.ResDir.EntityPrefab, resName)
		local resObj = scene.loader:getResource(resPath)

		entity:change2PrefabWithResObj(resName, resObj)
	end

	GameUtil.handleCallbackFunc(param.cb, param.cbObj)
end

function ArcadeSurvivorEntityMgr:addEntityByList(moList, cb, cbObj)
	local scene = ArcadeSurvivorGameController.instance:getGameScene()

	if not moList or #moList <= 0 or not scene then
		GameUtil.handleCallbackFunc(cb, cbObj)

		return
	end

	local resDict = {}
	local resList = {}
	local loadMOList = {}
	local entityParam = {}

	for _, mo in ipairs(moList) do
		local entityType = mo:getEntityType()
		local entityCls = ArcadeSurvivorGameEnum.EntityTypeCls[entityType]

		if entityCls then
			local uid = mo:getUid()
			local id = mo:getId()

			entityParam.entityType = entityType
			entityParam.id = id
			entityParam.uid = uid

			local goName = self:_getEntityGameObjectName(entityType, id, uid)
			local goEntity = gohelper.create3d(self.go, goName)
			local entity = MonoHelper.addNoUpdateLuaComOnceToGo(goEntity, entityCls, entityParam)
			local typeDict = GameUtil.tabletool_checkDictTable(self._entityDict, entityType)

			typeDict[uid] = entity

			local resName = mo:getResName()
			local resPath = ResUrl.getArcadeSurvivorScenePrefabRes(ArcadeSurvivorEnum.ResDir.EntityPrefab, resName)

			if resPath and not resDict[resPath] then
				resDict[resPath] = true
				resList[#resList + 1] = resPath
			end

			loadMOList[#loadMOList + 1] = mo
		else
			logError(string.format("ArcadeSurvivorEntityMgr:addEntityByList error, entityType:%s cls is nil", entityType))
		end
	end

	scene.loader:loadResList(resList, self._onLoadEntityListRes, self, {
		loadMOList = loadMOList,
		cb = cb,
		cbObj = cbObj
	})
	ArcadeSurvivorGameController.instance:dispatchEvent(ArcadeSurvivorEvent.OnAddEntities, moList)
end

function ArcadeSurvivorEntityMgr:_onLoadEntityListRes(param)
	local scene = ArcadeSurvivorGameController.instance:getGameScene()

	if not scene or not param then
		return
	end

	local loadMOList = param.loadMOList

	for _, mo in ipairs(loadMOList) do
		local uid = mo:getUid()
		local entityType = mo:getEntityType()
		local entity = self:getEntity(entityType, uid, true)

		if entity then
			local resName = mo:getResName()
			local resPath = ResUrl.getArcadeSurvivorScenePrefabRes(ArcadeSurvivorEnum.ResDir.EntityPrefab, resName)
			local resObj = scene.loader:getResource(resPath)

			entity:change2PrefabWithResObj(resName, resObj)
		end
	end

	GameUtil.handleCallbackFunc(param.cb, param.cbObj)
end

function ArcadeSurvivorEntityMgr:removeEntity(entityType, uid)
	if entityType == ArcadeSurvivorEnum.EntityType.Character then
		if self._characterEntity then
			self._characterEntity:destroy()
		end

		self._characterEntity = nil
	else
		local entity = self:getEntity(entityType, uid)

		if entity then
			entity:destroy()

			self._entityDict[entityType][uid] = nil
		end
	end
end

function ArcadeSurvivorEntityMgr:clearAllEntity(includeCharacter)
	if includeCharacter then
		if self._characterEntity then
			self._characterEntity:destroy()
		end

		self._characterEntity = nil
	end

	if self._entityDict then
		for _, dict in pairs(self._entityDict) do
			for _, entity in pairs(dict) do
				entity:destroy()
			end
		end
	end

	self._entityDict = {}
end

function ArcadeSurvivorEntityMgr:setAllEntityIsShow(isShow)
	gohelper.setActive(self.go, isShow)
end

function ArcadeSurvivorEntityMgr:getCharacterEntity()
	return self._characterEntity
end

function ArcadeSurvivorEntityMgr:getEntity(entityType, uid, nilError)
	local result

	if entityType then
		if entityType == ArcadeSurvivorEnum.EntityType.Character then
			result = self:getCharacterEntity()
		elseif uid then
			local dict = self._entityDict[entityType]

			result = dict and dict[uid]
		end
	end

	if not result and nilError then
		logError(string.format("ArcadeSurvivorEntityMgr:getEntity error, entityType:%s uid:%s", entityType, uid))
	end

	return result
end

return ArcadeSurvivorEntityMgr
