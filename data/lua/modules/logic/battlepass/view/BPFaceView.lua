module("modules.logic.battlepass.view.BPFaceView", package.seeall)

slot0 = class("BPFaceView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnClose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#simage_fullbg/icon/#btn_close")
	slot0._btnCloseBg = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_closeBg")
	slot0._btnStart = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_start")
	slot0._headicon = gohelper.findChild(slot0.viewGO, "stamp/icon")
	slot0._txthead = gohelper.findChildTextMesh(slot0.viewGO, "stamp/txt")
	slot0._txtheadname = gohelper.findChildTextMesh(slot0.viewGO, "stamp/name")
	slot0._simagesignature = gohelper.findChildSingleImage(slot0.viewGO, "desc/#simage_signature")
	slot0._btnDetail = gohelper.findChildButtonWithAudio(slot0.viewGO, "desc/#txt_skinname/#btn_faj", AudioEnum.UI.play_artificial_ui_carddisappear)
	slot0._txtskinname = gohelper.findChildTextMesh(slot0.viewGO, "desc/#txt_skinname")
	slot0._txtname = gohelper.findChildTextMesh(slot0.viewGO, "desc/#txt_skinname/#txt_name")
	slot0._txtnameEn = gohelper.findChildTextMesh(slot0.viewGO, "desc/#txt_skinname/#txt_name/#txt_enname")
end

function slot0.addEvents(slot0)
	slot0._btnClose:AddClickListener(slot0.onBtnCloseClick, slot0, BpEnum.ButtonName.Close)
	slot0._btnCloseBg:AddClickListener(slot0.onBtnCloseClick, slot0, BpEnum.ButtonName.CloseBg)
	slot0._btnStart:AddClickListener(slot0._openBpView, slot0)
	slot0._btnDetail:AddClickListener(slot0._btndetailOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnClose:RemoveClickListener()
	slot0._btnCloseBg:RemoveClickListener()
	slot0._btnStart:RemoveClickListener()
	slot0._btnDetail:RemoveClickListener()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, slot0._onViewClose, slot0)
end

function slot0._openBpView(slot0)
	slot0:statData(BpEnum.ButtonName.Goto)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, slot0._onViewClose, slot0)
	BpController.instance:openBattlePassView()
end

function slot0.onClickModalMask(slot0)
	slot0:onBtnCloseClick(BpEnum.ButtonName.CloseBg)
end

function slot0.onBtnCloseClick(slot0, slot1)
	slot0:statData(slot1)
	slot0:closeThis()
end

function slot0._btndetailOnClick(slot0)
	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.HeroSkin, BpConfig.instance:getCurSkinId(BpModel.instance.id), false, nil, false)
end

function slot0._onViewClose(slot0, slot1)
	if slot1 == ViewName.BpView then
		slot0:closeThis()
	end
end

function slot0.onOpen(slot0)
	if BpConfig.instance:getBpCO(BpModel.instance.id) then
		slot0._txtskinname.text = slot1.bpSkinDesc
		slot0._txtname.text = slot1.bpSkinNametxt
		slot0._txtnameEn.text = slot1.bpSkinEnNametxt

		slot0._simagesignature:LoadImage(ResUrl.getSignature(lua_character.configDict[lua_skin.configDict[BpConfig.instance:getCurSkinId(BpModel.instance.id)].characterId].signature))
	end

	slot2, slot3 = BpConfig.instance:getCurHeadItemName(BpModel.instance.id)
	slot0._txtheadname.text = string.format("「%s」", slot2)

	IconMgr.instance:getCommonLiveHeadIcon(slot0._headicon):setLiveHead(slot3)
	PlayerPrefsHelper.setString(string.format("%s#%s#%s", PlayerPrefsKey.FirstShowPatFace, "BPFace", PlayerModel.instance:getPlayinfo().userId), tostring(BpModel.instance.id))
end

function slot0.statData(slot0, slot1)
	StatController.instance:track(StatEnum.EventName.BP_Click_Face_Slapping, {
		[StatEnum.EventProperties.BP_Button_Name] = slot1
	})
end

return slot0
