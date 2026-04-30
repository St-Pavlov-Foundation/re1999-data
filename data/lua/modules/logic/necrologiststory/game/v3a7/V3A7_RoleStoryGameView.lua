-- chunkname: @modules/logic/necrologiststory/game/v3a7/V3A7_RoleStoryGameView.lua

module("modules.logic.necrologiststory.game.v3a7.V3A7_RoleStoryGameView", package.seeall)

local V3A7_RoleStoryGameView = class("V3A7_RoleStoryGameView", BaseView)

function V3A7_RoleStoryGameView:onInitView()
	self._gomapitem = gohelper.findChild(self.viewGO, "Left/TabContent/#go_mapitem")
	self._gofinished = gohelper.findChild(self.viewGO, "Left/#go_finished")
	self._btnstart = gohelper.findChildButtonWithAudio(self.viewGO, "Middle/#btn_start")
	self._btnrestart = gohelper.findChildButtonWithAudio(self.viewGO, "Middle/#btn_restart")
	self._gonormal = gohelper.findChild(self.viewGO, "Right/#go_normal")
	self._golevel3right = gohelper.findChild(self.viewGO, "Right/#go_level_3_right")
	self._goprogress1 = gohelper.findChild(self.viewGO, "Right/#go_level_3_right/progressbg/#go_progress_1")
	self._golevel6right = gohelper.findChild(self.viewGO, "Right/#go_level_6_right")
	self._golevel3 = gohelper.findChild(self.viewGO, "Panel/#go_level_3")
	self._txtprogress = gohelper.findChildText(self.viewGO, "Panel/#go_level_3/txt_tips/#txt_progress")
	self._goprogress = gohelper.findChild(self.viewGO, "Panel/#go_level_3/progressbg/#go_progress")
	self._golevel6 = gohelper.findChild(self.viewGO, "Panel/#go_level_6")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3A7_RoleStoryGameView:addEvents()
	self._btnstart:AddClickListener(self._btnstartOnClick, self)
	self._btnrestart:AddClickListener(self._btnrestartOnClick, self)
	self:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
end

function V3A7_RoleStoryGameView:removeEvents()
	self._btnstart:RemoveClickListener()
	self._btnrestart:RemoveClickListener()
	self:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
end

function V3A7_RoleStoryGameView:_btnstartOnClick()
	local config = NecrologistStoryV3A7Config.instance:getBaseConfig(self._selectLevelId)

	NecrologistStoryController.instance:openStoryView(config.storyId, self.gameBaseMO.id)
end

function V3A7_RoleStoryGameView:_btnrestartOnClick()
	local config = NecrologistStoryV3A7Config.instance:getBaseConfig(self._selectLevelId)

	NecrologistStoryController.instance:openStoryView(config.storyId, self.gameBaseMO.id)
end

function V3A7_RoleStoryGameView:_editableInitView()
	self._goItemParent = gohelper.findChild(self.viewGO, "Left/TabContent")
end

function V3A7_RoleStoryGameView:refreshParam()
	local storyId = self.viewParam.roleStoryId

	if self.gameBaseMO == nil then
		self.gameBaseMO = NecrologistStoryModel.instance:getGameMO(storyId)
	end
end

function V3A7_RoleStoryGameView:onOpen()
	self:refreshParam()

	self._allLevelItem = self:getUserDataTb_()

	local allLevelIds = NecrologistStoryV3A7Config.instance:getBaseList()

	self._selectLevelId = self.gameBaseMO:getLastUnLockLevel()

	gohelper.CreateObjList(self, self._onCreateLevelItem, allLevelIds, self._goItemParent, self._gomapitem)
	self:refreshView()
	gohelper.setActive(self._golevel3, false)
	gohelper.setActive(self._golevel6, false)
end

function V3A7_RoleStoryGameView:setSelectLevelId(levelId)
	if levelId == nil then
		return
	end

	local state = self.gameBaseMO:getLevelState(levelId)

	if state == NecrologistStoryEnum.StoryState.Lock then
		GameFacade.showToast(ToastEnum.V3A7YiShiLevelLockTip)

		return
	end

	self._selectLevelId = levelId

	self:refreshView()
end

