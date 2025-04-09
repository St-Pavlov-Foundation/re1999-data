module("modules.logic.story.view.StoryActivityChapterClose2_7", package.seeall)

slot0 = class("StoryActivityChapterClose2_7", StoryActivityChapterBase)

function slot0.onCtor(slot0)
	slot0.assetPath = "ui/viewres/story/v2a7/storyactivitychapterclose.prefab"
end

function slot0.onInitView(slot0)
	slot0.goEnd = gohelper.findChild(slot0.viewGO, "#simage_FullBG/end")
	slot0.goContinued = gohelper.findChild(slot0.viewGO, "#simage_FullBG/continue")
	slot0._anim = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function slot0.onUpdateView(slot0)
	if tonumber(slot0.data) == 2 then
		slot0._anim:Play("close1", 0, 0)
	else
		slot0._anim:Play("close", 0, 0)
	end

	gohelper.setActive(slot0.goEnd, slot1)
	gohelper.setActive(slot0.goContinued, not slot1)

	slot0._audioId = slot0:getAudioId(tonumber(slot0.data))

	slot0:_playAudio()
end

function slot0.getAudioId(slot0, slot1)
	return AudioEnum.Story.play_activitysfx_yuzhou_chapter_continue
end

function slot0._playAudio(slot0)
	if slot0._audioId then
		AudioEffectMgr.instance:playAudio(slot0._audioId)
	end
end

function slot0.onHide(slot0)
	if slot0._audioId then
		AudioEffectMgr.instance:stopAudio(slot0._audioId)

		slot0._audioId = nil
	end
end

function slot0.onDestory(slot0)
	if slot0._audioId then
		AudioEffectMgr.instance:stopAudio(slot0._audioId)

		slot0._audioId = nil
	end

	uv0.super.onDestory(slot0)
end

return slot0
