-- chunkname: @modules/logic/bossrush/model/v3a2/V3a2_BossRushModel.lua

module("modules.logic.bossrush.model.v3a2.V3a2_BossRushModel", package.seeall)

local V3a2_BossRushModel = class("V3a2_BossRushModel", BaseModel)

function V3a2_BossRushModel:init()
	self._config = BossRushConfig.instance
end

function V3a2_BossRushModel:onRefresh128InfosReply(msg)
	self:initRankInfo(msg)
end

function V3a2_BossRushModel:onReceiveAct128GetExpReply(msg)
	local mo = self:getHandBookMo(msg.type)

	if mo then
		mo:setAcceptExp(msg.acceptExpPoint)
	end

	local seasonMo = V4a1_BossRushModel.instance:getSeasonMoByActId(msg.activityId)

	seasonMo:refreshLevel(msg.playerLevel)
end

function V3a2_BossRushModel:_onReceiveAct128GetMilestoneBonusReply(msg)
	local seasonMo = V4a1_BossRushModel.instance:getSeasonMoByActId(msg.activityId)

	if seasonMo then
		seasonMo:refreshClaimLevel(msg.gainMilestoneLevel)
	end

	self:_refreshGainMilestoneLevel(msg.activityId)
end

function V3a2_BossRushModel:getSortStages(actId)
	local lockInfoList = {}
	local unlockInfoList = {}
	local newOpenStage
	local _infoList = {}
	local dataList = V3a9_BossRushModel.instance:getStageMos(actId)

	if dataList then
		for _, mo in ipairs(dataList) do
			local isOpen = mo:isOpen()

			if isOpen then
				newOpenStage = mo

				table.insert(unlockInfoList, mo)
			else
				table.insert(lockInfoList, mo)
			end
		end

		table.insert(_infoList, newOpenStage)

		for _, info in ipairs(unlockInfoList) do
			if newOpenStage ~= info then
				table.insert(_infoList, info)
			end
		end

		for _, info in ipairs(lockInfoList) do
			table.insert(_infoList, info)
		end
	end

	return _infoList
end

function V3a2_BossRushModel:getRank(season)
	local seasonMo = V4a1_BossRushModel.instance:getSeasonMo(season)

	if seasonMo then
		return seasonMo.level
	end
end

function V3a2_BossRushModel:initRankInfo(info)
	local seasonMo = V4a1_BossRushModel.instance:getSeasonMoByActId(info.activityId)

	if seasonMo then
		seasonMo:refreshLevel(info.playerLevel)
		seasonMo:refreshClaimLevel(info.gainMilestoneLevel)
	end

	self:_refreshGainMilestoneLevel(info.activityId)
end

function V3a2_BossRushModel:refreshRankMos(activityId)
	self:_refreshGainMilestoneLevel(activityId)
end

function V3a2_BossRushModel:_refreshGainMilestoneLevel(activityId)
	local seasonMo = V4a1_BossRushModel.instance:getSeasonMoByActId(activityId)

	if seasonMo then
		local season = seasonMo.season
		local _mos = self:getRankMos(season)

		if _mos then
			for _, mo in pairs(_mos) do
				mo:setInfo(seasonMo.level, seasonMo.claimLevel)
			end
		end
	end
end

function V3a2_BossRushModel:getRankExp(season)
	local seasonMo = V4a1_BossRushModel.instance:getSeasonMo(season)
	local currency = seasonMo and seasonMo.expMaterial
	local num = currency and ItemModel.instance:getItemQuantity(currency[1], currency[2])

	return num
end

function V3a2_BossRushModel:getRankExpProgress(season)
	local seasonMo = V4a1_BossRushModel.instance:getSeasonMo(season)
	local level = seasonMo.level
	local rankMo = self:getRankMo(season, level + 1)
	local exp = self:getRankExp(season)

	if rankMo then
		return exp - rankMo.preExp, rankMo.config.needExp
	end

	rankMo = self:getRankMo(season, level)

	return 0, rankMo and rankMo.config.needExp or 0
end

function V3a2_BossRushModel:getRankMos(season)
	if not self._rankMOs then
		self._rankMOs = {}

		local cos = self._config:getAllLevelCos()

		if cos then
			for i, co in pairs(cos) do
				local mo = V3a2_BossRush_RankMO.New()

				mo:initMO(co)

				if not self._rankMOs[co.season] then
					self._rankMOs[co.season] = {}
				end

				self._rankMOs[co.season][co.playerLevel] = mo
			end

			for _, list in pairs(self._rankMOs) do
				for playerLevel, mo in pairs(list) do
					local preMo = list[playerLevel - 1]
					local preExp = preMo and preMo.totalNeedExp or 0
					local needExp = preExp + mo.config.needExp

					mo:initExp(preExp, needExp)
				end
			end
		end
	end

	return self._rankMOs[season]
end

function V3a2_BossRushModel:isCanClaimRankBonus(season)
	local seasonMo = V4a1_BossRushModel.instance:getSeasonMo(season)

	return seasonMo:isCanClaimRankBonus()
end

function V3a2_BossRushModel:getRankMo(season, level)
	local mos = self:getRankMos(season)

	return mos and mos[level]
end

function V3a2_BossRushModel:getRankLevelBg(season, rank)
	local rankMo = self:getRankMo(season, rank) or self:getRankMo(season, 1)

	return rankMo and rankMo.config.levelBg
end

