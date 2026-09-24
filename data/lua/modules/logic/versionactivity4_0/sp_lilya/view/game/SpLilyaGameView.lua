-- chunkname: @modules/logic/versionactivity4_0/sp_lilya/view/game/SpLilyaGameView.lua

module("modules.logic.versionactivity4_0.sp_lilya.view.game.SpLilyaGameView", package.seeall)

local SpLilyaGameView = class("SpLilyaGameView", BaseView)
local Input = UnityEngine.Input
local KeyCode = UnityEngine.KeyCode

function SpLilyaGameView:onInitView()
	self._simagefullbg1 = gohelper.findChildSingleImage(self.viewGO, "root/#simage_fullbg1")
	self._simagefullbg2 = gohelper.findChildSingleImage(self.viewGO, "root/#simage_fullbg2")
	self._goAirBackground1 = gohelper.findChild(self.viewGO, "root/#simage_fullbg2/simage_yun")
	self._goupperleft = gohelper.findChild(self.viewGO, "root/#go_upperleft")
	self._txtnum = gohelper.findChildText(self.viewGO, "root/#go_upperleft/#txt_num")
	self._txttip = gohelper.findChildText(self.viewGO, "root/#go_upperleft/txt_tips")
	self._gostar = gohelper.findChild(self.viewGO, "root/#go_upperleft/#go_star")
	self._golight = gohelper.findChild(self.viewGO, "root/#go_upperleft/#go_star/#go_light")
	self._goupperright = gohelper.findChild(self.viewGO, "root/#go_upperright")
	self._txtdesc = gohelper.findChildText(self.viewGO, "root/#go_upperright/#txt_desc")
	self._gonum = gohelper.findChild(self.viewGO, "root/#go_upperright/#go_num")
	self._txtnum1 = gohelper.findChildText(self.viewGO, "root/#go_upperright/#go_num/#txt_num1")
	self._txtnum3 = gohelper.findChildText(self.viewGO, "root/#go_upperright/#go_num/#txt_num1/txt_num2/#txt_num3")
	self._goroot = gohelper.findChild(self.viewGO, "root")
	self._goenergyTip = gohelper.findChild(self.viewGO, "root/#go_energyTip")
	self._gotipsbg = gohelper.findChild(self.viewGO, "root/#go_energyTip/#go_tipsbg")
	self._gooperate = gohelper.findChild(self.viewGO, "root/#go_drag/#go_operate")
	self._gooperate2 = gohelper.findChild(self.viewGO, "root/#go_drag/#go_operate2")
	self._gobottomright = gohelper.findChild(self.viewGO, "root/#go_bottomright")
	self._gobullet = gohelper.findChild(self.viewGO, "root/#go_bottomright/#go_bullet")
	self._gobulletState1 = gohelper.findChild(self.viewGO, "root/#go_bottomright/#go_bullet/#go_state1")
	self._gobulletState2 = gohelper.findChild(self.viewGO, "root/#go_bottomright/#go_bullet/#go_state2")
	self._gobulletState3 = gohelper.findChild(self.viewGO, "root/#go_bottomright/#go_bullet/#go_state3")
	self._gobulletRise = gohelper.findChildImage(self.viewGO, "root/#go_bottomright/#go_bullet/#go_state2/#image_rise")
	self._goshoot = gohelper.findChild(self.viewGO, "root/#go_bottomright/#go_shoot")
	self._gostate1 = gohelper.findChild(self.viewGO, "root/#go_bottomright/#go_shoot/#go_state1")
	self._gostate2 = gohelper.findChild(self.viewGO, "root/#go_bottomright/#go_shoot/#go_state2")
	self._goSubState1 = gohelper.findChild(self.viewGO, "root/#go_bottomright/#go_shoot/#go_state2/state1")
	self._goSubState2 = gohelper.findChild(self.viewGO, "root/#go_bottomright/#go_shoot/#go_state2/state2")
	self._goSubState3 = gohelper.findChild(self.viewGO, "root/#go_bottomright/#go_shoot/#go_state2/state3")
	self._imagerise = gohelper.findChildImage(self.viewGO, "root/#go_bottomright/#go_shoot/#go_state2/#image_rise")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")
	self._gosceneRoot = gohelper.findChild(self.viewGO, "root/#go_sceneRoot")
	self._godragRoot = gohelper.findChild(self.viewGO, "root/#go_drag")
	self._godragOperate = gohelper.findChild(self.viewGO, "root/#go_drag/#go_operate")
	self._imagedragOperate = gohelper.findChild(self.viewGO, "root/#go_drag/#go_operate/image_operate")
	self._btnEnergy = gohelper.findChildButton(self.viewGO, "root/#go_bottomright/#go_bullet")
	self._btnShoot = gohelper.findChildButton(self.viewGO, "root/#go_bottomright/#go_shoot")
	self._btnShootPress = SLFramework.UGUI.UIClickListener.Get(self._btnShoot.gameObject)
	self._btnShootPress.canMultTouch = true
	self._btnEnergyPress = SLFramework.UGUI.UIClickListener.Get(self._btnEnergy.gameObject)
	self._btnEnergyPress.canMultTouch = true
	self._dragHandle = SLFramework.UGUI.UIDragListener.Get(self._godragRoot)
	self._energyClickAnimator = gohelper.findChildComponent(self.viewGO, "root/#go_bottomright/#go_bullet", gohelper.Type_Animator)
	self._resultAnimator = gohelper.findChildComponent(self.viewGO, "root/#go_upperleft", gohelper.Type_Animator)
	self._waveAnimator = gohelper.findChildComponent(self.viewGO, "root/#go_upperright", gohelper.Type_Animator)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SpLilyaGameView:_onDragBegin(param, pointerEventData)
	if self._activePointerId ~= nil then
		return
	end

	if pointerEventData.pressPosition.x > UnityEngine.Screen.width * 0.5 then
		return
	end

	local uiCamera = CameraMgr.instance:getUICamera()
	local localPos = Vector2.zero
	local isRect, localPos = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(self._godragOperate.transform, pointerEventData.pressPosition, uiCamera, localPos)

	if not isRect then
		return
	end

	self._activePointerId = pointerEventData.pointerId
	self._joystickCenterX = localPos.x
	self._joystickCenterY = localPos.y

	transformhelper.setLocalPos(self._imagedragOperate.transform, 0, 0, 0)
	self:_updateJoystick(pointerEventData)
