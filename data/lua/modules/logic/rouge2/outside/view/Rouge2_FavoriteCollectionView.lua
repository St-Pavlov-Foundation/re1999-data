-- chunkname: @modules/logic/rouge2/outside/view/Rouge2_FavoriteCollectionView.lua

module("modules.logic.rouge2.outside.view.Rouge2_FavoriteCollectionView", package.seeall)

local Rouge2_FavoriteCollectionView = class("Rouge2_FavoriteCollectionView", BaseView)

function Rouge2_FavoriteCollectionView:onInitView()
	self._gocontent = gohelper.findChild(self.viewGO, "#go_content")
	self._gobottom = gohelper.findChild(self.viewGO, "#go_bottom")
	self._btnlist = gohelper.findChildButtonWithAudio(self.viewGO, "#go_bottom/#btn_list")
	self._golistselected = gohelper.findChild(self.viewGO, "#go_bottom/#btn_list/#go_list_selected")
	self._btnhandbook = gohelper.findChildButtonWithAudio(self.viewGO, "#go_bottom/#btn_handbook")
	self._gohandbookselected = gohelper.findChild(self.viewGO, "#go_bottom/#btn_handbook/#go_handbook_selected")
	self._golefttop = gohelper.findChild(self.viewGO, "#go_lefttop")
	self._gorougemapdetailcontainer = gohelper.findChild(self.viewGO, "#go_rougemapdetailcontainer")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_FavoriteCollectionView:addEvents()
	self._btnlist:AddClickListener(self._btnlistOnClick, self)
	self._btnhandbook:AddClickListener(self._btnhandbookOnClick, self)
end

function Rouge2_FavoriteCollectionView:removeEvents()
	self._btnlist:RemoveClickListener()
	self._btnhandbook:RemoveClickListener()
end

function Rouge2_FavoriteCollectionView:_btnlistOnClick()
	if self._listSelected then
		return
	end

	self.viewContainer:selectTabView(1)
	self:_setBtnListSelected(true)
end

function Rouge2_FavoriteCollectionView:_btnhandbookOnClick()
	if self._listSelected == false then
		return
	end

	self.viewContainer:selectTabView(2)
	self:_setBtnListSelected(false)
end

function Rouge2_FavoriteCollectionView:_editableInitView()
	self:_setBtnListSelected(true)
	gohelper.setActive(self._gobottom, Rouge2_OutsideModel.instance:passedLayerId(Rouge2_OutsideEnum.FirstLayerId))
end

function Rouge2_FavoriteCollectionView:_setBtnListSelected(value)
	self._listSelected = value

	gohelper.setActive(self._golistselected, value)
	gohelper.setActive(self._gohandbookselected, not value)
	gohelper.setActive(self._gorougemapdetailcontainer, value)
end

function Rouge2_FavoriteCollectionView:onUpdateParam()
	return
end

function Rouge2_FavoriteCollectionView:onOpen()
	if self.viewParam then
		local displayTab = self.viewParam.defaultTabIds and self.viewParam.defaultTabIds[2] or Rouge2_OutsideEnum.CollectionDisplayType.Collection

		self:_setBtnListSelected(displayTab == Rouge2_OutsideEnum.CollectionDisplayType.Collection)
	end
end

function Rouge2_FavoriteCollectionView:onClose()
	return
end

function Rouge2_FavoriteCollectionView:onDestroyView()
	return
end

return Rouge2_FavoriteCollectionView
