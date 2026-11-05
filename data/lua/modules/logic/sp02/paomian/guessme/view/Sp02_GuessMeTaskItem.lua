-- chunkname: @modules/logic/sp02/paomian/guessme/view/Sp02_GuessMeTaskItem.lua

module("modules.logic.sp02.paomian.guessme.view.Sp02_GuessMeTaskItem", package.seeall)

local Sp02_GuessMeTaskItem = class("Sp02_GuessMeTaskItem", RougeSimpleItemBase)

function Sp02_GuessMeTaskItem:_btnClickOnClick()
	if self:isSelected() then
		return
	end

	if self._status == Sp02_GuessMeEnum.TaskStatus.Lock then
		GameFacade.showToast(ToastEnum.SP02GuessMeLock)

		return
	end

	AudioMgr.instance:trigger(AudioEnum3_10.PaoMian.GuessMeSwitchDay)
	Sp02_PaoMianController.instance:dispatchEvent(Sp02_GuessMeEvent.OnSelectGuessMeDay, self:index())
end

local kRed = 38506

function Sp02_GuessMeTaskItem:onUpdateMO(mo)
	Sp02_GuessMeTaskItem.super.onUpdateMO(self, mo)

	local dayStr = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("sp02_guessmeview_day"), self:index())
	local activityId = mo and mo.activityId
	local id = mo and mo.id
	local activityCo = self:_getActivityCo()

	self._status = self:_getTaskStatusStatus()

	gohelper.setActive(self._goLock, self:_isLocked())

	if self._preStatus == Sp02_GuessMeEnum.TaskStatus.Lock and self._status ~= Sp02_GuessMeEnum.TaskStatus.Lock then
		gohelper.setActive(self._goLock, true)
		self._animator:Play(UIAnimationName.Unlock, 0, 0)
	end

	self._txtSelectDay.text = dayStr
	self._txtUnselectDay.text = dayStr
	self._txtLockedDay.text = dayStr

	RedDotController.instance:addRedDot(self._goReddot, kRed, id)

	self._preStatus = self._status
end

function Sp02_GuessMeTaskItem:_id()
	return self._mo and self._mo.id or 0
end

function Sp02_GuessMeTaskItem:_actId()
	return self._mo and self._mo.activityId or 0
end

function Sp02_GuessMeTaskItem:_getActivityCo()
	return ActivityConfig.instance:getActivityCo(self:_actId())
end

function Sp02_GuessMeTaskItem:_getSignInfo()
	return Sp02_GuessMeModel.instance:getSignInfo(self:_actId(), self:_id())
end

function Sp02_GuessMeTaskItem:_getTaskStatusStatus()
	local info = self:_getSignInfo()

	return info and info:getStatus() or Sp02_GuessMeEnum.TaskStatus.Lock
end

function Sp02_GuessMeTaskItem:_isLocked()
	return self._status == Sp02_GuessMeEnum.TaskStatus.Lock
end

function Sp02_GuessMeTaskItem:_isClaimable()
	return self._status == Sp02_GuessMeEnum.TaskStatus.CanGet
end

function Sp02_GuessMeTaskItem:_isClaimed()
	return self._status == Sp02_GuessMeEnum.TaskStatus.Finish
end

function Sp02_GuessMeTaskItem:ctor(...)
	Sp02_GuessMeTaskItem.super.ctor(self, ...)

	self._status = Sp02_GuessMeEnum.TaskStatus.Lock
end

function Sp02_GuessMeTaskItem:_editableInitView()
	Sp02_GuessMeTaskItem.super._editableInitView(self)

	self._goSelect = gohelper.findChild(self.viewGO, "#go_Selected")
	self._goUnselect = gohelper.findChild(self.viewGO, "#go_UnSelected")
	self._goLock = gohelper.findChild(self.viewGO, "image_Locked")
	self._txtSelectDay = gohelper.findChildText(self.viewGO, "#go_Selected/txt_DateSelected")
	self._txtUnselectDay = gohelper.findChildText(self.viewGO, "#go_UnSelected/txt_DateUnSelected")
	self._txtLockedDay = gohelper.findChildText(self.viewGO, "image_Locked/txt_DateLocked")
	self._goReddot = gohelper.findChild(self.viewGO, "#go_reddot")
	self._btnClick = gohelper.findChildButtonWithAudio(self.viewGO, "btn_click")
	self._animator = self.viewGO:GetComponent(gohelper.Type_Animator)

	gohelper.setActive(self._goSelect, false)
	gohelper.setActive(self._goUnselect, false)
	gohelper.setActive(self._goLock, false)

	self._txtSelectDay.text = ""
	self._txtUnselectDay.text = ""
	self._txtLockedDay.text = ""
end

function Sp02_GuessMeTaskItem:_editableAddEvents()
	self._btnClick:AddClickListener(self._btnClickOnClick, self)
end

function Sp02_GuessMeTaskItem:_editableRemoveEvents()
	self._btnClick:RemoveClickListener()
end

function Sp02_GuessMeTaskItem:onSelect(isSelect)
	Sp02_GuessMeTaskItem.super.onSelect(self, isSelect)
	gohelper.setActive(self._goSelect, isSelect)
	gohelper.setActive(self._goUnselect, not isSelect and self._status ~= Sp02_GuessMeEnum.TaskStatus.Lock)
	self._animator:Play(UIAnimationName.Select, 0, 0)
end

function Sp02_GuessMeTaskItem:onDestroyView()
	Sp02_GuessMeTaskItem.super.onDestroyView(self)
end

return Sp02_GuessMeTaskItem