end

function SpLilyaGameView:_onDrag(param, pointerEventData)
	if pointerEventData.pointerId ~= self._activePointerId then
		return
	end

	self:_updateJoystick(pointerEventData)
end

function SpLilyaGameView:_onDragEnd(param, pointerEventData)
	if pointerEventData.pointerId ~= self._activePointerId then
		return
	end

	self:_resetJoystick()
	SpLilyaGameController.instance:setPlayerMoveDir(nil, nil)
end

function SpLilyaGameView:_resetJoystick()
	self._activePointerId = nil

	transformhelper.setLocalPos(self._imagedragOperate.transform, 0, 0, 0)
	transformhelper.setLocalPos(self._godragOperate.transform, self._joystickDefaultX, self._joystickDefaultY, self._joystickDefaultZ)
	transformhelper.setLocalPos(self._gooperate2.transform, self._joystickDefaultX, self._joystickDefaultY, self._joystickDefaultZ)
	self:_hideOperation2Arrows()
end

function SpLilyaGameView:_onShootPressDown()
	self._shootButtonPressed = true

	self:_refreshPowerInput()
end

function SpLilyaGameView:_onShootPressUp()
	self._shootButtonPressed = false

	self:_refreshPowerInput()
end

function SpLilyaGameView:_refreshPowerInput()
	local shouldPower = self._shootButtonPressed or self._spacePressed

	if shouldPower == self._powerInputActive then
		return
	end

	self._powerInputActive = shouldPower

	if shouldPower then
		SpLilyaGameController.instance:startPower()
	else
		SpLilyaGameController.instance:stopPower()
	end
end

function SpLilyaGameView:_resetPowerInputState()
	self._shootButtonPressed = false
	self._spacePressed = false
	self._powerInputActive = false
end

function SpLilyaGameView:_onKeyboardUpdate()
	self:_updateAirBackground(UnityEngine.Time.deltaTime)

	if not self._keyboardInputEnabled then
		return
	end

	if Input.GetKeyDown(KeyCode.Space) then
		self._spacePressed = true

		self:_refreshPowerInput()
	end

	if Input.GetKeyUp(KeyCode.Space) then
		self._spacePressed = false

		self:_refreshPowerInput()
	end

	if Input.GetKeyDown(KeyCode.R) then
		self:_onEnergy()
	end
