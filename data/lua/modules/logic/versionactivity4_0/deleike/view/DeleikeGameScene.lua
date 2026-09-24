-- chunkname: @modules/logic/versionactivity4_0/deleike/view/DeleikeGameScene.lua

module("modules.logic.versionactivity4_0.deleike.view.DeleikeGameScene", package.seeall)

local DeleikeGameScene = class("DeleikeGameScene", BaseView)
local Vector2 = UnityEngine.Vector2

function DeleikeGameScene:onInitView()
	self.goScene = gohelper.findChild(self.viewGO, "Scene")
	self._goJoyStick = gohelper.findChild(self.viewGO, "go_Joystick")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function DeleikeGameScene:addEvents()
	self:addEventCb(DeleikeController.instance, DeleikeEvent.ResetGame, self._onResetGame, self)
end

function DeleikeGameScene:removeEvents()
	return
end

function DeleikeGameScene:_onResetGame()
	self:buildMap()
end

function DeleikeGameScene:_editableInitView()
	return
end

function DeleikeGameScene:onOpen()
	DeleikeGameMgr.instance:initScene(self.goScene)
	self:buildMap()
end

function DeleikeGameScene:buildMap()
	DeleikeGameMgr.instance:clearScene()

	local mapCfg = DeleikeGameMgr.instance.mapCfg

	DeleikeGameMgr.instance:addBgTile(0, 0, Vector2.zero)

	for _, w in ipairs(mapCfg.walls) do
		local tileType = w.type == "anchor" and DeleikeEnum.TileType.Anchor or DeleikeEnum.TileType.Normal
		local ix = math.floor(w.x + 0.5)
		local iy = math.floor(w.y + 0.5)

		DeleikeGameMgr.instance:addPolygonTile(tileType, ix, iy, DeleikeHelper.GridToWorld(ix, iy))
	end

	for _, endpoint in ipairs(mapCfg.triggers) do
		local type = endpoint.type
		local ix = math.floor(endpoint.x + 0.5)
		local iy = math.floor(endpoint.y + 0.5)

		DeleikeGameMgr.instance:addTriggerPoint(type, ix, iy, DeleikeHelper.GridToWorld(ix, iy))
	end

	local spawnPos = DeleikeHelper.GridToWorld(mapCfg.spawn.x, mapCfg.spawn.y)

	DeleikeGameMgr.instance:createPlayer(spawnPos, self._goJoyStick)
end

function DeleikeGameScene:onDestroyView()
	DeleikeGameMgr.instance:dispose()
end

return DeleikeGameScene
