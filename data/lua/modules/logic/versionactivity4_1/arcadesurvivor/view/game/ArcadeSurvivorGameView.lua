-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/view/game/ArcadeSurvivorGameView.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.view.game.ArcadeSurvivorGameView", package.seeall)

local ArcadeSurvivorGameView = class("ArcadeSurvivorGameView", BaseView)
local UnityEngineInput = UnityEngine.Input
local UnityEngineKeyCode = UnityEngine.KeyCode
local ArcadeSurvivorDirection = ArcadeSurvivorEnum.Direction

function ArcadeSurvivorGameView:onInitView()
	self._goentitytip = gohelper.findChild(self.viewGO, "#go_entitytip")
	self._godrag = gohelper.findChild(self.viewGO, "Game/#go_drag")
	self._btndrag = ArcadeSurvivorGameHelper.getArcadeSurvivorButton(self.viewGO, "Game/#go_drag")
	self._goiconnode = gohelper.findChild(self.viewGO, "Game/#go_iconnode")
	self._goentityicon = gohelper.findChild(self.viewGO, "Game/#go_iconnode/#go_entityicon")
	self._gofloatnode = gohelper.findChild(self.viewGO, "Game/#go_floatnode")
	self._gofloatitem = gohelper.findChild(self.viewGO, "Game/#go_floatnode/#go_floatitem")
	self._goselectedframe = gohelper.findChild(self.viewGO, "Game/#go_selectedframe")
	self._godangerwarning = gohelper.findChild(self.viewGO, "Game/#go_dangerWarning")
	self._simagedangericon = gohelper.findChildSingleImage(self.viewGO, "Game/#go_dangerWarning/#simage_icon")
	self._imagedangericon = self._simagedangericon:GetComponent(gohelper.Type_Image)
	self._txtdangername = gohelper.findChildText(self.viewGO, "Game/#go_dangerWarning/#txt_name")
	self._txtdangerdesc = gohelper.findChildText(self.viewGO, "Game/#go_dangerWarning/#txt_desc")
	self._gocollection = gohelper.findChild(self.viewGO, "Left/#go_item/#scroll_collection/viewport/content")
	self._gocollectionitem = gohelper.findChild(self.viewGO, "Left/#go_item/#scroll_collection/viewport/content/#go_collectionitem")
	self._btncollection = ArcadeSurvivorGameHelper.getArcadeSurvivorButton(self.viewGO, "Left/#go_item/#scroll_collection/#btn_collectionclick")
	self._gocollectionFlyTarget = gohelper.findChild(self.viewGO, "Left/#go_item/#go_collectionflytarget")
	self._simageweaponicon = gohelper.findChildSingleImage(self.viewGO, "Left/#go_item/#go_weapon/#go_weaponitem/#image_icon")
	self._goweapontrigger = gohelper.findChild(self.viewGO, "Left/#go_item/#go_weapon/#go_weaponitem/#go_trigger")
	self._btnweapon = ArcadeSurvivorGameHelper.getArcadeSurvivorButton(self.viewGO, "Left/#go_item/#go_weapon/#go_weaponitem/btn_click")
	self._simageheroicon = gohelper.findChildSingleImage(self.viewGO, "Left/hero/mask/simage_icon")
	self._gohpbar = gohelper.findChild(self.viewGO, "Left/hero/#go_hpbar")
	self._gohpitem = gohelper.findChild(self.viewGO, "Left/hero/#go_hpbar/go_hpitem")
	self._txthpnum = gohelper.findChildText(self.viewGO, "Left/hero/go_hpNum/#txt_num")
	self._gobase = gohelper.findChild(self.viewGO, "Left/hero/#go_base")
	self._gobaseItem = gohelper.findChild(self.viewGO, "Left/hero/#go_base/go_baseitem")
	self._btnLeft = ArcadeSurvivorGameHelper.getArcadeSurvivorClickListener(self.viewGO, "Left/#go_joyPoint/#go_joystick/#go_background/btn_left")
	self._btnRight = ArcadeSurvivorGameHelper.getArcadeSurvivorClickListener(self.viewGO, "Left/#go_joyPoint/#go_joystick/#go_background/btn_right")
	self._btnUp = ArcadeSurvivorGameHelper.getArcadeSurvivorClickListener(self.viewGO, "Left/#go_joyPoint/#go_joystick/#go_background/btn_up")
	self._btnDown = ArcadeSurvivorGameHelper.getArcadeSurvivorClickListener(self.viewGO, "Left/#go_joyPoint/#go_joystick/#go_background/btn_down")
	self._gojoystick = gohelper.findChild(self.viewGO, "Left/#go_joyPoint/#go_joystick")
	self._goback = gohelper.findChild(self.viewGO, "#go_topleft/#btn_back")
	self._btnback = ArcadeSurvivorGameHelper.getArcadeSurvivorButton(self.viewGO, "#go_topleft/#btn_back")
	self._goleveltarget = gohelper.findChild(self.viewGO, "Left/#go_tips")
	self._txtleveltarget = gohelper.findChildText(self.viewGO, "Left/#go_tips/#txt_title")
	self._goeventlist = gohelper.findChild(self.viewGO, "Right/#go_wishlist")
	self._goeventitem = gohelper.findChild(self.viewGO, "Right/#go_wishlist/wishitem")
	self._gocurrencyFlyTarget = gohelper.findChild(self.viewGO, "Top/#go_currencyflytarget")
	self._golv = gohelper.findChild(self.viewGO, "Top/#go_lv")
	self._imagelvBG = gohelper.findChildImage(self.viewGO, "Top/#go_lv/#image_lvBG")
	self._imagelv = gohelper.findChildImage(self.viewGO, "Top/#go_lv/#image_lv")
	self._txtrate = gohelper.findChildText(self.viewGO, "Top/#go_lv/#txt_rate")
	self._goFlyItemContent = gohelper.findChild(self.viewGO, "#go_flyItemContent")
	self._goFlyItem = gohelper.findChild(self.viewGO, "#go_flyItemContent/#go_flyItem")
	self._goitemtip = gohelper.findChild(self.viewGO, "#go_itemtip")
	self._btnbattlefield = ArcadeSurvivorGameHelper.getArcadeSurvivorClickListener(self.viewGO, "#btn_battlefield")
	self._gobosshpbarroot = gohelper.findChild(self.viewGO, "#go_boss_hpbar")
	self._imagebosshpfb = gohelper.findChildImage(self.viewGO, "#go_boss_hpbar/#go_hpbar/bg/fg")
	self._txtbosshp = gohelper.findChildText(self.viewGO, "#go_boss_hpbar/#go_hpbar/txt_num")
	self._opening = gohelper.findChild(self.viewGO, "#go_opening")
	self._txtleveltitle = gohelper.findChildText(self.viewGO, "#go_opening/txt_title")
	self._txtleveldesc = gohelper.findChildText(self.viewGO, "#go_opening/#txt_desc")
	self._godialoguetalk = gohelper.findChild(self.viewGO, "#go_dialoguetalk")
	self._goexcessive = gohelper.findChild(self.viewGO, "#go_excessive")
	self._excessiveAnimEvent = gohelper.findChildComponent(self.viewGO, "#go_excessive/storymode/anim", gohelper.Type_AnimationEventWrap)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ArcadeSurvivorGameView:addEvents()
	self._btncollection:AddClickListener(self._btncollectionOnClick, self)
	self._btnweapon:AddClickListener(self._btnweaponOnClick, self)
	self._btnback:AddClickListener(self._btnbackOnClick, self)
	self._btnbattlefield:AddClickListener(self._btnbattlefieldOnClick, self)
	self._btnLeft:AddClickDownListener(self._btnDirectionOnClick, self, ArcadeSurvivorEnum.Direction.Left)
	self._btnRight:AddClickDownListener(self._btnDirectionOnClick, self, ArcadeSurvivorEnum.Direction.Right)
	self._btnUp:AddClickDownListener(self._btnDirectionOnClick, self, ArcadeSurvivorEnum.Direction.Up)
	self._btnDown:AddClickDownListener(self._btnDirectionOnClick, self, ArcadeSurvivorEnum.Direction.Down)
	self._btndrag:AddClickListener(self._btnClickOnClick, self)

	self._dragHandle = SLFramework.UGUI.UIDragListener.Get(self._godrag)

	self._dragHandle:AddDragBeginListener(self._onDragBegin, self)
	self._dragHandle:AddDragEndListener(self._onDragEnd, self)
	NavigateMgr.instance:addEscape(ViewName.ArcadeSurvivorGameView, self._btnbackOnClick, self)
	self._excessiveAnimEvent:AddEventListener("beginSwitchRoom", self._onBeginSwitchStage, self)
	self:addEventCb(ArcadeSurvivorGameController.instance, ArcadeSurvivorEvent.OnResetGame, self._onResetGame, self)
	self:addEventCb(ArcadeSurvivorGameController.instance, ArcadeSurvivorEvent.PlayChangeStageExcessive, self._onPlayChangeStageExcessive, self)
	self:addEventCb(ArcadeSurvivorGameController.instance, ArcadeSurvivorEvent.OnAddEntity, self._onAddEntity, self)
	self:addEventCb(ArcadeSurvivorGameController.instance, ArcadeSurvivorEvent.OnAddEntities, self._onAddEntities, self)
	self:addEventCb(ArcadeSurvivorGameController.instance, ArcadeSurvivorEvent.OnRemoveEntity, self._onRemoveEntity, self)
	self:addEventCb(ArcadeSurvivorGameController.instance, ArcadeSurvivorEvent.OnEnterLevel, self._onEnterLevel, self)
	self:addEventCb(ArcadeSurvivorGameController.instance, ArcadeSurvivorEvent.OnBattleBegin, self._onBattleBegin, self)
	self:addEventCb(ArcadeSurvivorGameController.instance, ArcadeSurvivorEvent.PlayOpening, self.playOpening, self)
	self:addEventCb(ArcadeSurvivorGameController.instance, ArcadeSurvivorEvent.OnRoundBegin, self._onRoundBegin, self)
	self:addEventCb(ArcadeSurvivorGameController.instance, ArcadeSurvivorEvent.OnPlayerTurnStart, self._onPlayerTurnStart, self)
	self:addEventCb(ArcadeSurvivorGameController.instance, ArcadeSurvivorEvent.OnPlayerTurnUpdate, self._onPlayerTurnUpdate, self)
	self:addEventCb(ArcadeSurvivorGameController.instance, ArcadeSurvivorEvent.OnSelectEvent, self._onSelectEvent, self)
	self:addEventCb(ArcadeSurvivorGameController.instance, ArcadeSurvivorEvent.OnChangeEntityHp, self._onHpChange, self)
	self:addEventCb(ArcadeSurvivorGameController.instance, ArcadeSurvivorEvent.OnEntityAttrChange, self._onEntityAttrChange, self)
	self:addEventCb(ArcadeSurvivorGameController.instance, ArcadeSurvivorEvent.OnEntityChangeAttrDict, self._onEntityChangeAttrDict, self)
	self:addEventCb(ArcadeSurvivorGameController.instance, ArcadeSurvivorEvent.OnEntityMove, self._onEntityMove, self)
	self:addEventCb(ArcadeSurvivorGameController.instance, ArcadeSurvivorEvent.OnEntityTweenMove, self._onEntityTweenMove, self)
	self:addEventCb(ArcadeSurvivorGameController.instance, ArcadeSurvivorEvent.RefreshEntityIcon, self._onRefreshEntityIcon, self)
	self:addEventCb(ArcadeSurvivorGameController.instance, ArcadeSurvivorEvent.OnSceneFocusChange, self._onSceneFocusChange, self)
	self:addEventCb(ArcadeSurvivorGameController.instance, ArcadeSurvivorEvent.OnBossFocusStart, self._onBossFocusStart, self)
	self:addEventCb(ArcadeSurvivorGameController.instance, ArcadeSurvivorEvent.OnCollectionChange, self._onCollectionChange, self)
	self:addEventCb(ArcadeSurvivorGameController.instance, ArcadeSurvivorEvent.OnCollectionSkillTrigger, self._onCollectionSkillTrigger, self)
	self:addEventCb(ArcadeSurvivorGameController.instance, ArcadeSurvivorEvent.OnGameCurrencyChange, self._onCurrencyChange, self)
	self:addEventCb(ArcadeSurvivorGameController.instance, ArcadeSurvivorEvent.OnScoreChange, self._onScoreChange, self)
	self:addEventCb(ArcadeSurvivorGameController.instance, ArcadeSurvivorEvent.PlayUIEffect, self._onPlayUIEffect, self)
	self:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self:addEventCb(ViewMgr.instance, ViewEvent.ReOpenWhileOpen, self._onOverlayViewOpened, self)
	self:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onOverlayViewClosed, self)
	self:addEventCb(ViewMgr.instance, ViewEvent.DestroyViewFinish, self._onOverlayViewClosed, self)
	self:addEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self._onScreenResize, self)