end

function SpLilyaGameView:_onEnergy()
	local gameMO = SpLilyaGameModel.instance:getGameMO()

	if not gameMO then
		return
	end

	local playerMo = gameMO.playerMo
	local sceneMo = gameMO.sceneMo

	if not playerMo or not sceneMo then
		return
	end

	local energyMax = playerMo.energyMax or 0

	if energyMax <= 0 or energyMax > (playerMo.curEnergy or 0) then
		self:_showEnergyTip()

		return
	end

	self._energyClickAnimator:Play(SpLilyaEnum.EnergyClickAnimatorName.Click, 0, 0)
	SpLilyaGameController.instance:fireEnergy()
end

function SpLilyaGameView:_showEnergyTip()
	local item

	if self._useTipCount < SpLilyaEnum.MaxTipCount then
		local itemGo = gohelper.cloneInPlace(self._gotipsbg, tostring(self._useTipCount + 1))

		item = gohelper.findChildComponent(itemGo, "", gohelper.Type_Animator)

		table.insert(self._useTipList, item)

		self._useTipCount = self._useTipCount + 1
	else
		item = table.remove(self._useTipList, 1)

		table.insert(self._useTipList, item)
	end

	gohelper.setActive(item.gameObject, true)
	gohelper.setAsFirstSibling(item.gameObject)
	item:Play(SpLilyaEnum.EnergyTipAnimatorName.Open, 0, 0)
end

function SpLilyaGameView:addEvents()
	self._dragHandle:AddDragBeginListener(self._onDragBegin, self)
	self._dragHandle:AddDragListener(self._onDrag, self)
	self._dragHandle:AddDragEndListener(self._onDragEnd, self)
	self._btnShootPress:AddClickDownListener(self._onShootPressDown, self)
	self._btnShootPress:AddClickUpListener(self._onShootPressUp, self)
	self._btnEnergyPress:AddClickListener(self._onEnergy, self)
	self:addEventCb(SpLilyaGameController.instance, SpLilyaEvent.WaveUpdate, self.refreshWaveInfo, self)
	self:addEventCb(SpLilyaGameController.instance, SpLilyaEvent.WaveWaitUpdate, self._onWaveWaitUpdate, self)
	self:addEventCb(SpLilyaGameController.instance, SpLilyaEvent.TimeUpdate, self.refreshTimeInfo, self)
	self:addEventCb(SpLilyaGameController.instance, SpLilyaEvent.BulletCreate, self.refreshBulletInfo, self)
	self:addEventCb(SpLilyaGameController.instance, SpLilyaEvent.PowerUpdate, self.refreshShootBtnPowerState, self)
	self:addEventCb(SpLilyaGameController.instance, SpLilyaEvent.EnergyUpdate, self._onEnergyUpdate, self)
	self:addEventCb(SpLilyaGameController.instance, SpLilyaEvent.GameReset, self._onGameReset, self)
	self:addEventCb(SpLilyaGameController.instance, SpLilyaEvent.PlayerMoveEvent, self._onPlayerMove, self)
	self:addEventCb(SpLilyaGameController.instance, SpLilyaEvent.GameEnd, self._onGameEnd, self)
end

function SpLilyaGameView:removeEvents()
	self._dragHandle:RemoveDragBeginListener()
	self._dragHandle:RemoveDragListener()
	self._dragHandle:RemoveDragEndListener()
	self._btnShootPress:RemoveClickDownListener()
	self._btnShootPress:RemoveClickUpListener()
	self._btnEnergyPress:RemoveClickListener()
	self:removeEventCb(SpLilyaGameController.instance, SpLilyaEvent.WaveUpdate, self.refreshWaveInfo, self)
	self:removeEventCb(SpLilyaGameController.instance, SpLilyaEvent.WaveWaitUpdate, self._onWaveWaitUpdate, self)
	self:removeEventCb(SpLilyaGameController.instance, SpLilyaEvent.TimeUpdate, self.refreshTimeInfo, self)
	self:removeEventCb(SpLilyaGameController.instance, SpLilyaEvent.BulletCreate, self.refreshBulletInfo, self)
	self:removeEventCb(SpLilyaGameController.instance, SpLilyaEvent.PowerUpdate, self.refreshShootBtnPowerState, self)
	self:removeEventCb(SpLilyaGameController.instance, SpLilyaEvent.EnergyUpdate, self._onEnergyUpdate, self)
	self:removeEventCb(SpLilyaGameController.instance, SpLilyaEvent.GameReset, self._onGameReset, self)
	self:removeEventCb(SpLilyaGameController.instance, SpLilyaEvent.PlayerMoveEvent, self._onPlayerMove, self)
	self:removeEventCb(SpLilyaGameController.instance, SpLilyaEvent.GameEnd, self._onGameEnd, self)
