-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/skill/hit/ArcadeSkillHitThrowingBomb.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.skill.hit.ArcadeSkillHitThrowingBomb", package.seeall)

local ArcadeSkillHitThrowingBomb = class("ArcadeSkillHitThrowingBomb", ArcadeSkillHitBase)

function ArcadeSkillHitThrowingBomb:onCtor()
	local params = self._params

	self._changeName = params[1]
	self._bombIdList = {}

	for i = 2, #params do
		local bombId = tonumber(params[i])

		if bombId then
			table.insert(self._bombIdList, bombId)
		end
	end
end

function ArcadeSkillHitThrowingBomb:onHit()
	if self._context and self._context.target then
		ArcadeGameSummonController.instance:summonBombList(self._bombIdList)
	end
end

function ArcadeSkillHitThrowingBomb:onHitPrintLog()
	if self._context and self._context.target then
		logNormal(string.format("%s ==> 投掷炸弹位置随机", self:getLogPrefixStr()))
	end
end

return ArcadeSkillHitThrowingBomb
