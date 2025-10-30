﻿-- chunkname: @modules/logic/survival/view/map/SurvivalPreviewTeamView.lua

module("modules.logic.survival.view.map.SurvivalPreviewTeamView", package.seeall)

local SurvivalPreviewTeamView = class("SurvivalPreviewTeamView", SurvivalInitTeamView)

function SurvivalPreviewTeamView:onInitView()
	SurvivalPreviewTeamView.super.onInitView(self)

	self._gounselect = gohelper.findChild(self._root, "#btn_Assist/#go_State1")
	self._goselected = gohelper.findChild(self._root, "#btn_Assist/#go_State3")
	self._gofull = gohelper.findChild(self._root, "#btn_Assist/#go_State2")
	self._goherocontent = gohelper.findChild(self._root, "Team/Scroll View/Viewport/#go_content")
	self._txtheronum = gohelper.findChildTextMesh(self._root, "Team/Title/txt_Team/#txt_MemberNum")
	self._gonpccontent = gohelper.findChild(self._root, "Partner/Scroll View/Viewport/#go_content")
	self._txtnpcnum = gohelper.findChildTextMesh(self._root, "Partner/Title/txt_Partner/#txt_MemberNum")
	self._btnequip = gohelper.findChildButtonWithAudio(self._root, "Left/#btn_equip")
end

function SurvivalPreviewTeamView:addEvents()
	SurvivalPreviewTeamView.super.addEvents(self)
	self._btnequip:AddClickListener(self._btnequipOnClick, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, self._onViewClose, self)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnNPCInTeamChange, self._modifyNPCList, self)
end

function SurvivalPreviewTeamView:removeEvents()
	SurvivalPreviewTeamView.super.removeEvents(self)
	self._btnequip:RemoveClickListener()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, self._onViewClose, self)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnNPCInTeamChange, self._modifyNPCList, self)
end

function SurvivalPreviewTeamView:onOpen()
	MonoHelper.addNoUpdateLuaComOnceToGo(self._btnequip.gameObject, SurvivalEquipBtnComp)

	self._initGroupMo = SurvivalMapModel.instance:getInitGroup()

	self:_initHeroItemList()
	self:_updateHeroList()
	self:_initNPCItemList()
	self:_updateNPCList()
end

function SurvivalPreviewTeamView:onViewShow()
	self:_updateHeroList()
	self:_updateNPCList()
end

function SurvivalPreviewTeamView:_btnreturnOnClick()
	self.viewContainer:playAnim("go_map")
	self.viewContainer:preStep()
end

function SurvivalPreviewTeamView:_btnequipOnClick()
	SurvivalController.instance:openEquipView()
end

function SurvivalPreviewTeamView:_btnstartOnClick()
	if not next(self._initGroupMo.allSelectHeroMos) then
		GameFacade.showToast(ToastEnum.SurvivalNoHero)

		return
	end

	self:enterNextStep()
end

function SurvivalPreviewTeamView:enterNextStep()
	self.viewContainer:nextStep()
end

function SurvivalPreviewTeamView:_initHeroItemList()
	if self._heroItemList then
		return
	end

	self._heroItemList = self:getUserDataTb_()

	local path = self.viewContainer:getSetting().otherRes.initHeroItemSmall
	local canCarryNum = self._initGroupMo:getCarryHeroCount()
	local itemCount = math.max(canCarryNum, self._initGroupMo:getCarryHeroMax())

	for i = 1, itemCount do
		local itemGo = self:getResInst(path, self._goherocontent)

		itemGo.name = "item_" .. tostring(i)

		local item = MonoHelper.addNoUpdateLuaComOnceToGo(itemGo, SurvivalInitTeamHeroSmallItem)

		item:setIndex(i)
		item:setIsLock(canCarryNum < i)
		item:setParentView(self)
		table.insert(self._heroItemList, item)
	end
end

function SurvivalPreviewTeamView:_updateHeroList()
	local count = 0

	for i, heroItem in ipairs(self._heroItemList) do
		if not heroItem._isLock then
			local heroMo = self._initGroupMo.allSelectHeroMos[i]
			local showSelectEffect = self._isModify and heroMo and heroItem:getHeroMo() ~= heroMo

			heroItem:setTrialValue(heroMo and self._initGroupMo.assistHeroMo and heroMo == self._initGroupMo.assistHeroMo.heroMO)
			heroItem:onUpdateMO(heroMo)

			if showSelectEffect then
				heroItem:showSelectEffect()
			end

			if heroMo then
				count = count + 1
			end
		end
	end

	self._txtheronum.text = string.format("(%d/%d)", count, self._initGroupMo:getCarryHeroCount())

	self.viewContainer:setWeightNum()
end

function SurvivalPreviewTeamView:_initNPCItemList()
	if self._npcItemList then
		return
	end

	self._npcItemList = self:getUserDataTb_()

	local path = self.viewContainer:getSetting().otherRes.initNpcItemSmall
	local canCarryNum = self._initGroupMo:getCarryNPCCount()
	local itemCount = math.max(canCarryNum, self._initGroupMo:getCarryNPCMax())

	for i = 1, itemCount do
		local itemGo = self:getResInst(path, self._gonpccontent)

		itemGo.name = "item_" .. tostring(i)

		local item = MonoHelper.addNoUpdateLuaComOnceToGo(itemGo, SurvivalInitNPCSmallItem)

		item:setIndex(i)
		item:setIsLock(canCarryNum < i)
		item:setParentView(self)
		table.insert(self._npcItemList, item)
	end
end

function SurvivalPreviewTeamView:_updateNPCList()
	local count = 0

	for i, npcItem in ipairs(self._npcItemList) do
		if not npcItem._isLock then
			local npcMo = self._initGroupMo.allSelectNpcs[i]
			local showSelectEffect = self._isModify and npcMo and npcItem:getNpcMo() ~= npcMo

			npcItem:onUpdateMO(npcMo)

			if showSelectEffect then
				npcItem:showSelectEffect()
			end

			if npcMo then
				count = count + 1
			end
		end
	end

	self._txtnpcnum.text = string.format("(%d/%d)", count, self._initGroupMo:getCarryNPCCount())

	self.viewContainer:setWeightNum()
end

function SurvivalPreviewTeamView:_onViewClose(viewName)
	if viewName == ViewName.SurvivalInitHeroSelectView then
		self:_modifyHeroGroup()
	elseif viewName == ViewName.SurvivalNPCSelectView then
		self:_modifyNPCList()
	end
end

function SurvivalPreviewTeamView:_modifyHeroGroup()
	self._isModify = true

	self:_updateHeroList()

	self._isModify = false
end

function SurvivalPreviewTeamView:_modifyNPCList()
	self._isModify = true

	self:_updateNPCList()

	self._isModify = false
end

return SurvivalPreviewTeamView
