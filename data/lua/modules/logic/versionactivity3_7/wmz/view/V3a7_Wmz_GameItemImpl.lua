-- chunkname: @modules/logic/versionactivity3_7/wmz/view/V3a7_Wmz_GameItemImpl.lua

module("modules.logic.versionactivity3_7.wmz.view.V3a7_Wmz_GameItemImpl", package.seeall)

local V3a7_Wmz_GameItemImpl = class("V3a7_Wmz_GameItemImpl", RougeSimpleItemBase)

function V3a7_Wmz_GameItemImpl:onInitView()
	self._goLocked = gohelper.findChild(self.viewGO, "#go_Locked")
	self._goPiece = gohelper.findChild(self.viewGO, "#go_Piece")
	self._goLine0 = gohelper.findChild(self.viewGO, "#go_Line_0")
	self._goLine1 = gohelper.findChild(self.viewGO, "#go_Line_1")
	self._goLineStart = gohelper.findChild(self.viewGO, "#go_Line_Start")
	self._goBorder = gohelper.findChild(self.viewGO, "#go_Border")
	self._goFrame = gohelper.findChild(self.viewGO, "#go_Frame")
	self._godragArea = gohelper.findChild(self.viewGO, "#go_dragArea")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a7_Wmz_GameItemImpl:addEvents()
	return
end

function V3a7_Wmz_GameItemImpl:removeEvents()
	return
end

function V3a7_Wmz_GameItemImpl:ctor(...)
	V3a7_Wmz_GameItemImpl.super.ctor(self, ...)
end

function V3a7_Wmz_GameItemImpl:_editableInitView()
	V3a7_Wmz_GameItemImpl.super._editableInitView(self)

	self._Image_BGGo = gohelper.findChild(self.viewGO, "Image_BG")
	self._line0 = self:_create_V3a7_Wmz_GameItemImpl_Line(self._goLine0)
	self._line1 = self:_create_V3a7_Wmz_GameItemImpl_Line(self._goLine1)
	self._border = self:_create_V3a7_Wmz_GameItem_Border(self._goBorder)
	self._goLineStartTran = self._goLineStart.transform
	self._imgPiece = gohelper.findChildImage(self._goPiece, "")

	self:setActive_goLocked(false)
	self:setActive_goLine(false)
	gohelper.setActive(self._godragArea, false)
end

function V3a7_Wmz_GameItemImpl:onDestroyView()
	GameUtil.onDestroyViewMember(self, "_line0")
	GameUtil.onDestroyViewMember(self, "_line1")
	V3a7_Wmz_GameItemImpl.super.onDestroyView(self)
end

function V3a7_Wmz_GameItemImpl:dragContext()
	local c = self:baseViewContainer()

	return c:dragContext()
end

function V3a7_Wmz_GameItemImpl:isCompleted()
	return self:dragContext():isCompleted()
end

function V3a7_Wmz_GameItemImpl:setSprite(...)
	local c = self:baseViewContainer()

	return c:setSprite(...)
end

function V3a7_Wmz_GameItemImpl:coordToAPosInContentSpace(...)
	local c = self:baseViewContainer()

	return c:coordToAPosInContentSpace(...)
end

function V3a7_Wmz_GameItemImpl:getTileIdListByGroup()
	local c = self:baseViewContainer()

	return c:getTileIdListByGroup(self:groupId())
end

function V3a7_Wmz_GameItemImpl:isVoid()
	return self._mo:isVoid()
end

function V3a7_Wmz_GameItemImpl:isNothing()
	return self._mo:isNothing()
end

function V3a7_Wmz_GameItemImpl:isWall()
	return self._mo:isWall()
end

function V3a7_Wmz_GameItemImpl:isPassable()
	return self._mo:isPassable()
end

function V3a7_Wmz_GameItemImpl:isPassableEmpty()
	return self._mo:isPassableEmpty()
end

function V3a7_Wmz_GameItemImpl:isEmpty()
	return self._mo:isEmpty()
end

function V3a7_Wmz_GameItemImpl:isPathNone()
	return self._mo:isPathNone()
end

function V3a7_Wmz_GameItemImpl:isStart()
	return self._mo:isStart()
end

function V3a7_Wmz_GameItemImpl:id()
	return self._mo:id()
end

function V3a7_Wmz_GameItemImpl:x()
	return self._mo:x()
end

function V3a7_Wmz_GameItemImpl:y()
	return self._mo:y()
end

function V3a7_Wmz_GameItemImpl:xy()
	return self._mo:xy()
end

function V3a7_Wmz_GameItemImpl:pathType()
	return self._mo:pathType()
end

function V3a7_Wmz_GameItemImpl:floorType()
	return self._mo:floorType()
end

