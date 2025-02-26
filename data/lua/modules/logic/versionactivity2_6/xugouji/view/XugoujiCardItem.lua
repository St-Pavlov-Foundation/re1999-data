module("modules.logic.versionactivity2_6.xugouji.view.XugoujiCardItem", package.seeall)

slot0 = class("XugoujiCardItem", ListScrollCellExtend)
slot1 = VersionActivity2_6Enum.ActivityId.Xugouji

function slot0.onInitView(slot0)
	slot0._btn = gohelper.findChildButtonWithAudio(slot0.viewGO, "#image_RoleBG")
	slot0._goLock = gohelper.findChild(slot0.viewGO, "#go_Locked")
	slot0._goRoleBG = gohelper.findChild(slot0.viewGO, "#image_RoleBG")
	slot0._goEnemyBG = gohelper.findChild(slot0.viewGO, "#image_EnemyBG")
	slot0._goCardIcon = gohelper.findChild(slot0.viewGO, "#simage_SkillIcon")
	slot0._imgCardIcon = gohelper.findChildSingleImage(slot0.viewGO, "#simage_SkillIcon")
	slot0._goFlip = gohelper.findChild(slot0.viewGO, "#go_Flip")
	slot0._goSelected = gohelper.findChild(slot0.viewGO, "#go_RoleSelected")
	slot0._txtDebugLog = gohelper.findChildText(slot0.viewGO, "#txt_debuglog")

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
	slot0.canvasGroup = gohelper.onceAddComponent(slot0.viewGO, typeof(UnityEngine.CanvasGroup))
end

function slot0._editableAddEvents(slot0)
	slot0:addEventCb(XugoujiController.instance, XugoujiEvent.OperateCard, slot0._onOperatedCard, slot0)
	slot0:addEventCb(XugoujiController.instance, XugoujiEvent.CardStatusUpdated, slot0._onCardStatusUpdate, slot0)
	slot0:addEventCb(XugoujiController.instance, XugoujiEvent.CardPairStatusUpdated, slot0._onGotCardPair, slot0)
	slot0:addEventCb(XugoujiController.instance, XugoujiEvent.TurnChanged, slot0._onTurnChanged, slot0)
	slot0:addEventCb(XugoujiController.instance, XugoujiEvent.CardEffectStatusUpdated, slot0._onCardEffectStatusUpdate, slot0)
end

function slot0._editableRemoveEvents(slot0)
	slot0:removeEventCb(XugoujiController.instance, XugoujiEvent.OperateCard, slot0._onOperatedCard, slot0)
	slot0:removeEventCb(XugoujiController.instance, XugoujiEvent.CardStatusUpdated, slot0._onCardStatusUpdate, slot0)
	slot0:removeEventCb(XugoujiController.instance, XugoujiEvent.CardPairStatusUpdated, slot0._onGotCardPair, slot0)
	slot0:removeEventCb(XugoujiController.instance, XugoujiEvent.TurnChanged, slot0._onTurnChanged, slot0)
	slot0:removeEventCb(XugoujiController.instance, XugoujiEvent.CardEffectStatusUpdated, slot0._onCardEffectStatusUpdate, slot0)
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
	if slot0._cardInfo.uid == slot1 then
		slot0:hideCard()
	end
end

function slot0._onTurnChanged(slot0)
	slot0:refreshUI()
end

function slot0._onCardEffectStatusUpdate(slot0, slot1)
	if slot0._cardInfo.uid == slot1 then
		slot0:refreshUI()
	end
end

function slot0.onUpdateData(slot0, slot1)
	slot0._cardInfo = slot1
	slot0._seleted = false
	slot0._hide = false

	slot0:refreshUI()
	slot0:refreshCardIcon()
end

function slot0.refreshUI(slot0)
	if not slot0._cardInfo then
		return
	end

	slot1 = Activity188Model.instance:isMyTurn()

	gohelper.setActive(slot0._goRoleBG, slot1)
	gohelper.setActive(slot0._goEnemyBG, not slot1)
	gohelper.setActive(slot0._goSelected, slot0._seleted)

	slot2 = slot0._cardInfo.status == XugoujiEnum.CardStatus.Front
	slot0.canvasGroup.alpha = slot0._cardInfo.status == XugoujiEnum.CardStatus.Disappear and 0.39 or 1

	if slot0._cardInfo.status == XugoujiEnum.CardStatus.Back and slot0._seleted then
		gohelper.setActive(slot0._goSelected, false)
	end

	slot5 = Activity188Model.instance:getCardEffect(slot0._cardInfo.uid)

	gohelper.setActive(slot0._goCardIcon, slot2 or slot4 or slot5 and slot5[XugoujiEnum.CardEffectStatus.Perspective])
	slot0:refreshCardEffect()
	gohelper.setActive(slot0._txtDebugLog.gameObject, XugoujiController.instance:isDebugMode())

	if XugoujiController.instance:isDebugMode() then
		slot8 = Activity188Config.instance:getCardCfg(uv0, slot0._cardInfo.id)
		slot0._txtDebugLog.text = slot0._cardInfo.id
	end
end

function slot0.hideCard(slot0)
	slot0._hide = true
	slot0._seleted = false

	if slot0._cardInfo.status == XugoujiEnum.CardStatus.Disappear then
		ZProj.TweenHelper.DOFadeCanvasGroup(slot0.viewGO, 1, 0.39, 0.3)
	end
end

function slot0.refreshCardIcon(slot0)
	if not slot0._cardInfo then
		return
	end

	if not Activity188Config.instance:getCardCfg(uv0, slot0._cardInfo.id).resource or slot2 == "" then
		return
	end

	slot0._imgCardIcon:LoadImage(slot2)
end

function slot0.refreshCardIconShow(slot0)
end

function slot0.refreshCardEffect(slot0)
	if not slot0._cardInfo then
		return
	end

	if not Activity188Model.instance:getCardEffect(slot0._cardInfo.uid) then
		return
	end

	slot2 = Activity188Model.instance:isMyTurn()

	gohelper.setActive(slot0._goLock, slot1[XugoujiEnum.CardEffectStatus.Lock] or slot1[XugoujiEnum.CardEffectStatus.LockEnemy])
	gohelper.setActive(slot0._goFlip, slot1[XugoujiEnum.CardEffectStatus.Perspective] or slot1[XugoujiEnum.CardEffectStatus.PerspectiveEnemy])
end

function slot0.clearCardEffect(slot0)
	if not slot0._cardInfo then
		return
	end

	gohelper.setActive(slot0._goCardIcon, slot0._cardInfo.status == XugoujiEnum.CardStatus.Front or slot0._cardInfo.status == XugoujiEnum.CardStatus.Disappear)
end

function slot0.onDestroyView(slot0)
	slot0._imgCardIcon:UnLoadImage()
end

return slot0
