module("modules.logic.versionactivity2_6.xugouji.view.XugoujiCardItem", package.seeall)

slot0 = class("XugoujiCardItem", ListScrollCellExtend)
slot1 = VersionActivity2_6Enum.ActivityId.Xugouji
slot2 = "v2a6_xugouji_skillcard_selfback"
slot3 = "v2a6_xugouji_skillcard_enemybackj"

function slot0.onInitView(slot0)
	slot0._btn = gohelper.findChildButtonWithAudio(slot0.viewGO, "#image_RoleBG")
	slot0._goLock = gohelper.findChild(slot0.viewGO, "#go_Locked")
	slot0._goRoleBG = gohelper.findChild(slot0.viewGO, "#image_RoleBG")
	slot0._imageRoleBG = gohelper.findChildImage(slot0.viewGO, "#image_RoleBG")
	slot0._goCardIcon = gohelper.findChild(slot0.viewGO, "#simage_SkillIcon")
	slot0._imgCardIcon = gohelper.findChildImage(slot0.viewGO, "#simage_SkillIcon")
	slot0._goFlip = gohelper.findChild(slot0.viewGO, "#go_Flip")
	slot0._goSelected = gohelper.findChild(slot0.viewGO, "#go_RoleSelected")
	slot0._txtDebugLog = gohelper.findChildText(slot0.viewGO, "#txt_debuglog")
	slot0._animator = ZProj.ProjAnimatorPlayer.Get(slot0.viewGO)
	slot0._goEnemyCardBackLogo = gohelper.findChild(slot0.viewGO, "#image_RoleBG/enemy_logo")
	slot0._enemyCardBackLogoAnimator = ZProj.ProjAnimatorPlayer.Get(slot0._goEnemyCardBackLogo)

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btn:AddClickListener(slot0._clickCard, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btn:RemoveClickListener()
end

function slot0._clickCard(slot0)
	if Activity188Model.instance:getGameState() ~= XugoujiEnum.GameStatus.Operatable then
		return
	end

	if not (slot0._cardInfo.status == XugoujiEnum.CardStatus.Back) then
		return
	end

	XugoujiController.instance:selectCardItem(slot0._cardInfo.uid)
end

function slot0._editableInitView(slot0)
	slot0._flipState = XugoujiEnum.CardStatus.Back
	slot0._perspective = false
	slot0._lockState = false
	slot0._active = false
end

function slot0._editableAddEvents(slot0)
	slot0:addEventCb(XugoujiController.instance, XugoujiEvent.OperateCard, slot0._onOperatedCard, slot0)
	slot0:addEventCb(XugoujiController.instance, XugoujiEvent.CardStatusUpdated, slot0._onCardStatusUpdate, slot0)
	slot0:addEventCb(XugoujiController.instance, XugoujiEvent.CardPairStatusUpdated, slot0._onCardPairStatusUpdated, slot0)
	slot0:addEventCb(XugoujiController.instance, XugoujiEvent.GotActiveCard, slot0._onGotCardPair, slot0)
	slot0:addEventCb(XugoujiController.instance, XugoujiEvent.TurnChanged, slot0._onTurnChanged, slot0)
	slot0:addEventCb(XugoujiController.instance, XugoujiEvent.CardEffectStatusUpdated, slot0._onCardEffectStatusUpdate, slot0)
	slot0:addEventCb(XugoujiController.instance, XugoujiEvent.FilpBackUnActiveCard, slot0._onFilpBackUnActive, slot0)
	slot0:addEventCb(XugoujiController.instance, XugoujiEvent.GotNewCardDisplay, slot0.onUpdateNewCard, slot0)
	slot0:addEventCb(XugoujiController.instance, XugoujiEvent.GameRestartCardDisplay, slot0.onGameRestart, slot0)
end

function slot0._editableRemoveEvents(slot0)
	slot0:removeEventCb(XugoujiController.instance, XugoujiEvent.OperateCard, slot0._onOperatedCard, slot0)
	slot0:removeEventCb(XugoujiController.instance, XugoujiEvent.CardStatusUpdated, slot0._onCardStatusUpdate, slot0)
	slot0:removeEventCb(XugoujiController.instance, XugoujiEvent.CardPairStatusUpdated, slot0._onCardPairStatusUpdated, slot0)
	slot0:removeEventCb(XugoujiController.instance, XugoujiEvent.GotActiveCard, slot0._onGotCardPair, slot0)
	slot0:removeEventCb(XugoujiController.instance, XugoujiEvent.TurnChanged, slot0._onTurnChanged, slot0)
	slot0:removeEventCb(XugoujiController.instance, XugoujiEvent.CardEffectStatusUpdated, slot0._onCardEffectStatusUpdate, slot0)
	slot0:removeEventCb(XugoujiController.instance, XugoujiEvent.FilpBackUnActiveCard, slot0._onFilpBackUnActive, slot0)
	slot0:removeEventCb(XugoujiController.instance, XugoujiEvent.GotNewCardDisplay, slot0.onUpdateNewCard, slot0)
	slot0:removeEventCb(XugoujiController.instance, XugoujiEvent.GameRestartCardDisplay, slot0.onGameRestart, slot0)
end

function slot0._onOperatedCard(slot0, slot1)
	if slot0._cardInfo.uid == slot1 then
		slot0._seleted = true

		gohelper.setActive(slot0._goSelected, slot0._seleted)
	end
end

function slot0._onCardStatusUpdate(slot0, slot1)
	if slot0._cardInfo.uid == slot1 then
		slot0:refreshUI()
	end
end

function slot0._onGotCardPair(slot0, slot1)
	if slot0._cardInfo.uid == slot1[1] or slot0._cardInfo.uid == slot1[2] then
		slot0:playCardGotPairAni()
	end
end

function slot0._onCardPairStatusUpdated(slot0, slot1)
	if slot0._cardInfo.uid == slot1 then
		slot0:playCardGotPairAni()
		slot0:hideCard()
	end
end

function slot0._onTurnChanged(slot0)
	slot0._seleted = false

	gohelper.setActive(slot0._goSelected, false)
	gohelper.setActive(slot0._goEnemyCardBackLogo, true)
	slot0._enemyCardBackLogoAnimator:Play(Activity188Model.instance:isMyTurn() and UIAnimationName.Out or UIAnimationName.In, nil, )

	if not slot0._active and slot0._cardInfo.status == XugoujiEnum.CardStatus.Disappear then
		slot0:playActiveAni()
	end

	if slot0._active or slot0._lockState then
		return
	end

	slot0:refreshUI()
end

function slot0._onCardEffectStatusUpdate(slot0, slot1)
	if slot0._cardInfo.uid == slot1 then
		slot0:refreshUI()
	end
end

function slot0._onFilpBackUnActive(slot0)
	if slot0._flipState == XugoujiEnum.CardStatus.Back then
		return
	end

	slot3 = Activity188Model.instance:isMyTurn()

	gohelper.setActive(slot0._goEnemyCardBackLogo, slot3)
	slot0._enemyCardBackLogoAnimator:Play(slot3 and UIAnimationName.Idle or "idle1", nil, )

	if slot0._cardInfo.status == XugoujiEnum.CardStatus.Back and slot0._flipState ~= slot1 then
		slot0:refreshUI()
	end
end

function slot0.onUpdateNewCard(slot0)
	slot0._animator:Play(UIAnimationName.Close, nil, )
	gohelper.setActive(slot0._goEnemyCardBackLogo, not Activity188Model.instance:isMyTurn())

	slot0._flipState = XugoujiEnum.CardStatus.Back

	Activity188Model.instance:setCardItemStatue(slot0._cardInfo.uid, slot0._flipState)
end

function slot0.onGameRestart(slot0)
	slot0._animator:Play(UIAnimationName.Close, nil, )
	gohelper.setActive(slot0._goEnemyCardBackLogo, false)

	slot0._flipState = XugoujiEnum.CardStatus.Back
end

function slot0.onUpdateData(slot0, slot1)
	slot0._cardInfo = slot1
	slot0._seleted = false
	slot0._hide = false
	slot0._lockState = false
	slot0._perspective = false
	slot0._active = false
	slot0._flipState = XugoujiEnum.CardStatus.Back

	Activity188Model.instance:setCardItemStatue(slot0._cardInfo.uid, slot0._flipState)
end

function slot0.refreshUI(slot0)
	if not slot0._cardInfo then
		return
	end

	if slot0._active then
		return
	end

	gohelper.setActive(slot0._goSelected, slot0._seleted)
	slot0:refreshCardAniShow(slot0._cardInfo)

	slot0._flipState = slot0._cardInfo.status

	Activity188Model.instance:setCardItemStatue(slot0._cardInfo.uid, slot0._flipState)

	slot1 = slot0._cardInfo.status == XugoujiEnum.CardStatus.Front
	slot3 = slot0._cardInfo.status == XugoujiEnum.CardStatus.Disappear

	if slot0._cardInfo.status == XugoujiEnum.CardStatus.Back and slot0._seleted then
		gohelper.setActive(slot0._goSelected, false)
	end

	slot4 = Activity188Model.instance:getCardEffect(slot0._cardInfo.uid)

	gohelper.setActive(slot0._goCardIcon, slot1 or slot3 or slot4 and slot4[XugoujiEnum.CardEffectStatus.Perspective])
	gohelper.setActive(slot0._txtDebugLog.gameObject, XugoujiController.instance:isDebugMode())

	if XugoujiController.instance:isDebugMode() then
		slot7 = Activity188Config.instance:getCardCfg(uv0, slot0._cardInfo.id)
		slot0._txtDebugLog.text = slot0._cardInfo.id
	end
end

function slot0.hideCard(slot0)
	slot0._hide = true
	slot0._seleted = false
end

function slot0.refreshCardIcon(slot0)
	if not slot0._cardInfo then
		return
	end

	if not Activity188Config.instance:getCardCfg(uv0, slot0._cardInfo.id).resource or slot2 == "" then
		return
	end

	UISpriteSetMgr.instance:setXugoujiSprite(slot0._imgCardIcon, slot2)
	UISpriteSetMgr.instance:setXugoujiSprite(slot0._imageRoleBG, uv1)
end

function slot0.refreshCardAniShow(slot0, slot1)
	if slot0._flipState == XugoujiEnum.CardStatus.Back and slot0._cardInfo.status == XugoujiEnum.CardStatus.Front then
		slot0._perspective = false
		slot0._lockState = false

		slot0._animator:Play(UIAnimationName.Open, nil, )
		AudioMgr.instance:trigger(AudioEnum2_6.Xugouji.cardFilp)

		return
	elseif slot0._flipState == XugoujiEnum.CardStatus.Front and slot2 == XugoujiEnum.CardStatus.Back then
		slot0._animator:Play(UIAnimationName.Close, nil, )
		AudioMgr.instance:trigger(AudioEnum2_6.Xugouji.cardClose)

		return
	end

	slot3 = Activity188Model.instance:getCardEffect(slot0._cardInfo.uid)

	if not slot0._perspective and slot3 and slot3[XugoujiEnum.CardEffectStatus.Perspective] and not slot0._perspective then
		slot0._perspective = true

		AudioMgr.instance:trigger(AudioEnum2_6.Xugouji.cardPerspective)
		slot0._animator:Play("perspective_in", nil, )
	elseif slot0._perspective and slot3 and not slot3[XugoujiEnum.CardEffectStatus.Perspective] then
		slot0._perspective = false

		AudioMgr.instance:trigger(AudioEnum2_6.Xugouji.cardPerspectiveEnd)
		slot0._animator:Play("perspective_out", nil, )
	elseif not slot0._lockState and slot3 and slot3[XugoujiEnum.CardEffectStatus.Lock] then
		slot0._lockState = true

		AudioMgr.instance:trigger(AudioEnum2_6.Xugouji.cardLock)
		slot0._animator:Play("lock_in", nil, )
	elseif slot0._lockState and slot3 and not slot3[XugoujiEnum.CardEffectStatus.Lock] then
		slot0._lockState = false

		slot0._animator:Play("lock_out", nil, )
	end
end

function slot0.playCardGotPairAni(slot0)
	slot0._animator:Play(UIAnimationName.Finish, nil, )
end

function slot0.playActiveAni(slot0)
	if slot0._active then
		return
	end

	slot0._active = true

	AudioMgr.instance:trigger(AudioEnum2_6.Xugouji.cardDisappear)
	slot0._animator:Play("active_in", nil, )
end

function slot0.clearCardEffect(slot0)
	if not slot0._cardInfo then
		return
	end

	gohelper.setActive(slot0._goCardIcon, slot0._cardInfo.status == XugoujiEnum.CardStatus.Front or slot0._cardInfo.status == XugoujiEnum.CardStatus.Disappear)
end

function slot0.onDestroyView(slot0)
end

return slot0
