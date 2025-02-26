module("modules.logic.rouge.view.RougeDLCTipsView", package.seeall)

slot0 = class("RougeDLCTipsView", BaseView)

function slot0.onInitView(slot0)
	slot0._goroot = gohelper.findChild(slot0.viewGO, "#go_root")
	slot0._gocontainer = gohelper.findChild(slot0.viewGO, "#go_root/#go_container")
	slot0._txtdlcname = gohelper.findChildText(slot0.viewGO, "#go_root/#go_container/#txt_dlcname")
	slot0._scrollinfo = gohelper.findChildScrollRect(slot0.viewGO, "#go_root/#go_container/#scroll_info")
	slot0._simagebanner = gohelper.findChildSingleImage(slot0.viewGO, "#go_root/#go_container/#scroll_info/Viewport/Content/bg/#simage_banner")
	slot0._txtdlcdesc = gohelper.findChildText(slot0.viewGO, "#go_root/#go_container/#scroll_info/Viewport/Content/#txt_dlcdesc")
	slot0._gotopleft = gohelper.findChild(slot0.viewGO, "#go_root/#go_topleft")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:refreshDLCContainer()
end

function slot0.refreshDLCContainer(slot0)
	if lua_rouge_season.configDict[slot0.viewParam and slot0.viewParam.dlcId] then
		slot0._txtdlcname.text = slot2.name
		slot0._txtdlcdesc.text = slot2.desc

		slot0._simagebanner:LoadImage(ResUrl.getRougeDLCLangImage("rouge_dlc_banner_" .. slot2.id))
	end
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
