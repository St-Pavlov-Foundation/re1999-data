module("modules.logic.character.view.recommed.CharacterRecommedHeroView", package.seeall)

local var_0_0 = class("CharacterRecommedHeroView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gospine = gohelper.findChild(arg_1_0.viewGO, "left/hero/#go_spine")
	arg_1_0._gospineroot = gohelper.findChild(arg_1_0.viewGO, "left/hero")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(CharacterRecommedController.instance, CharacterRecommedEvent.OnCutHeroAnimCB, arg_2_0._refreshHero, arg_2_0)
	arg_2_0:addEventCb(CharacterRecommedController.instance, CharacterRecommedEvent.OnJumpView, arg_2_0._onJumpView, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(CharacterRecommedController.instance, CharacterRecommedEvent.OnCutHeroAnimCB, arg_3_0._refreshHero, arg_3_0)
	arg_3_0:removeEventCb(CharacterRecommedController.instance, CharacterRecommedEvent.OnJumpView, arg_3_0._onJumpView, arg_3_0)
end

function var_0_0._editableInitView(arg_4_0)
	transformhelper.setLocalScale(arg_4_0._gospine.transform, 1, 1, 1)
	recthelper.setAnchor(arg_4_0._gospine.transform, -200, -1174)
end

function var_0_0.onOpen(arg_5_0)
	arg_5_0:_refreshHero(arg_5_0.viewParam.heroId)
end

function var_0_0._onJumpView(arg_6_0, arg_6_1)
	if arg_6_1 == CharacterRecommedEnum.JumpView.Rank then
		gohelper.setActive(arg_6_0._gospineroot.gameObject, false)
	end
end

function var_0_0._refreshHero(arg_7_0, arg_7_1)
	if arg_7_0._heroId == arg_7_1 then
		return
	end

	arg_7_0._heroId = arg_7_1
	arg_7_0._heroRecommendMo = CharacterRecommedModel.instance:getHeroRecommendMo(arg_7_1)
	arg_7_0._heroSkinConfig = arg_7_0._heroRecommendMo:getHeroSkinConfig()

	arg_7_0:_updateHero()
	gohelper.setActive(arg_7_0._gospineroot.gameObject, true)

	local var_7_0 = SkinConfig.instance:getSkinOffset(arg_7_0._heroSkinConfig.characterViewOffset)
	local var_7_1 = tonumber(var_7_0[3])

	recthelper.setAnchor(arg_7_0._gospine.transform, tonumber(var_7_0[1]), tonumber(var_7_0[2]))
	transformhelper.setLocalScale(arg_7_0._gospine.transform, var_7_1, var_7_1, var_7_1)
end

function var_0_0._updateHero(arg_8_0)
	arg_8_0._uiSpine = GuiModelAgent.Create(arg_8_0._gospine, true)

	arg_8_0._uiSpine:setShareRT(CharacterVoiceEnum.RTShareType.Normal, arg_8_0.viewName)
	arg_8_0:_loadSpine()
end

function var_0_0._loadSpine(arg_9_0)
	arg_9_0._uiSpine:setResPath(arg_9_0._heroSkinConfig, arg_9_0._onSpineLoaded, arg_9_0)
end

function var_0_0._onSpineLoaded(arg_10_0)
	arg_10_0._spineLoaded = true
end

function var_0_0.playCloseTransition(arg_11_0)
	local var_11_0 = arg_11_0._uiSpine and arg_11_0._uiSpine:_getLive2d()

	if not var_11_0 or not var_11_0._cameraGo then
		return
	end

	gohelper.setActive(var_11_0._cameraGo, false)
end

function var_0_0.onDestroyView(arg_12_0)
	if arg_12_0._uiSpine then
		arg_12_0._uiSpine:onDestroy()

		arg_12_0._uiSpine = nil
	end
end

return var_0_0
