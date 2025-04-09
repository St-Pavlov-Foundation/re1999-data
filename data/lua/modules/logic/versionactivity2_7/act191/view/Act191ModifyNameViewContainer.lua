module("modules.logic.versionactivity2_7.act191.view.Act191ModifyNameViewContainer", package.seeall)

slot0 = class("Act191ModifyNameViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		Act191ModifyNameView.New()
	}
end

function slot0.onContainerClickModalMask(slot0)
	slot0:closeThis()
end

function slot0.playOpenTransition(slot0)
	slot0:onPlayOpenTransitionFinish()
end

return slot0
