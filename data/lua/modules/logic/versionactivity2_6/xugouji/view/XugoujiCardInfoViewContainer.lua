module("modules.logic.versionactivity2_6.xugouji.view.XugoujiCardInfoViewContainer", package.seeall)

slot0 = class("XugoujiCardInfoViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		XugoujiCardInfoView.New()
	}
end

function slot0._overrideClickHome(slot0)
	NavigateButtonsView.homeClick()
end

function slot0.setVisibleInternal(slot0, slot1)
	uv0.super.setVisibleInternal(slot0, slot1)
end

return slot0
