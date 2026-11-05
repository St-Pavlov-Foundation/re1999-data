-- chunkname: @modules/logic/versionactivity4_1/act248/view/decryption/Act248AnswerRoleItem.lua

module("modules.logic.versionactivity4_1.act248.view.decryption.Act248AnswerRoleItem", package.seeall)

local Act248AnswerRoleItem = class("Act248AnswerRoleItem", ListScrollCellExtend)

function Act248AnswerRoleItem:onInitView()
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_click")
	self._simageHead = gohelper.findChildSingleImage(self.viewGO, "selected/heroicon")
	self._goselect = gohelper.findChild(self.viewGO, "selected")
	self._gounselect = gohelper.findChild(self.viewGO, "unselect")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Act248AnswerRoleItem:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function Act248AnswerRoleItem:removeEvents()
	self._btnclick:RemoveClickListener()
end

function Act248AnswerRoleItem:_btnclickOnClick()
	return
end

function Act248AnswerRoleItem:_editableInitView()
	return
end

function Act248AnswerRoleItem:onUpdateMO(mo)
	self._mo = mo

	if not string.nilorempty(mo.co.icon) then
		self._simageHead:LoadImage(ResUrl.getHeadIconSmall(mo.co.icon))
	end

	self:refreshStatus()
end

function Act248AnswerRoleItem:onFill()
	self._mo:onFill(true)
	self:refreshStatus()
end

function Act248AnswerRoleItem:refreshStatus()
	local isFill = self._mo:isFill()

	gohelper.setActive(self._goselect.gameObject, isFill)
	gohelper.setActive(self._gounselect.gameObject, not isFill)
end

return Act248AnswerRoleItem
