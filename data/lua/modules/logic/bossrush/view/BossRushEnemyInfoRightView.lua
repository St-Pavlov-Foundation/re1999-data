-- chunkname: @modules/logic/bossrush/view/BossRushEnemyInfoRightView.lua

module("modules.logic.bossrush.view.BossRushEnemyInfoRightView", package.seeall)

local BossRushEnemyInfoRightView = class("BossRushEnemyInfoRightView", EnemyInfoRightView)

function BossRushEnemyInfoRightView:_editableInitView()
	BossRushEnemyInfoRightView.super._editableInitView(self)

	self._gohp = gohelper.findChild(self.viewGO, "#go_right_container/#go_header/hp")
	self._godanger = gohelper.findChild(self.viewGO, "#go_right_container/#go_skill_container/#go_danger")
end

function BossRushEnemyInfoRightView:refreshUI()
	BossRushEnemyInfoRightView.super.refreshUI(self)
	self:_refreshSkillBuff()
end

function BossRushEnemyInfoRightView:_refreshSkillBuff()
	local activityId = self.viewParam.activityId
	local stage = self.viewParam.stage
	local layer = self.viewParam.layer or 1
	local isCurSeason = V4a1_BossRushModel.instance:isCurSeason(activityId)
	local isShow = false

	if isCurSeason then
		if not self._skillBuffItem then
			local go = self:getResInst(self.viewContainer:getSetting().otherRes.dangerPanel, self._godanger.gameObject)

			self._skillBuffItem = MonoHelper.addLuaComOnceToGo(go, V4a1_BossRush_DangerPanel)

			self._skillBuffItem:setViewContainer(self.viewContainer)
		end

		local layerCo = BossRushConfig.instance:getEpisodeCO(stage, layer, activityId)

		isShow = self._skillBuffItem:onUpdateMO(0, layerCo.episodeId, self.monsterId)

		recthelper.setAnchor(self._gonoskill.transform, 244, -29)
	end

	gohelper.setActive(self._godanger, isShow)
	gohelper.setActive(self._gohp, not self.isBoss or not isCurSeason)
end

return BossRushEnemyInfoRightView
