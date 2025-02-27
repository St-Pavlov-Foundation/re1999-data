module("modules.logic.weekwalk_2.view.WeekWalk_2HeroGroupHeroItem", package.seeall)

slot0 = class("WeekWalk_2HeroGroupHeroItem", HeroGroupHeroItem)

function slot0.checkWeekWalkCd(slot0)
	if slot0._heroMO ~= nil and slot0.monsterCO == nil then
		if WeekWalk_2Model.instance:getCurMapHeroCd(slot0._heroMO.config.id) > 0 then
			slot0._playDeathAnim = true

			slot0:playAnim("herogroup_hero_deal")

			slot0.tweenid = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.5, slot0.setGrayFactor, nil, slot0)

			return slot0._heroMO.id
		else
			slot0._commonHeroCard:setGrayScale(false)
		end
	end
end

return slot0
