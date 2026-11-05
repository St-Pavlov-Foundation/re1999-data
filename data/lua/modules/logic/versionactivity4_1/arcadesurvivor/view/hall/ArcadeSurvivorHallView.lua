-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/view/hall/ArcadeSurvivorHallView.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.view.hall.ArcadeSurvivorHallView", package.seeall)

local ArcadeSurvivorHallView = class("ArcadeSurvivorHallView", BaseView)
local UnityEngineInput = UnityEngine.Input
local UnityEngineKeyCode = UnityEngine.KeyCode
local ArcadeSurvivorDirection = ArcadeSurvivorEnum.Direction

function ArcadeSurvivorHallView:onInitView()
	self._godrag = gohelper.findChild(self.viewGO, "#go_drag")
	self._btnweapon = ArcadeSurvivorGameHelper.getArcadeSurvivorButton(self.viewGO, "Right/#btn_weapon")
	self._simageweaponicon = gohelper.findChildSingleImage(self.viewGO, "Right/#btn_weapon/has/#image_icon")
	self._goweapon = gohelper.findChild(self.viewGO, "Right/#btn_weapon/has")
	self._goweaponempty = gohelper.findChild(self.viewGO, "Right/#btn_weapon/empty")
	self._gocollection = gohelper.findChild(self.viewGO, "Right/#go_collection")
	self._simagecollectionicon = gohelper.findChildSingleImage(self.viewGO, "Right/#go_collection/#go_collectionitem/#image_icon")
	self._imagecollectionbg = gohelper.findChildImage(self.viewGO, "Right/#go_collection/#go_collectionitem/bg")
	self._txtcollectionnum = gohelper.findChildText(self.viewGO, "Right/#go_collection/#go_collectionitem/#txt_num")
	self._btncollection = ArcadeSurvivorGameHelper.getArcadeSurvivorButton(self.viewGO, "Right/#go_collection/#go_collectionitem/btn_click")
	self._gotipview = gohelper.findChild(self.viewGO, "#go_tipview")
	self._btnback = ArcadeSurvivorGameHelper.getArcadeSurvivorButton(self.viewGO, "#go_topleft/#btn_back")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ArcadeSurvivorHallView:addEvents()
	self._btnweapon:AddClickListener(self._btnweaponOnClick, self)
	self._btncollection:AddClickListener(self._btncollectionOnClick, self)
	self._btnback:AddClickListener(self._btnbackOnClick, self)
	self:_initHandleComp()
	self:addEventCb(ArcadeSurvivorController.instance, ArcadeSurvivorEvent.OnEquipHero, self._refreshHero, self)
	self:addEventCb(ArcadeSurvivorController.instance, ArcadeSurvivorEvent.UpLevelTalent, self._refreshDevelopReddot, self)
	self:addEventCb(ArcadeSurvivorController.instance, ArcadeSurvivorEvent.OnClickHeroItem, self._refreshDevelopReddot, self)
	self:addEventCb(ArcadeSurvivorController.instance, ArcadeSurvivorEvent.OnClickHandBookItem, self._refreshHandBookReddot, self)
	self:addEventCb(RedDotController.instance, RedDotEvent.UpdateRelateDotInfo, self._refreshTaskReddot, self)
	self:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self:addEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self.initCamera, self)
	self:addEventCb(ArcadeSurvivorController.instance, ArcadeSurvivorEvent.OnLoadFinishHallScene, self._onLoadFinishHallScene, self)
	self:addEventCb(ArcadeSurvivorController.instance, ArcadeSurvivorEvent.OnExitHallView, self._onExitHallView, self, LuaEventSystem.Low)
	self:addEventCb(ArcadeSurvivorController.instance, ArcadeSurvivorEvent.OnBeginTransitionGame, self._onBeginTransitionGame, self)
	self:addEventCb(ArcadeSurvivorController.instance, ArcadeSurvivorEvent.NPCTalkBlock, self._setNPCBlock, self)
end

