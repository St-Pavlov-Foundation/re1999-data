module("modules.logic.fight.model.datahelper.FightDataHelper", package.seeall)

slot0 = {
	defineMgrRef = function ()
		slot0 = FightDataMgr.instance.mgrList

		for slot4, slot5 in pairs(FightDataMgr.instance) do
			for slot9, slot10 in ipairs(slot0) do
				if slot10 == slot5 then
					uv0[slot4] = slot10

					break
				end
			end
		end
	end,
	initDataMgr = function ()
		uv0.lastFightResult = nil

		FightLocalDataMgr.instance:initDataMgr()
		FightDataMgr.instance:initDataMgr()
		uv0.defineMgrRef()
		FightMsgMgr.sendMsg(FightMsgId.AfterInitDataMgrRef)
	end,
	initFightData = function (slot0)
		if not slot0 then
			uv0.version = 999
			FightModel.instance._version = uv0.version

			return
		end

		uv0.version = FightModel.GMForceVersion or slot0.version or 0
		FightModel.instance._version = uv0.version

		uv0.checkReplay(slot0)
		FightLocalDataMgr.instance:updateFightData(slot0)
		FightDataMgr.instance:updateFightData(slot0)

		if isDebugBuild then
			FightLocalDataMgr.instance.roundMgr.enterData = slot0
			FightDataMgr.instance.roundMgr.enterData = slot0
		end
	end,
	checkReplay = function (slot0)
		if uv0.version >= 1 then
			if slot0.isRecord then
				uv0.stageMgr:enterFightState(FightStageMgr.FightStateType.Replay)
			end
		elseif FightModel.instance:getFightParam() and slot3.isReplay then
			uv0.stageMgr:enterFightState(FightStageMgr.FightStateType.Replay)
		elseif FightReplayModel.instance:isReconnectReplay() then
			uv0.stageMgr:enterFightState(FightStageMgr.FightStateType.Replay)
		end
	end,
	playEffectData = function (slot0)
		if slot0:isDone() then
			return
		end

		uv0.calMgr:playActEffectData(slot0)
	end,
	cacheFightWavePush = function (slot0)
		FightLocalDataMgr.instance.cacheFightMgr:cacheFightWavePush(slot0)
		FightDataMgr.instance.cacheFightMgr:cacheFightWavePush(slot0)
	end,
	setRoundDataByProto = function (slot0)
		slot1 = FightRoundData.New(slot0)

		if isDebugBuild then
			slot2 = FightDataUtil.coverData(slot1)

			FightLocalDataMgr.instance.roundMgr:setOriginRoundData(slot2)
			FightDataMgr.instance.roundMgr:setOriginRoundData(slot2)
			FightDataMgr.instance.protoCacheMgr:addRoundProto(slot0)
		end

		FightLocalDataMgr.instance.roundMgr:setRoundData(slot1)
		FightDataMgr.instance.roundMgr:setRoundData(slot1)
	end,
	getBloodPool = function (slot0)
		slot2 = uv0.teamDataMgr and slot1[slot0]

		return slot2 and slot2.bloodPool
	end
}

slot0.initDataMgr()

return slot0
