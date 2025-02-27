module("modules.logic.weekwalk_2.view.WeekWalk_2DeepLayerNoticeViewContainer", package.seeall)

slot0 = class("WeekWalk_2DeepLayerNoticeViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		WeekWalk_2DeepLayerNoticeView.New()
	}
end

return slot0
