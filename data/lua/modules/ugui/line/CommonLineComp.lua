-- chunkname: @modules/ugui/line/CommonLineComp.lua

module("modules.ugui.line.CommonLineComp", package.seeall)

local CommonLineComp = class("CommonLineComp", LuaCompBase)

CommonLineComp.ModeStraight = "Straight"
CommonLineComp.ModeParabola = "Parabola"
CommonLineComp.ModeArc = "Arc"

function CommonLineComp:init(go)
	CommonLineComp.super.init(self, go)

	self.go = go
	self._graphic = gohelper.findChildComponent(go, "", typeof(UnityEngine.UI.Graphic))

	if self._graphic then
		self._material = UnityEngine.Object.Instantiate(self._graphic.material)
		self._graphic.material = self._material
	end

	self._tempVec4 = Vector4(0, 0, 0, 0)
end

function CommonLineComp:onDestroy()
	if self._material then
		UnityEngine.Object.Destroy(self._material)

		self._material = nil
	end
end

function CommonLineComp:setup(sceneRoot)
	self.sceneRoot = sceneRoot
end

function CommonLineComp:setStraight(x1, y1, x2, y2)
	if not self._material then
		return
	end

	self._mode = CommonLineComp.ModeStraight

	self._material:DisableKeyword("_PARABOLA_ON")
	self._material:DisableKeyword("_ROUND_ON")
	self:_writeStartEnd(x1, y1, x2, y2)
	self._material:SetFloat("_ParabolaHeight", 0)
end

function CommonLineComp:setParabola(x1, y1, angleDeg, speed, gravity, groundY)
	if not self._material then
		return 0, 0
	end

	self._mode = CommonLineComp.ModeParabola

	self._material:EnableKeyword("_PARABOLA_ON")
	self._material:DisableKeyword("_ROUND_ON")

	local rad = math.rad(angleDeg)
	local vx = math.cos(rad) * speed
	local vy = math.sin(rad) * speed
	local y2 = groundY
	local discriminant = math.max(vy * vy + 2 * gravity * (y1 - y2), 0)
	local t = (vy + math.sqrt(discriminant)) / gravity
	local x2 = x1 + vx * t
	local maxHeight

	if vy > 0 then
		maxHeight = y1 + vy * vy / (2 * gravity)
	else
		local downRatio = math.min(math.max(-angleDeg, 0), 90) / 90

		maxHeight = y1 + (y2 - y1) * downRatio
	end

	self:_writeStartEnd(x1, y1, x2, y2)
	self:_writePeakY(maxHeight)

	return x2, y2
end

function CommonLineComp:setArc(x1, y1, x2, y2, angleDeg)
	if not self._material then
		return
	end

	self._mode = CommonLineComp.ModeArc

	self._material:DisableKeyword("_PARABOLA_ON")
	self._material:EnableKeyword("_ROUND_ON")
	self:_writeStartEnd(x1, y1, x2, y2)
	self._material:SetFloat("_Angle", angleDeg or 0)
	self._material:SetFloat("_ParabolaHeight", 0)
end

function CommonLineComp:getMode()
	return self._mode
end

function CommonLineComp:getMaterial()
	return self._material
end

function CommonLineComp:_getShaderLineFactor()
	local screenWidth = UnityEngine.Screen.width
	local aspect = screenWidth / UnityEngine.Screen.height
	local innerFactor = aspect > 1.7777777777777777 and screenWidth / 2592 or 0.5208333333333334 * aspect

	return 0.01 * innerFactor
end

function CommonLineComp:_writeStartEnd(x1, y1, x2, y2)
	if not self.sceneRoot then
		return
	end

	local factor = self:_getShaderLineFactor()
	local sw = self.sceneRoot.transform:TransformPoint(x1, y1, 0)

	self._tempVec4.x = sw.x / factor
	self._tempVec4.y = sw.y / factor

	self._material:SetVector("_StartVec", self._tempVec4)

	local ew = self.sceneRoot.transform:TransformPoint(x2, y2, 0)

	self._tempVec4.x = ew.x / factor
	self._tempVec4.y = ew.y / factor

	self._material:SetVector("_EndVec", self._tempVec4)
end

function CommonLineComp:_writePeakY(peakY)
	if not self.sceneRoot then
		return
	end

	local factor = self:_getShaderLineFactor()
	local pw = self.sceneRoot.transform:TransformPoint(0, peakY, 0)

	self._material:SetFloat("_ParabolaHeight", pw.y / factor)
end

return CommonLineComp