function ArcadeSurvivorHallView:_initHandleComp()
	self._btnLeft = ArcadeSurvivorGameHelper.getArcadeSurvivorButton(self.viewGO, "Left/#go_joyPoint/#go_joystick/#go_background/btn_left")
	self._btnRight = ArcadeSurvivorGameHelper.getArcadeSurvivorButton(self.viewGO, "Left/#go_joyPoint/#go_joystick/#go_background/btn_right")
	self._btnUp = ArcadeSurvivorGameHelper.getArcadeSurvivorButton(self.viewGO, "Left/#go_joyPoint/#go_joystick/#go_background/btn_up")
	self._btnDown = ArcadeSurvivorGameHelper.getArcadeSurvivorButton(self.viewGO, "Left/#go_joyPoint/#go_joystick/#go_background/btn_down")

	local longPressArr = ArcadeSurvivorHallEnum.Const.LongPressArr

	self._btnLeftLongPress = SLFramework.UGUI.UILongPressListener.Get(self._btnLeft.gameObject)

	self._btnLeftLongPress:SetLongPressTime(longPressArr)
	self._btnLeftLongPress:AddLongPressListener(self._playerActOnDirection, self, ArcadeSurvivorEnum.Direction.Left)

	self._btnRightLongPress = SLFramework.UGUI.UILongPressListener.Get(self._btnRight.gameObject)

	self._btnRightLongPress:SetLongPressTime(longPressArr)
	self._btnRightLongPress:AddLongPressListener(self._playerActOnDirection, self, ArcadeSurvivorEnum.Direction.Right)

	self._btnUpLongPress = SLFramework.UGUI.UILongPressListener.Get(self._btnUp.gameObject)

	self._btnUpLongPress:SetLongPressTime(longPressArr)
	self._btnUpLongPress:AddLongPressListener(self._playerActOnDirection, self, ArcadeSurvivorEnum.Direction.Up)

	self._btnDownLongPress = SLFramework.UGUI.UILongPressListener.Get(self._btnDown.gameObject)

	self._btnDownLongPress:SetLongPressTime(longPressArr)
	self._btnDownLongPress:AddLongPressListener(self._playerActOnDirection, self, ArcadeSurvivorEnum.Direction.Down)
	self._btnLeft:AddClickListener(self._playerActOnDirection, self, ArcadeSurvivorEnum.Direction.Left)
	self._btnRight:AddClickListener(self._playerActOnDirection, self, ArcadeSurvivorEnum.Direction.Right)
	self._btnUp:AddClickListener(self._playerActOnDirection, self, ArcadeSurvivorEnum.Direction.Up)
	self._btnDown:AddClickListener(self._playerActOnDirection, self, ArcadeSurvivorEnum.Direction.Down)

	self._dragHandle = SLFramework.UGUI.UIDragListener.Get(self._godrag)

	self._dragHandle:AddDragBeginListener(self._onDragBegin, self)
	self._dragHandle:AddDragListener(self._onDrag, self)
	self._dragHandle:AddDragEndListener(self._onDragEnd, self)

	self._btndrag = ArcadeSurvivorGameHelper.getArcadeSurvivorButton(self.viewGO, "#go_drag")

	self._btndrag:AddClickListener(self._btnClickOnClick, self)
end

