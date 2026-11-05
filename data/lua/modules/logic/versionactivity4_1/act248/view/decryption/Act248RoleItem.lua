-- chunkname: @modules/logic/versionactivity4_1/act248/view/decryption/Act248RoleItem.lua

module("modules.logic.versionactivity4_1.act248.view.decryption.Act248RoleItem", package.seeall)

local Act248RoleItem = class("Act248RoleItem", ListScrollCellExtend)

function Act248RoleItem:onInitView()
	self._simageHead = gohelper.findChildSingleImage(self.viewGO, "#simage_Head")
	self._gook = gohelper.findChild(self.viewGO, "#go_ok")
	self._txtname = gohelper.findChildText(self.viewGO, "#txt_name")
	self._btnClick = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Click")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Act248RoleItem:addEvents()
	self._btnClick:AddClickListener(self._btnClickOnClick, self)
end

function Act248RoleItem:removeEvents()
	self._btnClick:RemoveClickListener()
end

function Act248RoleItem:_btnClickOnClick()
	local isFill = self._mo:isFill()

	if isFill then
		return
	end

	Act248Controller.instance:dispatchEvent(Act248Event.onClickRoleItem, self._mo.id)
end

function Act248RoleItem:_editableInitView()
	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function Act248RoleItem:_editableAddEvents()
	self:addEventCb(Act248Controller.instance, Act248Event.onCorrectRole, self._onCorrectRole, self)
end

function Act248RoleItem:_editableRemoveEvents()
	self:removeEventCb(Act248Controller.instance, Act248Event.onCorrectRole, self._onCorrectRole, self)
end

function Act248RoleItem:onUpdateMO(mo)
	self._mo = mo
	self._txtname.text = mo.co.name

	if not string.nilorempty(mo.co.icon) then
		self._simageHead:LoadImage(ResUrl.getHeadIconSmall(mo.co.icon))
	end

	self:refreshStatus()
end

function Act248RoleItem:onSelect(isSelect)
	return
end

function Act248RoleItem:refreshStatus()
	local isFill = self._mo:isFill()

	gohelper.setActive(self._gook.gameObject, isFill)
end

function Act248RoleItem:_onCorrectRole(roleId, isCorrect)
	if self._animator and roleId == self._mo.id then
		local aniName = isCorrect and Act248Enum.AniName.finished or Act248Enum.AniName.wrong

		self._animator:Play(aniName, 0, 0)
	end
end

function Act248RoleItem:onDestroyView()
	self._simageHead:UnLoadImage()
end

return Act248RoleItem
