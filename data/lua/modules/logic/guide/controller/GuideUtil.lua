﻿-- chunkname: @modules/logic/guide/controller/GuideUtil.lua

module("modules.logic.guide.controller.GuideUtil", package.seeall)

local GuideUtil = _M
local typeRectTransform = typeof(UnityEngine.RectTransform)
local typeCanvasGroup = typeof(UnityEngine.CanvasGroup)
local uiRootTr

function GuideUtil.isGOShowInScreen(go)
	if gohelper.isNil(go) or not go.activeInHierarchy then
		return false
	end

	local rectTransform = go:GetComponent(typeRectTransform)

	if rectTransform then
		uiRootTr = uiRootTr or ViewMgr.instance:getUIRoot().transform

		if ZProj.UGUIHelper.Overlaps(rectTransform, uiRootTr, CameraMgr.instance:getUICamera()) then
			while rectTransform do
				local scaleX, scaleY, scaleZ = transformhelper.getLocalScale(rectTransform, 0, 0, 0)

				if scaleX == 0 or scaleY == 0 then
					return false
				end

				local canvasGroup = rectTransform:GetComponent(typeCanvasGroup)

				if canvasGroup and canvasGroup.alpha == 0 then
					return false
				end

				rectTransform = rectTransform.parent
			end

			return true
		else
			return false
		end
	else
		return true
	end
end

function GuideUtil.isGuideViewTarget(targetGO)
	if ViewMgr.instance:isOpen(ViewName.GuideView) then
		local viewParam = GuideViewMgr.instance.viewParam
		local guideGOPath = viewParam and viewParam.goPath
		local go = gohelper.find(guideGOPath)

		if go and targetGO == go then
			return true
		end
	end

	return false
end

return GuideUtil
