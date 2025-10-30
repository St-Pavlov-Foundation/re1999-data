-- chunkname: @modules/logic/rouge2/outside/view/Rouge2_CareerHandBookMainView.lua

module("modules.logic.rouge2.outside.view.Rouge2_CareerHandBookMainView", package.seeall)

local Rouge2_CareerHandBookMainView = class("Rouge2_CareerHandBookMainView", BaseView)

function Rouge2_CareerHandBookMainView:onInitView()
	self._txtprogress = gohelper.findChildText(self.viewGO, "Level/progressbg/#txt_progress")
	self._txtlevel = gohelper.findChildText(self.viewGO, "Level/#txt_level")
	self._btncheck = gohelper.findChildButtonWithAudio(self.viewGO, "Level/#btn_check")
	self._scrollTabList = gohelper.findChildScrollRect(self.viewGO, "#scroll_TabList")
	self._gotabitem = gohelper.findChild(self.viewGO, "#scroll_TabList/Viewport/Content/#go_tabitem")
	self._scrollProgress = gohelper.findChildScrollRect(self.viewGO, "#scroll_Progress")
	self._gocareerGroup = gohelper.findChild(self.viewGO, "#scroll_Progress/Viewport/Content/#go_careerGroup")
	self._gocareeritem = gohelper.findChild(self.viewGO, "#scroll_Progress/Viewport/Content/#go_careerGroup/#go_careeritem")
	self._godetailview = gohelper.findChild(self.viewGO, "#go_detailview")
	self._golefttop = gohelper.findChild(self.viewGO, "#go_lefttop")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_CareerHandBookMainView:addEvents()
	self._btncheck:AddClickListener(self._btncheckOnClick, self)
	self:addEventCb(Rouge2_OutsideController.instance, Rouge2_OutsideEvent.OnSelectHandBookCareer, self.onSelectTabItem, self)
	self:addEventCb(Rouge2_OutsideController.instance, Rouge2_OutsideEvent.OnSelectHandBookTalent, self.onSelectHandBookTalent, self)
	self:addEventCb(Rouge2_OutsideController.instance, Rouge2_OutsideEvent.OnUpdateCommonTalent, self.refreshTalentGroup, self)
end

function Rouge2_CareerHandBookMainView:removeEvents()
	self._btncheck:RemoveClickListener()
	self:removeEventCb(Rouge2_OutsideController.instance, Rouge2_OutsideEvent.OnSelectHandBookCareer, self.onSelectTabItem, self)
	self:removeEventCb(Rouge2_OutsideController.instance, Rouge2_OutsideEvent.OnSelectHandBookTalent, self.onSelectHandBookTalent, self)
	self:removeEventCb(Rouge2_OutsideController.instance, Rouge2_OutsideEvent.OnUpdateCommonTalent, self.refreshTalentGroup, self)
end

function Rouge2_CareerHandBookMainView:_btnClickOnClick()
	return
end

function Rouge2_CareerHandBookMainView:_btnclickOnClick()
	return
end

function Rouge2_CareerHandBookMainView:_btncheckOnClick()
	local param = {}

	param.careerId = self._curCareerId

	ViewMgr.instance:openView(ViewName.Rouge2_CareerHandBookTransferView, param)
end

function Rouge2_CareerHandBookMainView:_editableInitView()
	self._groupItemList = {}
	self._groupUseItemList = {}
	self._tabItemList = {}
	self._tabMoList = {}

	gohelper.setActive(self._gocareerGroup, false)

	self.animator = gohelper.findChildComponent(self.viewGO, "", gohelper.Type_Animator)
	self.levelAnimator = gohelper.findChildComponent(self.viewGO, "Level", gohelper.Type_Animator)
end

function Rouge2_CareerHandBookMainView:onSelectTabItem(mo, hideAnim)
	self._curCareerId = mo.careerId

	self:selectTabItem(mo.careerId)

	if not hideAnim then
		AudioMgr.instance:trigger(AudioEnum.Rouge2.play_ui_dungeon3_2_orchclick)
		self.animator:Play("switch", 0, 0)

		local delayTime = Rouge2_OutsideEnum.CareerSwitchRefreshTime

		TaskDispatcher.runDelay(self.onSwitchAnimPlayFinish, self, delayTime)
		Rouge2_OutsideController.instance:lockScreen(true, delayTime)
	else
		self:refreshTalentGroup()
	end
