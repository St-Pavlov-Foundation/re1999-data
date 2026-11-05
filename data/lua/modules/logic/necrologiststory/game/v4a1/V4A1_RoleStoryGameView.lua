-- chunkname: @modules/logic/necrologiststory/game/v4a1/V4A1_RoleStoryGameView.lua

module("modules.logic.necrologiststory.game.v4a1.V4A1_RoleStoryGameView", package.seeall)

local V4A1_RoleStoryGameView = class("V4A1_RoleStoryGameView", BaseView)

function V4A1_RoleStoryGameView:onInitView()
	self._goBgCg = gohelper.findChild(self.viewGO, "#go_bgcg")
	self.bgCgCtrl = self._goBgCg:GetComponent(typeof(ZProj.MaterialPropsCtrl))
	self.animBgCg = self._goBgCg:GetComponent(typeof(UnityEngine.Animator))
	self._goUnlockedBg = gohelper.findChild(self._goBgCg, "unlocked")
	self._unlocksimagecgbg = gohelper.findChildSingleImage(self._goUnlockedBg, "#simage_cgbg")
	self._unlockimagecgbg = gohelper.findChildImage(self._goUnlockedBg, "#simage_cgbg")
	self._unlockmask = gohelper.findChild(self._goUnlockedBg, "#simage_cgbgmask")
	self._goLockedBg = gohelper.findChild(self._goBgCg, "locked")
	self._locksimagecgbg = gohelper.findChildSingleImage(self._goLockedBg, "bgmask/#simage_cgbg")
	self._lockimagecgbg = gohelper.findChildImage(self._goLockedBg, "bgmask/#simage_cgbg")
	self.goScroll = gohelper.findChild(self.viewGO, "#scroll_content")
	self.goContent = gohelper.findChild(self.viewGO, "#scroll_content/Viewport/Content")
	self.goItem = gohelper.findChild(self.viewGO, "#scroll_content/Viewport/Content/goItem")
	self.goItem1 = gohelper.findChild(self.viewGO, "#scroll_content/Viewport/Content/go_item1")
	self.goItem2 = gohelper.findChild(self.viewGO, "#scroll_content/Viewport/Content/go_item2")

	gohelper.setActive(self.goItem, false)
	gohelper.setActive(self.goItem1, false)
	gohelper.setActive(self.goItem2, false)

	self.itemList = {}
	self.goCheckItem = gohelper.findChild(self.viewGO, "#scroll_content/Viewport/Content/go_checkitem")

	gohelper.setActive(self.goCheckItem, false)

	self.scroll = gohelper.findChildComponent(self.viewGO, "#scroll_content", typeof(ZProj.LimitedScrollRect))

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V4A1_RoleStoryGameView:addEvents()
	self:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
end

function V4A1_RoleStoryGameView:removeEvents()
	self:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
end

function V4A1_RoleStoryGameView:_editableInitView()
	return
end

function V4A1_RoleStoryGameView:_onCloseViewFinish(viewName)
	local isTop = ViewHelper.instance:checkViewOnTheTop(self.viewName)

	if not isTop then
		return
	end

	self:refreshView()
end

function V4A1_RoleStoryGameView:onClickStoryItem(item)
	local plotCo = item.plotCo

	if not plotCo then
		return
	end

	self.selectId = plotCo.id

	local isFinish = self.gameBaseMO:isStoryFinish(plotCo.id)

	NecrologistStoryController.instance:openStoryView(plotCo.id, not isFinish and self.gameBaseMO.id)
	self:refreshStoryList()
end

function V4A1_RoleStoryGameView:onOpen()
	self:refreshParam()
	self:refreshView()
end

function V4A1_RoleStoryGameView:refreshView()
	self:refreshRoleStoryBg()
	self:refreshStoryList()
	self:refreshListPos()
	self:playUnlockEndEffect()
end

function V4A1_RoleStoryGameView:refreshParam()
	local viewParam = self.viewParam or {}
	local storyId = viewParam.roleStoryId

	self.heroStoryId = storyId

	if storyId then
		self.gameBaseMO = NecrologistStoryModel.instance:getGameMO(storyId)
	end
