-- chunkname: @modules/logic/bossrush/view/v3a9/fight/V3a9_BossRush_ExpandBondsHeroItem.lua

module("modules.logic.bossrush.view.v3a9.fight.V3a9_BossRush_ExpandBondsHeroItem", package.seeall)

local V3a9_BossRush_ExpandBondsHeroItem = class("V3a9_BossRush_ExpandBondsHeroItem", V3a9_BossRush_HeroItem)

function V3a9_BossRush_ExpandBondsHeroItem:_btnClickOnClick()
	V3a9_BossRush_ExpandBondsHeroItem.super._btnClickOnClick(self)
	V3a9_BossRushController.instance:dispatchEvent(V3a9_BossRushEvent.onClickBondHeroItem, self._heroId)
end

function V3a9_BossRush_ExpandBondsHeroItem:_refreshState()
	local empty = true
	local heroMo

	if self._heroId and self._heroId ~= 0 then
		heroMo = HeroModel.instance:getByHeroId(self._heroId)
	end

	local alpha = heroMo and 1 or 0.4
	local color = self._imageHeadIcon.color

	color.a = alpha
	self._imageHeadIcon.color = color

	local isEquiped = self._groupMo:isEquipHero(self._heroId)
	local isDeath = V3a9_BossRushModel.instance:isRestrict(self._heroId)

	gohelper.setActive(self._goequip.gameObject, isEquiped)
	gohelper.setActive(self._goban.gameObject, isDeath)
	gohelper.setActive(self._goHas.gameObject, true)
end

function V3a9_BossRush_ExpandBondsHeroItem:setParam(stage, groupMo)
	self._stage = stage
	self._groupMo = groupMo
end

return V3a9_BossRush_ExpandBondsHeroItem