function V3a2_BossRushModel:getRankSpLevelBg(season, rank)
	local rankMo = self:getRankMo(season, rank) or self:getRankMo(season, 1)

	return rankMo and rankMo.config.spLevelBg
end

function V3a2_BossRushModel:onRefreshHandBookInfo(info)
	for _, v in ipairs(info.galleryDetail) do
		local mo = self:getHandBookMo(v.type)

		if mo then
			mo:setInfo(v)
		end
	end
end

function V3a2_BossRushModel:getHandBookMos()
	if not self._handbookMOs then
		self._handbookMOs = {}

		local cos = self._config:getAllGalleryBossCos()

		if cos then
			for i, co in ipairs(cos) do
				local mo = V3a2_BossRush_HandBookMO.New()

				mo:initMO(co)

				self._handbookMOs[co.type] = mo
			end
		end
	end

	return self._handbookMOs
end

function V3a2_BossRushModel:getHandBookMo(bossType)
	local mos = self:getHandBookMos()

	return mos and mos[bossType]
end

function V3a2_BossRushModel:getHandBookMoByStage(stage, activityId)
	local bossType = self._config:getV3a2BossTypeByStage(stage, activityId)
	local mo = bossType and self:getHandBookMo(bossType)

	return mo
end

function V3a2_BossRushModel:getStrategyByStage(stage)
	local bossType = self._config:getV3a2BossTypeByStage(stage)
	local mo = self:getHandBookMoByStage(bossType)

	if mo then
		return BossRushConfig.instance:getBossRecommendStrategy(bossType)
	end
end

function V3a2_BossRushModel:getHandBookGroupMos(season)
	season = season or 1

	if not self._handbookGroupMOs then
		self._handbookGroupMOs = {}

		local mos = self:getHandBookMos()

		if mos then
			for i, mo in pairs(mos) do
				if mo.config.offline == 0 then
					local _season = mo.season

					if not self._handbookGroupMOs[_season] then
						self._handbookGroupMOs[_season] = {}
					end

					local minType = mo.config.minType
					local groupMos = self._handbookGroupMOs[_season][minType]

					if not groupMos then
						groupMos = {
							bossGroup = {},
							config = lua_activity128_bosstype.configDict[minType]
						}
						self._handbookGroupMOs[_season][minType] = groupMos
					end

					table.insert(groupMos.bossGroup, mo)
				end
			end
		end
	end

	return self._handbookGroupMOs[season]
end

function V3a2_BossRushModel:setScore(extra)
	local baseScore = extra and extra.baseScore or 0
	local ruleScore = extra and extra.ruleScore or 0

	self._score = {
		baseScore = baseScore,
		ruleScore = ruleScore,
		totalScore = baseScore + ruleScore
	}
end

function V3a2_BossRushModel:getScore()
	return self._score or {}
end

function V3a2_BossRushModel:getTotalScore()
	local score = self:getScore()

	return score and score.totalScore or 0
end

function V3a2_BossRushModel:checkIsNewHighestPointRecord(stage)
	return self:getTotalScore() > BossRushModel.instance:getHighestPoint(stage)
end

function V3a2_BossRushModel:setAssistMo(assistMo, index)
	local stage, _, actId = BossRushModel.instance:getBattleStageAndLayer()

	if not self._assistMos then
		self._assistMos = {}
	end

	if not self._assistMos[actId] then
		self._assistMos[actId] = {}
	end

	local mo = self._assistMos[actId][stage] or HeroSingleGroupMO.New()

	mo:init(index, assistMo.heroUid)
	mo:setAssist(assistMo)

	self._assistMos[actId][stage] = mo

	self:setEditorAssistMo(assistMo)
end

function V3a2_BossRushModel:getAssistMo()
	local stage, _, actId = BossRushModel.instance:getBattleStageAndLayer()

	if not stage or not actId then
		return
	end

	if not self._assistMos then
		self._assistMos = {}
	end

	if not self._assistMos[actId] then
		self._assistMos[actId] = {}
	end

	return self._assistMos[actId][stage]
end

function V3a2_BossRushModel:setEditorAssistMo(assistMo)
	local stage, _, actId = BossRushModel.instance:getBattleStageAndLayer()

	if not self._editorAssistMos then
		self._editorAssistMos = {}
	end

	if not self._editorAssistMos[actId] then
		self._editorAssistMos[actId] = {}
	end

	self._editorAssistMos[actId][stage] = assistMo
end

function V3a2_BossRushModel:getEditorAssistMo()
	local stage, _, actId = BossRushModel.instance:getBattleStageAndLayer()

	if not stage or not actId then
		return
	end

	if not self._editorAssistMos then
		self._editorAssistMos = {}
	end

	if not self._editorAssistMos[actId] then
		self._editorAssistMos[actId] = {}
	end

	return self._editorAssistMos[actId][stage]
end

function V3a2_BossRushModel:clearAssist(isClearEditor)
	local stage, _, actId = BossRushModel.instance:getBattleStageAndLayer()

	if not stage or not actId then
		return
	end

	if self._assistMos and self._assistMos[actId] and self._assistMos[actId][stage] then
		self._assistMos[actId][stage] = nil
	end

	if isClearEditor and self._editorAssistMos and self._editorAssistMos[actId] and self._editorAssistMos[actId][stage] then
		self._editorAssistMos[actId][stage] = nil
	end
end

function V3a2_BossRushModel:clearAllAssist()
	self._assistMos = nil
	self._editorAssistMos = nil
end

V3a2_BossRushModel.instance = V3a2_BossRushModel.New()

return V3a2_BossRushModel