end

function ArcadeSurvivorGameView:removeEvents()
	self._btncollection:RemoveClickListener()
	self._btnweapon:RemoveClickListener()
	self._btnback:RemoveClickListener()
	self._btnbattlefield:RemoveClickListener()
	self._btnLeft:RemoveClickDownListener()
	self._btnRight:RemoveClickDownListener()
	self._btnUp:RemoveClickDownListener()
	self._btnDown:RemoveClickDownListener()
	self._btndrag:RemoveClickListener()
	self._dragHandle:RemoveDragBeginListener()
	self._dragHandle:RemoveDragEndListener()
	self._excessiveAnimEvent:RemoveAllEventListener()
	self:removeEventCb(ArcadeSurvivorGameController.instance, ArcadeSurvivorEvent.OnResetGame, self._onResetGame, self)
	self:removeEventCb(ArcadeSurvivorGameController.instance, ArcadeSurvivorEvent.PlayChangeStageExcessive, self._onPlayChangeStageExcessive, self)
	self:removeEventCb(ArcadeSurvivorGameController.instance, ArcadeSurvivorEvent.OnAddEntity, self._onAddEntity, self)
	self:removeEventCb(ArcadeSurvivorGameController.instance, ArcadeSurvivorEvent.OnAddEntities, self._onAddEntities, self)
	self:removeEventCb(ArcadeSurvivorGameController.instance, ArcadeSurvivorEvent.OnRemoveEntity, self._onRemoveEntity, self)
	self:removeEventCb(ArcadeSurvivorGameController.instance, ArcadeSurvivorEvent.OnEnterLevel, self._onEnterLevel, self)
	self:removeEventCb(ArcadeSurvivorGameController.instance, ArcadeSurvivorEvent.OnBattleBegin, self._onBattleBegin, self)
	self:removeEventCb(ArcadeSurvivorGameController.instance, ArcadeSurvivorEvent.PlayOpening, self.playOpening, self)
	self:removeEventCb(ArcadeSurvivorGameController.instance, ArcadeSurvivorEvent.OnRoundBegin, self._onRoundBegin, self)
	self:removeEventCb(ArcadeSurvivorGameController.instance, ArcadeSurvivorEvent.OnPlayerTurnStart, self._onPlayerTurnStart, self)
	self:removeEventCb(ArcadeSurvivorGameController.instance, ArcadeSurvivorEvent.OnPlayerTurnUpdate, self._onPlayerTurnUpdate, self)
	self:removeEventCb(ArcadeSurvivorGameController.instance, ArcadeSurvivorEvent.OnSelectEvent, self._onSelectEvent, self)
	self:removeEventCb(ArcadeSurvivorGameController.instance, ArcadeSurvivorEvent.OnChangeEntityHp, self._onHpChange, self)
	self:removeEventCb(ArcadeSurvivorGameController.instance, ArcadeSurvivorEvent.OnEntityAttrChange, self._onEntityAttrChange, self)
	self:removeEventCb(ArcadeSurvivorGameController.instance, ArcadeSurvivorEvent.OnEntityChangeAttrDict, self._onEntityChangeAttrDict, self)
	self:removeEventCb(ArcadeSurvivorGameController.instance, ArcadeSurvivorEvent.OnEntityMove, self._onEntityMove, self)
	self:removeEventCb(ArcadeSurvivorGameController.instance, ArcadeSurvivorEvent.OnEntityTweenMove, self._onEntityTweenMove, self)
	self:removeEventCb(ArcadeSurvivorGameController.instance, ArcadeSurvivorEvent.RefreshEntityIcon, self._onRefreshEntityIcon, self)
	self:removeEventCb(ArcadeSurvivorGameController.instance, ArcadeSurvivorEvent.OnSceneFocusChange, self._onSceneFocusChange, self)
	self:removeEventCb(ArcadeSurvivorGameController.instance, ArcadeSurvivorEvent.OnBossFocusStart, self._onBossFocusStart, self)
	self:removeEventCb(ArcadeSurvivorGameController.instance, ArcadeSurvivorEvent.OnCollectionChange, self._onCollectionChange, self)
	self:removeEventCb(ArcadeSurvivorGameController.instance, ArcadeSurvivorEvent.OnCollectionSkillTrigger, self._onCollectionSkillTrigger, self)
	self:removeEventCb(ArcadeSurvivorGameController.instance, ArcadeSurvivorEvent.OnGameCurrencyChange, self._onCurrencyChange, self)
	self:removeEventCb(ArcadeSurvivorGameController.instance, ArcadeSurvivorEvent.OnScoreChange, self._onScoreChange, self)
	self:removeEventCb(ArcadeSurvivorGameController.instance, ArcadeSurvivorEvent.PlayUIEffect, self._onPlayUIEffect, self)
	self:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self:removeEventCb(ViewMgr.instance, ViewEvent.ReOpenWhileOpen, self._onOverlayViewOpened, self)
	self:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onOverlayViewClosed, self)
	self:removeEventCb(ViewMgr.instance, ViewEvent.DestroyViewFinish, self._onOverlayViewClosed, self)
	self:removeEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self._onScreenResize, self)
end

local EXCESSIVE_OUT_TIME = 5

function ArcadeSurvivorGameView:_onPlayChangeStageExcessive()
	gohelper.setActive(self._goexcessive, false)
	gohelper.setActive(self._goexcessive, true)
	AudioMgr.instance:trigger(AudioEnum3_3.Arcade.play_ui_yuanzheng_transition)
	TaskDispatcher.cancelTask(self._playExcessiveOverTime, self)
	TaskDispatcher.runDelay(self._playExcessiveOverTime, self, EXCESSIVE_OUT_TIME)
end

function ArcadeSurvivorGameView:_playExcessiveOverTime()
	logError("ArcadeSurvivorGameView:_playExcessiveOverTime")
	self:_onBeginSwitchStage()
end

function ArcadeSurvivorGameView:_onBeginSwitchStage()
	TaskDispatcher.cancelTask(self._playExcessiveOverTime, self)
	ArcadeSurvivorGameController.instance:enterStageSceneAfterExcessive()
end

function ArcadeSurvivorGameView:_btncollectionOnClick()
	local characterMO = ArcadeSurvivorGameModel.instance:getCharacterMO()
	local collectionIdList = characterMO and characterMO:getCollectionIdList()

	if not collectionIdList or #collectionIdList <= 0 then
		return
	end

	local param = {
		needMask = true,
		isInSide = true,
		root = self._goitemtip,
		collectionList = collectionIdList,
		originalViewName = self.viewName
	}

	ArcadeSurvivorController.instance:openTipView(ArcadeSurvivorEnum.TipType.Collection, param)
	self:changeSelectedFrame()
end

function ArcadeSurvivorGameView:_btnweaponOnClick()
	local characterMO = ArcadeSurvivorGameModel.instance:getCharacterMO()
	local characterId = characterMO and characterMO:getId()
	local weaponId = ArcadeSurvivorConfig.instance:getCharacterWeaponCollectionId(characterId)
	local param = {
		needMask = true,
		isInSide = true,
		root = self._goitemtip,
		weaponId = weaponId,
		characterId = characterId,
		originalViewName = self.viewName
	}

	ArcadeSurvivorController.instance:openTipView(ArcadeSurvivorEnum.TipType.Weapon, param)
	self:changeSelectedFrame()
end

function ArcadeSurvivorGameView:_btneventItemOnClick(index)
	local eventId = self._eventItemList[index].eventId
	local param = {
		needMask = true,
		root = self._goitemtip,
		eventId = eventId,
		originalViewName = self.viewName
	}

	ArcadeSurvivorController.instance:openTipView(ArcadeSurvivorEnum.TipType.Event, param)
	self:changeSelectedFrame()
end

function ArcadeSurvivorGameView:_btnbackOnClick()
	ArcadeSurvivorGameController.instance:pauseGame(ArcadeSurvivorGameEnum.StopSource.QuitTip)
	ArcadeSurvivorController.instance:openQuitTipView(true)
end

function ArcadeSurvivorGameView:_btnbattlefieldOnClick()
	ArcadeSurvivorGameController.instance:dispatchEvent(ArcadeSurvivorEvent.BackToShopOrEventView)
end

function ArcadeSurvivorGameView:_btnDirectionOnClick(direction)
	ArcadeSurvivorGameController.instance:playerActOnDirection(direction)
	self:_closeTipView(true)
end

