﻿-- chunkname: @modules/logic/rouge2/outside/view/Rouge2_CollectionListView.lua

module("modules.logic.rouge2.outside.view.Rouge2_CollectionListView", package.seeall)

local Rouge2_CollectionListView = class("Rouge2_CollectionListView", BaseView)

function Rouge2_CollectionListView:onInitView()
	self._simagefullbg = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_fullbg")
	self._scrollcollection = gohelper.findChildScrollRect(self.viewGO, "Left/#scroll_collection")
	self._gocontent = gohelper.findChild(self.viewGO, "Left/#scroll_collection/Viewport/#go_content")
	self._gotitle = gohelper.findChild(self.viewGO, "Left/#scroll_collection/#go_title")
	self._gosmalltitle = gohelper.findChild(self.viewGO, "Left/#go_smalltitle")
	self._imageicon = gohelper.findChildImage(self.viewGO, "Left/#go_smalltitle/#image_icon")
	self._txtTitle = gohelper.findChildText(self.viewGO, "Left/#go_smalltitle/#txt_Title")
	self._btnfilter = gohelper.findChildButtonWithAudio(self.viewGO, "Left/filter/#btn_filter")
	self._golayout = gohelper.findChild(self.viewGO, "Left/filter/#go_layout")
	self._gonormal = gohelper.findChild(self.viewGO, "Right/#go_normal")
	self._imageicon1 = gohelper.findChildSingleImage(self.viewGO, "Right/#go_normal/#image_icon1")
	self._txtcollectionname1 = gohelper.findChildText(self.viewGO, "Right/#go_normal/#txt_collectionname1")
	self._scrollcollectiondesc = gohelper.findChildScrollRect(self.viewGO, "Right/#go_normal/#scroll_collectiondesc")
	self._godescContent = gohelper.findChild(self.viewGO, "Right/#go_normal/#scroll_collectiondesc/Viewport/#go_descContent")
	self._btnblock = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#go_normal/#btn_block")
	self._golocked = gohelper.findChild(self.viewGO, "Right/#go_locked")
	self._txtlocked = gohelper.findChildText(self.viewGO, "Right/#go_locked/locked/#txt_locked")
	self._gounget = gohelper.findChild(self.viewGO, "Right/#go_unget")
	self._imageicon2 = gohelper.findChildSingleImage(self.viewGO, "Right/#go_unget/#image_icon2")
	self._gobasetags2 = gohelper.findChild(self.viewGO, "Right/#go_unget/tags/#go_basetags2")
	self._gobasetagitem2 = gohelper.findChild(self.viewGO, "Right/#go_unget/tags/#go_basetags2/#go_basetagitem2")
	self._goextratags2 = gohelper.findChild(self.viewGO, "Right/#go_unget/tags/#go_extratags2")
	self._goextratagitem2 = gohelper.findChild(self.viewGO, "Right/#go_unget/tags/#go_extratags2/#go_extratagitem2")
	self._gotips2 = gohelper.findChild(self.viewGO, "Right/#go_unget/tags/#go_tips2")
	self._txttagitem2 = gohelper.findChildText(self.viewGO, "Right/#go_unget/tags/#go_tips2/#txt_tagitem2")
	self._goshapecell2 = gohelper.findChild(self.viewGO, "Right/#go_unget/shape/#go_shapecell2")
	self._txtcollectionname2 = gohelper.findChildText(self.viewGO, "Right/#go_unget/#txt_collectionname2")
	self._btnshow = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_show")
	self._goitemdescmodeswitcher = gohelper.findChild(self.viewGO, "Right/#go_itemdescmodeswitcher")
	self._golefttop = gohelper.findChild(self.viewGO, "#go_lefttop")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_CollectionListView:addEvents()
	self._btnfilter:AddClickListener(self._btnfilterOnClick, self)
	self._btnblock:AddClickListener(self._btnblockOnClick, self)
	self._btnshow:AddClickListener(self._btnshowOnClick, self)
end

function Rouge2_CollectionListView:removeEvents()
	self._btnfilter:RemoveClickListener()
	self._btnblock:RemoveClickListener()
	self._btnshow:RemoveClickListener()
end

function Rouge2_CollectionListView:_btnblockOnClick()
	return
end

function Rouge2_CollectionListView:_btnshowOnClick()
	Rouge2_OutsideController.instance:openCollectionCollectView()
end

