﻿-- chunkname: @modules/logic/rouge2/backpack/view/Rouge2_BackpackSkillEditItem.lua

module("modules.logic.rouge2.backpack.view.Rouge2_BackpackSkillEditItem", package.seeall)

local Rouge2_BackpackSkillEditItem = class("Rouge2_BackpackSkillEditItem", LuaCompBase)

function Rouge2_BackpackSkillEditItem:ctor(index)
	self._index = index
end

function Rouge2_BackpackSkillEditItem:init(go)
	self.go = go
	self._goEmpty = gohelper.findChild(self.go, "#go_Empty")
	self._goUnEmpty = gohelper.findChild(self.go, "#go_UnEmpty")
	self._btnAdd = gohelper.findChildButtonWithAudio(self.go, "#go_Empty/#btn_Add")
	self._simageSkillIcon = gohelper.findChildSingleImage(self.go, "#go_UnEmpty/#image_SkillIcon")
	self._goSelected = gohelper.findChild(self.go, "#go_Selected")
	self._goCapacity = gohelper.findChild(self.go, "#go_UnEmpty/#go_Capacity")
	self._goAssemblyList = gohelper.findChild(self.go, "#go_UnEmpty/#go_Capacity/#go_AssemblyList")
	self._goAssemblyItem = gohelper.findChild(self.go, "#go_UnEmpty/#go_Capacity/#go_AssemblyList/#go_AssemblyItem")
	self._btnSelect = gohelper.findChildButtonWithAudio(self.go, "#go_UnEmpty/#btn_Select")
	self._btnRemove = gohelper.findChildButtonWithAudio(self.go, "#go_UnEmpty/#btn_Remove", AudioEnum.Rouge2.RemoveActiveSkill)
	self._goBXSIcon = gohelper.findChild(self.go, "#go_sp")
	self._imageAttrIcon = gohelper.findChildImage(self.go, "#go_sp/#image_attricon")
	self._animator = gohelper.onceAddComponent(self.go, gohelper.Type_Animator)
	self._canvasgroup = gohelper.onceAddComponent(self.go, gohelper.Type_CanvasGroup)
	self._unemptyCanvasGroup = gohelper.onceAddComponent(self._goUnEmpty, gohelper.Type_CanvasGroup)
	self._tran = self.go.transform

	gohelper.setActive(self._goSelected, false)
	self:addEventCb(Rouge2_Controller.instance, Rouge2_Event.OnBeginDragSkill, self._onBeginDragSkill, self)
	self:addEventCb(Rouge2_Controller.instance, Rouge2_Event.OnEndDragSkill, self._onEndDragSkill, self)
	self:addEventCb(Rouge2_Controller.instance, Rouge2_Event.OnSelectActiveSkillHole, self._onSelectActiveSkillHole, self)
	self:addEventCb(Rouge2_Controller.instance, Rouge2_Event.OnUpdateActiveSkillInfo, self._onUpdateActiveSkillInfo, self)
end

function Rouge2_BackpackSkillEditItem:addEventListeners()
	self._btnAdd:AddClickListener(self._btnAddOnClick, self)
	self._btnSelect:AddClickListener(self._btnSelectOnClick, self)
	self._btnRemove:AddClickListener(self._btnRemoveOnClick, self)
end

function Rouge2_BackpackSkillEditItem:removeEventListeners()
	self._btnAdd:RemoveClickListener()
	self._btnSelect:RemoveClickListener()
	self._btnRemove:RemoveClickListener()
end

function Rouge2_BackpackSkillEditItem:_btnAddOnClick()
	if Rouge2_BackpackSkillEditListModel.instance:isDraging() then
		return
	end

	Rouge2_BackpackSkillEditListModel.instance:onSelectUseSkillIndex(self._index)
end

function Rouge2_BackpackSkillEditItem:_btnSelectOnClick()
	if Rouge2_BackpackSkillEditListModel.instance:isDraging() or self._isRemove then
		return
	end

	Rouge2_BackpackSkillEditListModel.instance:onSelectUseSkillIndex(self._index)

	local tipPos = Rouge2_Enum.SkillTipsPos.BackpackSkillEdit1

	Rouge2_ViewHelper.openCareerSkillTipsView(Rouge2_Enum.ItemDataType.Server, self._skillUid, tipPos, Rouge2_Enum.SkillTipsUsage.BackpackEditView_Left)
end

