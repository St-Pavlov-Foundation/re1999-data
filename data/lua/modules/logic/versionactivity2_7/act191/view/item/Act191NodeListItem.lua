module("modules.logic.versionactivity2_7.act191.view.item.Act191NodeListItem", package.seeall)

slot0 = class("Act191NodeListItem", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0.txtStage = gohelper.findChildText(slot1, "bg/stage/#txt_Stage")
	slot0.goNodeItem = gohelper.findChild(slot1, "bg/#go_NodeItem")
	slot0.goSalary = gohelper.findChild(slot1, "#go_Salary")
	slot0.txtCoin1 = gohelper.findChildText(slot1, "#go_Salary/Coin1/#txt_Coin1")
	slot0.txtCoin2 = gohelper.findChildText(slot1, "#go_Salary/Coin2/#txt_Coin2")
	slot0.btnClick = gohelper.findChildButtonWithAudio(slot1, "#btn_Click")
	slot0.nodeItemList = {}
end

function slot0.addEventListeners(slot0)
	slot0:addClickCb(slot0.btnClick, slot0.showSalary, slot0)
	slot0:addEventCb(Activity191Controller.instance, Activity191Event.UpdateGameInfo, slot0.refreshUI, slot0)
end

function slot0.removeEventListeners(slot0)
end

function slot0.onStart(slot0)
	slot0.actId = Activity191Model.instance:getCurActId()

	slot0:refreshUI()
end

function slot0.onDestroy(slot0)
	TaskDispatcher.cancelTask(slot0.hideSalary, slot0)
end

function slot0.refreshUI(slot0)
	slot0.gameInfo = Activity191Model.instance:getActInfo():getGameInfo()
	slot0.nodeInfoList = slot0.gameInfo:getStageNodeInfoList()
	slot1 = lua_activity191_stage.configDict[slot0.actId][slot0.gameInfo.curStage]
	slot0.txtCoin1.text = slot1.coin
	slot0.txtCoin2.text = slot1.score

	for slot6, slot7 in ipairs(slot0.nodeInfoList) do
		slot8 = slot0.nodeItemList[slot6] or slot0:creatNodeItem(slot6)
		slot10 = nil

		if lua_activity191_node.configDict[tonumber(slot1.rule)][slot6].random == 1 then
			slot10 = Activity191Helper.getNodeIcon(slot7.nodeType)
		elseif #slot7.selectNodeStr == 0 then
			slot10 = Activity191Helper.getNodeIcon(slot7.nodeType)
		else
			slot11 = Act191NodeDetailMO.New()

			slot11:init(slot7.selectNodeStr[1])

			slot10 = Activity191Helper.getNodeIcon(slot11.type)
		end

		UISpriteSetMgr.instance:setAct174Sprite(slot8.imageNode, slot10)
		UISpriteSetMgr.instance:setAct174Sprite(slot8.imageNodeS, slot10 .. "_light")

		if slot7.nodeId == slot0.gameInfo.curNode then
			slot0.txtStage.text = string.format("<#FAB459>%s</color>-%d", slot1.name, slot6)

			gohelper.setActive(slot8.goSelect, true)
		else
			gohelper.setActive(slot8.goSelect, false)
		end
	end

	gohelper.setActive(slot0.goNodeItem, false)
end

function slot0.creatNodeItem(slot0, slot1)
	slot2 = slot0:getUserDataTb_()
	slot3 = gohelper.cloneInPlace(slot0.goNodeItem)
	slot2.imageNode = gohelper.findChildImage(slot3, "image_Node")
	slot2.goSelect = gohelper.findChildImage(slot3, "go_Select")
	slot2.imageNodeS = gohelper.findChildImage(slot3, "go_Select/image_NodeS")
	slot0.nodeItemList[slot1] = slot2

	return slot2
end

function slot0.showSalary(slot0)
	if slot0.goSalary.activeInHierarchy then
		TaskDispatcher.cancelTask(slot0.hideSalary, slot0)
		slot0:hideSalary()

		return
	end

	gohelper.setActive(slot0.goSalary, true)
	TaskDispatcher.runDelay(slot0.hideSalary, slot0, 2)
end

function slot0.hideSalary(slot0)
	gohelper.setActive(slot0.goSalary, false)
end

return slot0
