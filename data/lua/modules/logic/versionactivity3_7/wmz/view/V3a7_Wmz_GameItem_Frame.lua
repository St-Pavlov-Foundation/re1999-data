-- chunkname: @modules/logic/versionactivity3_7/wmz/view/V3a7_Wmz_GameItem_Frame.lua

module("modules.logic.versionactivity3_7.wmz.view.V3a7_Wmz_GameItem_Frame", package.seeall)

local V3a7_Wmz_GameItem_Frame = class("V3a7_Wmz_GameItem_Frame", RougeSimpleItemBase)

function V3a7_Wmz_GameItem_Frame:onInitView()
	self._simagekuang = gohelper.findChildSingleImage(self.viewGO, "#simage_kuang")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a7_Wmz_GameItem_Frame:addEvents()
	return
end

function V3a7_Wmz_GameItem_Frame:removeEvents()
	return
end

function V3a7_Wmz_GameItem_Frame:ctor(...)
	V3a7_Wmz_GameItem_Frame.super.ctor(self, ...)
end

function V3a7_Wmz_GameItem_Frame:_editableInitView()
	V3a7_Wmz_GameItem_Frame.super._editableInitView(self)
end

function V3a7_Wmz_GameItem_Frame:onDestroyView()
	V3a7_Wmz_GameItem_Frame.super.onDestroyView(self)
end

function V3a7_Wmz_GameItem_Frame:setData(mo)
	V3a7_Wmz_GameItem_Frame.super.setData(self, mo)

	local frameBgResName = self._mo.frameBgResName
	local frameBgResUrl = string.nilorempty(frameBgResName) and "" or ResUrl.getV3a7WmzSingleBg(frameBgResName)

	GameUtil.loadSImage(self._simagekuang, frameBgResUrl)

	local posX = tonumber(self._mo.frameFocusX) or -19999
	local posY = tonumber(self._mo.frameFocusY) or -19999

	self:setAPos(posX, posY)

	if isDebugBuild then
		self:setName(string.format("%s: %s (%s)", self:index(), self:zoneId(), self._mo.frameBgResName))
	end
end

function V3a7_Wmz_GameItem_Frame:zoneId()
	return self._mo.id
end

return V3a7_Wmz_GameItem_Frame
