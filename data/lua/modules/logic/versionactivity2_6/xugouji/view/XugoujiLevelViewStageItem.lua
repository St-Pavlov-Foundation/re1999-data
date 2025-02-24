module("modules.logic.versionactivity2_6.xugouji.view.XugoujiLevelViewStageItem", package.seeall)

slot0 = class("XugoujiLevelViewStageItem", LuaCompBase)
slot1 = VersionActivity2_6Enum.ActivityId.Xugouji
slot2 = LoperaEnum.MapCfgIdx

function slot0.init(slot0, slot1)
	slot0.viewGO = slot1

	gohelper.setActive(slot0.viewGO, true)

	slot0._goStageType1Item = gohelper.findChild(slot0.viewGO, "#go_StageType1")
	slot0._goStageType2Item = gohelper.findChild(slot0.viewGO, "#go_StageType2")
	slot0._goStageType1Lock = gohelper.findChild(slot0._goStageType1Item, "#go_Lock")
	slot0._goStageType2Lock = gohelper.findChild(slot0._goStageType2Item, "#go_Lock")
	slot0._animator = slot1:GetComponent(typeof(UnityEngine.Animator))
	slot0._imagepoint = gohelper.findChildImage(slot0.viewGO, "#image_point")
	slot0._goImagepointfinished = gohelper.findChild(slot0.viewGO, "#image_pointfinished")
	slot0._gostagefinish = gohelper.findChild(slot0.viewGO, "unlock/#go_stagefinish")
	slot0._gostar = gohelper.findChild(slot0.viewGO, "unlock/#go_stage/info/#txt_stagename/#go_star")
	slot0._gohasstar = gohelper.findChild(slot0._gostar, "has/#image_Star")
	slot0._imagestageline = gohelper.findChildImage(slot0.viewGO, "unlock/#image_stageline")
	slot0._gogame = gohelper.findChild(slot0.viewGO, "unlock/#go_stage/#go_Game")
	slot0._gostory = gohelper.findChild(slot0.viewGO, "unlock/#go_stagenormal/#go_Story")
	slot0._imageline = gohelper.findChildImage(slot0.viewGO, "unlock/#image_line")
	slot0._imageangle = gohelper.findChildImage(slot0.viewGO, "unlock/#image_angle")
	slot0._txtType1StageName = gohelper.findChildText(slot0.viewGO, "#go_StageType1/#txt_StageName")
	slot0._txtType1StageNum = gohelper.findChildText(slot0.viewGO, "#go_StageType1/#txt_ChapterNum")
	slot0._txtType2StageNum = gohelper.findChildText(slot0.viewGO, "#go_StageType2/#txt_ChapterNum")
	slot0._btnreview = gohelper.findChildButtonWithAudio(slot0.viewGO, "unlock/#go_stage/info/#txt_stagename/#btn_review")
	slot0._btnclick = gohelper.findChildButtonWithAudio(slot0.viewGO, "btnClick")

	slot0:_addEvents()
end

function slot0.refreshItem(slot0, slot1, slot2)
	slot0._actId = VersionActivity2_6Enum.ActivityId.Xugouji
	slot0._index = slot2
	slot0._config = slot1
	slot0.episodeId = slot0._config.episodeId

	if slot0.episodeId == XugoujiEnum.ChallengeEpisodeId then
		gohelper.setActive(slot0.viewGO, false)

		return
	end

	slot0._stageType = slot1.gameId ~= 0 and XugoujiEnum.LevelType.Level or XugoujiEnum.LevelType.Story
	slot3 = Activity188Model.instance:getCurEpisodeId()

	slot0:refreshTitle()

	slot4 = slot0._config.mapId ~= 0
	slot5 = Activity188Model.instance:isEpisodeFinished(slot0.episodeId)
	slot6 = Activity188Model.instance:isEpisodeUnlock(slot0.episodeId)

	gohelper.setActive(slot0._goStageType1Item, slot0._stageType == XugoujiEnum.LevelType.Story)
	gohelper.setActive(slot0._goStageType2Item, slot0._stageType == XugoujiEnum.LevelType.Level)
	gohelper.setActive(slot0._goStageType1Lock, not slot6)
	gohelper.setActive(slot0._goStageType2Lock, not slot6)
	gohelper.setActive(slot0._gostagefinish, slot4)
	gohelper.setActive(slot0._gohasstar, slot5)
	gohelper.setActive(slot0._gogame, slot4)
	gohelper.setActive(slot0._goImagepointfinished, slot5)
