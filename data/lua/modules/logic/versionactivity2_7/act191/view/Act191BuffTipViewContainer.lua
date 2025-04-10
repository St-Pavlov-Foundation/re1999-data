module("modules.logic.versionactivity2_7.act191.view.Act191BuffTipViewContainer", package.seeall)

slot0 = class("Act191BuffTipViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		Act191BuffTipView.New()
	}
end

function slot0.onContainerClickModalMask(slot0)
	slot0:closeThis()
end

return slot0