function ArcadeSurvivorHallView:removeEvents()
	self._btnweapon:RemoveClickListener()
	self._btncollection:RemoveClickListener()
	self._btnback:RemoveClickListener()
	self:_removeHandleComp()
	self:removeEventCb(ArcadeSurvivorController.instance, ArcadeSurvivorEvent.OnEquipHero, self._refreshHero, self)
	self:removeEventCb(ArcadeSurvivorController.instance, ArcadeSurvivorEvent.UpLevelTalent, self._refreshDevelopReddot, self)
	self:removeEventCb(ArcadeSurvivorController.instance, ArcadeSurvivorEvent.OnClickHeroItem, self._refreshDevelopReddot, self)
	self:removeEventCb(ArcadeSurvivorController.instance, ArcadeSurvivorEvent.OnClickHandBookItem, self._refreshHandBookReddot, self)
	self:removeEventCb(RedDotController.instance, RedDotEvent.UpdateRelateDotInfo, self._refreshTaskReddot, self)
	self:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self:removeEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self.initCamera, self)
	self:removeEventCb(ArcadeSurvivorController.instance, ArcadeSurvivorEvent.OnLoadFinishHallScene, self._onLoadFinishHallScene, self)
	self:removeEventCb(ArcadeSurvivorController.instance, ArcadeSurvivorEvent.OnExitHallView, self._onExitHallView, self)
	self:removeEventCb(ArcadeSurvivorController.instance, ArcadeSurvivorEvent.OnBeginTransitionGame, self._onBeginTransitionGame, self)
	self:removeEventCb(ArcadeSurvivorController.instance, ArcadeSurvivorEvent.NPCTalkBlock, self._setNPCBlock, self)
end

function ArcadeSurvivorHallView:_removeHandleComp()
	self._btnLeftLongPress:RemoveLongPressListener()
	self._btnRightLongPress:RemoveLongPressListener()
	self._btnUpLongPress:RemoveLongPressListener()
	self._btnDownLongPress:RemoveLongPressListener()
	self._btnLeft:RemoveClickListener()
	self._btnRight:RemoveClickListener()
	self._btnUp:RemoveClickListener()
	self._btnDown:RemoveClickListener()
	self._dragHandle:RemoveDragBeginListener()
	self._dragHandle:RemoveDragEndListener()
	self._dragHandle:RemoveDragListener()
	self._btndrag:RemoveClickListener()
end

function ArcadeSurvivorHallView:_btnbackOnClick()
	if self._isNpcTalkBlock then
		return
	end

	ArcadeSurvivorController.instance:onExitHall()
end

function ArcadeSurvivorHallView:_btncollectionOnClick()
	if not self._collectionMO then
		return
	end

	local anchor = {
		x = 340,
		y = -651
	}
	local param = {
		collectionMO = self._collectionMO,
		root = self._gotipview,
		anchorPos = anchor,
		originalViewName = self.viewName
	}

	ArcadeSurvivorController.instance:openTipView(ArcadeSurvivorEnum.TipType.Collection, param)
end

function ArcadeSurvivorHallView:_btnweaponOnClick()
	if not self._weaponMO then
		return
	end

	local anchor = {
		x = 371,
		y = -155
	}
	local param = {
		weaponMO = self._weaponMO,
		characterId = self._heroMO:getId(),
		root = self._gotipview,
		anchorPos = anchor,
		originalViewName = self.viewName
	}

	ArcadeSurvivorController.instance:openTipView(ArcadeSurvivorEnum.TipType.Weapon, param)
end

function ArcadeSurvivorHallView:_btnClickOnClick()
	local canMove = self.viewContainer:isCanMove()

	if self._enterDifficulty or not canMove or not self._sceneView then
		return
	end

	local mainCamera = CameraMgr.instance:getMainCamera()
	local worldPos = recthelper.screenPosToWorldPos(GamepadController.instance:getMousePosition(), mainCamera, self._sceneView:getSceneGO().transform.position)
	local localPos = self._sceneView:onInverseTransformPoint(worldPos)
	local gridX = math.ceil((localPos.x - ArcadeSurvivorHallEnum.Const.StartX) / ArcadeSurvivorHallEnum.Const.GridSize + 0.75)
	local gridY = math.ceil((localPos.y - ArcadeSurvivorHallEnum.Const.StartY) / ArcadeSurvivorHallEnum.Const.GridSize + 0.75)
	local interactiveId = self._sceneView.entityMgr:isInteractiveRange(gridX, gridY)

	if interactiveId then
		local isOpenTip = ArcadeSurvivorConfig.instance:getHallUnitIsOpenTip(interactiveId)

		if isOpenTip then
			self._sceneView:openBuildingTipView(interactiveId)
		else
			ArcadeSurvivorController.instance:dispatchEvent(ArcadeSurvivorEvent.OnMoveToInteractive, interactiveId)
		end
	else
		local characterMO = ArcadeSurvivorHallModel.instance:getEquipCharacterMO()

		if characterMO:isEnterRange(gridX, gridY) then
			local anchor = {
				x = 736,
				y = 117
			}
			local param = {
				heroMO = characterMO:getHeroMO(),
				root = self._gotipview,
				anchorPos = anchor,
				originalViewName = self.viewName
			}

			ArcadeSurvivorController.instance:openTipView(ArcadeSurvivorEnum.TipType.Hero, param)
		end
	end
