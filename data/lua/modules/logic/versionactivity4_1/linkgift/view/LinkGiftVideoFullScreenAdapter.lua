-- chunkname: @modules/logic/versionactivity4_1/linkgift/view/LinkGiftVideoFullScreenAdapter.lua

module("modules.logic.versionactivity4_1.linkgift.view.LinkGiftVideoFullScreenAdapter", package.seeall)

local LinkGiftVideoFullScreenAdapter = class("LinkGiftVideoFullScreenAdapter", RougeSimpleItemBase)

function LinkGiftVideoFullScreenAdapter.s_create(Self, srcGo, baseViewContainer)
	local item = LinkGiftVideoFullScreenAdapter.New({
		parent = Self,
		baseViewContainer = baseViewContainer
	})

	srcGo = srcGo or gohelper.create2d(ViewMgr.instance:getUILayer("Adaption"), "LinkGiftVideoFullScreenAdapter")

	item:init(srcGo)

	return item
end

function LinkGiftVideoFullScreenAdapter.s_createByView(Self, srcGo)
	local item = LinkGiftVideoFullScreenAdapter.s_create(Self, srcGo, Self.viewContainer)

	return item
end

function LinkGiftVideoFullScreenAdapter.s_createByListScrollCellExtend(Self, srcGo)
	local scrollView = Self._view
	local item = LinkGiftVideoFullScreenAdapter.s_create(Self, srcGo, scrollView and scrollView.viewContainer or Self.viewContainer)

	return item
end

function LinkGiftVideoFullScreenAdapter.s_createByRougeSimpleItemBase(Self, srcGo)
	local item = LinkGiftVideoFullScreenAdapter.s_create(Self, srcGo, Self:baseViewContainer())

	return item
end

function LinkGiftVideoFullScreenAdapter.s_calcFullScreenWidthHeight(inVideoWidth, inVideoHeight, bScaleFill, optScreenWH, optScreenH)
	local sw = optScreenWH or UnityEngine.Screen.width
	local sh = optScreenH or UnityEngine.Screen.height
	local ratio = 1

	if bScaleFill then
		ratio = math.max(sw / inVideoWidth, sh / inVideoHeight)
	else
		ratio = math.min(sw / inVideoWidth, sh / inVideoHeight)
	end

	local outVideoWidth = inVideoWidth * ratio
	local outVideoHeight = inVideoHeight * ratio

	return outVideoWidth, outVideoHeight
end

function LinkGiftVideoFullScreenAdapter:ctor(...)
	self:__onInit()
	LinkGiftVideoFullScreenAdapter.super.ctor(self, ...)

	self._videoSrcW = -1
	self._videoSrcH = -1
end

function LinkGiftVideoFullScreenAdapter:onDestroyView()
	if not gohelper.isNil(self.viewGO) then
		gohelper.destroy(self.viewGO)
	end

	LinkGiftVideoFullScreenAdapter.super.onDestroyView(self)
	self:__onDispose()
end

function LinkGiftVideoFullScreenAdapter:_editableInitView()
	LinkGiftVideoFullScreenAdapter.super._editableInitView(self)

	local uiRootGo = ViewMgr.instance:getUIRoot()

	self._uiRootTrans = uiRootGo.transform

	self:resetTransform()
end

function LinkGiftVideoFullScreenAdapter:_editableAddEvents()
	GameGlobalMgr.instance:registerCallback(GameStateEvent.OnScreenResize, self._onScreenResize, self)
end

function LinkGiftVideoFullScreenAdapter:_editableRemoveEvents()
	GameGlobalMgr.instance:unregisterCallback(GameStateEvent.OnScreenResize, self._onScreenResize, self)
end

function LinkGiftVideoFullScreenAdapter:_onScreenResize()
	if self._videoSrcW <= 0 or self._videoSrcH <= 0 then
		return
	end

	self:_refreshDisplayWh()
end

function LinkGiftVideoFullScreenAdapter:setVideoWH(videoSrcW, videoSrcH)
	self._videoSrcW = videoSrcW
	self._videoSrcH = videoSrcH

	self:_refreshDisplayWh()
end

function LinkGiftVideoFullScreenAdapter:videoWH()
	return self._videoSrcW, self._videoSrcH
end

function LinkGiftVideoFullScreenAdapter:_refreshDisplayWh()
	local sw = recthelper.getWidth(self._uiRootTrans)
	local sh = recthelper.getHeight(self._uiRootTrans)
	local newW, newH = LinkGiftVideoFullScreenAdapter.s_calcFullScreenWidthHeight(self._videoSrcW, self._videoSrcH, false, sw, sh)

	self:setWH(newW, newH)
end

function LinkGiftVideoFullScreenAdapter:addChildGo(childGo)
	if gohelper.isNil(childGo) then
		return
	end

	local childTrans = childGo.transform

	self:addChildToSlot(childTrans, true, self:transform())
	self:setFullscreenStretch(childTrans)
end

return LinkGiftVideoFullScreenAdapter
