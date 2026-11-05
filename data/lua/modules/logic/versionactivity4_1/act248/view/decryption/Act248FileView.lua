-- chunkname: @modules/logic/versionactivity4_1/act248/view/decryption/Act248FileView.lua

module("modules.logic.versionactivity4_1.act248.view.decryption.Act248FileView", package.seeall)

local Act248FileView = class("Act248FileView", BaseView)

function Act248FileView:onInitView()
	self._gocaseitem = gohelper.findChild(self.viewGO, "root/#scroll_Case/Viewport/Content/#go_caseitem")
	self._golefttop = gohelper.findChild(self.viewGO, "#go_lefttop")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Act248FileView:addEvents()
	self:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
end

function Act248FileView:removeEvents()
	self:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
end

function Act248FileView:_editableInitView()
	self._fileItems = self:getUserDataTb_()

	gohelper.setActive(self._gocaseitem, false)
end

function Act248FileView:onUpdateParam()
	return
end

function Act248FileView:onOpen()
	self:_initFiles()
end

function Act248FileView:_initFiles()
	local model = Act248Model.instance:getFileModel()
	local list = model:getList()

	if list then
		for i, mo in ipairs(list) do
			local item = self:_getFileItem(i)

			item:onUpdateMO(mo)
		end
	end

	local count = list and #list or 0

	for i, item in ipairs(self._fileItems) do
		gohelper.setActive(item.viewGO, i <= count)

		if i <= count then
			item:refreshStatusAnim()
		end
	end
end

function Act248FileView:_onCloseViewFinish(viewName)
	if viewName == ViewName.Act248DecryptionMainView then
		for i, item in ipairs(self._fileItems) do
			item:refreshStatusAnim()
		end
	end
end

function Act248FileView:_getFileItem(index)
	local item = self._fileItems[index]

	if not item then
		local go = gohelper.cloneInPlace(self._gocaseitem)

		item = MonoHelper.addNoUpdateLuaComOnceToGo(go, Act248FileItem)
		self._fileItems[index] = item
	end

	return item
end

function Act248FileView:onClose()
	return
end

function Act248FileView:onDestroyView()
	return
end

return Act248FileView
