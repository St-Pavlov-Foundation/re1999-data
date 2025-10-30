-- chunkname: @modules/logic/story/view/actChapter/RoleStoryChapterOpen.lua

module("modules.logic.story.view.actChapter.RoleStoryChapterOpen", package.seeall)

local RoleStoryChapterOpen = class("RoleStoryChapterOpen", StoryActivityChapterBase)

function RoleStoryChapterOpen:onCtor()
	self.assetPath = "ui/viewres/story/rolestorychapteropen.prefab"
end

function RoleStoryChapterOpen:onInitView()
	self._goBg = gohelper.findChild(self.viewGO, "#go_bg")
	self._txtTitle = gohelper.findChildTextMesh(self._goBg, "#txt_Title")
	self._txtTitleEn = gohelper.findChildTextMesh(self._goBg, "#txt_TitleEn")
	self._txtEpisode = gohelper.findChildTextMesh(self._goBg, "#txt_Episode")
end

function RoleStoryChapterOpen:onUpdateView()
	local chapterCo = self.data

	self._txtTitle.text = chapterCo.navigateTxts[GameLanguageMgr.instance:getLanguageTypeStoryIndex()]
	self._txtTitleEn.text = chapterCo.navigateTxts[LanguageEnum.LanguageStoryType.EN]
	self._txtEpisode.text = chapterCo.navigateChapterEn
end

function RoleStoryChapterOpen:onHide()
	return
end

function RoleStoryChapterOpen:onDestory()
	RoleStoryChapterOpen.super.onDestory(self)
end

return RoleStoryChapterOpen
