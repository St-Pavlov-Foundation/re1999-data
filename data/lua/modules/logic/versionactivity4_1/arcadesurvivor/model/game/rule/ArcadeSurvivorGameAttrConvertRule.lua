-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/model/game/rule/ArcadeSurvivorGameAttrConvertRule.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.model.game.rule.ArcadeSurvivorGameAttrConvertRule", package.seeall)

local ArcadeSurvivorGameAttrConvertRule = class("ArcadeSurvivorGameAttrConvertRule", ArcadeSurvivorGameBaseRule)

function ArcadeSurvivorGameAttrConvertRule:applyOnceOnGain()
	local characterMO = ArcadeSurvivorGameModel.instance:getCharacterMO()

	if not characterMO then
		return
	end

	local paramList = string.splitToNumber(self._typeParam, "#")
	local targetAttrId = paramList[1]
	local sourceAttrId = paramList[2]
	local convertPermillage = paramList[3]

	if not targetAttrId or not sourceAttrId or not convertPermillage then
		return
	end

	local sourceAttrValue = characterMO:getAttrValue(sourceAttrId)
	local changeVal = math.floor(sourceAttrValue * convertPermillage / 1000)

	if changeVal == 0 then
		return
	end

	ArcadeSurvivorGameController.instance:changeEntityAttr(characterMO:getEntityType(), characterMO:getUid(), targetAttrId, changeVal)
end

return ArcadeSurvivorGameAttrConvertRule
