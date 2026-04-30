-- chunkname: @modules/logic/versionactivity3_7/wmz/view/V3a7_Wmz_GameItem_Point.lua

module("modules.logic.versionactivity3_7.wmz.view.V3a7_Wmz_GameItem_Point", package.seeall)

local V3a7_Wmz_GameItem_Point = class("V3a7_Wmz_GameItem_Point", RougeSimpleItemBase)

function V3a7_Wmz_GameItem_Point:onInitView()
	self._goLight = gohelper.findChild(self.viewGO, "#go_Light")
	self._btnClickPoint = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_ClickPoint")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a7_Wmz_GameItem_Point:addEvents()
	self._btnClickPoint:AddClickListener(self._btnClickPointOnClick, self)
end

function V3a7_Wmz_GameItem_Point:removeEvents()
	self._btnClickPoint:RemoveClickListener()
end

function V3a7_Wmz_GameItem_Point:ctor(...)
	V3a7_Wmz_GameItem_Point.super.ctor(self, ...)
end

function V3a7_Wmz_GameItem_Point:_btnClickPointOnClick()
	local p = self:parent()

	p:onClickPointItem(self)
end

function V3a7_Wmz_GameItem_Point:_editableInitView()
	V3a7_Wmz_GameItem_Point.super._editableInitView(self)
	gohelper.setActive(self._goLight, false)
end

function V3a7_Wmz_GameItem_Point:onDestroyView()
	V3a7_Wmz_GameItem_Point.super.onDestroyView(self)
end

function V3a7_Wmz_GameItem_Point:setData(mo)
	V3a7_Wmz_GameItem_Point.super.setData(self, mo)

	if isDebugBuild then
		self:setName(string.format("%s: %s", self:index(), self:zoneId()))
	end
end

function V3a7_Wmz_GameItem_Point:onSelect(isSelect)
	gohelper.setActive(self._goLight, isSelect)
end

function V3a7_Wmz_GameItem_Point:zoneId()
	return self._mo.id
end

function V3a7_Wmz_GameItem_Point:focusCoordXY()
	return self._mo.focusX, self._mo.focusY
end

function V3a7_Wmz_GameItem_Point:getZoneBgResUrl()
	local bgResName = self._mo.bgResName

	return string.nilorempty(bgResName) and "" or ResUrl.getV3a7WmzGameSingleBg(bgResName)
end

return V3a7_Wmz_GameItem_Point
