module("modules.logic.versionactivity2_7.act191.view.item.Act191RewardItem", package.seeall)

slot0 = class("Act191RewardItem", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0.bg = gohelper.findChildImage(slot1, "bg")
	slot0.icon = gohelper.findChildImage(slot1, "icon")
	slot0.num = gohelper.findChildText(slot1, "num")
	slot0.click = gohelper.findChildButtonWithAudio(slot1, "clickArea")
end

function slot0.addEventListeners(slot0)
	slot0:addClickCb(slot0.click, slot0.onClick, slot0)
end

function slot0.setData(slot0, slot1, slot2)
	slot0.config = lua_activity191_item.configDict[slot1]
	slot0.num.text = slot2

	UISpriteSetMgr.instance:setAct174Sprite(slot0.icon, slot0.config.icon)
end

function slot0.onClick(slot0)
	if slot0.param then
		Act191StatController.instance:statButtonClick(slot0.param.fromView, string.format("clickArea_%s_%s", slot0.param.index, slot0.config.name))
	end
end

function slot0.setClickEnable(slot0, slot1)
	gohelper.setActive(slot0.click, slot1)
end

function slot0.setExtraParam(slot0, slot1)
	slot0.param = slot1
end

return slot0
