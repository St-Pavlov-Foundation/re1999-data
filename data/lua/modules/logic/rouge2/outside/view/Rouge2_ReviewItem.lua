-- chunkname: @modules/logic/rouge2/outside/view/Rouge2_ReviewItem.lua

module("modules.logic.rouge2.outside.view.Rouge2_ReviewItem", package.seeall)

local Rouge2_ReviewItem = class("Rouge2_ReviewItem", LuaCompBase)

function Rouge2_ReviewItem:init(go)
	self.go = go
	self._goUnlocked = gohelper.findChild(self.go, "#go_Unlocked")
	self._simageItemPic = gohelper.findChildSingleImage(self.go, "#go_Unlocked/#simage_ItemPic")
	self._gonew = gohelper.findChild(self.go, "#go_Unlocked/#go_new")
	self._txtName = gohelper.findChildText(self.go, "#go_Unlocked/#txt_Name")
	self._btnPlay = gohelper.findChildButtonWithAudio(self.go, "#go_Unlocked/#btn_Play")
	self._goLocked = gohelper.findChild(self.go, "#go_Locked")
	self._goLine = gohelper.findChild(self.go, "#go_Line")
	self._goLine1 = gohelper.findChild(self.go, "#go_Line/#go_Line1")
	self._goLine2 = gohelper.findChild(self.go, "#go_Line/#go_Line2")
	self._goLine3 = gohelper.findChild(self.go, "#go_Line/#go_Line3")
	self._goLine4 = gohelper.findChild(self.go, "#go_Line/#go_Line4")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_ReviewItem:addEventListeners()
	self._btnPlay:AddClickListener(self._btnPlayOnClick, self)
	self:addEventCb(Rouge2_OutsideController.instance, Rouge2_OutsideEvent.OnClearRedDot, self.onClearRedDot, self)
end

function Rouge2_ReviewItem:removeEventListeners()
	self._btnPlay:RemoveClickListener()
	self:removeEventCb(Rouge2_OutsideController.instance, Rouge2_OutsideEvent.OnClearRedDot, self.onClearRedDot, self)
end

function Rouge2_ReviewItem:_btnPlayOnClick()
	if not string.nilorempty(self._config.eventId) then
		local param = {}
		local config = Rouge2_OutSideConfig.instance:getIllustrationConfig(tonumber(self._config.eventId))

		param.config = config
		param.displayType = Rouge2_OutsideEnum.IllustrationDetailType.Story

		Rouge2_ViewHelper.openRougeIllustrationDetailView(param)

		return
	end

	local levelIdDict = {}

	if not string.nilorempty(self._config.levelIdDict) then
		local levelIdPairs = string.split(self._config.levelIdDict, "|")

		for _, levelIdPair in ipairs(levelIdPairs) do
			local levelIdParam = string.splitToNumber(levelIdPair, "#")

			levelIdDict[levelIdParam[1]] = levelIdParam[2]
		end
	end

	local data = {}

	data.levelIdDict = levelIdDict
	data.isReplay = true

	StoryController.instance:playStories(self._mo.storyIdList, data)

	if self._showNewFlag then
		-- block empty
	end
end

function Rouge2_ReviewItem:_editableInitView()
	self.animator = gohelper.findChildComponent(self.go, "", gohelper.Type_Animator)
end

function Rouge2_ReviewItem:setIndex(index)
	self._index = index
end

function Rouge2_ReviewItem:onUpdateMO(mo, isEnd, reviewView, nodeStoryList, path, scrollGo)
	self._mo = mo
	self._config = mo.config
	self._isEnd = isEnd
	self._reviewView = reviewView
	self._path = path
	self.scrollGo = scrollGo

	self:_updateInfo()
	self:_initNodes(nodeStoryList)
	self:_updateNewFlag()
end