function V3a7_Wmz_GameItemImpl:sprite()
	return self._mo:sprite()
end

function V3a7_Wmz_GameItemImpl:indexStr()
	return self._mo:indexStr()
end

function V3a7_Wmz_GameItemImpl:groupId()
	return self._mo:groupId()
end

function V3a7_Wmz_GameItemImpl:bHasGroup()
	return self._mo:bHasGroup()
end

function V3a7_Wmz_GameItemImpl:bWelded()
	return self._mo:bWelded()
end

function V3a7_Wmz_GameItemImpl:tileId()
	return self._mo:tileId()
end

function V3a7_Wmz_GameItemImpl:getTile()
	return self._mo:getTile()
end

function V3a7_Wmz_GameItemImpl:isIndex(...)
	return self._mo:isIndex(...)
end

function V3a7_Wmz_GameItemImpl:T(...)
	return self._mo:T(...)
end

function V3a7_Wmz_GameItemImpl:R(...)
	return self._mo:R(...)
end

function V3a7_Wmz_GameItemImpl:B(...)
	return self._mo:B(...)
end

function V3a7_Wmz_GameItemImpl:L(...)
	return self._mo:L(...)
end

function V3a7_Wmz_GameItemImpl:setSelected(...)
	self._mo:setSelected(...)
end

function V3a7_Wmz_GameItemImpl:setTileId(...)
	self._mo:setTileId(...)
end

function V3a7_Wmz_GameItemImpl:setData(mo)
	V3a7_Wmz_GameItemImpl.super.setData(self, mo)

	local isCompleted = self:isCompleted()
	local bShowLocked = self:isWall() and not isCompleted

	self:setActive_goLocked(bShowLocked)

	if self:isPathNone() then
		self._line0:setActive(false)
		self._line1:setActive(false)
	end

	local sprite = self:sprite()

	if not string.nilorempty(sprite) then
		local bShowSprite = isCompleted or not self:isPassableEmpty()

		self:setSprite(self._imgPiece, sprite)
		self:setActive_goPiece(bShowSprite)
	else
		self:setActive_goPiece(false)
	end

	self:_refreshBorder()
	self:setActive_Image_BGGo(not self:isVoid())
end

function V3a7_Wmz_GameItemImpl:_refreshBorder()
	local bDisactive = self:isVoid() or self:isStart()

	if bDisactive then
		self._border:setActive(false)

		return
	end

	self._border:setActive(true)

	local gp = self:groupId()

	if gp == 0 then
		self._border:setActiveAllEdges(true)

		return
	end

	local TCell = self:T()
	local RCell = self:R()
	local BCell = self:B()
	local LCell = self:L()

	local function _handler(eDir, cellObj)
		if not cellObj then
			self._border:setActive_Edge(eDir, true)
		else
			self._border:setActive_Edge(eDir, cellObj:groupId() ~= gp)
		end
	end

	_handler(WmzEnum.Dir.Up, TCell)
	_handler(WmzEnum.Dir.Right, RCell)
	_handler(WmzEnum.Dir.Down, BCell)
	_handler(WmzEnum.Dir.Left, LCell)
end

function V3a7_Wmz_GameItemImpl:resetPos()
	local gridObj = self._mo
	local ax, ay = self:coordToAPosInContentSpace(gridObj:xy())

	self:setAPos(ax, ay)
end

function V3a7_Wmz_GameItemImpl:setActive_goLocked(bActive)
	gohelper.setActive(self._goLocked, bActive)
end

function V3a7_Wmz_GameItemImpl:setActive_goLineStart(bActive)
	gohelper.setActive(self._goLineStart, bActive)
end

function V3a7_Wmz_GameItemImpl:setActive_goLine(bWelded)
	self._line0:setActive(not bWelded)
	self._line1:setActive(bWelded)
end

function V3a7_Wmz_GameItemImpl:setActive_goPiece(bActive)
	gohelper.setActive(self._goPiece, bActive)
end

function V3a7_Wmz_GameItemImpl:setActive_Image_BGGo(bActive)
	gohelper.setActive(self._Image_BGGo, bActive)
end

function V3a7_Wmz_GameItemImpl:playIdleAnim()
	return
end

function V3a7_Wmz_GameItemImpl:_create_V3a7_Wmz_GameItemImpl_Line(srcGo)
	local item = self:newObject(V3a7_Wmz_GameItemImpl_Line)

	item:init(srcGo)

	return item
end

function V3a7_Wmz_GameItemImpl:_create_V3a7_Wmz_GameItem_Border(srcGo)
	local item = self:newObject(V3a7_Wmz_GameItem_Border)

	item:init(srcGo)

	return item
end

return V3a7_Wmz_GameItemImpl
