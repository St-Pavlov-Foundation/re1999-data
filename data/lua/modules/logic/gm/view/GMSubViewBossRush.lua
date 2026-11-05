-- chunkname: @modules/logic/gm/view/GMSubViewBossRush.lua

module("modules.logic.gm.view.GMSubViewBossRush", package.seeall)

local GMSubViewBossRush = class("GMSubViewBossRush", GMSubViewBase)

function GMSubViewBossRush:ctor()
	self.tabName = "鬃毛邮报"
end

function GMSubViewBossRush:addLineIndex()
	self.lineIndex = self.lineIndex + 1
end

function GMSubViewBossRush:getLineGroup()
	return "L" .. self.lineIndex
end

local selectActIdIndex = "GMSubViewBossRush_selectActIdIndex"
local stageSaveKey = "GMSubViewBossRush_stageSaveKey"
local stageHighestScoreSaveKey = "GMSubViewBossRush_stageHighestScoreSaveKey"
local EpisodeIdSaveKey = "GMSubViewBossRush_EpisodeIdSaveKey"
local selectSeasonCurrencyIndex = "GMSubViewBossRush_selectSeasonCurrencyIndex"
local seasonCurrencyNum = "GMSubViewBossRush_seasonCurrencyNum"

function GMSubViewBossRush:initViewContent()
	if self._inited then
		return
	end

	GMSubViewBase.initViewContent(self)

	self.lineIndex = 1

	self:addLabel(self:getLineGroup(), "关卡id")

	local episodeId = PlayerPrefsHelper.getString(EpisodeIdSaveKey, "")

	self._episodeIdInput = self:addInputText(self:getLineGroup(), episodeId, "关卡ID", self._inputEpisodeId, self, {
		w = 300
	})

	self:addButton(self:getLineGroup(), "进入关卡", self._enterEpisode, self)
	self:addLineIndex()
	self:addLabel(self:getLineGroup(), "活动id")

	self._actIdsDrop = self:addDropDown(self:getLineGroup(), "活动Id：", nil, self._onAcIdsDropValueChange, self, {
		w = 300,
		tempH = 300
	})

	self:addButton(self:getLineGroup(), "进入活动", self._openMainView, self)
	self:addLineIndex()
	self:addLabel(self:getLineGroup(), "Stage")

	self._stagesDrop = self:addDropDown(self:getLineGroup(), "stage", nil, self._onStageDropValueChange, self, {
		w = 500,
		tempH = 300
	})

	self:addLineIndex()
	self:addLabel(self:getLineGroup(), "最高分")

	local heightScore = PlayerPrefsHelper.getNumber(stageHighestScoreSaveKey, "")

	self._heightScoreInput = self:addInputText(self:getLineGroup(), heightScore, "最高分", self._inputHeightScore, self, {
		w = 300
	})

	self:addButton(self:getLineGroup(), "设置", self._setHeightScore, self)
	self:addButton(self:getLineGroup(), "重置最高分", self._resetHeightScore, self)
	self:addLineIndex()
	self:addLabel(self:getLineGroup(), "等级代币")

	self._seasonCurrencyDrop = self:addDropDown(self:getLineGroup(), "赛季ID：", nil, self._onSeasonCurrencyDropValueChange, self, {
		w = 400,
		tempH = 300
	})

	local currencyNum = PlayerPrefsHelper.getString(seasonCurrencyNum, 0)

	self._currencyNumInput = self:addInputText(self:getLineGroup(), currencyNum, "增加数量", self._inputSeasonCurrency, self, {
		w = 200
	})

	self:addButton(self:getLineGroup(), "Add", self._addSeasonCurrency, self)

	self._currencyNumTxt = self:addLabel(self:getLineGroup(), "", {
		w = 450,
		c = "#FF5C00",
		fsize = 28
	})

	self:addLineIndex()
	self:addButton(self:getLineGroup(), "重置解锁次数", self._resetHandbookUnlockCount, self)
	self:addLineIndex()

	self.tipTxt = self:addLabel(self:getLineGroup(), self:_getTip(), {
		w = 1000,
		c = "#FF5C00"
	})

	self:_initActIdsDrop()
	self:_initSeasonCurrencyDrop()

	self._inited = true
