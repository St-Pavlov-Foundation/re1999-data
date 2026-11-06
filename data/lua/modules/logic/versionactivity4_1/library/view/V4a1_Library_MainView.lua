-- chunkname: @modules/logic/versionactivity4_1/library/view/V4a1_Library_MainView.lua

module("modules.logic.versionactivity4_1.library.view.V4a1_Library_MainView", package.seeall)

local V4a1_Library_MainView = class("V4a1_Library_MainView", BaseView)

function V4a1_Library_MainView:onInitView()
	self._gotitle = gohelper.findChild(self.viewGO, "#go_title")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "#go_title/#txt_LimitTime")
	self._gotalk = gohelper.findChild(self.viewGO, "#go_bubble/#go_talk")
	self._txtdesc = gohelper.findChildText(self.viewGO, "#go_bubble/#go_talk/bg/#txt_desc")
	self._goemoji = gohelper.findChild(self.viewGO, "#go_bubble/#go_emoji")
	self._imageemoji = gohelper.findChildImage(self.viewGO, "#go_bubble/#go_emoji/bg/#image_emoji")
	self._golefttop = gohelper.findChild(self.viewGO, "#go_lefttop")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V4a1_Library_MainView:addEvents()
	self._charclick:AddClickListener(self._charclickOnClick, self)
end

function V4a1_Library_MainView:removeEvents()
	self._charclick:RemoveClickListener()
end

function V4a1_Library_MainView:_editableInitView()
	self._txtLimitTime.text = ""

	self:_editableInitView_entryItemList()

	self._gobubble = gohelper.findChild(self.viewGO, "#go_bubble")

	gohelper.setActive(self._gobubble, false)

	self._imagecharclick = gohelper.onceAddComponent(self.viewGO, typeof(UnityEngine.UI.Image))
	self._imagecharclick.color = Color.clear
	self._imagecharclick.raycastTarget = true
	self._charclick = gohelper.getClick(self.viewGO)
	self._animator = self.viewGO:GetComponent(gohelper.Type_Animator)
end

function V4a1_Library_MainView:getBubbleDescTemplate()
	return self._gobubble
end

function V4a1_Library_MainView:getBubbleParentTr()
	return self.viewGO.transform
end

function V4a1_Library_MainView:_charclickOnClick(param, clickPos)
	clickPos = clickPos or UnityEngine.Input.mousePosition

	local sceneObj = V4a1_LibraryController.instance:getSceneObj()

	if not sceneObj then
		return
	end

	if not sceneObj.entitymgr then
		return
	end

	local skinId, charEntity = sceneObj.entitymgr:getRaycastChar(clickPos)

	if charEntity then
		charEntity:onClick()
		self:_trackButtonClick(skinId)
	end
end

function V4a1_Library_MainView:_trackButtonClick(skinId)
	StatController.instance:track(StatEnum.EventName.ButtonClick, {
		[StatEnum.EventProperties.ViewName] = self.viewName,
		[StatEnum.EventProperties.ButtonName] = tostring(skinId or "")
	})
end

function V4a1_Library_MainView:onDestroyView()
	GameUtil.onDestroyViewMemberList(self, "_entryItemList")
	TaskDispatcher.cancelTask(self._refreshTimeTick, self)
end

function V4a1_Library_MainView:_getEntryItem(eV4a1_LibraryEnum_Entry)
	return self._entryItemList[eV4a1_LibraryEnum_Entry]
end

function V4a1_Library_MainView:_getEntryItemByActId(actId)
	for _, item in ipairs(self._entryItemList) do
		if item:actId() == actId then
			return item
		end
	end
end