end

function ArcadeSurvivorHallView:_onDragBegin(param, pointerEventData)
	if self._enterDifficulty then
		return
	end

	self._dragTime = 0
	self._preDirection = nil
	self._prePosition = pointerEventData.position
	self._startPosition = pointerEventData.position
	self._isMove = false
end

local DRAG_OFFSET = 10

function ArcadeSurvivorHallView:_onDrag(param, pointerEventData)
	if self._enterDifficulty or not self._prePosition or not self._preDirection then
		return
	end

	if not self.viewContainer:isCanMove() then
		self._dragTime = 0
		self._preDirection = nil
		self._prePosition = nil

		return
	end

	local direction
	local x = pointerEventData.position.x - self._prePosition.x
	local y = pointerEventData.position.y - self._prePosition.y
	local absX = math.abs(x)
	local absY = math.abs(y)

	if absY < absX then
		if x < -DRAG_OFFSET then
			if self._preDirection ~= ArcadeSurvivorEnum.Direction.Left then
				self._dragTime = 0
			end

			direction = ArcadeSurvivorEnum.Direction.Left
		end

		if x > DRAG_OFFSET then
			if self._preDirection ~= ArcadeSurvivorEnum.Direction.Right then
				self._dragTime = 0
			end

			direction = ArcadeSurvivorEnum.Direction.Right
		end
	elseif absX < absY then
		if y < -DRAG_OFFSET then
			if self._preDirection ~= ArcadeSurvivorEnum.Direction.Down then
				self._dragTime = 0
			end

			direction = ArcadeSurvivorEnum.Direction.Down
		end

		if y > DRAG_OFFSET then
			if self._preDirection ~= ArcadeSurvivorEnum.Direction.Up then
				self._dragTime = 0
			end

			direction = ArcadeSurvivorEnum.Direction.Up
		end
	end

	self._dragTime = self._dragTime + Time.deltaTime
	self._preDirection = direction
	self._prePosition = pointerEventData.position

	if self._dragTime > ArcadeSurvivorHallEnum.Const.LongPressArr[2] then
		self._dragTime = 0

		self:_playerActOnDirection(direction)

		self._isMove = true
	end
end

function ArcadeSurvivorHallView:_onDragEnd(param, pointerEventData)
	if self._enterDifficulty then
		return
	end

	if not self._isMove and self._dragTime > 0.1 then
		local direction
		local x = pointerEventData.position.x - self._startPosition.x
		local y = pointerEventData.position.y - self._startPosition.y
		local absX = math.abs(x)
		local absY = math.abs(y)

		if absY < absX then
			if x < -DRAG_OFFSET then
				direction = ArcadeSurvivorEnum.Direction.Left
			end

			if x > DRAG_OFFSET then
				direction = ArcadeSurvivorEnum.Direction.Right
			end
		else
			if y < -DRAG_OFFSET then
				direction = ArcadeSurvivorEnum.Direction.Down
			end

			if y > DRAG_OFFSET then
				direction = ArcadeSurvivorEnum.Direction.Up
			end
		end

		self:_playerActOnDirection(direction)
	end

	self._dragTime = 0
	self._preDirection = nil
	self._prePosition = nil
	self._startPosition = nil
	self._isMove = false
end

