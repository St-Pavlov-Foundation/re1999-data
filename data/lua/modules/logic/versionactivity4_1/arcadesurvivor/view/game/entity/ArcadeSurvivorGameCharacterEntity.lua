-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/view/game/entity/ArcadeSurvivorGameCharacterEntity.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.view.game.entity.ArcadeSurvivorGameCharacterEntity", package.seeall)

local ArcadeSurvivorGameCharacterEntity = class("ArcadeSurvivorGameCharacterEntity", ArcadeSurvivorGameBaseEntity)

function ArcadeSurvivorGameCharacterEntity:_onRefreshPosition(isTween)
	local scene = ArcadeSurvivorGameController.instance:getGameScene()

	if scene then
		scene:focusPlayer(isTween)
	end
end

return ArcadeSurvivorGameCharacterEntity
