-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/view/hall/ArcadeSurvivorHallEntityMgr.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.view.hall.ArcadeSurvivorHallEntityMgr", package.seeall)

local ArcadeSurvivorHallEntityMgr = class("ArcadeSurvivorHallEntityMgr", LuaCompBase)

function ArcadeSurvivorHallEntityMgr:ctor(param)
	self._scene = param.scene
	self._compName = param.compName
end

function ArcadeSurvivorHallEntityMgr:init(go)
	self.go = go
	self.trans = go.transform

	transformhelper.setLocalPos(self.trans, 0, 0, -0.1)

	self._characterEntityDict = {}

	self:createCharacterEntity()
	self:createInteractiveEntity()
	self:_onInitEntity()
end

function ArcadeSurvivorHallEntityMgr:createCharacterEntity()
	self._characterMO = ArcadeSurvivorHallModel.instance:getEquipCharacterMO()

	local resPath = self._characterMO:getResPath()

	if string.nilorempty(resPath) then
		return
	end

	self._scene.loader:loadRes(resPath, self._onLoadCharacterEntity, self)
end

function ArcadeSurvivorHallEntityMgr:_onLoadCharacterEntity()
	local id = ArcadeSurvivorHeroModel.instance:getEquipHeroId()

	if not self._characterMO then
		return
	end

	local resPath = self._characterMO:getResPath()
	local characterAssetRes = self._scene.loader:getResource(resPath)

	if characterAssetRes then
		local goCharacter = gohelper.clone(characterAssetRes, self.go, string.format("character-%s", self._characterMO:getId()))

		self._characterEntityDict[id] = MonoHelper.addNoUpdateLuaComOnceToGo(goCharacter, ArcadeSurvivorHallEntity)

		self._characterEntityDict[id]:initEntity(goCharacter, self._characterMO, self._scene.loader)
		self:_delayBornCharacter()
	end
end

function ArcadeSurvivorHallEntityMgr:createInteractiveEntity()
	self._pathList = {}
	self._interactiveEntity = {}
	self._interactiveMODict = ArcadeSurvivorHallModel.instance:getInteractiveMODict()

	for i, mo in pairs(self._interactiveMODict) do
		local resPath = mo:getResPath()

		if not string.nilorempty(resPath) then
			table.insert(self._pathList, resPath)
		end
	end

	self._scene.loader:loadResList(self._pathList, self._onLoadInteractiveEntity, self)
end

function ArcadeSurvivorHallEntityMgr:_onLoadInteractiveEntity()
	for i, mo in pairs(self._interactiveMODict) do
		local resPath = mo:getResPath()

		if not string.nilorempty(resPath) then
			local res = self._scene.loader:getResource(resPath)

			if res then
				local go = gohelper.clone(res, self.go, "building_" .. i)

				self._interactiveEntity[i] = MonoHelper.addNoUpdateLuaComOnceToGo(go, ArcadeSurvivorHallEntity)

				self._interactiveEntity[i]:initEntity(go, mo)

				if i == ArcadeSurvivorHallEnum.HallInteractiveUnitId.NPC then
					self._interactiveEntity[i]:playIdleAnim()
				end
			end
		end
	end
end

function ArcadeSurvivorHallEntityMgr:addEventListeners()
	self:addEventCb(ArcadeSurvivorController.instance, ArcadeSurvivorEvent.OnMoveToInteractive, self._onMoveToInteractive, self)
	self:addEventCb(ArcadeSurvivorController.instance, ArcadeSurvivorEvent.OnEquipHero, self._onEquipHero, self)
	self:addEventCb(ArcadeSurvivorController.instance, ArcadeSurvivorEvent.NPCTalkBlock, self._setNPCBlock, self)
end

function ArcadeSurvivorHallEntityMgr:removeEventListeners()
	self:removeEventCb(ArcadeSurvivorController.instance, ArcadeSurvivorEvent.OnMoveToInteractive, self._onMoveToInteractive, self)
	self:removeEventCb(ArcadeSurvivorController.instance, ArcadeSurvivorEvent.OnEquipHero, self._onEquipHero, self)
	self:removeEventCb(ArcadeSurvivorController.instance, ArcadeSurvivorEvent.NPCTalkBlock, self._setNPCBlock, self)
end

