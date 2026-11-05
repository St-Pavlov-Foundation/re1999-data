-- chunkname: @modules/logic/bossrush/view/BossRushEnemyInfoViewContainer.lua

module("modules.logic.bossrush.view.BossRushEnemyInfoViewContainer", package.seeall)

local BossRushEnemyInfoViewContainer = class("BossRushEnemyInfoViewContainer", BaseViewContainer)

function BossRushEnemyInfoViewContainer:buildViews()
	local layoutMo = EnemyInfoLayoutMo.New()
	local enemyInfoMo = EnemyInfoMo.New()
	local views = {
		EnemyInfoEnterView.New(),
		EnemyInfoLayoutView.New(),
		EnemyInfoLeftView.New(),
		BossRushEnemyInfoRightView.New(),
		EnemyInfoTipView.New(),
		TabViewGroup.New(1, "#go_btns")
	}

	for _, view in ipairs(views) do
		view.layoutMo = layoutMo
		view.enemyInfoMo = enemyInfoMo
	end

	return views
end

function BossRushEnemyInfoViewContainer:onContainerInit()
	BossRushEnemyInfoViewContainer.super.onContainerInit(self)

	if self._views then
		for _, item in ipairs(self._views) do
			item.viewParam = self.viewParam
		end
	end
end

function BossRushEnemyInfoViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		return {
			NavigateButtonsView.New({
				true,
				false,
				false
			})
		}
	end
end

return BossRushEnemyInfoViewContainer
