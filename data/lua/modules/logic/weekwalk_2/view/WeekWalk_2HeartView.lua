module("modules.logic.weekwalk_2.view.WeekWalk_2HeartView", package.seeall)

slot0 = class("WeekWalk_2HeartView", BaseView)

function slot0.onInitView(slot0)
	slot0._gofullscreen = gohelper.findChild(slot0.viewGO, "#go_fullscreen")
	slot0._gofinish = gohelper.findChild(slot0.viewGO, "#go_finish")
	slot0._scrollnull = gohelper.findChildScrollRect(slot0.viewGO, "#go_finish/weekwalkending/#scroll_null")
	slot0._gostartemplate = gohelper.findChild(slot0.viewGO, "#go_finish/weekwalkending/#scroll_null/starlist/#go_star_template")
	slot0._simagefinishbg = gohelper.findChildSingleImage(slot0.viewGO, "#go_finish/#simage_finishbg")
	slot0._btnreward = gohelper.findChildButtonWithAudio(slot0.viewGO, "GameObject/#btn_reward")
	slot0._gorewardredpoint = gohelper.findChild(slot0.viewGO, "GameObject/#btn_reward/#go_rewardredpoint")
	slot0._btndetail = gohelper.findChildButtonWithAudio(slot0.viewGO, "GameObject/#btn_detail")
	slot0._btnreset = gohelper.findChildButtonWithAudio(slot0.viewGO, "GameObject/#btn_reset")
	slot0._simagebgimgnext = gohelper.findChildSingleImage(slot0.viewGO, "transition/ani/#simage_bgimg_next")
	slot0._goinfo = gohelper.findChild(slot0.viewGO, "#go_info")
	slot0._txtindex = gohelper.findChildText(slot0.viewGO, "#go_info/title/#txt_index")
	slot0._txtnameen = gohelper.findChildText(slot0.viewGO, "#go_info/title/#txt_nameen")
	slot0._simagestage = gohelper.findChildSingleImage(slot0.viewGO, "#go_info/title/#simage_stage")
	slot0._txtbattlename = gohelper.findChildText(slot0.viewGO, "#go_info/title/#txt_battlename")
	slot0._btndetail2 = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_info/title/#txt_battlename/#btn_detail2")
	slot0._txtnameen2 = gohelper.findChildText(slot0.viewGO, "#go_info/title/#txt_nameen2")
	slot0._gochapter1 = gohelper.findChild(slot0.viewGO, "#go_info/#go_chapter1")
	slot0._imageIcon11 = gohelper.findChildImage(slot0.viewGO, "#go_info/#go_chapter1/badge/go/#image_Icon11")
	slot0._imageIcon12 = gohelper.findChildImage(slot0.viewGO, "#go_info/#go_chapter1/badge/go/#image_Icon12")
	slot0._imageIcon13 = gohelper.findChildImage(slot0.viewGO, "#go_info/#go_chapter1/badge/go/#image_Icon13")
	slot0._txtchapternum1 = gohelper.findChildText(slot0.viewGO, "#go_info/#go_chapter1/#txt_chapternum1")
	slot0._btnchapter1 = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_info/#go_chapter1/#btn_chapter1")
	slot0._gochapter2 = gohelper.findChild(slot0.viewGO, "#go_info/#go_chapter2")
	slot0._imageIcon21 = gohelper.findChildImage(slot0.viewGO, "#go_info/#go_chapter2/badge/go/#image_Icon21")
	slot0._imageIcon22 = gohelper.findChildImage(slot0.viewGO, "#go_info/#go_chapter2/badge/go/#image_Icon22")
	slot0._imageIcon23 = gohelper.findChildImage(slot0.viewGO, "#go_info/#go_chapter2/badge/go/#image_Icon23")
	slot0._txtchapternum2 = gohelper.findChildText(slot0.viewGO, "#go_info/#go_chapter2/#txt_chapternum2")
	slot0._btnchapter2 = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_info/#go_chapter2/#btn_chapter2")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnreward:AddClickListener(slot0._btnrewardOnClick, slot0)
	slot0._btndetail:AddClickListener(slot0._btndetailOnClick, slot0)
	slot0._btnreset:AddClickListener(slot0._btnresetOnClick, slot0)
	slot0._btndetail2:AddClickListener(slot0._btndetail2OnClick, slot0)
	slot0._btnchapter1:AddClickListener(slot0._btnchapter1OnClick, slot0)
	slot0._btnchapter2:AddClickListener(slot0._btnchapter2OnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnreward:RemoveClickListener()
	slot0._btndetail:RemoveClickListener()
	slot0._btnreset:RemoveClickListener()
	slot0._btndetail2:RemoveClickListener()
	slot0._btnchapter1:RemoveClickListener()
	slot0._btnchapter2:RemoveClickListener()
end

function slot0._btnchapter1OnClick(slot0)
	if slot0._battle1Finished then
		return
	end

	slot0:enterWeekwalk_2Fight(WeekWalk_2Enum.BattleIndex.First)
end

function slot0._btnchapter2OnClick(slot0)
	if not slot0._battle1Finished or slot0._battle2Finished then
		return
	end

	slot0:enterWeekwalk_2Fight(WeekWalk_2Enum.BattleIndex.Second)
end

function slot0.enterWeekwalk_2Fight(slot0, slot1)
	slot2 = slot0._layerInfo:getBattleInfo(slot1)

	WeekWalk_2Controller.instance:enterWeekwalk_2Fight(slot2.elementId, slot2.battleId)
end

function slot0._btndetail2OnClick(slot0)
end

function slot0._btnrewardOnClick(slot0)
	WeekWalk_2Controller.instance:openWeekWalk_2LayerRewardView({
		mapId = slot0._layerInfo.id
	})
end

function slot0._btndetailOnClick(slot0)
	EnemyInfoController.instance:openWeekWalk_2EnemyInfoView(slot0._layerInfo.id)
end

function slot0._btnresetOnClick(slot0)
	WeekWalk_2Controller.instance:openWeekWalk_2ResetView()
end

function slot0._editableInitView(slot0)
	slot0._viewAnim = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	slot0:addEventCb(WeekWalk_2Controller.instance, WeekWalk_2Event.OnWeekwalkResetLayer, slot0._onWeekwalkResetLayer, slot0)
	slot0:addEventCb(WeekWalk_2Controller.instance, WeekWalk_2Event.OnWeekwalkTaskUpdate, slot0._onWeekwalkTaskUpdate, slot0)
end

function slot0._updateChess(slot0, slot1, slot2)
	slot0._chess1 = slot0._chess1 or gohelper.findChildImage(slot0._gochapter1, "chess")
	slot0._chess2 = slot0._chess2 or gohelper.findChildImage(slot0._gochapter2, "chess")
	slot3 = lua_weekwalk_ver2.configDict[slot0._mapId]
	slot7 = lua_weekwalk_ver2_element_res.configDict[slot3.resIdRear]

	if lua_weekwalk_ver2_element_res.configDict[slot3.resIdFront] then
		UISpriteSetMgr.instance:setWeekWalkSprite(slot0._chess1, slot6.res .. (slot1 and "_1" or "_0"))
	end

	if slot7 then
		UISpriteSetMgr.instance:setWeekWalkSprite(slot0._chess2, slot7.res .. (slot2 and "_1" or "_0"))
	end
end

function slot0._onWeekwalkTaskUpdate(slot0)
	slot0:_updateReward()
end

function slot0._onWeekwalkResetLayer(slot0)
	slot0._mapInfo = WeekWalk_2Model.instance:getLayerInfo(slot0._mapId)
	slot0._viewAnim.enabled = true

	slot0._viewAnim:Play("transition", 0, 0)
	AudioMgr.instance:trigger(AudioEnum.WeekWalk.play_ui_artificial_mist)
	slot0:_updateBattleStatus()
end

function slot0.onOpen(slot0)
	slot0._mapId = slot0.viewParam.mapId
	slot0._layerInfo = WeekWalk_2Model.instance:getLayerInfo(slot0._mapId)
	slot0._layerSceneConfig = slot0._layerInfo.sceneConfig
	slot0._index = slot0._layerInfo:getLayer()
	slot0._txtindex.text = tostring(slot0._index)
	slot0._txtbattlename.text = slot0._layerSceneConfig.battleName

	slot0._simagestage:LoadImage(ResUrl.getWeekWalkLayerIcon(string.format("weekwalkheart_stage%s", slot0._layerInfo.config.layer)))
	slot0:_updateBattleStatus()
	slot0:_updateReward()
end

function slot0._updateReward(slot0)
	slot3, slot4 = WeekWalk_2TaskListModel.instance:canGetRewardNum(WeekWalk_2Enum.TaskType.Season, slot0._mapId)

	gohelper.setActive(slot0._gorewardredpoint, slot3 > 0)
end

function slot0._updateBattleStatus(slot0)
	slot0._battle1Finished = slot0._layerInfo:getBattleInfo(WeekWalk_2Enum.BattleIndex.First).status == WeekWalk_2Enum.BattleStatus.Finished
	slot0._battle2Finished = slot0._layerInfo:getBattleInfo(WeekWalk_2Enum.BattleIndex.Second).status == WeekWalk_2Enum.BattleStatus.Finished

	gohelper.setActive(gohelper.findChild(slot0._gochapter1, "finished"), not slot0._battle1Finished)
	gohelper.setActive(gohelper.findChild(slot0._gochapter2, "finished"), not slot0._battle2Finished)
	gohelper.setActive(slot0._gochapter2, slot0._battle1Finished)
	slot0:_updateStarList(WeekWalk_2Enum.BattleIndex.First)

	if slot0._battle1Finished then
		slot0:_updateStarList(WeekWalk_2Enum.BattleIndex.Second)
	end

	slot0:_updateChess(slot0._battle1Finished, slot0._battle2Finished)
end

function slot0._updateStarList(slot0, slot1)
	slot0._iconEffectStatus = slot0._iconEffectStatus or slot0:getUserDataTb_()
	slot2 = slot0._layerInfo:getBattleInfo(slot1)

	for slot6 = 1, WeekWalk_2Enum.MaxStar do
		if not slot0._iconEffectStatus[slot0["_imageIcon" .. slot1 .. slot6]] then
			slot7.enabled = false
			slot0._iconEffectStatus[slot7] = slot0:getResInst(slot0.viewContainer._viewSetting.otherRes.weekwalkheart_star, slot7.gameObject)
		end

		WeekWalk_2Helper.setCupEffectByResult(slot0._iconEffectStatus[slot7], slot2:getCupInfo(slot6) and slot8.result or 0)
	end
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
