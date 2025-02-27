slot0 = require("modules.logic.common.defines.UIAnimationName")

module("modules.logic.versionactivity2_6.xugouji.view.XugoujiLevelViewStageItem", package.seeall)

slot1 = class("XugoujiLevelViewStageItem", LuaCompBase)
slot2 = VersionActivity2_6Enum.ActivityId.Xugouji

function slot1.init(slot0, slot1)
	slot0.viewGO = slot1

	gohelper.setActive(slot0.viewGO, true)

	slot0._goStageType1Item = gohelper.findChild(slot0.viewGO, "#go_StageType1")
	slot0._goStageType2Item = gohelper.findChild(slot0.viewGO, "#go_StageType2")
	slot0._goStageType1Lock = gohelper.findChild(slot0._goStageType1Item, "#go_Lock")
	slot0._goStageType2Lock = gohelper.findChild(slot0._goStageType2Item, "#go_Lock")
	slot0._animator = slot1:GetComponent(typeof(UnityEngine.Animator))
	slot0._imageStageIcon = gohelper.findChildImage(slot0.viewGO, "#go_StageType1")
	slot0._imageStageIconLock = gohelper.findChildImage(slot0.viewGO, "#go_StageType1/#go_Lock")
	slot0._txtType1StageName = gohelper.findChildText(slot0.viewGO, "#go_StageType1/#txt_StageName")
	slot0._txtType1StageNum = gohelper.findChildText(slot0.viewGO, "#go_StageType1/#txt_ChapterNum")
	slot0._txtType2StageNum = gohelper.findChildText(slot0.viewGO, "#go_StageType2/#txt_ChapterNum")
	slot0._goCompleteEffect = gohelper.findChild(slot0.viewGO, "vx_complete")
	slot0._completeEffectAnimator = ZProj.ProjAnimatorPlayer.Get(slot0._goCompleteEffect)
	slot0._btnclick = gohelper.findChildButtonWithAudio(slot0.viewGO, "btnClick")

	slot0:_addEvents()
end

function slot1.refreshItem(slot0, slot1, slot2)
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

	if not string.nilorempty(slot1.resource) then
		UISpriteSetMgr.instance:setXugoujiSprite(slot0._imageStageIcon, slot1.resource)
		UISpriteSetMgr.instance:setXugoujiSprite(slot0._imageStageIconLock, slot1.resource)
	end

	gohelper.setActive(slot0._goStageType1Item, slot0._stageType == XugoujiEnum.LevelType.Story)
	gohelper.setActive(slot0._goStageType2Item, slot0._stageType == XugoujiEnum.LevelType.Level)
	gohelper.setActive(slot0._goStageType1Lock, not slot6)
	gohelper.setActive(slot0._goStageType2Lock, not slot6)
	gohelper.setActive(slot0._goCompleteEffect, slot5)
	slot0._completeEffectAnimator:Play(uv0.Idle, nil, )
end

function slot1.refreshTitle(slot0)
	slot0._txtType1StageName.text = slot0._config.name
	slot0._txtType1StageNum.text = string.format("%02d", slot0._index)
	slot0._txtType2StageNum.text = string.format("%02d", slot0._index)
end

function slot1.addEventListeners(slot0)
	slot0._btnclick:AddClickListener(slot0._btnclickOnClick, slot0)
end

function slot1.removeEventListeners(slot0)
	if slot0._btnclick then
		slot0._btnclick:RemoveClickListener()
	end
end

function slot1._btnclickOnClick(slot0)
	if slot0:checkIsOpen() then
		slot0:_delayEnterEpisode()
	end
end

function slot1.checkIsOpen(slot0)
	slot2 = true

	if ActivityModel.instance:getActMO(uv0) == nil then
		logError("not such activity id: " .. slot0.actId)

		slot2 = false
	end

	if not slot1:isOpen() or slot1:isExpired() then
		GameFacade.showToast(ToastEnum.ActivityNotInOpenTime)

		slot2 = false
	end

	if not Activity188Model.instance:isEpisodeUnlock(slot0.episodeId) then
		GameFacade.showToast(ToastEnum.Activity142PreEpisodeNotClear)

		slot2 = false
	end

	return slot2
end

function slot1._delayEnterEpisode(slot0)
	if not slot0._config then
		return
	end

	XugoujiController.instance:dispatchEvent(XugoujiEvent.BeforeEnterEpisode)
	TaskDispatcher.runDelay(slot0._enterGameView, slot0, 0.1)
end

function slot1._enterGameView(slot0)
	XugoujiController.instance:enterEpisode(slot0.episodeId)
end

function slot1._addEvents(slot0)
	XugoujiController.instance:registerCallback(XugoujiEvent.EnterEpisode, slot0._onEnterEpisode, slot0)
end

function slot1._removeEvents(slot0)
	XugoujiController.instance:unregisterCallback(XugoujiEvent.EnterEpisode, slot0._onEnterEpisode, slot0)
end

function slot1.playFinishAni(slot0)
	slot0:refreshItem(slot0._config, slot0._index)
	AudioMgr.instance:trigger(AudioEnum2_6.Xugouji.episodeFinish)
	slot0._animator:Play(uv0.Finish, 0, 0)
	slot0._completeEffectAnimator:Play(uv0.Open, nil, )
	AudioEffectMgr.instance:playAudio(AudioEnum.UI.play_ui_activity_hero37_checkpoint_tongguan)
end

function slot1.playUnlockAni(slot0)
	slot0:refreshItem(slot0._config, slot0._index)
	AudioMgr.instance:trigger(AudioEnum2_6.Xugouji.episodeUnlock)
	slot0._animator:Play(uv0.Unlock, 0, 0)
	AudioEffectMgr.instance:playAudio(AudioEnum.UI.play_ui_activity_hero37_checkpoint_tongguan)
end

function slot1._onEnterEpisode(slot0, slot1)
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

function slot1._storyEnd(slot0)
	if slot0._config.gameId and slot0._config.gameId ~= 0 then
		XugoujiGameStepController.instance:insertStepListClient({
			{
				stepType = XugoujiEnum.GameStepType.WaitGameStart
			},
			{
				stepType = XugoujiEnum.GameStepType.UpdateInitialCard
			}
		})
		XugoujiController.instance:openXugoujiGameView()
	else
		XugoujiController.instance:finishStoryPlay()
	end
end

function slot1.onDestroy(slot0)
	slot0:_removeEvents()
	slot0:removeEventListeners()
end

return slot1
