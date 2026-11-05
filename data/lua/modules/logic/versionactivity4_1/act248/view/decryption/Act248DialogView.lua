-- chunkname: @modules/logic/versionactivity4_1/act248/view/decryption/Act248DialogView.lua

module("modules.logic.versionactivity4_1.act248.view.decryption.Act248DialogView", package.seeall)

local Act248DialogView = class("Act248DialogView", BaseView)

function Act248DialogView:onInitView()
	self._goslot = gohelper.findChild(self.viewGO, "root/#go_slot/#go_dialogue")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_slot/#go_dialogue/#btn_click")
	self._txtcontent = gohelper.findChildText(self.viewGO, "root/#go_slot/#go_dialogue/container/go_normalcontent/txt_contentcn")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Act248DialogView:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function Act248DialogView:removeEvents()
	self._btnclick:RemoveClickListener()
end

function Act248DialogView:_btnclickOnClick()
	self._dialogIndex = self._dialogIndex + 1

	self:_showDialog()
end

function Act248DialogView:_editableInitView()
	return
end

function Act248DialogView:onOpen()
	gohelper.setActive(self._goslot, false)
end

function Act248DialogView:showDialogs(list)
	self._dialogList = list
	self._dialogIndex = 1

	self:_showDialog()
	gohelper.setActive(self._goslot, true)
end

function Act248DialogView:_showDialog()
	local dialog = self._dialogList[self._dialogIndex]

	if not dialog then
		self:_onFinishDialog()

		return
	end

	self._txtcontent.text = dialog
end

function Act248DialogView:_onFinishDialog()
	self.viewContainer:onFinishDialog()
	gohelper.setActive(self._goslot, false)
end

function Act248DialogView:onClose()
	return
end

function Act248DialogView:onDestroyView()
	return
end

return Act248DialogView
