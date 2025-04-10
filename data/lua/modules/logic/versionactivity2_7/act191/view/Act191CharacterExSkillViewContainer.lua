module("modules.logic.versionactivity2_7.act191.view.Act191CharacterExSkillViewContainer", package.seeall)

slot0 = class("Act191CharacterExSkillViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		Act191CharacterExSkillView.New(),
		TabViewGroup.New(1, "#go_topleft")
	}
end

function slot0.buildTabViews(slot0, slot1)
	slot0.navigateView = NavigateButtonsView.New({
		true,
		false,
		false
	})

	return {
		slot0.navigateView
	}
end

function slot0.onContainerOpenFinish(slot0)
	slot0.navigateView:resetCloseBtnAudioId(AudioEnum.UI.Play_ui_mould_close)
	slot0.navigateView:resetHomeBtnAudioId(AudioEnum.UI.Play_ui_mould_close)
end

return slot0
