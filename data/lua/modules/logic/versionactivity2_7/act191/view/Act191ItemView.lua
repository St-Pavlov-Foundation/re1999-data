module("modules.logic.versionactivity2_7.act191.view.Act191ItemView", package.seeall)

slot0 = class("Act191ItemView", BaseView)

function slot0.onInitView(slot0)
	slot0._goRoot = gohelper.findChild(slot0.viewGO, "#go_Root")
	slot0._imageRare = gohelper.findChildImage(slot0.viewGO, "#go_Root/#image_Rare")
	slot0._imageIcon = gohelper.findChildImage(slot0.viewGO, "#go_Root/#image_Icon")
	slot0._txtName = gohelper.findChildText(slot0.viewGO, "#go_Root/#txt_Name")
	slot0._txtDesc = gohelper.findChildText(slot0.viewGO, "#go_Root/scroll_desc/Viewport/go_desccontent/#txt_Desc")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.onClickModalMask(slot0)
	slot0:closeThis()
end

function slot0.onOpen(slot0)
	slot0.config = slot0.viewParam

	if slot0.config.rare ~= 0 then
		UISpriteSetMgr.instance:setAct174Sprite(slot0._imageRare, "act174_roleframe_" .. slot0.config.rare)
	end

	gohelper.setActive(slot0._imageRare, slot0.config.rare ~= 0)
	UISpriteSetMgr.instance:setAct174Sprite(slot0._imageIcon, slot0.config.icon)

	slot0._txtName.text = slot0.config.name
	slot0._txtDesc.text = slot0.config.desc

	if slot0.config.id == 1001 then
		transformhelper.setLocalScale(slot0._imageIcon.gameObject.transform, 0.75, 0.75, 1)
	end
end

return slot0
