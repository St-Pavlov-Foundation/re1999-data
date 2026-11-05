-- chunkname: @modules/logic/versionactivity4_1/act248/view/clue/Act248ClueMainViewContainer.lua

module("modules.logic.versionactivity4_1.act248.view.clue.Act248ClueMainViewContainer", package.seeall)

local Act248ClueMainViewContainer = class("Act248ClueMainViewContainer", BaseViewContainer)

function Act248ClueMainViewContainer:buildViews()
	local views = {}

	self._mainView = Act248ClueMainView.New()

	table.insert(views, self._mainView)
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))
	table.insert(views, TabViewGroup.New(2, "root/left"))
	table.insert(views, TabViewGroup.New(3, "root/middle/clueinfo"))

	return views
end

function Act248ClueMainViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			self.navigateView
		}
	elseif tabContainerId == 2 then
		self._leftView = Act248ClueLeftListView.New()

		return {
			self._leftView
		}
	elseif tabContainerId == 3 then
		self._clueInfo = Act248ClueInfo.New()

		return {
			self._clueInfo
		}
	end
end

function Act248ClueMainViewContainer:showClueInfo(clueId, delayTime)
	if self._selectClueId == clueId then
		return
	end

	self._selectClueId = clueId

	TaskDispatcher.cancelTask(self._refreshClueInfo, self)

	delayTime = delayTime or 0

	if delayTime == 0 then
		self:_refreshClueInfo()
	else
		self._mainView:playAni(Act248Enum.AniName.switch)
		TaskDispatcher.runDelay(self._refreshClueInfo, self, delayTime)
	end
end

function Act248ClueMainViewContainer:_refreshClueInfo()
	self._clueInfo:refreshClue(self._selectClueId)
end

function Act248ClueMainViewContainer:getSelectClueId()
	return self._selectClueId
end

return Act248ClueMainViewContainer
