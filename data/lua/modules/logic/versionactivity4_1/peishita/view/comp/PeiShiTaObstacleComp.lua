-- chunkname: @modules/logic/versionactivity4_1/peishita/view/comp/PeiShiTaObstacleComp.lua

module("modules.logic.versionactivity4_1.peishita.view.comp.PeiShiTaObstacleComp", package.seeall)

local PeiShiTaObstacleComp = class("PeiShiTaObstacleComp", PeiShiTaUnitComp)

function PeiShiTaObstacleComp:init(go)
	PeiShiTaObstacleComp.super.init(self, go)

	self._goAxe = gohelper.findChild(go, "#go_Axe")
	self._dirArrowGo = self:getUserDataTb_()
	self._dirArrowGo[PeiShiTaEnum.Direction.Up] = gohelper.findChild(self._goAxe, "#go_Top")
	self._dirArrowGo[PeiShiTaEnum.Direction.Down] = gohelper.findChild(self._goAxe, "#go_Bottom")
	self._dirArrowGo[PeiShiTaEnum.Direction.Left] = gohelper.findChild(self._goAxe, "#go_Left")
	self._dirArrowGo[PeiShiTaEnum.Direction.Right] = gohelper.findChild(self._goAxe, "#go_Right")
	self._goTree = gohelper.findChild(self.go, "#go_Tree")
	self._animator = SLFramework.AnimatorPlayer.Get(self._goTree)
	self._animComp = gohelper.onceAddComponent(self._goTree, gohelper.Type_Animator)
end

function PeiShiTaObstacleComp:addEventListeners()
	PeiShiTaObstacleComp.super.addEventListeners(self)
	self:addEventCb(PeiShiTaGameController.instance, PeiShiTaEvent.OnToolChanged, self._onToolChanged, self)
	self:addEventCb(PeiShiTaGameController.instance, PeiShiTaEvent.OnUnitRemove, self._onObstacleDie, self)
	self:addEventCb(PeiShiTaGameController.instance, PeiShiTaEvent.OnBoardChanged, self._onBoardChanged, self)
end

function PeiShiTaObstacleComp:_onBoardChanged()
	if not self._inUse then
		return
	end

	self:_refreshAxeIcon()
end

function PeiShiTaObstacleComp:_onToolChanged(toolId)
	if not self._inUse or toolId ~= PeiShiTaEnum.ToolId.Axe then
		return
	end

	self:_refreshAxeIcon()
end

function PeiShiTaObstacleComp:setUnitData(gameMo, unit)
	PeiShiTaObstacleComp.super.setUnitData(self, gameMo, unit)
	self:_refreshAxeIcon()
end

function PeiShiTaObstacleComp:_refreshAxeIcon()
	local player = PeiShiTaGameModel.instance:getUnitById(self._gameMo.playerId)

	if not player then
		return
	end

	local dx = player.pos.x - self._unitX
	local dy = player.pos.y - self._unitY
	local isAdjacent = math.abs(dx) + math.abs(dy) == 1

	gohelper.setActive(self._goAxe, isAdjacent and PeiShiTaCellHelper.canRemoveObstacle(PeiShiTaEnum.UnitType.Obstacle))

	local moveDir

	if isAdjacent then
		if dx ~= 0 then
			moveDir = dx > 0 and PeiShiTaEnum.Direction.Right or PeiShiTaEnum.Direction.Left
		else
			moveDir = dy > 0 and PeiShiTaEnum.Direction.Down or PeiShiTaEnum.Direction.Up
		end
	end

	for dir, arrowGo in pairs(self._dirArrowGo) do
		gohelper.setActive(arrowGo, dir == moveDir)
	end
end

function PeiShiTaObstacleComp:_onObstacleDie(unit, x, y)
	if not self._inUse then
		return
	end

	if self._unitX ~= x or self._unitY ~= y then
		return
	end

	self._animator:Play("close", self._reallyRetire, self)
	AudioMgr.instance:trigger(AudioEnum4_1.PeiShiTa.play_ui_atlantis_cut_trees)
end

return PeiShiTaObstacleComp
