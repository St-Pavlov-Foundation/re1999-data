-- chunkname: @modules/logic/matchgame/rpc/MatchGameRpc.lua

module("modules.logic.matchgame.rpc.MatchGameRpc", package.seeall)

local MatchGameRpc = class("MatchGameRpc", BaseRpc)

function MatchGameRpc:sendGetAct244InfoRequest(activityId, callback, callbackObj)
	local req = Activity244Module_pb.GetAct244InfoRequest()

	req.activityId = activityId

	self:sendMsg(req, callback, callbackObj)
end

function MatchGameRpc:onReceiveGetAct244InfoReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	MatchGameModel.instance:onUpdateInfo(msg)
end

function MatchGameRpc:sendAct244BuyHeroRequest(activityId, heroId, callback, callbackObj)
	local req = Activity244Module_pb.Act244BuyHeroRequest()

	req.activityId = activityId
	req.heroId = heroId

	self:sendMsg(req, callback, callbackObj)
end

function MatchGameRpc:onReceiveAct244BuyHeroReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	MatchGameModel.instance:onUpdateCharacterInfo(msg.hero)
end

function MatchGameRpc:sendAct244UpgradeHeroRequest(activityId, heroId, callback, callbackObj)
	local req = Activity244Module_pb.Act244UpgradeHeroRequest()

	req.activityId = activityId
	req.heroId = heroId

	self:sendMsg(req, callback, callbackObj)
end

function MatchGameRpc:onReceiveAct244UpgradeHeroReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	MatchGameModel.instance:onUpdateCharacterInfo(msg.hero)
end

function MatchGameRpc:sendAct244ActiveTalentRequest(activityId, talentId, callback, callbackObj)
	local req = Activity244Module_pb.Act244ActiveTalentRequest()

	req.activityId = activityId
	req.talentId = talentId

	self:sendMsg(req, callback, callbackObj)
end

function MatchGameRpc:onReceiveAct244ActiveTalentReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	MatchGameModel.instance:onUpdateTalentInfo(msg.talent)
end

function MatchGameRpc:sendAct244ResetTalentRequest(activityId, talentBranch, callback, callbackObj)
	local req = Activity244Module_pb.Act244ResetTalentRequest()

	req.activityId = activityId
	req.talentBranch = talentBranch

	self:sendMsg(req, callback, callbackObj)
end

function MatchGameRpc:onReceiveAct244ResetTalentReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	MatchGameModel.instance:onResetTalent(msg.talentBranch)
end

function MatchGameRpc:sendAct244ModifyTeamRequest(activityId, teamIndex, heroIds, callback, callbackObj)
	local req = Activity244Module_pb.Act244ModifyTeamRequest()

	req.activityId = activityId
	req.teamIndex = teamIndex

	if heroIds then
		for _, id in ipairs(heroIds) do
			req.heroIds:append(id)
		end
	end

	self:sendMsg(req, callback, callbackObj)
end

function MatchGameRpc:onReceiveAct244ModifyTeamReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local teamId = msg.team.index

	MatchGameModel.instance:updateTeamInfo(msg.teamIndex, msg.team)
	MatchGameHeroGroupModel.instance:onModifyTeamSuccess(teamId)
end

function MatchGameRpc:sendAct244ModifyTeamIndexRequest(activityId, teamIndex, callback, callbackObj)
	local req = Activity244Module_pb.Act244ModifyTeamIndexRequest()

	req.activityId = activityId
	req.teamIndex = teamIndex

	self:sendMsg(req, callback, callbackObj)
end

function MatchGameRpc:onReceiveAct244ModifyTeamIndexReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	MatchGameModel.instance:updateTeamIndex(msg.teamIndex)
	MatchGameHeroGroupModel.instance:onSwitchTeamSuccess()
end

function MatchGameRpc:sendAct244StartEpisodeRequest(activityId, episodeId, callback, callbackObj)
	local req = Activity244Module_pb.Act244StartEpisodeRequest()

	req.activityId = activityId
	req.episodeId = episodeId

	self:sendMsg(req, callback, callbackObj)
end

function MatchGameRpc:onReceiveAct244StartEpisodeReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	ViewMgr.instance:closeView(ViewName.MatchGameHeroGroupView)
	MatchGameController.instance:openMatchGameFightView({
		activityId = msg.activityId,
		episodeId = msg.episodeId
	})
end

function MatchGameRpc:sendAct244SettleEpisodeRequest(activityId, episodeId, isPass, stars, score, callback, callbackObj)
	local req = Activity244Module_pb.Act244SettleEpisodeRequest()

	req.activityId = activityId
	req.episodeId = episodeId
	req.isPass = isPass
	req.score = score

	if stars and next(stars) then
		tabletool.clear(req.stars)

		for _, star in ipairs(stars) do
			table.insert(req.stars, star)
		end
	end

	if isPass and MatchGameModel.instance:getEpisodeStatus(episodeId) ~= MatchGameEnum.EpisodeStatus.Finish then
		MatchGameLevelModel.instance:setNewFinishEpisode(episodeId)
	else
		MatchGameLevelModel.instance:clearFinishEpisode()
	end

	self:sendMsg(req, callback, callbackObj)
end

function MatchGameRpc:onReceiveAct244SettleEpisodeReply(resultCode, msg)
	return
end

function MatchGameRpc:sendAct244ReceiveStarBonusRequest(activityId, callback, callbackObj)
	local req = Activity244Module_pb.Act244ReceiveStarBonusRequest()

	req.activityId = activityId

	self:sendMsg(req, callback, callbackObj)
end

function MatchGameRpc:onReceiveAct244ReceiveStarBonusReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	MatchGameModel.instance.receivedBonusId = msg.receivedBonusId

	MatchGameController.instance:dispatchEvent(MatchGameEvent.OnUpdateBonusInfo)
end

function MatchGameRpc:sendAct244ReceiveChallengeBonusRequest(activityId, callback, callbackObj)
	local req = Activity244Module_pb.Act244ReceiveChallengeBonusRequest()

	req.activityId = activityId

	self:sendMsg(req, callback, callbackObj)
end

function MatchGameRpc:onReceiveAct244ReceiveChallengeBonusReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local challengeMo = MatchGameModel.instance.challengeMo

	challengeMo.receivedBonusId = msg.receivedBonusId

	MatchGameController.instance:dispatchEvent(MatchGameEvent.OnUpdateBonusInfo)
end

function MatchGameRpc:onReceiveAct244ItemPush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	MatchGameModel.instance:onUpdateItemInfoList(msg.updateItems)
end

function MatchGameRpc:onReceiveAct244EpisodePush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	MatchGameModel.instance:onUpdateEpisodeInfo(msg)
end

MatchGameRpc.instance = MatchGameRpc.New()

return MatchGameRpc
