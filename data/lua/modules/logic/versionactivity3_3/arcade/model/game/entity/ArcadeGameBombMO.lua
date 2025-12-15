-- chunkname: @modules/logic/versionactivity3_3/arcade/model/game/entity/ArcadeGameBombMO.lua

module("modules.logic.versionactivity3_3.arcade.model.game.entity.ArcadeGameBombMO", package.seeall)

local ArcadeGameBombMO = class("ArcadeGameBombMO", ArcadeGameBaseUnitMO)

function ArcadeGameBombMO:onCtor(extraParam)
	self._liveRound = 0
end

function ArcadeGameBombMO:addLiveRound()
	self._liveRound = self._liveRound + 1
end

function ArcadeGameBombMO:getIsExplode()
	local countdown = ArcadeConfig.instance:getBombCountdown(self.id)

	return countdown <= self._liveRound
end

function ArcadeGameBombMO:getCfg()
	local cfg = ArcadeConfig.instance:getBombCfg(self.id, true)

	return cfg
end

function ArcadeGameBombMO:getSize()
	if not self._sizeX then
		self._sizeX, self._sizeY = ArcadeConfig.instance:getBombSize(self.id)
	end

	return self._sizeX, self._sizeY
end

function ArcadeGameBombMO:getRes()
	return ArcadeConfig.instance:getBombRes(self.id)
end

function ArcadeGameBombMO:getDesc()
	local cfgDesc = ArcadeConfig.instance:getBombDesc(id)

	return ArcadeGameHelper.phraseDesc(cfgDesc, true)
end

return ArcadeGameBombMO
