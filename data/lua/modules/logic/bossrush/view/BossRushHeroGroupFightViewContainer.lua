-- chunkname: @modules/logic/bossrush/view/BossRushHeroGroupFightViewContainer.lua

module("modules.logic.bossrush.view.BossRushHeroGroupFightViewContainer", package.seeall)

local BossRushHeroGroupFightViewContainer = class("BossRushHeroGroupFightViewContainer", HeroGroupFightViewContainer)

function BossRushHeroGroupFightViewContainer:getFightLevelView()
	return BossRushHeroGroupFightViewLevel.New()
end

return BossRushHeroGroupFightViewContainer
