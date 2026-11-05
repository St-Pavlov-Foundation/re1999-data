-- chunkname: @modules/logic/versionactivity4_1/library/scene/comp/V4a1_LibrarySceneCameraComp.lua

module("modules.logic.versionactivity4_1.library.scene.comp.V4a1_LibrarySceneCameraComp", package.seeall)

local V4a1_LibrarySceneCameraComp = class("V4a1_LibrarySceneCameraComp", CommonSceneCameraComp)
local kDesignWidth = ZProj.ScreenAdaption.DesignWidth
local kDesignHeight = ZProj.ScreenAdaption.DesignHeight
local kDesignAspect = kDesignWidth / kDesignHeight
local math_atan = math.atan
local math_tan = math.tan
local math_deg = math.deg
local math_rad = math.rad

local function _getSwSh()
	local w, h

	if BootNativeUtil.isWindows() and not SLFramework.FrameworkSettings.IsEditor then
		w, h = SettingsModel.instance:getCurrentScreenSize()
	else
		w = UnityEngine.Screen.width
		h = UnityEngine.Screen.height
	end

	return w, h
end

local function _calcFovInternalSimple(refFov, minFov, maxFov)
	local w, h = _getSwSh()
	local invAspect = h / w
	local fovRatio = kDesignAspect * invAspect
	local fov = refFov * fovRatio

	return GameUtil.clamp(fov, minFov, maxFov)
end

local function _calcAdjustedFov(refFov, minFov, maxFov)
	local w, h = _getSwSh()

	if not w or not h or w <= 0 or h <= 0 then
		return GameUtil.clamp(refFov, minFov, maxFov)
	end

	local invAspect = h / w
	local refHFov = 2 * math_atan(math_tan(math_rad(refFov) / 2) * kDesignAspect)
	local vFov = 2 * math_deg(math_atan(math_tan(refHFov / 2) * invAspect))

	return GameUtil.clamp(vFov, minFov, maxFov)
end

function V4a1_LibrarySceneCameraComp:ctor(...)
	V4a1_LibrarySceneCameraComp.super.ctor(self, ...)
end

function V4a1_LibrarySceneCameraComp:_calcFovInternal(cameraConfig)
	return _calcAdjustedFov(cameraConfig.fov, self:_getMinMaxFov())
end

function V4a1_LibrarySceneCameraComp:_getMinMaxFov()
	local fovRange = V4a1_LibraryConfig.instance:getFovRange()

	return fovRange[1], fovRange[2]
end

function V4a1_LibrarySceneCameraComp:onSceneClose()
	V4a1_LibrarySceneCameraComp.super.onSceneClose(self)
end

return V4a1_LibrarySceneCameraComp