function V4a1_Library_MainView:_editableInitView_entryItemList()
	local E = V4a1_LibraryEnum.Entry

	self._entryItemList = {
		[E.Investigation_GuessView] = self:_createEntryItemImpl(V4a1_Library_MainViewEntryItemImpl, gohelper.findChild(self.viewGO, "#go_enter1"), Sp02_GuessMeConfig.instance:getInvestigation_GuessViewActId()),
		[E.GuessGame] = self:_createEntryItemImpl(V4a1_Library_MainViewEntryItem_GuessGame, gohelper.findChild(self.viewGO, "#go_enter2"), VersionActivity4_1Enum.ActivityId.GuessGameNew),
		[E.DeepDive] = self:_createEntryItemImpl(V4a1_Library_MainViewEntryItem_DeepDive, gohelper.findChild(self.viewGO, "#go_enter3"), Activity187Config.instance:getDeepDiveActId()),
		[E.GoldenMilletPresent] = self:_createEntryItemImpl(V4a1_Library_MainViewEntryItemImpl, gohelper.findChild(self.viewGO, "#go_enter4"), GoldenMilletPresentModel.instance:getGoldenMilletPresentActId()),
		[E.LinkGift] = self:_createEntryItemImpl(V4a1_Library_MainViewEntryItemImpl, gohelper.findChild(self.viewGO, "#go_enter5"), ActivityType101Config.instance:getLinkGiftActId())
	}

	assert(self.viewContainer:getEntryBtnMaxCount() == #self._entryItemList)
end

function V4a1_Library_MainView:_onUpdateActivity(actId)
	if not actId then
		return
	end

	local item = self:_getEntryItemByActId(actId)

	if not item then
		return
	end

	item:refresh()
end

function V4a1_Library_MainView:_onRefreshActivityState(actId)
	if not actId then
		return
	end

	local item = self:_getEntryItemByActId(actId)

	if not item then
		return
	end

	local mo = item:mo()
	local eV4a1_LibraryEnum_Entry = mo
	local status = ActivityHelper.getActivityStatus(actId, true)

	if status ~= ActivityEnum.ActivityStatus.Expired then
		return
	end

	local E = V4a1_LibraryEnum.Entry

	local function _onClickYesCb(Self)
		if not Self then
			return
		end

		if eV4a1_LibraryEnum_Entry == E.Investigation_GuessView then
			Self:_closeInvestigation_GuessView(actId)
		elseif eV4a1_LibraryEnum_Entry == E.GuessGame then
			Self:_closeGuessGame(actId)
		elseif eV4a1_LibraryEnum_Entry == E.DeepDive then
			Self:_closeDeepDive(actId)
		elseif eV4a1_LibraryEnum_Entry == E.GoldenMilletPresent then
			Self:_closeGoldenMilletPresent(actId)
		elseif eV4a1_LibraryEnum_Entry == E.LinkGift then
			Self:_closeLinkGift(actId)
		elseif isDebugBuild then
			assert(false, "[V4a1_Library_MainView] unsupported entry:" .. tostring(eV4a1_LibraryEnum_Entry))
		end
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.EndActivity, MsgBoxEnum.BoxType.Yes, _onClickYesCb, nil, nil, self)
end

function V4a1_Library_MainView:_refreshEntryItemList()
	local maxCount = self.viewContainer:getEntryBtnMaxCount()

	for i = 1, maxCount do
		local item = self._entryItemList[i]

		if not item then
			if isDebugBuild then
				logError("item count out of range! index:" .. i)
			end

			break
		end

		local eV4a1_LibraryEnum_Entry = i

		item:onUpdateMO(eV4a1_LibraryEnum_Entry)
		item:setActive(true)
	end

	for i = maxCount + 1, #self._entryItemList do
		local item = self._entryItemList[i]

		item:setActive(false)
	end
end

function V4a1_Library_MainView:actId()
	return self.viewContainer:actId()
end

function V4a1_Library_MainView:onOpen()
	self:onUpdateParam()
	self:_refreshEntryItemList()
	TaskDispatcher.runRepeat(self._refreshTimeTick, self, 1)
	self:_refreshTimeTick()
	ActivityController.instance:registerCallback(ActivityEvent.UpdateActivity, self._onUpdateActivity, self)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshActivityState, self._onRefreshActivityState, self)
end

function V4a1_Library_MainView:onPlayOpenAnim()
	self._animator:Play(UIAnimationName.Open, 0, 0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_atlantis4_1_enter)
end

