module("modules.logic.versionactivity2_5.challenge.view.dungeon.detail.Act183DungeonRewardRuleComp", package.seeall)

slot0 = class("Act183DungeonRewardRuleComp", Act183DungeonBaseComp)

function slot0.init(slot0, slot1)
	uv0.super.init(slot0, slot1)

	slot0._gorewarditem = gohelper.findChild(slot0.go, "#go_rewards/#go_rewarditem")
	slot0._rewardRuleItemTab = slot0:getUserDataTb_()
end

function slot0.addEventListeners(slot0)
end

function slot0.removeEventListeners(slot0)
end

function slot0.updateInfo(slot0, slot1)
	uv0.super.updateInfo(slot0, slot1)

	slot0._subEpisodeConditions = Act183Config.instance:getGroupSubEpisodeConditions(slot0._activityId, slot0._groupId)

	slot0:initSelectConditionMap()
end

function slot0.initSelectConditionMap(slot0)
	slot0._selectConditionMap = {}
	slot0._selectConditionIds = {}
	slot1 = false
	slot0._fightConditionIds, slot0._passFightConditionIds = slot0._groupEpisodeMo:getTotalAndPassConditionIds(slot0._episodeId)
	slot0._fightConditionIdMap = Act183Helper.listToMap(slot0._fightConditionIds)
	slot0._passFightConditionIdMap = Act183Helper.listToMap(slot0._passFightConditionIds)

	if slot0._episodeType == Act183Enum.EpisodeType.Boss then
		slot2 = {}

		if PlayerPrefsHelper.hasKey(Act183Helper._generateSaveSelectCollectionIdsKey(slot0._activityId, slot0._episodeId)) then
			slot2 = Act183Helper.getSelectConditionIdsInLocal(slot0._activityId, slot0._episodeId)
		else
			slot2 = slot0._passFightConditionIds
			slot1 = true
		end

		if slot2 then
			for slot7, slot8 in ipairs(slot2) do
				if slot0._passFightConditionIdMap[slot8] then
					slot0._selectConditionMap[slot8] = true

					table.insert(slot0._selectConditionIds, slot8)
				else
					slot1 = true
				end
			end
		end
	end

	if slot1 then
		Act183Helper.saveSelectConditionIdsInLocal(slot0._activityId, slot0._episodeId, slot0._selectConditionIds)
	end
end

function slot0.checkIsVisible(slot0)
	return slot0._episodeType == Act183Enum.EpisodeType.Boss
end

function slot0.show(slot0)
	uv0.super.show(slot0)

	slot0._hasPlayRefreshAnimRuleIds = Act183Helper.getHasPlayRefreshAnimRuleIdsInLocal(slot0._episodeId)
	slot0._hasPlayRefreshAnimRuleIdMap = Act183Helper.listToMap(slot0._hasPlayRefreshAnimRuleIds)
	slot0._needFocusEscapeRule = false

	slot0:createObjList(slot0._subEpisodeConditions, slot0._rewardRuleItemTab, slot0._gorewarditem, slot0._initRewardRuleItemFunc, slot0._refreshRewardRuleItemFunc, slot0._defaultItemFreeFunc)
	Act183Helper.saveHasPlayRefreshAnimRuleIdsInLocal(slot0._episodeId, slot0._hasPlayRefreshAnimRuleIds)
end

function slot0._initRewardRuleItemFunc(slot0, slot1, slot2)
	slot1.goselectbg = gohelper.findChild(slot1.go, "btn_check/#go_BG1")
	slot1.gounselectbg = gohelper.findChild(slot1.go, "btn_check/#go_BG2")
	slot1.imageicon = gohelper.findChildImage(slot1.go, "image_icon")
	slot1.txtcondition = gohelper.findChildText(slot1.go, "txt_condition")

	SkillHelper.addHyperLinkClick(slot1.txtcondition)

	slot1.txteffect = gohelper.findChildText(slot1.go, "txt_effect")
	slot1.btncheck = gohelper.findChildButtonWithAudio(slot1.go, "btn_check")

	slot1.btncheck:AddClickListener(slot0._onClickRewardItem, slot0, slot2)

	slot1.goselect = gohelper.findChild(slot1.go, "btn_check/go_select")
end

function slot0._onClickRewardItem(slot0, slot1)
	if not Act183Config.instance:getConditionCo(slot0._subEpisodeConditions and slot0._subEpisodeConditions[slot1]) then
		return
	end

	slot5 = not slot0._selectConditionMap[slot3.id]
	slot0._selectConditionMap[slot3.id] = slot5

	tabletool.removeValue(slot0._selectConditionIds, slot3.id)

	if slot5 then
		table.insert(slot0._selectConditionIds, slot3.id)
	end

	Act183Helper.saveSelectConditionIdsInLocal(slot0._activityId, slot0._episodeId, slot0._selectConditionIds)
	slot0:refresh()
end

function slot0._refreshRewardRuleItemFunc(slot0, slot1, slot2, slot3)
	if not Act183Config.instance:getConditionCo(slot2) then
		return
	end

	slot1.txtcondition.text = SkillHelper.buildDesc(slot4.decs1)
	slot1.txteffect.text = slot4.decs2
	slot7 = slot0._selectConditionMap[slot2] == true
	slot8 = slot0._groupEpisodeMo:isConditionPass(slot2)

	ZProj.UGUIHelper.SetGrayscale(slot1.imageicon.gameObject, not slot8)
	gohelper.setActive(slot1.goselect, slot7)
	gohelper.setActive(slot1.btncheck.gameObject, slot8 and slot0._status ~= Act183Enum.EpisodeStatus.Locked)
	gohelper.setActive(slot1.goselectbg, slot7)
	gohelper.setActive(slot1.gounselectbg, not slot7 and slot8)
	gohelper.setActive(slot1.go, true)
	Act183Helper.setEpisodeConditionStar(slot1.imageicon, slot8, slot7)
end

function slot0._releaseRewardItemsFunc(slot0)
	if slot0._rewardRuleItemTab then
		for slot4, slot5 in pairs(slot0._rewardRuleItemTab) do
			slot5.btncheck:RemoveClickListener()
		end
	end
end

function slot0.getSelectConditionMap(slot0)
	return slot0._selectConditionMap
end

function slot0.onDestroy(slot0)
	slot0:_releaseRewardItemsFunc()
	uv0.super.onDestroy(slot0)
end

return slot0
