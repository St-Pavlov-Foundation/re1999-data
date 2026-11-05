-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/model/game/rule/ArcadeSurvivorGameCollAttrRule.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.model.game.rule.ArcadeSurvivorGameCollAttrRule", package.seeall)

local ArcadeSurvivorGameCollAttrRule = class("ArcadeSurvivorGameCollAttrRule", ArcadeSurvivorGameBaseRule)

function ArcadeSurvivorGameCollAttrRule:applyOnceOnGain()
	local characterMO = ArcadeSurvivorGameModel.instance:getCharacterMO()

	if not characterMO then
		return
	end

	local changeAttrDict = {}
	local attrIdList = {}

	for _, data in ipairs(ArcadeSurvivorGameHelper.parseColonNumberList(self._typeParam)) do
		if not changeAttrDict[data.id] then
			attrIdList[#attrIdList + 1] = data.id
		end

		changeAttrDict[data.id] = (changeAttrDict[data.id] or 0) + data.val
	end

	local hasChangeAttr = next(changeAttrDict) ~= nil

	if hasChangeAttr then
		ArcadeSurvivorGameController.instance:changeEntityAttrs(characterMO:getEntityType(), characterMO:getUid(), changeAttrDict, attrIdList)
	end
end

return ArcadeSurvivorGameCollAttrRule
