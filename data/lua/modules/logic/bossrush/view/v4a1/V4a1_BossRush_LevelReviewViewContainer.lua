-- chunkname: @modules/logic/bossrush/view/v4a1/V4a1_BossRush_LevelReviewViewContainer.lua

module("modules.logic.bossrush.view.v4a1.V4a1_BossRush_LevelReviewViewContainer", package.seeall)

local V4a1_BossRush_LevelReviewViewContainer = class("V4a1_BossRush_LevelReviewViewContainer", BaseViewContainer)

function V4a1_BossRush_LevelReviewViewContainer:buildViews()
	local views = {}

	self._bossRushViewRule = V1a4_BossRushViewRule.New()

	table.insert(views, V4a1_BossRush_LevelReviewView.New())
	table.insert(views, TabViewGroup.New(1, "top_left"))
	table.insert(views, self._bossRushViewRule)

	self._bossRushViewRule.offsetAnchor = {
		-180,
		0
	}

	return views
end

function V4a1_BossRush_LevelReviewViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			self.navigateView
		}
	end
end

function V4a1_BossRush_LevelReviewViewContainer:getBossRushViewRule()
	return self._bossRushViewRule
end

function V4a1_BossRush_LevelReviewViewContainer:diffRootChild(viewGO)
	self:setRootChild(viewGO)

	return true
end

function V4a1_BossRush_LevelReviewViewContainer:setRootChild(viewSelf)
	local root = gohelper.findChild(viewSelf.viewGO, "DetailPanel/Condition")

	viewSelf._goadditionRule = gohelper.findChild(root, "#scroll_ConditionIcons")
	viewSelf._goruletemp = gohelper.findChild(viewSelf._goadditionRule, "#go_ruletemp")
	viewSelf._imagetagicon = gohelper.findChildImage(viewSelf._goruletemp, "#image_tagicon")
	viewSelf._gorulelist = gohelper.findChild(viewSelf._goadditionRule, "Viewport/content")
	viewSelf._btnadditionRuleclick = gohelper.findChildButtonWithAudio(viewSelf._goadditionRule, "#btn_additionRuleclick")
end

return V4a1_BossRush_LevelReviewViewContainer
