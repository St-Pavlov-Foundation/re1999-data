﻿-- chunkname: @modules/logic/versionactivity1_4/act128/rpc/Activity128Rpc.lua

module("modules.logic.versionactivity1_4.act128.rpc.Activity128Rpc", package.seeall)

local Activity128Rpc = class("Activity128Rpc", BaseRpc)

function Activity128Rpc:sendGet128InfosRequest(activityId, callback, cbObj)
	local req = Activity128Module_pb.Get128InfosRequest()

	req.activityId = activityId

	return self:sendMsg(req, callback, cbObj)
end

function Activity128Rpc:onReceiveGet128InfosReply(resultCode, msg)
	self:_onReceiveGet128InfosReply(resultCode, msg)
end

function Activity128Rpc:sendAct128GetTotalRewardsRequest(activityId, bossId)
	local req = Activity128Module_pb.Act128GetTotalRewardsRequest()

	req.activityId = activityId
	req.bossId = bossId

	return self:sendMsg(req)
end

function Activity128Rpc:onReceiveAct128GetTotalRewardsReply(resultCode, msg)
	self:_onReceiveAct128GetTotalRewardsReply(resultCode, msg)
end

function Activity128Rpc:sendAct128DoublePointRequest(activityId, bossId)
	local req = Activity128Module_pb.Act128DoublePointRequest()

	req.activityId = activityId
	req.bossId = bossId

	return self:sendMsg(req)
end

function Activity128Rpc:onReceiveAct128DoublePointReply(resultCode, msg)
	self:_onReceiveAct128DoublePointReply(resultCode, msg)
end

function Activity128Rpc:onReceiveAct128InfoUpdatePush(resultCode, msg)
	self:_onReceiveAct128InfoUpdatePush(resultCode, msg)
end

function Activity128Rpc:sendAct128EvaluateRequest(activityId, bossId)
	return
end

function Activity128Rpc:sendAct128GetTotalSingleRewardRequest(activityId, bossId, rewardId)
	local req = Activity128Module_pb.Act128GetTotalSingleRewardRequest()

	req.activityId = activityId
	req.bossId = bossId
	req.rewardId = rewardId

	return self:sendMsg(req)
end

function Activity128Rpc:onReceiveAct128GetTotalSingleRewardReply(resultCode, msg)
	self:_onReceiveAct128GetTotalSingleRewardReply(resultCode, msg)
end

function Activity128Rpc:sendAct128SpFirstHalfSelectItemRequest(activityId, bossId, itemTypeIds, callback, callbackobj)
	local req = Activity128Module_pb.Act128SpFirstHalfSelectItemRequest()

	req.activityId = activityId
	req.bossId = bossId

	for i, id in pairs(itemTypeIds) do
		req.itemTypeIds:append(id)
	end

	return self:sendMsg(req, callback, callbackobj)
end

function Activity128Rpc:onReceiveAct128SpFirstHalfSelectItemReply(resultCode, msg)
	self:_onReceiveAct128SpFirstHalfSelectItemReply(resultCode, msg)
end

function Activity128Rpc:sendGetGalleryInfosRequest(activityId, callback, callbackobj)
	local req = Activity128Module_pb.GetGalleryInfosRequest()

	req.activityId = activityId

	return self:sendMsg(req, callback, callbackobj)
end

function Activity128Rpc:onReceiveGetGalleryInfosReply(resultCode, msg)
	self:_onReceiveGetGalleryInfosReply(resultCode, msg)
end

function Activity128Rpc:sendAct128GetExpRequest(activityId, type, callback, callbackobj)
	local req = Activity128Module_pb.Act128GetExpRequest()

	req.activityId = activityId
	req.type = type

	return self:sendMsg(req, callback, callbackobj)
end

function Activity128Rpc:onReceiveAct128GetExpReply(resultCode, msg)
	self:_onReceiveAct128GetExpReply(resultCode, msg)
end

function Activity128Rpc:sendAct128GetMilestoneBonusRequest(activityId, callback, callbackobj)
	local req = Activity128Module_pb.Act128GetMilestoneBonusRequest()

	req.activityId = activityId

	return self:sendMsg(req, callback, callbackobj)
end

function Activity128Rpc:onReceiveAct128GetMilestoneBonusReply(resultCode, msg)
	self:_onReceiveAct128GetMilestoneBonusReply(resultCode, msg)
end

return Activity128Rpc
