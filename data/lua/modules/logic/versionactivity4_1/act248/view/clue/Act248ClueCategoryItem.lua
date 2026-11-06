-- chunkname: @modules/logic/versionactivity4_1/act248/view/clue/Act248ClueCategoryItem.lua

module("modules.logic.versionactivity4_1.act248.view.clue.Act248ClueCategoryItem", package.seeall)

local Act248ClueCategoryItem = class("Act248ClueCategoryItem", ListScrollCellExtend)

function Act248ClueCategoryItem:onInitView()
	self._gounselected = gohelper.findChild(self.viewGO, "#go_unselected")
	self._goselected = gohelper.findChild(self.viewGO, "#go_selected")
	self._gochildcategory = gohelper.findChild(self.viewGO, "#go_childcategory")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_click")
	self._txtname1 = gohelper.findChildText(self.viewGO, "#go_unselected/txt_itemcn1")
	self._txtname2 = gohelper.findChildText(self.viewGO, "#go_selected/txt_itemcn2")
	self._gonum = gohelper.findChild(self.viewGO, "#go_num")
	self._txtnum = gohelper.findChildText(self.viewGO, "#go_num/#txt_num")
	self._goreddot = gohelper.findChild(self.viewGO, "reddot")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Act248ClueCategoryItem:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function Act248ClueCategoryItem:removeEvents()
	self._btnclick:RemoveClickListener()
end

function Act248ClueCategoryItem:_btnclickOnClick()
	Act248Controller.instance:dispatchEvent(Act248Event.onOpenClueCategory, self._mo.category, not self._isSelect)
end

function Act248ClueCategoryItem:_editableInitView()
	RedDotController.instance:addRedDot(self._goreddot, RedDotEnum.DotNode.Act248Clue)
end

function Act248ClueCategoryItem:_editableAddEvents()
	self:addEventCb(Act248Controller.instance, Act248Event.OnRefreshNew, self._refreshNew, self)
end

function Act248ClueCategoryItem:_editableRemoveEvents()
	self:removeEventCb(Act248Controller.instance, Act248Event.OnRefreshNew, self._refreshNew, self)
end

function Act248ClueCategoryItem:onUpdateMO(mo)
	self._mo = mo

	local co = Act248Config.instance:getCategoryCo(mo.category)

	self._txtname1.text = co.name
	self._txtname2.text = co.name
	self._correctClueIds = self.viewContainer.getCorrectClueDict and self.viewContainer:getCorrectClueDict()

	self:_refreshNew()
end

function Act248ClueCategoryItem:onSelect(isSelect)
	self._isSelect = isSelect

	gohelper.setActive(self._gounselected, not isSelect)
	gohelper.setActive(self._goselected, isSelect)
end

function Act248ClueCategoryItem:_getFileId()
	if self.viewContainer and self.viewContainer.viewParam then
		local fileMo = self.viewContainer.viewParam.fileMo

		return fileMo and fileMo.id
	end
end

function Act248ClueCategoryItem:getChildRoot()
	return self._gochildcategory
end

function Act248ClueCategoryItem:showNum(num)
	if num and num > 0 then
		self._txtnum.text = num
	end

	gohelper.setActive(self._gonum, num and num > 0)
end

function Act248ClueCategoryItem:_refreshNew()
	local isNew = false
	local clueList = Act248Model.instance:getClueListByCategory(self._mo.category)

	if clueList then
		local fileId = self:_getFileId()

		for _, mo in ipairs(clueList) do
			if mo:isShowInFile(fileId) and self:_checkIsHasNew(mo) then
				isNew = true

				break
			end
		end
	end

	gohelper.setActive(self._goreddot, isNew)
end

function Act248ClueCategoryItem:_checkIsHasNew(mo)
	local _mo = Act248Model.instance:getCoverOrOwnClueMo(mo, self._correctClueIds)

	if _mo and _mo:isUnlock() and _mo:isNew() then
		return true
	end
end

function Act248ClueCategoryItem:onDestroyView()
	return
end

return Act248ClueCategoryItem
