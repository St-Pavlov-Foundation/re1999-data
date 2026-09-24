-- chunkname: @modules/logic/settings/view/SettingsDelUnusedResViewContainer.lua

module("modules.logic.settings.view.SettingsDelUnusedResViewContainer", package.seeall)

local SettingsDelUnusedResViewContainer = class("SettingsDelUnusedResViewContainer", BaseViewContainer)

function SettingsDelUnusedResViewContainer:buildViews()
	local views = {}
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "view/#scroll_content"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = SettingsDelUnusedResListItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 1430
	scrollParam.cellHeight = 90
	scrollParam.cellSpaceH = 0
	scrollParam.cellSpaceV = 2
	scrollParam.startSpace = 0
	scrollParam.sortMode = ScrollEnum.ScrollSortDown
	self._listScrollModel = ListScrollModel.New()
	self._scrollView = LuaListScrollView.New(self._listScrollModel, scrollParam)

	table.insert(views, self._scrollView)
	table.insert(views, SettingsDelUnusedResView.New())

	return views
end

function SettingsDelUnusedResViewContainer:setListData(data)
	self._listScrollModel:setList(data)
end

function SettingsDelUnusedResViewContainer:selectCell(index)
	self._scrollView:selectCell(index, true)
end

function SettingsDelUnusedResViewContainer:onContainerClickModalMask()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	self:closeThis()
end

return SettingsDelUnusedResViewContainer
