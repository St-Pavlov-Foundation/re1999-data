﻿-- chunkname: @modules/logic/rouge2/map/view/choicebase/Rouge2_MsgPushWork.lua

module("modules.logic.rouge2.map.view.choicebase.Rouge2_MsgPushWork", package.seeall)

local Rouge2_MsgPushWork = class("Rouge2_MsgPushWork", BaseWork)

function Rouge2_MsgPushWork:ctor(msgName, msg)
	self._msgName = msgName or ""
	self._msg = msg
end

function Rouge2_MsgPushWork:onStart(context)
	local handler = self["onReceive" .. self._msgName]

	if handler and handler(self, self._msg) then
		return
	end

	self:onDone(true)
end

function Rouge2_MsgPushWork:getMsgName()
	return self._msgName
end

function Rouge2_MsgPushWork:onReceiveRouge2BagItemUpdatePush(msg)
	local reason = msg.reason
	local items = msg.items

	Rouge2_BackpackModel.instance:updateItems(items)
	Rouge2_BackpackController.instance:showGetItemView(reason, items)
	Rouge2_BackpackController.instance:buildItemReddot()
end

function Rouge2_MsgPushWork:onReceiveRouge2AttrUpdatePush(msg)
	local updates = msg.updates

	Rouge2_Model.instance:updateAttrInfoList(updates)
	Rouge2_MapInteractHelper.addPopMapAttrUpView()
	Rouge2_BackpackController.instance:buildBXSBoxReddot()
end

function Rouge2_MsgPushWork:onReceiveRouge2BagItemRemovePush(msg)
	local reason = msg.reason
	local items = msg.items

	Rouge2_BackpackModel.instance:removeItems(items)
	Rouge2_BackpackController.instance:showLossItemView(items)
	Rouge2_BackpackController.instance:buildItemReddot()
end

function Rouge2_MsgPushWork:onReceiveRouge2CheckInfoPush(msg)
	Rouge2_MapAttrCheckHelper.onGetCheckResultMsg(msg)
end

return Rouge2_MsgPushWork
