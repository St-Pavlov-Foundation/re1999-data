-- chunkname: @modules/live2d/special/Live2dSpecialEffect_312704_mes.lua

module("modules.live2d.special.Live2dSpecialEffect_312704_mes", package.seeall)

local Live2dSpecialEffect_312704_mes = class("Live2dSpecialEffect_312704_mes", BaseLive2dSpecialEffect)
local b_jingji = "b_jingji"

function Live2dSpecialEffect_312704_mes:_onBeforeBodyChange(prevBodyName, curBodyName)
	if curBodyName == b_jingji then
		if not self._renderController then
			local spineGo = self._live2d:getSpineGo()

			self._renderController = spineGo and spineGo:GetComponent(typeof(Live2D.Cubism.Rendering.CubismRenderController))
		end

		if not self._setDrawableOverride and self._renderController then
			self._renderController:SetDrawableOverride(0, false)
			self._renderController:SetDrawableOverride(0, true)

			self._setDrawableOverride = true
		end
	end
end

return Live2dSpecialEffect_312704_mes
