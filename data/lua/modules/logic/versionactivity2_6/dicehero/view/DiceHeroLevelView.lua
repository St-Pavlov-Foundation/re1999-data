module("modules.logic.versionactivity2_6.dicehero.view.DiceHeroLevelView", package.seeall)

slot0 = class("DiceHeroLevelView", BaseView)

function slot0.onInitView(slot0)
	slot0._gonormal = gohelper.findChild(slot0.viewGO, "#go_Normal")
	slot0._goinfinite = gohelper.findChild(slot0.viewGO, "#go_Endless")
	slot0._btnReset = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_Reset")
	slot0._txtTitle1 = gohelper.findChildTextMesh(slot0.viewGO, "#go_Normal/Title/#txt_Title")
	slot0._txtTitle2 = gohelper.findChildTextMesh(slot0.viewGO, "#go_Endless/Title/#txt_Title")
end

function slot0.addEvents(slot0)
	slot0._btnReset:AddClickListener(slot0._onResetClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnReset:RemoveClickListener()
end

function slot0._onResetClick(slot0)
	MessageBoxController.instance:showMsgBox(MessageBoxIdDefine.DiceHeroReset, MsgBoxEnum.BoxType.Yes_No, slot0._onSendReset, nil, , slot0)
end

function slot0._onSendReset(slot0)
	DiceHeroRpc.instance:sendDiceGiveUp(5)
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_wenming_alaifuchapter)
	gohelper.setActive(slot0._gonormal, not slot0.viewParam.isInfinite)
	gohelper.setActive(slot0._goinfinite, slot0.viewParam.isInfinite)
	gohelper.setActive(slot0._btnReset, slot0.viewParam.isInfinite)

	slot1 = slot0.viewContainer._viewSetting.otherRes.roleinfoitem
	slot2 = slot0.viewParam and slot0.viewParam.chapterId or 1

	for slot6 = 1, 6 do
		slot7 = gohelper.findChild(slot0.viewGO, "#btn_stage" .. slot6)

		if not DiceHeroConfig.instance:getLevelCo(slot2, slot6) then
			break
		end

		MonoHelper.addNoUpdateLuaComOnceToGo(slot7, DiceHeroStageItem):initData(slot9, slot0.viewParam.isInfinite)

		if slot6 == 1 then
			slot0._txtTitle1.text = slot9.chapterName
			slot0._txtTitle2.text = slot9.chapterName
		end
	end

	MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(slot1, gohelper.findChild(slot0.viewGO, "#go_roleinfoitem")), DiceHeroRoleItem, {
		chapter = slot2
	})
end

return slot0
