module("modules.logic.gm.view.GMCommandHistoryView", package.seeall)

slot0 = class("GMCommandHistoryView", BaseView)
slot0.LevelType = "人物等级"
slot0.HeroAttr = "英雄提升"
slot0.ClickItem = "ClickItem"
slot0.Return = "Return"

function slot0.ctor(slot0)
end

function slot0.onInitView(slot0)
	slot0._maskGO = gohelper.findChild(slot0.viewGO, "addItem")
	slot0._inpItem = SLFramework.UGUI.InputFieldWrap.GetWithPath(slot0.viewGO, "viewport/content/item1/inpText")

	slot0:_hideScroll()
end

function slot0.addEvents(slot0)
	SLFramework.UGUI.UIClickListener.Get(slot0._inpItem.gameObject):AddClickListener(slot0._onClickInpItem, slot0, nil)
	SLFramework.UGUI.UIClickListener.Get(slot0._maskGO):AddClickListener(slot0._onClickMask, slot0, nil)
	slot0._inpItem:AddOnValueChanged(slot0._onInpValueChanged, slot0)
end

function slot0.removeEvents(slot0)
	SLFramework.UGUI.UIClickListener.Get(slot0._inpItem.gameObject):RemoveClickListener()
	SLFramework.UGUI.UIClickListener.Get(slot0._maskGO):RemoveClickListener()
	slot0._inpItem:RemoveOnValueChanged()
end

function slot0.onOpen(slot0)
	GMController.instance:registerCallback(uv0.ClickItem, slot0._onClickItem, slot0)
end

function slot0.onClose(slot0)
	GMController.instance:unregisterCallback(uv0.ClickItem, slot0._onClickItem, slot0)
end

function slot0._onClickInpItem(slot0)
	slot0:_showScroll()
end

function slot0._onClickMask(slot0)
	slot0:_hideScroll()
end

function slot0._showScroll(slot0)
	gohelper.setActive(slot0._maskGO, true)
	recthelper.setAnchorX(slot0._maskGO.transform, -600)
	slot0:_showDefaultItems()
end

function slot0._hideScroll(slot0)
	gohelper.setActive(slot0._maskGO, false)
	recthelper.setAnchorX(slot0._maskGO.transform, 0)
	GMAddItemModel.instance:clear()
end

slot1 = "左ctrl + 点击删除对应记录"

function slot0._onClickItem(slot0, slot1)
	if slot1.type then
		return
	end

	if slot1.name == uv0 then
		return
	end

	if UnityEngine.Input.GetKey(UnityEngine.KeyCode.LeftControl) then
		GMCommandHistoryModel.instance:removeCommandHistory(slot1.name)
		slot0:_showDefaultItems()

		return
	end

	slot0._inpItem:SetText(slot1.name)
	slot0:_hideScroll()
end

function slot0._onInpValueChanged(slot0, slot1)
	if string.nilorempty(slot1) then
		slot0:_showDefaultItems()
	else
		slot0:_showTargetItems()
	end
end

function slot0._showDefaultItems(slot0)
	if #GMCommandHistoryModel.instance:getCommandHistory() == 0 then
		slot0:_hideScroll()

		return
	end

	slot2 = {
		{
			name = uv0
		}
	}

	for slot6, slot7 in ipairs(slot1) do
		table.insert(slot2, {
			name = slot7
		})
	end

	GMAddItemModel.instance:setList(slot2)
end

function slot0._showTargetItems(slot0)
	slot3 = {}

	for slot7 = 1, #GMCommandHistoryModel.instance:getCommandHistory() do
		if string.find(slot1[slot7], slot0._inpItem:GetText()) then
			table.insert(slot3, {
				name = slot8
			})
		end
	end

	GMAddItemModel.instance:setList(slot3)
end

return slot0
