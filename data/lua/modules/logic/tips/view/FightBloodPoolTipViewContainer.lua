module("modules.logic.tips.view.FightBloodPoolTipViewContainer", package.seeall)

slot0 = class("FightBloodPoolTipViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		FightBloodPoolTipView.New()
	}
end

return slot0
