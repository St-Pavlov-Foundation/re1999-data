module("modules.logic.weekwalk_2.rpc.Weekwalk_2Rpc", package.seeall)

slot0 = class("Weekwalk_2Rpc", BaseRpc)

function slot0.sendWeekwalkVer2GetInfoRequest(slot0, slot1, slot2)
	return slot0:sendMsg(WeekwalkVer2Module_pb.WeekwalkVer2GetInfoRequest(), slot1, slot2)
end

function slot0.onReceiveWeekwalkVer2GetInfoReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	WeekWalk_2Model.instance:initInfo(slot2.info)
	WeekWalk_2Controller.instance:dispatchEvent(WeekWalk_2Event.OnGetInfo)
	WeekWalk_2Controller.instance:dispatchEvent(WeekWalk_2Event.OnWeekwalkInfoChange)
end

function slot0.sendWeekwalkVer2HeroRecommendRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = WeekwalkVer2Module_pb.WeekwalkVer2HeroRecommendRequest()
	slot5.elementId = slot1
	slot5.layerId = slot2

	slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveWeekwalkVer2HeroRecommendReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	slot3 = slot2.racommends
end

function slot0.sendWeekwalkVer2ResetLayerRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = WeekwalkVer2Module_pb.WeekwalkVer2ResetLayerRequest()
	slot5.layerId = slot1
	slot5.battleId = slot2

	slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveWeekwalkVer2ResetLayerReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	WeekWalk_2Model.instance:getInfo():setLayerInfo(slot2.layerInfo)
	WeekWalk_2Controller.instance:dispatchEvent(WeekWalk_2Event.OnWeekwalkResetLayer)
	WeekWalk_2Controller.instance:dispatchEvent(WeekWalk_2Event.OnWeekwalkInfoChange)
	GameFacade.showToast(ToastEnum.WeekwalkResetLayer)
end

function slot0.sendWeekwalkVer2ChangeHeroGroupSelectRequest(slot0, slot1, slot2, slot3, slot4, slot5)
	slot6 = WeekwalkVer2Module_pb.WeekwalkVer2ChangeHeroGroupSelectRequest()
	slot6.layerId = slot1
	slot6.battleId = slot2
	slot6.select = slot3

	slot0:sendMsg(slot6, slot4, slot5)
end

function slot0.onReceiveWeekwalkVer2ChangeHeroGroupSelectReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	if WeekWalk_2Model.instance:getBattleInfo(slot2.layerId, slot2.battleId) then
		slot6.heroGroupSelect = slot2.select
	end
end

function slot0.sendWeekwalkVer2ChooseSkillRequest(slot0, slot1, slot2, slot3, slot4)
	WeekwalkVer2Module_pb.WeekwalkVer2ChooseSkillRequest().no = slot1

	if slot2 then
		for slot9, slot10 in ipairs(slot2) do
			table.insert(slot5.skillIds, slot10)
		end
	end

	slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveWeekwalkVer2ChooseSkillReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	if WeekWalk_2Model.instance:getInfo() then
		slot5:setHeroGroupSkill(slot2.no, slot2.skillIds)
		WeekWalk_2Controller.instance:dispatchEvent(WeekWalk_2Event.OnBuffSetupReply)
	end
end

function slot0.sendWeekwalkVer2GetSettleInfoRequest(slot0, slot1, slot2)
	slot0:sendMsg(WeekwalkVer2Module_pb.WeekwalkVer2GetSettleInfoRequest(), slot1, slot2)
end

function slot0.onReceiveWeekwalkVer2GetSettleInfoReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	WeekWalk_2Model.instance:initSettleInfo(slot2.settleInfo)
	WeekWalk_2Controller.instance:openWeekWalk_2HeartResultView()
end

function slot0.sendWeekwalkVer2MarkPreSettleRequest(slot0, slot1, slot2)
	slot0:sendMsg(WeekwalkVer2Module_pb.WeekwalkVer2MarkPreSettleRequest(), slot1, slot2)
end

function slot0.onReceiveWeekwalkVer2MarkPreSettleReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end
end

function slot0.sendWeekwalkVer2MarkPopRuleRequest(slot0, slot1, slot2)
	slot0:sendMsg(WeekwalkVer2Module_pb.WeekwalkVer2MarkPopRuleRequest(), slot1, slot2)
end

function slot0.onReceiveWeekwalkVer2MarkPopRuleReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end
end

function slot0.sendWeekwalkVer2MarkShowFinishedRequest(slot0, slot1, slot2, slot3)
	slot4 = WeekwalkVer2Module_pb.WeekwalkVer2MarkShowFinishedRequest()
	slot4.layerId = slot1

	slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveWeekwalkVer2MarkShowFinishedReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	slot3 = slot2.layerId
end

function slot0.onReceiveWeekwalkVer2InfoUpdatePush(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	WeekWalk_2Model.instance:updateInfo(slot2.info)
	WeekWalk_2Model.instance:clearSettleInfo()
	WeekWalk_2Controller.instance:dispatchEvent(WeekWalk_2Event.OnWeekwalkInfoUpdate)
	WeekWalk_2Controller.instance:dispatchEvent(WeekWalk_2Event.OnWeekwalkInfoChange)
end

function slot0.onReceiveWeekwalkVer2SettleInfoUpdatePush(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	WeekWalk_2Model.instance:initSettleInfo(slot2.settleInfo)
end

function slot0.onReceiveWeekwalkVer2FightSettlePush(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	slot3 = slot2.layerId
	slot4 = slot2.battleId

	WeekWalk_2Model.instance:initFightSettleInfo(slot2.result, slot2.cupInfos)
end

slot0.instance = slot0.New()

return slot0
