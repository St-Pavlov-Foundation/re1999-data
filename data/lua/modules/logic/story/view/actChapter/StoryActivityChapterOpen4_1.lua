-- chunkname: @modules/logic/story/view/actChapter/StoryActivityChapterOpen4_1.lua

module("modules.logic.story.view.actChapter.StoryActivityChapterOpen4_1", package.seeall)

local StoryActivityChapterOpen4_1 = class("StoryActivityChapterOpen4_1", StoryActivityChapterBase)

function StoryActivityChapterOpen4_1:onCtor()
	self.assetPath = "ui/viewres/story/v4a1/storyactivitychapteropen.prefab"
end

function StoryActivityChapterOpen4_1:onInitView()
	self._goVideo = gohelper.findChild(self.viewGO, "#go_video")
	self._goChapter = gohelper.findChild(self.viewGO, "#go_chapter")
	self._simageSection = gohelper.findChildSingleImage(self._goChapter, "simageChapter")
	self._simageTitle = gohelper.findChildSingleImage(self._goChapter, "simageTitle")
	self._anim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._goMaskBg = gohelper.findChild(self.viewGO, "#gomask")
end

function StoryActivityChapterOpen4_1:onUpdateView()
	gohelper.setActive(self.viewGO, false)
	self:play()
end

function StoryActivityChapterOpen4_1:play()
	gohelper.setActive(self.viewGO, true)

	local co = self.data
	local vals = string.splitToNumber(co.navigateChapterEn, "#")
	local chapter = vals[1] or 1
	local part = vals[2] or 1

	gohelper.setActive(self._goMaskBg, true)

	local config = StoryConfig.instance:getActivityOpenConfig(chapter, part)
	local section = string.format("4_1_chapter_%s", config and config.labelRes or 1)
	local title = string.format("4_1_title_%s", part)

	self._simageTitle:LoadImage(self:getLangResBg(title), self.onTitleLoaded, self)
	self._simageSection:LoadImage(self:getLangResBg(section), self.onSectionLoaded, self)

	self._anim.speed = 0

	self:playVideo()
end

function StoryActivityChapterOpen4_1:playVideo()
	local co = self.data
	local vals = string.splitToNumber(co.navigateChapterEn, "#")
	local chapter = vals[1] or 1
	local part = vals[2] or 1
	local videoName = self:getVideoName(part)

	if not self._videoItem then
		self._videoItem = StoryActivityVideoItem.New(self._goVideo)
	end

	local audioId = self:getAudioId(part)
	local videoCo = {
		loop = false,
		audioNoStopByFinish = true,
		audioId = audioId,
		startCallback = self.onVideoStart,
		startCallbackObj = self,
		outCallback = self.onVideoOut,
		outCallbackObj = self
	}

	self._videoItem:playVideo(videoName, videoCo)
end

function StoryActivityChapterOpen4_1:onVideoStart()
	gohelper.setActive(self._goMaskBg, false)

	self._anim.speed = 1

	local co = self.data
	local vals = string.splitToNumber(co.navigateChapterEn, "#")
	local chapter = vals[1] or 1
	local part = vals[2] or 1

	if part == 1 then
		self._anim:Play("open", 0, 0)
	else
		self._anim:Play("open1", 0, 0)
	end
end

function StoryActivityChapterOpen4_1:onVideoOut(videoItem)
	local videoName = videoItem._videoName
	local openVideoName = "v4a1_opening_2"

	if videoName ~= openVideoName then
		local videoCo = {
			loop = false
		}

		videoItem:playVideo(openVideoName, videoCo)
	end
end

function StoryActivityChapterOpen4_1:onSectionLoaded()
	local image = gohelper.findChildImage(self._goChapter, "simageChapter")

	if image then
		image:SetNativeSize()
	end
end

function StoryActivityChapterOpen4_1:onTitleLoaded()
	local image = gohelper.findChildImage(self._goChapter, "simageTitle")

	if image then
		image:SetNativeSize()
	end
end

function StoryActivityChapterOpen4_1:onBgLoaded()
	ZProj.UGUIHelper.SetImageSize(self._simageBg.gameObject)
end

function StoryActivityChapterOpen4_1:getVideoName(part)
	return part == 1 and "v4a1_opening_1" or "v4a1_opening_2"
end

function StoryActivityChapterOpen4_1:getLangResBg(name)
	return string.format("singlebg_lang/txt_v4a1_storyactivityopenclose/%s.png", name)
end

function StoryActivityChapterOpen4_1:getAudioId(part)
	if part == 1 then
		return AudioEnum.Story.play_activitysfx_atlantis_chapter_open
	end

	return AudioEnum.Story.play_activitysfx_atlantis_subsection_open
end

function StoryActivityChapterOpen4_1:onHide()
	if self._videoItem then
		self._videoItem:onVideoOut()
	end

	TaskDispatcher.cancelTask(self.play, self)
end

function StoryActivityChapterOpen4_1:onDestory()
	if self._simageTitle then
		self._simageTitle:UnLoadImage()
	end

	if self._simageSection then
		self._simageSection:UnLoadImage()
	end

	if self._videoItem then
		self._videoItem:onDestroy()

		self._videoItem = nil
	end

	TaskDispatcher.cancelTask(self.play, self)
	StoryActivityChapterOpen4_1.super.onDestory(self)
end

return StoryActivityChapterOpen4_1