function ArcadeSurvivorHallEntityMgr:_onMoveToInteractive(interactiveId)
	TaskDispatcher.cancelTask(self._onAutoMove, self)

	if not self:isCanMove() then
		return
	end

	self:_setAutoMoveToInteractiveId(interactiveId)

	if not self._linkMO then
		self._linkMO = ArcadeSurvivorHallQuickLinkMO.New()

		self._linkMO:initMo()
	end

	local curGridX, curGridY = self._characterMO:getGridPos()

	self._autoGridList = self._linkMO:findPath(interactiveId, curGridX, curGridY)

	if self._autoGridList and #self._autoGridList > 0 then
		local targetGridX, targetGridY = self._autoGridList[1].x, self._autoGridList[1].y

		ArcadeSurvivorRpc.instance:sendArcadeSurvivorRoleMoveRequest(targetGridX, targetGridY)
		self:_onAutoMove()
	else
		self:_onFinishAutoMove()
	end
end

function ArcadeSurvivorHallEntityMgr:_setAutoMoveToInteractiveId(interactiveId)
	self._isAutoMoveToInteractiveId = interactiveId
end

function ArcadeSurvivorHallEntityMgr:_onEquipHero(characterId)
	for id, entity in pairs(self._characterEntityDict) do
		entity:showEntity(id == characterId)
	end

	self._characterMO = ArcadeSurvivorHallModel.instance:getEquipCharacterMO()

	local entity = self._characterEntityDict[characterId]

	if entity then
		local curGridX, curGridY = ArcadeSurvivorHallModel.instance:getHeroGrid()

		self._characterMO:setGridPos(curGridX, curGridY)
		entity:refreshEntity(self._characterMO)
		self:_refreshHeroEntity(characterId)
	else
		self:createCharacterEntity()
	end
end

function ArcadeSurvivorHallEntityMgr:_refreshHeroEntity(id)
	for tId, entity in pairs(self._characterEntityDict) do
		gohelper.setActive(entity.go, tId == id)
	end
end

function ArcadeSurvivorHallEntityMgr:_setNPCBlock(isBlock)
	self._isNpcTalkBlock = isBlock
end

function ArcadeSurvivorHallEntityMgr:onOpen()
	self:_onInitEntity()

	self._nearInteractiveId = nil
end

function ArcadeSurvivorHallEntityMgr:_onInitEntity()
	self:_refreshEntitySibling()
	self:_delayBornCharacter()
	self:_setAutoMoveToInteractiveId()
	self:_setNPCBlock()
end

function ArcadeSurvivorHallEntityMgr:_refreshEntitySibling()
	local _, gridY = self._characterMO:getGridPos()
	local npcMO = self._interactiveMODict[ArcadeSurvivorHallEnum.HallInteractiveUnitId.NPC]
	local _, npcGridY = npcMO:getGridPos()

	if npcGridY < gridY then
		self._characterMO:setPosZ(0.01)
	else
		self._characterMO:setPosZ(-0.1)
	end
end

function ArcadeSurvivorHallEntityMgr:_delayBornCharacter()
	TaskDispatcher.cancelTask(self._bornCharacter, self)

	local characterEntity = self:getCharacterEntity()

	if not characterEntity then
		return
	end

	characterEntity:showEntity(false)
	characterEntity:refreshPosition()
	TaskDispatcher.runDelay(self._bornCharacter, self, ArcadeSurvivorHallEnum.Const.DelayShowCharacterTime)
end

function ArcadeSurvivorHallEntityMgr:_bornCharacter()
	local characterEntity = self:getCharacterEntity()

	if not characterEntity then
		return
	end

	characterEntity:showEntity(true)
	characterEntity:playBornAni()
end

function ArcadeSurvivorHallEntityMgr:getCharacterEntity()
	local id = ArcadeSurvivorHeroModel.instance:getEquipHeroId()

	return self._characterEntityDict[id]
end

function ArcadeSurvivorHallEntityMgr:playerActOnDirection(direction)
	if not self:isCanMove() then
		return
	end

	local curGridX, curGridY = self._characterMO:getGridPos()
	local targetGridX = curGridX + (ArcadeSurvivorEnum.DirChangeGridX[direction] or 0)
	local targetGridY = curGridY + (ArcadeSurvivorEnum.DirChangeGridY[direction] or 0)

	self:_onHeroMove(targetGridX, targetGridY)
end

function ArcadeSurvivorHallEntityMgr:isCanMove()
	if not self._characterMO or self._isAutoMoveToInteractiveId or self._isNpcTalkBlock then
		return
	end

	local characterEntity = self:getCharacterEntity()
	local isShow = characterEntity and characterEntity:isShowEntity()

	if not isShow then
		return
	end

	local isOpenInteractiveView = ArcadeSurvivorController.instance:getIsOpenInteractiveView()

	if isOpenInteractiveView then
		return
	end

	return true
end

