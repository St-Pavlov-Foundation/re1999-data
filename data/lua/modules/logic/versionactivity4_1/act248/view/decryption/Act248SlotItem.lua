-- chunkname: @modules/logic/versionactivity4_1/act248/view/decryption/Act248SlotItem.lua

module("modules.logic.versionactivity4_1.act248.view.decryption.Act248SlotItem", package.seeall)

local Act248SlotItem = class("Act248SlotItem", ListScrollCellExtend)

function Act248SlotItem:onInitView()
	self._gocluecard = gohelper.findChild(self.viewGO, "#go_cluecard")
	self._goempty = gohelper.findChild(self.viewGO, "#go_cluecard/#go_empty")
	self._goselect = gohelper.findChild(self.viewGO, "#go_cluecard/#go_select")
	self._gowrong = gohelper.findChild(self.viewGO, "#go_cluecard/#go_wrong")
	self._gofinished = gohelper.findChild(self.viewGO, "#go_cluecard/#go_finished")
	self._gofinishedicon = gohelper.findChild(self.viewGO, "#go_cluecard/#go_finished/icon")
	self._goname = gohelper.findChild(self.viewGO, "#go_cluecard/tag")
	self._txtname = gohelper.findChildText(self.viewGO, "#go_cluecard/tag/#txt_name")
	self._btnclickcharacter = gohelper.findChildButtonWithAudio(self.viewGO, "#go_cluecard/#btn_click_character")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Act248SlotItem:addEvents()
	self._btnclickcharacter:AddClickListener(self._btnclickcharacterOnClick, self)
end

function Act248SlotItem:removeEvents()
	self._btnclickcharacter:RemoveClickListener()
end

function Act248SlotItem:_btnclickcharacterOnClick()
	return
end

function Act248SlotItem:_editableInitView()
	gohelper.setActive(self._gocluecard, true)
	gohelper.setActive(self._goname, self:_isShowTag())

	self._rootItems = self:getUserDataTb_()

	for i = 1, 2 do
		local item = self:getUserDataTb_()

		item.goHas = gohelper.findChild(self.viewGO, "#go_cluecard/image_clueType" .. i)
		item.txtname = gohelper.findChildText(item.goHas, "txt_clue")

		gohelper.setActive(item.txtname.gameObject, false)

		item.simgicon = gohelper.findChildSingleImage(item.goHas.gameObject, "bg")
		self._rootItems[i] = item
	end

	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function Act248SlotItem:_editableAddEvents()
	return
end

function Act248SlotItem:_editableRemoveEvents()
	return
end

function Act248SlotItem:_isShowTag()
	return true
end

function Act248SlotItem:onShow(isShow)
	gohelper.setActive(self.viewGO, isShow)

	self._isShow = isShow

	if isShow then
		-- block empty
	end
end

function Act248SlotItem:isShow()
	return self._isShow
end

function Act248SlotItem:onUpdateMO()
	return
end

function Act248SlotItem:_isSingle()
	return
end

local EmptyPic = "v4a1_investigation_cardback_1"

function Act248SlotItem:_refreshStatus()
	local fillClueId = self:getCurFillClue()
	local isClue = fillClueId and fillClueId > 0
	local isSingle = self:_isSingle()
	local item1 = self._rootItems[1]
	local item2 = self._rootItems[2]

	if isClue then
		local clueMo = Act248Model.instance:getClueById(fillClueId)
		local clueCo = clueMo:getConfig()
		local isHasIcon = not string.nilorempty(clueCo.pic)
		local pic = clueCo.pic

		if not isHasIcon then
			pic = EmptyPic
			item1.txtname.text = clueCo.name
			item2.txtname.text = clueCo.name
		end

		item1.simgicon:LoadImage(ResUrl.getAct248ClueSingleBg(pic))
		item2.simgicon:LoadImage(ResUrl.getAct248ClueSingleBg(pic))
		gohelper.setActive(item1.txtname.gameObject, not isHasIcon)
		gohelper.setActive(item2.txtname.gameObject, not isHasIcon)
	else
		item1.simgicon:LoadImage(ResUrl.getAct248ClueSingleBg(EmptyPic))
		item2.simgicon:LoadImage(ResUrl.getAct248ClueSingleBg(EmptyPic))
	end

	gohelper.setActive(item1.goHas.gameObject, isSingle)
	gohelper.setActive(item2.goHas.gameObject, not isSingle)

	local status = self:_getStatus()

	gohelper.setActive(self._gofinished, isClue and status == Act248Enum.SlotFillStatus.Correct and not self._isHideStatus)
	gohelper.setActive(self._gofinishedicon, isClue and status == Act248Enum.SlotFillStatus.Correct and not self._isHideStatus)
	gohelper.setActive(self._gowrong, isClue and status == Act248Enum.SlotFillStatus.Error and not self._isHideStatus)
	gohelper.setActive(self._goempty, not isClue and not self._isHideStatus)
end

function Act248SlotItem:_getStatusAniName()
	local status = self:_getStatus()

	if status == Act248Enum.SlotFillStatus.Correct then
		return Act248Enum.AniName.finished
	end

	if status == Act248Enum.SlotFillStatus.Error then
		return Act248Enum.AniName.wrong
	end

	return Act248Enum.AniName.idle
end

function Act248SlotItem:_getStatus()
	return Act248Enum.SlotFillStatus.Normal
end

function Act248SlotItem:getCurFillClue()
	return self._fillClueId
end

function Act248SlotItem:setFillClue(clueId)
	if self._fillClueId == clueId then
		return
	end

	self._fillClueId = clueId

	self:_refreshStatus()
end

function Act248SlotItem:playAni(aniName, rate)
	self._animator:Play(aniName, 0, rate or 0)
end

function Act248SlotItem:checkCorrectFillAni(delayTime, isCorrectFill)
	self._isCorrectFill = isCorrectFill

	TaskDispatcher.cancelTask(self._correctFillAniCB, self)

	if delayTime > 0 then
		TaskDispatcher.runDelay(self._correctFillAniCB, self, delayTime)
	else
		self:_correctFillAniCB()
	end
end

function Act248SlotItem:_correctFillAniCB()
	local aniName = self._isCorrectFill and Act248Enum.AniName.finished or Act248Enum.AniName.wrong

	self:playAni(aniName)
	self:_refreshStatus()
	TaskDispatcher.cancelTask(self._resetStatus, self)

	if not self._isCorrectFill then
		TaskDispatcher.runDelay(self._resetStatus, self, 1)
	end
end

function Act248SlotItem:_resetStatus()
	self:playAni(Act248Enum.AniName.idle)
end

function Act248SlotItem:setHideStatus(isHide)
	self._isHideStatus = isHide
end

function Act248SlotItem:onDestroyView()
	self._rootItems[1].simgicon:UnLoadImage()
	self._rootItems[2].simgicon:UnLoadImage()
	TaskDispatcher.cancelTask(self._correctFillAniCB, self)
	TaskDispatcher.cancelTask(self._resetStatus, self)
end

return Act248SlotItem