end

function SpLilyaGameView:_editableInitView()
	self._joystickRadius = (recthelper.getWidth(self._godragOperate.transform) - recthelper.getWidth(self._imagedragOperate.transform)) / 2
	self._joystickDefaultX, self._joystickDefaultY, self._joystickDefaultZ = transformhelper.getLocalPos(self._godragOperate.transform)
	self._activePointerId = nil
	self._useTipList = self:getUserDataTb_()
	self._keyboardInputEnabled = false
	self._airBackgroundScrolling = false

	self:_resetPowerInputState()
	self:_initOperationKeyTips()

	self._useTipCount = 0

	gohelper.setActive(self._gotipsbg, false)
	recthelper.setAnchor(self._goenergyTip.transform, 0, 196)

	self._goWaveWaitTip = gohelper.clone(self._goenergyTip, self._goroot, "#go_waveWaitTip")

	recthelper.setAnchor(self._goWaveWaitTip.transform, 0, 268)

	self._goWaveWaitTipBg = gohelper.findChild(self._goWaveWaitTip, "#go_tipsbg")
	self._txtWaveWaitTip = gohelper.findChildText(self._goWaveWaitTipBg, "txt_tips")

	local waveWaitAnimator = gohelper.findChildComponent(self._goWaveWaitTip, "#go_tipsbg", gohelper.Type_Animator)

	if waveWaitAnimator then
		waveWaitAnimator.enabled = false
	end

	gohelper.setActive(self._goWaveWaitTipBg, true)
	gohelper.setActive(self._goWaveWaitTip, false)
	gohelper.setActive(self._txtdesc, false)

	self._operation2ArrowList = self:getUserDataTb_()

	for i = 1, 4 do
		self._operation2ArrowList[i] = gohelper.findChild(self.viewGO, string.format("root/#go_drag/#go_operate2/#go_arrow%d/#arrow_light", i))
	end
end

function SpLilyaGameView:_initOperationKeyTips()
	local keyTipResPath = self.viewContainer._viewSetting.otherRes[10]

	self._goShootKeyTip = self:getResInst(keyTipResPath, self._goshoot, "#go_operation_key_tip")

	recthelper.setAnchor(self._goShootKeyTip.transform, 0, -124)
	self:_setOperationKeyTip(self._goShootKeyTip, "SPACE")

	self._goEnergyKeyTip = self:getResInst(keyTipResPath, self._gobullet, "#go_operation_key_tip")

	recthelper.setAnchor(self._goEnergyKeyTip.transform, 0, -80)
	self:_setOperationKeyTip(self._goEnergyKeyTip, "R" .. " ")
end

function SpLilyaGameView:_setOperationKeyTip(keyTipGO, keyName)
	if gohelper.isNil(keyTipGO) then
		return
	end

	local shortKeyGO = gohelper.findChild(keyTipGO, "btn_1")
	local longKeyGO = gohelper.findChild(keyTipGO, "btn_2")
	local useLongKey = string.len(string.gsub(keyName, "%s+", "")) > 1

	gohelper.setActive(shortKeyGO, not useLongKey)
	gohelper.setActive(longKeyGO, useLongKey)

	gohelper.findChildText(keyTipGO, useLongKey and "btn_2/#txt_btn" or "btn_1/#txt_btn").text = keyName

	gohelper.setActive(keyTipGO, true)
end

function SpLilyaGameView:_onWaveWaitUpdate(remainSecond)
	local isWaiting = remainSecond ~= nil and remainSecond > 0

	gohelper.setActive(self._goWaveWaitTip, isWaiting)

	if isWaiting then
		self._txtWaveWaitTip.text = string.format("%d秒后刷新下一波怪物", remainSecond)
	end
end

