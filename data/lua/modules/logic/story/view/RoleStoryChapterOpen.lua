module("modules.logic.story.view.RoleStoryChapterOpen", package.seeall)

local var_0_0 = class("RoleStoryChapterOpen", StoryActivityChapterBase)

function var_0_0.onCtor(arg_1_0)
	arg_1_0.assetPath = "ui/viewres/story/rolestorychapteropen.prefab"
end

function var_0_0.onInitView(arg_2_0)
	arg_2_0._goBg = gohelper.findChild(arg_2_0.viewGO, "#go_bg")
	arg_2_0._txtTitle = gohelper.findChildTextMesh(arg_2_0._goBg, "#txt_Title")
	arg_2_0._txtTitleEn = gohelper.findChildTextMesh(arg_2_0._goBg, "#txt_TitleEn")
	arg_2_0._txtEpisode = gohelper.findChildTextMesh(arg_2_0._goBg, "#txt_Episode")
end

function var_0_0.onUpdateView(arg_3_0)
	local var_3_0 = arg_3_0.data

	arg_3_0._txtTitle.text = var_3_0.navigateTxts[GameLanguageMgr.instance:getLanguageTypeStoryIndex()]
	arg_3_0._txtTitleEn.text = var_3_0.navigateTxts[LanguageEnum.LanguageStoryType.EN]
	arg_3_0._txtEpisode.text = var_3_0.navigateChapterEn
end

function var_0_0.onHide(arg_4_0)
	return
end

function var_0_0.onDestory(arg_5_0)
	var_0_0.super.onDestory(arg_5_0)
end

return var_0_0