function Rouge2_CollectionListView:_btnfilterOnClick()
	local params = {
		confirmCallback = self.onConfirmTagFilterCallback,
		confirmCallbackObj = self,
		baseSelectMap = self._baseTagSelectMap,
		extraSelectMap = self._extraTagSelectMap
	}

	Rouge2_OutsideController.instance:openRougeCollectionFilterView(params)
end

function Rouge2_CollectionListView:onConfirmTagFilterCallback(baseTagMap, extraTagMap)
	self:filterCompositeList(baseTagMap, extraTagMap)
	self:refreshFilterButtonUI()
end

function Rouge2_CollectionListView:filterCompositeList(baseTagMap, extraTagMap)
	Rouge2_CollectionListModel.instance:onInitData(baseTagMap, extraTagMap, self._selectIndex)
end

function Rouge2_CollectionListView:refreshFilterButtonUI()
	local isFiltering = Rouge2_CollectionListModel.instance:isFiltering()

	self:_setFilterSelected(isFiltering)
end

function Rouge2_CollectionListView:_editableInitView()
	self._goUnselectLayout = gohelper.findChild(self._golayout.gameObject, "unselected")
	self._goSelectLayout = gohelper.findChild(self._golayout.gameObject, "selected")
	self._goUnselectFilter = gohelper.findChild(self._btnfilter.gameObject, "unselect")
	self._goSelectFilter = gohelper.findChild(self._btnfilter.gameObject, "select")
	self._cellModelTab = self:getUserDataTb_()
	self._baseTagSelectMap = {}
	self._extraTagSelectMap = {}

	self:_setFilterSelected(false)
	self:_setAllSelected(true)

	self._enchantList = {}
	self._itemInstTab = self:getUserDataTb_()
	self._gocontenttransform = self._gocontent.transform

	self._scrollcollection:AddOnValueChanged(self._onScrollChange, self)

	self._dropherogroup = gohelper.findChildDropdown(self.viewGO, "Left/filter/#go_layout")

	self._dropherogroup:AddOnValueChanged(self._onDropValueChanged, self)

	self._dropherogrouparrow = gohelper.findChild(self.viewGO, "Left/filter/#go_layout/selected/Label/go_arrow").transform
	self._dropgroupchildcount = self._goSelectLayout.transform.childCount
	self._selectIndex = 1

	local list = {
		luaLang("p_all"),
		luaLang("p_handbookequipviewfilterview_haveget"),
		luaLang("p_handbookequipviewfilterview_notget")
	}

	self._dropherogroup:ClearOptions()
	self._dropherogroup:AddOptions(list)
	self._dropherogroup:SetValue(self._selectIndex - 1)
	TaskDispatcher.runRepeat(self._checkDropArrow, self, 0)

	local goRight = gohelper.findChild(self.viewGO, "Right")

	self._rightAnimator = gohelper.onceAddComponent(goRight, gohelper.Type_Animator)
	self._aniamtor = gohelper.onceAddComponent(self.viewGO, gohelper.Type_Animator)
	self._txtDesc = gohelper.findChildTextMesh(self._godescContent, "txt_desc")
	self._baseTagSelectMap = {}
	self._extraTagSelectMap = {}

	Rouge2_CollectionListModel.instance:onInitData(self._baseTagSelectMap, self._extraTagSelectMap, self._selectIndex, true)
	self:addEventCb(Rouge2_OutsideController.instance, Rouge2_OutsideEvent.OnClickCollectionListItem, self._onClickCollectionListItem, self)
	self:addEventCb(Rouge2_OutsideController.instance, Rouge2_OutsideEvent.SwitchCollectionInfoType, self._onSwitchCollectionInfoType, self)
	self:_refreshSelectCollectionInfo()
	gohelper.setActive(self._gotitle, false)
	gohelper.setActive(self._imageicon.gameObject, false)
end

function Rouge2_CollectionListView:_onDropValueChanged(value)
	self._selectIndex = value + 1

	Rouge2_CollectionListModel.instance:onInitData(self._baseTagSelectMap, self._extraTagSelectMap, self._selectIndex)
	AudioMgr.instance:trigger(AudioEnum.UI.RougeFavoriteAudio7)
end

function Rouge2_CollectionListView:_checkDropArrow()
	local childCount = self._goSelectLayout.transform.childCount

	if childCount ~= self._dropDownChildCount then
		self._dropDownChildCount = childCount

		local isOpen = self._dropgroupchildcount ~= childCount

		transformhelper.setLocalScale(self._dropherogrouparrow, 1, isOpen and -1 or 1, 1)
	end
end

