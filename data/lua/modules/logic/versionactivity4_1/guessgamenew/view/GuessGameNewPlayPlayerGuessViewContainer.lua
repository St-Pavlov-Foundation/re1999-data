-- chunkname: @modules/logic/versionactivity4_1/guessgamenew/view/GuessGameNewPlayPlayerGuessViewContainer.lua

module("modules.logic.versionactivity4_1.guessgamenew.view.GuessGameNewPlayPlayerGuessViewContainer", package.seeall)

local GuessGameNewPlayPlayerGuessViewContainer = class("GuessGameNewPlayPlayerGuessViewContainer", BaseViewContainer)

function GuessGameNewPlayPlayerGuessViewContainer:buildViews()
	local views = {
		TabViewGroup.New(1, "#go_lefttop"),
		TabViewGroup.New(2, "#go_righttop"),
		TabViewGroup.New(3, "#go_roles"),
		GuessGameNewPlayPlayerGuessView.New()
	}

	return views
end

function GuessGameNewPlayPlayerGuessViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateButtonView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		self.navigateButtonView:setCloseCheck(self.closeCallback, self)

		return {
			self.navigateButtonView
		}
	elseif tabContainerId == 2 then
		return {
			GuessGameNewPlayTaskTipView.New()
		}
	elseif tabContainerId == 3 then
		return {
			GuessGameNewPlayPlayerGuessRolesView.New()
		}
	end
end

function GuessGameNewPlayPlayerGuessViewContainer:closeCallback()
	GameFacade.showMessageBox(MessageBoxIdDefine.GuessGameExitGame, MsgBoxEnum.BoxType.Yes_No, self.onClickYes, nil, nil, self, nil)
end

function GuessGameNewPlayPlayerGuessViewContainer:onClickYes()
	GuessGameNewController.instance:exitGame()
end

return GuessGameNewPlayPlayerGuessViewContainer
