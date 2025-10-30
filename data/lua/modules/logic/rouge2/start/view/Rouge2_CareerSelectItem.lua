﻿-- chunkname: @modules/logic/rouge2/start/view/Rouge2_CareerSelectItem.lua

module("modules.logic.rouge2.start.view.Rouge2_CareerSelectItem", package.seeall)

local Rouge2_CareerSelectItem = class("Rouge2_CareerSelectItem", ListScrollCell)

function Rouge2_CareerSelectItem:init(go)
	self.go = go
	self._goLocked = gohelper.findChild(self.go, "#go_Locked")
	self._goSelected = gohelper.findChild(self.go, "#go_Selected")
	self._goUnselected = gohelper.findChild(self.go, "#go_Unselected")
	self._imageIcon = gohelper.findChildImage(self.go, "#go_Selected/#image_Icon")
	self._txtName1 = gohelper.findChildText(self.go, "#go_Selected/#txt_Name")
	self._txtName2 = gohelper.findChildText(self.go, "#go_Unselected/#txt_Name")
	self._txtNameEn = gohelper.findChildText(self.go, "#go_Unselected/#txt_NameEn")
	self._goTag = gohelper.findChild(self.go, "#go_Tag")
	self._txtTag = gohelper.findChild(self.go, "#go_Tag/#txt_Tag")
	self._btnClick = gohelper.findChildButtonWithAudio(self.go, "#btn_Click", AudioEnum.Rouge2.SwitchCareer)
end

function Rouge2_CareerSelectItem:addEventListeners()
	self._btnClick:AddClickListener(self._btnClickOnClick, self)
end

function Rouge2_CareerSelectItem:removeEventListeners()
	self._btnClick:RemoveClickListener()
end

function Rouge2_CareerSelectItem:_btnClickOnClick()
	if not Rouge2_OutsideModel.instance:isUnlockCareer(self._careerId) then
		local remainSecond = Rouge2_OutsideModel.instance:getCareerUnlockRemainTime(self._careerId)

		if remainSecond and remainSecond > 0 then
			local timeStr = string.format("%s%s", TimeUtil.secondToRoughTime2(remainSecond))

			GameFacade.showToast(ToastEnum.Rouge2LockCareer, timeStr)
		end

		return
	end

	Rouge2_CareerSelectListModel.instance:selectCell(self._index, true)
end

function Rouge2_CareerSelectItem:onUpdateMO(careerCo)
	self._careerCo = careerCo
	self._careerId = careerCo and careerCo.id
	self._unlockRemainTime = Rouge2_OutsideModel.instance:getCareerUnlockRemainTime(self._careerId)
	self._isUnlock = Rouge2_OutsideModel.instance:isUnlockCareer(self._careerId)

	TaskDispatcher.cancelTask(self.refreshUnlockRemainTime, self)

	if self._unlockRemainTime and self._unlockRemainTime > 0 then
		TaskDispatcher.runRepeat(self.refreshUnlockRemainTime, self, 1)
	end

	self:refreshUI()
end

function Rouge2_CareerSelectItem:refreshUI()
	local careerName = self._careerCo and self._careerCo.name

	self._txtName1.text = careerName
	self._txtName2.text = careerName
	self._txtNameEn.text = self._careerCo and self._careerCo.nameEn

	gohelper.setActive(self._goLocked, not self._isUnlock)
	gohelper.setActive(self._goTag, self._careerCo and self._careerCo.isDifficult ~= 0)
	Rouge2_IconHelper.setCareerIcon(self._careerId, self._imageIcon, Rouge2_Enum.CareerIconSuffix.Tab)
end

function Rouge2_CareerSelectItem:refreshUnlockRemainTime()
	self._unlockRemainTime = Rouge2_OutsideModel.instance:getCareerUnlockRemainTime(self._careerId)
	self._isUnlock = Rouge2_OutsideModel.instance:isUnlockCareer(self._careerId)

	if not self._unlockRemainTime or self._unlockRemainTime <= 0 then
		TaskDispatcher.cancelTask(self.refreshUnlockRemainTime, self)
	end

	self:refreshUI()
end

function Rouge2_CareerSelectItem:onSelect(isSelect)
	gohelper.setActive(self._goSelected, isSelect)
	gohelper.setActive(self._goUnselected, not isSelect)
end

function Rouge2_CareerSelectItem:onDestroy()
	TaskDispatcher.cancelTask(self.refreshUnlockRemainTime, self)
end

return Rouge2_CareerSelectItem