function ArcadeSurvivorGameView:_btnClickOnClick()
	local scene = ArcadeSurvivorGameController.instance:getGameScene()
	local transEntityMgr = scene and scene.entityMgr:getTrans()

	if not transEntityMgr then
		self:_closeTipView()

		return
	end

	local mousePos = GamepadController.instance:getMousePosition()
	local worldPos = recthelper.screenPosToWorldPos(mousePos, nil, transEntityMgr.position)
	local localPos = transEntityMgr:InverseTransformPoint(worldPos.x, worldPos.y, 0)
	local gridX, gridY = ArcadeSurvivorGameHelper.position2Grid(localPos.x, localPos.y)
	local isOutside = ArcadeSurvivorGameHelper.isOutsideMap(gridX, gridY)

	if isOutside then
		self:_closeTipView()

		return
	end

	local occupyEntityData = ArcadeSurvivorGameModel.instance:getEntityDataInGrid(gridX, gridY)

	if not occupyEntityData then
		self:_closeTipView()

		return
	end

	local entityType = occupyEntityData.entityType
	local uid = occupyEntityData.uid

	if isDebugBuild then
		local clickUnitMO = ArcadeSurvivorGameModel.instance:getEntityMO(entityType, uid)
		local id = clickUnitMO and clickUnitMO:getId()

		logNormal(string.format("ArcadeSurvivor click entity, Type:%s Id:%s Uid:%s GridX:%s GridY:%s", tostring(entityType), tostring(id), tostring(uid), tostring(gridX), tostring(gridY)))
	end

	if entityType == ArcadeSurvivorEnum.EntityType.Character or entityType == ArcadeSurvivorEnum.EntityType.Monster then
		local anchor = {
			x = 705,
			y = 112
		}
		local param = {
			hideCloseBtn = true,
			isInSide = true,
			root = self._goentitytip,
			anchorPos = anchor,
			entityType = entityType,
			uid = uid,
			originalViewName = self.viewName
		}

		ArcadeSurvivorController.instance:openTipView(ArcadeSurvivorEnum.TipType.Hero, param)
		self:changeSelectedFrame(entityType, uid)
	end
end

function ArcadeSurvivorGameView:_onDragBegin(param, pointerEventData)
	self._startPosition = pointerEventData.position
end

local DRAG_OFFSET = 10

function ArcadeSurvivorGameView:_onDragEnd(param, pointerEventData)
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

	self:_btnDirectionOnClick(direction)
end

function ArcadeSurvivorGameView:_onResetGame()
	self:_clearOpening()
	self:onOpen()
end

function ArcadeSurvivorGameView:_onAddEntity(mo)
	self:addIcon2Entity(mo)
	self:refreshOutsideMonsterArrows()
end

function ArcadeSurvivorGameView:_onAddEntities(moList)
	if not moList then
		return
	end

	for _, mo in ipairs(moList) do
		self:addIcon2Entity(mo)
	end

	self:refreshOutsideMonsterArrows()
end

function ArcadeSurvivorGameView:_onRemoveEntity(entityType, uid)
	local monsterEntityType = ArcadeSurvivorEnum.EntityType.Monster

	if entityType == monsterEntityType then
		if self._bossHpCapDict and self._bossHpCapDict[uid] ~= nil then
			local aliveBossMOList = ArcadeSurvivorGameModel.instance:getAliveBossMOList()

			if #aliveBossMOList <= 0 then
				self:onTargetFinish()
			end
		else
			local monsterMOList = ArcadeSurvivorGameModel.instance:getEntityMOList(monsterEntityType)

			if not monsterMOList or #monsterMOList <= 0 then
				self:onTargetFinish()
			end
		end
	end

	self:checkSelectedEntity()
	self:recycleIcon(entityType, uid)
	self:refreshOutsideMonsterArrows()
end

function ArcadeSurvivorGameView:_onEnterLevel()
	self._timeFrameAnimator:Play(UIAnimationName.Idle, 0, 0)
	self._bossHpBarAnimator:Play(UIAnimationName.Idle, 0, 0)

	self._timeFrameBgIndex = 1
	self._haveSwitchedTarget = false
	self._bossIdList = {}
	self._bossHpCapDict = {}
	self._bossTotalHpCap = 0

	self:_tryFindBoss()

	local bossIdCount = self._bossIdList and #self._bossIdList or 0
	local levelBgmId = AudioEnum3_3.bgm.play_8bit_music_combat

	if bossIdCount > 0 then
		local bossBgmId

		for _, bossId in ipairs(self._bossIdList) do
			local bgmId = ArcadeSurvivorConfig.instance:getMonsterBgmId(bossId)

			if bgmId and bgmId > 0 then
				bossBgmId = bgmId

				break
			end
		end

		levelBgmId = bossBgmId or levelBgmId
	end

	local currentBgmId = AudioBgmManager.instance:getCurPlayingId()

	if currentBgmId ~= levelBgmId then
		AudioBgmManager.instance:stopBgm(AudioBgmEnum.Layer.ArcadeSurvivorInSide)
	end

	AudioBgmManager.instance:modifyBgm(AudioBgmEnum.Layer.ArcadeSurvivorInSide, levelBgmId, AudioEnum4_1.ArcadeSurvivorBgm.stop_ui_8bit_music)
	AudioBgmManager.instance:playBgm(AudioBgmEnum.Layer.ArcadeSurvivorInSide)

	if bossIdCount > 0 then
		self:refreshBossHpBar()
	end

	gohelper.setActive(self._gobosshpbarroot, bossIdCount > 0)
	gohelper.setActive(self._transFameT, bossIdCount <= 0)
	self:refreshLevelTargetDesc()
	self:refreshScore()
	self._targetAnimatorPlayer:Play("normal", nil, nil)
	self:checkEntityIcon()
	self:_restoreEntityIconFrames()
	self:refreshOutsideMonsterArrows()
end