function SpLilyaGameView:_updateJoystick(pointerEventData)
	local uiCamera = CameraMgr.instance:getUICamera()
	local localPos = Vector2.zero
	local isRect, localPos = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(self._godragOperate.transform, pointerEventData.position, uiCamera, localPos)

	if not isRect then
		return
	end

	local dirX = localPos.x - (self._joystickCenterX or 0)
	local dirY = localPos.y - (self._joystickCenterY or 0)
	local dist = math.sqrt(dirX * dirX + dirY * dirY)

	if dist > 0 then
		local clampedDist = math.min(dist, self._joystickRadius)
		local scale = clampedDist / dist

		transformhelper.setLocalPos(self._imagedragOperate.transform, dirX * scale, dirY * scale, 0)

		local gameInfo = self.gameInfo

		if gameInfo and gameInfo.isGravity == SpLilyaEnum.UseGravity.Unuse then
			self:_updateOperation2Arrows(dirX, dirY)
			SpLilyaGameController.instance:setPlayerMoveDir(dirX / dist, dirY / dist)
		else
			local angle = math.deg(math.atan2(dirY, dirX))

			angle = math.max(SpLilyaEnum.RotateLimit.Min, math.min(SpLilyaEnum.RotateLimit.Max, angle))

			if self._playerEntity then
				local shotSpeed = SpLilyaGameController.instance:getShotSpeed()

				self._playerEntity:setRotation(angle, shotSpeed)
				SpLilyaGameController.instance:setPlayerRotation(angle)
			end
		end
	end
end

function SpLilyaGameView:_updateOperation2Arrows(dirX, dirY)
	local angle = math.deg(math.atan2(dirY, dirX))
	local activeIndex

	activeIndex = angle >= 45 and angle < 135 and 1 or angle >= -45 and angle < 45 and 2 or angle >= -135 and angle < -45 and 3 or 4

	for i = 1, 4 do
		gohelper.setActive(self._operation2ArrowList[i], i == activeIndex)
	end
end

function SpLilyaGameView:_hideOperation2Arrows()
	for i = 1, 4 do
		gohelper.setActive(self._operation2ArrowList[i], false)
	end
end

function SpLilyaGameView:onUpdateParam()
	return
end

function SpLilyaGameView:onOpen()
	self:checkParam()
	self:refreshUI()

	self._keyboardInputEnabled = true

	UpdateBeat:Add(self._onKeyboardUpdate, self)
end

function SpLilyaGameView:checkParam()
	local actId = SpLilyaModel.instance:getActId()
	local episodeId = SpLilyaGameModel.instance:getCurEpisodeId()
	local gameConfig = SpLilyaConfig.instance:getGameCo(actId, episodeId)

	self.gameConfig = gameConfig
end

function SpLilyaGameView:refreshUI()
	self.gameInfo = SpLilyaGameModel.instance:getGameMO()

	self:initBackGround()
	self:initStageInfo()
	self:initBtn()
	self:initPlayerEntity()
end

function SpLilyaGameView:initPlayerEntity()
	if not self._playerEntity then
		local playerGo = self:getResInst(self.viewContainer._viewSetting.otherRes[2], self._gosceneRoot)
		local _playerEntity = MonoHelper.addNoUpdateLuaComOnceToGo(playerGo, SpLilyaPlayerEntity)

		self._playerEntity = _playerEntity

		local hitController = self.viewContainer:getRes(self.viewContainer._viewSetting.otherRes[8])

		if hitController then
			self._playerEntity:attachHitAnimator(hitController)
		end

		self._playerEntity:initEntity(self._gosceneRoot)
		self._playerEntity:setCurveType(self.gameConfig.isGravity)
	end
end

function SpLilyaGameView:initBtn()
	local isAutoFire = self.gameConfig.isGravity == SpLilyaEnum.UseGravity.Unuse

	gohelper.setActive(self._gooperate, not isAutoFire)
	gohelper.setActive(self._gooperate2, isAutoFire)
	self:_hideOperation2Arrows()
	gohelper.setActive(self._goshoot, not isAutoFire)
	gohelper.setActive(self._gobullet, self.gameConfig.isEnergy == SpLilyaEnum.UseEnergy.Use)
	self:refreshShootBtnPowerState(0)

	local playerMo = self.gameInfo and self.gameInfo.playerMo

	self:refreshEnergy(playerMo and playerMo.curEnergy or 0, playerMo and playerMo.energyMax or 0)
