-- chunkname: @modules/logic/sodache/view/outside/SodacheTaskView.lua

module("modules.logic.sodache.view.outside.SodacheTaskView", package.seeall)

local SodacheTaskView = class("SodacheTaskView", BaseView)

function SodacheTaskView:onInitView()
	self._goTaskItem = gohelper.findChild(self.viewGO, "root/left/#go_TaskItem")
	self._scrollCategory = gohelper.findChildScrollRect(self.viewGO, "root/left/#scroll_Category")
	self._goCategoryContent = gohelper.findChild(self.viewGO, "root/left/#scroll_Category/#go_CategoryContent")
	self._scrollTaskInfo = gohelper.findChildScrollRect(self.viewGO, "root/right/#scroll_TaskInfo")
	self._txtName = gohelper.findChildText(self.viewGO, "root/right/#scroll_TaskInfo/Viewport/Content/Name/#txt_Name")
	self._txtTarget = gohelper.findChildText(self.viewGO, "root/right/#scroll_TaskInfo/Viewport/Content/Target/#txt_Target")
	self._txtDesc = gohelper.findChildText(self.viewGO, "root/right/#scroll_TaskInfo/Viewport/Content/Desc/#txt_Desc")
	self._scrollReward = gohelper.findChildScrollRect(self.viewGO, "root/right/#scroll_Reward")
	self._goCurrency = gohelper.findChild(self.viewGO, "root/right/#scroll_Reward/#go_Currency")
	self._txtCurrency = gohelper.findChildText(self.viewGO, "root/right/#scroll_Reward/#go_Currency/#txt_Currency")
	self._goCardItem = gohelper.findChild(self.viewGO, "root/right/#scroll_Reward/Viewport/Content/#go_CardItem")
	self._btnAccept = gohelper.findChildButtonWithAudio(self.viewGO, "root/right/#btn_Accept")
	self._btnSubmit = gohelper.findChildButtonWithAudio(self.viewGO, "root/right/#btn_Submit")
	self._btnAbandon = gohelper.findChildButtonWithAudio(self.viewGO, "root/right/#btn_Abandon")
	self._btnClaim = gohelper.findChildButtonWithAudio(self.viewGO, "root/right/#btn_Claim")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SodacheTaskView:addEvents()
	self._btnAccept:AddClickListener(self._btnAcceptOnClick, self)
	self._btnSubmit:AddClickListener(self._btnSubmitOnClick, self)
	self._btnAbandon:AddClickListener(self._btnAbandonOnClick, self)
	self._btnClaim:AddClickListener(self._btnClaimOnClick, self)
end

function SodacheTaskView:removeEvents()
	self._btnAccept:RemoveClickListener()
	self._btnSubmit:RemoveClickListener()
	self._btnAbandon:RemoveClickListener()
	self._btnClaim:RemoveClickListener()
end

local freshEvt = "refresh content"

function SodacheTaskView:_btnSubmitOnClick()
	if self.taskMo and self.canSubmit then
		SodacheOutsideRpc.instance:sendSodacheTaskSubmitRequest(self.taskMo.id)
	end
end

function SodacheTaskView:_btnAcceptOnClick()
	if self.taskMo then
		SodacheOutsideRpc.instance:sendSodacheTaskAcceptRequest({
			self.taskMo.id
		})
	end
end

function SodacheTaskView:_btnClaimOnClick()
	if self.taskMo then
		SodacheOutsideRpc.instance:sendSodacheTaskGainRewardRequest({
			self.taskMo.id
		})
	end
end

function SodacheTaskView:_btnAbandonOnClick()
	if self.taskMo then
		SodacheOutsideRpc.instance:sendSodacheTaskAbandonRequest({
			self.taskMo.id
		})
	end
end

function SodacheTaskView:_editableInitView()
	gohelper.setActive(self._goCardItem, false)

	self.cardItemList = {}
	self.taskItemMap = {}
	self.taskGroupMap = {}

	for _, type in pairs(SodacheEnum.TaskType) do
		local go = gohelper.findChild(self._goCategoryContent, "TaskGroup" .. type)

		if go then
			local groupItem = self:getUserDataTb_()

			groupItem.goTaskList = gohelper.findChild(go, "go_TaskList")
			self.taskGroupMap[type] = groupItem
		end
	end

	self.animRight = gohelper.findChildAnim(self.viewGO, "root/right")
	self.animRightEvent = self.animRight.gameObject:GetComponent(gohelper.Type_AnimationEventWrap)

	self.animRightEvent:AddEventListener(freshEvt, self._onFreshEnd, self)
end

function SodacheTaskView:onOpen()
	self:addEventCb(SodacheController.instance, SodacheEvent.OnTaskChange, self.onTaskChange, self)

	self.taskBox = SodacheModel.instance:getOutsideMo().taskBox

	local firstMo = self:refreshTask()

	if firstMo then
		self:_btnTaskOnClick(firstMo)
	end
end

function SodacheTaskView:onClose()
	self.animRightEvent:RemoveEventListener(freshEvt)
end

