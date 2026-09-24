-- chunkname: @modules/logic/college/view/role/CollegeRoleDispatchPanelItem.lua

module("modules.logic.college.view.role.CollegeRoleDispatchPanelItem", package.seeall)

local CollegeRoleDispatchPanelItem = class("CollegeRoleDispatchPanelItem", CollegeRoleBasePanelItem)

function CollegeRoleDispatchPanelItem:updateData(mo)
	CollegeRoleDispatchPanelItem.super.updateData(self, mo)

	self._newLocation = self._view._locationMo
end

function CollegeRoleDispatchPanelItem:refreshOtherUI()
	CollegeRoleDispatchPanelItem.super.refreshOtherUI(self)

	local isShowTips = self._isDispatch and self._locationMo ~= self._newLocation

	gohelper.setActive(self._goTips, isShowTips)

	if isShowTips then
		local locationName = self._locationMo.co.name

		self._txtTips.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("college_roledispatch_tips"), locationName)
	end
end

function CollegeRoleDispatchPanelItem:getEntryClass()
	return CollegeRoleDispatchEntryItem
end

return CollegeRoleDispatchPanelItem