function ArcadeSurvivorGameView:_tryFindBoss()
	local curLevelId = ArcadeSurvivorGameModel.instance:getCurLevelId()
	local isBossLevel = ArcadeSurvivorConfig.instance:getLevelIsBossLevel(curLevelId)

	if not isBossLevel then
		return
	end

	local aliveBossMOList = ArcadeSurvivorGameModel.instance:getAliveBossMOList()

	if #aliveBossMOList <= 0 then
		return
	end

	local bossIdList = {}
	local bossHpCapDict = {}

	for _, monsterMO in ipairs(aliveBossMOList) do
		local bossId = monsterMO:getId()
		local bossUid = monsterMO:getUid()
		local bossHpCap = monsterMO:getAttrValue(ArcadeSurvivorEnum.Attribute.hpCap)

		bossIdList[#bossIdList + 1] = bossId
		bossHpCapDict[bossUid] = bossHpCap
	end

	self._bossIdList = bossIdList
	self._bossHpCapDict = bossHpCapDict

	self:_refreshBossTotalHpCap()
end

function ArcadeSurvivorGameView:_refreshBossTotalHpCap()
	local bossHpCapDict = self._bossHpCapDict
	local totalHpCap = 0

	if bossHpCapDict then
		for _, bossHpCap in pairs(bossHpCapDict) do
			totalHpCap = totalHpCap + bossHpCap
		end
	end

	self._bossTotalHpCap = totalHpCap
end

function ArcadeSurvivorGameView:playOpening(title, desc, callback, callbackObj)
	self._openingCallback = callback
	self._openingCallbackObj = callbackObj
	self._txtleveltitle.text = title
	self._txtleveldesc.text = desc

	ArcadeSurvivorGameController.instance:pauseGame(ArcadeSurvivorGameEnum.StopSource.Opening)
	GameUtil.setActiveUIBlock(ArcadeSurvivorEnum.BlockKey.Opening, true, false)
	gohelper.setActive(self._opening, true)
	self._openingAnimatorPlayer:Play(UIAnimationName.Open, self._onOpeningShown, self)
	AudioMgr.instance:trigger(AudioEnum4_1.ArcadeSurvivor.play_ui_atlantis_text_prompt)
end

function ArcadeSurvivorGameView:_onOpeningShown()
	TaskDispatcher.runDelay(self._closeOpening, self, 1.2)
end

function ArcadeSurvivorGameView:_closeOpening()
	self._openingAnimatorPlayer:Play(UIAnimationName.Close, self._onOpeningFinished, self)
end

function ArcadeSurvivorGameView:_onOpeningFinished()
	local callback, callbackObj = self._openingCallback, self._openingCallbackObj

	self:_clearOpening()
	GameUtil.handleCallbackFunc(callback, callbackObj)
end

function ArcadeSurvivorGameView:_clearOpening()
	self._openingCallback, self._openingCallbackObj = nil

	TaskDispatcher.cancelTask(self._closeOpening, self)
	self._openingAnimatorPlayer:Stop()
	gohelper.setActive(self._opening, false)
	GameUtil.setActiveUIBlock(ArcadeSurvivorEnum.BlockKey.Opening, false, true)
	ArcadeSurvivorGameController.instance:resumeGame(ArcadeSurvivorGameEnum.StopSource.Opening)
end

function ArcadeSurvivorGameView:_onBattleBegin()
	local bossIdCount = self._bossIdList and #self._bossIdList or 0

	if bossIdCount > 0 then
		self._checkIntroDialogAfterDangerWarning = true

		self:checkDangerWarning()
	else
		self:checkMonsterDialog(ArcadeSurvivorGameEnum.DialogTalkCondition.Intro)
	end
end

function ArcadeSurvivorGameView:checkMonsterDialog(conditionType, monsterMO)
	local monsterMOList

	if monsterMO then
		monsterMOList = {
			monsterMO
		}
	else
		monsterMOList = ArcadeSurvivorGameModel.instance:getEntityMOList(ArcadeSurvivorEnum.EntityType.Monster)
	end

	if not monsterMOList or #monsterMOList <= 0 then
		return
	end

	for _, curMonsterMO in ipairs(monsterMOList) do
		local groupId = curMonsterMO:getCanTalkDialogGroupId(conditionType)

		if groupId then
			self._dialogTalkComp:playTalk(groupId)

			return
		end
	end
end

function ArcadeSurvivorGameView:checkDangerWarning()
	TaskDispatcher.cancelTask(self._closeDangerWarning, self)

	local firstBossId = self._bossIdList and self._bossIdList[1]

	if firstBossId then
		GameUtil.setActiveUIBlock(ArcadeSurvivorEnum.BlockKey.DangerWarning, true, false)
		ArcadeSurvivorGameController.instance:setAllEntityVisibility(false)
		ArcadeSurvivorGameController.instance:pauseGame(ArcadeSurvivorGameEnum.StopSource.DangerWarning)

		local icon = ArcadeSurvivorConfig.instance:getMonsterIcon(firstBossId)
		local name = ArcadeSurvivorConfig.instance:getMonsterName(firstBossId)
		local desc = ArcadeSurvivorConfig.instance:getMonsterDesc(firstBossId)

		self._simagedangericon:LoadImage(ResUrl.getArcadeSurvivorIcon(icon), self.setDangerIconNativeSize, self)

		self._txtdangername.text = name
		self._txtdangerdesc.text = desc

		gohelper.setActive(self._godangerwarning, true)
		AudioMgr.instance:trigger(AudioEnum3_7.Arcade.play_ui_beiai_boss_dengchang)

		local warningKeepTime = ArcadeSurvivorConfig.instance:getConst(ArcadeSurvivorEnum.ConstId.DangerWarningKeepTime, true)

		TaskDispatcher.runDelay(self._closeDangerWarning, self, warningKeepTime)
	else
		self:_closeDangerWarning()
	end
end

function ArcadeSurvivorGameView:setDangerIconNativeSize()
	self._imagedangericon:SetNativeSize()
end

function ArcadeSurvivorGameView:_onRoundBegin()
	local bossIdCount = self._bossIdList and #self._bossIdList or 0

	if not self._haveSwitchedTarget and bossIdCount <= 0 then
		self:refreshLevelTargetDesc(true)

		local remainRound = ArcadeSurvivorGameModel.instance:getRemainRound()

		if remainRound <= 0 then
			self:onTargetFinish()
		end
	end
end

function ArcadeSurvivorGameView:_onPlayerTurnStart()
	local index = self._timeFrameBgIndex
	local frameName = string.format(ArcadeSurvivorEnum.Const.TimeFrameBg, index)

	UISpriteSetMgr.instance:setArcadeSurvivorSprite(self._imageFrameT, frameName)
	UISpriteSetMgr.instance:setArcadeSurvivorSprite(self._imageFrameB, frameName)
	UISpriteSetMgr.instance:setArcadeSurvivorSprite(self._imageFrameL, frameName)
	UISpriteSetMgr.instance:setArcadeSurvivorSprite(self._imageFrameR, frameName)

	self._timeFrameBgIndex = index % ArcadeSurvivorGameEnum.Const.TimeFrameBgCount + 1

	self._timeFrameAnimator:Play("pulse", 0, 0)

	local bossIdCount = self._bossIdList and #self._bossIdList or 0

	if bossIdCount > 0 then
		self._bossHpBarAnimator:Play("pulse", 0, 0)
	end
end

function ArcadeSurvivorGameView:_onPlayerTurnUpdate(passTime, turnTime)
	if not passTime or not turnTime then
		return
	end

	local progress = 0

	if turnTime > 0 then
		progress = GameUtil.clamp((turnTime - passTime) / turnTime, 0, 1)
	end

	self:_setTimeFrameProgress(progress)
end

function ArcadeSurvivorGameView:_setTimeFrameProgress(progress)
	transformhelper.setLocalScale(self._transFrameMaskT, progress, 1, 1)
	transformhelper.setLocalScale(self._transFrameMaskB, progress, 1, 1)
	transformhelper.setLocalScale(self._transFrameMaskL, progress, 1, 1)
	transformhelper.setLocalScale(self._transFrameMaskR, progress, 1, 1)
end

function ArcadeSurvivorGameView:_onSelectEvent(newSelectEventId)
	self:setEventItems(newSelectEventId)
end

function ArcadeSurvivorGameView:_onEntityMove(mo)
	if not mo then
		return
	end

	local entityType = mo:getEntityType()
	local uid = mo:getUid()
	local usedIcon = self:getUsedIcon(entityType, uid)

	if usedIcon then
		usedIcon:refreshPos()
	end

	if entityType == self._selectedEntityType and uid == self._selectedUid then
		self:refreshSelectedFrame()
	end

	self:refreshOutsideMonsterArrows()
end

function ArcadeSurvivorGameView:_onEntityTweenMove(entityType, uid, isTween)
	if entityType == self._selectedEntityType and uid == self._selectedUid then
		self:refreshSelectedFrame()

		self._selectedFrameTweenMoving = isTween
	end
end

function ArcadeSurvivorGameView:_onRefreshEntityIcon(entityType, uid)
	local usedIcon = self:getUsedIcon(entityType, uid)

	if usedIcon then
		usedIcon:refresh()

		if self._bossFocusHideIconFrame then
			usedIcon:setFrameShow(false)
		end
	end
end

function ArcadeSurvivorGameView:_onSceneFocusChange()
	self:refreshSelectedFrame()
	self:refreshOutsideMonsterArrows()
end

function ArcadeSurvivorGameView:_onBossFocusStart()
	self._bossFocusHideIconFrame = true

	local usedIconDict = self._usedIconDict

	if not usedIconDict then
		return
	end

	for _, iconDict in pairs(usedIconDict) do
		for _, iconComp in pairs(iconDict) do
			iconComp:setFrameShow(false)
		end
	end
end

function ArcadeSurvivorGameView:_onHpChange(mo, changeVal, floatVal, critCount)
	if not mo then
		return
	end

	local entityType = mo:getEntityType()
	local uid = mo:getUid()
	local gridX, gridY = mo:getGridPos()
	local value = floatVal or changeVal

	self:addFightFloatData(entityType, uid, gridX, gridY, value, critCount)

	if entityType == ArcadeSurvivorEnum.EntityType.Character then
		self:refreshHp()
	elseif entityType == ArcadeSurvivorEnum.EntityType.Monster then
		if changeVal < 0 then
			self:checkMonsterDialog(ArcadeSurvivorGameEnum.DialogTalkCondition.Hp, mo)
		end

		if mo:getMonsterType() == ArcadeSurvivorEnum.MonsterType.Boss then
			self:refreshBossHpBar()
		end
	end
end

function ArcadeSurvivorGameView:_onEntityAttrChange(entityType, uid, attrId)
	if not attrId then
		return
	end

	if entityType == ArcadeSurvivorEnum.EntityType.Monster then
		if attrId == ArcadeSurvivorEnum.Attribute.hpCap then
			self:_updateBossHpCap(uid)
		end
	elseif entityType == ArcadeSurvivorEnum.EntityType.Character then
		if attrId == ArcadeSurvivorEnum.Attribute.hpCap then
			self:refreshHpCap()
			self:refreshAttr()
		elseif attrId == ArcadeSurvivorEnum.Attribute.hp then
			self:refreshHp()
		elseif self._attrItemDict and self._attrItemDict[attrId] then
			self:refreshAttr()
		end
	end
end

function ArcadeSurvivorGameView:_onEntityChangeAttrDict(entityType, uid, changedAttrDict)
	if not changedAttrDict then
		return
	end

	if entityType == ArcadeSurvivorEnum.EntityType.Monster then
		if changedAttrDict and changedAttrDict[ArcadeSurvivorEnum.Attribute.hpCap] then
			self:_updateBossHpCap(uid)
		end
	elseif entityType == ArcadeSurvivorEnum.EntityType.Character then
		local needRefreshArr = false

		if changedAttrDict[ArcadeSurvivorEnum.Attribute.hpCap] then
			self:refreshHpCap()

			needRefreshArr = true
		elseif changedAttrDict[ArcadeSurvivorEnum.Attribute.hp] then
			self:refreshHp()
		end

		if not needRefreshArr then
			for attrId, _ in pairs(self._attrItemDict) do
				if changedAttrDict[attrId] then
					needRefreshArr = true

					break
				end
			end
		end

		if needRefreshArr then
			self:refreshAttr()
		end
	end
end

function ArcadeSurvivorGameView:_updateBossHpCap(uid)
	local bossHpCapDict = self._bossHpCapDict

	if not bossHpCapDict or bossHpCapDict[uid] == nil then
		return
	end

	local monsterMO = ArcadeSurvivorGameModel.instance:getEntityMO(ArcadeSurvivorEnum.EntityType.Monster, uid)

	if not monsterMO then
		return
	end

	local bossHpCap = monsterMO:getAttrValue(ArcadeSurvivorEnum.Attribute.hpCap)

	bossHpCapDict[uid] = bossHpCap

	self:_refreshBossTotalHpCap()
	self:refreshBossHpBar()
end

function ArcadeSurvivorGameView:_onCollectionChange()
	local lossCollection = false
	local characterMO = ArcadeSurvivorGameModel.instance:getCharacterMO()

	self._newCollectionList = {}

	local collectionIdDict = {}
	local collectionIdList = characterMO and characterMO:getCollectionIdList()

	if collectionIdList then
		for _, collectionId in ipairs(collectionIdList) do
			collectionIdDict[collectionId] = true

			if self._collectionItemDict and not self._collectionItemDict[collectionId] then
				self._newCollectionList[#self._newCollectionList + 1] = collectionId
			end
		end
	end

	if self._collectionItemDict then
		for id, collectionItem in pairs(self._collectionItemDict) do
			if not collectionIdDict[id] then
				collectionItem.animator:Play("out", 0, 0)

				lossCollection = true
			end
		end
	end

	if lossCollection then
		TaskDispatcher.cancelTask(self.setCollections, self)
		TaskDispatcher.runDelay(self.setCollections, self, 0.167)
	else
		self:setCollections()
	end
end

function ArcadeSurvivorGameView:_onCollectionSkillTrigger(collectionId)
	if not collectionId then
		return
	end

	local triggerGO
	local characterMO = ArcadeSurvivorGameModel.instance:getCharacterMO()
	local characterId = characterMO and characterMO:getId()
	local weaponId = ArcadeSurvivorConfig.instance:getCharacterWeaponCollectionId(characterId)

	if collectionId == weaponId then
		triggerGO = self._goweapontrigger
	else
		local collectionItem = self._collectionItemDict and self._collectionItemDict[collectionId]

		triggerGO = collectionItem and collectionItem.gotrigger
	end

	if not triggerGO then
		return
	end

	gohelper.setActive(triggerGO, false)
	gohelper.setActive(triggerGO, true)
end

function ArcadeSurvivorGameView:_onCurrencyChange(currencyId, changeNum, gainPos)
	if currencyId ~= ArcadeSurvivorEnum.Currency.Coin then
		return
	end

	if changeNum <= 0 or not gainPos then
		return
	end

	local rectPosX, rectPosY = recthelper.worldPosToAnchorPosXYZ(gainPos.x, gainPos.y, gainPos.z, self._transFlyContent)

	self:playEffectFlying(rectPosX, rectPosY, self._currencyPosV2)
end

function ArcadeSurvivorGameView:_onScoreChange()
	self:refreshScore(true)
end

function ArcadeSurvivorGameView:_onPlayUIEffect(effectId, needPlayAudio)
	local uiEffName = ArcadeSurvivorConfig.instance:getShowUIEffect(effectId)

	if string.nilorempty(uiEffName) or gohelper.isNil(self._uiEffectDict[uiEffName]) then
		return
	end

	local uiEffect = self._uiEffectDict[uiEffName]

	gohelper.setActive(uiEffect, false)
	gohelper.setActive(uiEffect, true)

	if needPlayAudio then
		local audioId = ArcadeSurvivorConfig.instance:getShowAudio(effectId)

		if audioId and audioId > 0 then
			AudioMgr.instance:trigger(audioId)
		end
	end
end

function ArcadeSurvivorGameView:_onOpenView(viewName, viewParam)
	self:_onOverlayViewOpened(viewName, viewParam)

	if viewName == ViewName.ArcadeSurvivorEventSelectView or viewName == ViewName.ArcadeSurvivorShopView then
		gohelper.setActive(self._btnbattlefield, true)
		gohelper.setActive(self._gojoystick, false)
		gohelper.setActive(self._goback, false)
	end
end

function ArcadeSurvivorGameView:_onCloseView(viewName)
	if viewName == ViewName.ArcadeSurvivorEventSelectView or viewName == ViewName.ArcadeSurvivorShopView then
		gohelper.setActive(self._btnbattlefield, false)
		gohelper.setActive(self._gojoystick, true)
		gohelper.setActive(self._goback, true)
	end
end

function ArcadeSurvivorGameView:_onOverlayViewOpened(viewName, viewParam)
	if not self._overlayViews or viewName == self.viewName then
		return
	end

	local aboveGame = false

	for _, openViewName in ipairs(ViewMgr.instance:getOpenViewNameList()) do
		if openViewName == viewName then
			break
		end

		if openViewName == self.viewName then
			aboveGame = true
		end
	end

	if not aboveGame then
		return
	end

	local setting = ViewMgr.instance:getSetting(viewName)
	local isOverlay

	if viewName == ViewName.ArcadeSurvivorTipsView then
		isOverlay = viewParam and (viewParam.needMask or viewParam.tipType == ArcadeSurvivorEnum.TipType.Hero and viewParam.originalViewName == self.viewName)
	else
		isOverlay = setting.viewType == ViewType.Modal or setting.viewType == ViewType.Full or setting.bgBlur and setting.bgBlur ~= 0
	end

	if not isOverlay then
		self:_onOverlayViewClosed(viewName)

		return
	end

	local wasEmpty = next(self._overlayViews) == nil

	self._overlayViews[viewName] = true

	if wasEmpty then
		ArcadeSurvivorGameController.instance:pauseGame(ArcadeSurvivorGameEnum.StopSource.ViewOverlay)
	end
end

function ArcadeSurvivorGameView:_onOverlayViewClosed(viewName)
	if not self._overlayViews or not self._overlayViews[viewName] then
		return
	end

	self._overlayViews[viewName] = nil

	if not next(self._overlayViews) then
		local controller = ArcadeSurvivorGameController.instance

		controller:resetPlayerTurnCountdown()
		controller:resumeGame(ArcadeSurvivorGameEnum.StopSource.ViewOverlay)
	end
end

function ArcadeSurvivorGameView:_clearOverlayViews()
	self._overlayViews = nil

	ArcadeSurvivorGameController.instance:resumeGame(ArcadeSurvivorGameEnum.StopSource.ViewOverlay)
end

function ArcadeSurvivorGameView:_initOverlayViews()
	self:_clearOverlayViews()

	self._overlayViews = {}

	for _, viewName in ipairs(ViewMgr.instance:getOpenViewNameList()) do
		local container = ViewMgr.instance:getContainer(viewName)

		self:_onOverlayViewOpened(viewName, container.viewParam)
	end
end

function ArcadeSurvivorGameView:_onScreenResize()
	self:_setCamera()
	self:_setFlayItemEndPos()
end

function ArcadeSurvivorGameView:_setCamera()
	local camera = CameraMgr.instance:getMainCamera()

	camera.orthographic = true

	local scale = GameUtil.getAdapterScale()

	camera.orthographicSize = ArcadeSurvivorEnum.Const.MapCameraSize * scale

	local cameraTrs = CameraMgr.instance:getMainCameraTrs()

	transformhelper.setLocalPos(cameraTrs, 0, 0, 0)
	transformhelper.setLocalRotation(cameraTrs, 0, 0, 0)
end

function ArcadeSurvivorGameView:_setFlayItemEndPos()
	self._currencyPosV2 = Vector2(0, 0)

	local currencyPos = recthelper.rectToRelativeAnchorPos(self._gocurrencyFlyTarget.transform.position, self._transFlyContent)

	self._currencyPosV2:Set(currencyPos.x, currencyPos.y)

	self._collectionPosV2 = Vector2(0, 0)

	local collectionPos = recthelper.rectToRelativeAnchorPos(self._gocollectionFlyTarget.transform.position, self._transFlyContent)

	self._collectionPosV2:Set(collectionPos.x, collectionPos.y)
end

function ArcadeSurvivorGameView:_editableInitView()
	self._openingAnimatorPlayer = SLFramework.AnimatorPlayer.Get(self._opening)
	self._uiEffectDict = self:getUserDataTb_()
	self._topAnimator = gohelper.findChildComponent(self.viewGO, "Top", gohelper.Type_Animator)
	self._targetAnimatorPlayer = SLFramework.AnimatorPlayer.Get(self._goleveltarget)
	self._selectedAnimator = self._goselectedframe:GetComponent(gohelper.Type_Animator)
	self._selectedCanvasGroup = self._goselectedframe:GetComponent(gohelper.Type_CanvasGroup)
	self._bosshpbarrootAnimator = self._gobosshpbarroot:GetComponent(gohelper.Type_Animator)

	local gobosshpbar = gohelper.findChild(self.viewGO, "#go_boss_hpbar/#go_hpbar")

	self._transBossHpBar = gobosshpbar.transform
	self._bossHpBarAnimator = gobosshpbar:GetComponent(gohelper.Type_Animator)

	local goframe = gohelper.findChild(self.viewGO, "frame")

	self._transTimeFrame = goframe.transform
	self._timeFrameAnimator = goframe:GetComponent(gohelper.Type_Animator)

	local goFrameT = gohelper.findChild(self.viewGO, "frame/top")
	local goFrameB = gohelper.findChild(self.viewGO, "frame/bottom")
	local goFrameL = gohelper.findChild(self.viewGO, "frame/left")
	local goFrameR = gohelper.findChild(self.viewGO, "frame/right")

	self._imageFrameT = gohelper.findChildImage(goFrameT, "mask/image_fg")
	self._imageFrameB = gohelper.findChildImage(goFrameB, "mask/image_fg")
	self._imageFrameL = gohelper.findChildImage(goFrameL, "mask/image_fg")
	self._imageFrameR = gohelper.findChildImage(goFrameR, "mask/image_fg")
	self._transFameT = goFrameT.transform
	self._transFameB = goFrameB.transform
	self._transFameL = goFrameL.transform
	self._transFameR = goFrameR.transform
	self._transFrameMaskT = gohelper.findChild(goFrameT, "mask").transform
	self._transFrameMaskB = gohelper.findChild(goFrameB, "mask").transform
	self._transFrameMaskL = gohelper.findChild(goFrameL, "mask").transform
	self._transFrameMaskR = gohelper.findChild(goFrameR, "mask").transform

	local gogame = gohelper.findChild(self.viewGO, "Game")

	self._transgame = gogame.transform

	local goselectedlu = gohelper.findChild(self.viewGO, "Game/#go_selectedframe/leftup")
	local goselectedrd = gohelper.findChild(self.viewGO, "Game/#go_selectedframe/rightdown")

	self._transselectedlu = goselectedlu.transform
	self._transselectedrd = goselectedrd.transform
	self._transselectedframe = self._goselectedframe.transform
	self._iconPool = {}
	self._usedIconDict = {}

	gohelper.setActive(self._goentityicon, false)

	self._transFlyContent = self._goFlyItemContent.transform
	self._transfloatnode = self._gofloatnode.transform

	gohelper.setActive(self._gofloatitem, false)
	gohelper.setActive(self._goselectedframe, true)
	gohelper.setActive(self._btnbattlefield, false)
	gohelper.setActive(self._gobosshpbarroot, false)

	self._scoreAnimator = self._golv:GetComponent(gohelper.Type_Animator)

	gohelper.setActive(self._txtrate, true)
	self:_setFlayItemEndPos()

	self.flyEffectItemList = self:getUserDataTb_()

	local flyEffectInitCount = 6

	for _ = 1, flyEffectInitCount do
		self:createFlyEffect()
	end

	gohelper.setActive(self._goFlyItem, false)

	self._outsideMonsterArrowDict = {}

	for _, direction in pairs(ArcadeSurvivorEnum.Direction) do
		local arrowGO = gohelper.findChild(self.viewGO, string.format("Game/#go_arrows/%s", direction))

		gohelper.setActive(arrowGO, false)

		self._outsideMonsterArrowDict[direction] = arrowGO
	end

	self._dialogTalkComp = MonoHelper.addLuaComOnceToGo(self._godialoguetalk, ArcadeSurvivorDialogueTalkComp)

	MainCameraMgr.instance:addView(self.viewName, self._setCamera, nil, self)

	self._isMobilePlayer = GameUtil.isMobilePlayerAndNotEmulator()

	if not self._isRunning then
		self._isRunning = true

		LateUpdateBeat:Add(self._onLateUpdate, self)
	end
end

function ArcadeSurvivorGameView:_onLateUpdate()
	if self._selectedFrameTweenMoving then
		self:refreshSelectedFrame()
	end

	self:checkDelayShowFightFloat()

	if not self._isMobilePlayer then
		local direction

		if UnityEngineInput.GetKeyDown(UnityEngineKeyCode.D) or UnityEngineInput.GetKeyDown(UnityEngineKeyCode.RightArrow) then
			direction = ArcadeSurvivorDirection.Right
		elseif UnityEngineInput.GetKeyDown(UnityEngineKeyCode.A) or UnityEngineInput.GetKeyDown(UnityEngineKeyCode.LeftArrow) then
			direction = ArcadeSurvivorDirection.Left
		elseif UnityEngineInput.GetKeyDown(UnityEngineKeyCode.W) or UnityEngineInput.GetKeyDown(UnityEngineKeyCode.UpArrow) then
			direction = ArcadeSurvivorDirection.Up
		elseif UnityEngineInput.GetKeyDown(UnityEngineKeyCode.S) or UnityEngineInput.GetKeyDown(UnityEngineKeyCode.DownArrow) then
			direction = ArcadeSurvivorDirection.Down
		end

		if direction then
			local inGuiding = ArcadeGameHelper.checkInGuiding()

			if inGuiding then
				return
			end

			self:_btnDirectionOnClick(direction)
		end
	end
end

function ArcadeSurvivorGameView:onUpdateParam()
	return
end

function ArcadeSurvivorGameView:onOpen()
	self:_initOverlayViews()

	self._timeFrameBgIndex = 1
	self._haveSwitchedTarget = false

	local characterMO = ArcadeSurvivorGameModel.instance:getCharacterMO()
	local characterId = characterMO and characterMO:getId()
	local characterIcon = ArcadeSurvivorConfig.instance:getCharacterPortrait(characterId)
	local characterIconPath = ResUrl.getArcadeSurvivorIcon(characterIcon)

	self._simageheroicon:LoadImage(characterIconPath, self.onLoadCharacterIconFinished, self)

	local weaponId = ArcadeSurvivorConfig.instance:getCharacterWeaponCollectionId(characterId)
	local icon = ArcadeSurvivorConfig.instance:getCollectionIcon(weaponId)
	local iconPath = ResUrl.getArcadeSurvivorIcon(icon)

	self._simageweaponicon:LoadImage(iconPath)

	self._attrItemDict = {}

	local showAttrList = {
		ArcadeSurvivorEnum.Attribute.atk,
		ArcadeSurvivorEnum.Attribute.dodgeRate,
		ArcadeSurvivorEnum.Attribute.respawnTimes
	}

	gohelper.CreateObjList(self, self._onCreateAttrItem, showAttrList, self._gobase, self._gobaseItem)
	gohelper.setActive(self._opening, false)
	self:refresh()
	self:checkEntityIcon()
end

function ArcadeSurvivorGameView:onLoadCharacterIconFinished()
	if not self._simageheroicon then
		return
	end

	self._simageheroicon.gameObject:GetComponent(gohelper.Type_Image):SetNativeSize()

	local characterMO = ArcadeSurvivorGameModel.instance:getCharacterMO()
	local characterId = characterMO and characterMO:getId()
	local trans = self._simageheroicon.transform
	local posArr = ArcadeSurvivorConfig.instance:getCharacterPortraitOffset(characterId)
	local posX = posArr and tonumber(posArr[1])
	local posY = posArr and tonumber(posArr[2])

	if posX and posY then
		transformhelper.setLocalPosXY(trans, posX, posY)
	end

	local scaleArr = ArcadeSurvivorConfig.instance:getCharacterPortraitScale(characterId)
	local scaleX = scaleArr and tonumber(scaleArr[1])
	local scaleY = scaleArr and tonumber(scaleArr[2])

	if scaleX and scaleY then
		transformhelper.setLocalScale(trans, scaleX, scaleY, 1)
	end
end

function ArcadeSurvivorGameView:_onCreateAttrItem(obj, data, index)
	local attrItem = self:getUserDataTb_()

	attrItem.id = data
	attrItem.go = obj
	attrItem.txtNum = gohelper.findChildText(obj, "#txt_num")
	attrItem._imagebase = gohelper.findChildImage(obj, "#txt_num/#image_base")

	local icon = ArcadeSurvivorConfig.instance:getAttributeIcon(attrItem.id)

	UISpriteSetMgr.instance:setArcadeSurvivorSprite(attrItem._imagebase, icon)

	self._attrItemDict[attrItem.id] = attrItem
end

function ArcadeSurvivorGameView:refresh()
	self:refreshAttr()
	self:refreshHpCap()
	self:refreshScore()
	self:setCollections()
	self:setEventItems()
	self:checkSelectedEntity()
	self:refreshLevelTargetDesc()
	self:refreshOutsideMonsterArrows()
	self._targetAnimatorPlayer:Play("normal", nil, nil)
end

function ArcadeSurvivorGameView:refreshScore(isPlay)
	self:killScoreProgressTween()

	local curScore = ArcadeSurvivorGameModel.instance:getCurLevelScore()

	if curScore < 0 then
		curScore = 0
	end

	local curGradeNeedScore = ArcadeSurvivorConfig.instance:getCurGradeNeedScore(curScore)
	local nextGradeNeedScore = ArcadeSurvivorConfig.instance:getNextGradeNeedScore(curScore)
	local progress = 1

	if curGradeNeedScore and nextGradeNeedScore and curGradeNeedScore < nextGradeNeedScore then
		local overScore = curScore - curGradeNeedScore
		local scoreStep = nextGradeNeedScore - curGradeNeedScore

		progress = GameUtil.clamp(overScore / scoreStep, 0, 1)
	end

	local icon = ArcadeSurvivorConfig.instance:getGradeIcon(curScore)

	if icon then
		UISpriteSetMgr.instance:setV3a3EliminateSprite(self._imagelv, icon)
		UISpriteSetMgr.instance:setV3a3EliminateSprite(self._imagelvBG, icon)
	end

	local tweenBegin, tweenEnd
	local curLevel = ArcadeSurvivorConfig.instance:getGradeLevel(curScore)

	if isPlay and self._curLevel then
		local audioId, scoreLevelAnimName

		if curLevel ~= self._curLevel then
			if curLevel > self._curLevel then
				tweenBegin = 0
				scoreLevelAnimName = "lvup"
				audioId = AudioEnum3_3.Arcade.play_ui_yuanzheng_rate
			else
				tweenBegin = 1
			end

			gohelper.setActive(self._txtrate, false)
			gohelper.setActive(self._txtrate, true)
		else
			if progress > self._curProgress then
				scoreLevelAnimName = "add"
			end

			tweenBegin = self._curProgress
		end

		tweenEnd = progress

		if not string.nilorempty(scoreLevelAnimName) then
			self._scoreAnimator:Play(scoreLevelAnimName, 0, 0)

			if audioId then
				AudioMgr.instance:trigger(audioId)
			end
		end
	end

	if tweenBegin and tweenEnd and tweenBegin ~= tweenEnd then
		self._scoreProgressTweenId = ZProj.TweenHelper.DOTweenFloat(tweenBegin, tweenEnd, 0.5, self._onTweenScoreProgress, nil, self, nil, EaseType.OutQuart)
	else
		self._imagelv.fillAmount = progress
	end

	self._curLevel = curLevel
	self._curProgress = progress

	local gainRate = ArcadeSurvivorConfig.instance:getGradeAddCoinRate(curScore)

	self._txtrate.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("add_percent_value"), gainRate / 10)
end

function ArcadeSurvivorGameView:killScoreProgressTween()
	if self._scoreProgressTweenId then
		ZProj.TweenHelper.KillById(self._scoreProgressTweenId)

		self._scoreProgressTweenId = nil
	end
end

function ArcadeSurvivorGameView:_onTweenScoreProgress(value)
	if self._imagelv then
		self._imagelv.fillAmount = value
	end
end

function ArcadeSurvivorGameView:refreshLevelTargetDesc(keepZeroRoundDesc)
	local desc
	local curLevelId = ArcadeSurvivorGameModel.instance:getCurLevelId()

	if curLevelId then
		local isBossLevel = ArcadeSurvivorConfig.instance:getLevelIsBossLevel(curLevelId)

		if isBossLevel then
			local bossNameList = {}

			if self._bossIdList then
				for _, bossId in ipairs(self._bossIdList) do
					local bossName = ArcadeSurvivorConfig.instance:getMonsterName(bossId)

					bossNameList[#bossNameList + 1] = bossName
				end
			end

			local strBossNames = table.concat(bossNameList, luaLang("comma_sep"))

			desc = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("v4a1_arcade_survivor_target_3"), strBossNames)
		else
			local remainRound = ArcadeSurvivorGameModel.instance:getRemainRound()

			if remainRound > 0 or keepZeroRoundDesc then
				desc = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("v4a1_arcade_survivor_target_1"), remainRound)
			else
				desc = luaLang("v4a1_arcade_survivor_target_2")
			end
		end
	end

	self._txtleveltarget.text = desc or ""
