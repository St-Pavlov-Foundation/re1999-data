﻿-- chunkname: @modules/logic/fight/view/FightNewProgressView.lua

module("modules.logic.fight.view.FightNewProgressView", package.seeall)

local FightNewProgressView = class("FightNewProgressView", FightBaseView)

function FightNewProgressView:onInitView()
	self.fightRoot = gohelper.findChild(self.viewGO, "root")
	self.progressHandleDict = {
		[FightEnum.ProgressId.Progress_5] = self.showFightConquerBattleProgress,
		[FightEnum.ProgressId.Progress_6] = self.showFightConquerBattleProgress,
		[FightEnum.ProgressId.Progress_500M] = self.showProgress500M
	}
end

function FightNewProgressView:addEvents()
	self:com_registMsg(FightMsgId.FightMaxProgressValueChange, self.onFightMaxProgressValueChange)
end

function FightNewProgressView:onFightMaxProgressValueChange(id)
	if id == 0 then
		return
	end

	local data = self.progressDic[id]

	if not data then
		return
	end

	self:showProgress(data)
end

function FightNewProgressView:onOpen()
	self.progressDic = FightDataHelper.fieldMgr.progressDic

	if not self.progressDic then
		return
	end

	for k, data in pairs(self.progressDic) do
		self:showProgress(data)
	end
end

function FightNewProgressView:showProgress(data)
	local handle = self.progressHandleDict[data.showId]

	if handle then
		handle(self)
	end
end

function FightNewProgressView:showFightConquerBattleProgress()
	local has5 = false
	local has6 = false

	for k, data in pairs(self.progressDic) do
		if data.showId == 5 then
			has5 = true
		elseif data.showId == 6 then
			has6 = true
		end
	end

	if has5 and has6 then
		if self.progress56View then
			return
		end

		local url = "ui/viewres/fight/fightassassinhpview.prefab"

		self.progress56View = self:com_openSubView(FightProgressConquerBattleView, url, self.fightRoot)
	end
end

function FightNewProgressView:showProgress500M()
	if self.progress500MView then
		return
	end

	local goRoot = gohelper.findChild(self.viewGO, "root/topLeftContent")

	self.progress500MView = self:com_openSubView(FightProgress500MView, "ui/viewres/fight/fighttower/fightprogressview.prefab", goRoot)
end

return FightNewProgressView
