-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/view/game/ArcadeSurvivorGameEntityIcon.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.view.game.ArcadeSurvivorGameEntityIcon", package.seeall)

local ArcadeSurvivorGameEntityIcon = class("ArcadeSurvivorGameEntityIcon", LuaCompBase)

function ArcadeSurvivorGameEntityIcon:init(go)
	self.go = go
	self.trans = go.transform
	self.viewTrans = self.trans.parent
	self._goFrames = gohelper.findChild(self.go, "#go_frame")

	local goFrame1 = gohelper.findChild(self.go, "#go_frame/frame1")
	local goLeftUp1 = gohelper.findChild(goFrame1, "leftup")
	local goRightDown1 = gohelper.findChild(goFrame1, "rightdown")

	self._goFrame1 = goFrame1
	self._translu1 = goLeftUp1.transform
	self._transrd1 = goRightDown1.transform

	local goFrame2 = gohelper.findChild(self.go, "#go_frame/frame2")
	local goLeftUp2 = gohelper.findChild(goFrame2, "leftup")
	local goRightDown2 = gohelper.findChild(goFrame2, "rightdown")

	self._goFrame2 = goFrame2
	self._translu2 = goLeftUp2.transform
	self._transrd2 = goRightDown2.transform

	gohelper.setActive(self._goFrames, false)
end

function ArcadeSurvivorGameEntityIcon:addEventListeners()
	self:addEventCb(ArcadeSurvivorGameController.instance, ArcadeSurvivorEvent.OnEntityTweenMove, self._onEntityTweenMove, self)
	self:addEventCb(ArcadeSurvivorGameController.instance, ArcadeSurvivorEvent.OnEntityBoardStateChange, self._onBoardStateChange, self)
end

function ArcadeSurvivorGameEntityIcon:removeEventListeners()
	self:removeEventCb(ArcadeSurvivorGameController.instance, ArcadeSurvivorEvent.OnEntityTweenMove, self._onEntityTweenMove, self)
	self:removeEventCb(ArcadeSurvivorGameController.instance, ArcadeSurvivorEvent.OnEntityBoardStateChange, self._onBoardStateChange, self)
end

function ArcadeSurvivorGameEntityIcon:_onBoardStateChange(entityType, uid)
	if entityType ~= self._entityType or uid ~= self._uid then
		return
	end

	self._tweenMoving = false

	self:refreshPos()
end

function ArcadeSurvivorGameEntityIcon:_onEntityTweenMove(entityType, uid, isTween)
	local isSameEntity = self._entityType and self._uid and entityType == self._entityType and uid == self._uid

	if not isSameEntity then
		return
	end

	self._tweenMoving = isTween

	self:refreshPos()
end

function ArcadeSurvivorGameEntityIcon:onUpdate()
	local isCanUpdate = not self._isDisposed and self._entityType and self._uid

	if not isCanUpdate or not self._tweenMoving then
		return
	end

	self:refreshPos()
end

function ArcadeSurvivorGameEntityIcon:setEntity(entityType, uid, id)
	self._entityType = entityType
	self._uid = uid
	self._id = id
	self.go.name = string.format("icon-%s-%s", self._entityType, self._uid)

	self:refresh()
end

function ArcadeSurvivorGameEntityIcon:refresh()
	self:refreshPos()
	self:refreshFrame()
end

function ArcadeSurvivorGameEntityIcon:refreshPos()
	self:checkShow()

	if not self._isShow then
		return
	end

	local scene = ArcadeSurvivorGameController.instance:getGameScene()
	local isCanRefresh = self._entityType and self._uid and scene

	if not isCanRefresh then
		return
	end

	local entity = scene.entityMgr:getEntity(self._entityType, self._uid)

	if not entity then
		return
	end

	local x, y, z = entity:getPosition()
	local rectPosX, rectPosY = recthelper.worldPosToAnchorPosXYZ(x, y, z, self.viewTrans)

	recthelper.setAnchor(self.trans, rectPosX, rectPosY)
end

function ArcadeSurvivorGameEntityIcon:checkShow()
	local isShow = false
	local mo = ArcadeSurvivorGameModel.instance:getEntityMO(self._entityType, self._uid)

	if mo and not mo:getIsOffBoard() then
		local gridX, gridY = mo:getGridPos()
		local curLevelId = ArcadeSurvivorGameModel.instance:getCurLevelId()

		if curLevelId then
			local isOutside = ArcadeSurvivorGameHelper.isOutsideMap(gridX, gridY)

			isShow = not isOutside
		end
	end

	if self._isShow == isShow then
		return
	end

	gohelper.setActive(self.go, isShow)

	self._isShow = isShow
end

function ArcadeSurvivorGameEntityIcon:refreshFrame()
	local scene = ArcadeSurvivorGameController.instance:getGameScene()
	local isCanRefresh = self._entityType and self._uid and scene

	if not isCanRefresh then
		gohelper.setActive(self._goFrames, false)

		return
	end

	local mo = ArcadeSurvivorGameModel.instance:getEntityMO(self._entityType, self._uid)

	if not mo then
		gohelper.setActive(self._goFrames, false)

		return
	end

	local viewScale = scene:getViewScale()
	local baseUIGridSize = ArcadeSurvivorConfig.instance:getGameBaseUIGridSize()
	local uiGridSize = baseUIGridSize * viewScale
	local halfUIGridSize = uiGridSize / 2
	local sizeX, sizeY = mo:getSize()
	local showFrame = false

	if self._entityType == ArcadeSurvivorEnum.EntityType.Character then
		showFrame = true

		transformhelper.setLocalPosXY(self._translu1, -halfUIGridSize, (sizeY - 0.5) * uiGridSize)
		transformhelper.setLocalPosXY(self._transrd1, (sizeX - 0.5) * uiGridSize, -halfUIGridSize)
		gohelper.setActive(self._goFrame1, true)
		gohelper.setActive(self._goFrame2, false)
	elseif self._entityType == ArcadeSurvivorEnum.EntityType.Monster then
		local monsterType = mo:getMonsterType()

		showFrame = monsterType == ArcadeSurvivorEnum.MonsterType.Boss

		if showFrame then
			transformhelper.setLocalPosXY(self._translu2, -halfUIGridSize, (sizeY - 0.5) * uiGridSize)
			transformhelper.setLocalPosXY(self._transrd2, (sizeX - 0.5) * uiGridSize, -halfUIGridSize)
			gohelper.setActive(self._goFrame1, false)
			gohelper.setActive(self._goFrame2, true)
		end
	end

	gohelper.setActive(self._goFrames, showFrame)
end

function ArcadeSurvivorGameEntityIcon:setFrameShow(isShow)
	gohelper.setActive(self._goFrames, isShow)
end

function ArcadeSurvivorGameEntityIcon:reset()
	self._entityType = nil
	self._uid = nil
	self._id = nil
	self.go.name = "icon"
	self._tweenMoving = nil
	self._isShow = false

	gohelper.setActive(self._goFrames, false)
	gohelper.setActive(self.go, false)
end

function ArcadeSurvivorGameEntityIcon:onDestroy()
	self:reset()
end

return ArcadeSurvivorGameEntityIcon
