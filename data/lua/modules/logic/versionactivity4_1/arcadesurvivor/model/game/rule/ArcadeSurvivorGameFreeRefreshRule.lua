-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/model/game/rule/ArcadeSurvivorGameFreeRefreshRule.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.model.game.rule.ArcadeSurvivorGameFreeRefreshRule", package.seeall)

local ArcadeSurvivorGameFreeRefreshRule = class("ArcadeSurvivorGameFreeRefreshRule", ArcadeSurvivorGameBaseRule)

function ArcadeSurvivorGameFreeRefreshRule:getShopRefreshExtra()
	local extraCount = 0
	local changeCount = tonumber(self._typeParam) or 0

	for _, sourceInfo in ipairs(self:getSourceInfoList()) do
		extraCount = extraCount + changeCount * sourceInfo.count
	end

	return extraCount
end

return ArcadeSurvivorGameFreeRefreshRule
