-- chunkname: @modules/logic/versionactivity4_1/linkgift/view/V4a1_LinkGift_Page1.lua

module("modules.logic.versionactivity4_1.linkgift.view.V4a1_LinkGift_Page1", package.seeall)

local V4a1_LinkGift_Page1 = class("V4a1_LinkGift_Page1", V4a1_LinkGift_PageImpl)

function V4a1_LinkGift_Page1:onInitView()
	self._btnvideo1 = gohelper.findChildButtonWithAudio(self.viewGO, "mask/switch/#go_tab1/#btn_video1")
	self._btnvideo2 = gohelper.findChildButtonWithAudio(self.viewGO, "mask/switch/#go_tab2/#btn_video2")
	self._btnmaxsize = gohelper.findChildButtonWithAudio(self.viewGO, "mask/switch/#btn_maxsize")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V4a1_LinkGift_Page1:addEvents()
	self._btnvideo1:AddClickListener(self._btnvideo1OnClick, self)
	self._btnvideo2:AddClickListener(self._btnvideo2OnClick, self)
	self._btnmaxsize:AddClickListener(self._btnmaxsizeOnClick, self)
end

function V4a1_LinkGift_Page1:removeEvents()
	self._btnvideo1:RemoveClickListener()
	self._btnvideo2:RemoveClickListener()
	self._btnmaxsize:RemoveClickListener()
end

local kDefaultVideoIndex = 1
local kAnimEvt = "switch"
local kVideoWidth = V4a1_LinkGift_VideoItem.kVideoWidth or 944
local kVideoHeight = V4a1_LinkGift_VideoItem.kVideoHeight or 530

function V4a1_LinkGift_Page1:ctor(...)
	V4a1_LinkGift_Page1.super.ctor(self, ...)

	self._videoItemList = {}
	self._videoTabItemList = {}
	self._curVideoIndex = false
	self._videoFullScreenTransList = {}
	self._videoTabItemList_fullScreen = {}
	self._videoFullScreenAdapter = LinkGiftVideoFullScreenAdapter.s_createByRougeSimpleItemBase(self)

	self._videoFullScreenAdapter:setVideoWH(kVideoWidth, kVideoHeight)
end

function V4a1_LinkGift_Page1:_editableAddEvents()
	V4a1_LinkGift_Page1.super._editableAddEvents(self)
	self._btnCloseFullScreen:AddClickListener(self._btnCloseFullScreenOnClick, self)
	self._btnvideo1_fullscreen:AddClickListener(self._btnvideo1OnClick, self)
	self._btnvideo2_fullscreen:AddClickListener(self._btnvideo2OnClick, self)
end

function V4a1_LinkGift_Page1:_editableRemoveEvents()
	self._btnCloseFullScreen:RemoveClickListener()
	self._btnvideo1_fullscreen:RemoveClickListener()
	self._btnvideo2_fullscreen:RemoveClickListener()
	V4a1_LinkGift_Page1.super._editableRemoveEvents(self)
end

function V4a1_LinkGift_Page1:_btnCloseFullScreenOnClick()
	self:onClickExitFullScreen()
end

function V4a1_LinkGift_Page1:_editableInitView()
	V4a1_LinkGift_Page1.super._editableInitView(self)

	local videoFullScreenRootGo = self:videoFullScreenRootGo()

	self._cardEffect_fullscreen = gohelper.findChild(videoFullScreenRootGo, "cardEffect").transform
	self._btnCloseFullScreen = gohelper.findChildButtonWithAudio(videoFullScreenRootGo, "back/#btn_close")
	self._btnvideo1_fullscreen = gohelper.findChildButtonWithAudio(videoFullScreenRootGo, "switch/go_tab/#go_tab1/#btn_video1")
	self._btnvideo2_fullscreen = gohelper.findChildButtonWithAudio(videoFullScreenRootGo, "switch/go_tab/#go_tab2/#btn_video2")

	self:_editableInitView_layout()
	self:_editableInitView_videotab()
	self:_editableInitView_video()
	self:_editableInitView_videotab_fullscreen()
	self:setActive(false)
	self:_setActive_fullScreen(false)
	self._videoFullScreenAdapter:addChildGo(videoFullScreenRootGo)
end

function V4a1_LinkGift_Page1:_setActive_fullScreen(bActive)
	gohelper.setActive(self:videoFullScreenRootGo(), bActive)
end

