﻿-- chunkname: @modules/logic/survival/view/map/comp/Survival3DModelComp.lua

module("modules.logic.survival.view.map.comp.Survival3DModelComp", package.seeall)

local Survival3DModelComp = class("Survival3DModelComp", LuaCompBase)

function Survival3DModelComp:ctor(param)
	param = param or {}
	self.width = param.width
	self.height = param.height
	self.customPos = param.customPos
end

function Survival3DModelComp:init(go)
	self._image = go:GetComponent(gohelper.Type_RawImage)

	local width = self.width or recthelper.getWidth(self._image.transform)
	local height = self.height or recthelper.getHeight(self._image.transform)

	self.survivalUI3DRender = UI3DRenderController.instance:getSurvivalUI3DRender(width, height, self.customPos)
	self._image.texture = self.survivalUI3DRender:getRenderTexture()
end

function Survival3DModelComp:onDestroy()
	if self.survivalUI3DRender then
		UI3DRenderController.instance:removeSurvivalUI3DRender(self.survivalUI3DRender)

		self.survivalUI3DRender = nil
	end
end

function Survival3DModelComp:setSurvival3DModelMO(survival3DModelMO)
	self.survivalUI3DRender:setSurvival3DModelMO(survival3DModelMO)
end

function Survival3DModelComp:playNextAnim(animType)
	self.survivalUI3DRender:playNextAnim(animType)
end

return Survival3DModelComp
