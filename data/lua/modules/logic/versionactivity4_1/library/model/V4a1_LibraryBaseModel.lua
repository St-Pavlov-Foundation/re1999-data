-- chunkname: @modules/logic/versionactivity4_1/library/model/V4a1_LibraryBaseModel.lua

module("modules.logic.versionactivity4_1.library.model.V4a1_LibraryBaseModel", package.seeall)

local V4a1_LibraryBaseModel = class("V4a1_LibraryBaseModel", BaseModel)

function V4a1_LibraryBaseModel:ctor(...)
	V4a1_LibraryBaseModel.super.ctor(self, ...)
end

function V4a1_LibraryBaseModel:onInit()
	V4a1_LibraryBaseModel.super.onInit(self)

	self.__configInst = V4a1_LibraryConfig.instance

	self:reInit()
end

function V4a1_LibraryBaseModel:actId()
	return self.__configInst:actId()
end

function V4a1_LibraryBaseModel:configInst()
	return self.__configInst
end

function V4a1_LibraryBaseModel:getActMO()
	return ActivityModel.instance:getActMO(self:actId())
end

function V4a1_LibraryBaseModel:isActOnLine()
	return ActivityHelper.getActivityStatus(self:actId(), true) == ActivityEnum.ActivityStatus.Normal
end

function V4a1_LibraryBaseModel:getRealStartTimeStamp()
	return self:getActMO():getRealStartTimeStamp()
end

function V4a1_LibraryBaseModel:getRealEndTimeStamp()
	return self:getActMO():getRealEndTimeStamp()
end

function V4a1_LibraryBaseModel:getRemainTimeSec(optActId)
	return ActivityModel.instance:getRemainTimeSec(optActId or self:actId()) or 0
end

return V4a1_LibraryBaseModel
