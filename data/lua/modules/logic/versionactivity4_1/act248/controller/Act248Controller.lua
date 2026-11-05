-- chunkname: @modules/logic/versionactivity4_1/act248/controller/Act248Controller.lua

module("modules.logic.versionactivity4_1.act248.controller.Act248Controller", package.seeall)

local Act248Controller = class("Act248Controller", BaseController)

function Act248Controller:onInit()
	return
end

function Act248Controller:onInitFinish()
	return
end

function Act248Controller:addConstEvents()
	StoryController.instance:registerCallback(StoryEvent.Finish, self._onStartStory, self)
	StoryController.instance:registerCallback(StoryEvent.RefreshStep, self._onRefreshStep, self)
end

function Act248Controller:reInit()
	return
end

function Act248Controller:openAct248EnterView()
	local actId = Act248Model.instance:getActId()

	if ActivityHelper.isOpen(actId) then
		Act248Rpc.instance:sendAct248GetInfoRequest(actId, function()
			ViewMgr.instance:openView(ViewName.Act248EnterView)
		end, self)
	end
end

function Act248Controller:openAct248ClueMainView(pileId, closeCb, closeCbobj)
	local param = {
		pileId = pileId,
		closeCb = closeCb,
		closeCbobj = closeCbobj
	}

	ViewMgr.instance:openView(ViewName.Act248ClueMainView, param)
end

function Act248Controller:openAct248FileView(param)
	ViewMgr.instance:openView(ViewName.Act248FileView, param)
end

function Act248Controller:openAct248ReportView(fileId, isNotFinish)
	local param = {
		fileId = fileId,
		isNotFinish = isNotFinish
	}

	ViewMgr.instance:openView(ViewName.Act248ReportView, param)
end

function Act248Controller:openAct248DecryptionMainView(fileMo)
	local param = {
		fileMo = fileMo
	}

	ViewMgr.instance:openView(ViewName.Act248DecryptionMainView, param)
end

function Act248Controller:openAct248AvgView(storyId, episodeId, afterStory)
	local param = {
		storyId = storyId,
		episodeId = episodeId,
		afterStory = afterStory
	}
	local actId = Act248Model.instance:getActId()

	Act248Rpc.instance:sendAct248GetInfoRequest(actId, function()
		ViewMgr.instance:openView(ViewName.Act248AvgView, param)
	end, self)
end

function Act248Controller:_onStartStory(storyId)
	if storyId == Act248Model.instance:getAvgBeforeStoryId() then
		self:openAct248AvgView(storyId)
	end
end

function Act248Controller:_onRefreshStep(o)
	local actId = Act248Model.instance:getActId()

	if not ActivityHelper.isOpen(actId) then
		return
	end

	local storyId = o.storyId
	local stepId = o.stepId
	local clueMo = Act248Model.instance:getClueMoByStoryStep(storyId, stepId)

	if clueMo then
		ToastController.instance:showToast(Act248Enum.Toast.CollectClue)
	end

	Act248Model.instance:onReadStory(storyId, stepId)
end

Act248Controller.instance = Act248Controller.New()

return Act248Controller
