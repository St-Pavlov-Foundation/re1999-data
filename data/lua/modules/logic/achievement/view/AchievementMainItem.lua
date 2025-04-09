module("modules.logic.achievement.view.AchievementMainItem", package.seeall)

slot0 = class("AchievementMainItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._gosingle = gohelper.findChild(slot0.viewGO, "#go_single")
	slot0._gogroup = gohelper.findChild(slot0.viewGO, "#go_group")
	slot0._gogroup2 = gohelper.findChild(slot0.viewGO, "#go_group2")
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#go_group/#image_bg")
	slot0._gogroupcontainer = gohelper.findChild(slot0.viewGO, "#go_group/#go_groupcontainer")
	slot0._goupgrade = gohelper.findChild(slot0.viewGO, "#go_group/#go_upgrade")
	slot0._goallcollect = gohelper.findChild(slot0.viewGO, "#go_group/#go_allcollect")
	slot0._gotop2 = gohelper.findChild(slot0.viewGO, "#go_group2/go_top2")
	slot0._simageAchievementGroupBG = gohelper.findChildSingleImage(slot0.viewGO, "#go_group2/go_top2/#simage_AchievementGroupBG")
	slot0._txtachievementgroupname = gohelper.findChildText(slot0.viewGO, "#go_group2/go_top2/#simage_AchievementGroupBG/#txt_achievementgroupname")
	slot0._golayout = gohelper.findChild(slot0.viewGO, "#go_group2/#go_layout")
	slot0._btnpopup = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_group2/go_top2/#btn_popup")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._btnpopupOnClick(slot0)
	AchievementMainController.instance:dispatchEvent(AchievementEvent.OnClickGroupFoldBtn, slot0._mo.groupId, not slot0._mo:getIsFold())
end

function slot0._editableInitView(slot0)
	slot0._animator = gohelper.onceAddComponent(slot0.viewGO, typeof(UnityEngine.Animator))
	slot0._groupBgImage = gohelper.findChildImage(slot0.viewGO, "#go_group/#image_bg")
	slot0._iconItems = slot0:getUserDataTb_()

	slot0:addEventCb(AchievementController.instance, AchievementEvent.OnGroupUpGrade, slot0._onGroupUpGrade, slot0)
	slot0:addEventCb(AchievementMainController.instance, AchievementEvent.OnFocusAchievementFinished, slot0._onFocusFinished, slot0)
end

function slot0.onDestroy(slot0)
	slot0:recycleIcons()
	slot0._simagebg:UnLoadImage()
	slot0._simageAchievementGroupBG:UnLoadImage()
	TaskDispatcher.cancelTask(slot0.playItemOpenAim, slot0)
	TaskDispatcher.cancelTask(slot0.playAchievementUnlockAnim, slot0)
end

function slot0.onUpdateMO(slot0, slot1)
	if slot0._mo ~= slot1 then
		slot0:recycleIcons()
	end

	slot0._mo = slot1

	slot0:refreshUI()
end

function slot0.refreshUI(slot0)
	slot2 = AchievementUtils.isGamePlayGroup(slot0._mo.firstAchievementCo.id)

	gohelper.setActive(slot0._gosingle, not AchievementUtils.isActivityGroup(slot0._mo.firstAchievementCo.id) and not slot2)
	gohelper.setActive(slot0._gogroup, slot1)
	gohelper.setActive(slot0._gogroup2, slot2)

	if slot1 then
		slot0:refreshGroup()
	elseif slot2 then
		slot0:refreshGroup2()
	else
		slot0:refreshSingle(slot0._gosingle, 1, slot0._mo.count)
	end

	slot0:playAchievementAnim()
end

slot0.LockedIconColor = "#4D4D4D"
slot0.UnLockedIconColor = "#FFFFFF"
slot0.LockedNameAlpha = 0.5
slot0.UnLockedNameAlpha = 1
slot0.LockedGroupBgColor = "#808080"
slot0.UnLockedGroupBgColor = "#FFFFFF"

function slot0.refreshSingle(slot0, slot1, slot2, slot3)
	slot7 = slot1

	slot0:checkInitIcon(slot3, slot7)

	for slot7 = 1, slot3 do
		slot8 = slot0._iconItems[slot7]
		slot11 = slot2 + slot7 - 1

		recthelper.setAnchor(slot8.viewGO.transform, uv0.IconStartX + (slot7 - 1) * uv0.IconIntervalX, 0)
		slot8:setClickCall(slot0.onClickSingleIcon, slot0, slot11)
		gohelper.setActive(slot8.viewGO, slot0._mo.achievementCfgs[slot11] ~= nil)

		if slot12 then
			if AchievementController.instance:getMaxLevelFinishTask(slot12.id) then
				slot8:setData(slot14)

				slot15 = AchievementModel.instance:achievementHasLocked(slot13)

				slot8:setIsLocked(slot15)
				slot8:setIconColor(slot15 and uv0.LockedIconColor or uv0.UnLockedIconColor)
				slot8:setNameTxtAlpha(slot15 and uv0.LockedNameAlpha or uv0.UnLockedNameAlpha)
				slot8:setNameTxtVisible(true)
				slot8:setSelectIconVisible(false)
				slot8:setBgVisible(true)
			else
				gohelper.setActive(slot8.viewGO, false)
			end
		end
	end
end

function slot0.refreshGroup(slot0)
	if AchievementConfig.instance:getGroup(slot0._mo.groupId) then
		gohelper.setActive(slot0._goupgrade, false)
		slot0:refreshGroupBg(slot1)
		slot0:refreshSingleInGroup()
	end
end

function slot0.refreshGroup2(slot0)
	slot0._txtachievementgroupname.text = AchievementConfig.instance:getGroupName(slot0._mo.groupId)

	slot0._simageAchievementGroupBG:LoadImage(ResUrl.getAchievementIcon(string.format("grouptitle/%s", slot0._mo.groupId)))
	slot0:refreshSingle(slot0._golayout, 1, slot0._mo.count)
	gohelper.setActive(slot0._gotop2, slot0._mo.isGroupTop)

	slot0._foldAnimComp = AchievementItemFoldAnimComp.Get(slot0._btnpopup.gameObject, slot0._golayout)

	slot0._foldAnimComp:onUpdateMO(slot0._mo)
end

function slot0.refreshGroupBg(slot0, slot1)
	if slot1 then
		slot0._simagebg:LoadImage(AchievementConfig.instance:getGroupBgUrl(slot0._mo.groupId, AchievementEnum.GroupParamType.List, AchievementModel.instance:isAchievementTaskFinished(slot1.unLockAchievement)))
		SLFramework.UGUI.GuiHelper.SetColor(slot0._groupBgImage, AchievementModel.instance:achievementGroupHasLocked(slot0._mo.groupId) and uv0.LockedGroupBgColor or uv0.UnLockedGroupBgColor)
	end
end

function slot0.refreshSingleInGroup(slot0)
	slot0:checkInitIcon(AchievementConfig.instance:getGroupParamIdTab(slot0._mo.groupId, AchievementEnum.GroupParamType.List) and #slot1 or 0, slot0._gogroupcontainer)

	for slot6 = 1, slot2 do
		slot7 = slot0._iconItems[slot6]

		slot7:setClickCall(slot0.onClickSingleIcon, slot0, slot1[slot6])
		slot0:_setGroupAchievementPosAndScale(slot7.viewGO, slot0._mo.groupId, slot6)
		gohelper.setActive(slot7.viewGO, slot0._mo.achievementCfgs[slot1[slot6]] ~= nil)

		if slot8 then
			if AchievementController.instance:getMaxLevelFinishTask(slot8.id) then
				slot7:setData(slot10)

				slot11 = AchievementModel.instance:achievementHasLocked(slot9)

				slot7:setIsLocked(slot11)
				slot7:setIconColor(slot11 and uv0.LockedIconColor or uv0.UnLockedIconColor)
				slot7:setSelectIconVisible(false)
				slot7:setNameTxtVisible(false)
				slot7:setBgVisible(false)
			else
				gohelper.setActive(slot7.viewGO, false)
			end
		end
	end

	gohelper.setActive(slot0._goallcollect, AchievementModel.instance:isGroupFinished(slot0._mo.groupId))
end

function slot0._setGroupAchievementPosAndScale(slot0, slot1, slot2, slot3)
	slot4, slot5, slot6, slot7 = AchievementConfig.instance:getAchievementPosAndScaleInGroup(slot2, slot3, AchievementEnum.GroupParamType.List)

	if slot1 then
		recthelper.setAnchor(slot1.transform, slot4 or 0, slot5 or 0)
		transformhelper.setLocalScale(slot1.transform, slot6 or 1, slot7 or 1, 1)
	end
end

slot0.IconStartX = -535
slot0.IconIntervalX = 262

function slot0.checkInitIcon(slot0, slot1, slot2)
	if #slot0._iconItems == slot1 then
		return
	end

	slot3 = nil

	if slot0._view and slot0._view.viewContainer and not slot0._view.viewContainer:getPoolView() then
		return
	end

	for slot7 = 1, slot1 do
		slot8 = slot3:getIcon(slot2)

		gohelper.setActive(slot8.viewGO, true)

		slot0._iconItems[slot7] = slot8
	end
end

function slot0.recycleIcons(slot0)
	slot1 = nil

	if slot0._view and slot0._view.viewContainer and not slot0._view.viewContainer:getPoolView() then
		return
	end

	if slot0._iconItems then
		for slot5, slot6 in pairs(slot0._iconItems) do
			slot1:recycleIcon(slot0._iconItems[slot5])

			slot0._iconItems[slot5] = nil
		end
	end
end

function slot0.onClickSingleIcon(slot0, slot1)
	if slot0._mo.achievementCfgs[slot1] then
		ViewMgr.instance:openView(ViewName.AchievementLevelView, {
			achievementId = slot2.id,
			achievementIds = AchievementMainTileModel.instance:getCurrentAchievementIds()
		})
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_achieve_weiqicard_saga)
	end
end

slot0.AnimDelayDelta = 0.06

function slot0.playAchievementAnim(slot0)
	slot0:playAchievementOpenAnim()
	TaskDispatcher.cancelTask(slot0.playAchievementUnlockAnim, slot0)
	TaskDispatcher.runDelay(slot0.playAchievementUnlockAnim, slot0, 0.5)
end

function slot0.playAchievementOpenAnim(slot0)
	TaskDispatcher.cancelTask(slot0.playItemOpenAim, slot0)

	if not slot0.viewGO.activeInHierarchy then
		return
	end

	if AchievementMainTileModel.instance:getScrollFocusIndex() then
		if not AchievementMainTileModel.instance:hasPlayOpenAnim() then
			slot0._animator:Play("close", 0, 0)
			TaskDispatcher.runDelay(slot0.playItemOpenAim, slot0, uv0.AnimDelayDelta * Mathf.Clamp(slot0._index - slot1, 0, slot0._index))
		else
			slot0._animator:Play("idle", 0, 0)
		end
	else
		slot0._animator:Play("close", 0, 0)
	end
end

function slot0.playItemOpenAim(slot0)
	slot0._animator:Play("open", 0, 0)
end

function slot0._onFocusFinished(slot0, slot1)
	if slot1 ~= AchievementEnum.ViewType.Tile then
		return
	end

	slot0:playAchievementAnim()
end

function slot0.playAchievementUnlockAnim(slot0)
	if slot0._iconItems then
		for slot4, slot5 in ipairs(slot0._iconItems) do
			slot0:playSingleAchievementUnlockAnim(slot5)
		end
	end
end

function slot0.playSingleAchievementUnlockAnim(slot0, slot1)
	if not slot1 or not slot1.viewGO or not slot1.viewGO.activeInHierarchy then
		return
	end

	slot3 = slot1:getTaskCO() and slot2.achievementId

	if AchievementModel.instance:achievementHasNew(slot3) then
		slot1:playAnim(AchievementMainCommonModel.instance:isAchievementPlayEffect(slot3) and AchievementMainIcon.AnimClip.Loop or AchievementMainIcon.AnimClip.New)
	else
		slot1:playAnim(AchievementMainIcon.AnimClip.Idle)
	end

	AchievementMainCommonModel.instance:markAchievementPlayEffect(slot3)
end

function slot0._onGroupUpGrade(slot0, slot1)
	if slot0._mo.groupId == slot1 then
		gohelper.setActive(slot0._goupgrade, true)
	end
end

return slot0
