module("modules.logic.versionactivity2_6.dicehero.view.DiceHeroResultViewContainer", package.seeall)

slot0 = class("DiceHeroResultViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		DiceHeroResultView.New()
	}
end

return slot0
