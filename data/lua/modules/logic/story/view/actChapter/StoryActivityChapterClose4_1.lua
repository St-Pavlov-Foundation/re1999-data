-- chunkname: @modules/logic/story/view/actChapter/StoryActivityChapterClose4_1.lua

module("modules.logic.story.view.actChapter.StoryActivityChapterClose4_1", package.seeall)

local StoryActivityChapterClose4_1 = class("StoryActivityChapterClose4_1", StoryActivityChapterBase)

function StoryActivityChapterClose4_1:onCtor()
	self.assetPath = "ui/viewres/story/v4a1/storyactivitychapterclose.prefab"
end

function StoryActivityChapterClose4_1:onInitView()
	self.goEnd = gohelper.findChild(self.viewGO, "#simage_FullBG/end")
	self.goContinued = gohelper.findChild(self.viewGO, "#simage_FullBG/continue")
	self._anim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function StoryActivityChapterClose4_1:onUpdateView()
	local isend = tonumber(self.data) == 2

	if isend then
		self._anim:Play("end", 0, 0)
	else
		self._anim:Play("continue", 0, 0)
	end

	gohelper.setActive(self.goEnd, isend)
	gohelper.setActive(self.goContinued, not isend)

	self._audioId = self:getAudioId(tonumber(self.data))

	self:_playAudio()
end

function StoryActivityChapterClose4_1:getAudioId(part)
	return AudioEnum.Story.play_activitysfx_atlantis_subsection_close
end

function StoryActivityChapterClose4_1:_playAudio()
	if self._audioId then
		AudioEffectMgr.instance:playAudio(self._audioId)
	end
end

function StoryActivityChapterClose4_1:onHide()
	if self._audioId then
		AudioEffectMgr.instance:stopAudio(self._audioId)

		self._audioId = nil
	end
end

function StoryActivityChapterClose4_1:onDestory()
	if self._audioId then
		AudioEffectMgr.instance:stopAudio(self._audioId)

		self._audioId = nil
	end

	StoryActivityChapterClose4_1.super.onDestory(self)
end

return StoryActivityChapterClose4_1