end

function ArcadeSurvivorGameView:onTargetFinish()
	local curLevelId = ArcadeSurvivorGameModel.instance:getCurLevelId()
	local isBossLevel = ArcadeSurvivorConfig.instance:getLevelIsBossLevel(curLevelId)

	if not isBossLevel and not self._haveSwitchedTarget then
		self._haveSwitchedTarget = true

		self._targetAnimatorPlayer:Play("finish", self._switchLevelTarget, self)
	else
		self._targetAnimatorPlayer:Play("finish", nil, nil)
	end

	AudioMgr.instance:trigger(AudioEnum4_1.ArcadeSurvivor.play_ui_yuanzheng_item_get)
end

function ArcadeSurvivorGameView:_switchLevelTarget()
	self._targetAnimatorPlayer:Play("switch", nil, nil)
	self:refreshLevelTargetDesc()
	self:refreshOutsideMonsterArrows()
end

function ArcadeSurvivorGameView:refreshBossHpBar()
	local bossIdCount = self._bossIdList and #self._bossIdList or 0

	if bossIdCount <= 0 then
		return
	end

	local totalHp = 0
	local totalHpCap = self._bossTotalHpCap or 0
	local bossMOList = ArcadeSurvivorGameModel.instance:getAliveBossMOList()

	for _, monsterMO in ipairs(bossMOList) do
		totalHp = totalHp + monsterMO:getHp()
	end

	local newAmount = 0
	local oldAmount = self._imagebosshpfb.fillAmount

	if totalHpCap > 0 then
		newAmount = totalHp / totalHpCap
	end

	self._txtbosshp.text = string.format("%s/%s", totalHp, totalHpCap)
	self._imagebosshpfb.fillAmount = newAmount

	if newAmount < oldAmount then
		local info = self._bosshpbarrootAnimator:GetCurrentAnimatorStateInfo(0)

		if info and info:IsName("shake") and info.normalizedTime < 1 then
			return
		end

		self._bosshpbarrootAnimator:Play("shake", 0, 0)
	end
