module("modules.logic.login.view.SimulateLoginView", package.seeall)

slot0 = class("SimulateLoginView", BaseView)

function slot0.ctor(slot0)
	slot0._button = nil
	slot0._inputField = nil
end

function slot0.onInitView(slot0)
	slot0._button = gohelper.findChildButtonWithAudio(slot0.viewGO, "Button")
	slot0._inputField = gohelper.findChildTextMeshInputField(slot0.viewGO, "InputField")
	slot0._btnAgeFit = gohelper.findChildButtonWithAudio(slot0.viewGO, "leftbtn/#btn_agefit")
end

function slot0.addEvents(slot0)
	slot0._button:AddClickListener(slot0._onClickButton, slot0)
	slot0._btnAgeFit:AddClickListener(slot0._onClickAgeFit, slot0)
	slot0._inputField:AddOnEndEdit(slot0._onEndEdit, slot0)
end

function slot0.removeEvents(slot0)
	slot0._button:RemoveClickListener()
	slot0._btnAgeFit:RemoveClickListener()
	slot0._inputField:RemoveOnEndEdit()
end

function slot0.onOpen(slot0)
	gohelper.addUIClickAudio(slot0._button.gameObject, AudioEnum.UI.UI_Common_Click)
	slot0._inputField:SetText(PlayerPrefsHelper.getString(PlayerPrefsKey.SimulateAccount))
	TaskDispatcher.runRepeat(slot0._onTick, slot0, 0.1)
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._onTick, slot0)
end

function slot0._onTick(slot0)
	if not ViewMgr.instance:isOpen(ViewName.LoginView) then
		logNormal("LoginView has close, close SimulateLoginView too")
		slot0:closeThis()
	end
end

function slot0._onClickButton(slot0, slot1)
	if string.nilorempty(slot0._inputField:GetText()) then
		GameFacade.showToast(ToastEnum.SimulateLogin)

		return
	end

	slot0:closeThis()
	LoginModel.instance:setChannelParam("", slot2, "", "", "")
	LoginController.instance:login({})
end

function slot0.onClickModalMask(slot0)
	slot0:_onClickButton()
end

function slot0._onClickAgeFit(slot0)
	ViewMgr.instance:openView(ViewName.SdkFitAgeTipView)
end

function slot0._onEndEdit(slot0, slot1)
	PlayerPrefsHelper.setString(PlayerPrefsKey.SimulateAccount, slot1)
end

return slot0
