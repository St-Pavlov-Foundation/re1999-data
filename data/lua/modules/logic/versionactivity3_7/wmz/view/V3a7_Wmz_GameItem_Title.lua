-- chunkname: @modules/logic/versionactivity3_7/wmz/view/V3a7_Wmz_GameItem_Title.lua

module("modules.logic.versionactivity3_7.wmz.view.V3a7_Wmz_GameItem_Title", package.seeall)

local V3a7_Wmz_GameItem_Title = class("V3a7_Wmz_GameItem_Title", RougeSimpleItemBase)

function V3a7_Wmz_GameItem_Title:onInitView()
	self._txtTitle = gohelper.findChildText(self.viewGO, "Image_TargetBG/#txt_Title")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a7_Wmz_GameItem_Title:addEvents()
	return
end

function V3a7_Wmz_GameItem_Title:removeEvents()
	return
end

function V3a7_Wmz_GameItem_Title:ctor(...)
	V3a7_Wmz_GameItem_Title.super.ctor(self, ...)
end

function V3a7_Wmz_GameItem_Title:_editableInitView()
	V3a7_Wmz_GameItem_Title.super._editableInitView(self)
	gohelper.setActive(self._goLight, false)
end

function V3a7_Wmz_GameItem_Title:onDestroyView()
	V3a7_Wmz_GameItem_Title.super.onDestroyView(self)
end

function V3a7_Wmz_GameItem_Title:zoneClearCurAndMax(...)
	local c = self:baseViewContainer()

	return c:zoneClearCurAndMax(...)
end

function V3a7_Wmz_GameItem_Title:setData(mo)
	V3a7_Wmz_GameItem_Title.super.setData(self, mo)

	local zoneClearCur = self:zoneClearCurAndMax()

	self._txtTitle.text = zoneClearCur >= self:index() and mo.titleDesc or luaLang("V3a7_Wmz_GameItem_Title_txtTitle")

	local posX = tonumber(self._mo.titlePosX) or -19999
	local posY = tonumber(self._mo.titlePosY) or -19999

	self:setAPos(posX, posY)

	if isDebugBuild then
		self:setName(string.format("%s: %s (%s)", self:index(), self:zoneId(), self._txtTitle.text))
	end
end

function V3a7_Wmz_GameItem_Title:zoneId()
	return self._mo.id
end

return V3a7_Wmz_GameItem_Title
