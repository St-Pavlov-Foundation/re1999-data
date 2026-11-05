-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/view/game/scene/comp/ArcadeSurvivorTileMgr.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.view.game.scene.comp.ArcadeSurvivorTileMgr", package.seeall)

local ArcadeSurvivorTileMgr = class("ArcadeSurvivorTileMgr", ArcadeSurvivorBaseSceneComp)

function ArcadeSurvivorTileMgr:onInit()
	self._curTileResName = nil
	self._loadingTileResName = nil
	self._tileDict = self:getUserDataTb_()

	transformhelper.setLocalPos(self.trans, 0, 0, ArcadeSurvivorGameEnum.Const.TileZLevel)
end

function ArcadeSurvivorTileMgr:onEnterLevel()
	local levelRuleId = ArcadeSurvivorGameModel.instance:getCurLevelRule()
	local tileResName = ArcadeSurvivorConfig.instance:getLevelRuleTileRes(levelRuleId)

	if tileResName ~= self._curTileResName then
		self._loadingTileResName = tileResName

		local tileResPath = ResUrl.getArcadeSurvivorScenePrefabRes(ArcadeSurvivorEnum.ResDir.ScenePrefab, tileResName)
		local scene = ArcadeSurvivorGameController.instance:getGameScene()

		scene.loader:loadRes(tileResPath, self._onLoadTileResFinish, self, tileResName)
	else
		self:_refreshTile()
	end
end

function ArcadeSurvivorTileMgr:_onLoadTileResFinish(tileResName)
	local scene = ArcadeSurvivorGameController.instance:getGameScene()

	if not scene then
		return
	end

	if not self._loadingTileResName or self._loadingTileResName ~= tileResName then
		return
	end

	self._loadingTileResName = nil

	if self._curTileResName ~= tileResName then
		self:_clearTiles()

		local tileResPath = ResUrl.getArcadeSurvivorScenePrefabRes(ArcadeSurvivorEnum.ResDir.ScenePrefab, tileResName)
		local tileRes = scene.loader:getResource(tileResPath)

		self._goTile = gohelper.clone(tileRes, self.go)

		gohelper.setActive(self._goTile, false)

		self._curTileResName = tileResName
	end

	self:_refreshTile()
end

function ArcadeSurvivorTileMgr:_refreshTile()
	if gohelper.isNil(self._goTile) then
		return
	end

	local mapSizeX, mapSizeY = ArcadeSurvivorGameModel.instance:getMapSize()

	if mapSizeX <= 0 or mapSizeY <= 0 then
		return
	end

	local levelRuleId = ArcadeSurvivorGameModel.instance:getCurLevelRule()
	local tileSize = ArcadeSurvivorConfig.instance:getLevelRuleTileSize(levelRuleId)

	if not tileSize or tileSize <= 0 then
		return
	end

	local baseGridSize = ArcadeSurvivorConfig.instance:getGameBaseGridSize()
	local tileSizeX = tileSize * baseGridSize
	local tileSizeY = tileSize * baseGridSize
	local tileCountX = math.ceil(mapSizeX / tileSize)
	local tileCountY = math.ceil(mapSizeY / tileSize)

	for i = 0, tileCountX - 1 do
		local posX = (i - (tileCountX - 1) * 0.5) * tileSizeX

		for j = 0, tileCountY - 1 do
			local key = string.format("%s#%s", i, j)
			local goTile = self._tileDict[key]

			if gohelper.isNil(goTile) then
				goTile = gohelper.cloneInPlace(self._goTile, key)
				self._tileDict[key] = goTile

				local scene = ArcadeSurvivorGameController.instance:getGameScene()

				scene.effectMgr:registerGrayscaleGO(goTile)
			end

			local posY = (j - (tileCountY - 1) * 0.5) * tileSizeY

			transformhelper.setLocalPos(goTile.transform, posX, posY, 0)
			gohelper.setActive(goTile, true)
		end
	end

	for key, goTile in pairs(self._tileDict) do
		local strI, strJ = key:match("^(%d+)#(%d+)$")
		local i = tonumber(strI)
		local j = tonumber(strJ)

		if tileCountX <= i or tileCountY <= j then
			gohelper.setActive(goTile, false)
		end
	end
end

function ArcadeSurvivorTileMgr:onClear()
	self:_clearTiles()
end

function ArcadeSurvivorTileMgr:_clearTiles()
	self._curTileResName = nil
	self._loadingTileResName = nil

	if self._goTile then
		gohelper.destroy(self._goTile)
	end

	self._goTile = nil

	for _, tile in pairs(self._tileDict) do
		local scene = ArcadeSurvivorGameController.instance:getGameScene()

		if scene then
			scene.effectMgr:unregisterGrayscaleGO(tile)
		end

		gohelper.destroy(tile)
	end

	self._tileDict = self:getUserDataTb_()
end

return ArcadeSurvivorTileMgr
