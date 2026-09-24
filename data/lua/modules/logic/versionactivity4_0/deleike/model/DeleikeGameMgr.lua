-- chunkname: @modules/logic/versionactivity4_0/deleike/model/DeleikeGameMgr.lua

module("modules.logic.versionactivity4_0.deleike.model.DeleikeGameMgr", package.seeall)

local DeleikeGameMgr = class("DeleikeGameMgr")
local Vector2 = UnityEngine.Vector2

function DeleikeGameMgr:startGame(gameId)
	self.gameId = gameId
	self.gameCfg, self.mapCfg = DeleikeConfig.instance:getGameConfig(self.gameId)

	if not self.gameCfg or not self.mapCfg then
		return
	end

	self.bgResPath = ResUrl.getDeleikeSingleBg(self.gameCfg.mapBg)
	self.skillMgr = DeleikeSkillMgr.New()
	self.unitCoord = DeleikeUnitCoord.New()
	self.inputLocked = false

	ViewMgr.instance:openView(ViewName.DeleikeGameView)
end

function DeleikeGameMgr:endGame()
	DeleikeController.instance:onGameFinish()
	ViewMgr.instance:closeView(ViewName.DeleikeGameView)
end

function DeleikeGameMgr:setInputLocked(locked)
	self.inputLocked = locked == true

	if self.inputLocked and self.skillMgr then
		self.skillMgr:resetState()
	end
end

function DeleikeGameMgr:initScene(sceneRoot)
	self.sceneRoot = sceneRoot
	self.sceneRootRt = sceneRoot.transform
	self.goBgTile = gohelper.findChild(sceneRoot, "BgRoot/go_BgTile")
	self.goGridTile = gohelper.findChild(sceneRoot, "GridRoot/go_GridTile")
	self.goAnchorTile = gohelper.findChild(sceneRoot, "TileRoot/go_AnchorTile")
	self.goNormalTile = gohelper.findChild(sceneRoot, "TileRoot/go_NormalTile")
	self.goSkillPoint = gohelper.findChild(sceneRoot, "TriggerRoot/go_SkillPoint")
	self.goDoor = gohelper.findChild(sceneRoot, "TriggerRoot/go_Door")
	self.goLineTile = gohelper.findChild(sceneRoot, "LineRoot/go_LineTile")
	self.goSkillLine1 = gohelper.findChild(sceneRoot, "go_SkillLine1")
	self.goSkillLine2 = gohelper.findChild(sceneRoot, "go_SkillLine2")
	self.goPlayer = gohelper.findChild(sceneRoot, "Player")
	self.goSkillMask = gohelper.findChild(sceneRoot, "go_SkillMask")

	if self.goSkillMask then
		gohelper.setActive(self.goSkillMask, false)
	end

	self.skillMgr:init(self.goSkillLine1, self.goSkillLine2)
end

function DeleikeGameMgr:addPolygonTile(tileType, x, y, worldPos, rotation, polygon, customName, rect)
	if not polygon and (tileType == DeleikeEnum.TileType.Normal or tileType == DeleikeEnum.TileType.Anchor) then
		worldPos = Vector2(worldPos.x, worldPos.y + DeleikeEnum.NormalTileArtOffsetY)
	end

	local mo = DeleikeTileMo.New()

	mo:init(tileType, x, y, worldPos, rotation, polygon, rect)

	local name = customName or DeleikeHelper.GetTileName(tileType, x, y)
	local go = gohelper.cloneInPlace(self:_getTilePrefab(tileType), name)

	gohelper.setActive(go, true)

	local comp = MonoHelper.addNoUpdateLuaComOnceToGo(go, self:_getTileClass(tileType))

	comp:setData(mo)

	if tileType == DeleikeEnum.TileType.Bg and self.bgResPath then
		gohelper.getSingleImage(go):LoadImage(self.bgResPath)
	end

	self.unitCoord:registerUnit(comp)

	return comp
end

function DeleikeGameMgr:addBgTile(x, y, worldPos)
	local comp = self:addPolygonTile(DeleikeEnum.TileType.Bg, x, y, worldPos)

	if self.goGridTile then
		local hw = DeleikeEnum.GridColumn * DeleikeEnum.GridUnit * 0.5
		local hh = DeleikeEnum.GridRow * DeleikeEnum.GridUnit * 0.5

		self:addPolygonTile(DeleikeEnum.TileType.Grid, x, y, worldPos, 0, {
			{
				x = -hw,
				y = -hh
			},
			{
				x = hw,
				y = -hh
			},
			{
				x = hw,
				y = hh
			},
			{
				x = -hw,
				y = hh
			}
		}, comp.go.name .. "_Grid")
	end