function Rouge2_BackpackSkillEditItem:_btnRemoveOnClick()
	self._isRemove = Rouge2_BackpackController.instance:tryRemoveActiveSkill(self._index)
end

function Rouge2_BackpackSkillEditItem:onUpdateMO()
	self:refreshInfo()
	self:refreshUI()
	self:refreshBXSIcon()
	self:playAnim()
end

function Rouge2_BackpackSkillEditItem:refreshInfo()
	self._isRemove = false
	self._canvasgroup.blocksRaycasts = true
	self._preIsEmpty = self._isEmpty
	self._skillMo = Rouge2_BackpackModel.instance:index2UseActiveSkill(self._index)
	self._skillUid = self._skillMo and self._skillMo:getUid()
	self._skillId = self._skillMo and self._skillMo:getItemId()
	self._isEmpty = not self._skillUid or self._skillUid == 0
end

function Rouge2_BackpackSkillEditItem:refreshUI()
	gohelper.setActive(self._goEmpty, self._isEmpty)
	gohelper.setActive(self._goUnEmpty, not self._isEmpty)

	if self._isEmpty then
		return
	end

	self._skillCo = Rouge2_CollectionConfig.instance:getActiveSkillConfig(self._skillId)

	local assemblyNum = self._skillCo and self._skillCo.assembleCost or 0

	gohelper.setActive(self._goCapacity, assemblyNum > 0)
	gohelper.CreateNumObjList(self._goAssemblyList, self._goAssemblyItem, assemblyNum, self._refreshAssemblyItem, self)
	Rouge2_IconHelper.setActiveSkillIcon(self._skillId, self._simageSkillIcon)
end

function Rouge2_BackpackSkillEditItem:_refreshAssemblyItem(obj, index)
	local goType1 = gohelper.findChild(obj, "go_Type1")
	local goType2 = gohelper.findChild(obj, "go_Type2")
	local useType1 = index % 2 ~= 0

	gohelper.setActive(goType1, useType1)
	gohelper.setActive(goType2, not useType1)
end

function Rouge2_BackpackSkillEditItem:refreshBXSIcon()
	local isUseBXS = Rouge2_Model.instance:isUseBXSCareer()

	gohelper.setActive(self._goBXSIcon, isUseBXS)

	if not isUseBXS then
		return
	end

	local attrIdList = Rouge2_MapConfig.instance:getBXSAttrIdList()
	local attrId = attrIdList and attrIdList[self._index]

	Rouge2_IconHelper.setAttributeIcon(attrId, self._imageAttrIcon)
end

function Rouge2_BackpackSkillEditItem:playAnim()
	if self._preIsEmpty == nil or self._preIsEmpty == self._isEmpty then
		return
	end

	if self._isEmpty then
		self._animator:Play("empty", 0, 0)
	else
		self._animator:Play("unempty", 0, 0)
	end
end

function Rouge2_BackpackSkillEditItem:_onSelectActiveSkillHole(index)
	gohelper.setActive(self._goSelected, self._index == index)
end

function Rouge2_BackpackSkillEditItem:_onUpdateActiveSkillInfo()
	self:refreshInfo()
	self:refreshUI()
	self:playAnim()
end

function Rouge2_BackpackSkillEditItem:getTran()
	return self._tran
end

function Rouge2_BackpackSkillEditItem:isScreenPosInRect(position)
	return recthelper.screenPosInRect(self._tran, nil, position.x, position.y)
end

function Rouge2_BackpackSkillEditItem:getSkillMo()
	return self._skillMo
end

function Rouge2_BackpackSkillEditItem:_onBeginDragSkill(uid)
	if self._skillUid ~= uid then
		return
	end

	self._canvasgroup.blocksRaycasts = false

	self._animator:Play("empty", 0, 0)
	gohelper.setActive(self._goEmpty, true)
	gohelper.setActive(self._goUnEmpty, false)
end

function Rouge2_BackpackSkillEditItem:_onEndDragSkill(uid, isSuccess)
	if self._skillUid ~= uid then
		return
	end

	if isSuccess then
		return
	end

	self._canvasgroup.blocksRaycasts = true

	self._animator:Play("unempty", 0, 0)
	gohelper.setActive(self._goEmpty, false)
	gohelper.setActive(self._goUnEmpty, true)
end

function Rouge2_BackpackSkillEditItem:onDestroy()
	self._simageSkillIcon:UnLoadImage()
end

return Rouge2_BackpackSkillEditItem