function V4a1_LinkGift_Page1:_editableInitView_layout()
	local i = 1

	repeat
		local go = gohelper.findChild(self.viewGO, string.format("layout/pos%s", i))
		local isNil = gohelper.isNil(go)

		if not isNil then
			local item = self:create_V4a1_LinkGift_LayoutRewardItem(go, i)

			table.insert(self._rewardItemList, item)
		end

		i = i + 1
	until isNil
end

function V4a1_LinkGift_Page1:_editableInitView_video()
	self._cardEffectGo = gohelper.findChild(self.viewGO, "mask/cardEffect")
	self._cardEffectTrans = self._cardEffectGo.transform

	local i = 1

	repeat
		local go = gohelper.findChild(self._cardEffectGo, string.format("go_video%s", i))
		local isNil = gohelper.isNil(go)

		if not isNil then
			local item = self:_create_V4a1_LinkGift_VideoItem(go, i)

			table.insert(self._videoItemList, item)
		end

		i = i + 1
	until isNil
end

function V4a1_LinkGift_Page1:_editableInitView_video_fullscreen()
	self._videoFullScreenTransList = self:getUserDataTb_()

	local i = 1

	repeat
		local go = gohelper.findChild(self:videoFullScreenRootGo(), string.format("cardEffect/go_video%s", i))
		local isNil = gohelper.isNil(go)

		if not isNil then
			table.insert(self._videoFullScreenTransList, go.transform)
		end

		i = i + 1
	until isNil

	if isDebugBuild then
		assert(#self._videoFullScreenTransList >= 2)
	end
end

function V4a1_LinkGift_Page1:_create_V4a1_LinkGift_VideoItem(srcGo, index)
	local item = V4a1_LinkGift_VideoItem.New({
		parent = self,
		baseViewContainer = self:baseViewContainer()
	})

	item:setIndex(index)
	item:init(srcGo)

	return item
end

function V4a1_LinkGift_Page1:_editableInitView_videotab()
	local i = 1

	repeat
		local go = gohelper.findChild(self.viewGO, string.format("mask/switch/#go_tab%s", i))
		local isNil = gohelper.isNil(go)

		if not isNil then
			local item = self:_create_V4a1_LinkGift_VideoTabItem(go, i)

			table.insert(self._videoTabItemList, item)
		end

		i = i + 1
	until isNil
end

function V4a1_LinkGift_Page1:_editableInitView_videotab_fullscreen()
	local i = 1

	repeat
		local go = gohelper.findChild(self:videoFullScreenRootGo(), string.format("switch/go_tab/#go_tab%s", i))
		local isNil = gohelper.isNil(go)

		if not isNil then
			local item = self:_create_V4a1_LinkGift_VideoTabItem(go, i)

			table.insert(self._videoTabItemList_fullScreen, item)
		end

		i = i + 1
	until isNil
end

function V4a1_LinkGift_Page1:_create_V4a1_LinkGift_VideoTabItem(srcGo, index)
	local item = V4a1_LinkGift_VideoTabItem.New({
		parent = self,
		baseViewContainer = self:baseViewContainer()
	})

	item:setIndex(index)
	item:init(srcGo)

	return item
end

function V4a1_LinkGift_Page1:onDestroyView()
	TaskDispatcher.cancelTask(self._onAutoSwitchPage, self)
	TaskDispatcher.cancelTask(self._onWaitCdDone, self)
	GameUtil.onDestroyViewMemberList(self, "_videoTabItemList")
	GameUtil.onDestroyViewMemberList(self, "_videoTabItemList_fullScreen")
	GameUtil.onDestroyViewMemberList(self, "_videoItemList")
	GameUtil.onDestroyViewMember(self, "_videoFullScreenAdapter")
	V4a1_LinkGift_Page1.super.onDestroyView(self)
end

function V4a1_LinkGift_Page1:_btnChangeOnClick()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_switch_20220009)
	self:selectedPage(1)
end

function V4a1_LinkGift_Page1:setData(mo)
	V4a1_LinkGift_Page1.super.setData(self, mo)
	self:_refreshVideoItemList()
	self:selectedVideo(self:_currentVideoIndex())
	self:_setupAutoSwitchPage()
end

function V4a1_LinkGift_Page1:_refreshVideoTabItemList()
	for i, item in ipairs(self._videoTabItemList) do
		item:onSelect(i == self:_currentVideoIndex())
	end

	for i, item in ipairs(self._videoTabItemList_fullScreen) do
		item:onSelect(i == self:_currentVideoIndex())
	end
end

function V4a1_LinkGift_Page1:_refreshVideoItemList()
	for i, item in ipairs(self._videoItemList) do
		local videoName = self:getLinkageActivityCO_res_video(i)
		local data = {
			videoName = videoName
		}

		item:onUpdateMO(data)
	end