end

function V4A1_RoleStoryGameView:refreshStoryList()
	if self.cgUnlock then
		gohelper.setActive(self.goScroll, false)
		gohelper.setActive(self._unlockmask, false)

		return
	end

	gohelper.setActive(self.goScroll, true)
	gohelper.setActive(self._unlockmask, true)

	local plotList = NecrologistStoryConfig.instance:getPlotListByStoryId(self.heroStoryId)

	for i = 1, math.max(#plotList, #self.itemList) do
		local item = self:createItem(i)

		self:refreshItem(item, plotList[i])
	end
end

function V4A1_RoleStoryGameView:refreshListPos()
	local isOnOpen = false

	if not self.unlockDict then
		self.unlockDict = {}
		isOnOpen = true
	end

	local plotList = NecrologistStoryConfig.instance:getPlotListByStoryId(self.heroStoryId)

	for i = #plotList, 1, -1 do
		local config = plotList[i]
		local isUnlock = self.gameBaseMO:isStoryUnlock(config.id)

		if isUnlock then
			if not self.unlockDict[config.id] then
				self.unlockDict[config.id] = true

				self:_focusItem(i, isOnOpen and 0 or 0.2)
			end

			break
		end
	end
end

function V4A1_RoleStoryGameView:createItem(index)
	local item = self.itemList[index]

	if not item then
		item = self:getUserDataTb_()
		item.index = index

		local parentItem = self.goItem1

		if index % 2 == 0 then
			parentItem = self.goItem2
		end

		item.goParent = gohelper.cloneInPlace(parentItem, tostring(index))
		item.go = gohelper.clone(self.goItem, item.goParent, "item")

		gohelper.setActive(item.go, true)

		item.normalItem = self:getUserDataTb_()
		item.normalItem.go = gohelper.findChild(item.go, "go_normalbg")
		item.normalItem.txtIndex = gohelper.findChildTextMesh(item.normalItem.go, "txtIndex")
		item.normalItem.txtTitle = gohelper.findChildTextMesh(item.normalItem.go, "txtTitle")
		item.normalItem.txtTitleEn = gohelper.findChildTextMesh(item.normalItem.go, "txtTitleEn")
		item.selectItem = self:getUserDataTb_()
		item.selectItem.go = gohelper.findChild(item.go, "go_selectbg")
		item.selectItem.txtIndex = gohelper.findChildTextMesh(item.selectItem.go, "txtIndex")
		item.selectItem.txtTitle = gohelper.findChildTextMesh(item.selectItem.go, "txtTitle")
		item.selectItem.txtTitleEn = gohelper.findChildTextMesh(item.selectItem.go, "txtTitleEn")
		item.btn = gohelper.findButtonWithAudio(item.go)

		item.btn:AddClickListener(self.onClickStoryItem, self, item)

		item.goBranch = gohelper.findChild(item.go, "go_fencha")
		item.goCheck = gohelper.findChild(item.go, "go_check")
		item.goEffect = gohelper.findChild(item.go, "go_post_credits_scene")

		gohelper.setActive(item.goEffect, false)

		item.checkList = {}
		self.itemList[index] = item
	end

	return item
end

function V4A1_RoleStoryGameView:playUnlockEndEffect()
	local isStoryUnlock = self.gameBaseMO:isStoryUnlock(311309)

	if not isStoryUnlock then
		return
	end

	local checkCount = self.gameBaseMO:getCheckCount()
	local count = 15
	local isUnlock = count <= checkCount

	if not isUnlock then
		return
	end

	local hasPlay = NecrologistStoryPlayerPrefs.instance:isExist(NecrologistStoryEnum.PrefsKey.V4A1EndUnlockAnim, true)

	if hasPlay then
		return
	end

	local index = 9
	local item = self.itemList[index]

	if not item then
		return
	end

	self:_focusItem(index, 0)
	gohelper.setActive(item.goEffect, false)
	gohelper.setActive(item.goEffect, true)
	AudioMgr.instance:trigger(AudioEnum.NecrologistStory.play_ui_checkpoint_unlock)
	NecrologistStoryPlayerPrefs.instance:setExist(NecrologistStoryEnum.PrefsKey.V4A1EndUnlockAnim, true)
	self:showBlock()
	TaskDispatcher.runDelay(self.openStoryEndItem, self, 0.4)
end

function V4A1_RoleStoryGameView:openStoryEndItem()
	self:closeBlock()

	local item = self.itemList[9]

	if not item then
		return
	end

	self:onClickStoryItem(item)
end

function V4A1_RoleStoryGameView:refreshItem(item, plotCo)
	item.plotCo = plotCo

	if not plotCo then
		gohelper.setActive(item.goParent, false)

		return
	end

	local isUnlock = self.gameBaseMO:isStoryUnlock(plotCo.id)

	gohelper.setActive(item.goParent, isUnlock)

	if not isUnlock then
		return
	end

	local isSelect = self.selectId == plotCo.id

	gohelper.setActive(item.selectItem.go, isSelect)
	gohelper.setActive(item.normalItem.go, not isSelect)

	local txtItem = isSelect and item.selectItem or item.normalItem

	if plotCo.storyId == NecrologistStoryEnum.RoleStoryId.V4A0 then
		txtItem.txtIndex.text = ""
	else
		txtItem.txtIndex.text = string.format("%02d", item.index)
	end

	txtItem.txtTitle.text = plotCo.storyName
	txtItem.txtTitleEn.text = plotCo.storyNameEn

	gohelper.setActive(item.goBranch, plotCo.branch == 1)

	if plotCo.branch == 1 then
		NecrologistStoryController.instance:dispatchEvent(NecrologistStoryEvent.ShowBranch)
	end

	local checkList = NecrologistStoryV4A1Config.instance:getCheckList(plotCo.id) or {}

	for i = 1, math.max(#checkList, #item.checkList) do
		local checkId = checkList[i]
		local checkItem = self:getCheckItem(item, i)

		gohelper.setActive(checkItem.go, checkId ~= nil)

		if checkId then
			local isSuccess = self.gameBaseMO:isCheckSuccess(checkId)

			if isSuccess ~= nil then
				gohelper.setActive(checkItem.goSuccess, isSuccess)
				gohelper.setActive(checkItem.goFail, not isSuccess)
			else
				gohelper.setActive(checkItem.goSuccess, false)
				gohelper.setActive(checkItem.goFail, false)
			end
		end
	end
end

function V4A1_RoleStoryGameView:getCheckItem(item, index)
	local checkItem = item.checkList[index]

	if not checkItem then
		checkItem = self:getUserDataTb_()
		checkItem.index = index
		checkItem.go = gohelper.clone(self.goCheckItem, item.goCheck, tostring(index))
		checkItem.goSuccess = gohelper.findChild(checkItem.go, "success")
		checkItem.goFail = gohelper.findChild(checkItem.go, "fail")
		item.checkList[index] = checkItem
	end

	return checkItem
end

function V4A1_RoleStoryGameView:refreshRoleStoryBg()
	gohelper.setActive(self._goBgCg, true)

	local storyCo = RoleStoryConfig.instance:getStoryById(self.heroStoryId)
	local unlock = RoleStoryModel.instance:isCGUnlock(self.heroStoryId)

	if unlock and (self.cgUnlock or RoleStoryModel.instance:canPlayDungeonUnlockAnim(self.heroStoryId)) then
		if ViewMgr.instance:isOpen(ViewName.NecrologistStoryView) then
			gohelper.setActive(self._goUnlockedBg, false)
			gohelper.setActive(self._goLockedBg, true)
			self.animBgCg:Play("idle")
			self:refreshRoleStoryLockBg(storyCo)
		else
			RoleStoryModel.instance:setPlayDungeonUnlockAnimFlag(self.heroStoryId)
			gohelper.setActive(self._goUnlockedBg, true)
			gohelper.setActive(self._goLockedBg, true)
			self:refreshRoleStoryUnlockBg(storyCo)
			self:refreshRoleStoryLockBg(storyCo)
			self.animBgCg:Play("unlock", 0, 0)
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoin_chapter_unlock)
		end
	else
		gohelper.setActive(self._goUnlockedBg, unlock)
		gohelper.setActive(self._goLockedBg, not unlock)
		self.animBgCg:Play("idle")

		if unlock then
			self:refreshRoleStoryUnlockBg(storyCo)
		else
			self:refreshRoleStoryLockBg(storyCo)
		end
	end
end

function V4A1_RoleStoryGameView:refreshRoleStoryUnlockBg(storyCo)
	self._unlocksimagecgbg:LoadImage(string.format("singlebg/dungeon/rolestory_bg_singlebg/%s.png", storyCo.cgBg), self._onLoadUnlockCgCallback, self)
	recthelper.setAnchor(self._unlockimagecgbg.transform, 0, 0)
	transformhelper.setLocalScale(self._unlockimagecgbg.transform, 1, 1, 1)
end

function V4A1_RoleStoryGameView:refreshRoleStoryLockBg(storyCo)
	self._locksimagecgbg:LoadImage(string.format("singlebg/dungeon/rolestory_bg_singlebg/%s.png", storyCo.cgBg), self._onLoadLockCgCallback, self)

	local poss = string.splitToNumber(storyCo.cgPos, "#")

	recthelper.setAnchor(self._lockimagecgbg.transform, poss[1] or 0, poss[2] or 0)
	transformhelper.setLocalScale(self._lockimagecgbg.transform, tonumber(storyCo.cgScale) or 1, tonumber(storyCo.cgScale) or 1, 1)
end

function V4A1_RoleStoryGameView:_onLoadUnlockCgCallback()
	self._unlockimagecgbg:SetNativeSize()
end

function V4A1_RoleStoryGameView:_onLoadLockCgCallback()
	self._lockimagecgbg:SetNativeSize()
end

function V4A1_RoleStoryGameView:getBranchItem()
	local plotList = NecrologistStoryConfig.instance:getPlotListByStoryId(self.heroStoryId)

	for i, plotCo in ipairs(plotList) do
		if plotCo.branch == 1 then
			self:_focusItem(i, 0.1)

			return self.itemList[i]
		end
	end
end

function V4A1_RoleStoryGameView:_focusItem(index, delayTime)
	local item = self.itemList[index]

	if not item then
		return
	end

	if self.tweenId then
		ZProj.TweenHelper.KillById(self.tweenId)

		self.tweenId = nil
	end

	ZProj.UGUIHelper.RebuildLayout(self.goContent.transform)

	local pos = recthelper.getAnchorX(item.goParent.transform) - 308
	local scrollWidth = recthelper.getWidth(self.goScroll.transform)
	local contentWidth = recthelper.getWidth(self.goContent.transform)
	local widthOffset = contentWidth - scrollWidth
	local moveLimt = math.max(0, widthOffset)

	pos = math.min(moveLimt, pos)
	pos = -pos

	if delayTime and delayTime > 0 then
		self.tweenId = ZProj.TweenHelper.DOAnchorPosX(self.goContent.transform, pos, delayTime)
	else
		recthelper.setAnchorX(self.goContent.transform, pos)
	end
end

function V4A1_RoleStoryGameView:onClose()
	return
end

function V4A1_RoleStoryGameView:showBlock()
	GameUtil.setActiveUIBlock(self.viewName, true, false)
end

function V4A1_RoleStoryGameView:closeBlock()
	GameUtil.setActiveUIBlock(self.viewName, false, false)
end

function V4A1_RoleStoryGameView:onDestroyView()
	self:closeBlock()

	if self._unlocksimagecgbg then
		self._unlocksimagecgbg:UnLoadImage()
	end

	if self._locksimagecgbg then
		self._locksimagecgbg:UnLoadImage()
	end

	for _, item in ipairs(self.itemList) do
		item.btn:RemoveClickListener()
	end

	if self.tweenId then
		ZProj.TweenHelper.KillById(self.tweenId)

		self.tweenId = nil
	end

	TaskDispatcher.cancelTask(self.openStoryEndItem, self)
end

return V4A1_RoleStoryGameView
