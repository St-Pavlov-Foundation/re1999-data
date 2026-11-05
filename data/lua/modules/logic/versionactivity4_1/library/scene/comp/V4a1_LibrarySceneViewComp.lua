-- chunkname: @modules/logic/versionactivity4_1/library/scene/comp/V4a1_LibrarySceneViewComp.lua

module("modules.logic.versionactivity4_1.library.scene.comp.V4a1_LibrarySceneViewComp", package.seeall)

local V4a1_LibrarySceneViewComp = class("V4a1_LibrarySceneViewComp", V4a1_LibraryBaseSceneComp)

function V4a1_LibrarySceneViewComp:ctor(...)
	V4a1_LibrarySceneViewComp.super.ctor(self, ...)

	if isDebugBuild then
		local setting = ViewMgr.instance:getSetting(V4a1_LibrarySceneViewComp.s_MainViewName())

		assert(setting.viewType ~= ViewType.Full, "use ViewType.Normal instead of ViewType.Full, cuz GameFullViewState:_onOpenFullView")
	end
end

function V4a1_LibrarySceneViewComp.s_MainViewName()
	return ViewName.V4a1_Library_MainView
end

function V4a1_LibrarySceneViewComp:onSceneClose(...)
	ViewMgr.instance:closeView(V4a1_LibrarySceneViewComp.s_MainViewName())
	V4a1_LibrarySceneViewComp.super.onSceneClose(self, ...)
end

function V4a1_LibrarySceneViewComp:getMainViewContainer()
	return ViewMgr.instance:getContainer(V4a1_LibrarySceneViewComp.s_MainViewName())
end

function V4a1_LibrarySceneViewComp:getMainViewObj()
	local c = self:getMainViewContainer()

	return c and c:getMainView()
end

function V4a1_LibrarySceneViewComp:onPlayOpenAnim()
	local viewObj = self:getMainViewObj()

	if viewObj then
		viewObj:onPlayOpenAnim()
	end
end

return V4a1_LibrarySceneViewComp