end

function GMSubViewBossRush:_inputActId()
	self:_setTip()
end

function GMSubViewBossRush:_inputEpisodeId()
	self:_setTip()
end

function GMSubViewBossRush:_getActId()
	return BossRushConfig.instance:getActivityId()
end

function GMSubViewBossRush:_getTip()
	return self._tipStr or ""
end

function GMSubViewBossRush:_setTip(tip)
	self._tipStr = tip
	self.tipTxt.text = tip
end

function GMSubViewBossRush:_initActIdsDrop()
	local options = {}

	self._actIds = {}

	local list = V4a1_BossRushModel.instance:getSeasonAllActIds()

	for actId in pairs(list) do
		table.insert(self._actIds, actId)
	end

	table.sort(self._actIds, function(a, b)
		local a_str = tostring(math.abs(a))
		local b_str = tostring(math.abs(b))
		local a_num = tonumber(string.sub(a_str, 2, 3))
		local b_num = tonumber(string.sub(b_str, 2, 3))

		return b_num < a_num
	end)

	for _, actId in ipairs(self._actIds) do
		table.insert(options, tostring(actId))
	end

	self._selectActIdIndex = PlayerPrefsHelper.getNumber(selectActIdIndex, 1)

	if self._actIdsDrop then
		self._actIdsDrop:ClearOptions()
		self._actIdsDrop:AddOptions(options)
		self._actIdsDrop:SetValue(self._selectActIdIndex - 1)
	end

	self:_initStageDrop()
end

function GMSubViewBossRush:_onAcIdsDropValueChange(index)
	self._selectActIdIndex = index + 1

	PlayerPrefsHelper.setNumber(selectActIdIndex, self._selectActIdIndex)
	self:_initStageDrop()
end

function GMSubViewBossRush:_openMainView()
	local actId = self._actIds[self._selectActIdIndex]

	if actId ~= self:_getActId() then
		function Activity128Config:getActivityId(index)
			if index == 2 then
				return
			end

			return actId
		end

		function Activity128Model:getActivityId()
			return actId
		end

		function Activity128Config:getActivityIds()
			return {
				actId
			}
		end
	end

	BossRushController.instance:openV3a2MainView()
end

function GMSubViewBossRush:_initStageDrop()
	local options = {}
	local actId = self._actIds[self._selectActIdIndex]

	self._stages = {}

	local mos = V3a9_BossRushModel.instance:getBossDetailMos(actId)

	if mos then
		for _, mo in ipairs(mos) do
			local str = string.format("%s-%s", mo.stage, mo.stageCO.name)

			table.insert(options, str)
			table.insert(self._stages, mo.stage)
		end
	end

	self._selectStageIndex = PlayerPrefsHelper.getNumber(stageSaveKey, 1)

	if self._stagesDrop then
		self._stagesDrop:ClearOptions()
		self._stagesDrop:AddOptions(options)
		self._stagesDrop:SetValue(self._selectStageIndex - 1)
	end
end

function GMSubViewBossRush:_onStageDropValueChange(index)
	self._selectStageIndex = index + 1

	PlayerPrefsHelper.setNumber(stageSaveKey, self._selectStageIndex)
end

function GMSubViewBossRush:_inputHeightScore()
	self:_setTip()
end

function GMSubViewBossRush:_setHeightScore()
	local str = self._heightScoreInput:GetText()

	if string.nilorempty(str) then
		return
	end

	local actId = self._actIds[self._selectActIdIndex]
	local stage = self._stages[self._selectStageIndex]
	local info = string.format("add Activity128Point %s %s %s 1 0", actId, stage, str)

	GMRpc.instance:sendGMRequest(info)
	GameFacade.showToast(ToastEnum.IconId, info)
	PlayerPrefsHelper.setNumber(stageHighestScoreSaveKey, tonumber(str))
