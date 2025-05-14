module("modules.logic.character.view.CharacterVoiceItem", package.seeall)

local var_0_0 = class("CharacterVoiceItem", ListScrollCellExtend)
local var_0_1 = "voiceview_item_in"

function var_0_0.onInitView(arg_1_0)
	arg_1_0._itemclick = SLFramework.UGUI.UIClickListener.Get(arg_1_0.viewGO)
	arg_1_0._itemAnimator = arg_1_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._goplayicon = gohelper.findChild(arg_1_0.viewGO, "#go_playicon")
	arg_1_0._gostopicon = gohelper.findChild(arg_1_0.viewGO, "#go_stopicon")
	arg_1_0._golockicon = gohelper.findChild(arg_1_0.viewGO, "#go_lockicon")
	arg_1_0._txtvoicename = gohelper.findChildText(arg_1_0.viewGO, "voice/#txt_voicename")
	arg_1_0._govoiceicon = gohelper.findChild(arg_1_0.viewGO, "#go_voiceicon")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._itemclick:AddClickListener(arg_2_0._itemOnClick, arg_2_0)
	arg_2_0:addEventCb(CharacterController.instance, CharacterEvent.ChangeVoiceLang, arg_2_0._onChangeCharVoiceLang, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._itemclick:RemoveClickListener()
end

function var_0_0._itemOnClick(arg_4_0)
	if CharacterDataModel.instance:isCurHeroAudioLocked(arg_4_0._audioId) then
		return
	end

	if CharacterDataModel.instance:isCurHeroAudioPlaying(arg_4_0._audioId) then
		CharacterController.instance:dispatchEvent(CharacterEvent.StopVoice, arg_4_0._audioId)
	else
		arg_4_0:_setRandomVoiceId()
		CharacterDataModel.instance:setPlayingInfo(arg_4_0._audioId, arg_4_0._defaultAudioId)
		CharacterController.instance:dispatchEvent(CharacterEvent.PlayVoice, arg_4_0._audioId)
	end
end

function var_0_0._setRandomVoiceId(arg_5_0)
	if not arg_5_0._multiVoiceList then
		local var_5_0 = HeroModel.instance:getByHeroId(arg_5_0._mo.heroId)
		local var_5_1 = SkinConfig.instance:getSkinCo(var_5_0.skin)
		local var_5_2 = CharacterDataConfig.instance:getCharacterTypeVoicesCO(arg_5_0._mo.heroId, CharacterEnum.VoiceType.MultiVoice, var_5_1.id)

		arg_5_0._multiVoiceList = {}

		for iter_5_0, iter_5_1 in ipairs(var_5_2) do
			if tonumber(iter_5_1.param) == arg_5_0._defaultAudioId then
				table.insert(arg_5_0._multiVoiceList, iter_5_1)
			end
		end
	end

	local var_5_3

	if #arg_5_0._multiVoiceList > 0 and math.random() > 0.5 then
		local var_5_4 = arg_5_0._multiVoiceList[math.random(#arg_5_0._multiVoiceList)]

		var_5_3 = var_5_4 and var_5_4.audio
	end

	arg_5_0._audioId = var_5_3 or arg_5_0._defaultAudioId
end

function var_0_0._editableInitView(arg_6_0)
	return
end

function var_0_0.onUpdateMO(arg_7_0, arg_7_1)
	arg_7_0._mo = arg_7_1
	arg_7_0._multiVoiceList = nil
	arg_7_0._defaultAudioId = arg_7_0._mo.id
	arg_7_0._audioId = CharacterDataModel.instance:getPlayingAudioId(arg_7_0._defaultAudioId) or arg_7_0._defaultAudioId

	transformhelper.setLocalScale(arg_7_0._gostopicon.transform, 1, 1, 1)
	arg_7_0:_refreshItem()
end

function var_0_0._refreshItem(arg_8_0)
	arg_8_0._itemAnimator.enabled = CharacterVoiceModel.instance:isNeedItemAni()

	if CharacterDataModel.instance:isCurHeroAudioLocked(arg_8_0._audioId) then
		gohelper.setActive(arg_8_0._golockicon, true)
		gohelper.setActive(arg_8_0._goplayicon, false)
		gohelper.setActive(arg_8_0._gostopicon, false)
		gohelper.setActive(arg_8_0._govoiceicon, false)
		SLFramework.UGUI.GuiHelper.SetColor(arg_8_0._txtvoicename, "#9D9D9D")

		local var_8_0 = HeroModel.instance:getByHeroId(arg_8_0._mo.heroId)

		arg_8_0._txtvoicename.text = CharacterDataConfig.instance:getConditionStringName(arg_8_0._mo)
	else
		local var_8_1 = CharacterDataModel.instance:isCurHeroAudioPlaying(arg_8_0._audioId)

		gohelper.setActive(arg_8_0._golockicon, false)
		gohelper.setActive(arg_8_0._goplayicon, not var_8_1)
		gohelper.setActive(arg_8_0._gostopicon, var_8_1)
		gohelper.setActive(arg_8_0._govoiceicon, var_8_1)

		if var_8_1 then
			SLFramework.UGUI.GuiHelper.SetColor(arg_8_0._txtvoicename, "#C66030")
		else
			SLFramework.UGUI.GuiHelper.SetColor(arg_8_0._txtvoicename, "#E2E1DF")
		end

		arg_8_0._txtvoicename.text = " " .. arg_8_0._mo.name
	end
end

function var_0_0._onChangeCharVoiceLang(arg_9_0)
	arg_9_0._itemAnimator.enabled = CharacterVoiceModel.instance:isNeedItemAni()

	arg_9_0._itemAnimator:Play(var_0_1, 0, 0)
end

function var_0_0.onDestroyView(arg_10_0)
	return
end

return var_0_0
