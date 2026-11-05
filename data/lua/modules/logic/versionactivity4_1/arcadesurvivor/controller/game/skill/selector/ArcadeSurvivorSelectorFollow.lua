-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/controller/game/skill/selector/ArcadeSurvivorSelectorFollow.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.controller.game.skill.selector.ArcadeSurvivorSelectorFollow", package.seeall)

local ArcadeSurvivorSelectorFollow = class("ArcadeSurvivorSelectorFollow", ArcadeSurvivorSelectorRect)

function ArcadeSurvivorSelectorFollow:onCtor()
	self._width = 0
	self._height = 0
end

function ArcadeSurvivorSelectorFollow:getRectSize()
	local width, height = self._width, self._height
	local characterMO = ArcadeSurvivorGameModel.instance:getCharacterMO()

	if characterMO then
		width = characterMO:getAttrValue(ArcadeSurvivorEnum.Attribute.atkWidth)
		height = characterMO:getAttrValue(ArcadeSurvivorEnum.Attribute.atkLength)
	end

	return width, height
end

return ArcadeSurvivorSelectorFollow
