-- chunkname: @modules/logic/versionactivity3_7/wmz/view/V3a7_Wmz_GameItem_Tile.lua

local sf = string.format

module("modules.logic.versionactivity3_7.wmz.view.V3a7_Wmz_GameItem_Tile", package.seeall)

local V3a7_Wmz_GameItem_Tile = class("V3a7_Wmz_GameItem_Tile", V3a7_Wmz_GameItem_Cell)

function V3a7_Wmz_GameItem_Tile:unbind(...)
	self._mo:unbind(...)
end

function V3a7_Wmz_GameItem_Tile:bind(...)
	self._mo:bind(...)
end

function V3a7_Wmz_GameItem_Tile:ctor(...)
	V3a7_Wmz_GameItem_Tile.super.ctor(self, ...)

	self._drag = UIDragListenerHelper.New()
end

function V3a7_Wmz_GameItem_Tile:_editableInitView()
	V3a7_Wmz_GameItem_Tile.super._editableInitView(self)

	self._btnClick = gohelper.findChildClick(self._godragArea, "")

	self:_editableInitView_drag()
end

function V3a7_Wmz_GameItem_Tile:_editableAddEvents()
	self._btnClick:AddClickListener(self._onBtnClick, self)
end

function V3a7_Wmz_GameItem_Tile:_editableRemoveEvents()
	self._btnClick:RemoveClickListener()
end

function V3a7_Wmz_GameItem_Tile:onDestroyView()
	GameUtil.onDestroyViewMember(self, "_drag")
	V3a7_Wmz_GameItem_Tile.super.onDestroyView(self)
end

function V3a7_Wmz_GameItem_Tile:_editableInitView_drag()
	gohelper.setActive(self._godragArea, true)
	self._drag:create(self._godragArea, self)
	self._drag:registerCallback(self._drag.EventBegin, self._onDragBegin, self)
	self._drag:registerCallback(self._drag.EventDragging, self._onDrag, self)
	self._drag:registerCallback(self._drag.EventEnd, self._onDragEnd, self)
end

function V3a7_Wmz_GameItem_Tile:_onDragBegin(...)
	local p = self:parent()

	p:onDragBegin(self, ...)
end

function V3a7_Wmz_GameItem_Tile:_onDrag(...)
	local p = self:parent()

	p:onDrag(self, ...)
end

function V3a7_Wmz_GameItem_Tile:_onDragEnd(...)
	local p = self:parent()

	p:onDragEnd(self, ...)
end

function V3a7_Wmz_GameItem_Tile:setData(mo)
	V3a7_Wmz_GameItem_Tile.super.setData(self, mo)

	if isDebugBuild then
		self:_debug_refresh()
	end
end

function V3a7_Wmz_GameItem_Tile:_onBtnClick()
	local p = self:parent()

	p:onTileItemClick(self)
end

function V3a7_Wmz_GameItem_Tile:getTileItem()
	return self
end

function V3a7_Wmz_GameItem_Tile:_debug_refresh()
	if not WmzEnum.rDir then
		return
	end

	local ptDebugName = WmzEnum.nameOfPT(self:pathType())

	self:setName(sf("%s: %s", self:indexStr(), ptDebugName))
end

return V3a7_Wmz_GameItem_Tile
