-- chunkname: @modules/logic/versionactivity4_1/peishita/view/PeiShiTaGameViewContainer.lua

module("modules.logic.versionactivity4_1.peishita.view.PeiShiTaGameViewContainer", package.seeall)

local PeiShiTaGameViewContainer = class("PeiShiTaGameViewContainer", BaseViewContainer)

function PeiShiTaGameViewContainer:buildViews()
	self._mainView = PeiShiTaGameView.New()

	return {
		self._mainView,
		PeiShiTaGameEffectView.New(),
		TabViewGroup.New(1, "#go_topleft")
	}
end

function PeiShiTaGameViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonsView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		self._navigateButtonsView:setOverrideClose(self._overrideClose, self)

		return {
			self._navigateButtonsView
		}
	end
end

function PeiShiTaGameViewContainer:_overrideClose()
	if PeiShiTaGameController.instance:isMoveLocked() then
		return
	end

	PeiShiTaGameController.instance:lockMoveInput(true)
	GameFacade.showMessageBox(MessageBoxIdDefine.Act176PuzzleMazeQuitGame, MsgBoxEnum.BoxType.Yes_No, self._endYesCallback, self._endNoCallback, nil, self, self, nil)
end

function PeiShiTaGameViewContainer:_endYesCallback()
	PeiShiTaGameController.instance:lockMoveInput(false)
	PeiShiTaController.instance:reportGameEnd(StatEnum.Result.Exit)
	self:closeThis()
end

function PeiShiTaGameViewContainer:_endNoCallback()
	PeiShiTaGameController.instance:lockMoveInput(false)
end

function PeiShiTaGameViewContainer:playOpenTransition()
	if ViewMgr.instance:isOpen(ViewName.StoryFrontView) then
		self:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinishCb, self)
	else
		self:_startPlayOpenAnim()
	end
end

function PeiShiTaGameViewContainer:_onCloseViewFinishCb(viewName)
	if viewName ~= ViewName.StoryFrontView then
		return
	end

	self:_startPlayOpenAnim()
end

function PeiShiTaGameViewContainer:_startPlayOpenAnim()
	self:startViewOpenBlock()
	self:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinishCb, self)

	local animatorPlayer = self:__getAnimatorPlayer()

	animatorPlayer:Play("open", self.onPlayOpenTransitionFinish, self)
end

return PeiShiTaGameViewContainer
