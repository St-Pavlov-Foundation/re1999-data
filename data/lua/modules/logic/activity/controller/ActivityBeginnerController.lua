-- chunkname: @modules/logic/activity/controller/ActivityBeginnerController.lua

module("modules.logic.activity.controller.ActivityBeginnerController", package.seeall)

local ActivityBeginnerController = class("ActivityBeginnerController", BaseController)

function ActivityBeginnerController:onInit()
	self:_initHandlers()
end

function ActivityBeginnerController:reInit()
	return
end

function ActivityBeginnerController:_initHandlers()
	if self._handlerList then
		return
	end

	self._actTypeIdFirstEndterMap = {
		[ActivityEnum.ActivityTypeID.Act201] = true,
		[ActivityEnum.ActivityTypeID.Act209] = true,
		[ActivityEnum.ActivityTypeID.Act212] = true,
		[ActivityEnum.ActivityTypeID.Act214] = true,
		[ActivityEnum.ActivityTypeID.Act100] = true
	}
	self._actIdFirstEndterMap = {
		[ActivityEnum.Activity.DreamShow] = true,
		[ActivityEnum.Activity.V2a2_TurnBack_H5] = true,
		[VersionActivity2_2Enum.ActivityId.LimitDecorate] = true,
		[VersionActivity3_2Enum.ActivityId.ActivityCollect] = true,
		[VersionActivity3_2Enum.ActivityId.CruiseTripleDrop] = true
	}
	self._actIdFirstWeekMap = {
		[ActivityEnum.Activity.V3a3_SkinDiscount] = true
	}
	self._handlerList = {
		[ActivityEnum.Activity.StoryShow] = {
			self.checkRedDotWithActivityId,
			self.checkFirstEnter
		},
		[ActivityEnum.Activity.DreamShow] = {
			self.checkRedDot,
			self.checkFirstEnter
		},
		[ActivityEnum.Activity.ClassShow] = {
			self.checkRedDotWithActivityId,
			self.checkFirstEnter
		},
		[ActivityEnum.Activity.V2a4_WarmUp] = {
			self.checkRedDotWithActivityId,
			Activity125Controller.checkRed_Task
		}
	}
	self._defaultHandler = {
		self.checkRedDotWithActivityId
	}
end

function ActivityBeginnerController:showRedDot(activityId)
	local handlers = self._handlerList[activityId]

	if not handlers then
		if activityId == DoubleDropModel.instance:getActId() then
			handlers = self._handlerList[ActivityEnum.Activity.ClassShow]
		else
			handlers = self._defaultHandler
		end
	end

	for i, handler in ipairs(handlers) do
		local result = handler(self, activityId)

		if result then
			return true
		end
	end

	if (self._actIdFirstEndterMap[activityId] or activityId == DoubleDropModel.instance:getActId()) and self:checkFirstEnter(activityId) then
		return true
	end

	if self._actIdFirstWeekMap[activityId] and self:checkFirstWeekEnter(activityId) then
		return true
	end

	local actCo = ActivityConfig.instance:getActivityCo(activityId)

	if actCo and self._actTypeIdFirstEndterMap[actCo.typeId] and self:checkFirstEnter(activityId) then
		return true
	end

	return false
end

function ActivityBeginnerController:_getRedDotId(activityId)
	local config = ActivityConfig.instance:getActivityCo(activityId)

	if not config then
		return 0
	end

	local reddotid = config.redDotId

	if reddotid > 0 then
		return reddotid
	end

	local center = config.showCenter

	config = ActivityConfig.instance:getActivityCenterCo(center)

	if not config then
		return 0
	end

	reddotid = config.reddotid

	return reddotid
end

function ActivityBeginnerController:checkRedDot(activityId)
	local reddotid = self:_getRedDotId(activityId)

	if reddotid > 0 then
		return RedDotModel.instance:isDotShow(reddotid)
	end

	return false
end

function ActivityBeginnerController:checkRedDotWithActivityId(activityId)
	local reddotid = self:_getRedDotId(activityId)

	if reddotid > 0 then
		return RedDotModel.instance:isDotShow(reddotid, activityId)
	end

	return false
end

function ActivityBeginnerController:checkFirstEnter(activityId)
	local key = PlayerPrefsKey.FirstEnterActivityShow .. "#" .. tostring(activityId) .. "#" .. tostring(PlayerModel.instance:getPlayinfo().userId)
	local data = PlayerPrefsHelper.getString(key, "")

	return string.nilorempty(data)
end

