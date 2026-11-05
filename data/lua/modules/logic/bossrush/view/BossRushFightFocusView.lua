-- chunkname: @modules/logic/bossrush/view/BossRushFightFocusView.lua

module("modules.logic.bossrush.view.BossRushFightFocusView", package.seeall)

local BossRushFightFocusView = class("BossRushFightFocusView", BaseView)

function BossRushFightFocusView:onInitView()
	self._gorootdanger = gohelper.findChild(self.viewGO, "fightinfocontainer/#go_infoView/content/#go_danger")
	self._godanger = gohelper.findChild(self.viewGO, "fightinfocontainer/#go_infoView/content/#go_danger/#go_danger")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function BossRushFightFocusView:addEvents()
	FightController.instance:registerCallback(FightEvent.OnIndicatorChange, self._onIndicatorChange, self)
end

function BossRushFightFocusView:removeEvents()
	FightController.instance:unregisterCallback(FightEvent.OnIndicatorChange, self._onIndicatorChange, self)
end

function BossRushFightFocusView:_onIndicatorChange(indicatorId)
	if indicatorId == FightEnum.IndicatorId.V1a4_BossRush_ig_ScoreTips or indicatorId == FightEnum.IndicatorId.ZongMaoTechniqueScore or indicatorId == FightEnum.IndicatorId.Rouge2Boss then
		self:_refreshScore()
	end
end

function BossRushFightFocusView:_refreshScore()
	if self._skillBuffItem and self._episodeId and self._entityMO and self._isCurSeason then
		local isShow = false

		if self._entityMO:isEnemySide() then
			local data = FightDataHelper.fieldMgr.indicatorDict[FightEnum.IndicatorId.V1a4_BossRush_ig_ScoreTips]
			local score = data and data.num or 0

			isShow = self._skillBuffItem:onUpdateMO(score, self._episodeId, self._entityMO.modelId)
		end

		gohelper.setActive(self._godanger, isShow)
	end
end

function BossRushFightFocusView:_editableInitView()
	return
end

function BossRushFightFocusView:onUpdateParam()
	return
end

function BossRushFightFocusView:onOpen()
	return
end

function BossRushFightFocusView:onRefreshEntityMO(entityMO)
	self._entityMO = entityMO

	local stage, layer, actId = BossRushModel.instance:getBattleStageAndLayer()

	self._isCurSeason = V4a1_BossRushModel.instance:isCurSeason(actId)

	if self._isCurSeason then
		if not self._skillBuffItem then
			local go = self:getResInst(self.viewContainer:getSetting().otherRes.dangerPanel, self._godanger.gameObject)

			self._skillBuffItem = MonoHelper.addLuaComOnceToGo(go, V4a1_BossRush_DangerPanel)

			self._skillBuffItem:setViewContainer(self.viewContainer)
		end

		local layerCo = BossRushConfig.instance:getEpisodeCO(stage, layer, actId)

		self._episodeId = layerCo.episodeId

		self:_refreshScore()
	end
end

function BossRushFightFocusView:onClose()
	return
end

function BossRushFightFocusView:onDestroyView()
	return
end

return BossRushFightFocusView
