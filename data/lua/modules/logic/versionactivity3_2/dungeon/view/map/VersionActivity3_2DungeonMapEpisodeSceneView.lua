﻿-- chunkname: @modules/logic/versionactivity3_2/dungeon/view/map/VersionActivity3_2DungeonMapEpisodeSceneView.lua

module("modules.logic.versionactivity3_2.dungeon.view.map.VersionActivity3_2DungeonMapEpisodeSceneView", package.seeall)

local VersionActivity3_2DungeonMapEpisodeSceneView = class("VersionActivity3_2DungeonMapEpisodeSceneView", BaseView)

function VersionActivity3_2DungeonMapEpisodeSceneView:onInitView()
	self._sceneNodeList = self:getUserDataTb_()
	self._episodeContainerItemList = self:getUserDataTb_()
	self._episodeSPContainerItemList = self:getUserDataTb_()
	self._goScrollContent = gohelper.findChild(self.viewGO, "#scroll_content")
	self._goMapEpisodeContainer = gohelper.create2d(self.viewGO, "mapEpisodeList")

	gohelper.setSiblingBefore(self._goMapEpisodeContainer, self._goScrollContent)

	local goFullScreen = gohelper.findChild(self.viewGO, "#go_fullscreen")

	gohelper.setSiblingAfter(goFullScreen, self._goMapEpisodeContainer)

	self._gotemplatenormal = gohelper.create2d(self._goMapEpisodeContainer, "mapEpisodeItem")
	self.episodeItemPath = self.viewContainer:getSetting().otherRes.normalSceneItem
	self.episodeItemSpPath = self.viewContainer:getSetting().otherRes.spSceneItem

	self:addEventCb(DungeonController.instance, DungeonMapElementEvent.OnLoadSceneFinish, self.loadSceneFinish, self)
	self:addEventCb(VersionActivityDungeonBaseController.instance, VersionActivityDungeonEvent.OnModeChange, self.onModeChange, self)
end

function VersionActivity3_2DungeonMapEpisodeSceneView:getSceneNode(name)
	local node = self._sceneNodeList[name]

	if gohelper.isNil(node) then
		node = UnityEngine.GameObject.New(tostring(name))

		gohelper.addChild(self._mapSceneGo, node)

		self._sceneNodeList[name] = node
	end

	return node
end

function VersionActivity3_2DungeonMapEpisodeSceneView:_addFollower(go, config, index)
	local episodeId = config.id

	if config.chapterId == 32201 then
		episodeId = episodeId - 10000
	end

	local extraConfig = lua_v3a2_chapter_map.configDict[episodeId]
	local uiFollower = gohelper.onceAddComponent(go, typeof(ZProj.UIFollower))
	local name = string.format("%s_%s", config.type, config.id)
	local entity = self:getSceneNode(name)
	local eventCoordinate = extraConfig and extraConfig.position or {}
	local posX = eventCoordinate[1] or 0
	local posY = eventCoordinate[2] or 0

	transformhelper.setLocalPos(entity.transform, posX, posY, 0)

	local mainCamera = CameraMgr.instance:getMainCamera()
	local uiCamera = CameraMgr.instance:getUICamera()
	local plane = ViewMgr.instance:getUIRoot().transform

	uiFollower:Set(mainCamera, uiCamera, plane, entity.transform, 0, 0, 0, 0, 0)
	uiFollower:SetEnable(true)
	uiFollower:ForceUpdate()
end

function VersionActivity3_2DungeonMapEpisodeSceneView:loadSceneFinish(param)
	self._mapCfg = param.mapConfig
	self._mapSceneGo = param.mapSceneGo
	self._sceneNodeList = self:getUserDataTb_()

	self:_updateMapEpisodeList()
end

function VersionActivity3_2DungeonMapEpisodeSceneView:onModeChange()
	self:_updateMapEpisodeList()
end

function VersionActivity3_2DungeonMapEpisodeSceneView:onOpen()
	self:_updateMapEpisodeList()
end

