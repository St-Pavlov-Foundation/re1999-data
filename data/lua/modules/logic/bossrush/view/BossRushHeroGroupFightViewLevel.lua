-- chunkname: @modules/logic/bossrush/view/BossRushHeroGroupFightViewLevel.lua

module("modules.logic.bossrush.view.BossRushHeroGroupFightViewLevel", package.seeall)

local BossRushHeroGroupFightViewLevel = class("BossRushHeroGroupFightViewLevel", HeroGroupFightViewLevel)

function BossRushHeroGroupFightViewLevel:isShowDangerRoot()
	local stage, layer, actId = BossRushModel.instance:getBattleStageAndLayer()
	local isCurSeason = V4a1_BossRushModel.instance:isCurSeason(actId)

	if isCurSeason then
		if not self._skillBuffItem then
			local go = self:getResInst(self.viewContainer:getSetting().otherRes.dangerPanel, self._godanger.gameObject)

			self._skillBuffItem = MonoHelper.addLuaComOnceToGo(go, V4a1_BossRush_DangerPanel)

			self._skillBuffItem:setViewContainer(self.viewContainer)
		end

		local layerCo = BossRushConfig.instance:getEpisodeCO(stage, layer, actId)
		local isShow = self._skillBuffItem:onUpdateMO(0, layerCo.episodeId)

		return isShow
	end

	return false
end

function BossRushHeroGroupFightViewLevel:_btnenemyOnClick()
	local stage, layer, actId = BossRushModel.instance:getBattleStageAndLayer()

	EnemyInfoController.instance:openBossRushEnemyInfoView(actId, stage, layer, actId)
end

return BossRushHeroGroupFightViewLevel
