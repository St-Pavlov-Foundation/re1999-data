module("modules.logic.versionactivity2_5.challenge.view.dungeon.episode.Act183BaseEpisodeItem", package.seeall)

slot0 = class("Act183BaseEpisodeItem", LuaCompBase)

function slot0.Get(slot0, slot1)
	slot4 = slot1:getConfigOrder()
	slot6 = Act183Enum.EpisodeClsType[Act183Helper.getEpisodeClsKey(slot1:getGroupType(), slot1:getEpisodeType())]
	slot8 = gohelper.findChild(slot0, slot6.getItemParentPath(slot4))
	slot13 = MonoHelper.addNoUpdateLuaComOnceToGo(gohelper.clone(slot6.getItemTemplateGo(slot0, slot6.getItemTemplatePath()), slot8, "item_" .. slot4), slot6)
	slot13.parentGo = slot8

	slot13:initPosAndRotation()

	return slot13
end

function slot0.getItemParentPath(slot0)
	return ""
end

function slot0.getItemTemplateGo(slot0, slot1)
	return gohelper.findChild(slot0, slot1)
end

function slot0.getItemTemplatePath(slot0)
	return ""
end

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0._golock = gohelper.findChild(slot0.go, "go_lock")
	slot0._gounlock = gohelper.findChild(slot0.go, "go_unlock")
	slot0._gofinish = gohelper.findChild(slot0.go, "go_finish")
	slot0._gocheck = gohelper.findChild(slot0.go, "go_finish/image")
	slot0._btnclick = gohelper.findChildButton(slot0.go, "btn_click")
	slot0._goselect = gohelper.findChild(slot0.go, "go_select")
	slot0._simageicon = gohelper.findChildSingleImage(slot0.go, "image_icon")
	slot0._animfinish = gohelper.onceAddComponent(slot0._gofinish, gohelper.Type_Animator)
	slot0._starItemTab = slot0:getUserDataTb_()
end

function slot0.initPosAndRotation(slot0)
	if gohelper.isNil(gohelper.findChild(slot0.parentGo, "positions")) then
		return
	end

	for slot7 = 1, slot1.transform.childCount do
		slot0:setTranPosition(slot2:GetChild(slot7 - 1))
	end
end

function slot0.setTranPosition(slot0, slot1)
	if gohelper.isNil(gohelper.findChild(slot0.go, slot1.gameObject.name)) then
		logError(string.format("设置关卡ui坐标失败 节点不存在 rootName = %s, goPath = %s", slot0.parentGo.name, slot2))

		return
	end

	slot4, slot5 = recthelper.getAnchor(slot1)
	slot6, slot7, slot8 = transformhelper.getLocalRotation(slot1)

	recthelper.setAnchor(slot3.transform, slot4 or 0, slot5 or 0)
	transformhelper.setLocalRotation(slot3.transform, slot6, slot7, slot8)
end

function slot0.addEventListeners(slot0)
	slot0._btnclick:AddClickListener(slot0._btnclickOnClick, slot0)
	slot0:addEventCb(Act183Controller.instance, Act183Event.OnClickEpisode, slot0._onSelectEpisode, slot0)
	slot0:addEventCb(Act183Controller.instance, Act183Event.EpisodeStartPlayFinishAnim, slot0._checkPlayFinishAnim, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._btnclick:RemoveClickListener()
end

function slot0._btnclickOnClick(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.Act183_ClickEpisode)
	Act183Controller.instance:dispatchEvent(Act183Event.OnClickEpisode, slot0._episodeId)
end

function slot0._onSelectEpisode(slot0, slot1)
	slot0:onSelect(slot1 == slot0._episodeId)
end

function slot0.onSelect(slot0, slot1)
	gohelper.setActive(slot0._goselect, slot1)
end

function slot0.onUpdateMo(slot0, slot1)
	slot0._episodeMo = slot1
	slot0._status = slot1:getStatus()
	slot0._episodeId = slot1:getEpisodeId()
	slot0._isFinishedButNotNew = slot0._status == Act183Enum.EpisodeStatus.Finished and Act183Model.instance:getNewFinishEpisodeId() ~= slot0._episodeId

	gohelper.setActive(slot0._goselect, false)
	gohelper.setActive(slot0._golock, slot0._status == Act183Enum.EpisodeStatus.Locked)
	gohelper.setActive(slot0._gounlock, slot0._status ~= Act183Enum.EpisodeStatus.Locked)
	gohelper.setActive(slot0._gofinish, slot0._isFinishedButNotNew)
	Act183Helper.setEpisodeIcon(slot0._episodeId, slot0._status, slot0._simageicon)
	slot0:setVisible(true)
end

function slot0.getConfigOrder(slot0)
	slot1 = slot0._episodeMo and slot0._episodeMo:getConfig()

	return slot1 and slot1.order
end

function slot0.setVisible(slot0, slot1)
	gohelper.setActive(slot0.go, slot1)
end

function slot0.getIconTran(slot0)
	return slot0._simageicon.transform
end

function slot0.playFinishAnim(slot0)
	gohelper.setActive(slot0._gofinish, true)
	slot0._animfinish:Play("in", 0, 0)
	AudioMgr.instance:trigger(AudioEnum.UI.Act183_EpisodeFinished)
end

function slot0._checkPlayFinishAnim(slot0, slot1)
	if slot0._episodeId ~= slot1 then
		return
	end

	slot0:playFinishAnim()
end

function slot0.refreshPassStarList(slot0, slot1)
	if slot0._status ~= Act183Enum.EpisodeStatus.Finished then
		return
	end

	slot3 = slot0._episodeMo and slot0._episodeMo:getFinishStarCount() or 0
	slot4 = {}

	for slot8 = 1, slot0._episodeMo and slot0._episodeMo:getTotalStarCount() or 0 do
		if not slot0._starItemTab[slot8] then
			slot9 = slot0:getUserDataTb_()
			slot9.go = gohelper.cloneInPlace(slot1, "star_" .. slot8)
			slot9.imagestar = slot9.go:GetComponent(gohelper.Type_Image)
			slot0._starItemTab[slot8] = slot9
		end

		UISpriteSetMgr.instance:setCommonSprite(slot9.imagestar, "zhuxianditu_pt_xingxing_001", true)
		SLFramework.UGUI.GuiHelper.SetColor(slot9.imagestar, slot8 <= slot3 and "#F77040" or "#87898C")
		gohelper.setActive(slot9.go, true)

		slot4[slot9] = true
	end

	for slot8, slot9 in pairs(slot0._starItemTab) do
		if not slot4[slot9] then
			gohelper.setActive(slot9.go, false)
		end
	end
end

function slot0.destroySelf(slot0)
	gohelper.destroy(slot0.go)
end

function slot0.onDestroy(slot0)
end

return slot0
