module("modules.logic.weekwalk_2.view.WeekWalk_2HeroGroupFightView_Level", package.seeall)

slot0 = class("WeekWalk_2HeroGroupFightView_Level", HeroGroupFightViewLevel)

function slot0._refreshTarget(slot0)
	gohelper.setActive(slot0._gotargetlist, true)

	slot3 = DungeonConfig.instance:getChapterCO(DungeonConfig.instance:getEpisodeCO(slot0._episodeId).chapterId).type == DungeonEnum.ChapterType.Hard

	gohelper.setActive(slot0._gohardEffect, slot3)
	gohelper.setActive(slot0._gobalanceEffect, HeroGroupBalanceHelper.getIsBalanceMode())

	slot0._isHardMode = slot3
	slot4, slot5 = nil

	if slot3 then
		slot5 = slot0._episodeId
		slot4 = slot1.preEpisode
	else
		slot6 = slot0._episodeId and DungeonConfig.instance:getHardEpisode(slot4)
		slot5 = slot6 and slot6.id
	end

	slot6 = slot4 and DungeonModel.instance:getEpisodeInfo(slot4)
	slot7 = slot5 and DungeonModel.instance:getEpisodeInfo(slot5)
	slot8 = slot4 and DungeonModel.instance:hasPassLevelAndStory(slot4)
	slot9 = slot4 and DungeonConfig.instance:getEpisodeAdvancedConditionText(slot4)
	slot10 = slot5 and DungeonConfig.instance:getEpisodeAdvancedConditionText(slot5)
	slot11 = DungeonModel.instance:isOpenHardDungeon(slot1.chapterId)
	slot12 = true

	if slot3 then
		gohelper.setActive(slot0._gohardcondition, true)

		slot0._txthardcondition.text = DungeonConfig.instance:getFirstEpisodeWinConditionText(slot5)
		slot13 = DungeonEnum.StarType.Normal <= slot7.star and slot8

		gohelper.setActive(slot0._gohardfinish, slot13)
		gohelper.setActive(slot0._gohardunfinish, not slot13)
		ZProj.UGUIHelper.SetColorAlpha(slot0._txthardcondition, slot13 and 1 or 0.63)
		gohelper.setActive(slot0._gohardplatinumcondition, not string.nilorempty(slot10))

		slot14 = DungeonEnum.StarType.Advanced <= slot7.star and slot8

		if not string.nilorempty(slot10) then
			slot0._txthardplatinumcondition.text = slot10

			gohelper.setActive(slot0._gohardplatinumfinish, slot14)
			gohelper.setActive(slot0._gohardplatinumunfinish, not slot14)
			ZProj.UGUIHelper.SetColorAlpha(slot0._txthardplatinumcondition, slot14 and 1 or 0.63)

			slot12 = false
		end

		slot0:_showStar(slot7, slot10, slot13, slot14)
	elseif slot0._isSimple then
		slot14 = DungeonModel.instance:getEpisodeInfo(slot0._episodeId) and DungeonEnum.StarType.Normal <= slot13.star and slot8

		gohelper.setActive(slot0._gonormalcondition, true)

		slot0._txtnormalcondition.text = DungeonConfig.instance:getFirstEpisodeWinConditionText(slot4)

		gohelper.setActive(slot0._gonormalfinish, slot14)
		gohelper.setActive(slot0._gonormalunfinish, not slot14)
		ZProj.UGUIHelper.SetColorAlpha(slot0._txtnormalcondition, slot14 and 1 or 0.63)
		slot0:_showStar(slot13, nil, slot14)
	else
		slot13 = DungeonConfig.instance:getFirstEpisodeWinConditionText(slot4)

		if BossRushController.instance:isInBossRushInfiniteFight() then
			slot13 = luaLang("v1a4_bossrushleveldetail_txt_target")
		end

		slot0._txtnormalcondition.text = slot13
		slot14 = slot6 and DungeonEnum.StarType.Normal <= slot6.star and slot8
		slot15 = slot6 and DungeonEnum.StarType.Advanced <= slot6.star and slot8
		slot16 = false

		if slot1.type == DungeonEnum.EpisodeType.WeekWalk then
			if WeekWalkModel.instance:getCurMapInfo():getBattleInfo(slot0._battleId) then
				slot14 = DungeonEnum.StarType.Normal <= slot18.star
				slot15 = DungeonEnum.StarType.Advanced <= slot18.star
				slot16 = DungeonEnum.StarType.Ultra <= slot18.star
			end

			slot19 = slot4 and DungeonConfig.instance:getEpisodeAdvancedCondition2Text(slot4)

			gohelper.setActive(slot0._goplatinumcondition2, not string.nilorempty(slot19))

			if not string.nilorempty(slot19) then
				slot0._txtplatinumcondition2.text = slot19

				gohelper.setActive(slot0._goplatinumfinish2, slot16)
				gohelper.setActive(slot0._goplatinumunfinish2, not slot16)
				ZProj.UGUIHelper.SetColorAlpha(slot0._txtplatinumcondition2, slot16 and 1 or 0.63)
			end
		end

		if slot1.type == DungeonEnum.EpisodeType.Jiexika then
			slot14 = false
		end

		gohelper.setActive(slot0._gonormalfinish, slot14)
		gohelper.setActive(slot0._gonormalunfinish, not slot14)
		ZProj.UGUIHelper.SetColorAlpha(slot0._txtnormalcondition, slot14 and 1 or 0.63)
		gohelper.setActive(slot0._goplatinumcondition, not slot0._isSimple and not string.nilorempty(slot9))

		if not string.nilorempty(slot9) then
			slot0._txtplatinumcondition.text = slot9

			gohelper.setActive(slot0._goplatinumfinish, slot15)
			gohelper.setActive(slot0._goplatinumunfinish, not slot15)
			ZProj.UGUIHelper.SetColorAlpha(slot0._txtplatinumcondition, slot15 and 1 or 0.63)

			slot12 = false
		end

		gohelper.setActive(slot0._goplace, slot12)
		slot0:_refreshWeekWalkTarget()
	end
end

function slot0._refreshWeekWalkTarget(slot0)
	if slot0._goWeekWalkHeart then
		return
	end

	slot0._goWeekWalkHeart = gohelper.findChild(slot0.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_weekwalkheart")

	gohelper.setActive(slot0._goWeekWalkHeart, false)

	slot1 = WeekWalk_2Model.instance:getCurMapInfo()

	if not WeekWalk_2Config.instance:getCupTask(slot1.id, slot1:getBattleInfoByBattleId(HeroGroupModel.instance.battleId).index) then
		return
	end

	for slot8, slot9 in ipairs(slot4) do
		slot0:_showCupTask(slot9)
	end
end

function slot0._showCupTask(slot0, slot1)
	slot3 = gohelper.cloneInPlace(slot0._goWeekWalkHeart)

	gohelper.setSiblingBefore(slot3, slot0._goplace)
	gohelper.setActive(slot3, true)

	gohelper.findChildText(slot3, "txt_desc").text = slot1.desc

	for slot8, slot9 in ipairs(GameUtil.splitString2(slot1.cupTask, true, "|", "#")) do
		slot10 = gohelper.findChild(slot3, "badgelayout/" .. slot8)

		gohelper.setActive(slot10, true)

		slot11 = gohelper.findChildImage(slot10, "1")
		slot11.enabled = false

		WeekWalk_2Helper.setCupEffectByResult(slot0.viewContainer:getResInst(slot0.viewContainer._viewSetting.otherRes.weekwalkheart_star, slot11.gameObject), slot9[1])
	end

	gohelper.setActive(slot0._gostar3, false)
end

return slot0
