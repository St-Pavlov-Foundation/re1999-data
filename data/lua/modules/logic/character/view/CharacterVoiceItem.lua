module("modules.logic.character.view.CharacterVoiceItem", package.seeall)

slot0 = class("CharacterVoiceItem", ListScrollCellExtend)
slot1 = "voiceview_item_in"

function slot0.onInitView(slot0)
	slot0._itemclick = SLFramework.UGUI.UIClickListener.Get(slot0.viewGO)
	slot0._itemAnimator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._goplayicon = gohelper.findChild(slot0.viewGO, "#go_playicon")
	slot0._gostopicon = gohelper.findChild(slot0.viewGO, "#go_stopicon")
	slot0._golockicon = gohelper.findChild(slot0.viewGO, "#go_lockicon")
	slot0._txtvoicename = gohelper.findChildText(slot0.viewGO, "voice/#txt_voicename")
	slot0._govoiceicon = gohelper.findChild(slot0.viewGO, "#go_voiceicon")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._itemclick:AddClickListener(slot0._itemOnClick, slot0)
	slot0:addEventCb(CharacterController.instance, CharacterEvent.ChangeVoiceLang, slot0._onChangeCharVoiceLang, slot0)
end

function slot0.removeEvents(slot0)
	slot0._itemclick:RemoveClickListener()
end

function slot0._itemOnClick(slot0)
	if CharacterDataModel.instance:isCurHeroAudioLocked(slot0._audioId) then
		return
	end

	if CharacterDataModel.instance:isCurHeroAudioPlaying(slot0._audioId) then
		CharacterController.instance:dispatchEvent(CharacterEvent.StopVoice, slot0._audioId)
	else
		slot0:_setRandomVoiceId()
		CharacterDataModel.instance:setPlayingInfo(slot0._audioId, slot0._defaultAudioId)
		CharacterController.instance:dispatchEvent(CharacterEvent.PlayVoice, slot0._audioId)
	end
end

function slot0._setRandomVoiceId(slot0)
	if not slot0._multiVoiceList then
		slot7 = SkinConfig.instance:getSkinCo(HeroModel.instance:getByHeroId(slot0._mo.heroId).skin).id
		slot0._multiVoiceList = {}

		for slot7, slot8 in ipairs(CharacterDataConfig.instance:getCharacterTypeVoicesCO(slot0._mo.heroId, CharacterEnum.VoiceType.MultiVoice, slot7)) do
			if tonumber(slot8.param) == slot0._defaultAudioId then
				table.insert(slot0._multiVoiceList, slot8)
			end
		end
	end

	slot1 = nil

	if #slot0._multiVoiceList > 0 and math.random() > 0.5 then
		slot1 = slot0._multiVoiceList[math.random(#slot0._multiVoiceList)] and slot2.audio
	end

	slot0._audioId = slot1 or slot0._defaultAudioId
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1
	slot0._multiVoiceList = nil
	slot0._defaultAudioId = slot0._mo.id
	slot0._audioId = CharacterDataModel.instance:getPlayingAudioId(slot0._defaultAudioId) or slot0._defaultAudioId

	transformhelper.setLocalScale(slot0._gostopicon.transform, 1, 1, 1)
	slot0:_refreshItem()
end

function slot0._refreshItem(slot0)
	slot0._itemAnimator.enabled = CharacterVoiceModel.instance:isNeedItemAni()

	if CharacterDataModel.instance:isCurHeroAudioLocked(slot0._audioId) then
		gohelper.setActive(slot0._golockicon, true)
		gohelper.setActive(slot0._goplayicon, false)
		gohelper.setActive(slot0._gostopicon, false)
		gohelper.setActive(slot0._govoiceicon, false)
		SLFramework.UGUI.GuiHelper.SetColor(slot0._txtvoicename, "#9D9D9D")

		slot1 = HeroModel.instance:getByHeroId(slot0._mo.heroId)
		slot0._txtvoicename.text = CharacterDataConfig.instance:getConditionStringName(slot0._mo)
	else
		slot1 = CharacterDataModel.instance:isCurHeroAudioPlaying(slot0._audioId)

		gohelper.setActive(slot0._golockicon, false)
		gohelper.setActive(slot0._goplayicon, not slot1)
		gohelper.setActive(slot0._gostopicon, slot1)
		gohelper.setActive(slot0._govoiceicon, slot1)

		if slot1 then
			SLFramework.UGUI.GuiHelper.SetColor(slot0._txtvoicename, "#C66030")
		else
			SLFramework.UGUI.GuiHelper.SetColor(slot0._txtvoicename, "#E2E1DF")
		end

		slot0._txtvoicename.text = " " .. slot0._mo.name
	end
end

function slot0._onChangeCharVoiceLang(slot0)
	slot0._itemAnimator.enabled = CharacterVoiceModel.instance:isNeedItemAni()

	slot0._itemAnimator:Play(uv0, 0, 0)
end

function slot0.onDestroyView(slot0)
end

return slot0
