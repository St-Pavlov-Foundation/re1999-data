module("modules.logic.versionactivity2_7.act191.view.Act191SwitchView", package.seeall)

slot0 = class("Act191SwitchView", BaseView)

function slot0.onInitView(slot0)
	slot0._txtStage = gohelper.findChildText(slot0.viewGO, "bg/stage/#txt_Stage")
	slot0._goItem = gohelper.findChild(slot0.viewGO, "bg/#go_Item")
	slot0._txtTips = gohelper.findChildText(slot0.viewGO, "#txt_Tips")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0.onClickModalMask(slot0)
end

function slot0._editableInitView(slot0)
	slot0.actId = Activity191Model.instance:getCurActId()
	slot0.nodeItemList = {}
end

function slot0.onOpen(slot0)
	gohelper.setActive(slot0._txtTips, false)

	slot0.gameInfo = Activity191Model.instance:getActInfo():getGameInfo()
	slot0.nodeInfoList = slot0.gameInfo:getStageNodeInfoList()
	slot0.gameInfo.nodeChange = false

	for slot6, slot7 in ipairs(slot0.nodeInfoList) do
		slot8 = slot0.nodeItemList[slot6] or slot0:creatNodeItem(slot6)
		slot10 = nil

		if lua_activity191_node.configDict[tonumber(lua_activity191_stage.configDict[slot0.actId][slot0.gameInfo.curStage].rule)][slot6].random == 1 then
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
			slot0._txtStage.text = string.format("<#FAB459>%s</color>-%d", slot1.name, slot6)
			slot0._txtTips.text = slot9.desc

			gohelper.setActive(slot8.goSelect, true)
			slot8.animSwitch:Play("switch_open")
			gohelper.setActive(slot0._txtTips, true)
		elseif slot7.nodeId == slot0.gameInfo.curNode - 1 then
			gohelper.setActive(slot8.goSelect, true)
			slot8.animSwitch:Play("switch_close")
		else
			gohelper.setActive(slot8.goSelect, false)
		end
	end

	gohelper.setActive(slot0._goItem, false)
	TaskDispatcher.runDelay(slot0.closeThis, slot0, 2.3)
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0.closeThis, slot0)
end

function slot0.creatNodeItem(slot0, slot1)
	slot2 = slot0:getUserDataTb_()
	slot3 = gohelper.cloneInPlace(slot0._goItem)
	slot2.imageNode = gohelper.findChildImage(slot3, "image_Node")
	slot2.goSelect = gohelper.findChildImage(slot3, "go_Select")
	slot2.animSwitch = slot2.goSelect:GetComponent(gohelper.Type_Animator)
	slot2.imageNodeS = gohelper.findChildImage(slot3, "go_Select/image_NodeS")
	slot0.nodeItemList[slot1] = slot2

	return slot2
end

return slot0
