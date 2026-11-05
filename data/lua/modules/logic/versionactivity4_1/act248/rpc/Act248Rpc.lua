-- chunkname: @modules/logic/versionactivity4_1/act248/rpc/Act248Rpc.lua

module("modules.logic.versionactivity4_1.act248.rpc.Act248Rpc", package.seeall)

local Act248Rpc = class("Act248Rpc", BaseRpc)

function Act248Rpc:sendAct248GetInfoRequest(activityId, callback, callbackObj)
	local req = Activity248Module_pb.Act248GetInfoRequest()

	req.activityId = activityId

	self:sendMsg(req, callback, callbackObj)
end

function Act248Rpc:onReceiveAct248GetInfoReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Act248Model.instance:initInfo(msg)
end

function Act248Rpc:sendAct248FillClueRequest(fileId, clueDict, callback, callbackObj)
	local req = Activity248Module_pb.Act248FillClueRequest()
	local activityId = Act248Model.instance:getActId()

	req.activityId = activityId
	req.fileId = fileId

	local count = 0

	if clueDict then
		for slotId, fillClueId in pairs(clueDict) do
			local no = req.fillSlotInfos:add()

			no.slotId = slotId
			no.fillClueId = fillClueId
			count = count + 1
		end
	end

	if count == 0 then
		return
	end

	self:sendMsg(req, callback, callbackObj)
end

function Act248Rpc:onReceiveAct248FillClueReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Act248Model.instance:refreshFileInfo(msg.fileInfo)
	Act248Controller.instance:dispatchEvent(Act248Event.onConfirmFillClue)
end

function Act248Rpc:sendAct248UnlockClueRequest(activityId, fileId, unlockClueIds, callback, callbackObj)
	local req = Activity248Module_pb.Act248UnlockClueRequest()

	req.activityId = activityId
	req.fileId = fileId

	if unlockClueIds then
		for _, clueId in ipairs(unlockClueIds) do
			req.unlockClueIds:append(clueId)
		end
	end

	self:sendMsg(req, callback, callbackObj)
end

function Act248Rpc:sendAct248UnlockSingleClueRequest(clueId, callback, callbackObj)
	local mo = Act248Model.instance:getClueById(clueId)

	if not mo then
		return
	end

	local req = Activity248Module_pb.Act248UnlockClueRequest()
	local activityId = Act248Model.instance:getActId()
	local fileIds = mo:getFiles()

	req.activityId = activityId
	req.fileId = fileIds and fileIds[1] or 1

	req.unlockClueIds:append(clueId)
	self:sendMsg(req, callback, callbackObj)
end

function Act248Rpc:onReceiveAct248UnlockClueReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Act248Model.instance:refreshUnlockClueInfo(msg.unlockClueIds)
end

function Act248Rpc:sendAct248GenerateReportRequest(activityId, fileId, callback, callbackObj)
	local req = Activity248Module_pb.Act248GenerateReportRequest()

	req.activityId = activityId
	req.fileId = fileId

	self:sendMsg(req, callback, callbackObj)
end

function Act248Rpc:onReceiveAct248GenerateReportReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Act248Model.instance:onGenerateReport(msg.fileId)
	Act248Controller.instance:dispatchEvent(Act248Event.onGenerateReport)
end

function Act248Rpc:sendAct248FinishReportRequest(activityId, fileId, optionIds, callback, callbackObj)
	local req = Activity248Module_pb.Act248FinishReportRequest()

	req.activityId = activityId
	req.fileId = fileId

	for _, id in ipairs(optionIds) do
		req.optionIds:append(id)
	end

	self:sendMsg(req, callback, callbackObj)
end

function Act248Rpc:onReceiveAct248FinishReportReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Act248Model.instance:onFinishReport(msg.fileId)
	Act248Controller.instance:dispatchEvent(Act248Event.onFinishReport)
end

function Act248Rpc:onReceiveAct248InfoPush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Act248Model.instance:refreshInfo(msg.newFileInfos, msg.newUnlockClueIds, true)

	if msg.newUnlockClueIds and #msg.newUnlockClueIds > 0 then
		local isNew = false

		for _, id in ipairs(msg.newUnlockClueIds) do
			local mo = Act248Model.instance:getClueById(id)

			if mo and not mo:isDefalutUnlock() then
				local lockInfo = mo:getLockInfo()

				if lockInfo and lockInfo.type == Act248Enum.UnlockType.Story then
					local storyId = lockInfo.param[1]

					if StoryModel.instance:isStoryFinished(storyId) then
						isNew = true

						break
					end
				else
					isNew = true

					break
				end
			end
		end

		if isNew then
			ToastController.instance:showToast(Act248Enum.Toast.CollectClue)
		end
	end
end

Act248Rpc.instance = Act248Rpc.New()

return Act248Rpc
