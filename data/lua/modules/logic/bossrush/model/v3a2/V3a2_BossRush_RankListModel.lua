﻿-- chunkname: @modules/logic/bossrush/model/v3a2/V3a2_BossRush_RankListModel.lua

module("modules.logic.bossrush.model.v3a2.V3a2_BossRush_RankListModel", package.seeall)

local V3a2_BossRush_RankListModel = class("V3a2_BossRush_RankListModel", ListScrollModel)

function V3a2_BossRush_RankListModel:setMoList()
	local moList = {}

	for _, mo in pairs(V3a2_BossRushModel.instance:getRankMos()) do
		if not string.nilorempty(mo.config.bonus) then
			table.insert(moList, mo)
		end
	end

	table.sort(moList, self.sort)

	for i = 1, #moList do
		local rank = moList[i - 1] and moList[i - 1].config.playerLevel or 0

		moList[i]:setPreRank(rank)
	end

	for i = 1, V3a2BossRushEnum.BossRankLockCount do
		local mo = self:getLockMo(i)

		mo:setLock(i == V3a2BossRushEnum.BossRankLockCount, i)
		table.insert(moList, mo)
	end

	self:setList(moList)
end

function V3a2_BossRush_RankListModel:getLockMo(index)
	if not self._lockMos then
		self._lockMos = {}
	end

	local mo = self._lockMos[index]

	if not mo then
		mo = V3a2_BossRush_RankMO.New()

		table.insert(self._lockMos, mo)
	end

	return mo
end

function V3a2_BossRush_RankListModel.sort(a, b)
	if a.isNoraml ~= b.isNoraml then
		return a.isNoraml
	end

	return a.playerLevel < b.playerLevel
end

V3a2_BossRush_RankListModel.instance = V3a2_BossRush_RankListModel.New()

return V3a2_BossRush_RankListModel
