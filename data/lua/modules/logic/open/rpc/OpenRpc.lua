﻿-- chunkname: @modules/logic/open/rpc/OpenRpc.lua

module("modules.logic.open.rpc.OpenRpc", package.seeall)

local OpenRpc = class("OpenRpc", BaseRpc)

function OpenRpc:onReceiveUpdateOpenPush(resultCode, msg)
	if resultCode == 0 then
		OpenModel.instance:updateOpenInfo(msg.openInfos)
		MainController.instance:dispatchEvent(MainEvent.OnFuncUnlockRefresh)

		local newIds = {}

		for i, openInfo in ipairs(msg.openInfos) do
			if openInfo.isOpen then
				table.insert(newIds, openInfo.id)
			end
		end

		if #newIds > 0 then
			OpenController.instance:dispatchEvent(OpenEvent.NewFuncUnlock, newIds)
		end
	end
end

OpenRpc.instance = OpenRpc.New()

return OpenRpc
