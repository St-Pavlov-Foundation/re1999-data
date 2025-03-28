module("modules.logic.herogroup.view.HeroGroupFightWeekWalk_2View", package.seeall)

slot0 = class("HeroGroupFightWeekWalk_2View", BaseView)

function slot0.onInitView(slot0)
	slot0._dropherogroup = gohelper.findChildDropdown(slot0.viewGO, "#go_container/btnContain/horizontal/#drop_herogroup")
end

function slot0.addEvents(slot0)
	slot0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnModifyGroupSelectIndex, slot0._onModifyGroupSelectIndex, slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._onModifyGroupSelectIndex(slot0)
	slot0:_updateWeekWalkGroupSelectIndex()
end

function slot0.onOpen(slot0)
	slot0._episodeId = HeroGroupModel.instance.episodeId
	slot0.episodeConfig = DungeonConfig.instance:getEpisodeCO(slot0._episodeId)
	slot0._chapterConfig = DungeonConfig.instance:getChapterCO(slot0.episodeConfig.chapterId)
end

function slot0.onOpenFinish(slot0)
	TaskDispatcher.cancelTask(slot0._setWeekWalkGroupSelectIndex, slot0)
	TaskDispatcher.runDelay(slot0._setWeekWalkGroupSelectIndex, slot0, 0)
end

function slot0._setWeekWalkGroupSelectIndex(slot0)
	if slot0._chapterConfig.type ~= DungeonEnum.ChapterType.WeekWalk_2 then
		return
	end

	slot1 = WeekWalk_2Model.instance:getCurMapInfo()
	slot4 = slot1:getBattleInfoByBattleId(HeroGroupModel.instance.battleId)
	slot5 = HeroGroupModel.instance.curGroupSelectIndex

	if slot1:getLayer() == WeekWalk_2Enum.FirstDeepLayer and slot4.heroGroupSelect ~= slot5 or slot2 ~= WeekWalk_2Enum.FirstDeepLayer and slot4.heroGroupSelect ~= 0 and slot4.heroGroupSelect ~= slot5 then
		Weekwalk_2Rpc.instance:sendWeekwalkVer2ChangeHeroGroupSelectRequest(slot1.id, slot3, slot5)
	end

	if slot2 ~= WeekWalk_2Enum.FirstDeepLayer and slot4.heroGroupSelect == 0 and WeekWalk_2Model.instance:getBattleInfoByLayerAndIndex(slot2 - 1, slot4.index) and slot8.heroGroupSelect ~= 0 and slot8.heroGroupSelect - 1 >= 0 and slot9 <= 3 then
		slot0._changeIndex = slot9

		if slot8.heroGroupSelect == slot5 then
			slot0:_updateWeekWalkGroupSelectIndex()

			return
		end

		UIBlockMgrExtend.setNeedCircleMv(false)
		UIBlockMgr.instance:startBlock("HeroGroupFightWeekWalk_2ViewChangeGroup")
		TaskDispatcher.cancelTask(slot0._changeGroupIndex, slot0)
		TaskDispatcher.runDelay(slot0._changeGroupIndex, slot0, slot0:_anyHeroInCd() and 2.2 or 0.8)
	end
end

function slot0._anyHeroInCd(slot0)
	for slot4 = 1, ModuleEnum.MaxHeroCountInGroup do
		slot6 = HeroSingleGroupModel.instance:getById(slot4) and slot5:getHeroMO()

		if slot6 and WeekWalkModel.instance:getCurMapHeroCd(slot6.config.id) and slot7 > 0 then
			return true
		end
	end
end

function slot0._changeGroupIndex(slot0)
	UIBlockMgrExtend.setNeedCircleMv(true)
	UIBlockMgr.instance:endBlock("HeroGroupFightWeekWalk_2ViewChangeGroup")

	slot1 = slot0.viewContainer:getHeroGroupFightView()

	slot1:setGroupChangeToast(ToastEnum.WeekWalkChangeGroup)
	slot0._dropherogroup:SetValue(slot0._changeIndex)
	slot1:setGroupChangeToast(nil)
end

function slot0._updateWeekWalkGroupSelectIndex(slot0)
	if slot0._chapterConfig.type ~= DungeonEnum.ChapterType.WeekWalk_2 then
		return
	end

	slot1 = WeekWalk_2Model.instance:getCurMapInfo()
	slot2 = slot1:getLayer()

	if slot1:getBattleInfoByBattleId(HeroGroupModel.instance.battleId).heroGroupSelect ~= HeroGroupModel.instance.curGroupSelectIndex then
		Weekwalk_2Rpc.instance:sendWeekwalkVer2ChangeHeroGroupSelectRequest(slot1.id, slot3, slot5)
	end
end

function slot0.onClose(slot0)
	UIBlockMgrExtend.setNeedCircleMv(true)
	UIBlockMgr.instance:endBlock("HeroGroupFightWeekWalk_2ViewChangeGroup")
	TaskDispatcher.cancelTask(slot0._changeGroupIndex, slot0)
	TaskDispatcher.cancelTask(slot0._setWeekWalkGroupSelectIndex, slot0)
end

return slot0
