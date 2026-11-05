-- chunkname: @modules/logic/versionactivity4_1/peishita/view/PeiShiTaGameView.lua

module("modules.logic.versionactivity4_1.peishita.view.PeiShiTaGameView", package.seeall)

local PeiShiTaGameView = class("PeiShiTaGameView", BaseView)

function PeiShiTaGameView:onInitView()
	self._txtTarget = gohelper.findChildText(self.viewGO, "#go_desc/Image_TargetBG/#txt_Target")
	self._goCellRoot = gohelper.findChild(self.viewGO, "#go_CellRoot")
	self._goCellTemplate = gohelper.findChild(self.viewGO, "#go_CellRoot/#go_CellTemplate")
	self._goUnitRoot = gohelper.findChild(self.viewGO, "#go_UnitRoot")
	self._goUnitInstanceRoot = gohelper.findChild(self.viewGO, "#go_UnitRoot/#go_UnitInstanceRoot")
	self._goUnitTemplateList = gohelper.findChild(self.viewGO, "#go_UnitRoot/#go_UnitTemlateList")
	self._goEffectRoot = gohelper.findChild(self.viewGO, "#go_EffectRoot")
	self._goDirPad = gohelper.findChild(self.viewGO, "#go_joyPoint/#go_joystick")
	self._btnReset = gohelper.findChildButtonWithAudio(self.viewGO, "#go_topright/#btn_reset")
	self._goToolItem = gohelper.findChild(self.viewGO, "#go_ToolPanel/#scroll_Tool/Viewport/content/#go_ToolItem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function PeiShiTaGameView:_editableInitView()
	self._cellList = self:getUserDataTb_()
	self._unitGoRegistry = self:getUserDataTb_()
	self._unitGroupRegistry = self:getUserDataTb_()

	PeiShiTaUnitCreateHelper.createUnitGroups(self)

	self._cellCoords = {}

	for y = 1, PeiShiTaEnum.BoardSize.Row do
		for x = 1, PeiShiTaEnum.BoardSize.Column do
			table.insert(self._cellCoords, {
				x = x,
				y = y
			})
		end
	end

	gohelper.setActive(self._goUnitTemplateList, false)
	MonoHelper.addLuaComOnceToGo(self._goDirPad, PeiShiTaDirPadComp)

	self._viewAnimator = gohelper.onceAddComponent(self.viewGO, gohelper.Type_Animator)
end

function PeiShiTaGameView:addEvents()
	self:addEventCb(PeiShiTaGameController.instance, PeiShiTaEvent.OnUnitMove, self._onBoardChanged, self, LuaEventSystem.Low)
	self:addEventCb(PeiShiTaGameController.instance, PeiShiTaEvent.OnUnitRemove, self._onBoardChanged, self, LuaEventSystem.Low)
	self:addEventCb(PeiShiTaGameController.instance, PeiShiTaEvent.OnToolChanged, self._onToolChanged, self)
	self:addEventCb(PeiShiTaGameController.instance, PeiShiTaEvent.OnLevelReset, self._onLevelReset, self)
	self:addEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, self._onOpenViewFinish, self)
	self._btnReset:AddClickListener(self._btnResetOnClick, self)
end

function PeiShiTaGameView:removeEvents()
	self:removeEventCb(PeiShiTaGameController.instance, PeiShiTaEvent.OnUnitMove, self._onBoardChanged, self)
	self:removeEventCb(PeiShiTaGameController.instance, PeiShiTaEvent.OnUnitRemove, self._onBoardChanged, self)
	self:removeEventCb(PeiShiTaGameController.instance, PeiShiTaEvent.OnToolChanged, self._onToolChanged, self)
	self:removeEventCb(PeiShiTaGameController.instance, PeiShiTaEvent.OnLevelReset, self._onLevelReset, self)
	self:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, self._onOpenViewFinish, self)
	self._btnReset:RemoveClickListener()
end

function PeiShiTaGameView:onOpen()
	GameGCMgr.instance:dispatchEvent(GameGCEvent.SetBanGc, self.viewName, true)
	self:refreshUI()
end

function PeiShiTaGameView:onOpenFinish()
	local gameId = PeiShiTaGameModel.instance:getGameId()

	PeiShiTaController.instance:dispatchEvent(PeiShiTaEvent.OnEnterGame, gameId)
end

function PeiShiTaGameView:refreshUI()
	self:_refreshLevelTarget()
	self:_refreshBoard()
	self:_refreshToolPanel()
end

