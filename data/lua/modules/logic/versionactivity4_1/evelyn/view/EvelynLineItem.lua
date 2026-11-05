-- chunkname: @modules/logic/versionactivity4_1/evelyn/view/EvelynLineItem.lua

module("modules.logic.versionactivity4_1.evelyn.view.EvelynLineItem", package.seeall)

local EvelynLineItem = class("EvelynLineItem", LuaCompBase)

function EvelynLineItem.stretchToFill(go)
	local rect = go and go:GetComponent(gohelper.Type_RectTransform)

	if not rect then
		return
	end

	rect.anchorMin = UnityEngine.Vector2.zero
	rect.anchorMax = UnityEngine.Vector2.one
	rect.sizeDelta = UnityEngine.Vector2.zero
	rect.anchoredPosition = UnityEngine.Vector2.zero
end

function EvelynLineItem:init(go)
	self.go = go
	self.viewGO = go
	self.transform = go.transform

	EvelynLineItem.stretchToFill(go)
	EvelynLineItem.stretchToFill(gohelper.findChild(go, "root"))

	local curveGo = gohelper.findChild(go, "root/curve1")
	local headGo = gohelper.findChild(go, "root/curve1/head")

	self._headTrs = headGo and headGo.transform or nil

	if curveGo then
		EvelynLineItem.stretchToFill(curveGo)

		local comp = MonoHelper.addNoUpdateLuaComOnceToGo(curveGo, CommonLineComp)

		self._lineComp = comp
	end
end

function EvelynLineItem:refresh(ax, ay, bx, by, angleDeg, lineContainerTrs)
	if not self._lineComp then
		return
	end

	if not self._canvasRootTrs then
		local canvas = lineContainerTrs:GetComponentInParent(typeof(UnityEngine.Canvas))

		if canvas then
			self._canvasRootTrs = canvas.transform
		end
	end

	if not self._canvasRootTrs then
		return
	end

	local sw = lineContainerTrs:TransformPoint(ax, ay, 0)
	local startDesign = self._canvasRootTrs:InverseTransformPoint(sw)
	local dx1, dy1 = startDesign.x, startDesign.y
	local ew = lineContainerTrs:TransformPoint(bx, by, 0)
	local endDesign = self._canvasRootTrs:InverseTransformPoint(ew)
	local dx2, dy2 = endDesign.x, endDesign.y

	self._lineComp:setup(self._canvasRootTrs)
	self._lineComp:setArc(dx1, dy1, dx2, dy2, angleDeg)

	if self._headTrs then
		local headLocalPos = self._headTrs.parent:InverseTransformPoint(ew)

		self._headTrs.localPosition = headLocalPos

		local chordAngle = math.deg(math.atan2(dy2 - dy1, dx2 - dx1))
		local endTangentAngle = chordAngle - angleDeg * 0.5

		transformhelper.setLocalRotation(self._headTrs, 0, 0, endTangentAngle)
	end
end

return EvelynLineItem