function VersionActivity3_2DungeonMapEpisodeSceneView:_updateMapEpisodeList()
	if not self._mapSceneGo then
		return
	end

	local spIndex = 0
	local index = 0
	local dungeonMo, episodeContainerItem
	local episodeList = DungeonConfig.instance:getChapterEpisodeCOList(self.activityDungeonMo.chapterId)

	for _, config in ipairs(episodeList) do
		dungeonMo = config and DungeonModel.instance:getEpisodeInfo(config.id) or nil

		if dungeonMo then
			if config.type ~= DungeonEnum.EpisodeType.V3_2SP then
				index = index + 1
				episodeContainerItem = self:getEpisodeContainerItem(index)
				episodeContainerItem.containerTr.name = config.id

				episodeContainerItem.episodeItem:refresh(config, dungeonMo)
				self:_addFollower(episodeContainerItem.episodeItem.viewGO, config, index)
			else
				spIndex = spIndex + 1
				episodeContainerItem = self:getSPEpisodeContainerItem(spIndex)
				episodeContainerItem.containerTr.name = config.id

				episodeContainerItem.episodeItem:refresh(config, dungeonMo)
				self:_addFollower(episodeContainerItem.episodeItem.viewGO, config, spIndex)
			end
		end
	end

	for i = index + 1, #self._episodeContainerItemList do
		gohelper.setActive(self._episodeContainerItemList[i].containerTr.gameObject, false)
	end

	for i = spIndex + 1, #self._episodeSPContainerItemList do
		gohelper.setActive(self._episodeSPContainerItemList[i].containerTr.gameObject, false)
	end
end

function VersionActivity3_2DungeonMapEpisodeSceneView:getEpisodeContainerItem(index)
	local episodeContainerItem = self._episodeContainerItemList[index]

	if episodeContainerItem then
		gohelper.setActive(episodeContainerItem.containerTr.gameObject, true)
		episodeContainerItem.episodeItem:clearElementIdList()

		return episodeContainerItem
	end

	episodeContainerItem = self:getUserDataTb_()

	local go = gohelper.cloneInPlace(self._gotemplatenormal, tostring(index))

	gohelper.setActive(go, true)

	episodeContainerItem.containerTr = go.transform

	local episodeItemViewGo = self.viewContainer:getResInst(self.episodeItemPath, go)
	local episodeItem = VersionActivity3_2DungeonMapEpisodeSceneItem.New()

	episodeItem.viewContainer = self.viewContainer
	episodeItem.activityDungeonMo = self.activityDungeonMo

	episodeItem:initView(episodeItemViewGo, {
		self.contentTransform,
		self
	})

	episodeContainerItem.episodeItem = episodeItem

	table.insert(self._episodeContainerItemList, episodeContainerItem)

	return episodeContainerItem
end

function VersionActivity3_2DungeonMapEpisodeSceneView:getSPEpisodeContainerItem(index)
	local episodeContainerItem = self._episodeSPContainerItemList[index]

	if episodeContainerItem then
		gohelper.setActive(episodeContainerItem.containerTr.gameObject, true)
		episodeContainerItem.episodeItem:clearElementIdList()

		return episodeContainerItem
	end

	episodeContainerItem = self:getUserDataTb_()

	local go = gohelper.cloneInPlace(self._gotemplatenormal, tostring(index))

	gohelper.setActive(go, true)

	episodeContainerItem.containerTr = go.transform

	local episodeItemViewGo = self.viewContainer:getResInst(self.episodeItemSpPath, go)
	local episodeItem = VersionActivity3_2DungeonMapEpisodeSceneItem.New()

	episodeItem.viewContainer = self.viewContainer
	episodeItem.activityDungeonMo = self.activityDungeonMo

	episodeItem:initView(episodeItemViewGo, {
		self.contentTransform,
		self
	})

	episodeContainerItem.episodeItem = episodeItem

	table.insert(self._episodeSPContainerItemList, episodeContainerItem)

	return episodeContainerItem
end

function VersionActivity3_2DungeonMapEpisodeSceneView:onClose()
	for i, v in pairs(self._episodeContainerItemList) do
		v.episodeItem:destroyView()
	end

	for i, v in pairs(self._episodeSPContainerItemList) do
		v.episodeItem:destroyView()
	end
end

return VersionActivity3_2DungeonMapEpisodeSceneView
