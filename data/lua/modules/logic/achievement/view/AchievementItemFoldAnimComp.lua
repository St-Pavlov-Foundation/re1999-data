module("modules.logic.achievement.view.AchievementItemFoldAnimComp", package.seeall)

slot0 = class("AchievementItemFoldAnimComp", LuaCompBase)

function slot0.Get(slot0, slot1)
	slot2 = MonoHelper.addNoUpdateLuaComOnceToGo(slot0, uv0)

	slot2:setFoldRoot(slot1)

	return slot2
end

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0._btnpopup = gohelper.getClickWithDefaultAudio(slot0.go)
	slot0._gooff = gohelper.findChild(slot0.go, "#go_off")
	slot0._goon = gohelper.findChild(slot0.go, "#go_on")
end

function slot0.addEventListeners(slot0)
	slot0._btnpopup:AddClickListener(slot0._btnpopupOnClick, slot0)
	slot0:addEventCb(AchievementMainController.instance, AchievementEvent.OnPlayGroupFadeAnim, slot0._onPlayGroupFadeAnimation, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._btnpopup:RemoveClickListener()
end

function slot0._btnpopupOnClick(slot0)
	AchievementMainController.instance:dispatchEvent(AchievementEvent.OnClickGroupFoldBtn, slot0._mo:getGroupId(), not slot0._mo:getIsFold())
end

function slot0.onDestroy(slot0)
	slot0:killTween()
end

function slot0.setFoldRoot(slot0, slot1)
	slot0._gofoldroot = slot1
end

function slot0.onUpdateMO(slot0, slot1)
	if slot0._mo ~= slot1 then
		slot0:killTween()
	end

	slot0._mo = slot1

	slot0:refreshUI()
end

function slot0._onPlayGroupFadeAnimation(slot0, slot1)
	if not slot1 or slot1.mo ~= slot0._mo then
		return
	end

	slot0._isFold = slot1.isFold

	if not slot0._isFold then
		slot0._mo:setIsFold(slot0._isFold)
	end

	slot0._openAnimTweenId = ZProj.TweenHelper.DOTweenFloat(slot1.orginLineHeight, slot1.targetLineHeight, slot1.duration, slot0._onOpenTweenFrameCallback, slot0._onOpenTweenFinishCallback, slot0, nil)
end

function slot0._onOpenTweenFrameCallback(slot0, slot1)
	slot0._mo:overrideLineHeight(slot1)
	AchievementMainCommonModel.instance:getCurViewExcuteModelInstance():onModelUpdate()
end

function slot0._onOpenTweenFinishCallback(slot0)
	slot0._mo:clearOverrideLineHeight()
	slot0._mo:setIsFold(slot0._isFold)
	AchievementMainCommonModel.instance:getCurViewExcuteModelInstance():onModelUpdate()
end

function slot0.refreshUI(slot0)
	slot1 = slot0._mo:getIsFold()

	gohelper.setActive(slot0._goon, not slot1)
	gohelper.setActive(slot0._gooff, slot1)
	gohelper.setActive(slot0._gofoldroot, not slot1)
end

function slot0.killTween(slot0)
	if slot0._openAnimTweenId then
		ZProj.TweenHelper.KillById(slot0._openAnimTweenId)

		slot0._openAnimTweenId = nil
	end
end

return slot0
