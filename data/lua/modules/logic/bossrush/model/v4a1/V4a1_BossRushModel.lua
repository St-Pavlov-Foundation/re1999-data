-- chunkname: @modules/logic/bossrush/model/v4a1/V4a1_BossRushModel.lua

module("modules.logic.bossrush.model.v4a1.V4a1_BossRushModel", package.seeall)

local V4a1_BossRushModel = class("V4a1_BossRushModel", BaseModel)

function V4a1_BossRushModel:init()
	self:reInit()
end

function V4a1_BossRushModel:reInit()
	self._curSeason = nil
	self._remainSeasonUnlockCount = 0
end

function V4a1_BossRushModel:getCurSeason()
	if not self._curSeason then
		self._curSeason = BossRushConfig.instance:getConst(V4a1BossRushEnum.CurSeasonConst)
	end

	return self._curSeason
end

function V4a1_BossRushModel:isCurSeason(actId)
	local season = self:getSeasonByActId(actId)

	return season == self:getCurSeason()
end

function V4a1_BossRushModel:refreshSeasonUnlockCount(count)
	self._remainSeasonUnlockCount = count or 0
end

function V4a1_BossRushModel:onUnlockBoss(msg)
	if self._remainSeasonUnlockCount <= 0 then
		return
	end

	self._remainSeasonUnlockCount = self._remainSeasonUnlockCount - 1

	local stageMo = V3a9_BossRushModel.instance:getStageMo(msg.targetActivityId, msg.bossId)

	if stageMo then
		local stageCO = stageMo.stageCO
		local bossType = stageCO.type
		local handbookMo = V3a2_BossRushModel.instance:getHandBookMo(bossType)

		if handbookMo then
			handbookMo:onUnlock()
		end
	end
end

function V4a1_BossRushModel:getSeasonUnlockCount()
	if not self._seasonUnlockCount then
		self._seasonUnlockCount = BossRushConfig.instance:getConst(V4a1BossRushEnum.SeasonUnlockCountConst)
	end

	return self._remainSeasonUnlockCount or 0, self._seasonUnlockCount or 0
end

function V4a1_BossRushModel:getSeasonMo(season)
	local mos = self:getSeasonMos()

	return mos[season]
end

function V4a1_BossRushModel:getSeasonMos()
	if not self._seasonMos then
		self._seasonMos = {}

		for _, co in ipairs(lua_activity128_season.configDict) do
			local mo = V4a1_BossRushSeasonMO.New()

			mo:onInit(co)

			self._seasonMos[co.id] = mo
		end
	end

	return self._seasonMos
end

function V4a1_BossRushModel:getSeasonMoByActId(actId)
	local season = self:getSeasonByActId(actId)

	return self:getSeasonMo(season)
end

function V4a1_BossRushModel:_initSeasonActId()
	local mos = V3a9_BossRushModel.instance:getAllBossDetailMos()

	if mos then
		for _actId, list in pairs(mos) do
			for _, v in pairs(list) do
				if not self._seasonActIds then
					self._seasonActIds = {}
				end

				self._seasonActIds[_actId] = v.season
			end
		end
	end
end

function V4a1_BossRushModel:getSeasonByActId(actId)
	if not self._seasonActIds then
		self:_initSeasonActId()
	end

	return self._seasonActIds[actId]
end

function V4a1_BossRushModel:getSeasonAllActIds()
	if not self._seasonActIds then
		self:_initSeasonActId()
	end

	return self._seasonActIds
end

function V4a1_BossRushModel:getScoreSkillMos(episodeId)
	if not self._scoreSkillCos then
		self._scoreSkillCos = {}

		for _, co in ipairs(lua_activity128_score_skill.configList) do
			if not self._scoreSkillCos[co.episodeId] then
				self._scoreSkillCos[co.episodeId] = {}
			end

			if not self._scoreSkillCos[co.episodeId][co.phase] then
				self._scoreSkillCos[co.episodeId][co.phase] = {}
			end

			table.insert(self._scoreSkillCos[co.episodeId][co.phase], co)
		end

		for _, v in ipairs(self._scoreSkillCos) do
			for _, list in ipairs(v) do
				table.sort(list, function(a, b)
					return a.config.monsterId < b.config.monsterId
				end)
			end
		end
	end

	return self._scoreSkillCos[episodeId]
end

function V4a1_BossRushModel:getHandBookMoByActStage(actId, stage)
	local stageMo = V3a9_BossRushModel.instance:getStageMo(actId, stage)

	if stageMo then
		local bossType = stageMo.stageCO.type

		return V3a2_BossRushModel.instance:getHandBookMo(bossType)
	end
end

function V4a1_BossRushModel:getEpisodeCoById(episodeId)
	if not self._episodeCo then
		self._episodeCo = {}

		for _, v in ipairs(lua_activity128_episode.configList) do
			if not self._episodeCo[v.episodeId] then
				self._episodeCo[v.episodeId] = {}
			end

			table.insert(self._episodeCo[v.episodeId], v)
		end
	end

	local cos = self._episodeCo[episodeId]

	if cos then
		return cos[#cos]
	end
end

function V4a1_BossRushModel:isShowHandBookRedddot(mo)
	if not mo or not mo:getBossType() then
		return false
	end

	if mo.season ~= self:getCurSeason() and not mo.haveFight then
		local count = self:getSeasonUnlockCount()

		if count > 0 then
			return true
		end
	end

	if mo:hasClaimBonus() then
		return true
	end

	return false
end

function V4a1_BossRushModel:isShowSeasonHandBookRedddot(season)
	local mos = V3a2_BossRushModel.instance:getHandBookGroupMos(season)

	if mos then
		for _, v in pairs(mos) do
			for _, mo in pairs(v.bossGroup) do
				if self:isShowHandBookRedddot(mo) then
					return true
				end
			end
		end
	end

	if RedDotModel.instance:isDotShow(RedDotEnum.DotNode.BossRushRankBonus, season) then
		return true
	end

	return false
end

V4a1_BossRushModel.instance = V4a1_BossRushModel.New()

return V4a1_BossRushModel