end

function ArcadeSurvivorGameView:refreshAttr()
	if not self._attrItemDict then
		return
	end

	local characterMO = ArcadeSurvivorGameModel.instance:getCharacterMO()

	for attrId, attrItem in pairs(self._attrItemDict) do
		local value = characterMO and characterMO:getAttrValue(attrId) or 0

		attrItem.txtNum.text = ArcadeSurvivorHelper.getAttributeShowValue(attrId, value)
	end
end

function ArcadeSurvivorGameView:refreshHpCap()
	self._characterHpItemList = {}

	local characterMO = ArcadeSurvivorGameModel.instance:getCharacterMO()
	local hpCap = characterMO and characterMO:getAttrValue(ArcadeSurvivorEnum.Attribute.hpCap) or 0
	local maxShowCount = ArcadeSurvivorConfig.instance:getConst(ArcadeSurvivorEnum.ConstId.MaxShowHpCount, true)
	local showHpCount = math.min(hpCap, maxShowCount)

	gohelper.CreateNumObjList(self._gohpbar, self._gohpitem, showHpCount, self._onCreateHpItem, self)
	self:refreshHp()
end

function ArcadeSurvivorGameView:_onCreateHpItem(obj, index)
	local hpItem = self:getUserDataTb_()

	hpItem.go = obj
	hpItem.golight = gohelper.findChild(hpItem.go, "light")
	hpItem.imagehp = gohelper.findChildImage(hpItem.go, "light")
	self._characterHpItemList[index] = hpItem
end

function ArcadeSurvivorGameView:refreshHp()
	if not self._characterHpItemList then
		return
	end

	local characterMO = ArcadeSurvivorGameModel.instance:getCharacterMO()
	local curHp = characterMO and characterMO:getHp() or 0
	local showHpCount = #self._characterHpItemList

	for i, hpItem in ipairs(self._characterHpItemList) do
		local heartIcon = ArcadeSurvivorGameHelper.getHeartIconName(curHp, showHpCount, i)

		if heartIcon then
			UISpriteSetMgr.instance:setArcadeSurvivorSprite(hpItem.imagehp, heartIcon)
			gohelper.setActive(hpItem.golight, true)
		else
			gohelper.setActive(hpItem.golight, false)
		end
	end

	local hpCap = characterMO and characterMO:getAttrValue(ArcadeSurvivorEnum.Attribute.hpCap) or 0

	self._txthpnum.text = string.format("%s/%s", curHp, hpCap)
end

function ArcadeSurvivorGameView:setCollections()
	self:_clearCollectionItems()

	local collectionIdList = {}
	local characterMO = ArcadeSurvivorGameModel.instance:getCharacterMO()

	if characterMO then
		collectionIdList = characterMO:getCollectionIdList()
	end

	gohelper.CreateObjList(self, self._onCreateCollectionItem, collectionIdList, self._gocollection, self._gocollectionitem)
	self:_checkNewCollection()
