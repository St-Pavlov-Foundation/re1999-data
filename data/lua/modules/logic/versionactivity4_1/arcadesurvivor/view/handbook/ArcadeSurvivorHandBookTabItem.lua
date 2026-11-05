-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/view/handbook/ArcadeSurvivorHandBookTabItem.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.view.handbook.ArcadeSurvivorHandBookTabItem", package.seeall)

local ArcadeSurvivorHandBookTabItem = class("ArcadeSurvivorHandBookTabItem", ListScrollCellExtend)

function ArcadeSurvivorHandBookTabItem:onInitView()
	self._goselect = gohelper.findChild(self.viewGO, "#go_select")
	self._goreddot = gohelper.findChild(self.viewGO, "#go_reddot")
	self._btntab = ArcadeSurvivorGameHelper.getArcadeSurvivorButton(self.viewGO, "#btn_tab")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ArcadeSurvivorHandBookTabItem:addEvents()
	self._btntab:AddClickListener(self._btntabOnClick, self)
end

function ArcadeSurvivorHandBookTabItem:removeEvents()
	self._btntab:RemoveClickListener()
end

function ArcadeSurvivorHandBookTabItem:_btntabOnClick()
	local tab, Id = ArcadeSurvivorHandBookModel.instance:getShowCategoryType()

	if tab == self.type then
		return
	end

	ArcadeSurvivorHandBookModel.instance:setShowCategoryType(self.type)
	ArcadeSurvivorController.instance:dispatchEvent(ArcadeSurvivorEvent.OnCutHandBookTab, self.type)
end

function ArcadeSurvivorHandBookTabItem:_editableInitView()
	return
end

function ArcadeSurvivorHandBookTabItem:_editableAddEvents()
	return
end

function ArcadeSurvivorHandBookTabItem:_editableRemoveEvents()
	return
end

function ArcadeSurvivorHandBookTabItem:onUpdateMO(mo)
	self.type = mo

	self:refreshReddot()
end

function ArcadeSurvivorHandBookTabItem:refreshReddot()
	local hasReddot = ArcadeSurvivorHandBookModel.instance:hasReddotByType(self.type)

	gohelper.setActive(self._goreddot, hasReddot)
end

function ArcadeSurvivorHandBookTabItem:onSelect(isSelect)
	gohelper.setActive(self._goselect, isSelect)

	if isSelect then
		gohelper.setActive(self._goreddot, false)
	end
end

function ArcadeSurvivorHandBookTabItem:onDestroyView()
	return
end

return ArcadeSurvivorHandBookTabItem
