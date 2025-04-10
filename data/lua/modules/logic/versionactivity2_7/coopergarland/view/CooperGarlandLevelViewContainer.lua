module("modules.logic.versionactivity2_7.coopergarland.view.CooperGarlandLevelViewContainer", package.seeall)

slot0 = class("CooperGarlandLevelViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot0._levelView = CooperGarlandLevelView.New()

	table.insert(slot1, slot0._levelView)
	table.insert(slot1, TabViewGroup.New(1, "#go_btns"))

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			slot0.navigateView
		}
	end
end

function slot0.setVisibleInternal(slot0, slot1)
	uv0.super.setVisibleInternal(slot0, slot1)

	slot0._levelView.openAnimComplete = false

	if slot1 then
		slot0:playAnim(UIAnimationName.Open, slot0._playOpenAnimFinish, slot0)
	end
end

function slot0._playOpenAnimFinish(slot0)
	if not slot0._levelView then
		return
	end

	slot0._levelView.openAnimComplete = true

	slot0._levelView:playEpisodeFinishAnim()
end

function slot0.playAnim(slot0, slot1, slot2, slot3)
	slot0.animatorPlayer = SLFramework.AnimatorPlayer.Get(slot0.viewGO)

	if slot0.animatorPlayer then
		slot0.animatorPlayer:Play(slot1, slot2, slot3)
	end
end

return slot0
