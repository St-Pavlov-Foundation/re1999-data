-- chunkname: @modules/logic/versionactivity4_1/evelyn/view/EvelynGameViewContainer.lua

module("modules.logic.versionactivity4_1.evelyn.view.EvelynGameViewContainer", package.seeall)

local EvelynGameViewContainer = class("EvelynGameViewContainer", BaseViewContainer)

function EvelynGameViewContainer:buildViews()
	local views = {}

	table.insert(views, EvelynGameView.New())
	table.insert(views, TabViewGroup.New(1, "root/#go_topLeft"))

	return views
end

function EvelynGameViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		self.navigateView:setCloseCheck(self._onCloseCheck, self)

		return {
			self.navigateView
		}
	end
end

function EvelynGameViewContainer:_onCloseCheck(reallyClose)
	local navigateView = self.navigateView

	GameFacade.showMessageBox(MessageBoxIdDefine.V4a1EvelynGameExit, MsgBoxEnum.BoxType.Yes_No, function()
		local gameView = self._views and self._views[1]

		if gameView and not gohelper.isNil(gameView.viewGO) then
			gameView:sendGameStat(StatEnum.EvelynGameResult.Exit)
		end

		if navigateView and not gohelper.isNil(navigateView.viewGO) then
			navigateView:_reallyClose()
		end
	end)

	return false
end

return EvelynGameViewContainer
