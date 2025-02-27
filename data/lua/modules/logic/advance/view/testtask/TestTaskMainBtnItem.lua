module("modules.logic.advance.view.testtask.TestTaskMainBtnItem", package.seeall)

slot0 = class("TestTaskMainBtnItem", ActCenterItemBase)

function slot0.init(slot0, slot1)
	uv0.super.init(slot0, gohelper.cloneInPlace(slot1))

	slot0._btnitem = gohelper.getClick(gohelper.findChild(slot0.go, "bg"))
end

function slot0.onInit(slot0, slot1)
	slot0:_refreshItem()
end

function slot0.onClick(slot0)
	TestTaskController.instance:openTestTaskView()
end

function slot0._refreshItem(slot0)
	UISpriteSetMgr.instance:setMainSprite(slot0._imgitem, "icon_3")
	RedDotController.instance:addRedDot(slot0._goactivityreddot, RedDotEnum.DotNode.TestTaskBtn)
end

function slot0.isShowRedDot(slot0)
	return RedDotModel.instance:isDotShow(RedDotEnum.DotNode.TestTaskBtn)
end

return slot0