end

function Rouge2_CareerHandBookMainView:selectTabItem(selectId)
	for _, item in ipairs(self._tabItemList) do
		item:onSelect(selectId == item._mo.careerId)
	end
end

function Rouge2_CareerHandBookMainView:onSwitchAnimPlayFinish()
	Rouge2_OutsideController.instance:lockScreen(false)
	TaskDispatcher.cancelTask(self.onSwitchAnimPlayFinish, self)
	self:refreshTalentGroup()
end

function Rouge2_CareerHandBookMainView:onSelectHandBookTalent(talentId)
	if ViewMgr.instance:isOpen(ViewName.Rouge2_CareerHandBookDetailView) then
		return
	end

	Rouge2_TalentModel.instance:setCurTalentId(talentId)

	local viewParam = {}

	viewParam.parentGo = self._godetailview
	viewParam.talentId = talentId

	Rouge2_ViewHelper.openRougeCareerHandBookDetailView(viewParam)
end

function Rouge2_CareerHandBookMainView:onUpdateParam()
	return
end

function Rouge2_CareerHandBookMainView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.Rouge2.play_ui_dungeon3_2_guide)
	self:refreshUI()
end

function Rouge2_CareerHandBookMainView:refreshUI()
	self:refreshCareerTabItem()

	local firstMo = self._tabMoList[1]

	if firstMo then
		self:onSelectTabItem(firstMo, true)
	end
end

function Rouge2_CareerHandBookMainView:refreshCareerTabItem()
	local list = Rouge2_CareerConfig.instance:getAllCareerConfigs()

	for i, v in ipairs(list) do
		local mo = {
			id = i,
			careerId = v.id,
			config = v
		}

		table.insert(self._tabMoList, mo)
	end

	gohelper.CreateObjList(self, self.onTabItemShow, self._tabMoList, nil, self._gotabitem, Rouge2_CareerHandBookTabItem)
end

function Rouge2_CareerHandBookMainView:onTabItemShow(item, data, index)
	item:onUpdateMO(data)
	table.insert(self._tabItemList, item)
end

function Rouge2_CareerHandBookMainView:OnUpdateCommonTalent(geniusId)
	self:refreshTalentGroup()
end

function Rouge2_CareerHandBookMainView:refreshTalentGroup()
	local list = Rouge2_OutSideConfig.instance:getTalentConfigListByType(self._curCareerId)
	local result = {}
	local totalTalentCount = list and #list or 0

	gohelper.setActive(self._scrollProgress, totalTalentCount > 0)

	if totalTalentCount == 0 then
		return
	end

	local lastGroupIndex = math.floor((totalTalentCount - 1) / 3) + 1
	local curTalentId = list[totalTalentCount].geniusId
	local curLevel = list[totalTalentCount].order
	local nextTalentId
	local isFindNext = false

	for i, v in ipairs(list) do
		local groupId = math.floor((i - 1) / 3) + 1
		local groupMo

		if not result[groupId] then
			groupMo = {
				groupId = groupId,
				talentIdList = {},
				indexList = {},
				isLast = groupId == lastGroupIndex,
				careerId = self._curCareerId
			}

			table.insert(result, groupMo)
		else
			groupMo = result[groupId]
		end

		table.insert(groupMo.talentIdList, v.geniusId)
		table.insert(groupMo.indexList, i)

		if not isFindNext and not Rouge2_TalentModel.instance:isTalentActive(v.geniusId) then
			isFindNext = true
			curTalentId = v.geniusId
			curLevel = math.max(1, i - 1)

			local nextTalentConfig = Rouge2_OutSideConfig.instance:getTalentTypeConfigByTalentId(curTalentId)

			if nextTalentConfig then
				nextTalentId = nextTalentConfig.geniusId
			end
		end
	end

	self._curTalentId = curTalentId
	self._nextTalentId = nextTalentId
	self._curLevel = curLevel

	tabletool.clear(self._groupUseItemList)

	for i = 1, lastGroupIndex do
		local groupItem

		if not self._groupItemList[i] then
			local groupItemGo = gohelper.cloneInPlace(self._gocareerGroup, tostring(i))

			groupItem = MonoHelper.addNoUpdateLuaComOnceToGo(groupItemGo, Rouge2_CareerHandBookGroupItem)

			table.insert(self._groupItemList, groupItem)
		else
			groupItem = self._groupItemList[i]
		end

		table.insert(self._groupUseItemList, groupItem)
		groupItem:setActive(true)
		groupItem:setInfo(result[i])
	end

	local itemCount = #self._groupItemList

	if lastGroupIndex < itemCount then
		for i = lastGroupIndex + 1, itemCount do
			local groupItem = self._groupItemList[i]

			groupItem:setActive(false)
		end
	end

	local isLevelUp, previousLevel = self:checkLevelUp()

	self:refreshCareerInfo()

	if isLevelUp then
		self:onLevelUp(previousLevel)
	end
