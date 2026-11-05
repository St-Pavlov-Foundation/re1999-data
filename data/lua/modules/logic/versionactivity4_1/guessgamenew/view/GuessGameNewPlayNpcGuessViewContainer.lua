-- chunkname: @modules/logic/versionactivity4_1/guessgamenew/view/GuessGameNewPlayNpcGuessViewContainer.lua

module("modules.logic.versionactivity4_1.guessgamenew.view.GuessGameNewPlayNpcGuessViewContainer", package.seeall)

local GuessGameNewPlayNpcGuessViewContainer = class("GuessGameNewPlayNpcGuessViewContainer", BaseViewContainer)

function GuessGameNewPlayNpcGuessViewContainer:buildViews()
	local views = {
		TabViewGroup.New(1, "#go_lefttop"),
		TabViewGroup.New(2, "#go_righttop"),
		TabViewGroup.New(3, "#go_roles"),
		GuessGameNewPlayNpcGuessView.New()
	}

	return views
end

function GuessGameNewPlayNpcGuessViewContainer:buildTabViews(tabContainerId)
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
			GuessGameNewPlayNpcGuessRolesView.New()
		}
	end
end

function GuessGameNewPlayNpcGuessViewContainer:closeCallback()
	GameFacade.showMessageBox(MessageBoxIdDefine.GuessGameExitGame, MsgBoxEnum.BoxType.Yes_No, self.onClickYes, nil, nil, self, nil)
end

function GuessGameNewPlayNpcGuessViewContainer:onClickYes()
	GuessGameNewController.instance:exitGame()
end

return GuessGameNewPlayNpcGuessViewContainer
