-- chunkname: @modules/logic/versionactivity4_1/act248/view/clue/Act248ClueDetailItem.lua

module("modules.logic.versionactivity4_1.act248.view.clue.Act248ClueDetailItem", package.seeall)

local Act248ClueDetailItem = class("Act248ClueDetailItem", ListScrollCellExtend)

function Act248ClueDetailItem:onInitView()
	self._txtname = gohelper.findChildText(self.viewGO, "namebg/#txt_name")
	self._gopicture = gohelper.findChild(self.viewGO, "#go_picture")
	self._scrolldesc = gohelper.findChildScrollRect(self.viewGO, "#go_cluedesc/#scroll_desc")
	self._txtdesc = gohelper.findChildText(self.viewGO, "#go_cluedesc/#scroll_desc/Viewport/Content/#txt_desc")
	self._txtdesc2 = gohelper.findChildText(self.viewGO, "#go_cluedesc/#scroll_desc/Viewport/Content/#txt_desc2")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Act248ClueDetailItem:addEvents()
	return
end

function Act248ClueDetailItem:removeEvents()
	return
end

function Act248ClueDetailItem:_editableInitView()
	return
end

function Act248ClueDetailItem:_editableAddEvents()
	return
end

function Act248ClueDetailItem:_editableRemoveEvents()
	return
end

function Act248ClueDetailItem:onUpdateMO(clueMo)
	if clueMo then
		local co = clueMo:getConfig()

		self._txtname.text = co.name
	end

	self._clueMo = clueMo

	self:refreshDesc()
end

function Act248ClueDetailItem:refreshDesc()
	if not self._clueMo then
		return
	end

	local co = self._clueMo:getConfig()

	self._txtdesc.text = co.desc

	if self.viewContainer and self.viewContainer.getSelectSlotGroupMo then
		local slotGroupMo = self.viewContainer:getSelectSlotGroupMo()

		if slotGroupMo then
			local slotMo = slotGroupMo:getSlotMoByClueId(self._clueMo.id)

			if slotMo and slotMo:getStatus() == Act248Enum.SlotFillStatus.Correct then
				local slotCo = slotMo:getConfig()

				self._txtdesc2.text = slotCo.clueText

				gohelper.setActive(self._txtdesc2, true)

				return
			end
		end
	end

	gohelper.setActive(self._txtdesc2, false)
end

function Act248ClueDetailItem:onDestroyView()
	return
end

return Act248ClueDetailItem
