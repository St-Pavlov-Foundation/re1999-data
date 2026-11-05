-- chunkname: @modules/logic/versionactivity4_1/evelyn/view/EvelynTaskView.lua

module("modules.logic.versionactivity4_1.evelyn.view.EvelynTaskView", package.seeall)

local EvelynTaskView = class("EvelynTaskView", BaseView)

function EvelynTaskView:onInitView()
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Left/LimitTime/image_LimitTimeBG/#txt_LimitTime")
	self._simageFullBg = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function EvelynTaskView:addEvents()
	self:addEventCb(TaskController.instance, TaskEvent.SuccessGetBonus, self._oneClaimReward, self)
	self:addEventCb(TaskController.instance, TaskEvent.OnFinishTask, self._onFinishTask, self)
end

function EvelynTaskView:removeEvents()
	self:removeEventCb(TaskController.instance, TaskEvent.SuccessGetBonus, self._oneClaimReward, self)
	self:removeEventCb(TaskController.instance, TaskEvent.OnFinishTask, self._onFinishTask, self)
end

function EvelynTaskView:_oneClaimReward()
	Activity220TaskListModel.instance:init(self._actId)
end

function EvelynTaskView:_onFinishTask(taskId)
	if Activity220TaskListModel.instance:getById(taskId) then
		Activity220TaskListModel.instance:init(self._actId)
	end
end

function EvelynTaskView:_editableInitView()
	return
end

function EvelynTaskView:onUpdateParam()
	return
end

function EvelynTaskView:onOpen()
	self._actId = self.viewParam.actId

	Activity220TaskListModel.instance:clear()
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Activity220
	}, self._oneClaimReward, self)
	self:showLeftTime()
	self:_refreshTaskBg()
	TaskDispatcher.runRepeat(self.showLeftTime, self, TimeUtil.OneMinuteSecond)
end

function EvelynTaskView:showLeftTime()
	if not self._txtLimitTime then
		return
	end

	self._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(self._actId)
end

function EvelynTaskView:_refreshTaskBg()
	if not self._simageFullBg then
		return
	end

	local episodeCos = EvelynConfig.instance:getEpisodeConfigList()
	local lastEpisodeCo = episodeCos and episodeCos[#episodeCos]
	local useDiffBg = false

	if lastEpisodeCo then
		local episodeInfo = Activity220Model.instance:getEpisodeInfo(self._actId, lastEpisodeCo.episodeId)

		useDiffBg = episodeInfo and episodeInfo:isEpisodePass() or false
	end

	local bgName = useDiffBg and EvelynEnum.TaskBgDiffName or EvelynEnum.TaskBgName

	self._simageFullBg:LoadImage(string.format("%s/%s.png", EvelynEnum.LevelBgDir, bgName))
end

function EvelynTaskView:onClose()
	TaskDispatcher.cancelTask(self.showLeftTime, self)
end

function EvelynTaskView:onDestroyView()
	TaskDispatcher.cancelTask(self.showLeftTime, self)
end

return EvelynTaskView
