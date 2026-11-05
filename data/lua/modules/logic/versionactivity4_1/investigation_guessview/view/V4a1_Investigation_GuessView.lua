-- chunkname: @modules/logic/versionactivity4_1/investigation_guessview/view/V4a1_Investigation_GuessView.lua

module("modules.logic.versionactivity4_1.investigation_guessview.view.V4a1_Investigation_GuessView", package.seeall)

local V4a1_Investigation_GuessView = class("V4a1_Investigation_GuessView", BaseView)

function V4a1_Investigation_GuessView:onInitView()
	self._btnclickArea = gohelper.findChildButtonWithAudio(self.viewGO, "root/left/#btn_clickArea")
	self._simagePic = gohelper.findChildSingleImage(self.viewGO, "root/left/imagemask/#simage_Pic")
	self._goselect1 = gohelper.findChild(self.viewGO, "root/left/selectpoint/#go_select1")
	self._goselect2 = gohelper.findChild(self.viewGO, "root/left/selectpoint/#go_select2")
	self._gotalk = gohelper.findChild(self.viewGO, "root/left/selectpoint/#go_talk")
	self._txtdec = gohelper.findChildText(self.viewGO, "root/left/selectpoint/#go_talk/#txt_dec")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "root/right/LimitTime/#txt_LimitTime")
	self._scrollTaskTabList = gohelper.findChildScrollRect(self.viewGO, "root/right/TaskTab/#scroll_TaskTabList")
	self._goTaskItem = gohelper.findChild(self.viewGO, "root/right/TaskTab/#scroll_TaskTabList/Viewport/Content/#go_TaskItem")
	self._goUnSelected = gohelper.findChild(self.viewGO, "root/right/TaskTab/#scroll_TaskTabList/Viewport/Content/#go_TaskItem/#go_UnSelected")
	self._goSelected = gohelper.findChild(self.viewGO, "root/right/TaskTab/#scroll_TaskTabList/Viewport/Content/#go_TaskItem/#go_Selected")
	self._goreddot = gohelper.findChild(self.viewGO, "root/right/TaskTab/#scroll_TaskTabList/Viewport/Content/#go_TaskItem/#go_reddot")
	self._scrollTaskDesc = gohelper.findChildScrollRect(self.viewGO, "root/right/TaskPanel/#scroll_TaskDesc")
	self._txtTaskContent = gohelper.findChildText(self.viewGO, "root/right/TaskPanel/#scroll_TaskDesc/Viewport/Content/#txt_TaskContent")
	self._scrollReward = gohelper.findChildScrollRect(self.viewGO, "root/right/RawardPanel/#scroll_Reward")
	self._goRewardItem = gohelper.findChild(self.viewGO, "root/right/RawardPanel/#scroll_Reward/Viewport/Content/#go_RewardItem")
	self._btngetreward = gohelper.findChildButtonWithAudio(self.viewGO, "root/right/RawardPanel/#btn_getreward")
	self._goOptionContent = gohelper.findChild(self.viewGO, "root/right/#go_OptionContent")
	self._goOptionItem = gohelper.findChild(self.viewGO, "root/right/#go_OptionContent/#go_OptionItem")
	self._golefttop = gohelper.findChild(self.viewGO, "root/#go_lefttop")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")
	self._gosettings = gohelper.findChild(self.viewGO, "root/left/#go_settings")
	self._txtTitle = gohelper.findChildText(self.viewGO, "root/right/TaskPanel/#scroll_TaskDesc/Viewport/Content/#txt_title")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V4a1_Investigation_GuessView:addEvents()
	self._btnclickArea:AddClickListener(self._btnclickAreaOnClick, self)
	self._btngetreward:AddClickListener(self._btngetrewardOnClick, self)
end

function V4a1_Investigation_GuessView:removeEvents()
	self._btnclickArea:RemoveClickListener()
	self._btngetreward:RemoveClickListener()
end

local ti = table.insert
local string_match = string.match
local tonumber = _G.tonumber

function V4a1_Investigation_GuessView:ctor(...)
	V4a1_Investigation_GuessView.super.ctor(self, ...)

	self._ctx = V4a1_Investigation_GuessView_BubbleContext.New()