end

function DeleikeGameMgr:addLineTile(centerX, centerY, dirX, dirY)
	local perpX, perpY = -dirY, dirX
	local perpAngle = math.deg(math.atan2(perpY, perpX))
	local name = string.format("Line_%d", math.random(1000, 9999))

	self:addPolygonTile(DeleikeEnum.TileType.Line, 0, 0, Vector2(centerX, centerY), perpAngle, nil, name)
end

function DeleikeGameMgr:addTriggerPoint(type, x, y, worldPos)
	local isSkillPoint = type ~= DeleikeEnum.TriggerType.Door
	local template = isSkillPoint and self.goSkillPoint or self.goDoor
	local go = gohelper.cloneInPlace(template)

	gohelper.setActive(go, true)

	local comp = MonoHelper.addLuaComOnceToGo(go, isSkillPoint and DeleikeTriggerSkill or DeleikeTriggerDoor)

	comp:setData(type, x, y, worldPos)
	self.unitCoord:registerUnit(comp)
end

function DeleikeGameMgr:createPlayer(spawnPos, goJoystick)
	if self.player then
		return
	end

	self.player = MonoHelper.addNoUpdateLuaComOnceToGo(self.goPlayer, DeleikePlayerComp, goJoystick)

	self.player:setPos(spawnPos.x, spawnPos.y)

	if self.skillMgr then
		self.skillMgr.player = self.player
	end

	self.unitCoord:registerUnit(self.player)
end

function DeleikeGameMgr:onTriggerPicked(triggerType)
	if not self.player then
		return
	end

	if triggerType == DeleikeEnum.TriggerType.Skill1 then
		local count = self.player:getSkillCount(1)

		self.player:setSkillCount(1, count + 1, true)
	elseif triggerType == DeleikeEnum.TriggerType.Skill2 then
		local count = self.player:getSkillCount(2)

		self.player:setSkillCount(2, count + 1, true)
	end
end

function DeleikeGameMgr:clearScene()
	local unitCoord = self.unitCoord

	if unitCoord then
		local units = unitCoord:getAllUnits()

		for i = 1, #units do
			local comp = units[i]

			if comp.go and not gohelper.isNil(comp.go) and comp ~= self.player then
				gohelper.destroy(comp.go)
			end
		end

		unitCoord:clearAll()
	end

	if self.skillMgr then
		self.skillMgr:resetState()

		self.skillMgr.player = nil
	end

	self.inputLocked = false

	if self.player then
		self.player:resetState()

		self.player = nil
	end
end

function DeleikeGameMgr:dispose()
	self:clearScene()

	self.gameId = nil
	self.gameCfg, self.mapCfg = nil
	self.goBgTile = nil
	self.goGridTile = nil
	self.goAnchorTile, self.goNormalTile = nil
	self.goSkillPoint, self.goDoor = nil
	self.goLineTile = nil
	self.goSkillLine1, self.goSkillLine2 = nil
	self.goSkillMask = nil
	self.goPlayer = nil

	if self.unitCoord then
		self.unitCoord:dispose()

		self.unitCoord = nil
	end

	if self.skillMgr then
		self.skillMgr:dispose()

		self.skillMgr = nil
	end
end

function DeleikeGameMgr:_getTilePrefab(tileType)
	if tileType == DeleikeEnum.TileType.Bg then
		return self.goBgTile
	elseif tileType == DeleikeEnum.TileType.Grid then
		return self.goGridTile
	elseif tileType == DeleikeEnum.TileType.Anchor then
		return self.goAnchorTile
	elseif tileType == DeleikeEnum.TileType.Line then
		return self.goLineTile
	end

	return self.goNormalTile
end

function DeleikeGameMgr:_getTileClass(type)
	if not self.type2Class then
		self.type2Class = {
			[DeleikeEnum.TileType.Bg] = DeleikeTileBg,
			[DeleikeEnum.TileType.Grid] = DeleikeTileBg,
			[DeleikeEnum.TileType.Normal] = DeleikeTileNormal,
			[DeleikeEnum.TileType.Line] = DeleikeTileLine
		}
	end

	return self.type2Class[type] or DeleikeTileNormal
end

DeleikeGameMgr.instance = DeleikeGameMgr.New()

return DeleikeGameMgr