end

function SpLilyaGameView:refreshShootBtnPowerState(powerTime)
	powerTime = powerTime or 0

	local isPower = powerTime > 0

	gohelper.setActive(self._gostate1, not isPower)
	gohelper.setActive(self._gostate2, isPower)

	local playerMo = self.gameInfo and self.gameInfo.playerMo
	local maxPowerTime = playerMo and playerMo.maxPowerTime or 0
	local progress = maxPowerTime > 0 and math.min(powerTime / maxPowerTime, 1) or 0

	self._imagerise.fillAmount = progress

	local thresholds = SpLilyaEnum.BulletPress

	gohelper.setActive(self._goSubState1, isPower and progress >= thresholds[1])
	gohelper.setActive(self._goSubState2, isPower and progress >= thresholds[2])
	gohelper.setActive(self._goSubState3, isPower and progress >= thresholds[3])
end

function SpLilyaGameView:_onPlayerMove(posX, posY)
	if not self._playerEntity then
		return
	end

	self._playerEntity:setPos(posX, posY)
	self._playerEntity:refreshLinePos()
end

function SpLilyaGameView:_onEnergyUpdate(curEnergy, energyMax)
	self:refreshEnergy(curEnergy, energyMax)
end

function SpLilyaGameView:_onGameReset()
	self._keyboardInputEnabled = true
	self._airBackgroundScrolling = self.gameConfig.isGravity == SpLilyaEnum.UseGravity.Unuse

	self:_resetPowerInputState()
	self:_hideOperation2Arrows()

	local playerMo = self.gameInfo and self.gameInfo.playerMo

	if playerMo then
		self:refreshEnergy(playerMo.curEnergy, playerMo.energyMax)
	end

	self._resultAnimator:Play(SpLilyaEnum.SuccessAnimatorName.Idle, 0, 0)
	self._energyClickAnimator:Play(SpLilyaEnum.EnergyClickAnimatorName.Idle, 0, 0)
	gohelper.setActive(self._goWaveWaitTip, false)
	self:refreshWaveInfo()
end

function SpLilyaGameView:refreshEnergy(curEnergy, energyMax)
	curEnergy = curEnergy or 0
	energyMax = energyMax or 0

	local isEmpty = curEnergy <= 0
	local isFull = not isEmpty and energyMax > 0 and energyMax <= curEnergy

	gohelper.setActive(self._gobulletState1, isEmpty)
	gohelper.setActive(self._gobulletState2, not isEmpty and not isFull)
	gohelper.setActive(self._gobulletState3, isFull)

	if not isEmpty and not isFull then
		self._gobulletRise.fillAmount = curEnergy / energyMax
	end
end

function SpLilyaGameView:initStageInfo()
	self:refreshTipsInfo()
	self:refreshWaveInfo()
end

function SpLilyaGameView:refreshTipsInfo()
	self._txttip.text = self.gameConfig.winDesc

	local showDesc = self.gameInfo.winType ~= SpLilyaEnum.VictoryType.LimitBulle and self.gameInfo.time > 0 or self.gameInfo.winType == SpLilyaEnum.VictoryType.LimitBulle

	gohelper.setActive(self._txtnum, showDesc)
	self:refreshTimeInfo()
	self:refreshBulletInfo()
end

function SpLilyaGameView:refreshTimeInfo()
	if self.gameInfo.winType ~= SpLilyaEnum.VictoryType.LimitBulle and self.gameInfo.time > 0 then
		local remainTime = math.ceil(self.gameInfo.remainTime)

		self._txtnum.text = TimeUtil.second2TimeString(remainTime)
	end
end

function SpLilyaGameView:refreshBulletInfo(noPlayAnim)
	if self.gameInfo.winType == SpLilyaEnum.VictoryType.LimitBulle then
		local desc = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("v4a0_sp_lilya_bullet_limit_tip"), self.gameInfo.shotCount)

		self._txtnum.text = desc
	end
end