end

function V4a1_Investigation_GuessView:_btnclickAreaOnClick()
	return
end

function V4a1_Investigation_GuessView:_btngetrewardOnClick()
	if self._status ~= Sp02_GuessMeEnum.TaskStatus.CanGet then
		return
	end

	Activity238Rpc.instance:sendAct238BonusRequest(self:_actId(), self._selectTaskId)
end

function V4a1_Investigation_GuessView:_actId()
	return self.viewContainer:actId()
end

function V4a1_Investigation_GuessView:_editableInitView()
	self._selectpointItemList = {}
	self._itemTabList = {}
	self._goUnknowHero = gohelper.findChild(self.viewGO, "root/left/#go_UnknowHero")
	self._goKnowHero = gohelper.findChild(self.viewGO, "root/left/#go_KnowHero")
	self._simageRolePic = gohelper.findChildSingleImage(self.viewGO, "root/left/#go_KnowHero/#simage_rolePic")
	self._simageRolePicMask = gohelper.findChildSingleImage(self.viewGO, "root/left/#go_UnknowHero/#simage_rolePicMask")
	self._txtName = gohelper.findChildText(self.viewGO, "root/left/#go_KnowHero/Image_txt/#txt_Name")
	self._goLeft = gohelper.findChild(self.viewGO, "root/left")
	self._goTaskTabList = self._scrollTaskTabList.gameObject
	self._goTaskViewport = gohelper.findChild(self._goTaskTabList, "Viewport")
	self._goTaskContent = gohelper.findChild(self._goTaskViewport, "Content")
	self._viewAnimator = gohelper.onceAddComponent(self.viewGO, gohelper.Type_Animator)
	self._animEventWrap = gohelper.onceAddComponent(self.viewGO, gohelper.Type_AnimationEventWrap)

	self._animEventWrap:AddEventListener("switch_content", self._startSwitchGuessMeDay, self)

	self._leftAnimator = gohelper.onceAddComponent(self._goLeft, gohelper.Type_Animator)
	self._tranTaskContent = self._goTaskContent.transform
	self._taskScrollViewportWidth = recthelper.getWidth(self._goTaskViewport.transform)

	self:_editableInitView_settings()
	gohelper.setActive(self._goTaskItem, false)
end

function V4a1_Investigation_GuessView:getBubbleObj(activity238_bubble_desc_id)
	return self._ctx:getBubbleObj(activity238_bubble_desc_id)
end

local kNodeNamePattern = "activity238_bubble_desc_(%d+)"

