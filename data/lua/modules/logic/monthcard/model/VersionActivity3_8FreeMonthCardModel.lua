-- chunkname: @modules/logic/monthcard/model/VersionActivity3_8FreeMonthCardModel.lua

module("modules.logic.monthcard.model.VersionActivity3_8FreeMonthCardModel", package.seeall)

local VersionActivity3_8FreeMonthCardModel = class("VersionActivity3_8FreeMonthCardModel", BaseModel)

function VersionActivity3_8FreeMonthCardModel:onInit()
	self:reInit()
end

function VersionActivity3_8FreeMonthCardModel:reInit()
	self._openDay = 0
	self._todaySigned = false
	self._act240Infos = {}
end

function VersionActivity3_8FreeMonthCardModel:set240Infos(info)
	self._openDay = info.openDay
	self._todaySigned = info.todaySigned
	self._act240Infos = self:_buildAct240Infos(info.infos)
end

function VersionActivity3_8FreeMonthCardModel:_buildAct240Infos(infos)
	local act240Infos = {}

	for _, info in ipairs(infos) do
		local act240Info = VersionActivity3_8FreeMonthCardAct240InfoMo.New()

		act240Info:init(info)
		table.insert(act240Infos, act240Info)
	end

	return act240Infos
end

function VersionActivity3_8FreeMonthCardModel:setDaySignIn(dayIds)
	if not self._act240Infos then
		return
	end

	for _, dayId in ipairs(dayIds) do
		if self._act240Infos[dayId] then
			self._act240Infos[dayId]:updateState(MonthCardEnum.Act240SignState.HasGet)
		end
	end
end

function VersionActivity3_8FreeMonthCardModel:isTodaySigned()
	return self._todaySigned
end

function VersionActivity3_8FreeMonthCardModel:getOpenDay()
	return self._openDay
end

function VersionActivity3_8FreeMonthCardModel:getDaySignState(dayId)
	if not self._act240Infos or not self._act240Infos[dayId] then
		return MonthCardEnum.Act240SignState.Unsigned
	end

	return self._act240Infos[dayId].state
end

function VersionActivity3_8FreeMonthCardModel:isDayCanSign(dayId)
	if dayId > self._openDay then
		return false
	end

	if dayId == self._openDay then
		return not self._todaySigned
	end

	local state = self:getDaySignState(dayId)

	return state == MonthCardEnum.Act240SignState.CanSigned
end

function VersionActivity3_8FreeMonthCardModel:getRewardGetDayCount()
	local count = 0

	for _, actInfo in ipairs(self._act240Infos) do
		if actInfo.state == MonthCardEnum.Act240SignState.HasGet then
			count = count + 1
		end
	end

	return count
end

function VersionActivity3_8FreeMonthCardModel:getMaxSignDay()
	local day = 0
	local actCos = Activity240Config.instance:getActivity240Cos()

	for _, actCo in pairs(actCos) do
		day = day < actCo.id and actCo.id or day
	end

	return day
end

function VersionActivity3_8FreeMonthCardModel:getCanBackdateDayCount()
	local hasSignDay = self:getRewardGetDayCount()

	if hasSignDay >= self._openDay - 1 then
		return 0
	end

	return self._openDay - 1 - hasSignDay
end

function VersionActivity3_8FreeMonthCardModel:getAllTasks(actId)
	actId = actId or VersionActivity3_8Enum.ActivityId.FreeMonthCard

	local taskCos = Activity240Config.instance:getActivity240TaskCos(actId)
	local taskList = {}

	for _, taskCo in ipairs(taskCos) do
		table.insert(taskList, taskCo.id)
	end

	table.sort(taskList, VersionActivity3_8FreeMonthCardModel.sortFunc)

	return taskList
end

function VersionActivity3_8FreeMonthCardModel.sortFunc(a, b)
	local aTaskCo = Activity240Config.instance:getActivity240TaskCo(a)
	local bTaskCo = Activity240Config.instance:getActivity240TaskCo(b)
	local aTaskMo = TaskModel.instance:getTaskById(a)
	local bTaskMo = TaskModel.instance:getTaskById(b)

	if not aTaskMo or not bTaskMo then
		return a < b
	end

	local aValue = aTaskMo.progress >= aTaskCo.maxProgress and aTaskMo.finishCount > 0 and 3 or aTaskMo.hasFinished and 1 or 2
	local bValue = bTaskMo.progress >= bTaskCo.maxProgress and bTaskMo.finishCount > 0 and 3 or bTaskMo.hasFinished and 1 or 2

	if aValue ~= bValue then
		return aValue < bValue
	else
		return a < b
	end
end

VersionActivity3_8FreeMonthCardModel.instance = VersionActivity3_8FreeMonthCardModel.New()

return VersionActivity3_8FreeMonthCardModel