function V3A7_RoleStoryGameView:refreshView()
	if self._allLevelItem then
		local count = tabletool.len(self._allLevelItem)

		for i = 1, count do
			local item = self._allLevelItem[i]

			if item then
				local isSelect = item.levelId == self._selectLevelId
				local isLock = self.gameBaseMO:getStoryState(item.storyId) == NecrologistStoryEnum.StoryState.Lock

				gohelper.setActive(item.selectGo, isSelect)
				gohelper.setActive(item.unSelectGo, not isSelect)
				gohelper.setActive(item.lockGo, isLock)
			end
		end
	end

	local state = self.gameBaseMO:getLevelState(self._selectLevelId)
	local isFinish = state == NecrologistStoryEnum.StoryState.Finish

	gohelper.setActive(self._btnstart.gameObject, state == NecrologistStoryEnum.StoryState.Normal)
	gohelper.setActive(self._btnrestart.gameObject, isFinish)
	gohelper.setActive(self._gofinished, self.gameBaseMO:allLevelIsFinish())

	local firstSp = self.gameBaseMO:isFirstSpLevel(self._selectLevelId)
	local lastSp = self.gameBaseMO:isLastSpLevel(self._selectLevelId)

	gohelper.setActive(self._golevel3right, firstSp and isFinish)
	gohelper.setActive(self._golevel6right, lastSp)
	gohelper.setActive(self._gonormal, not firstSp and not lastSp)
end

function V3A7_RoleStoryGameView:_onCreateLevelItem(obj, levelConfig, _)
	local item = {}
	local storyGroupConfig = NecrologistStoryConfig.instance:getPlotGroupCo(levelConfig.storyId)

	item.go = obj
	item.levelId = levelConfig.id
	item.selectGo = gohelper.findChild(obj, "select")
	item.lockGo = gohelper.findChild(obj, "lock")
	item.unSelectGo = gohelper.findChild(obj, "unselect")

	local clickGo = gohelper.findChild(obj, "click")
	local click = gohelper.getClick(clickGo)

	click:AddClickListener(function()
		self:setSelectLevelId(item.levelId)
	end, self)

	item.click = click

	local nameText1 = gohelper.findChildText(obj, "unselect/txt_name")
	local nameText2 = gohelper.findChildText(obj, "lock/txt_name")
	local nameText3 = gohelper.findChildText(obj, "select/txt_name")
	local selectNormal = gohelper.findChild(obj, "select/go_namebg/normal")
	local selectSpe = gohelper.findChild(obj, "select/go_namebg/special")
	local lockNormal = gohelper.findChild(obj, "lock/go_namebg/normal")
	local lockSpe = gohelper.findChild(obj, "lock/go_namebg/special")
	local unSelectNormal = gohelper.findChild(obj, "unselect/go_namebg/normal")
	local unSelectSpe = gohelper.findChild(obj, "unselect/go_namebg/special")
	local firstSp = self.gameBaseMO:isFirstSpLevel(item.levelId)
	local lastSp = self.gameBaseMO:isLastSpLevel(item.levelId)
	local isSp = firstSp or lastSp

	gohelper.setActive(selectNormal, not isSp)
	gohelper.setActive(unSelectNormal, not isSp)
	gohelper.setActive(lockNormal, not isSp)
	gohelper.setActive(unSelectSpe, isSp)
	gohelper.setActive(lockSpe, isSp)
	gohelper.setActive(selectSpe, isSp)

	nameText1.text = storyGroupConfig.storyName
	nameText2.text = storyGroupConfig.storyName
	nameText3.text = storyGroupConfig.storyName
	item.storyId = levelConfig.storyId

	table.insert(self._allLevelItem, item)
end

function V3A7_RoleStoryGameView:onClose()
	if self._allLevelItem then
		for _, v in pairs(self._allLevelItem) do
			if v and v.click then
				v.click:RemoveClickListener()
			end
		end
	end
end

function V3A7_RoleStoryGameView:_onCloseViewFinish()
	local newLevelId = self.gameBaseMO:getLastUnLockLevel()

	if newLevelId == self._selectLevelId then
		return
	end

	local firstSp = self.gameBaseMO:isFirstSpLevel(newLevelId)
	local lastSp = self.gameBaseMO:isLastSpLevel(newLevelId)

	if firstSp or lastSp then
		self:showProgress(newLevelId)
	else
		self:_showNewLevel()
	end
end

function V3A7_RoleStoryGameView:showProgress(levelId)
	local firstSp = self.gameBaseMO:isFirstSpLevel(levelId)
	local lastSp = self.gameBaseMO:isLastSpLevel(levelId)

	gohelper.setActive(self._golevel3, firstSp)
	gohelper.setActive(self._golevel6, lastSp)
	TaskDispatcher.runDelay(self._showNewLevel, self, 2)
end

function V3A7_RoleStoryGameView:_showNewLevel()
	local newLevelId = self.gameBaseMO:getLastUnLockLevel()

	gohelper.setActive(self._golevel3, false)
	gohelper.setActive(self._golevel6, false)
	self:setSelectLevelId(newLevelId)
end

function V3A7_RoleStoryGameView:onDestroyView()
	return
end

return V3A7_RoleStoryGameView
