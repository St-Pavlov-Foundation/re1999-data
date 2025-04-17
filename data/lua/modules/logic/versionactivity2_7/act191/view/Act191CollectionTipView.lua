module("modules.logic.versionactivity2_7.act191.view.Act191CollectionTipView", package.seeall)

slot0 = class("Act191CollectionTipView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnClose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_Close")
	slot0._goRoot = gohelper.findChild(slot0.viewGO, "#go_Root")
	slot0._simageIcon = gohelper.findChildSingleImage(slot0.viewGO, "#go_Root/#simage_Icon")
	slot0._txtName = gohelper.findChildText(slot0.viewGO, "#go_Root/#txt_Name")
	slot0._txtDesc = gohelper.findChildText(slot0.viewGO, "#go_Root/scroll_desc/Viewport/go_desccontent/#txt_Desc")
	slot0._btnBuy = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_Root/#btn_Buy")
	slot0._txtBuyCost = gohelper.findChildText(slot0.viewGO, "#go_Root/#btn_Buy/#txt_BuyCost")
	slot0._goTag1 = gohelper.findChild(slot0.viewGO, "#go_Root/tag/#go_Tag1")
	slot0._txtTag1 = gohelper.findChildText(slot0.viewGO, "#go_Root/tag/#go_Tag1/#txt_Tag1")
	slot0._goTag2 = gohelper.findChild(slot0.viewGO, "#go_Root/tag/#go_Tag2")
	slot0._txtTag2 = gohelper.findChildText(slot0.viewGO, "#go_Root/tag/#go_Tag2/#txt_Tag2")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnClose:AddClickListener(slot0._btnCloseOnClick, slot0)
	slot0._btnBuy:AddClickListener(slot0._btnBuyOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnClose:RemoveClickListener()
	slot0._btnBuy:RemoveClickListener()
end

function slot0._onEscBtnClick(slot0)
	slot0:closeThis()

	if ViewMgr.instance:isOpen(ViewName.Act191InfoView) then
		ViewMgr.instance:closeView(ViewName.Act191InfoView)
	end
end

function slot0._btnCloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._btnBuyOnClick(slot0)
	if Activity191Model.instance:getActInfo():getGameInfo().coin < slot0.viewParam.cost then
		GameFacade.showToast(ToastEnum.Act174CoinNotEnough)

		return
	end

	Activity191Rpc.instance:sendBuyIn191ShopRequest(slot0.actId, slot0.viewParam.index, slot0._buyReply, slot0)
end

function slot0._buyReply(slot0, slot1, slot2)
	if slot2 == 0 then
		GameFacade.showToast(ToastEnum.Act191BuyTip)
		slot0:closeThis()
	end
end

function slot0._editableInitView(slot0)
	NavigateMgr.instance:addEscape(slot0.viewName, slot0._onEscBtnClick, slot0)

	slot0.actId = Activity191Model.instance:getCurActId()

	SkillHelper.addHyperLinkClick(slot0._txtDesc)
end

function slot0.onUpdateParam(slot0)
	slot0:refreshUI()
end

function slot0.onOpen(slot0)
	Act191StatController.instance:onViewOpen(slot0.viewName)
	slot0:refreshUI()
end

function slot0.onClose(slot0)
	Act191StatController.instance:statViewClose(slot0.viewName, slot0.viewContainer:isManualClose(), slot0.config.title)
end

function slot0.refreshUI(slot0)
	gohelper.setActive(slot0._btnClose, not slot0.viewParam.notShowBg)

	if slot0.viewParam.pos then
		recthelper.setAnchor(slot0._goRoot.transform, slot1.x, slot1.y)
	end

	if slot0.viewParam.showBuy then
		slot0:refreshCost()
		gohelper.setActive(slot0._btnBuy, true)
	else
		gohelper.setActive(slot0._btnBuy, false)
	end

	slot0.config = Activity191Config.instance:getCollectionCo(slot0.viewParam.itemId)

	if slot0.config then
		slot0._simageIcon:LoadImage(ResUrl.getRougeSingleBgCollection(slot0.config.icon))

		slot0._txtName.text = string.format("<#%s>%s</color>", Activity191Enum.CollectionColor[slot0.config.rare], slot0.config.title)

		if slot0.viewParam.enhance then
			slot0._txtDesc.text = SkillHelper.buildDesc(slot0.config.replaceDesc)
		else
			slot0._txtDesc.text = SkillHelper.buildDesc(slot0.config.desc)
		end

		if string.nilorempty(slot0.config.label) then
			gohelper.setActive(slot0._goTag1, false)
			gohelper.setActive(slot0._goTag2, false)
		else
			for slot7 = 1, 2 do
				slot8 = string.split(slot0.config.label, "#")[slot7]
				slot0["_txtTag" .. slot7].text = slot8

				gohelper.setActive(slot0["_goTag" .. slot7], slot8)
			end
		end
	end
end

function slot0.refreshCost(slot0)
	if Activity191Model.instance:getActInfo():getGameInfo().coin < slot0.viewParam.cost then
		SLFramework.UGUI.GuiHelper.SetColor(slot0._txtBuyCost, "#be4343")
	else
		SLFramework.UGUI.GuiHelper.SetColor(slot0._txtBuyCost, "#211f1f")
	end

	slot0._txtBuyCost.text = slot1
end

return slot0