end

function ArcadeSurvivorGameView:_onCreateCollectionItem(obj, data, _)
	local collectionItem = self:getUserDataTb_()

	collectionItem.id = data
	collectionItem.go = obj
	collectionItem.animator = gohelper.findComponentAnim(collectionItem.go)
	collectionItem.gotrigger = gohelper.findChild(collectionItem.go, "#go_trigger")
	collectionItem.simageIcon = gohelper.findChildSingleImage(obj, "#image_icon")

	local icon = ArcadeSurvivorConfig.instance:getCollectionIcon(collectionItem.id)
	local iconPath = ResUrl.getArcadeSurvivorIcon(icon)

	collectionItem.simageIcon:LoadImage(iconPath)

	collectionItem.txtNum = gohelper.findChildText(obj, "#txt_num")

	local rarity = ArcadeSurvivorConfig.instance:getCollectionRarity(collectionItem.id)
	local displayRarity = ArcadeSurvivorHelper.getCollectionDisplayRarity(rarity)
	local itembg = string.format(ArcadeSurvivorEnum.Const.CollectionRareBg, displayRarity)
	local bg = gohelper.findChildImage(collectionItem.go, "bg")

	UISpriteSetMgr.instance:setArcadeSurvivorSprite(bg, itembg)

	local characterMO = ArcadeSurvivorGameModel.instance:getCharacterMO()
	local count = characterMO and characterMO:getCollectionCount(data) or 0

	collectionItem.txtNum.text = count

	collectionItem.animator:Play("idle", 0, 0)

	self._collectionItemDict[data] = collectionItem
end

function ArcadeSurvivorGameView:_checkNewCollection()
	if self._newCollectionList and self._collectionItemDict then
		for _, id in ipairs(self._newCollectionList) do
			local item = self._collectionItemDict[id]

			if item then
				item.animator:Play("in", 0, 0)
			end
		end
	end

	self._newCollectionList = nil
end

function ArcadeSurvivorGameView:setEventItems(newSelectEventId)
	self._tmpNewSelectEventId = newSelectEventId

	self:_clearEventItems()

	local eventIdList = ArcadeSurvivorGameModel.instance:getEventIdList()

	gohelper.CreateObjList(self, self._onCreateEventItem, eventIdList, self._goeventlist, self._goeventitem)

	self._tmpNewSelectEventId = nil
end

function ArcadeSurvivorGameView:_onCreateEventItem(obj, data, index)
	local eventItem = self:getUserDataTb_()

	eventItem.eventId = data
	eventItem.go = obj
	eventItem.txtdesc = gohelper.findChildText(obj, "#txt")
	eventItem.txtdesc.text = ArcadeSurvivorConfig.instance:getEventTitle(eventItem.eventId)
	eventItem.simageicon = gohelper.findChildSingleImage(obj, "mask/simage_icon")
	eventItem.animator = obj:GetComponent(gohelper.Type_Animator)
	eventItem.btnclick = ArcadeSurvivorGameHelper.getArcadeSurvivorClickListener(obj, "#btn_click")

	self:addClickCb(eventItem.btnclick, self._btneventItemOnClick, self, index)

	local isNewSelect = self._tmpNewSelectEventId and self._tmpNewSelectEventId == eventItem.eventId

	eventItem.animator:Play(UIAnimationName.Open, 0, isNewSelect and 0 or 1)

	local icon = ArcadeSurvivorConfig.instance:getEventPopupImage(eventItem.eventId)

	if not string.nilorempty(icon) then
		local iconPath = ResUrl.getArcadeSurvivorIcon(icon)

		eventItem.simageicon:LoadImage(iconPath)
	end

	self._eventItemList[index] = eventItem
end

function ArcadeSurvivorGameView:checkSelectedEntity()
	if not self._selectedEntityType or not self._selectedUid then
		self._selectedAnimator:Play(UIAnimationName.Close, 0, 1)

		return
	end

	local scene = ArcadeSurvivorGameController.instance:getGameScene()
	local entity = scene and scene.entityMgr:getEntity(self._selectedEntityType, self._selectedUid)

	if not entity then
		self:changeSelectedFrame()
	end
end

function ArcadeSurvivorGameView:changeSelectedFrame(entityType, uid, immediately)
	if self._selectedEntityType == entityType and self._selectedUid == uid then
		return
	end

	local newSelectedEntityType, newSelectedUid, sizeX, sizeY, entity
	local viewScale = 1
	local scene = ArcadeSurvivorGameController.instance:getGameScene()

	if scene then
		entity = scene.entityMgr:getEntity(entityType, uid)
		viewScale = scene:getViewScale()
	end

	local selectedMO
	local mo = entity and entity:getMO()
	local isInView = ArcadeSurvivorGameModel.instance:isEntityMOInView(mo, true)

	if isInView then
		if entityType == ArcadeSurvivorEnum.EntityType.Monster then
			local monsterType = mo:getMonsterType()

			if monsterType ~= ArcadeSurvivorEnum.MonsterType.Boss then
				selectedMO = mo
			end
		elseif entityType ~= ArcadeSurvivorEnum.EntityType.Character then
			selectedMO = mo
		end
	end

	if selectedMO then
		newSelectedEntityType = entityType
		newSelectedUid = uid
		sizeX, sizeY = selectedMO:getSize()
	end

	if sizeX and sizeY then
		local uiGridSize = ArcadeSurvivorConfig.instance:getGameBaseUIGridSize() * viewScale
		local halfUIGridSize = uiGridSize / 2

		transformhelper.setLocalPosXY(self._transselectedlu, -halfUIGridSize, (sizeY - 0.5) * uiGridSize)
		transformhelper.setLocalPosXY(self._transselectedrd, (sizeX - 0.5) * uiGridSize, -halfUIGridSize)
	end

	local animName

	if self._selectedEntityType ~= newSelectedEntityType or self._selectedUid ~= newSelectedUid then
		if newSelectedEntityType and newSelectedUid then
			animName = UIAnimationName.Open
			self._selectedCanvasGroup.alpha = 0
		else
			animName = UIAnimationName.Close
		end
	end

	if animName then
		self._selectedAnimator:Play(animName, 0, immediately and 1 or 0)
	end

	self._selectedFrameTweenMoving = entity and entity:isTweenMoving()
	self._selectedEntityType = newSelectedEntityType
	self._selectedUid = newSelectedUid

	self:refreshSelectedFrame()
end

function ArcadeSurvivorGameView:refreshSelectedFrame()
	if not self._selectedEntityType or not self._selectedUid then
		return
	end

	local scene = ArcadeSurvivorGameController.instance:getGameScene()

	if not scene then
		return
	end

	local entity = scene.entityMgr:getEntity(self._selectedEntityType, self._selectedUid)
	local isInView = false

	if entity then
		local x, y, z = entity:getPosition()
		local rectPosX, rectPosY = recthelper.worldPosToAnchorPosXYZ(x, y, z, self._transgame)

		recthelper.setAnchor(self._transselectedframe, rectPosX, rectPosY)

		local mo = entity:getMO()

		isInView = ArcadeSurvivorGameModel.instance:isEntityMOInView(mo, true)
	end

	if not isInView then
		self:changeSelectedFrame(nil, nil, true)
	end
end

function ArcadeSurvivorGameView:refreshOutsideMonsterArrows()
	if not self._outsideMonsterArrowDict then
		return
	end

	for _, arrowGO in pairs(self._outsideMonsterArrowDict) do
		gohelper.setActive(arrowGO, false)
	end

	local curLevelId = ArcadeSurvivorGameModel.instance:getCurLevelId()
	local isBossLevel = curLevelId and ArcadeSurvivorConfig.instance:getLevelIsBossLevel(curLevelId)

	if isBossLevel then
		return
	end

	local remainRound = ArcadeSurvivorGameModel.instance:getRemainRound()

	if remainRound > 0 then
		return
	end

	local monsterMOList = ArcadeSurvivorGameModel.instance:getEntityMOList(ArcadeSurvivorEnum.EntityType.Monster)

	if not monsterMOList or #monsterMOList <= 0 then
		return
	end

	for _, monsterMO in ipairs(monsterMOList) do
		local monsterType = monsterMO:getMonsterType()

		if monsterType ~= ArcadeSurvivorEnum.MonsterType.Neutral then
			local direction = ArcadeSurvivorGameModel.instance:getOutsideMonsterArrowDirection(monsterMO)

			if direction then
				gohelper.setActive(self._outsideMonsterArrowDict[direction], true)
			end
		end
	end
end

function ArcadeSurvivorGameView:checkEntityIcon()
	local iconEntityTypeList = ArcadeSurvivorGameEnum.IconEntityTypes

	for _, entityType in ipairs(iconEntityTypeList) do
		local moList = ArcadeSurvivorGameModel.instance:getEntityMOList(entityType)

		if moList then
			for _, mo in ipairs(moList) do
				if entityType == ArcadeSurvivorEnum.EntityType.Monster then
					local monsterType = mo:getMonsterType()
					local isBoss = monsterType == ArcadeSurvivorEnum.MonsterType.Boss

					if isBoss then
						self:addIcon2Entity(mo)
					end
				else
					self:addIcon2Entity(mo)
				end
			end
		end
	end
end

function ArcadeSurvivorGameView:_restoreEntityIconFrames()
	self._bossFocusHideIconFrame = false

	local usedIconDict = self._usedIconDict

	if not usedIconDict then
		return
	end

	for _, iconDict in pairs(usedIconDict) do
		for _, iconComp in pairs(iconDict) do
			iconComp:refreshFrame()
		end
	end
end

function ArcadeSurvivorGameView:addIcon2Entity(mo)
	if not mo then
		return
	end

	local entityType = mo:getEntityType()
	local uid = mo:getUid()
	local usedIcon = self:getUsedIcon(entityType, uid)

	if usedIcon then
		usedIcon:refreshPos()

		return
	end

	local id = mo:getId()
	local entityTypeDict = self._usedIconDict[entityType]

	if not entityTypeDict then
		entityTypeDict = {}
		self._usedIconDict[entityType] = entityTypeDict
	end

	local iconComp = self:getEntityIcon()

	iconComp:setEntity(entityType, uid, id)

	if self._bossFocusHideIconFrame then
		iconComp:setFrameShow(false)
	end

	entityTypeDict[uid] = iconComp
end

function ArcadeSurvivorGameView:getEntityIcon()
	if next(self._iconPool) then
		return table.remove(self._iconPool)
	end

	local goIcon = gohelper.clone(self._goentityicon, self._goiconnode)
	local iconComp = MonoHelper.addLuaComOnceToGo(goIcon, ArcadeSurvivorGameEntityIcon)

	return iconComp
end

