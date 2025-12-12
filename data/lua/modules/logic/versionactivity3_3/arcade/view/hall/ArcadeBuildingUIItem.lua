-- chunkname: @modules/logic/versionactivity3_3/arcade/view/hall/ArcadeBuildingUIItem.lua

module("modules.logic.versionactivity3_3.arcade.view.hall.ArcadeBuildingUIItem", package.seeall)

local ArcadeBuildingUIItem = class("ArcadeBuildingUIItem", ListScrollCellExtend)

function ArcadeBuildingUIItem:onInitView()
	self._goui = gohelper.findChild(self.viewGO, "#go_ui")
	self._goinfo = gohelper.findChild(self.viewGO, "#go_ui/#go_info")
	self._txtname = gohelper.findChildText(self.viewGO, "#go_ui/#go_info/#txt_name")
	self._goreddot = gohelper.findChild(self.viewGO, "#go_ui/#go_info/#txt_name/#go_reddot")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ArcadeBuildingUIItem:addEvents()
	return
end

function ArcadeBuildingUIItem:removeEvents()
	return
end

function ArcadeBuildingUIItem:_editableInitView()
	self._goreddotitem = gohelper.findChild(self._goreddot, "type1")

	gohelper.setActive(self._goreddot, true)
	gohelper.setActive(self._goreddotitem, false)
end

function ArcadeBuildingUIItem:_editableAddEvents()
	self:addEventCb(ArcadeController.instance, ArcadeEvent.OnRefreshHallBuildingReddot, self.refreshReddot, self)
end

function ArcadeBuildingUIItem:_editableRemoveEvents()
	self:removeEventCb(ArcadeController.instance, ArcadeEvent.OnRefreshHallBuildingReddot, self.refreshReddot, self)
end

function ArcadeBuildingUIItem:onUpdateMO(mo)
	self.buildingMo = mo

	local co = mo:getCfg()

	self._txtname.text = co.name

	local color = mo:isUnlock() and "#FFF1DE" or "#B0B0B0"

	self._txtname.color = GameUtil.parseColor(color)

	self:refreshReddot(self.buildingMo:getId())
end

function ArcadeBuildingUIItem:refreshReddot(interactiveId)
	if interactiveId ~= self.buildingMo:getId() then
		return
	end

	local type = self.buildingMo:getReddotType()

	gohelper.setActive(self._goreddotitem, type ~= nil and type ~= ArcadeEnum.ReddotType.None)
end

function ArcadeBuildingUIItem:onSelect(isSelect)
	return
end

function ArcadeBuildingUIItem:onDestroyView()
	return
end

return ArcadeBuildingUIItem