end

function V4a1_LinkGift_Page1:onSelectedVideo(index, lastIndex, isFirst)
	if isFirst then
		self:_onSwitch()

		return
	end

	self:_playAnim_switchTo(index)
end

function V4a1_LinkGift_Page1:_currentVideoIndex()
	return self:curVideoIndex() or kDefaultVideoIndex
end

function V4a1_LinkGift_Page1:_getAnotherVideo()
	local index = self:_currentVideoIndex()

	if isDebugBuild then
		assert(index <= 2)
	end

	return 3 - index
end

function V4a1_LinkGift_Page1:_playAnim_switchTo(index)
	self:_onSwitch()
end

function V4a1_LinkGift_Page1:_onSwitch()
	local index = self:_currentVideoIndex()
	local curVideoItem = self:getVideoItem(index)

	curVideoItem:setAsLastSibling()
	self:_refreshVideoTabItemList()
end

function V4a1_LinkGift_Page1:_selectedVideo_slient(index)
	self._curVideoIndex = index

	self:_onSwitch()
end

function V4a1_LinkGift_Page1:onPostSelectedPage(curPage, lastPage)
	if self == curPage then
		self:_refreshVideoItemList()
	end

	V4a1_LinkGift_Page1.super.onPostSelectedPage(self, curPage, lastPage)
end

function V4a1_LinkGift_Page1:selectedVideo(index, bManually)
	if bManually then
		TaskDispatcher.cancelTask(self._onAutoSwitchPage, self)
		TaskDispatcher.cancelTask(self._onWaitCdDone, self)

		if not self:baseViewContainer():bFullScreen() then
			TaskDispatcher.runDelay(self._onWaitCdDone, self, self:baseViewContainer():getAutoSwitchVideoCDSec())
		end
	end

	if self._curVideoIndex == index then
		return
	end

	if bManually then
		self:baseViewContainer():trackSwitchVideoOnClick(index)
	end

	local isFirst = self._curVideoIndex == false
	local lastIndex = self._curVideoIndex

	self._curVideoIndex = index

	self:onSelectedVideo(index, lastIndex, isFirst)
end

function V4a1_LinkGift_Page1:curVideoIndex()
	return self._curVideoIndex
end

function V4a1_LinkGift_Page1:getVideoItem(index)
	return self._videoItemList[index]
end

function V4a1_LinkGift_Page1:getCurVideoItem()
	return self._videoItemList[self._curVideoIndex]
end

function V4a1_LinkGift_Page1:_btnmaxsizeOnClick()
	self:_setFullScreen(true)
	self:baseViewContainer():trackFullScreenOnClick()
end

function V4a1_LinkGift_Page1:onClickExitFullScreen()
	self:_setFullScreen(false)
end

function V4a1_LinkGift_Page1:_setFullScreen(bFullScreen)
	TaskDispatcher.cancelTask(self._onAutoSwitchPage, self)
	TaskDispatcher.cancelTask(self._onWaitCdDone, self)

	if bFullScreen == self:baseViewContainer():bFullScreen() then
		return
	end

	self:baseViewContainer():setFullScreenSlient(bFullScreen)

	if bFullScreen then
		for i, item in ipairs(self._videoItemList) do
			item:transform():SetParent(self._cardEffect_fullscreen, true)
			item:resetFullscreenStretch()
		end
	else
		for i, item in ipairs(self._videoItemList) do
			item:transform():SetParent(self._cardEffectTrans, true)
			item:resetFullscreenStretch()
		end
	end

	if not bFullScreen then
		self:_setupAutoSwitchPage()
	end

	local index = self:_currentVideoIndex()

	self._curVideoIndex = nil

	self:selectedVideo(index)
	self:_setActive_fullScreen(bFullScreen)
end

function V4a1_LinkGift_Page1:_onAutoSwitchPage()
	self:_selectAnotherVideo()
end

function V4a1_LinkGift_Page1:_selectAnotherVideo()
	self:selectedVideo(self:_getAnotherVideo())
end

function V4a1_LinkGift_Page1:_setupAutoSwitchPage(bExecNow, optRepeatSec)
	TaskDispatcher.cancelTask(self._onAutoSwitchPage, self)
	TaskDispatcher.runRepeat(self._onAutoSwitchPage, self, optRepeatSec or self:baseViewContainer():getPlayNextVideoSec())

	if bExecNow then
		self:_onAutoSwitchPage()
	end
end

function V4a1_LinkGift_Page1:_onWaitCdDone()
	self:_setupAutoSwitchPage(true)
end

return V4a1_LinkGift_Page1
