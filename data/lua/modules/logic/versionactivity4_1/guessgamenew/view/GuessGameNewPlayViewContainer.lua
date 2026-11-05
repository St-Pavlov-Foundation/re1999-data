-- chunkname: @modules/logic/versionactivity4_1/guessgamenew/view/GuessGameNewPlayViewContainer.lua

module("modules.logic.versionactivity4_1.guessgamenew.view.GuessGameNewPlayViewContainer", package.seeall)

local GuessGameNewPlayViewContainer = class("GuessGameNewPlayViewContainer", BaseViewContainer)

function GuessGameNewPlayViewContainer:buildViews()
	local views = {
		GuessGameNewPlayView.New(),
		TabViewGroup.New(1, "#go_lefttop"),
		TabViewGroup.New(2, "#go_righttop"),
		TabViewGroup.New(3, "#go_role")
	}

	return views
end

function GuessGameNewPlayViewContainer:buildTabViews(tabContainerId)
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
			GuessGameNewPlayRolesView.New()
		}
	end
end

function GuessGameNewPlayViewContainer:closeCallback()
	GameFacade.showMessageBox(MessageBoxIdDefine.GuessGameExitGame, MsgBoxEnum.BoxType.Yes_No, self.onClickYes, nil, nil, self, nil)
end

function GuessGameNewPlayViewContainer:onClickYes()
	GuessGameNewController.instance:exitGame()
end

return GuessGameNewPlayViewContainer
