-- chunkname: @modules/logic/versionactivity4_1/act248/view/decryption/Act248ReportViewContainer.lua

module("modules.logic.versionactivity4_1.act248.view.decryption.Act248ReportViewContainer", package.seeall)

local Act248ReportViewContainer = class("Act248ReportViewContainer", BaseViewContainer)

function Act248ReportViewContainer:buildViews()
	local views = {}
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "root/left/#scroll_RoleList"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = Act248RoleItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.cellWidth = 220
	scrollParam.cellHeight = 220
	self._reportView = Act248ReportView.New()

	table.insert(views, self._reportView)
	table.insert(views, LuaListScrollView.New(Act248ReportRoleListModel.instance, scrollParam))
	table.insert(views, TabViewGroup.New(1, "root/#go_topleft"))

	return views
end

function Act248ReportViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		self.navigateView:setOverrideClose(self._overrideCloseFunc, self)

		return {
			self.navigateView
		}
	end
end

function Act248ReportViewContainer:_overrideCloseFunc()
	self._reportView:_btnCloseOnClick()
end

function Act248ReportViewContainer:getRoleRes()
	return self:getRes(self._viewSetting.otherRes[1])
end

return Act248ReportViewContainer