function PeiShiTaGameView:_refreshLevelTarget()
	local gameConfig = PeiShiTaGameModel.instance:getGameConfig()

	self._txtTarget.text = gameConfig and gameConfig.targetDesc or ""
end

function PeiShiTaGameView:_refreshBoard()
	local gameMo = PeiShiTaGameModel.instance:getGameMo()

	if not gameMo then
		return
	end

	self:_refreshCells()
	PeiShiTaUnitCreateHelper.createUnits(self, self._unitGoRegistry, gameMo)
end

function PeiShiTaGameView:_refreshCells()
	gohelper.CreateObjList(self, self._onCellCreated, self._cellCoords, self._goCellRoot, self._goCellTemplate, PeiShiTaCellComp)
	self:_refreshCellColors()
end

function PeiShiTaGameView:_onCellCreated(comp, coord)
	comp:setUnitData(coord.x, coord.y)

	self._cellList[PeiShiTaCellHelper.cellKey(coord.x, coord.y)] = comp
end

function PeiShiTaGameView:_refreshCellColors()
	local gameMo = PeiShiTaGameModel.instance:getGameMo()

	if not gameMo then
		return
	end

	local cellTypeMap = PeiShiTaGameHelper.buildCellTypeMap(gameMo)

	for _, cellComp in pairs(self._cellList) do
		cellComp:refreshColor(cellTypeMap)
	end
end

function PeiShiTaGameView:_refreshToolPanel()
	local unitList = {}
	local markUnitIdMap = {}
	local gameCo = PeiShiTaGameModel.instance:getGameConfig()
	local mapId = gameCo and gameCo.mapId
	local mapData = PeiShiTaGameConfig.instance:getMapData(mapId)
	local srcList = mapData and mapData.unitList or {}

	for _, unit in ipairs(srcList) do
		local type = unit.config.type
		local unitId = unit.config.id

		if not markUnitIdMap[unitId] and type == PeiShiTaEnum.UnitType.Drop then
			table.insert(unitList, unit)

			markUnitIdMap[unitId] = true
		end
	end

	table.sort(unitList, self._toolListSortFunc)
	gohelper.CreateObjList(self, self._refreshToolItem, unitList, nil, self._goToolItem, PeiShiTaGameToolCell)
end

function PeiShiTaGameView._toolListSortFunc(a, b)
	local aType = a.config.type
	local aUnitId = a.config.id
	local bType = b.config.type
	local bUnitId = b.config.id

	if aType ~= bType then
		return aType < bType
	end

	return aUnitId < bUnitId
end

function PeiShiTaGameView:_refreshToolItem(comp, unit)
	comp:onUpdateMO(unit.config)
end

function PeiShiTaGameView:_onBoardChanged()
	self:_refreshCellColors()
end

function PeiShiTaGameView:_onToolChanged(toolId)
	self:_refreshCellColors()
end

function PeiShiTaGameView:_onLevelReset()
	self:refreshUI()
end

function PeiShiTaGameView:_onOpenViewFinish(viewName)
	if viewName == ViewName.StoryView then
		self:closeThis()
	end
end

function PeiShiTaGameView:_btnResetOnClick()
	if PeiShiTaGameController.instance:isMoveLocked() then
		return
	end

	PeiShiTaGameController.instance:lockMoveInput(true)
	GameFacade.showMessageBox(MessageBoxIdDefine.DungeonPuzzleResetGame, MsgBoxEnum.BoxType.Yes_No, self._restartGame, self._cancelRestartGame, nil, self, self)
end

function PeiShiTaGameView:_restartGame()
	self._viewAnimator.enabled = true

	self._viewAnimator:Play("reset", 0, 0)
	TaskDispatcher.runDelay(self._reallyRestartGame, self, 0.33)
	UIBlockHelper.instance:startBlock(self.viewName, 0.6, self.viewName)
end

function PeiShiTaGameView:_reallyRestartGame()
	PeiShiTaController.instance:reportGameEnd(StatEnum.Result.Reset)
	PeiShiTaGameModel.instance:restartGame()
	PeiShiTaGameController.instance:lockMoveInput(false)
end

function PeiShiTaGameView:_cancelRestartGame()
	PeiShiTaGameController.instance:lockMoveInput(false)
end

function PeiShiTaGameView:onClose()
	PeiShiTaGameController.instance:stopFlow()
	TaskDispatcher.cancelTask(self._reallyRestartGame, self)
	GameGCMgr.instance:dispatchEvent(GameGCEvent.SetBanGc, self.viewName, false)
end

function PeiShiTaGameView:onDestroyView()
	self._cellCoords = nil
end

return PeiShiTaGameView