function SodacheTaskView:refreshTask()
	for _, item in pairs(self.taskItemMap) do
		gohelper.setActive(item.go, false)
	end

	local firstMo

	for k, mo in ipairs(self.taskBox.tasks) do
		local isReceive = mo.state == SodacheEnum.TaskState.Received

		if not firstMo and (not isReceive or k == #self.taskBox.tasks) then
			firstMo = mo
		end

		if not isReceive or mo.config.remove ~= 1 then
			local item = self.taskItemMap[mo.id]

			if not item then
				item = self:getUserDataTb_()

				local parent = self.taskGroupMap[mo.config.type].goTaskList
				local go = gohelper.clone(self._goTaskItem, parent, "taskItem" .. k)

				item.goUnselect = gohelper.findChild(go, "go_unselect")

				local txtNameU = gohelper.findChildText(go, "go_unselect/txt_name")

				txtNameU.text = mo.config.name
				item.goSelected = gohelper.findChild(go, "go_selected")

				gohelper.setActive(item.goSelected, false)

				local txtNameS = gohelper.findChildText(go, "go_selected/txt_name")

				txtNameS.text = mo.config.name

				local btnClick = gohelper.findChildButtonWithAudio(go, "btn_Click")

				item.goEffect = gohelper.findChild(go, "vx_select")
				item.go = go
				item.anim = gohelper.findComponentAnim(go)

				self:addClickCb(btnClick, self._btnTaskOnClick, self, mo)

				self.taskItemMap[mo.id] = item
			end

			gohelper.setActive(item.go, true)
		end
	end

	return firstMo
end

function SodacheTaskView:_btnTaskOnClick(taskMo, manual)
	if not manual and self.taskMo == taskMo then
		return
	end

	if self.taskMo then
		local item = self.taskItemMap[self.taskMo.id]

		item.anim:Play("unselect", 0, 0)
		gohelper.setActive(item.goUnselect, true)
		gohelper.setActive(item.goSelected, false)
		gohelper.setActive(item.goEffect, false)
	end

	local item = self.taskItemMap[taskMo.id]

	item.anim:Play("select", 0, 0)
	gohelper.setActive(item.goUnselect, false)
	gohelper.setActive(item.goSelected, true)
	gohelper.setActive(item.goEffect, true)

	self.taskMo = taskMo

	self.animRight:Play("refresh", 0, 0)
end

function SodacheTaskView:refreshTaskInfo()
	if not self.taskMo then
		return
	end

	local config = self.taskMo.config

	self._txtName.text = config.name

	if self.taskMo.state == SodacheEnum.TaskState.Processing or self.taskMo.state == SodacheEnum.TaskState.Finished then
		self._txtTarget.text = string.format("%s(%s/%s)", config.desc, self.taskMo.progress, config.maxProgress)
	else
		self._txtTarget.text = config.desc
	end

	self._txtDesc.text = config.desc1

	local drops = GameUtil.splitString2(config.rewardShow, true, ";", "&")
	local hasCoin = false
	local count = 0

	for k, v in ipairs(drops) do
		local cardMo = SodacheCardMo.Create(v[1])

		if v[1] == SodacheEnum.CurrencyId.Coin then
			hasCoin = true
			self._txtCurrency.text = string.format("%s%s%d", cardMo.serverMo.itemCo.name, luaLang("multiple"), v[2])
		elseif cardMo.serverMo.itemType == SodacheEnum.ItemType.Card then
			count = count + 1

			local cardItem = self.cardItemList[k]

			if not cardItem then
				local go = gohelper.cloneInPlace(self._goCardItem)

				cardItem = MonoHelper.addNoUpdateLuaComOnceToGo(go, SodacheCardItem)

				cardItem:showInfo()

				self.cardItemList[k] = cardItem
			end

			cardItem:updateMo(cardMo)
			gohelper.setActive(cardItem.go, true)
		end
	end

	gohelper.setActive(self._goCurrency, hasCoin)

	for i = count + 1, #self.cardItemList do
		gohelper.setActive(self.cardItemList[i].go, false)
	end

	gohelper.setActive(self._btnAccept, config.needAccept == 1 and self.taskMo.state == SodacheEnum.TaskState.Accept)
	gohelper.setActive(self._btnAbandon, config.abandon == 1 and self.taskMo.state == SodacheEnum.TaskState.Processing)
	gohelper.setActive(self._btnClaim, self.taskMo.state == SodacheEnum.TaskState.Finished)

	if config.listenerType == "submitItem" and self.taskMo.state == SodacheEnum.TaskState.Processing then
		local itemId = tonumber(config.listenerParam)
		local needCnt = config.maxProgress
		local hasCnt = SodacheUtil.getItemCount(itemId)

		self.canSubmit = needCnt <= hasCnt
		self._txtTarget.text = string.format("%s(%s/%s)", config.desc, hasCnt, needCnt)

		ZProj.UGUIHelper.SetGrayscale(self._btnSubmit.gameObject, not self.canSubmit)
		gohelper.setActive(self._btnSubmit, true)
	else
		self.canSubmit = false

		gohelper.setActive(self._btnSubmit, false)
	end
end

function SodacheTaskView:onTaskChange()
	local firstMo = self:refreshTask()

	if firstMo then
		self:_btnTaskOnClick(firstMo)
	end
end

function SodacheTaskView:_onFreshEnd()
	self:refreshTaskInfo()
end

return SodacheTaskView
