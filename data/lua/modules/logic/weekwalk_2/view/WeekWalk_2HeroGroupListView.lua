module("modules.logic.weekwalk_2.view.WeekWalk_2HeroGroupListView", package.seeall)

slot0 = class("WeekWalk_2HeroGroupListView", HeroGroupListView)

function slot0.addEvents(slot0)
	uv0.super.addEvents(slot0)
	slot0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnUseRecommendGroupFinish, slot0._checkRestrictHero, slot0)
end

function slot0._getHeroItemCls(slot0)
	return WeekWalk_2HeroGroupHeroItem
end

function slot0._checkRestrictHero(slot0)
	slot1 = {}

	for slot5, slot6 in ipairs(slot0._heroItemList) do
		if slot6:checkWeekWalkCd() then
			table.insert(slot1, slot7)
		end
	end

	if #slot1 == 0 then
		return
	end

	UIBlockMgr.instance:startBlock("removeWeekWalkInCdHero")

	slot0._heroInCdList = slot1

	TaskDispatcher.runDelay(slot0._removeWeekWalkInCdHero, slot0, 1.5)
end

function slot0._removeWeekWalkInCdHero(slot0)
	UIBlockMgr.instance:endBlock("removeWeekWalkInCdHero")

	if not slot0._heroInCdList then
		return
	end

	slot0._heroInCdList = nil

	for slot5, slot6 in ipairs(slot0._heroInCdList) do
		HeroSingleGroupModel.instance:remove(slot6)
	end

	for slot5, slot6 in ipairs(slot0._heroItemList) do
		slot6:resetGrayFactor()
	end

	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
end

function slot0.onDestroyView(slot0)
	UIBlockMgr.instance:endBlock("removeWeekWalkInCdHero")
	TaskDispatcher.cancelTask(slot0._removeWeekWalkInCdHero, slot0)
	uv0.super.onDestroyView(slot0)
end

return slot0
