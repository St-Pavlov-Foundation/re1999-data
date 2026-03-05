-- chunkname: @modules/logic/fight/view/FightLorentzCardCopyView.lua

module("modules.logic.fight.view.FightLorentzCardCopyView", package.seeall)

local FightLorentzCardCopyView = class("FightLorentzCardCopyView", BaseView)

FightLorentzCardCopyView.OpenAnimDuration = 1
FightLorentzCardCopyView.CloseAnimDuration = 1
FightLorentzCardCopyView.FlyItemDuration = 0.2

function FightLorentzCardCopyView:onInitView()
	self.cardItemList = {}
	self.srcPool = self:getUserDataTb_()
	self.curPool = self:getUserDataTb_()

	local goMiddle = gohelper.findChild(self.viewGO, "root/Middle")

	gohelper.setActive(goMiddle, false)
	table.insert(self.srcPool, gohelper.findChild(self.viewGO, "root/Middle/card1"))
	table.insert(self.srcPool, gohelper.findChild(self.viewGO, "root/Middle/card2"))
	table.insert(self.srcPool, gohelper.findChild(self.viewGO, "root/Middle/card3"))

	self.goLayout = gohelper.findChild(self.viewGO, "root/layout")
	self.flyRoot = gohelper.findChild(self.viewGO, "root/#go_flyItemContent")
	self.flyRootRectTr = self.flyRoot:GetComponent(gohelper.Type_RectTransform)
	self.flyItem = gohelper.findChild(self.viewGO, "root/#go_flyItemContent/#fly")

	gohelper.setActive(self.flyItem, false)
end

function FightLorentzCardCopyView:addEvents()
	return
end

function FightLorentzCardCopyView:removeEvents()
	return
end

function FightLorentzCardCopyView.blockEsc()
	return
end

function FightLorentzCardCopyView:_editableInitView()
	NavigateMgr.instance:addEscape(self.viewName, self.blockEsc)
end

function FightLorentzCardCopyView:getPrefabGo()
	if #self.curPool < 1 then
		tabletool.addValues(self.curPool, self.srcPool)
	end

	local go

	if #self.curPool == 1 then
		go = table.remove(self.curPool)
	else
		local index = math.random(1, #self.curPool)

		go = table.remove(self.curPool, index)
	end

	return gohelper.clone(go, self.goLayout)
end

function FightLorentzCardCopyView:createCardItem()
	local go = self:getPrefabGo()
	local item = self:getUserDataTb_()

	item.go = go
	item.rectTr = go:GetComponent(gohelper.Type_RectTransform)
	item.animator = gohelper.findChildComponent(go, "ani", gohelper.Type_Animator)
	item.simage = gohelper.findChildSingleImage(go, "ani/image_card")

	gohelper.setActive(go, false)
	table.insert(self.cardItemList, item)

	return item
end

function FightLorentzCardCopyView:onUpdateParam()
	self:refreshCardItem()
end

function FightLorentzCardCopyView:onOpen()
	self:hideViewAndCopyNode()
	self:refreshCardItem()
end

function FightLorentzCardCopyView:hideViewAndCopyNode()
	FightController.instance:dispatchEvent(FightEvent.SetIsShowUI, false)

	local viewContainer = ViewMgr.instance:getContainer(ViewName.FightView)
	local viewGo = viewContainer.viewGO
	local btnRoot = gohelper.findChild(viewGo, "root/btns")
	local anchorX, anchorY = recthelper.getAnchor(btnRoot.transform)

	btnRoot = gohelper.clone(btnRoot, self.viewGO)

	recthelper.setAnchor(btnRoot.transform, anchorX, anchorY)

	local goBtn = gohelper.findChild(btnRoot, "cardBox")

	self.goBtnImage = gohelper.findChild(goBtn, "image")
	self.btnAnimator = goBtn:GetComponent(gohelper.Type_Animator)
end

function FightLorentzCardCopyView:getSkillIdAndCount()
	local defaultSkillId = 31390111
	local defaultCount = 3
	local entityId = self.viewParam and self.viewParam.entityId
	local skillId, count = FightHelper.getEntityRecordSkillIdAndCount(entityId)

	skillId = skillId or defaultSkillId
	count = count or defaultCount

	return skillId, count
end

function FightLorentzCardCopyView:refreshCardItem()
	for _, cardItem in ipairs(self.cardItemList) do
		gohelper.setActive(cardItem.go, false)
	end

	local skillId, count = self:getSkillIdAndCount()

	for i = 1, count do
		local cardItem = self.cardItemList[i]

		cardItem = cardItem or self:createCardItem()

		gohelper.setActive(cardItem.go, true)

		local skillCo = skillId and lua_skill.configDict[skillId]

		if skillCo then
			local url = ResUrl.getSkillIcon(skillCo.icon)

			cardItem.simage:LoadImage(url)
		end
	end

	AudioMgr.instance:trigger(350026)
	TaskDispatcher.runDelay(self.playCloseAnim, self, FightLorentzCardCopyView.OpenAnimDuration)
end

function FightLorentzCardCopyView:playCloseAnim()
	for _, cardItem in ipairs(self.cardItemList) do
		if cardItem.go.activeSelf then
			cardItem.animator:Play("close", 0, 0)
		end
	end

	TaskDispatcher.runDelay(self.startFlyItem, self, FightLorentzCardCopyView.CloseAnimDuration)
end

function FightLorentzCardCopyView:startFlyItem()
	gohelper.setActive(self.flyRoot, true)

	local targetScreenPos = self.goBtnImage and recthelper.uiPosToScreenPos(self.goBtnImage.transform)

	for _, cardItem in ipairs(self.cardItemList) do
		if cardItem.go.activeSelf then
			local startScreenPos = recthelper.uiPosToScreenPos(cardItem.rectTr)
			local flyItem = gohelper.cloneInPlace(self.flyItem)
			local flyItemRectTr = flyItem.transform
			local anchor = recthelper.screenPosToAnchorPos(startScreenPos, flyItemRectTr)
			local flyScript = flyItem:GetComponent(typeof(UnityEngine.UI.UIFlying))

			flyScript.startPosition = anchor

			if targetScreenPos then
				local endPos = recthelper.screenPosToAnchorPos(targetScreenPos, flyItemRectTr)

				flyScript.endPosition = endPos
			end

			gohelper.setActive(flyItem, true)
		end
	end

	TaskDispatcher.runDelay(self.triggerEvent, self, FightLorentzCardCopyView.FlyItemDuration)
end

function FightLorentzCardCopyView:triggerEvent()
	AudioMgr.instance:trigger(350027)
	self.btnAnimator:Play("add", 0, 0)
	FightController.instance:dispatchEvent(FightEvent.CardBoxPlayAnim, "add")
end

function FightLorentzCardCopyView:onDestroyView()
	if self.cardItemList then
		for _, cardItem in ipairs(self.cardItemList) do
			cardItem.simage:UnLoadImage()
		end
	end

	TaskDispatcher.cancelTask(self.playCloseAnim, self)
	TaskDispatcher.cancelTask(self.startFlyItem, self)
	TaskDispatcher.cancelTask(self.triggerEvent, self)
end

return FightLorentzCardCopyView
