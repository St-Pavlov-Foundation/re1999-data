module("modules.logic.weekwalk_2.view.WeekWalk_2LayerRewardItem", package.seeall)

slot0 = class("WeekWalk_2LayerRewardItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._gonormal = gohelper.findChild(slot0.viewGO, "#go_normal")
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#go_normal/#simage_bg")
	slot0._txtindex = gohelper.findChildText(slot0.viewGO, "#go_normal/#txt_index")
	slot0._scrollrewards = gohelper.findChild(slot0.viewGO, "#go_normal/#scroll_rewards"):GetComponent(typeof(ZProj.LimitedScrollRect))
	slot0._rewardscontent = gohelper.findChild(slot0.viewGO, "#go_normal/#scroll_rewards/Viewport/Content")
	slot0._gorewarditem = gohelper.findChild(slot0.viewGO, "#go_normal/#scroll_rewards/Viewport/Content/#go_rewarditem")
	slot0._txtdesc = gohelper.findChildText(slot0.viewGO, "#go_normal/info/#txt_desc")
	slot0._imagestar = gohelper.findChildImage(slot0.viewGO, "#go_normal/info/progress/#image_star")
	slot0._goblackmask = gohelper.findChild(slot0.viewGO, "#go_normal/#go_blackmask")
	slot0._gonotget = gohelper.findChild(slot0.viewGO, "#go_normal/#go_notget")
	slot0._btnnotfinishbg = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_normal/#go_notget/#btn_notfinishbg")
	slot0._btnfinishbg = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_normal/#go_notget/#btn_finishbg")
	slot0._goget = gohelper.findChild(slot0.viewGO, "#go_normal/#go_get")
	slot0._gogetall = gohelper.findChild(slot0.viewGO, "#go_getall")
	slot0._simagegetallbg = gohelper.findChildSingleImage(slot0.viewGO, "#go_getall/#simage_getallbg")
	slot0._btncollectall = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_getall/go_getall/#btn_collectall")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnnotfinishbg:AddClickListener(slot0._btnnotfinishbgOnClick, slot0)
	slot0._btnfinishbg:AddClickListener(slot0._btnfinishbgOnClick, slot0)
	slot0._btncollectall:AddClickListener(slot0._btncollectallOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnnotfinishbg:RemoveClickListener()
	slot0._btnfinishbg:RemoveClickListener()
	slot0._btncollectall:RemoveClickListener()
end

function slot0._btncollectallOnClick(slot0)
	WeekWalk_2Controller.instance:dispatchEvent(WeekWalk_2Event.OnGetTaskReward, slot0)
	TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.WeekWalk_2, slot0._mo.minTypeId, WeekWalk_2TaskListModel.instance:getCanGetList())
end

function slot0._btnnotfinishbgOnClick(slot0)
end

function slot0._btnfinishbgOnClick(slot0)
	WeekWalk_2Controller.instance:dispatchEvent(WeekWalk_2Event.OnGetTaskReward, slot0)
	TaskRpc.instance:sendFinishTaskRequest(slot0._mo.id)
end

function slot0.playOutAnim(slot0)
	gohelper.setActive(slot0._goblackmask, true)
	slot0._animator:Play("out", 0, 0)
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._imagestar.gameObject, false)

	slot0._rewardItems = slot0:getUserDataTb_()
	slot0._animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function slot0.getAnimator(slot0)
	return slot0._animator
end

function slot0._editableAddEvents(slot0)
	gohelper.addUIClickAudio(slot0._btnnotfinishbg.gameObject, AudioEnum.UI.play_ui_activity_jump)
	gohelper.addUIClickAudio(slot0._btnfinishbg.gameObject, AudioEnum.WeekWalk.play_artificial_ui_taskreceive)
	gohelper.addUIClickAudio(slot0._btncollectall.gameObject, AudioEnum.WeekWalk.play_artificial_ui_taskreceive)
end

function slot0._editableRemoveEvents(slot0)
end

function slot0.onUpdateMO(slot0, slot1)
	if slot1.isDirtyData then
		gohelper.setActive(slot0.viewGO, false)

		return
	end

	gohelper.setActive(slot0.viewGO, true)

	slot0._mo = slot1

	gohelper.setActive(slot0._gonormal, not slot1.isGetAll)
	gohelper.setActive(slot0._gogetall, slot1.isGetAll)

	if slot1.isGetAll then
		return
	end

	slot0._config = lua_task_weekwalk_ver2.configDict[slot1.id]
	slot0._txtindex.text = "0" .. WeekWalk_2TaskListModel.instance:getSortIndex(slot1)

	slot0:_addRewards()
	slot0:_updateStatus()

	slot2 = WeekWalk_2TaskListModel.instance:getLayerTaskMapId()
	slot0._isDeepTask = true

	gohelper.setActive(slot0._txtdesc.gameObject, slot0._isDeepTask)

	if slot0._isDeepTask then
		slot0._txtdesc.text = slot0._config.desc
	end

	slot0:_initStars()
	slot0:_updateStars()

	slot0._scrollrewards.parentGameObject = slot0._view._csListScroll.gameObject
