﻿-- chunkname: @modules/logic/season/view/SeasonEquipComposeView.lua

module("modules.logic.season.view.SeasonEquipComposeView", package.seeall)

local SeasonEquipComposeView = class("SeasonEquipComposeView", BaseView)

function SeasonEquipComposeView:onInitView()
	self._simagebg1 = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_bg1")
	self._scrollcardlist = gohelper.findChildScrollRect(self.viewGO, "left/mask/#scroll_cardlist")
	self._goempty = gohelper.findChild(self.viewGO, "left/#go_empty")
	self._simagelight = gohelper.findChildSingleImage(self.viewGO, "right/composecontain/#simage_light")
	self._gocard1 = gohelper.findChild(self.viewGO, "right/composecontain/cards/#go_card1")
	self._gocard2 = gohelper.findChild(self.viewGO, "right/composecontain/cards/#go_card2")
	self._gocard3 = gohelper.findChild(self.viewGO, "right/composecontain/cards/#go_card3")
	self._btncompose = gohelper.findChildButtonWithAudio(self.viewGO, "right/#btn_compose")
	self._btndiscompose = gohelper.findChildButtonWithAudio(self.viewGO, "right/#btn_discompose")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SeasonEquipComposeView:addEvents()
	self._btncompose:AddClickListener(self._btncomposeOnClick, self)
	self._btndiscompose:AddClickListener(self._btndiscomposeOnClick, self)
end

function SeasonEquipComposeView:removeEvents()
	self._btncompose:RemoveClickListener()
	self._btndiscompose:RemoveClickListener()
end

SeasonEquipComposeView.MaxUICount = 3

function SeasonEquipComposeView:_editableInitView()
	self._simagebg1:LoadImage(ResUrl.getSeasonIcon("full/hechengye_bj.jpg"))
	self._simagelight:LoadImage(ResUrl.getSeasonIcon("hecheng_guang.png"))

	self._txtHint = gohelper.findChildText(self.viewGO, "right/tip")
	self._matItems = {}
end

function SeasonEquipComposeView:onDestroyView()
	self._simagebg1:UnLoadImage()

	for i, item in pairs(self._matItems) do
		gohelper.setActive(item.goIcon, true)

		if item.icon then
			item.icon:disposeUI()
		end
	end

	Activity104EquipComposeController.instance:onCloseView()
end

function SeasonEquipComposeView:onOpen()
	local actId = self.viewParam.actId

	Activity104EquipComposeController.instance:onOpenView(actId)
	self:addEventCb(Activity104EquipComposeController.instance, Activity104Event.OnComposeDataChanged, self.handleComposeDataChanged, self)
	self:addEventCb(Activity104EquipComposeController.instance, Activity104Event.OnComposeSuccess, self.handleComposeSucc, self)
	self:refreshUI()
end

function SeasonEquipComposeView:onClose()
	UIBlockMgrExtend.setNeedCircleMv(true)
	UIBlockMgr.instance:endBlock(SeasonEquipComposeView.Compose_Anim_Block_Key)
	TaskDispatcher.cancelTask(self.onPlayComposeAnimOver, self)
	TaskDispatcher.cancelTask(self.delayRefreshView, self)
end

function SeasonEquipComposeView:handleComposeSucc()
	return
end

function SeasonEquipComposeView:handleComposeDataChanged()
	if self._delayRefreshUITime ~= nil then
		local curTime = Time.time

		if curTime - self._delayRefreshUITime < SeasonEquipComposeView.DelayRefreshTime then
			return
		end
	end

	self:refreshUI()
end

