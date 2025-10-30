﻿-- chunkname: @modules/logic/survival/view/map/comp/SurvivalFightUIItem.lua

module("modules.logic.survival.view.map.comp.SurvivalFightUIItem", package.seeall)

local SurvivalFightUIItem = class("SurvivalFightUIItem", SurvivalUnitUIItem)

function SurvivalFightUIItem:init(go)
	self._fightArrow = gohelper.findChild(go, "#go_canSkip")

	SurvivalFightUIItem.super.init(self, go)
end

function SurvivalFightUIItem:addEventListeners()
	SurvivalFightUIItem.super.addEventListeners(self)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnAttrUpdate, self.refreshInfo, self)
end

function SurvivalFightUIItem:removeEventListeners()
	SurvivalFightUIItem.super.removeEventListeners(self)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnAttrUpdate, self.refreshInfo, self)
end

function SurvivalFightUIItem:refreshInfo()
	SurvivalFightUIItem.super.refreshInfo(self)

	if self._unitMo.visionVal == 8 then
		gohelper.setActive(self._fightArrow, false)

		return
	end

	gohelper.setActive(self._golevel, true)

	self._txtlevel.text = "LV." .. self._unitMo.co.fightLevel

	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()
	local teamLv = weekInfo:getAttr(SurvivalEnum.AttrType.HeroFightLevel)
	local fightLv = self._unitMo.co.fightLevel

	gohelper.setActive(self._fightArrow, fightLv <= teamLv and self._unitMo.co.skip == 1)
	self:updateIconAndBg()
end

return SurvivalFightUIItem
