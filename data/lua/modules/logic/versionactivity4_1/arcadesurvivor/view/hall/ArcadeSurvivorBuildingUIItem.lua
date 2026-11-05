-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/view/hall/ArcadeSurvivorBuildingUIItem.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.view.hall.ArcadeSurvivorBuildingUIItem", package.seeall)

local ArcadeSurvivorBuildingUIItem = class("ArcadeSurvivorBuildingUIItem", ListScrollCellExtend)

function ArcadeSurvivorBuildingUIItem:onInitView()
	self._goui = gohelper.findChild(self.viewGO, "#go_ui")
	self._goinfo = gohelper.findChild(self.viewGO, "#go_ui/#go_info")
	self._txtname = gohelper.findChildText(self.viewGO, "#go_ui/#go_info/#txt_name")
	self._goreddot = gohelper.findChild(self.viewGO, "#go_ui/#go_info/#txt_name/#go_reddot")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ArcadeSurvivorBuildingUIItem:addEvents()
	self:addEventCb(ArcadeSurvivorController.instance, ArcadeSurvivorEvent.OnRefreshHallBuildingReddot, self.refreshReddot, self)
end

function ArcadeSurvivorBuildingUIItem:removeEvents()
	self:removeEventCb(ArcadeSurvivorController.instance, ArcadeSurvivorEvent.OnRefreshHallBuildingReddot, self.refreshReddot, self)
end

function ArcadeSurvivorBuildingUIItem:_editableInitView()
	self._reddotitem = self:getUserDataTb_()

	for i = 1, 2 do
		local go = gohelper.findChild(self._goreddot, "type" .. i)

		self._reddotitem[i] = go
	end

	gohelper.setActive(self._goreddot, true)
end

function ArcadeSurvivorBuildingUIItem:onUpdateMO(mo)
	self.buildingMO = mo

	local cfg = mo:getCfg()

	self._txtname.text = cfg.name

	local color = mo:isUnlock() and "#FFF1DE" or "#B0B0B0"

	self._txtname.color = GameUtil.parseColor(color)

	self:refreshReddot(self.buildingMO:getId())
end

function ArcadeSurvivorBuildingUIItem:refreshReddot(interactiveId)
	if interactiveId ~= self.buildingMO:getId() then
		return
	end

	local type = self.buildingMO:getReddotType()

	for i, item in pairs(self._reddotitem) do
		gohelper.setActive(item, type == i)
	end
end

return ArcadeSurvivorBuildingUIItem
