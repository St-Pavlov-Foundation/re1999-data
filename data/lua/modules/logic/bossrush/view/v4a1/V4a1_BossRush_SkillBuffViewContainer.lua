-- chunkname: @modules/logic/bossrush/view/v4a1/V4a1_BossRush_SkillBuffViewContainer.lua

module("modules.logic.bossrush.view.v4a1.V4a1_BossRush_SkillBuffViewContainer", package.seeall)

local V4a1_BossRush_SkillBuffViewContainer = class("V4a1_BossRush_SkillBuffViewContainer", BaseViewContainer)

function V4a1_BossRush_SkillBuffViewContainer:buildViews()
	local views = {}

	table.insert(views, V4a1_BossRush_SkillBuffView.New())

	return views
end

return V4a1_BossRush_SkillBuffViewContainer