function ArcadeSurvivorHallEntityMgr:_onHeroMove(targetGridX, targetGridY)
	if self:_overRange(targetGridX, targetGridY) then
		return
	end

	local entity = self:getCharacterEntity()
	local interactiveId = self:isInteractiveRange(targetGridX, targetGridY)
	local nearInteractiveId = self:isNearInteractive(targetGridX, targetGridY)

	local function callback()
		entity:refreshPosition()
		self:_checkInteractiveEvent(interactiveId, nearInteractiveId)
	end

	if not interactiveId then
		self._characterMO:setGridPos(targetGridX, targetGridY)
		ArcadeSurvivorHeroModel.instance:setCharacterPos(targetGridX, targetGridY)
	end

	self:_refreshEntitySibling()
	entity:doMove(callback, self)
	self:_setAutoMoveToInteractiveId()
end

function ArcadeSurvivorHallEntityMgr:_overRange(targetGridX, targetGridY)
	local maxGrid = ArcadeSurvivorHallModel.instance:getHallGridSize()

	return targetGridX < 1 or targetGridX > maxGrid[1] or targetGridY < 1 or targetGridY > maxGrid[2]
end

function ArcadeSurvivorHallEntityMgr:isInteractiveRange(curGridX, curGridY)
	for i, mo in pairs(self._interactiveMODict) do
		if mo:isEnterRange(curGridX, curGridY) then
			return i
		end
	end
end

function ArcadeSurvivorHallEntityMgr:isNearInteractive(curGridX, curGridY)
	local interactiveId

	for i, mo in pairs(self._interactiveMODict) do
		for _, direction in ipairs(ArcadeSurvivorEnum.AxisDirection) do
			local dirHexPoint = ArcadeSurvivorEnum.DirectionHexPointDict[direction]

			if mo:isEnterRange(curGridX + dirHexPoint.x, curGridY + dirHexPoint.y) then
				if interactiveId then
					interactiveId = math.max(interactiveId, i)
				else
					interactiveId = i
				end
			end
		end
	end

	return interactiveId
end

function ArcadeSurvivorHallEntityMgr:_checkInteractiveEvent(interactiveId, nearInteractiveId)
	local enterInteractiveId = interactiveId or nearInteractiveId

	if enterInteractiveId then
		self:_enterInteractive(enterInteractiveId)
	else
		if self._nearInteractiveId then
			ArcadeSurvivorController.instance:closeTipView()
		end

		ArcadeSurvivorController.instance:exitInteractive()
	end

	self._nearInteractiveId = nearInteractiveId
end

function ArcadeSurvivorHallEntityMgr:_enterInteractive(interactiveId)
	local cfg = ArcadeSurvivorConfig.instance:getHallUnitCfg(interactiveId, true)

	if not cfg then
		return
	end

	local isOpenTip = ArcadeSurvivorConfig.instance:getHallUnitIsOpenTip(interactiveId)

	if isOpenTip then
		self._scene:openBuildingTipView(interactiveId)
	else
		ArcadeSurvivorController.instance:enterInteractive(interactiveId)
	end
end

function ArcadeSurvivorHallEntityMgr:_onAutoMove()
	if LuaUtil.tableNotEmpty(self._autoGridList) then
		local grid = self._autoGridList[#self._autoGridList]

		if not grid then
			self:_onFinishAutoMove()

			return
		end

		self:_refreshEntitySibling()
		self._characterMO:setGridPos(grid.x, grid.y)
		ArcadeSurvivorHeroModel.instance:setCharacterPos(grid.x, grid.y)
		table.remove(self._autoGridList, #self._autoGridList)

		local characterEntity = self:getCharacterEntity()

		characterEntity:doMove(self._onAutoMove, self)

		return
	end

	self:_onFinishAutoMove()
end

function ArcadeSurvivorHallEntityMgr:_onFinishAutoMove()
	ArcadeSurvivorController.instance:enterInteractive(self._isAutoMoveToInteractiveId)
	self:_setAutoMoveToInteractiveId()
end

function ArcadeSurvivorHallEntityMgr:onClose()
	self:_setAutoMoveToInteractiveId()
	self:_setNPCBlock()
end

function ArcadeSurvivorHallEntityMgr:clear()
	self._scene = nil

	TaskDispatcher.cancelTask(self._onAutoMove, self)
	TaskDispatcher.cancelTask(self._bornCharacter, self)

	if self._characterEntityDict then
		for _, entity in pairs(self._characterEntityDict) do
			entity:clear()
		end
	end

	self:_setAutoMoveToInteractiveId()
	self:_setNPCBlock()

	self._nearInteractiveId = nil
end

return ArcadeSurvivorHallEntityMgr
