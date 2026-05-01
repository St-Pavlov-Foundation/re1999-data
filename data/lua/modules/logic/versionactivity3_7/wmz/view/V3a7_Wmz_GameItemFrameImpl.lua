-- chunkname: @modules/logic/versionactivity3_7/wmz/view/V3a7_Wmz_GameItemFrameImpl.lua

module("modules.logic.versionactivity3_7.wmz.view.V3a7_Wmz_GameItemFrameImpl", package.seeall)

local V3a7_Wmz_GameItemFrameImpl = class("V3a7_Wmz_GameItemFrameImpl", RougeSimpleItemBase)

function V3a7_Wmz_GameItemFrameImpl:ctor(...)
	V3a7_Wmz_GameItemFrameImpl.super.ctor(self, ...)
end

function V3a7_Wmz_GameItemFrameImpl:_editableInitView()
	V3a7_Wmz_GameItemFrameImpl.super._editableInitView(self)

	if self._goTopRight then
		self._goTopRightTrans = self._goTopRight.transform
	end

	if self._goBottomRight then
		self._goBottomRightTrans = self._goBottomRight.transform
	end

	if self._goBottomLeft then
		self._goBottomLeftTrans = self._goBottomLeft.transform
	end

	if self._goTopLeft then
		self._goTopLeftTrans = self._goTopLeft.transform
	end
end

function V3a7_Wmz_GameItemFrameImpl:onDestroyView()
	V3a7_Wmz_GameItemFrameImpl.super.onDestroyView(self)
end

function V3a7_Wmz_GameItemFrameImpl:setActive_goTop(bActive)
	gohelper.setActive(self._goTop, bActive)
end

function V3a7_Wmz_GameItemFrameImpl:setActive_goRight(bActive)
	gohelper.setActive(self._goRight, bActive)
end

function V3a7_Wmz_GameItemFrameImpl:setActive_goBottom(bActive)
	gohelper.setActive(self._goBottom, bActive)
end

function V3a7_Wmz_GameItemFrameImpl:setActive_goLeft(bActive)
	gohelper.setActive(self._goLeft, bActive)
end

function V3a7_Wmz_GameItemFrameImpl:setActive_goTopRight(bActive)
	gohelper.setActive(self._goTopRight, bActive)
end

function V3a7_Wmz_GameItemFrameImpl:setActive_goBottomRight(bActive)
	gohelper.setActive(self._goBottomRight, bActive)
end

function V3a7_Wmz_GameItemFrameImpl:setActive_goBottomLeft(bActive)
	gohelper.setActive(self._goBottomLeft, bActive)
end

function V3a7_Wmz_GameItemFrameImpl:setActive_goTopLeft(bActive)
	gohelper.setActive(self._goTopLeft, bActive)
end

function V3a7_Wmz_GameItemFrameImpl:setActiveAllEdges(bActive)
	self:setActive_goTop(bActive)
	self:setActive_goRight(bActive)
	self:setActive_goBottom(bActive)
	self:setActive_goLeft(bActive)
end

function V3a7_Wmz_GameItemFrameImpl:setActive_Edge(eDir, bActive)
	if isDebugBuild then
		assert(eDir)
	end

	local E = WmzEnum.Dir

	if eDir == E.Up then
		self:setActive_goTop(bActive)
	elseif eDir == E.Right then
		self:setActive_goRight(bActive)
	elseif eDir == E.Down then
		self:setActive_goBottom(bActive)
	elseif eDir == E.Left then
		self:setActive_goLeft(bActive)
	else
		assert(false, "unsupprted eDir" .. tostring(eDir))
	end
end

function V3a7_Wmz_GameItemFrameImpl:setActive_Corner(eCorner, bActive)
	if isDebugBuild then
		assert(eCorner)
	end

	local E = WmzEnum.Corner

	if eCorner == E.LT then
		self:setActive_goTopLeft(bActive)
	elseif eCorner == E.RT then
		self:setActive_goTopRight(bActive)
	elseif eCorner == E.LB then
		self:setActive_goBottomLeft(bActive)
	elseif eCorner == E.RB then
		self:setActive_goBottomRight(bActive)
	else
		assert(false, "unsupprted eCorner" .. tostring(eCorner))
	end
end

function V3a7_Wmz_GameItemFrameImpl:rotateCorner(eCorner, zDegree)
	local E = WmzEnum.Corner

	if eCorner == E.LT then
		self:localRotateZ(zDegree, self._goTopLeftTrans)
	elseif eCorner == E.RT then
		self:localRotateZ(zDegree, self._goTopRightTrans)
	elseif eCorner == E.LB then
		self:localRotateZ(zDegree, self._goBottomLeftTrans)
	elseif eCorner == E.RB then
		self:localRotateZ(zDegree, self._goBottomRightTrans)
	else
		assert(false, "unsupprted eCorner" .. tostring(eCorner))
	end
end

return V3a7_Wmz_GameItemFrameImpl
