-- chunkname: @modules/logic/versionactivity4_1/evelyn/model/EvelynModel.lua

module("modules.logic.versionactivity4_1.evelyn.model.EvelynModel", package.seeall)

local EvelynModel = class("EvelynModel", BaseModel)

function EvelynModel:onInit()
	return
end

function EvelynModel:reInit()
	return
end

function EvelynModel:getActId()
	return VersionActivity4_1Enum.ActivityId.Evelyn
end

function EvelynModel:isActOpen(isToast)
	local actId = self:getActId()
	local status, toastId, toastParam
	local actInfoMo = ActivityModel.instance:getActMO(actId)

	if actInfoMo then
		status, toastId, toastParam = ActivityHelper.getActivityStatusAndToast(actId)
	else
		toastId = ToastEnum.ActivityEnd
	end

	if isToast and toastId then
		GameFacade.showToast(toastId, toastParam)
	end

	local result = status == ActivityEnum.ActivityStatus.Normal

	return result
end

EvelynModel.instance = EvelynModel.New()

return EvelynModel