end

function slot0._initStars(slot0)
	if slot0._starList then
		return
	end

	slot0._starList = slot0:getUserDataTb_()

	for slot6 = #slot0._starList, slot0._isDeepTask and 1 or slot0._config.maxProgress do
		slot7 = gohelper.cloneInPlace(slot0._imagestar.gameObject)

		gohelper.setActive(slot7, true)

		slot8 = slot7:GetComponent(gohelper.Type_Image)
		slot8.enabled = false

		table.insert(slot0._starList, slot0._view:getResInst(slot0._view.viewContainer._viewSetting.otherRes.weekwalkheart_star, slot8.gameObject))
	end
end

function slot0._updateStars(slot0)
	if not slot0._starList then
		return
	end

	for slot5, slot6 in ipairs(slot0._starList) do
		gohelper.setActive(slot6.gameObject, slot5 <= (slot0._isDeepTask and 1 or slot0._config.maxProgress))

		if slot0._config.listenerType == "WeekwalkVer2SeasonCup" then
			WeekWalk_2Helper.setCupEffectByResult(slot6, string.split(slot0._config.listenerParam, "#")[1])
		else
			WeekWalk_2Helper.setCupEffectByResult(slot6, slot7[2])
		end
	end
end

function slot0._updateStatus(slot0)
	slot0._taskMo = WeekWalk_2TaskListModel.instance:getTaskMo(slot0._mo.id)
	slot1 = slot0._config.maxFinishCount <= slot0._taskMo.finishCount

	gohelper.setActive(slot0._gonotget, not slot1)
	gohelper.setActive(slot0._goget, slot1)
	gohelper.setActive(slot0._goblackmask, slot1)

	if not slot1 then
		slot2 = slot0._taskMo.hasFinished

		gohelper.setActive(slot0._btnnotfinishbg.gameObject, not slot2)
		gohelper.setActive(slot0._btnfinishbg.gameObject, slot2)
	end
end

function slot0._addRewards(slot0)
	slot0._scrollrewards.horizontalNormalizedPosition = 0

	for slot5 = 1, #string.split(slot0._mo.bonus, "|") do
		slot6 = slot0:_getItem(slot5)
		slot7 = string.splitToNumber(slot1[slot5], "#")

		gohelper.setActive(slot6.parentGo, true)
		slot6.itemIcon:setMOValue(slot7[1], slot7[2], slot7[3], nil, true)
		slot6.itemIcon:isShowCount(slot7[1] ~= MaterialEnum.MaterialType.Hero)
		slot6.itemIcon:setCountFontSize(40)
		slot6.itemIcon:showStackableNum2()
		slot6.itemIcon:setHideLvAndBreakFlag(true)
		slot6.itemIcon:hideEquipLvAndBreak(true)
	end

	for slot5 = #slot1 + 1, #slot0._rewardItems do
		if slot0._rewardItems[slot5] then
			gohelper.setActive(slot6.parentGo, false)
		end
	end

	recthelper.setWidth(slot0._rewardscontent.transform, (recthelper.getWidth(slot0._gorewarditem.transform) + -13) * #slot1)
end

function slot0._getItem(slot0, slot1)
	if slot0._rewardItems[slot1] then
		return slot2
	end

	slot2 = slot0:getUserDataTb_()
	slot2.parentGo = gohelper.clone(slot0._gorewarditem, slot0._rewardscontent)
	slot2.itemIcon = IconMgr.instance:getCommonPropItemIcon(slot2.parentGo)
	slot0._rewardItems[slot1] = slot2

	return slot2
end

function slot0.onSelect(slot0, slot1)
end

function slot0.onDestroyView(slot0)
	for slot4, slot5 in pairs(slot0._rewardItems) do
		gohelper.destroy(slot5.itemIcon.go)
		gohelper.destroy(slot5.parentGo)
		slot5.itemIcon:onDestroy()
	end

	slot0._rewardItems = nil

	slot0._simagebg:UnLoadImage()
	slot0._simagegetallbg:UnLoadImage()
end

return slot0
