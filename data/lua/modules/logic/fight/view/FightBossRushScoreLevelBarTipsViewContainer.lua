-- chunkname: @modules/logic/fight/view/FightBossRushScoreLevelBarTipsViewContainer.lua

module("modules.logic.fight.view.FightBossRushScoreLevelBarTipsViewContainer", package.seeall)

local FightBossRushScoreLevelBarTipsViewContainer = class("FightBossRushScoreLevelBarTipsViewContainer", BaseViewContainer)

function FightBossRushScoreLevelBarTipsViewContainer:buildViews()
	return {
		FightBossRushScoreLevelBarTipsView.New()
	}
end

return FightBossRushScoreLevelBarTipsViewContainer