end

function GMSubViewBossRush:_resetHeightScore()
	local actId = self._actIds[self._selectActIdIndex]
	local stage = self._stages[self._selectStageIndex]
	local info = string.format("delete Activity128 %s %s", actId, stage)

	GMRpc.instance:sendGMRequest(info)
	GameFacade.showToast(ToastEnum.IconId, info)
end

function GMSubViewBossRush:_resetHandbookUnlockCount()
	local actId = self:_getActId()
	local info = string.format("resetAct128UnlockCount %s", actId)

	GMRpc.instance:sendGMRequest(info)
end

function GMSubViewBossRush:_enterEpisode()
	local episodeIdStr = self._episodeIdInput:GetText()

	if string.nilorempty(episodeIdStr) then
		self:_setTip("未输入关卡id")

		return
	end

	local episodeId = tonumber(episodeIdStr)

	V4a1_BossRushController.instance:enterEpisode(episodeId)
	PlayerPrefsHelper.setString(EpisodeIdSaveKey, episodeIdStr)
end

function GMSubViewBossRush:_initSeasonCurrencyDrop()
	local mos = V4a1_BossRushModel.instance:getSeasonMos()
	local options = {}
	local actIds = {}

	if mos then
		for _, mo in ipairs(mos) do
			local season = mo.season
			local str = string.format("赛季%s-%s", season, mo.co.expMaterial)

			table.insert(options, str)
			table.insert(actIds, V3a9_BossRushModel.instance:getActIdBySeason(season))
		end
	end

	BossRushRpc.instance:sendGet128ActIdsInfosRequest(actIds, self._refreshSeasonCurrencyNum, self)

	self._selectSeasonCurrencyIndex = PlayerPrefsHelper.getNumber(selectSeasonCurrencyIndex, 1)

	if self._seasonCurrencyDrop then
		self._seasonCurrencyDrop:ClearOptions()
		self._seasonCurrencyDrop:AddOptions(options)
		self._seasonCurrencyDrop:SetValue(self._selectSeasonCurrencyIndex - 1)
	end
end

function GMSubViewBossRush:_refreshSeasonCurrencyNum()
	local season = self._selectSeasonCurrencyIndex
	local mo = V4a1_BossRushModel.instance:getSeasonMo(season)

	if mo then
		local expMaterial = mo.expMaterial
		local num = ItemModel.instance:getItemQuantity(expMaterial[1], expMaterial[2])
		local exp, next = V3a2_BossRushModel.instance:getRankExpProgress(season)

		self._currencyNumTxt.text = string.format("当前数量：%s,\n当前等级：%s,已领取：%s\n当前进度：%s,目标经验：%s", num, mo.level, mo.claimLevel, exp, next)
	end
end

function GMSubViewBossRush:_onSeasonCurrencyDropValueChange(index)
	self._selectSeasonCurrencyIndex = index + 1

	PlayerPrefsHelper.setNumber(selectSeasonCurrencyIndex, self._selectSeasonCurrencyIndex)
	self:_refreshSeasonCurrencyNum()
end

function GMSubViewBossRush:_inputSeasonCurrency()
	local num = self._currencyNumInput:GetText()

	if not string.nilorempty(num) then
		PlayerPrefsHelper.setNumber(seasonCurrencyNum, tonumber(num))
	end

	self:_setTip()
end

function GMSubViewBossRush:_addSeasonCurrency()
	local num = self._currencyNumInput:GetText()

	if not string.nilorempty(num) then
		local mo = V4a1_BossRushModel.instance:getSeasonMo(self._selectSeasonCurrencyIndex)
		local expMaterial = mo.co.expMaterial
		local info = string.format("add material %s#%s", expMaterial, num)

		GMRpc.instance:sendGMRequest(info)
		GameFacade.showToast(ToastEnum.IconId, info)
	end
end

return GMSubViewBossRush