function ArcadeSurvivorHallView:_refreshDevelopReddot()
	ArcadeSurvivorHallModel.instance:refreshDevelopReddot()
	ArcadeSurvivorController.instance:dispatchEvent(ArcadeSurvivorEvent.OnRefreshHallBuildingReddot, ArcadeSurvivorHallEnum.HallInteractiveUnitId.Develop)
end

function ArcadeSurvivorHallView:_refreshHandBookReddot()
	ArcadeSurvivorHallModel.instance:refreshHandBookReddot()
	ArcadeSurvivorController.instance:dispatchEvent(ArcadeSurvivorEvent.OnRefreshHallBuildingReddot, ArcadeSurvivorHallEnum.HallInteractiveUnitId.HandBook)
end

function ArcadeSurvivorHallView:_refreshTaskReddot()
	ArcadeSurvivorHallModel.instance:refreshTaskReddot()
	ArcadeSurvivorController.instance:dispatchEvent(ArcadeSurvivorEvent.OnRefreshHallBuildingReddot, ArcadeSurvivorHallEnum.HallInteractiveUnitId.Task)
end

function ArcadeSurvivorHallView:_onOpenView(viewName)
	if viewName == ViewName.ArcadeSurvivorGameView then
		ArcadeSurvivorController.instance:onExitHall(true)
	end
end

function ArcadeSurvivorHallView:_onLoadFinishHallScene()
	self._animPlayer:Play(UIAnimationName.Open, self._onPlayOpenAnimFinish, self)
end

function ArcadeSurvivorHallView:_onPlayOpenAnimFinish()
	return
end

function ArcadeSurvivorHallView:_onExitHallView(isImmediate)
	if isImmediate then
		self:closeThis()
	else
		self._animPlayer:Play(UIAnimationName.Close, self.closeThis, self)
	end
end

function ArcadeSurvivorHallView:_onBeginTransitionGame(difficulty)
	if self._enterDifficulty then
		return
	end

	self._enterDifficulty = difficulty

	self._animPlayer:Play("close1", self._onFinishTransitionGame, self)
	AudioMgr.instance:trigger(AudioEnum3_3.Arcade.play_ui_yuanzheng_transition)
end

function ArcadeSurvivorHallView:_onFinishTransitionGame()
	self._sceneView:showScene(false)
	ArcadeSurvivorGameController.instance:enterGame(self._enterDifficulty)
end

function ArcadeSurvivorHallView:_setNPCBlock(isBlock)
	self._isNpcTalkBlock = isBlock
end

function ArcadeSurvivorHallView:_editableInitView()
	self._enterDifficulty = nil
	self._sceneView = self.viewContainer:getSceneView()
	self._isMobilePlayer = GameUtil.isMobilePlayerAndNotEmulator()
	self._anim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._animPlayer = SLFramework.AnimatorPlayer.Get(self.viewGO.gameObject)

	NavigateMgr.instance:addEscape(self.viewName, self._btnbackOnClick, self)
	MainCameraMgr.instance:addView(self.viewName, self.initCamera, nil, self)
end

function ArcadeSurvivorHallView:initCamera()
	local camera = CameraMgr.instance:getMainCamera()

	camera.orthographic = true

	local scale = GameUtil.getAdapterScale()

	camera.orthographicSize = ArcadeSurvivorEnum.Const.MapCameraSize * scale
end

function ArcadeSurvivorHallView:onUpdateParam()
	return
end

function ArcadeSurvivorHallView:onOpen()
	self._anim.enabled = true

	self._anim:Play(UIAnimationName.Open, 0, 0)
	self._anim:Update(0)

	self._anim.enabled = false

	AudioMgr.instance:trigger(AudioEnum3_3.Arcade.play_ui_yuanzheng_game_start)

	if not self._isRunning then
		self._isRunning = true

		LateUpdateBeat:Add(self._onLateUpdate, self)
	end

	self:_refreshHero()
end

