﻿-- chunkname: @modules/logic/season/view1_5/Season1_5EquipTagSelect.lua

module("modules.logic.season.view1_5.Season1_5EquipTagSelect", package.seeall)

local Season1_5EquipTagSelect = class("Season1_5EquipTagSelect", BaseView)

function Season1_5EquipTagSelect:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season1_5EquipTagSelect:addEvents()
	return
end

function Season1_5EquipTagSelect:removeEvents()
	return
end

function Season1_5EquipTagSelect:init(ctrl, dropListPath, defaultColor)
	self._controller = ctrl
	self._dropListPath = dropListPath
	self._defaultColor = defaultColor or "#cac8c5"
end

function Season1_5EquipTagSelect:_editableInitView()
	self._dropdowntag = gohelper.findChildDropdown(self.viewGO, self._dropListPath)
	self._txtlabel = gohelper.findChildText(self._dropdowntag.gameObject, "Label")
	self._imagearrow = gohelper.findChildImage(self._dropdowntag.gameObject, "arrow")

	self._dropdowntag:AddOnValueChanged(self.handleDropValueChanged, self)

	self._clicktag = gohelper.getClick(self._dropdowntag.gameObject)

	self._clicktag:AddClickListener(self.handleClickTag, self)
end

function Season1_5EquipTagSelect:onDestroyView()
	if self._dropdowntag then
		self._dropdowntag:RemoveOnValueChanged()

		self._dropdowntag = nil
	end

	if self._clicktag then
		self._clicktag:RemoveClickListener()

		self._clicktag = nil
	end
end

function Season1_5EquipTagSelect:onOpen()
	if self._controller.getFilterModel then
		self._model = self._controller:getFilterModel()
	end

	if not self._model then
		return
	end

	self._dropdowntag:ClearOptions()
	self._dropdowntag:AddOptions(self._model:getOptions())
	self._dropdowntag:SetValue(0)
	self:refreshSelected()
end

function Season1_5EquipTagSelect:onClose()
	return
end

function Season1_5EquipTagSelect:handleClickTag()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
end

function Season1_5EquipTagSelect:handleDropValueChanged(index)
	local selectIndex = index

	if self._controller.setSelectTag and self._model then
		self._controller:setSelectTag(selectIndex)
		AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
		self:refreshSelected()
	else
		logError("controller setSelectTag not implement!")
	end
end

function Season1_5EquipTagSelect:refreshSelected()
	local tagId = self._model:getCurTagId()
	local colorSelect

	if tagId == Activity104EquipTagModel.NoTagId then
		colorSelect = self._defaultColor
	else
		colorSelect = "#c66030"
	end

	self._txtlabel.color = GameUtil.parseColor(colorSelect)

	SLFramework.UGUI.GuiHelper.SetColor(self._imagearrow, colorSelect)
end

return Season1_5EquipTagSelect
