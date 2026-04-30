-- chunkname: @modules/logic/fight/view/FightDeviceSwitchView.lua

module("modules.logic.fight.view.FightDeviceSwitchView", package.seeall)

local FightDeviceSwitchView = class("FightDeviceSwitchView", BaseView)

function FightDeviceSwitchView:onInitView()
	self.viewRect = self.viewGO:GetComponent(gohelper.Type_RectTransform)
	self.cardItemList = {}
	self.goCardLayout = gohelper.findChild(self.viewGO, "card_layout")
	self.rectCardLayout = self.goCardLayout:GetComponent(gohelper.Type_RectTransform)
	self.bgClick = gohelper.findChildClick(self.viewGO, "bg_mask")

	self.bgClick:AddClickListener(self.onClickBgMask, self)

	self.goDescTip = gohelper.findChild(self.viewGO, "card_layout/desctip")
	self.txtTitle = gohelper.findChildText(self.viewGO, "card_layout/desctip/#txt_title")
	self.txtDesc = gohelper.findChildText(self.viewGO, "card_layout/desctip/#txt_desc")
	self.txtCostPower = gohelper.findChildText(self.viewGO, "card_layout/desctip/grid/#txt_energy")
	self.txtAddExPoint = gohelper.findChildText(self.viewGO, "card_layout/desctip/grid/#txt_tongdiao")
	self.imageEnergyIcon = gohelper.findChildImage(self.viewGO, "card_layout/desctip/grid/#txt_energy/icon")

	gohelper.setActive(self.goDescTip, false)
end

function FightDeviceSwitchView:addEvents()
	self:addEventCb(FightController.instance, FightEvent.OnDevice_SwitchGroup, self.onSwitchGroup, self)
	self:addEventCb(FightController.instance, FightEvent.OnDevice_LongPressSwitchCardItem, self.onLongPressSwitchCardItem, self)
end

function FightDeviceSwitchView:removeEvents()
	return
end

function FightDeviceSwitchView:onClickBgMask()
	self:closeThis()
end

function FightDeviceSwitchView:onSwitchGroup(uid, index)
	if uid ~= self.uid then
		return
	end

	if self.selectIndex == index then
		return
	end

	self:closeThis()
end

function FightDeviceSwitchView:updateData()
	self.uid = self.viewParam
	self.deviceInfo = FightDataHelper.getClientDeviceInfo(self.uid)
	self.selectIndex = self.deviceInfo.clientIndex
end

function FightDeviceSwitchView:onUpdateParam()
	gohelper.setActive(self.goDescTip, false)
	self:updateData()
	self:refreshDeviceArea()
end

function FightDeviceSwitchView:onOpen()
	gohelper.setActive(self.goDescTip, false)
	self:updateData()
	self:refreshDeviceArea()
end

function FightDeviceSwitchView:onLongPressSwitchCardItem(cardItem)
	if not cardItem then
		gohelper.setActive(self.goDescTip, false)

		return
	end

	local deviceSkillInfo = cardItem:getDeviceSkillInfo()

	if not deviceSkillInfo then
		gohelper.setActive(self.goDescTip, false)

		return
	end

	local skillId = deviceSkillInfo.skillId
	local skillCo = lua_skill.configDict[skillId]

	if not skillCo then
		gohelper.setActive(self.goDescTip, false)

		return
	end

	gohelper.setActive(self.goDescTip, true)
	FightDeviceCardTipView.refreshContent(deviceSkillInfo, cardItem:getUid(), self.txtTitle, self.txtDesc, self.txtCostPower, self.txtAddExPoint, self.imageEnergyIcon)
end

function FightDeviceSwitchView:refreshCurSelectDeviceInfo()
	local groupSkillList = self.deviceInfo.skills
	local index = 0

	for groupSkillIndex, groupSkill in ipairs(groupSkillList) do
		if groupSkillIndex ~= self.selectIndex then
			index = index + 1

			local skillInfo = groupSkill.skills[1]
			local cardItem = self.cardItemList[index]

			if not cardItem then
				cardItem = FightDeviceSwitchCardItem.Create(self.goCardLayout)

				table.insert(self.cardItemList, cardItem)
			end

			cardItem:show()
			cardItem:refreshUI(self.uid, groupSkillIndex, skillInfo)
		end
	end

	for i = index + 1, #self.cardItemList do
		self.cardItemList[i]:hide()
	end
end

FightDeviceSwitchView.OffsetX = 90

function FightDeviceSwitchView:updateCardLayoutPos()
	local curSelectDeviceCardItem = self.deviceArea:getCardItem(self.deviceInfo.uid)

	if curSelectDeviceCardItem then
		local rectTr = curSelectDeviceCardItem:getRectTr()

		if rectTr then
			local anchorX = recthelper.rectToRelativeAnchorPos2(rectTr.position, self.viewRect)

			anchorX = anchorX + FightDeviceSwitchView.OffsetX

			recthelper.setAnchorX(self.rectCardLayout, anchorX)
		end
	end
end

function FightDeviceSwitchView:refreshDeviceArea()
	if self.deviceArea then
		self.deviceArea:refreshUI()
		self.deviceArea:setDeviceCardItemActive(self.uid)
		self:refreshCurSelectDeviceInfo()
		self:updateCardLayoutPos()

		return
	end

	self.deviceArea = FightDeviceArea.Create(self.viewGO, FightDeviceArea.ViewType.FightSwitchView)

	self.deviceArea:setLoadDoneCallback(self.onDeviceAreaLoadDone, self)
	self.deviceArea:setDeviceCardItemCls(FightDeviceSwitchPlayCardItem)
	self.deviceArea:startLoad()
end

function FightDeviceSwitchView:onDeviceAreaLoadDone()
	local anchor, scale = FightPlayCardLayoutHelper.getAnchorPosAndScale(FightPlayCardLayoutHelper.PlayCardOperateType.DeviceCard)

	self.deviceArea:setDeviceAreaAnchor(anchor.x, anchor.y)
	self.deviceArea:setDeviceAreaScale(scale)
	self.deviceArea:setLineActive(false)
	self.deviceArea:setDeviceCardItemActive(self.uid)
	self:refreshCurSelectDeviceInfo()
	self:updateCardLayoutPos()
end

function FightDeviceSwitchView:onDestroyView()
	if self.bgClick then
		self.bgClick:RemoveClickListener()

		self.bgClick = nil
	end

	for _, cardItem in ipairs(self.cardItemList) do
		cardItem:dispose()
	end

	if self.deviceArea then
		self.deviceArea:dispose()

		self.deviceArea = nil
	end
end

return FightDeviceSwitchView
