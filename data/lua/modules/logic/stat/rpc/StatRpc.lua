module("modules.logic.stat.rpc.StatRpc", package.seeall)

slot0 = class("StatRpc", BaseRpc)

function slot0.sendClientStatBaseInfoRequest(slot0, slot1)
	slot2 = StatModule_pb.ClientStatBaseInfoRequest()
	slot2.info = slot1

	return slot0:sendMsg(slot2)
end

function slot0.onReceiveClientStatBaseInfoReply(slot0, slot1, slot2)
end

function slot0.onReceiveStatInfoPush(slot0, slot1, slot2)
	if slot1 == 0 then
		StatModel.instance:setRoleType(slot2.userTag)

		if string.nilorempty(slot2.userTag) == false then
			SDKMgr.instance:updateRole(StatModel.instance:generateRoleInfo())
		end
	end
end

slot0.instance = slot0.New()

return slot0