function SpLilyaGameView:refreshWaveInfo()
	TaskDispatcher.cancelTask(self._onWaveAnimPlayFinish, self)
	TaskDispatcher.runDelay(self._onWaveAnimPlayFinish, self, SpLilyaEnum.AnimTime.Update)
	gohelper.setActive(self._txtdesc, true)

	self._txtdesc.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("v4a0_sp_lilya_wave_tip"), self.gameInfo.curWave + 1)

	self._waveAnimator:Play(SpLilyaEnum.WaveAnimatorName.Update, 0, 0)
end

function SpLilyaGameView:_onWaveAnimPlayFinish()
	TaskDispatcher.cancelTask(self._onWaveAnimPlayFinish, self)

	local gameInfo = self.gameInfo
	local maxWave = gameInfo.maxWave
	local curWave = gameInfo.curWave

	gohelper.setActive(self._txtdesc, false)

	self._txtnum3.text = tostring(curWave + 1)
	self._txtnum1.text = tostring(maxWave + 1)
end

function SpLilyaGameView:initBackGround()
	local isAirStage = self.gameConfig.isGravity == SpLilyaEnum.UseGravity.Unuse

	gohelper.setActive(self._simagefullbg1, not isAirStage)
	gohelper.setActive(self._simagefullbg2, isAirStage)
	self:_initAirBackground(isAirStage)
end

function SpLilyaGameView:_initAirBackground(isAirStage)
	self._airBackgroundScrolling = isAirStage

	if not self._goAirBackground1 then
		return
	end

	if not isAirStage then
		if self._goAirBackground2 then
			gohelper.setActive(self._goAirBackground2, false)
		end

		return
	end

	if not self._goAirBackground2 then
		self._goAirBackground2 = gohelper.cloneInPlace(self._goAirBackground1, "simage_yun_loop")
	end

	local transform1 = self._goAirBackground1.transform
	local transform2 = self._goAirBackground2.transform
	local originX, originY = recthelper.getAnchor(transform1)
	local scaleX = math.abs(transform1.localScale.x)
	local backgroundWidth = recthelper.getWidth(transform1) * scaleX

	if backgroundWidth <= 0 then
		self._airBackgroundScrolling = false

		return
	end

	self._airBackgroundOriginX = originX
	self._airBackgroundY = originY
	self._airBackgroundWidth = backgroundWidth

	recthelper.setAnchor(transform1, originX, originY)
	recthelper.setAnchor(transform2, originX + backgroundWidth, originY)
	gohelper.setActive(self._goAirBackground2, true)
end

function SpLilyaGameView:_updateAirBackground(deltaTime)
	if not self._airBackgroundScrolling or not self._goAirBackground2 then
		return
	end

	if not deltaTime or deltaTime <= 0 then
		return
	end

	local width = self._airBackgroundWidth
	local originX = self._airBackgroundOriginX

	if not width or width <= 0 or not originX then
		return
	end

	local moveStep = SpLilyaEnum.AirBackgroundScrollSpeed * deltaTime
	local transform1 = self._goAirBackground1.transform
	local transform2 = self._goAirBackground2.transform
	local x1 = recthelper.getAnchorX(transform1) - moveStep
	local x2 = recthelper.getAnchorX(transform2) - moveStep
	local wrapX = originX - width

	if x1 <= wrapX then
		x1 = x1 + width * 2
	end

	if x2 <= wrapX then
		x2 = x2 + width * 2
	end

	recthelper.setAnchor(transform1, x1, self._airBackgroundY)
	recthelper.setAnchor(transform2, x2, self._airBackgroundY)
end

function SpLilyaGameView:_onGameEnd()
	self._keyboardInputEnabled = false
	self._airBackgroundScrolling = false

	self:_resetPowerInputState()
	gohelper.setActive(self._goWaveWaitTip, false)

	local gameInfo = self.gameInfo
	local animName

	if gameInfo.gameResult == SpLilyaEnum.GameResult.Success then
		animName = SpLilyaEnum.SuccessAnimatorName.Success
	else
		animName = SpLilyaEnum.SuccessAnimatorName.Fail
	end

	self._resultAnimator:Play(animName, 0, 0)
end

function SpLilyaGameView:onClose()
	UpdateBeat:Remove(self._onKeyboardUpdate, self)

	self._keyboardInputEnabled = false
	self._airBackgroundScrolling = false

	self:_resetPowerInputState()
	TaskDispatcher.cancelTask(self._onWaveAnimPlayFinish, self)
end

function SpLilyaGameView:onDestroyView()
	return
end

return SpLilyaGameView
