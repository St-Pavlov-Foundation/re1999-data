module("modules.logic.activity.view.V1a9_Role_FullSignView_Part2", package.seeall)

slot0 = class("V1a9_Role_FullSignView_Part2", V1a9_Role_FullSignView)

function slot0._editableInitView(slot0)
	slot0._simageFullBG:LoadImage(ResUrl.getV1a9SignSingleBg("v1a9_sign_fullbg2"))
	gohelper.setActive(gohelper.findChild(slot0.viewGO, "Root/vx_effect1"), false)
	gohelper.setActive(gohelper.findChild(slot0.viewGO, "Root/vx_effect2"), true)
end

return slot0
