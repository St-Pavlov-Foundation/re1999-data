-- chunkname: @modules/logic/bossrush/view/v4a1/V4a1_BossRush_LevelReviewView.lua

module("modules.logic.bossrush.view.v4a1.V4a1_BossRush_LevelReviewView", package.seeall)

local V4a1_BossRush_LevelReviewView = class("V4a1_BossRush_LevelReviewView", V3a2_BossRush_LevelDetailView)

function V4a1_BossRush_LevelReviewView:onOpen()
	V4a1_BossRush_LevelReviewView.super.onOpen(self)
	gohelper.setActive(self._btnbonus.gameObject, false)
end

function V4a1_BossRush_LevelReviewView:_btnSearchIconOnClick()
	EnemyInfoController.instance:openBossRushEnemyInfoView(self._activityId, self._stage, self._layer)
end

function V4a1_BossRush_LevelReviewView:_enterFightScene()
	BossRushController.instance:enterFightScene(self._stage, self._layer, self._activityId)
end

function V4a1_BossRush_LevelReviewView:getHeightScore()
	local handbookMo = V4a1_BossRushModel.instance:getHandBookMoByActStage(self._activityId, self._stage)
	local highestPoint = handbookMo and handbookMo.heightScore or 0

	return highestPoint
end

return V4a1_BossRush_LevelReviewView
