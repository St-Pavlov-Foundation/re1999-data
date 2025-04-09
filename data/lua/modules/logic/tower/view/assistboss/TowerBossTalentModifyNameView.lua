module("modules.logic.tower.view.assistboss.TowerBossTalentModifyNameView", package.seeall)

slot0 = class("TowerBossTalentModifyNameView", BaseView)

function slot0.onInitView(slot0)
	slot0._btncloseView = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_closeView")
	slot0._simagerightbg = gohelper.findChildSingleImage(slot0.viewGO, "window/#simage_rightbg")
	slot0._simageleftbg = gohelper.findChildSingleImage(slot0.viewGO, "window/#simage_leftbg")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "bottom/#btn_close")
	slot0._btnsure = gohelper.findChildButtonWithAudio(slot0.viewGO, "bottom/#btn_sure")
	slot0._input = gohelper.findChildTextMeshInputField(slot0.viewGO, "message/#input_signature")
	slot0._txttext = gohelper.findChildText(slot0.viewGO, "message/#input_signature/textarea/#txt_text")
	slot0._btncleanname = gohelper.findChildButtonWithAudio(slot0.viewGO, "message/#btn_cleanname")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btncloseView:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0._btnsure:AddClickListener(slot0._btnsureOnClick, slot0)
	slot0._btncleanname:AddClickListener(slot0._btncleannameOnClick, slot0)
	slot0._input:AddOnValueChanged(slot0._onInputValueChanged, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btncloseView:RemoveClickListener()
	slot0._btnclose:RemoveClickListener()
	slot0._btnsure:RemoveClickListener()
	slot0._btncleanname:RemoveClickListener()
	slot0._input:RemoveOnValueChanged()
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._btnsureOnClick(slot0)
	if string.nilorempty(slot0._input:GetText()) then
		return
	end

	if GameUtil.utf8len(slot1) > 6 then
		GameFacade.showToast(ToastEnum.InformPlayerCharLen)

		return
	end

	TowerRpc.instance:sendTowerRenameTalentPlanRequest(slot0.bossId, GameUtil.trimInput(slot1), slot0._onRenameTalentReply, slot0)
end

function slot0._onRenameTalentReply(slot0)
	slot0:_btncloseOnClick()
	GameFacade.showToast(ToastEnum.PlayerModifyChangeName)
end

function slot0._btncleannameOnClick(slot0)
	slot0._input:SetText("")
end

function slot0._onInputValueChanged(slot0)
	gohelper.setActive(slot0._btncleanname, not string.nilorempty(slot0._input:GetText()))
end

function slot0._editableInitView(slot0)
	slot0._simageleftbg:LoadImage(ResUrl.getCommonIcon("bg_1"))
	slot0._simagerightbg:LoadImage(ResUrl.getCommonIcon("bg_2"))
end

function slot0.onOpen(slot0)
	slot0.bossId = slot0.viewParam.bossId
end

function slot0.onDestroyView(slot0)
	slot0._simagerightbg:UnLoadImage()
	slot0._simageleftbg:UnLoadImage()
end

return slot0