function Rouge2_ReviewItem:_updateNewFlag()
	self._reddotComp = Rouge2_OutsideRedDotComp.Get(self._gonew, self.go, self.scrollGo)

	self._reddotComp:intReddotInfo(RedDotEnum.DotNode.V3a2_Rouge_Review_AVG, self._mo.config.id, Rouge2_OutsideEnum.LocalData.Avg)

	if self._reddotComp and self._reddotComp._isDotShow then
		self.animator:Play("unlock", 0, 0)
	else
		self.animator:Play("idle", 0, 0)
	end
end

function Rouge2_ReviewItem:_initNodes(nodeStoryList)
	if not self._isUnlock then
		return
	end

	if not nodeStoryList or #nodeStoryList <= 1 then
		local showLine = not self._isEnd

		gohelper.setActive(self._goLine1, showLine)

		if nodeStoryList and showLine then
			for i, v in ipairs(nodeStoryList) do
				self:_showNodeText(v, self._goLine1, i, 1)
			end
		end

		return
	end

	local nodeStoryCount = #nodeStoryList
	local goLine = self["_goLine" .. nodeStoryCount]

	gohelper.setActive(goLine, true)

	for i, v in ipairs(nodeStoryList) do
		local node = gohelper.findChild(goLine, "#go_End" .. i)
		local nodeGo = self._reviewView:getResInst(self._path, node, "item" .. v.config.id)
		local nodeItem = MonoHelper.addNoUpdateLuaComOnceToGo(nodeGo, Rouge2_ReviewItem)

		nodeItem._showLock = true

		nodeItem:onUpdateMO(v, true, nil, nil, nil, self.scrollGo)
		self:_showNodeText(v, goLine, i, nodeStoryCount)
	end
end

function Rouge2_ReviewItem:_showNodeText(storyMo, go, index, nodeStoryCount)
	local isUnlock = storyMo and self:_isUnlockStory(storyMo)

	if isUnlock then
		local path

		if nodeStoryCount <= 1 then
			path = string.format("image_Line/image_Line%s/#txt_Descr%s", index, index)
		else
			path = string.format("image_Line/image_Line2/image_Line%s/#txt_Descr%s", index, index)
		end

		local txt = gohelper.findChildTextMesh(go, path)

		if txt then
			txt.text = storyMo.config.desc
		else
			logError("Rouge2_ReviewItem txt is not exist  path:" .. path)
		end
	end
end

function Rouge2_ReviewItem:_updateInfo()
	self._isUnlock = self:_isUnlockStory(self._mo)

	gohelper.setActive(self._goUnlocked, self._isUnlock)

	local canShowLock = self._showLock or self._index == 1

	gohelper.setActive(self._goLocked, not self._isUnlock and canShowLock)

	if not self._isUnlock then
		return
	end

	self._txtName.text = self._config.name

	if not string.nilorempty(self._config.eventId) then
		local illustrationConfig = Rouge2_OutSideConfig.instance:getIllustrationConfig(tonumber(self._config.eventId))

		self._simageItemPic:LoadImage(ResUrl.getRouge2Icon("small/" .. illustrationConfig.image))
	else
		self._simageItemPic:LoadImage(ResUrl.getRouge2Icon("small/" .. self._config.fullImage))
	end
end

function Rouge2_ReviewItem:isUnlock()
	return self._isUnlock
end

function Rouge2_ReviewItem:setMaxUnlockStateId(id)
	self._maxUnlockStateId = id
end

function Rouge2_ReviewItem:_isUnlockStory(mo)
	if self._maxUnlockStateId and self._maxUnlockStateId >= mo.config.stageId then
		return true
	end

	local storyList = mo.storyIdList
	local storyId = storyList[#storyList]

	return Rouge2_OutsideModel.instance:storyIsPass(storyId)
end

function Rouge2_ReviewItem:onClearRedDot()
	self._showNewFlag = false

	gohelper.setActive(self._gonew, self._showNewFlag)
end

function Rouge2_ReviewItem:onDestroy()
	return
end

return Rouge2_ReviewItem