function V4a1_Library_MainView:onClose()
	ActivityController.instance:unregisterCallback(ActivityEvent.UpdateActivity, self._onUpdateActivity, self)
	ActivityController.instance:unregisterCallback(ActivityEvent.RefreshActivityState, self._onRefreshActivityState, self)
end

function V4a1_Library_MainView:onUpdateParam()
	return
end

function V4a1_Library_MainView:_refreshTimeTick()
	self._txtLimitTime.text = self.viewContainer:getRemainTimeStr(self:actId())

	local maxCount = self.viewContainer:getEntryBtnMaxCount()

	for i = 1, maxCount do
		local item = self._entryItemList[i]

		item:onTimerTick()
	end
end

function V4a1_Library_MainView:_createEntryItemImpl(cls, srcGo, actId)
	local item = cls.New({
		parent = self,
		baseViewContainer = self.viewContainer
	})

	item:init(srcGo)
	item:setIndex(actId)

	return item
end

function V4a1_Library_MainView:onClickItem(item)
	local actId = item:actId()
	local mo = item:mo()
	local eV4a1_LibraryEnum_Entry = mo
	local status, toastId, toastParam = ActivityHelper.getActivityStatusAndToast(actId, true)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		if status == ActivityEnum.ActivityStatus.NotOpen then
			local actInfo = ActivityModel.instance:getActMO(actId)
			local timeOffset = actInfo:getRealStartTimeStamp() - ServerTime.now()
			local actName = actInfo.config.name
			local timeStr = TimeUtil.getFormatTime2(timeOffset)

			GameFacade.showToast(ToastEnum.V1a4_ActPreTips, actName, timeStr)
		elseif toastId then
			GameFacade.showToastWithTableParam(toastId, toastParam)
		end

		return
	end

	local E = V4a1_LibraryEnum.Entry

	if eV4a1_LibraryEnum_Entry == E.Investigation_GuessView then
		self:_openInvestigation_GuessView(actId)
	elseif eV4a1_LibraryEnum_Entry == E.GuessGame then
		self:_openGuessGame(actId)
	elseif eV4a1_LibraryEnum_Entry == E.DeepDive then
		self:_openDeepDive(actId)
	elseif eV4a1_LibraryEnum_Entry == E.GoldenMilletPresent then
		self:_openGoldenMilletPresent(actId)
	elseif eV4a1_LibraryEnum_Entry == E.LinkGift then
		self:_openLinkGift(actId)
	elseif isDebugBuild then
		assert(false, "[V4a1_Library_MainView] unsupported entry:" .. tostring(eV4a1_LibraryEnum_Entry))
	end
end

function V4a1_Library_MainView:_openInvestigation_GuessView(actId)
	Sp02_PaoMianController.instance:openInvestigation_GuessView(actId)
end

function V4a1_Library_MainView:_openGuessGame(actId)
	ViewMgr.instance:openView(ViewName.GuessGameNewMainView)
end

function V4a1_Library_MainView:_openDeepDive(actId)
	return
end

function V4a1_Library_MainView:_openGoldenMilletPresent(actId)
	ViewMgr.instance:openView(ViewName.GoldenMilletPresent, {
		actId = actId
	})
end

function V4a1_Library_MainView:_openLinkGift(actId)
	ViewMgr.instance:openView(ViewName.LinkGift_PanelView, {
		actId = actId
	})
end

function V4a1_Library_MainView:_closeInvestigation_GuessView(actId)
	Sp02_PaoMianController.instance:closeInvestigation_GuessView(actId)
end

function V4a1_Library_MainView:_closeGuessGame(actId)
	ViewMgr.instance:closeView(ViewName.GuessGameNewMainView)
end

function V4a1_Library_MainView:_closeDeepDive(actId)
	return
end

function V4a1_Library_MainView:_closeGoldenMilletPresent(actId)
	ViewMgr.instance:closeView(ViewName.GoldenMilletPresent)
end

function V4a1_Library_MainView:_closeLinkGift(actId)
	ViewMgr.instance:closeView(ViewName.LinkGift_PanelView)
end

return V4a1_Library_MainView