end

function Rouge2_CareerHandBookMainView:refreshCareerInfo()
	self._curCareerConfig = Rouge2_CareerConfig.instance:getCareerConfig(self._curCareerId)
	self._curTalentConfig = Rouge2_OutSideConfig.instance:getTalentConfigById(self._curTalentId)
	self.typeConfig = Rouge2_OutSideConfig.instance:getTalentTypeConfigByTalentId(self._curTalentId)

	local curLevel = Rouge2_TalentModel.instance:getCareerLevel(self._curCareerId)

	self._txtlevel.text = tostring(curLevel)

	local curExp = Rouge2_TalentModel.instance:getCareerExp(self._curCareerId)
	local haveNextLevel = self._nextTalentId ~= nil
	local nextConfig = haveNextLevel and Rouge2_OutSideConfig.instance:getTalentTypeConfigByTalentId(self._nextTalentId) or self.typeConfig

	self._txtprogress.text = string.format("%s/%s", curExp, nextConfig.careerExp)
end

function Rouge2_CareerHandBookMainView:checkLevelUp()
	local curLevel = Rouge2_TalentModel.instance:getCareerLevel(self._curCareerId)
	local curExp = Rouge2_TalentModel.instance:getCareerExp(self._curCareerId)
	local gainExp = Rouge2_TalentModel.instance:getCareerGainExp(self._curCareerId)

	if gainExp and gainExp > 0 then
		local previousExp = math.max(0, curExp - gainExp)
		local previousLevel = Rouge2_TalentModel.instance:getCareerLevelByExp(previousExp)

		if previousLevel < curLevel then
			logNormal("肉鸽2 当前职业技能升级 职业Id:" .. self._curCareerId .. " 先前等级: " .. previousLevel .. " 当前等级: " .. curLevel)

			return true, previousLevel
		end
	end

	return false, nil
end

function Rouge2_CareerHandBookMainView:onLevelUp(previousLevel)
	Rouge2_OutsideController.instance:lockScreen(true, Rouge2_OutsideEnum.CareerLevelUpTime)
	self.levelAnimator:Play("levelup", 0, 0)
	TaskDispatcher.runDelay(self.onLevelUpAnimFinish, self, Rouge2_OutsideEnum.CareerLevelUpTime)

	local param = {}

	param.previousLevel = previousLevel
	param.careerId = self._curCareerId

	Rouge2_OutsideController.instance:dispatchEvent(Rouge2_OutsideEvent.OnLevelUpAnimStart, param)
end

function Rouge2_CareerHandBookMainView:onLevelUpAnimFinish()
	self.levelAnimator:Play("idle", 0, 0)
	Rouge2_OutsideController.instance:lockScreen(false, Rouge2_OutsideEnum.CareerLevelUpTime)
	Rouge2_OutsideController.instance:dispatchEvent(Rouge2_OutsideEvent.OnLevelUpAnimFinish, self._curCareerId)
	Rouge2_TalentModel.instance:clearCareerGainExp(self._curCareerId)
	TaskDispatcher.cancelTask(self.onLevelUpAnimFinish, self)
end

function Rouge2_CareerHandBookMainView:onClose()
	Rouge2_TalentModel.instance:setCurTalentId(nil)
	TaskDispatcher.cancelTask(self.onSwitchAnimPlayFinish, self)
	TaskDispatcher.cancelTask(self.onLevelUpAnimFinish, self)
end

function Rouge2_CareerHandBookMainView:onDestroyView()
	return
end

return Rouge2_CareerHandBookMainView
