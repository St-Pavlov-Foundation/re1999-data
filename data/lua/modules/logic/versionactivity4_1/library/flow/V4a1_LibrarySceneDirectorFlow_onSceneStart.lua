-- chunkname: @modules/logic/versionactivity4_1/library/flow/V4a1_LibrarySceneDirectorFlow_onSceneStart.lua

module("modules.logic.versionactivity4_1.library.flow.V4a1_LibrarySceneDirectorFlow_onSceneStart", package.seeall)

local Base = V4a1_LibrarySceneFlowSequenceBase
local V4a1_LibrarySceneDirectorFlow_onSceneStart = class("V4a1_LibrarySceneDirectorFlow_onSceneStart", Base)

function V4a1_LibrarySceneDirectorFlow_onSceneStart:ctor(...)
	Base.ctor(self, ...)
end

function V4a1_LibrarySceneDirectorFlow_onSceneStart:onDestroyView()
	V4a1_LibrarySceneDirectorFlow_onSceneStart.super.onDestroyView(self)
end

function V4a1_LibrarySceneDirectorFlow_onSceneStart:onStart()
	local v4a1_Library_LoadingContainer = ViewMgr.instance:getContainer(ViewName.V4a1_Library_Loading)
	local loadLevelFlow = ChgFlowParallel_Base.New()

	loadLevelFlow:addWork(LibAsyncTaskWork.s_create(self:sceneLevelComp(), CommonSceneLevelComp.OnLevelLoaded))
	loadLevelFlow:addWork(LibAsyncTaskWork.s_create(self:scenePreloaderComp(), V4a1_LibraryEvent.OnPreloadFinish))
	self:addWork(loadLevelFlow)

	local loadResFlow = ChgFlowParallel_Base.New()

	loadResFlow:addWork(LibAsyncTaskWork.s_create(self:sceneEntityMgrComp(), V4a1_LibraryEvent.OnShowCharsChanged))

	if v4a1_Library_LoadingContainer then
		loadResFlow:addWork(WmzWork_WaitEvent.s_create(GameSceneMgr.instance, SceneEventName.LoadingAnimEnd))
	end

	self:addWork(loadResFlow)

	local closeLoadingFlow = ChgFlowParallel_Base.New()

	if v4a1_Library_LoadingContainer then
		closeLoadingFlow:addWork(WmzWork_WaitEvent.s_create(ViewMgr.instance, ViewEvent.OnCloseView, v4a1_Library_LoadingContainer.viewName, v4a1_Library_LoadingContainer.viewParam))
	else
		closeLoadingFlow:addWork(WmzWork_WaitEvent.s_create(GameSceneMgr.instance, SceneEventName.LoadingAnimEnd))
	end

	closeLoadingFlow:addWork(FunctionWork.New(self._onScenePrepared, self))
	self:addWork(closeLoadingFlow)
	self:addWork(GaoSiNiaoWork_OpenView.s_create(V4a1_LibrarySceneViewComp.s_MainViewName()))
	self:addWork(FunctionWork.New(self._onPlayOpenAnim, self))
end

function V4a1_LibrarySceneDirectorFlow_onSceneStart:_onScenePrepared()
	self:sceneObj():onPrepared()
end

function V4a1_LibrarySceneDirectorFlow_onSceneStart:_onPlayOpenAnim()
	self:sceneGoComp():onPlayOpenAnim()
	self:sceneViewComp():onPlayOpenAnim()
end

return V4a1_LibrarySceneDirectorFlow_onSceneStart
