-- chunkname: @modules/logic/versionactivity4_1/act248/view/clue/Act248ClueCategoryChildItem.lua

module("modules.logic.versionactivity4_1.act248.view.clue.Act248ClueCategoryChildItem", package.seeall)

local Act248ClueCategoryChildItem = class("Act248ClueCategoryChildItem", ListScrollCellExtend)

function Act248ClueCategoryChildItem:onInitView()
	self._gonormal = gohelper.findChild(self.viewGO, "#go_normal")
	self._goselect = gohelper.findChild(self.viewGO, "#go_select")
	self._gofinished = gohelper.findChild(self.viewGO, "#go_finished")
	self._gowrong = gohelper.findChild(self.viewGO, "#go_wrong")
	self._golocked = gohelper.findChild(self.viewGO, "#go_locked")
	self._txtlocked = gohelper.findChildText(self.viewGO, "#go_locked/txt")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_click")
	self._simgicon = gohelper.findChildSingleImage(self.viewGO, "bg/#icon")
	self._gofinishedbg = gohelper.findChild(self.viewGO, "#go_finished/Image")
	self._goreddot = gohelper.findChild(self.viewGO, "reddot")
	self._gobg = gohelper.findChild(self.viewGO, "bg")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Act248ClueCategoryChildItem:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function Act248ClueCategoryChildItem:removeEvents()
	self._btnclick:RemoveClickListener()
end

function Act248ClueCategoryChildItem:_btnclickOnClick()
	if not self._isUnlock then
		local lockInfo = self._mo:getLockInfo()

		if lockInfo then
			local param = lockInfo.lockName

			ToastController.instance:showToast(Act248Enum.Toast.ClueLock, param)
		end

		return
	end

	if self._isSelect then
		return
	end

	local clueId = self._mo:getClueId()

	self.viewContainer:showClueInfo(clueId, Act248Enum.ClueInfoSwitchDelayTime)
	Act248Controller.instance:dispatchEvent(Act248Event.onClickClueItem, clueId)
	self:_refreshNew()

	local isNew = self._mo:isNew()

	if isNew and self._isSelect then
		self._mo:cancelNew()
		Act248Controller.instance:dispatchEvent(Act248Event.OnRefreshNew)
	end
end

function Act248ClueCategoryChildItem:_editableInitView()
	self._nameItems = self:getUserDataTb_()

	table.insert(self._nameItems, gohelper.findChildText(self._gonormal, "txt_itemcn"))
	table.insert(self._nameItems, gohelper.findChildText(self._goselect, "txt_itemcn"))
	table.insert(self._nameItems, gohelper.findChildText(self._gofinished, "txt_itemcn"))
	table.insert(self._nameItems, gohelper.findChildText(self._gowrong, "txt_itemcn"))
	gohelper.setActive(self._goselect, false)
	gohelper.setActive(self._gofinished, false)
	gohelper.setActive(self._gowrong, false)

	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	RedDotController.instance:addRedDot(self._goreddot, RedDotEnum.DotNode.Act248Clue)
end

function Act248ClueCategoryChildItem:_editableAddEvents()
	self:addEventCb(Act248Controller.instance, Act248Event.OnRefreshNew, self._refreshNew, self)
end

function Act248ClueCategoryChildItem:_editableRemoveEvents()
	self:removeEventCb(Act248Controller.instance, Act248Event.OnRefreshNew, self._refreshNew, self)
end

function Act248ClueCategoryChildItem:onUpdateMO(mo, index)
	self._mo = mo
	self._index = index

	local co = mo:getConfig()

	self._isUnlock = mo:isUnlock()
	self._isHasIcon = not string.nilorempty(co.tabIcon)

	if self._isUnlock then
		local nameStr = self:_getClueName()

		for _, txt in ipairs(self._nameItems) do
			txt.text = nameStr
		end

		if self._isHasIcon then
			self._simgicon:LoadImage(mo:getTabIcon())
		end

		gohelper.setActive(self._simgicon.gameObject, self._isHasIcon)
	end

	gohelper.setActive(self._golocked, not self._isUnlock)
	gohelper.setActive(self._gonormal, self._isUnlock)
	gohelper.setActive(self._gobg, self._isUnlock)

	local showClueId = self.viewContainer:getSelectClueId()

	self._isSelect = self._mo.id == showClueId

	self:_refreshNew()
	self:_refreshLock()
end

function Act248ClueCategoryChildItem:_refreshLock()
	return
end

function Act248ClueCategoryChildItem:_getClueName()
	local co = self._mo:getConfig()

	return co.name
end

function Act248ClueCategoryChildItem:playAnim(isShow)
	if isShow ~= self._isShow then
		if isShow then
			gohelper.setActive(self.viewGO, true)
		end

		local aniName = isShow and Act248Enum.AniName.open or Act248Enum.AniName.close

		self._animator:Play(aniName, 0, 0)
	end

	self._isShow = isShow
end

function Act248ClueCategoryChildItem:onSelect(isSelect)
	self._isSelect = isSelect

	gohelper.setActive(self._gonormal, self._isUnlock and not isSelect)
	gohelper.setActive(self._goselect, self._isUnlock and isSelect)
	self:_refreshNew()
end

function Act248ClueCategoryChildItem:_refreshNew()
	local isNew = self._mo:isNew()

	gohelper.setActive(self._goreddot, isNew)
end

function Act248ClueCategoryChildItem:onDestroyView()
	self._simgicon:UnLoadImage()
end

return Act248ClueCategoryChildItem
