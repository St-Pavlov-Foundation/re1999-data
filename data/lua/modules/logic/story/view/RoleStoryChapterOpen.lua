module("modules.logic.story.view.RoleStoryChapterOpen", package.seeall)

slot0 = class("RoleStoryChapterOpen", StoryActivityChapterBase)

function slot0.onCtor(slot0)
	slot0.assetPath = "ui/viewres/story/rolestorychapteropen.prefab"
end

function slot0.onInitView(slot0)
	slot0._goBg = gohelper.findChild(slot0.viewGO, "#go_bg")
	slot0._txtTitle = gohelper.findChildTextMesh(slot0._goBg, "#txt_Title")
	slot0._txtTitleEn = gohelper.findChildTextMesh(slot0._goBg, "#txt_TitleEn")
	slot0._txtEpisode = gohelper.findChildTextMesh(slot0._goBg, "#txt_Episode")
end

function slot0.onUpdateView(slot0)
	slot1 = slot0.data
	slot0._txtTitle.text = slot1.navigateTxts[GameLanguageMgr.instance:getLanguageTypeStoryIndex()]
	slot0._txtTitleEn.text = slot1.navigateTxts[LanguageEnum.LanguageStoryType.EN]
	slot0._txtEpisode.text = slot1.navigateChapterEn
end

function slot0.onHide(slot0)
end

function slot0.onDestory(slot0)
	uv0.super.onDestory(slot0)
end

return slot0
