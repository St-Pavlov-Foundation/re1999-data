module("modules.logic.fight.fightcomponent.FightTweenComponent", package.seeall)

slot0 = class("FightTweenComponent", FightBaseClass)

function slot0.onConstructor(slot0)
	slot0.TweenHelper = ZProj.TweenHelper
	slot0.index = 0
	slot0.tweenList = {}
end

function slot0.DOTweenFloat(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7, slot8)
	slot0.index = slot0.index + 1
	slot0.tweenList[slot0.index] = slot0.TweenHelper.DOTweenFloat(slot1, slot2, slot3, slot4, slot5, slot6, slot7, EaseType.Str2Type(slot8))
end

function slot0.DOAnchorPos(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7, slot8)
	slot0.index = slot0.index + 1
	slot0.tweenList[slot0.index] = slot0.TweenHelper.DOAnchorPos(slot1, slot2, slot3, slot4, slot5, slot6, slot7, EaseType.Str2Type(slot8))
end

function slot0.DOAnchorPosX(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7)
	slot0.index = slot0.index + 1
	slot0.tweenList[slot0.index] = slot0.TweenHelper.DOAnchorPosX(slot1, slot2, slot3, slot4, slot5, slot6, EaseType.Str2Type(slot7))
end

function slot0.DOAnchorPosY(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7)
	slot0.index = slot0.index + 1
	slot0.tweenList[slot0.index] = slot0.TweenHelper.DOAnchorPosY(slot1, slot2, slot3, slot4, slot5, slot6, EaseType.Str2Type(slot7))
end

function slot0.DOWidth(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7)
	slot0.index = slot0.index + 1
	slot0.tweenList[slot0.index] = slot0.TweenHelper.DOWidth(slot1, slot2, slot3, slot4, slot5, slot6, EaseType.Str2Type(slot7))
end

function slot0.DOHeight(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7)
	slot0.index = slot0.index + 1
	slot0.tweenList[slot0.index] = slot0.TweenHelper.DOHeight(slot1, slot2, slot3, slot4, slot5, slot6, EaseType.Str2Type(slot7))
end

function slot0.DOSizeDelta(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7, slot8)
	slot0.index = slot0.index + 1
	slot0.tweenList[slot0.index] = slot0.TweenHelper.DOSizeDelta(slot1, slot2, slot3, slot4, slot5, slot6, slot7, EaseType.Str2Type(slot8))
end

function slot0.DOMove(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7, slot8, slot9)
	slot0.index = slot0.index + 1
	slot0.tweenList[slot0.index] = slot0.TweenHelper.DOMove(slot1, slot2, slot3, slot4, slot5, slot6, slot7, slot8, EaseType.Str2Type(slot9))
end

function slot0.DOMoveX(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7)
	slot0.index = slot0.index + 1
	slot0.tweenList[slot0.index] = slot0.TweenHelper.DOMoveX(slot1, slot2, slot3, slot4, slot5, slot6, EaseType.Str2Type(slot7))
end

function slot0.DOMoveY(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7)
	slot0.index = slot0.index + 1
	slot0.tweenList[slot0.index] = slot0.TweenHelper.DOMoveY(slot1, slot2, slot3, slot4, slot5, slot6, EaseType.Str2Type(slot7))
end

function slot0.DOLocalMove(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7, slot8, slot9)
	slot0.index = slot0.index + 1
	slot0.tweenList[slot0.index] = slot0.TweenHelper.DOLocalMove(slot1, slot2, slot3, slot4, slot5, slot6, slot7, slot8, EaseType.Str2Type(slot9))
end

function slot0.DOLocalMoveX(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7)
	slot0.index = slot0.index + 1
	slot0.tweenList[slot0.index] = slot0.TweenHelper.DOLocalMoveX(slot1, slot2, slot3, slot4, slot5, slot6, EaseType.Str2Type(slot7))
end

function slot0.DOLocalMoveY(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7)
	slot0.index = slot0.index + 1
	slot0.tweenList[slot0.index] = slot0.TweenHelper.DOLocalMoveY(slot1, slot2, slot3, slot4, slot5, slot6, EaseType.Str2Type(slot7))
end

function slot0.DOScale(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7, slot8, slot9)
	slot0.index = slot0.index + 1
	slot0.tweenList[slot0.index] = slot0.TweenHelper.DOScale(slot1, slot2, slot3, slot4, slot5, slot6, slot7, slot8, EaseType.Str2Type(slot9))
end

function slot0.DORotate(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7, slot8, slot9)
	slot0.index = slot0.index + 1
	slot0.tweenList[slot0.index] = slot0.TweenHelper.DORotate(slot1, slot2, slot3, slot4, slot5, slot6, slot7, slot8, EaseType.Str2Type(slot9))
end

function slot0.DOLocalRotate(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7, slot8, slot9)
	slot0.index = slot0.index + 1
	slot0.tweenList[slot0.index] = slot0.TweenHelper.DOLocalRotate(slot1, slot2, slot3, slot4, slot5, slot6, slot7, slot8, EaseType.Str2Type(slot9))
end

function slot0.DoFade(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7, slot8)
	slot0.index = slot0.index + 1
	slot0.tweenList[slot0.index] = slot0.TweenHelper.DoFade(slot1, slot2, slot3, slot4, slot5, slot6, slot7, EaseType.Str2Type(slot8))
end

function slot0.DOColor(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7)
	slot0.index = slot0.index + 1
	slot0.tweenList[slot0.index] = slot0.TweenHelper.DOColor(slot1, slot2, slot3, slot4, slot5, slot6, EaseType.Str2Type(slot7))
end

function slot0.DOText(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7)
	slot0.index = slot0.index + 1
	slot0.tweenList[slot0.index] = slot0.TweenHelper.DOText(slot1, slot2, slot3, slot4, slot5, slot6, EaseType.Str2Type(slot7))
end

function slot0.DOFadeCanvasGroup(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7, slot8)
	slot0.index = slot0.index + 1
	slot0.tweenList[slot0.index] = slot0.TweenHelper.DOFadeCanvasGroup(slot1, slot2, slot3, slot4, slot5, slot6, slot7, EaseType.Str2Type(slot8))
end

function slot0.DOFillAmount(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7)
	slot0.index = slot0.index + 1
	slot0.tweenList[slot0.index] = slot0.TweenHelper.DOFillAmount(slot1, slot2, slot3, slot4, slot5, slot6, EaseType.Str2Type(slot7))
end

function slot0.scrollNumTween(slot0, slot1, slot2, slot3, slot4, slot5)
	slot5 = EaseType.Str2Type(slot5)
	slot6 = slot1:GetInstanceID()

	if not slot0.scrollNumtweenList then
		slot0.scrollNumtweenList = {}
	end

	slot0:killTween(slot0.scrollNumtweenList[slot6])

	slot7 = slot0:DOTweenFloat(slot2, slot3, slot4, slot0.onScrollNumFrame, nil, slot0, slot1, slot5)
	slot0.scrollNumtweenList[slot6] = slot7

	return slot7
end

function slot0.onScrollNumFrame(slot0, slot1, slot2)
	slot2.text = math.ceil(slot1)
end

function slot0.killTween(slot0, slot1)
	if not slot1 then
		return
	end

	return slot0.TweenHelper.KillById(slot1)
end

function slot0.KillTweenByObj(slot0, slot1, slot2)
	return slot0.TweenHelper.KillByObj(slot1, slot2)
end

function slot0.onDestructor(slot0)
	for slot4 = 1, slot0.index do
		slot0.TweenHelper.KillById(slot0.tweenList[slot4])
	end
end

return slot0
