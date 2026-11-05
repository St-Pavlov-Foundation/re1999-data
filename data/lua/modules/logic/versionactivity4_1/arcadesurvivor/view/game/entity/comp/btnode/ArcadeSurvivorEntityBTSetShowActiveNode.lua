-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/view/game/entity/comp/btnode/ArcadeSurvivorEntityBTSetShowActiveNode.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.view.game.entity.comp.btnode.ArcadeSurvivorEntityBTSetShowActiveNode", package.seeall)

local ArcadeSurvivorEntityBTSetShowActiveNode = class("ArcadeSurvivorEntityBTSetShowActiveNode", ArcadeSurvivorEntityBTBaseNode)

function ArcadeSurvivorEntityBTSetShowActiveNode:onCtor()
	self._showId = self:getParamValue(ArcadeSurvivorGameEnum.BTNodeParam.ShowId)
	self._active = self:getParamValue(ArcadeSurvivorGameEnum.BTNodeParam.Active)
end

function ArcadeSurvivorEntityBTSetShowActiveNode:_onTick()
	local scene = ArcadeSurvivorGameController.instance:getGameScene()

	if scene and scene.effectMgr:setShowActive(self._showId, self._active, self:getEntity()) then
		return ArcadeSurvivorGameEnum.BTNodeStatus.Success
	end

	return ArcadeSurvivorGameEnum.BTNodeStatus.Failure
end

return ArcadeSurvivorEntityBTSetShowActiveNode