function ActivityBeginnerController:setFirstEnter(activityId)
	local key = PlayerPrefsKey.FirstEnterActivityShow .. "#" .. tostring(activityId) .. "#" .. tostring(PlayerModel.instance:getPlayinfo().userId)

	PlayerPrefsHelper.setString(key, "hasEnter")
end

function ActivityBeginnerController:checkFirstWeekEnter(activityId)
	local weekEndTime = math.floor(ServerTime.getWeekEndTimeStamp(true) / 3600)
	local key = PlayerPrefsKey.FirstEnterWeek .. "#" .. tostring(activityId) .. "#" .. tostring(PlayerModel.instance:getPlayinfo().userId)
	local cur_save = PlayerPrefsHelper.getNumber(key, 0)

	return cur_save ~= weekEndTime
end

function ActivityBeginnerController:setFirstWeekEnter(activityId)
	local weekEndTime = math.floor(ServerTime.getWeekEndTimeStamp(true) / 3600)
	local key = PlayerPrefsKey.FirstEnterWeek .. "#" .. tostring(activityId) .. "#" .. tostring(PlayerModel.instance:getPlayinfo().userId)

	PlayerPrefsHelper.setNumber(key, weekEndTime)
end

function ActivityBeginnerController:checkActivityNewStage(activityId)
	return ActivityModel.instance:getActivityInfo()[activityId]:isNewStageOpen()
end

function ActivityBeginnerController:checkGoodsTaskReward(activityId)
	local activityConfig = ActivityConfig.instance:getActivityCo(activityId)
	local packageGoodsList = string.splitToNumber(activityConfig.patFaceParam, "#")

	if not packageGoodsList or next(packageGoodsList) == nil then
		return false
	end

	for _, packageGoodsId in ipairs(packageGoodsList) do
		local haveCanGetReward = StoreCharageConditionalHelper.isHasCanFinishGoodsTask(packageGoodsId)

		if haveCanGetReward then
			return true
		end
	end

	return false
end

function ActivityBeginnerController:saveInt(key, value)
	GameUtil.playerPrefsSetNumberByUserId(key, value)
end

function ActivityBeginnerController:getInt(key, defaultValue)
	return GameUtil.playerPrefsGetNumberByUserId(key, defaultValue)
end

function ActivityBeginnerController:saveString(key, value)
	GameUtil.playerPrefsSetStringByUserId(key, value)
end

function ActivityBeginnerController:getString(key, defaultValue)
	return GameUtil.playerPrefsGetStringByUserId(key, defaultValue)
end

function ActivityBeginnerController:cleanFirstEnter(actId)
	local key = PlayerPrefsKey.FirstEnterActivityShow .. "#" .. tostring(actId) .. "#" .. tostring(PlayerModel.instance:getPlayinfo().userId)

	PlayerPrefsHelper.setString(key, "")
end

function ActivityBeginnerController:onReceiveGetActivityInfosReply_OnFirstLogin()
	self:_onReceiveGetActivityInfosReply_OnFirstLogin_WarmUpH5()
end

local kEdTs = "ActivityBeginnerController|EdTs|"

function ActivityBeginnerController:_getEndTimeTsPlayerPrefsKey(actId)
	return kEdTs .. "|" .. actId
end

function ActivityBeginnerController:savePlayerPrefsEdTs(actId, newTs)
	local key = self:_getEndTimeTsPlayerPrefsKey(actId)

	self:saveString(key, tostring(newTs or 0))
end

function ActivityBeginnerController:getPlayerPrefsEdTs(actId, fallback)
	local key = self:_getEndTimeTsPlayerPrefsKey(actId)

	return self:getString(key, tostring(fallback or 0))
end

function ActivityBeginnerController:simpleSavePlayerPrefsEdTs(actId)
	self:savePlayerPrefsEdTs(actId, ActivityModel.instance:getActEndTimeTs(actId))
end

function ActivityBeginnerController:_onReceiveGetActivityInfosReply_OnFirstLogin_WarmUpH5()
	local actIdList = ActivityType100Config.instance:getWarmUpH5ActIdList()

	for _, actId in ipairs(actIdList) do
		if not self:checkFirstEnter(actId) then
			if ActivityModel.instance:isActOnLine(actId) then
				local endTimeTs = ActivityModel.instance:getActEndTimeTs(actId)

				if tonumber(self:getPlayerPrefsEdTs(actId)) ~= endTimeTs then
					self:cleanFirstEnter(actId)
				end
			else
				self:savePlayerPrefsEdTs(actId)
			end
		end
	end
end

ActivityBeginnerController.instance = ActivityBeginnerController.New()

return ActivityBeginnerController
