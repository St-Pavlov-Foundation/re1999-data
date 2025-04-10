module("modules.logic.versionactivity2_7.lengzhou6.view.LengZhou6BuffItem", package.seeall)

slot0 = class("LengZhou6BuffItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._imagebuff = gohelper.findChildImage(slot0.viewGO, "#image_buff")
	slot0._txtbuffValue = gohelper.findChildText(slot0.viewGO, "#image_buff/#txt_buffValue")
	slot0._goclick = gohelper.findChild(slot0.viewGO, "#image_buff/#go_click")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._click = SLFramework.UGUI.UIClickListener.Get(slot0._goclick)

	slot0._click:AddClickListener(slot0._onClick, slot0)
end

function slot0._onClick(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	if slot0._buff then
		LengZhou6Controller.instance:dispatchEvent(LengZhou6Event.OnClickBuff, slot0._buff._configId)
	end
end

function slot0.updateBuffItem(slot0, slot1)
	slot0._buff = slot1

	if slot0._buff ~= nil then
		UISpriteSetMgr.instance:setBuffSprite(slot0._imagebuff, slot0._buff.config.icon)

		slot4 = slot0._buff:getLayerCount()
		slot0._txtbuffValue.text = slot4

		gohelper.setActive(slot0.viewGO, slot4 > 0)
	else
		gohelper.setActive(slot0.viewGO, false)
	end
end

function slot0.changeParent(slot0, slot1)
	slot0.viewGO.transform.parent = slot1.transform
end

function slot0.onDestroyView(slot0)
	if slot0._click then
		slot0._click:RemoveClickListener()

		slot0._click = nil
	end
end

return slot0
