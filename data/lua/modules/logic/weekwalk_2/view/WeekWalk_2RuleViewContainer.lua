module("modules.logic.weekwalk_2.view.WeekWalk_2RuleViewContainer", package.seeall)

slot0 = class("WeekWalk_2RuleViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		WeekWalk_2RuleView.New()
	}
end

return slot0
