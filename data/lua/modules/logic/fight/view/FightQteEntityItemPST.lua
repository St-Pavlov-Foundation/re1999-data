-- chunkname: @modules/logic/fight/view/FightQteEntityItemPST.lua

module("modules.logic.fight.view.FightQteEntityItemPST", package.seeall)

local FightQteEntityItemPST = class("FightQteEntityItemPST", FightQteEntityItemBase)

function FightQteEntityItemPST:addEvents()
	self:addEventCb(FightController.instance, FightEvent.OnBuffUpdate, self.onBuffUpdate, self)
	self:addEventCb(FightController.instance, FightEvent.OnPlayPSTFlyItem, self.onPlayPSTFlyItem, self)
end

function FightQteEntityItemPST:onPlayPSTFlyItem()
	if self.energyAnimator then
		self.energyAnimator:Play("fly", 0, 0)
	end
end

function FightQteEntityItemPST:onBuffUpdate(entityId, effectType, buffId)
	if entityId ~= self.entityId then
		return
	end

	local featuresSplit = self.entityMo:getFeaturesSplitInfoByBuffId(buffId)

	if not featuresSplit then
		return
	end

	local targetBuffId = FightEnum.BuffActId.QTECostByLayer

	for _, oneFeature in ipairs(featuresSplit) do
		if oneFeature[1] == targetBuffId then
			self:refreshUI()

			return
		end
	end
end

function FightQteEntityItemPST:getCostTypeAndCost()
	local skillCo = lua_skill.configDict[self.activeSkillId]

	if not skillCo then
		return 0, 0
	end

	local costType, cost = FightHelper.getQTESkillCost(skillCo)
	local targetBuffId = FightEnum.BuffActId.QTECostByLayer
	local layer, feature = FightQteEntityItemHelper.getBuffActIdLayer(targetBuffId, self.entityMo)

	if layer < 0 then
		return costType, cost
	end

	local oneLayerOffset = feature[2]

	cost = cost + layer * oneLayerOffset
	cost = math.max(0, cost)

	return costType, cost
end

function FightQteEntityItemPST:initView()
	FightQteEntityItemPST.super.initView(self)

	self.goEnergy = gohelper.findChild(self.viewGo, "root/energy")
	self.goBg = gohelper.findChild(self.goEnergy, "go_bg")

	FightController.instance:dispatchEvent(FightEvent.OnSetPSTFlyStartGo, self.goBg)

	self.energyAnimator = self.goBg:GetComponent(gohelper.Type_Animator)
	self.goEnergyUnFull = gohelper.findChild(self.goEnergy, "go_bg/unfull")
	self.goEnergyFull = gohelper.findChild(self.goEnergy, "go_bg/full")
	self.txtEnergy1 = gohelper.findChildText(self.goEnergyUnFull, "#txt_energy")
	self.txtEnergy2 = gohelper.findChildText(self.goEnergyFull, "#txt_energy")
	self.lastLayer = 0
end

function FightQteEntityItemPST:refreshUI()
	if not self.loadedDone then
		return
	end

	FightQteEntityItemPST.super.refreshUI(self)
	self:refreshEnergy()
end

function FightQteEntityItemPST:refreshEnergy()
	if not self.loadedDone then
		return
	end

	if self.useType ~= FightQteEntityItemBase.UseType.QTEBtn then
		gohelper.setActive(self.goEnergy, false)

		return
	end

	local buffLayer = FightQteEntityItemHelper.getBuffActIdLayer(FightEnum.BuffActId.QTECostByLayer, self.entityMo)

	buffLayer = math.max(0, buffLayer)
	self.txtEnergy1.text = buffLayer
	self.txtEnergy2.text = buffLayer

	local light = buffLayer > 0

	gohelper.setActive(self.goEnergyFull, light)
	gohelper.setActive(self.goEnergyUnFull, not light)

	if buffLayer > self.lastLayer then
		self.energyAnimator:Play("add", 0, 0)
	end

	self.lastLayer = buffLayer
end

return FightQteEntityItemPST