function Rouge2_CollectionListView:_onScrollChange()
	local y = recthelper.getAnchorY(self._gocontenttransform)
	local model = Rouge2_CollectionListModel.instance
	local typeMap = model:getTypeHeightMap()
	local typeList = model:getTypeList()
	local curType

	for i, v in ipairs(typeList) do
		local type = v.type
		local height = (typeMap[type] or 0) + 48

		if height < y then
			curType = type
		else
			break
		end
	end

	curType = curType or model:getFirstType() or typeList[1].type

	local showTitle = curType ~= nil and #Rouge2_CollectionListModel.instance:getList() > 0

	gohelper.setActive(self._gosmalltitle, showTitle)

	if showTitle then
		local tagConfig = Rouge2_CollectionConfig.instance:getTagConfig(tonumber(curType))

		if not tagConfig then
			return
		end

		self._txtTitle.text = tagConfig.name
	end
end

function Rouge2_CollectionListView:_setFilterSelected(value)
	self._isFilterSelected = value

	gohelper.setActive(self._goSelectFilter, value)
	gohelper.setActive(self._goUnselectFilter, not value)
end

function Rouge2_CollectionListView:_setAllSelected(value)
	self._isAllSelected = value

	gohelper.setActive(self._goSelectLayout, value)
	gohelper.setActive(self._goUnselectLayout, not value)
end

function Rouge2_CollectionListView:_onClickCollectionListItem()
	self._rightAnimator:Play("switch", 0, 0)

	local collectionConfig = Rouge2_CollectionListModel.instance:getSelectedConfig()

	if collectionConfig then
		AudioMgr.instance:trigger(AudioEnum.Rouge2.play_ui_dungeon3_2_choose_4)
	end

	TaskDispatcher.cancelTask(self._refreshSelectCollectionInfo, self)
	TaskDispatcher.runDelay(self._refreshSelectCollectionInfo, self, Rouge2_OutsideEnum.CollectionListViewDelayTime)
end

function Rouge2_CollectionListView:_refreshSelectCollectionInfo()
	local collectionConfig = Rouge2_CollectionListModel.instance:getSelectedConfig()

	if not collectionConfig then
		return
	end

	self._collectionConfig = collectionConfig

	local isUnlock = Rouge2_OutsideModel.instance:collectionIsUnlock(collectionConfig.id)
	local isPass = Rouge2_OutsideModel.instance:collectionIsPass(collectionConfig.id)
	local showNormal = isUnlock and isPass
	local showLocked = not isUnlock
	local showUnget = isUnlock and not isPass

	gohelper.setActive(self._gonormal, showNormal)
	gohelper.setActive(self._golocked, showLocked)
	gohelper.setActive(self._gounget, showUnget)

	if showNormal then
		self:refreshNormalInfo()
	end

	if showLocked then
		self:refreshUnlockInfo()
	end

	if showUnget then
		self:refreshUnGetInfo()
	end
end

function Rouge2_CollectionListView:refreshNormalInfo()
	local config = self._collectionConfig

	Rouge2_CollectionHelper.setItemIcon(self._imageicon1, config.id)

	self._txtcollectionname1.text = config.name

	self:_onSwitchCollectionInfoType()
end

function Rouge2_CollectionListView:refreshUnlockInfo()
	self._txtlocked.text = ""
end

function Rouge2_CollectionListView:refreshUnGetInfo()
	local config = self._collectionConfig

	Rouge2_CollectionHelper.setItemIcon(self._imageicon2, config.id)

	self._txtcollectionname2.text = config.name
end

function Rouge2_CollectionListView:_onSwitchCollectionInfoType()
	local infoType = Rouge2_OutsideModel.instance:getCurCollectionInfoType()
	local config = self._collectionConfig
	local isSimple = infoType == Rouge2_OutsideEnum.CollectionInfoType.Simple
	local model = isSimple and Rouge2_Enum.ItemDescMode.Simply or Rouge2_Enum.ItemDescMode.Full

	Rouge2_ItemDescHelper.setItemDescStr(Rouge2_Enum.ItemDataType.Config, config.id, self._txtDesc, model)
end

function Rouge2_CollectionListView:onOpen()
	self._aniamtor:Play("open", 0, 0)
	self:_onScrollChange()
end

function Rouge2_CollectionListView:onClose()
	return
end

function Rouge2_CollectionListView:onDestroyView()
	self._scrollcollection:RemoveOnValueChanged()
	self._dropherogroup:RemoveOnValueChanged()
	TaskDispatcher.cancelTask(self._checkDropArrow, self)
	TaskDispatcher.cancelTask(self._refreshSelectCollectionInfo, self)
end

return Rouge2_CollectionListView
