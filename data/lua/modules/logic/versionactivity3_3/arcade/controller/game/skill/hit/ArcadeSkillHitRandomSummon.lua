-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/skill/hit/ArcadeSkillHitRandomSummon.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.skill.hit.ArcadeSkillHitRandomSummon", package.seeall)

local ArcadeSkillHitRandomSummon = class("ArcadeSkillHitRandomSummon", ArcadeSkillHitBase)

function ArcadeSkillHitRandomSummon:onCtor()
	local params = self._params

	self._changeName = params[1]
	self._monsterIdList = nil

	local idstr = params[2]

	if not string.nilorempty(idstr) then
		self._monsterIdList = string.splitToNumber(idstr, ",")
	end
end

function ArcadeSkillHitRandomSummon:onHit()
	if self._context and self._context.target then
		self:addHiter(self._context.target)
	end

	if self._monsterIdList then
		ArcadeGameSummonController.instance:summonMonsterList(self._monsterIdList)
	end
end

function ArcadeSkillHitRandomSummon:onHitPrintLog()
	if self._monsterIdList and #self._monsterIdList > 0 then
		logNormal(string.format("%s ==> 随机坐标召唤怪物。munster:[%s] ", self:getLogPrefixStr(), self._params and self._params[2]))
	else
		logError(string.format("%s ==> 怪物参数配置错误。munster:[%s]", self:getLogPrefixStr(), self._params and self._params[2]))
	end
end

return ArcadeSkillHitRandomSummon
