-- chunkname: @modules/logic/settings/view/SettingsDelUnusedResListItem.lua

module("modules.logic.settings.view.SettingsDelUnusedResListItem", package.seeall)

local SettingsDelUnusedResListItem = class("SettingsDelUnusedResListItem", ListScrollCellExtend)

function SettingsDelUnusedResListItem:onInitView()
	self._txtname1 = gohelper.findChildText(self.viewGO, "#go_selected/#txt_name")
	self._txtname2 = gohelper.findChildText(self.viewGO, "#go_unselected/#txt_name")
	self._txtsize1 = gohelper.findChildText(self.viewGO, "#go_selected/#txt_size")
	self._txtsize2 = gohelper.findChildText(self.viewGO, "#go_unselected/#txt_size")
	self._goselected = gohelper.findChild(self.viewGO, "#go_selected")
	self._gounselected = gohelper.findChild(self.viewGO, "#go_unselected")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SettingsDelUnusedResListItem:addEvents()
	return
end

function SettingsDelUnusedResListItem:removeEvents()
	return
end

function SettingsDelUnusedResListItem:_editableInitView()
	self._gotogclick = gohelper.findChild(self.viewGO, "#go_togclick")
	self._btn = gohelper.getClickWithAudio(self._gotogclick)
end

function SettingsDelUnusedResListItem:_editableAddEvents()
	self._btn:AddClickListener(self._onClick, self)
end

function SettingsDelUnusedResListItem:_editableRemoveEvents()
	self._btn:RemoveClickListener()
end

function SettingsDelUnusedResListItem:_onClick()
	self._view:selectCell(self._index, true)
end

function SettingsDelUnusedResListItem:onUpdateMO(mo)
	self._mo = mo
	self._txtname1.text = mo.txt
	self._txtname2.text = mo.txt
	self._txtsize1.text = mo.sizeStr
	self._txtsize2.text = mo.sizeStr
end

function SettingsDelUnusedResListItem:onSelect(isSelect)
	gohelper.setActive(self._goselected, isSelect)
	gohelper.setActive(self._gounselected, isSelect == false)

	if isSelect then
		SettingsVoicePackageController.instance:dispatchEvent(SettingsEvent.OnChangeSelecetDelUnusedRes, self._mo.type)
	end
end

function SettingsDelUnusedResListItem:onDestroyView()
	return
end

return SettingsDelUnusedResListItem
