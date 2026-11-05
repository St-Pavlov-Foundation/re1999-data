-- chunkname: @modules/logic/bossrush/view/v4a1/V4a1_BossRush_ResultPanel.lua

module("modules.logic.bossrush.view.v4a1.V4a1_BossRush_ResultPanel", package.seeall)

local V4a1_BossRush_ResultPanel = class("V4a1_BossRush_ResultPanel", V3a2_BossRush_ResultPanel)

function V4a1_BossRush_ResultPanel:_editableInitView()
	V4a1_BossRush_ResultPanel.super._editableInitView(self)

	self._gorootdanger = gohelper.findChild(self.viewGO, "#go_score/Right/#go_danger")
	self._godanger = gohelper.findChild(self.viewGO, "#go_score/Right/#go_danger/#go_danger")
end

function V4a1_BossRush_ResultPanel:_openResultView()
	ViewMgr.instance:openView(ViewName.V4a1_BossRush_ResultView, self.viewParam)
	self:closeThis()
end

function V4a1_BossRush_ResultPanel:onOpen()
	V4a1_BossRush_ResultPanel.super.onOpen(self)

	local stage, layer, actId = BossRushModel.instance:getBattleStageAndLayer()
	local isCurSeason = V4a1_BossRushModel.instance:isCurSeason(actId)
	local isShow = false

	if isCurSeason then
		if not self._skillBuffItem then
			local go = gohelper.findChild(self.viewGO, "#go_score/Right/#go_danger/#go_danger/dangerrankview")

			self._skillBuffItem = MonoHelper.addLuaComOnceToGo(go, V4a1_BossRush_DangerPanel)

			self._skillBuffItem:setViewContainer(self.viewContainer)
		end

		local layerCo = BossRushConfig.instance:getEpisodeCO(stage, layer, actId)

		isShow = self._skillBuffItem:onUpdateMO(self.fightScore, layerCo.episodeId, nil, true, true)
	end

	gohelper.setActive(self._godanger, isShow)
	gohelper.setActive(self._gorootdanger, isShow)
end

function V4a1_BossRush_ResultPanel:_animFinishCallback()
	V4a1_BossRush_ResultPanel.super._animFinishCallback(self)

	if self._skillBuffItem then
		self._skillBuffItem:onPlayAnim()
	end
end

return V4a1_BossRush_ResultPanel