function ArcadeSurvivorHallView:_onLateUpdate()
	if self._enterDifficulty or self._isMobilePlayer then
		return
	end

	if self._moveTime and Time.time - self._moveTime > 0.5 and not self._isSendMoveRpc then
		ArcadeSurvivorHallModel.instance:saveHeroGrid()

		self._isSendMoveRpc = true
	end

	local direction

	if UnityEngineInput.GetKey(UnityEngineKeyCode.D) or UnityEngineInput.GetKey(UnityEngineKeyCode.RightArrow) then
		direction = ArcadeSurvivorDirection.Right
	elseif UnityEngineInput.GetKey(UnityEngineKeyCode.A) or UnityEngineInput.GetKey(UnityEngineKeyCode.LeftArrow) then
		direction = ArcadeSurvivorDirection.Left
	elseif UnityEngineInput.GetKey(UnityEngineKeyCode.W) or UnityEngineInput.GetKey(UnityEngineKeyCode.UpArrow) then
		direction = ArcadeSurvivorDirection.Up
	elseif UnityEngineInput.GetKey(UnityEngineKeyCode.S) or UnityEngineInput.GetKey(UnityEngineKeyCode.DownArrow) then
		direction = ArcadeSurvivorDirection.Down
	else
		return
	end

	local inGuiding = ArcadeGameHelper.checkInGuiding()

	if inGuiding then
		return
	end

	if not self._inputTime or Time.time - self._inputTime >= ArcadeSurvivorHallEnum.Const.LongPressArr[1] then
		self:_playerActOnDirection(direction)

		self._inputTime = Time.time
	end
end

function ArcadeSurvivorHallView:_playerActOnDirection(direction)
	self.viewContainer:playerActOnDirection(direction)

	self._moveTime = Time.time
	self._isSendMoveRpc = false
end

function ArcadeSurvivorHallView:_refreshHero()
	local equipHeroId = ArcadeSurvivorHeroModel.instance:getEquipHeroId()

	self._heroMO = ArcadeSurvivorHeroModel.instance:getHeroMOById(equipHeroId)

	local effectDict = self._heroMO:getEffectDict()

	if effectDict then
		self._weaponMO = effectDict[ArcadeSurvivorEnum.EffectType.Weapon]
		self._collectionMO = effectDict[ArcadeSurvivorEnum.EffectType.Collection]
	end

	self:_refreshWeapon()
	self:_refreshCollection()
end

function ArcadeSurvivorHallView:_refreshWeapon()
	if self._weaponMO then
		local icon = self._weaponMO:getIcon()

		if not string.nilorempty(icon) then
			self._simageweaponicon:LoadImage(ResUrl.getArcadeSurvivorIcon(icon))
		end
	end

	gohelper.setActive(self._goweapon, self._weaponMO)
	gohelper.setActive(self._goweaponempty, not self._weaponMO)
end

function ArcadeSurvivorHallView:_refreshCollection()
	if self._collectionMO then
		local id = self._collectionMO:getId()
		local rarity = ArcadeSurvivorConfig.instance:getCollectionRarity(id)
		local displayRarity = ArcadeSurvivorHelper.getCollectionDisplayRarity(rarity)
		local itembg = string.format(ArcadeSurvivorEnum.Const.CollectionRareBg, displayRarity)

		UISpriteSetMgr.instance:setArcadeSurvivorSprite(self._imagecollectionbg, itembg)

		self._txtcollectionnum.text = self._collectionMO:getCount()

		local icon = self._collectionMO:getIcon()

		if not string.nilorempty(icon) then
			self._simagecollectionicon:LoadImage(ResUrl.getArcadeSurvivorIcon(icon))
		end
	end

	gohelper.setActive(self._gocollection, self._collectionMO)
end

function ArcadeSurvivorHallView:onClose()
	ArcadeSurvivorHallModel.instance:saveHeroGrid()

	if self._isRunning then
		LateUpdateBeat:Remove(self._onLateUpdate, self)

		self._isRunning = false
	end
end

function ArcadeSurvivorHallView:onDestroyView()
	self._simagecollectionicon:UnLoadImage()
	self._simageweaponicon:UnLoadImage()
end

return ArcadeSurvivorHallView
