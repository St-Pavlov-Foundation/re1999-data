-- chunkname: @modules/logic/tips/view/FightDeviceCardTipView.lua

module("modules.logic.tips.view.FightDeviceCardTipView", package.seeall)

local FightDeviceCardTipView = class("FightDeviceCardTipView", BaseView)

function FightDeviceCardTipView:onInitView()
	self.viewRect = self.viewGO:GetComponent(gohelper.Type_RectTransform)
	self.viewWidth = recthelper.getWidth(self.viewRect)
	self.viewHeight = recthelper.getHeight(self.viewRect)
	self.rootRect = gohelper.findChildComponent(self.viewGO, "layout", gohelper.Type_RectTransform)
	self._txttitle = gohelper.findChildText(self.viewGO, "layout/#txt_title")
	self._txtdesc = gohelper.findChildText(self.viewGO, "layout/#txt_desc")
	self._txtCostPower = gohelper.findChildText(self.viewGO, "layout/grid/#txt_energy")
	self._txtAddExPoint = gohelper.findChildText(self.viewGO, "layout/grid/#txt_tongdiao")
	self._imageEnergyIcon = gohelper.findChildImage(self.viewGO, "layout/grid/#txt_energy/icon")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function FightDeviceCardTipView:addEvents()
	return
end

function FightDeviceCardTipView:removeEvents()
	return
end

function FightDeviceCardTipView:_editableInitView()
	self.blockGraphic = gohelper.findChildComponent(self.viewGO, "close_block", gohelper.Type_Graphic)
	self.click = gohelper.findChildClickWithDefaultAudio(self.viewGO, "close_block")

	self.click:AddClickListener(self.closeThis, self)
end

function FightDeviceCardTipView:onUpdateParam()
	self:refreshUI()
end

function FightDeviceCardTipView:onOpen()
	self:refreshUI()
end

function FightDeviceCardTipView:refreshUI()
	local deviceSkillInfo = self.viewParam.deviceSkillInfo
	local skillId = deviceSkillInfo.skillId
	local uid = self.viewParam.entityUid

	FightDeviceCardTipView.refreshContent(deviceSkillInfo, uid, self._txttitle, self._txtdesc, self._txtCostPower, self._txtAddExPoint, self._imageEnergyIcon)

	local srcWidth = recthelper.getWidth(self.rootRect)

	self.rootRect.pivot = self.viewParam.pivot
	self.rootRect.anchorMin = self.viewParam.anchorMinAndMax
	self.rootRect.anchorMax = self.viewParam.anchorMinAndMax
	self.offsetPosX = self.viewParam.offsetPosX
	self.offsetPosY = self.viewParam.offsetPosY

	recthelper.setWidth(self.rootRect, srcWidth)
	self:setPos()
	self:checkIgnoreClick()
end

function FightDeviceCardTipView:setPos()
	local anchorX, anchorY = recthelper.screenPosToAnchorPos2(self.viewParam.screenPos, self.viewRect)
	local anchorMinAndMax = self.viewParam.anchorMinAndMax

	if anchorMinAndMax == FightCommonTipController.Pivot.TopLeft then
		anchorX = anchorX + self.viewWidth * 0.5
		anchorY = anchorY - self.viewHeight * 0.5
	elseif anchorMinAndMax == FightCommonTipController.Pivot.TopCenter then
		anchorY = anchorY - self.viewHeight * 0.5
	elseif anchorMinAndMax == FightCommonTipController.Pivot.TopRight then
		anchorX = anchorX - self.viewWidth * 0.5
		anchorY = anchorY - self.viewHeight * 0.5
	elseif anchorMinAndMax == FightCommonTipController.Pivot.CenterLeft then
		anchorX = anchorX + self.viewWidth * 0.5
	elseif anchorMinAndMax == FightCommonTipController.Pivot.Center then
		-- block empty
	elseif anchorMinAndMax == FightCommonTipController.Pivot.CenterRight then
		anchorX = anchorX - self.viewWidth * 0.5
	elseif anchorMinAndMax == FightCommonTipController.Pivot.BottomLeft then
		anchorX = anchorX + self.viewWidth * 0.5
		anchorY = anchorY + self.viewHeight * 0.5
	elseif anchorMinAndMax == FightCommonTipController.Pivot.BottomCenter then
		anchorY = anchorY + self.viewHeight * 0.5
	elseif anchorMinAndMax == FightCommonTipController.Pivot.BottomRight then
		anchorX = anchorX - self.viewWidth * 0.5
		anchorY = anchorY + self.viewHeight * 0.5
	end

	anchorX = anchorX + self.offsetPosX
	anchorY = anchorY + self.offsetPosY

	recthelper.setAnchor(self.rootRect, anchorX, anchorY)
end

function FightDeviceCardTipView:checkIgnoreClick()
	self.blockGraphic.raycastTarget = not self.viewParam.ignoreClick
end

function FightDeviceCardTipView.refreshContent(deviceSkillInfo, entityId, txtTitle, txtDesc, txtCost, txtAddExPoint, imageEnergyIcon)
	local skillId = deviceSkillInfo and deviceSkillInfo.skillId
	local skillCo = skillId and lua_skill.configDict[skillId]

	if not skillCo then
		return
	end

	local desc = FightConfig.instance:getEntitySkillDesc(entityId, skillCo)

	desc = SkillHelper.buildDesc(desc)
	txtTitle.text = skillCo.name
	txtDesc.text = desc

	if skillCo.isBigSkill == 1 then
		gohelper.setActive(imageEnergyIcon.gameObject, false)
		gohelper.setActive(txtCost.gameObject, false)

		local entityMo = FightDataHelper.entityMgr:getById(entityId)

		txtAddExPoint.text = "-" .. (entityMo and entityMo:getUniqueSkillPoint() or 0)
	else
		gohelper.setActive(imageEnergyIcon.gameObject, true)
		gohelper.setActive(txtCost.gameObject, true)

		txtCost.text = "-" .. deviceSkillInfo.costValue
		txtAddExPoint.text = "+" .. FightDeviceHelper.getSkillIdAddDeviceExPoint(skillId)

		local url = FightDeviceHelper.getCareerImage(deviceSkillInfo.costType)

		UISpriteSetMgr.instance:setFightSprite(imageEnergyIcon, url, true)
	end
end

function FightDeviceCardTipView:onDestroyView()
	if self.click then
		self.click:RemoveClickListener()

		self.click = nil
	end
end

return FightDeviceCardTipView
