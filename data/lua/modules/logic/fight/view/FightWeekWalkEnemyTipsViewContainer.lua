module("modules.logic.fight.view.FightWeekWalkEnemyTipsViewContainer", package.seeall)

slot0 = class("FightWeekWalkEnemyTipsViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		FightWeekWalkEnemyTipsView.New()
	}
end

return slot0
