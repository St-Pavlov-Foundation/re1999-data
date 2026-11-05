-- chunkname: @modules/logic/bossrush/model/v3a2/V3a2_BossRush_HandBookListModel.lua

module("modules.logic.bossrush.model.v3a2.V3a2_BossRush_HandBookListModel", package.seeall)

local V3a2_BossRush_HandBookListModel = class("V3a2_BossRush_HandBookListModel", ListScrollModel)

function V3a2_BossRush_HandBookListModel:setMoList()
	self._season = self._season or 1

	local moList = self:getMoList(self._season)

	self:setList(moList)
end

function V3a2_BossRush_HandBookListModel:getMoList(season)
	local moList = {}
	local mos = V3a2_BossRushModel.instance:getHandBookGroupMos(season)

	if mos then
		for _, mo in pairs(mos) do
			table.sort(mo.bossGroup, self.sortBoss)
			table.insert(moList, mo)
		end
	end

	table.sort(moList, self.sortGroup)

	return moList
end

function V3a2_BossRush_HandBookListModel.sortGroup(a, b)
	local a_sort = a.config.sort
	local b_sort = b.config.sort

	if a_sort ~= b_sort then
		return a_sort < b_sort
	end

	return a.config.mintype < b.config.mintype
end

function V3a2_BossRush_HandBookListModel.sortBoss(a, b)
	local a_sort = a.config.sort
	local b_sort = b.config.sort

	if a_sort ~= b_sort then
		return a_sort < b_sort
	end

	return a:getBossType() < b:getBossType()
end

function V3a2_BossRush_HandBookListModel:onSelect(mo)
	self._selectMo = mo

	BossRushController.instance:dispatchEvent(BossRushEvent.V3a2_BossRush_HandBook_SelectMonster, mo)
end

function V3a2_BossRush_HandBookListModel:getSelectMo()
	return self._selectMo
end

function V3a2_BossRush_HandBookListModel:onSelectSeason(season)
	self._season = season

	BossRushController.instance:dispatchEvent(BossRushEvent.onSelectHandBookSeason, season)
end

function V3a2_BossRush_HandBookListModel:getSelectSeason()
	return self._season
end

function V3a2_BossRush_HandBookListModel:getFirstCanClaimHandBookMo()
	local mos = V4a1_BossRushModel.instance:getSeasonMos()

	if mos then
		for _, mo in ipairs(mos) do
			local season = mo.season
			local claimGroupIndex, canCliamBossMo = self:getCanClaimSeasonHandBookMo(season)

			if claimGroupIndex and canCliamBossMo then
				return canCliamBossMo
			end
		end

		local moList = self:getMoList(1)

		if moList then
			return moList[1].bossGroup[1]
		end
	end
end

function V3a2_BossRush_HandBookListModel:getCanClaimSeasonHandBookMo(season)
	local claimGroupIndex = 0
	local canCliamBossMo
	local moList = self:getMoList(season)

	for i, v in ipairs(moList) do
		local isCanCliam, canCliamMo = self:_hasClaimBounsGroup(v.bossGroup)

		if isCanCliam and (i < claimGroupIndex or claimGroupIndex == 0) then
			claimGroupIndex = i
			canCliamBossMo = canCliamMo
		end
	end

	if claimGroupIndex > 0 then
		return claimGroupIndex, canCliamBossMo
	end
end

function V3a2_BossRush_HandBookListModel:_hasClaimBounsGroup(bossGroup)
	if bossGroup then
		for _, mo in ipairs(bossGroup) do
			if mo:hasClaimBonus() then
				return true, mo
			end
		end
	end
end

V3a2_BossRush_HandBookListModel.instance = V3a2_BossRush_HandBookListModel.New()

return V3a2_BossRush_HandBookListModel
