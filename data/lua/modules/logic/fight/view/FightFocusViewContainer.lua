-- chunkname: @modules/logic/fight/view/FightFocusViewContainer.lua

module("modules.logic.fight.view.FightFocusViewContainer", package.seeall)

local FightFocusViewContainer = class("FightFocusViewContainer", BaseViewContainer)

function FightFocusViewContainer:buildViews()
	local view = {
		FightFocusView.New(),
		TabViewGroup.New(1, "fightinfocontainer/skilltipview")
	}

	if BossRushController.instance:isInBossRushFight() then
		self._bossRushFightFocusView = BossRushFightFocusView.New()

		table.insert(view, self._bossRushFightFocusView)
	end

	return view
end

function FightFocusViewContainer:onContainerClickModalMask()
	self:closeThis()
end

function FightFocusViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._skillTipView = SkillTipView.New()

		return {
			self._skillTipView
		}
	end
end

function FightFocusViewContainer:switchTab(tabId)
	self:dispatchEvent(ViewEvent.ToSwitchTab, 1, tabId)
end

function FightFocusViewContainer:showSkillTipView(info, isCharacter, entityId)
	self._skillTipView:showInfo(info, isCharacter, entityId)
end

function FightFocusViewContainer:hideSkillTipView()
	self._skillTipView:hideInfo()
end

function FightFocusViewContainer:playOpenTransition()
	FightFocusViewContainer.super.playOpenTransition(self, {
		anim = "open"
	})
end

function FightFocusViewContainer:playCloseTransition()
	FightFocusViewContainer.super.playCloseTransition(self, {
		anim = "close"
	})
end

function FightFocusViewContainer:onRefreshEntityMO(entityMO)
	if self._bossRushFightFocusView then
		self._bossRushFightFocusView:onRefreshEntityMO(entityMO)
	end
end

return FightFocusViewContainer