function V4a1_Investigation_GuessView:_editableInitView_settings()
	self._gosettingsTrans = self._gosettings.transform

	local childCount = self._gosettingsTrans.childCount

	self._bubbleStateInfo = {}

	for i = 0, childCount - 1 do
		local child = self._gosettingsTrans:GetChild(i)
		local bubbleIdStr = string_match(child.name, kNodeNamePattern)
		local activity238_bubble_desc_id = tonumber(bubbleIdStr)

		if activity238_bubble_desc_id then
			local CO = Sp02_GuessMeConfig.instance:getBubbleDescCO(activity238_bubble_desc_id)

			if CO then
				local bubbleObj = self:getBubbleObj(activity238_bubble_desc_id)
				local item = self:_create_V4a1_Investigation_GuessView_Selectpoint(child.gameObject, #self._selectpointItemList + 1)

				item:onUpdateMO(CO)
				ti(self._selectpointItemList, item)
			end
		end
	end
end

function V4a1_Investigation_GuessView:onBubbleHided(item)
	local bubbleObj = item:getBubbleObj()
	local nextBubbleIndex = -1

	if bubbleObj then
		nextBubbleIndex = bubbleObj:gpIndex() + 1
	end

	local nextBubbleId = self._bubbleIdList[nextBubbleIndex]
	local nextBubbleObj = self:getBubbleObj(nextBubbleId)

	item:stopLoopAnim()

	if nextBubbleObj then
		if bubbleObj:dayId() ~= nextBubbleObj:dayId() then
			local bubbleIdList = self._ctx:getBubbleIdListByDay(bubbleObj:dayId())
			local realNextBubbleId = bubbleIdList[nextBubbleIndex]
			local realNextBubbleObj = self:getBubbleObj(realNextBubbleId)

			if realNextBubbleObj then
				realNextBubbleObj:setState(V4a1_Investigation_Bubble.State.WaitingClick)
			end

			return
		end

		nextBubbleObj:setState(V4a1_Investigation_Bubble.State.WaitingClick)

		for _, item in ipairs(self._selectpointItemList) do
			if item:bubbleId() == nextBubbleId then
				item:setActive(true)

				break
			end
		end
	end
end

function V4a1_Investigation_GuessView:_onSelectGuessDay(index)
	if index == self._selectIndex then
		return
	end

	self._readySelectIndex = index

	self._viewAnimator:Play(UIAnimationName.Switch, 0, 0)
end

function V4a1_Investigation_GuessView:_onUpdateGuessMe()
	if true or self:_allowPlaySwitchAnim() then
		self:_playAnimSwitch()
	else
		self:_refreshUI()
	end
end

function V4a1_Investigation_GuessView:_onSelectGuessMeOption(index)
	if not index or self._status >= Sp02_GuessMeEnum.TaskStatus.CanGet then
		return
	end

	if index ~= self._correctOption then
		self._selectFailCount = self._selectFailCount + 1
	end

	self:_trackOptionOnClick(index)
end

function V4a1_Investigation_GuessView:onUpdateParam()
	self._activityCo = ActivityConfig.instance:getActivityCo(self:_actId())

	self:_initSelectIndex()
	self:_refreshUI()
	self:_autoSelectTab()
	TaskDispatcher.cancelTask(self._refreshRemainTime, self)
	TaskDispatcher.runRepeat(self._refreshRemainTime, self, 30)
	self:_refreshRemainTime()
end

function V4a1_Investigation_GuessView:onOpen()
	self._readySelectIndex = nil

	self._ctx:reset(self)
	self:onUpdateParam()
	self:addEventCb(Sp02_PaoMianController.instance, Sp02_GuessMeEvent.OnUpdateGuessMe, self._onUpdateGuessMe, self)
	self:addEventCb(Sp02_PaoMianController.instance, Sp02_GuessMeEvent.OnSelectGuessMeDay, self._onSelectGuessDay, self)
	self:addEventCb(Sp02_PaoMianController.instance, Sp02_GuessMeEvent.OnSelectGuessMeOption, self._onSelectGuessMeOption, self)
	AudioMgr.instance:trigger(AudioEnum3_10.PaoMian.EnterGuessMeView)
end

function V4a1_Investigation_GuessView:onClose()
	self._animEventWrap:RemoveAllEventListener()
	TaskDispatcher.cancelTask(self._refreshRemainTime, self)
end

function V4a1_Investigation_GuessView:onDestroyView()
	self._simageRolePic:UnLoadImage()
	self._simageRolePicMask:UnLoadImage()
	TaskDispatcher.cancelTask(self._onSwitch, self)
	GameUtil.onDestroyViewMemberList(self, "_selectpointItemList")
	GameUtil.onDestroyViewMemberList(self, "_itemTabList")
end

function V4a1_Investigation_GuessView:_initSelectIndex()
	local selectIndex = 1
	local taskConfigList = self._ctx:taskConfigList()

	for i, config in ipairs(taskConfigList) do
		local status = Sp02_GuessMeModel.instance:getStatus(config.activityId, config.id)

		if status == Sp02_GuessMeEnum.TaskStatus.Lock then
			break
		end

		selectIndex = i

		if status == Sp02_GuessMeEnum.TaskStatus.CanGet or status == Sp02_GuessMeEnum.TaskStatus.UnLock then
			break
		end
	end

	self:_initSelectInfo(selectIndex)
end

function V4a1_Investigation_GuessView:_initSelectInfo(index)
	GameUtil.onDestroyViewMember(self, "_flow")

	self._selectIndex = index
	self._preSelectTaskId = self._selectTaskId
	self._selectTaskCo = self._ctx:getTaskCoByIndex(self._selectIndex)
	self._selectTaskId = self._selectTaskCo and self._selectTaskCo.id
	self._correctOption = self._selectTaskCo and self._selectTaskCo.correctOption
	self._optionList = self:_initOptionList(self._selectTaskCo)
	self._rewardList = Sp02_GuessMeConfig.instance:getRewardIdList(self._selectTaskCo.activityId, self._selectTaskCo.id)
	self._signMo = Sp02_GuessMeModel.instance:getSignInfo(self._selectTaskCo.activityId, self._selectTaskCo.id)
	self._status = Sp02_GuessMeModel.instance:getStatus(self:_actId(), self._selectTaskId)
	self._bubbleIdList = self._selectTaskCo and self._selectTaskCo.bubbleIds or {}
	self._selectFailCount = 0
end

function V4a1_Investigation_GuessView:_initOptionList(dayCo)
	local optionList = {}

	for i = 1, 3 do
		local optionInfo = dayCo["option" .. i]

		if not string.nilorempty(optionInfo) then
			table.insert(optionList, optionInfo)
		end
	end

	return optionList
end

local a = 1

function V4a1_Investigation_GuessView:_refreshUI()
	self._preStatus = self._status
	self._status = Sp02_GuessMeModel.instance:getStatus(self:_actId(), self._selectTaskId)
	self._txtTaskContent.text = self._selectTaskCo and self._selectTaskCo.desc or ""
	self._txtTitle.text = self._selectTaskCo and self._selectTaskCo.title or ""
	self._txtName.text = self._selectTaskCo and self._selectTaskCo.answer

	local bDone = self._status > Sp02_GuessMeEnum.TaskStatus.UnLock

	gohelper.setActive(self._btngetreward, self._status == Sp02_GuessMeEnum.TaskStatus.CanGet)
	gohelper.setActive(self._goUnknowHero, self._status <= Sp02_GuessMeEnum.TaskStatus.UnLock)
	gohelper.setActive(self._goKnowHero, bDone)
	self._simageRolePic:LoadImage(ResUrl.getV4a1InvestigationGuessSingleBg(self._selectTaskCo.questionPictuer))
	self._simageRolePicMask:LoadImage(ResUrl.getV4a1InvestigationGuessSingleBg(self._selectTaskCo.questionMask))
	self:_refreshTabList()
	gohelper.CreateObjList(self, self._refreshOptionItem, self._optionList, self._goOptionContent, self._goOptionItem, Sp02_GuessMeOptionItem)
	gohelper.CreateObjList(self, self._refreshRewardItem, self._rewardList, self._goRewardContent, self._goRewardItem, Sp02_GuessMeRewardItem)

	local firstBubbleId = self._bubbleIdList[1]

	for _, item in ipairs(self._selectpointItemList) do
		item:setActive_bubbleTalkGo(false)

		if bDone then
			item:setActive(false)
		else
			local obj = item:getBubbleObj()
			local bActive = not obj:bDisActive()

			if bActive then
				bActive = false

				for _, bubbleId in ipairs(self._bubbleIdList) do
					if bubbleId == item:bubbleId() then
						bActive = true

						break
					end
				end
			end

			if bActive then
				item:refresh()
			else
				item:setActive(false)
			end
		end
	end
end

function V4a1_Investigation_GuessView:_refreshTabList()
	local maxCount = self._ctx:taskCount()

	for i = 1, maxCount do
		local data = self._ctx:getTaskCoByIndex(i)
		local isSelected = i == self._selectIndex
		local item

		if i > #self._itemTabList then
			item = self:_create_Sp02_GuessMeTaskItem(i)

			table.insert(self._itemTabList, item)
		else
			item = self._itemTabList[i]
		end

		item:onUpdateMO(data)
		item:setActive(true)
		item:setSelected(isSelected)

		if isSelected then
			self._selectTaskItem = taskItem
		end
	end

	for i = maxCount + 1, #self._itemTabList do
		local item = self._itemTabList[i]

		item:setActive(false)
	end

	ZProj.UGUIHelper.RebuildLayout(self._tranTaskContent)
end

function V4a1_Investigation_GuessView:_create_Sp02_GuessMeTaskItem(index)
	local go = gohelper.clone(self._goTaskItem, self._goTaskContent, Sp02_GuessMeTaskItem.__cname)
	local item = Sp02_GuessMeTaskItem.New({
		parent = self,
		baseViewContainer = self.viewContainer
	})

	item:setIndex(index)
	item:init(go)

	return item
end

function V4a1_Investigation_GuessView:_autoSelectTab()
	self:_setSelectIndex(self._selectIndex, true)
end

function V4a1_Investigation_GuessView:_setSelectIndex(index, isFocus, needClick)
	if index == self._lastSelectedIndex then
		return
	end

	self:_taskScrollToIndex(index, needClick)
end

local kItemWidth_go_radiotaskitem = 175

function V4a1_Investigation_GuessView:_taskScrollToIndex(index, needClick)
	local maxScrollPosX = math.max(recthelper.getWidth(self._tranTaskContent) - self._taskScrollViewportWidth, 0)
	local posX = math.min((index - 1) * kItemWidth_go_radiotaskitem, maxScrollPosX)

	recthelper.setAnchorX(self._tranTaskContent, -posX)

	if needClick then
		self:_initSelectInfo(index)
		self:_refreshUI()
	end
end

function V4a1_Investigation_GuessView:_allowPlaySwitchAnim()
	local isPreCanGet = self._preStatus and self._preStatus >= Sp02_GuessMeEnum.TaskStatus.CanGet
	local status = Sp02_GuessMeModel.instance:getStatus(self:_actId(), self._selectTaskId)
	local isCurCanGet = status and status >= Sp02_GuessMeEnum.TaskStatus.CanGet

	if isPreCanGet == isCurCanGet then
		return false
	end

	if isCurCanGet and not isPreCanGet then
		return true
	end
end

function V4a1_Investigation_GuessView:_playAnimSwitch()
	self._leftAnimator:Play(UIAnimationName.Switch, 0, 0)
	TaskDispatcher.cancelTask(self._onSwitch, self)
	TaskDispatcher.runDelay(self._onSwitch, self, 0.16)
end

function V4a1_Investigation_GuessView:_onSwitch()
	local taskConfigList = self._ctx:taskConfigList()

	if self._selectIndex == 4 then
		local targetIndex = 5
		local bUnlock5 = false
		local config = taskConfigList[targetIndex]

		if config then
			local status = Sp02_GuessMeModel.instance:getStatus(config.activityId, config.id)

			if status == Sp02_GuessMeEnum.TaskStatus.CanGet or status == Sp02_GuessMeEnum.TaskStatus.UnLock then
				self:_taskScrollToIndex(#taskConfigList)
			end
		end
	end

	self:_refreshUI()
end

function V4a1_Investigation_GuessView:_refreshRemainTime()
	self._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(self:_actId())
end

function V4a1_Investigation_GuessView:_refreshOptionItem(optionItem, optionInfo, index)
	optionItem:onUpdateMO(index, optionInfo, self._selectTaskCo, self._signMo)
end

function V4a1_Investigation_GuessView:_refreshRewardItem(rewardItem, rewardCo, index)
	rewardItem:onUpdateMO(index, rewardCo, self._selectTaskCo, self._signMo)
end

function V4a1_Investigation_GuessView:_startSwitchGuessMeDay()
	if not self._readySelectIndex then
		return
	end

	self:_initSelectInfo(self._readySelectIndex)
	self:_refreshUI()
end

function V4a1_Investigation_GuessView:_create_V4a1_Investigation_GuessView_Selectpoint(srcGo, index)
	local item = V4a1_Investigation_GuessView_Selectpoint.New({
		parent = self,
		baseViewContainer = self.viewContainer
	})

	item:setIndex(index)
	item:init(srcGo)

	return item
end

function V4a1_Investigation_GuessView:onTrackBubbleOnClick(item)
	local notice_id = item:bubbleId()

	StatController.instance:track("41_preview_notice", {
		date_id = self._selectIndex,
		notice_id = notice_id
	})
end

function V4a1_Investigation_GuessView:_trackOptionOnClick(answer_id)
	StatController.instance:track("preview_choose", {
		date_id = self._selectIndex,
		answer_id = answer_id
	})
end

return V4a1_Investigation_GuessView