end

function slot0.refreshTitle(slot0)
	slot0._txtType1StageName.text = slot0._config.name
	slot0._txtType1StageNum.text = string.format("%02d", slot0._index)
	slot0._txtType2StageNum.text = string.format("%02d", slot0._index)
end

function slot0.addEventListeners(slot0)
	slot0._btnclick:AddClickListener(slot0._btnclickOnClick, slot0)
end

function slot0.removeEventListeners(slot0)
	if slot0._btnclick then
		slot0._btnclick:RemoveClickListener()
	end
end

function slot0._btnclickOnClick(slot0)
	slot0:_delayEnterEpisode()
end

function slot0._delayEnterEpisode(slot0)
	if not slot0._config then
		return
	end

	XugoujiController.instance:dispatchEvent(XugoujiEvent.BeforeEnterEpisode)
	TaskDispatcher.runDelay(slot0._enterGameView, slot0, 0.1)
end

function slot0._enterGameView(slot0)
	XugoujiController.instance:enterEpisode(slot0.episodeId)
end

function slot0._btnReviewOnClick(slot0)
	if slot0._config.mapId ~= 0 then
		LanShouPaController.instance:openStoryView(slot0.episodeId)
	else
		StoryController.instance:playStory(slot0._config.storyId, nil, slot0._storyEnd, slot0)
	end
end

function slot0._addEvents(slot0)
	XugoujiController.instance:registerCallback(XugoujiEvent.EnterEpisode, slot0._onEnterEpisode, slot0)
end

function slot0._removeEvents(slot0)
	XugoujiController.instance:unregisterCallback(XugoujiEvent.EnterEpisode, slot0._onEnterEpisode, slot0)
end

function slot0.playFinishAni(slot0)
	slot0:refreshItem(slot0._config, slot0._index)
end

function slot0.playUnlockAni(slot0)
	slot0:refreshItem(slot0._config, slot0._index)
end

function slot0._playChooseEpisode(slot0, slot1)
	if slot0.episodeId == Activity188Model.instance:getCurEpisodeId() then
		AudioEffectMgr.instance:playAudio(AudioEnum.UI.play_ui_activity_hero37_checkpoint_unlock)

		if slot1 < slot0.episodeId then
			-- Nothing
		end
	end
end

function slot0._onEnterEpisode(slot0, slot1)
	if slot0.episodeId ~= slot1 then
		return
	end

	GameUtil.playerPrefsSetStringByUserId(PlayerPrefsKey.Version2_6XugoujiSelect .. uv0, tostring(slot0._index))

	if slot0._config.gameId and slot0._config.gameId ~= 0 then
		if slot0._config.storyId == 0 or Activity188Model.instance:getCurEpisodeId() == slot1 then
			slot0:_storyEnd()
		else
			StoryController.instance:playStory(slot0._config.storyId, nil, slot0._storyEnd, slot0)
		end
	elseif slot0._config.storyId == 0 then
		slot0:_storyEnd()
	else
		StoryController.instance:playStory(slot0._config.storyId, nil, slot0._storyEnd, slot0)
	end

	Activity188Model.instance:setCurEpisodeId(slot1)
end

function slot0._storyEnd(slot0)
	if slot0._config.gameId and slot0._config.gameId ~= 0 then
		XugoujiController.instance:openXugoujiGameView()
	else
		XugoujiController.instance:finishStoryPlay()
	end
end

function slot0.onDestroy(slot0)
	slot0:_removeEvents()
	slot0:removeEventListeners()
end

return slot0