function SeasonEquipComposeView:refreshUI()
	local list = Activity104EquipItemComposeModel.instance:getList()

	gohelper.setActive(self._goempty, not list or #list == 0)
	self:refreshButtons()
	self:refreshHint()
	self:refreshMatList()
end

function SeasonEquipComposeView:refreshHint()
	local hintStr = luaLang("season_compose_hint1")
	local needHint1 = true

	if Activity104EquipItemComposeModel.instance:existSelectedMaterial() then
		local rare = Activity104EquipItemComposeModel.instance:getSelectedRare()

		if rare == Activity104Enum.Rare_Orange or rare == Activity104Enum.MainRoleRare then
			needHint1 = false
		end
	end

	if not needHint1 then
		hintStr = luaLang("season_compose_hint2")
	end

	self._txtHint.text = hintStr
end

function SeasonEquipComposeView:refreshMatList()
	for i = 1, SeasonEquipComposeView.MaxUICount do
		self:refreshMat(i)
	end
end

function SeasonEquipComposeView:refreshButtons()
	local isMatReady = Activity104EquipItemComposeModel.instance:isMaterialAllReady()

	gohelper.setActive(self._btncompose, isMatReady)
	gohelper.setActive(self._btndiscompose, not isMatReady)
end

function SeasonEquipComposeView:refreshMat(index)
	local item = self:getOrCreateMatItem(index)
	local itemUid = Activity104EquipItemComposeModel.instance.curSelectMap[index]
	local isEmpty = itemUid == Activity104EquipItemComposeModel.EmptyUid

	gohelper.setActive(item.goIcon, not isEmpty)
	gohelper.setActive(item.goEmpty, isEmpty)

	if not isEmpty then
		self:checkCreateMatItemIcon(item, index)

		local itemMO = Activity104EquipItemComposeModel.instance:getEquipMO(itemUid)

		item.icon:updateData(itemMO.itemId)
	end
end

function SeasonEquipComposeView:getOrCreateMatItem(index)
	local item = self._matItems[index]

	if not item then
		item = self:getUserDataTb_()
		item.go = gohelper.findChild(self.viewGO, "right/composecontain/cards/#go_card" .. tostring(index))
		item.goIcon = gohelper.findChild(item.go, "go_pos")
		item.goEmpty = gohelper.findChild(item.go, "go_empty")
		self._matItems[index] = item
	end

	return item
end

function SeasonEquipComposeView:checkCreateMatItemIcon(item, index)
	if not item.icon then
		local path = self.viewContainer:getSetting().otherRes[2]
		local go = self:getResInst(path, item.goIcon, "icon" .. tostring(index))

		item.icon = MonoHelper.addNoUpdateLuaComOnceToGo(go, SeasonCelebrityCardEquip)

		item.icon:setClickCall(self.onClickMatSlot, self, index)
		gohelper.setAsFirstSibling(go)
	end
end

function SeasonEquipComposeView:onClickMatSlot(index)
	local itemUid = Activity104EquipItemComposeModel.instance.curSelectMap[index]
	local isEmpty = itemUid == Activity104EquipItemComposeModel.EmptyUid

	if not isEmpty then
		Activity104EquipComposeController.instance:changeSelectCard(itemUid)
	end
end

function SeasonEquipComposeView:_btncomposeOnClick()
	if Activity104EquipComposeController.instance:checkMaterialHasEquiped() then
		local function yesFunc()
			self:playAnimBeforeSend()
		end

		GameFacade.showMessageBox(MessageBoxIdDefine.SeasonComposeMatIsEquiped, MsgBoxEnum.BoxType.Yes_No, yesFunc)
	else
		self:playAnimBeforeSend()
	end
end

function SeasonEquipComposeView:_btndiscomposeOnClick()
	GameFacade.showToast(ToastEnum.ClickSeasonDiscompose)
end

SeasonEquipComposeView.DelaySendTime = 1
SeasonEquipComposeView.DelayRefreshTime = 1
SeasonEquipComposeView.Compose_Anim_Block_Key = "Compose_Anim_Block"

function SeasonEquipComposeView:playAnimBeforeSend()
	TaskDispatcher.cancelTask(self.onPlayComposeAnimOver, self)

	local animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	animator:Play("hecherng", 0, 0)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock(SeasonEquipComposeView.Compose_Anim_Block_Key)
	TaskDispatcher.runDelay(self.onPlayComposeAnimOver, self, SeasonEquipComposeView.DelaySendTime)
end

function SeasonEquipComposeView:onPlayComposeAnimOver()
	UIBlockMgrExtend.setNeedCircleMv(true)
	UIBlockMgr.instance:endBlock(SeasonEquipComposeView.Compose_Anim_Block_Key)
	Activity104EquipComposeController.instance:sendCompose()

	self._delayRefreshUITime = Time.time

	TaskDispatcher.runDelay(self.delayRefreshView, self, SeasonEquipComposeView.DelayRefreshTime)
end

function SeasonEquipComposeView:delayRefreshView()
	self:refreshUI()
end

return SeasonEquipComposeView