function ArcadeSurvivorGameView:recycleIcon(entityType, uid)
	local iconComp = self:getUsedIcon(entityType, uid)

	if not iconComp then
		return
	end

	iconComp:reset()

	local iconPool = self._iconPool

	iconPool[#iconPool + 1] = iconComp
	self._usedIconDict[entityType][uid] = nil
end

function ArcadeSurvivorGameView:recycleAllIcon()
	if not self._usedIconDict then
		return
	end

	for entityType, entityTypeDict in pairs(self._usedIconDict) do
		for _, iconComp in pairs(entityTypeDict) do
			iconComp:reset()

			local iconPool = self._iconPool

			iconPool[#iconPool + 1] = iconComp
		end

		self._usedIconDict[entityType] = nil
	end
end

function ArcadeSurvivorGameView:getUsedIcon(entityType, uid)
	if not self._usedIconDict or not entityType or not uid then
		return
	end

	local entityTypeDict = self._usedIconDict[entityType]

	return entityTypeDict and entityTypeDict[uid]
end

function ArcadeSurvivorGameView:addFightFloatData(entityType, uid, gridX, gridY, value, critCount)
	if not entityType or entityType == ArcadeSurvivorEnum.EntityType.Ally or not uid or not gridX or not gridY or not value then
		return
	end

	if not self._fightFloatDataDict then
		self._fightFloatDataDict = {}
	end

	local gridId = ArcadeSurvivorGameHelper.getGridId(gridX, gridY)
	local data = self._fightFloatDataDict[gridId]

	critCount = critCount or 0

	if data then
		data.val = data.val + value
		data.critCount = math.max(data.critCount, critCount)
		data.entityType = entityType
		data.uid = uid
	else
		self._fightFloatDataDict[gridId] = {
			beginTime = Time.time,
			entityType = entityType,
			uid = uid,
			gridX = gridX,
			gridY = gridY,
			val = value,
			critCount = critCount
		}
	end
end

function ArcadeSurvivorGameView:checkDelayShowFightFloat()
	local fightFloatDataDict = self._fightFloatDataDict

	if not fightFloatDataDict then
		return
	end

	local showGirdIdList = self._showFightFloatGridIdList

	if not showGirdIdList then
		showGirdIdList = {}
		self._showFightFloatGridIdList = showGirdIdList
	end

	local curTime = Time.time
	local delayTime = ArcadeSurvivorGameEnum.Const.FightFloatWaitTime
	local showCount = 0

	for gridId, fightFloatData in pairs(fightFloatDataDict) do
		if delayTime <= curTime - fightFloatData.beginTime then
			local entityType = fightFloatData.entityType
			local uid = fightFloatData.uid
			local gridX = fightFloatData.gridX
			local gridY = fightFloatData.gridY
			local value = fightFloatData.val

			self:showFightFloat(entityType, uid, gridX, gridY, value, fightFloatData.critCount)

			showCount = showCount + 1
			showGirdIdList[showCount] = gridId
		end
	end

	for index = 1, showCount do
		fightFloatDataDict[showGirdIdList[index]] = nil
		showGirdIdList[index] = nil
	end
end

function ArcadeSurvivorGameView:showFightFloat(entityType, uid, gridX, gridY, value, critCount)
	if not entityType or not uid or not gridX or not gridY or not value or value == 0 then
		return
	end

	local floatItem = self:getFightFloatItem(gridX, gridY)
	local scene = ArcadeSurvivorGameController.instance:getGameScene()
	local entityMgr = scene and scene.entityMgr
	local entity = entityMgr and entityMgr:getEntity(entityType, uid)
	local posX, posY, posZ

	if entity then
		posX, posY, posZ = entity:getPosition()
	else
		posX, posY, posZ = ArcadeSurvivorGameHelper.grid2Position(gridX, gridY, true)
	end

	local rectPosX, rectPosY = recthelper.worldPosToAnchorPosXYZ(posX, posY, posZ, self._transfloatnode)

	recthelper.setAnchor(floatItem.go.transform, rectPosX, rectPosY)

	local scale = 1

	if value < 0 then
		local thresholds = ArcadeSurvivorConfig.instance:getConstArray(ArcadeSurvivorEnum.ConstId.FightFloatDamageThresholds, true, "#")
		local damage = math.abs(value)

		if damage >= thresholds[3] then
			scale = 1.6
		elseif damage >= thresholds[2] then
			scale = 1.3
		end
	end

	transformhelper.setLocalScale(floatItem.txtval.transform, floatItem.baseScaleX * scale, floatItem.baseScaleY * scale, floatItem.baseScaleZ)
	SLFramework.UGUI.GuiHelper.SetColor(floatItem.txtval, value >= 0 and "#00FF68" or "#E34F38")

	floatItem.txtval.text = math.abs(value)

	if value < 0 and critCount and critCount > 0 then
		floatItem.txtval.text = math.abs(value) .. string.rep("！", critCount)
	end

	gohelper.setActive(floatItem.go, false)
	gohelper.setActive(floatItem.go, true)
end

function ArcadeSurvivorGameView:getFightFloatItem(gridX, gridY)
	if not self._floatItemDict then
		self._floatItemDict = {}
	end

	local gridId = ArcadeSurvivorGameHelper.getGridId(gridX, gridY)
	local floatItem = self._floatItemDict[gridId]

	if not floatItem then
		floatItem = self:getUserDataTb_()
		floatItem.go = gohelper.clone(self._gofloatitem, self._gofloatnode)
		floatItem.txtval = gohelper.findChildText(floatItem.go, "x/txtNum")
		floatItem.baseScaleX, floatItem.baseScaleY, floatItem.baseScaleZ = transformhelper.getLocalScale(floatItem.txtval.transform)
		self._floatItemDict[gridId] = floatItem
	end

	return floatItem
end

function ArcadeSurvivorGameView:playEffectFlying(starPosX, starPosY, endPosV2)
	local flyEffectItem = self:getFlyEffectItem()

	gohelper.setActive(flyEffectItem.go, true)
	flyEffectItem.comp:SetOneFlyItemDoneCallback(self.onFlyDone, self)
	flyEffectItem.comp:SetOneFlyItemDoneAndRecycleDoneCallback(self.onFlyRecycle, self, flyEffectItem)

	flyEffectItem.comp.startPosition = Vector2(starPosX, starPosY)
	flyEffectItem.comp.endPosition = endPosV2

	gohelper.setActive(flyEffectItem.compGO, true)
	flyEffectItem.comp:StartFlying()
end

function ArcadeSurvivorGameView:getFlyEffectItem()
	for i = 1, #self.flyEffectItemList do
		if not self.flyEffectItemList[i].isActive then
			self.flyEffectItemList[i].isActive = true

			return self.flyEffectItemList[i]
		end
	end

	self:createFlyEffect()

	return self.flyEffectItemList[#self.flyEffectItemList]
end

function ArcadeSurvivorGameView:createFlyEffect()
	local flyEffectItem = {}

	flyEffectItem.go = gohelper.clone(self._goFlyItem, self._goFlyItemContent)
	flyEffectItem.compGO = gohelper.findChild(flyEffectItem.go, "#fly")
	flyEffectItem.comp = flyEffectItem.compGO:GetComponent(typeof(UnityEngine.UI.UIFlying))
	flyEffectItem.flyGO = gohelper.findChild(flyEffectItem.go, "fly_item")
	flyEffectItem.isActive = false

	flyEffectItem.comp:SetFlyItemObj(flyEffectItem.flyGO)
	table.insert(self.flyEffectItemList, flyEffectItem)
end

function ArcadeSurvivorGameView:recycleFlyEffectItem(flyEffectItem)
	flyEffectItem.isActive = false

	gohelper.setActive(flyEffectItem.go, false)
	gohelper.setActive(flyEffectItem.compGO, false)
end

function ArcadeSurvivorGameView:recycleAllFlyEffectItem()
	for i = 1, #self.flyEffectItemList do
		self.flyEffectItemList[i].isActive = false

		gohelper.setActive(self.flyEffectItemList[i].compGO, false)
		gohelper.setActive(self.flyEffectItemList[i].go, false)
	end
end

function ArcadeSurvivorGameView:onFlyDone()
	AudioMgr.instance:trigger(AudioEnum3_3.Arcade.play_ui_yuanzheng_item_get)
end

function ArcadeSurvivorGameView:onFlyRecycle(flyEffectItem)
	self:recycleFlyEffectItem(flyEffectItem)
end

function ArcadeSurvivorGameView:onClose()
	self:_clearOpening()
	self:_clearOverlayViews()
	self:killScoreProgressTween()

	self._checkIntroDialogAfterDangerWarning = false
	self._newCollectionList = nil
	self._fightFloatDataDict = nil
	self._showFightFloatGridIdList = nil
	self._tmpNewSelectEventId = nil
	self._selectedEntityType = nil
	self._selectedUid = nil

	TaskDispatcher.cancelTask(self._playExcessiveOverTime, self)
	self:_closeDangerWarning()
	TaskDispatcher.cancelTask(self.setCollections, self)
	self:recycleAllFlyEffectItem()

	if self._isRunning then
		self._isRunning = false

		LateUpdateBeat:Remove(self._onLateUpdate, self)
	end

	self._selectedFrameTweenMoving = false

	self:recycleAllIcon()
	self:_closeTipView()
end

function ArcadeSurvivorGameView:_closeDangerWarning()
	GameUtil.setActiveUIBlock(ArcadeSurvivorEnum.BlockKey.DangerWarning, false, true)
	TaskDispatcher.cancelTask(self._closeDangerWarning, self)
	ArcadeSurvivorGameController.instance:setAllEntityVisibility(true)
	ArcadeSurvivorGameController.instance:resumeGame(ArcadeSurvivorGameEnum.StopSource.DangerWarning)
	gohelper.setActive(self._godangerwarning, false)

	if self._checkIntroDialogAfterDangerWarning then
		self._checkIntroDialogAfterDangerWarning = false

		self:checkMonsterDialog(ArcadeSurvivorGameEnum.DialogTalkCondition.Intro)
	end
end

function ArcadeSurvivorGameView:_closeTipView(immediatelyCloseFrame)
	ArcadeSurvivorController.instance:closeTipView()
	self:changeSelectedFrame(nil, nil, immediatelyCloseFrame)
end

function ArcadeSurvivorGameView:_clearCollectionItems()
	if self._collectionItemDict then
		for _, collectionItem in pairs(self._collectionItemDict) do
			collectionItem.simageIcon:UnLoadImage()
		end
	end

	self._collectionItemDict = {}
end

function ArcadeSurvivorGameView:_clearEventItems()
	if self._eventItemList then
		for _, eventItem in ipairs(self._eventItemList) do
			eventItem.simageicon:UnLoadImage()
			self:removeClickCb(eventItem.btnclick)
		end
	end

	self._eventItemList = {}
end

function ArcadeSurvivorGameView:onDestroyView()
	self:_clearOverlayViews()
	self._simageheroicon:UnLoadImage()
	self._simageweaponicon:UnLoadImage()
	self._simagedangericon:UnLoadImage()
	self:_clearCollectionItems()
	self:_clearEventItems()
	ArcadeSurvivorGameController.instance:onGameViewDestroy()
end

return ArcadeSurvivorGameView
