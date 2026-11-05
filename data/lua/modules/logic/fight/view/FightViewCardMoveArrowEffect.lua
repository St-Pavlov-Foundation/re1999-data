-- chunkname: @modules/logic/fight/view/FightViewCardMoveArrowEffect.lua

module("modules.logic.fight.view.FightViewCardMoveArrowEffect", package.seeall)

local FightViewCardMoveArrowEffect = class("FightViewCardMoveArrowEffect", FightBaseClass)

FightViewCardMoveArrowEffect.EffectUrl = "ui/viewres/fight/fightskill/fightcarde_wztx_arrow.prefab"
FightViewCardMoveArrowEffect.Behaviour2Node = {
	[FightEnum.BehaviourId.MoveForward] = "#go_left",
	[FightEnum.BehaviourId.MoveBackward] = "#go_right",
	[FightEnum.BehaviourId.MoveSwap] = "#go_middle"
}
FightViewCardMoveArrowEffect.AnimOpen = "open"
FightViewCardMoveArrowEffect.AnimClose = "close"

function FightViewCardMoveArrowEffect:onConstructor(viewCardItem)
	self.viewCardItem = viewCardItem
	self.root = viewCardItem.moveArrowEffectRoot
	self.effectGo = nil
	self.nodeDict = nil
	self.isLoading = false
	self.curNodeName = nil

	gohelper.setActive(self.root, false)
end

function FightViewCardMoveArrowEffect:refresh(skillId)
	if FightCardDataHelper.hasTargetEnchantId(self.viewCardItem._cardInfoMO, FightEnum.EnchantedType.YiFuLin) or FightCardDataHelper.hasTargetEnchantId(self.viewCardItem._cardInfoMO, FightEnum.EnchantedType.YiFuLinNoPreDel) then
		self.curNodeName = nil

		gohelper.setActive(self.root, false)

		return
	end

	local nodeName = self:_getMoveArrowNode(skillId)

	self.curNodeName = nodeName

	if not nodeName then
		gohelper.setActive(self.root, false)

		return
	end

	if self.effectGo then
		self:_showArrowNode(nodeName)
	elseif not self.isLoading then
		self.isLoading = true

		self:com_loadAsset(self.EffectUrl, self._onEffectLoaded)
	end
end

function FightViewCardMoveArrowEffect:_getMoveArrowNode(skillId)
	local skillCO = skillId and lua_skill.configDict[skillId]

	if not skillCO then
		return nil
	end

	for i = 1, FightEnum.MaxBehavior do
		local behavior = skillCO["behavior" .. i]

		if not string.nilorempty(behavior) then
			local array = FightStrUtil.instance:getSplitString2Cache(behavior, true)

			for _, behaviourArray in ipairs(array) do
				local nodeName = self.Behaviour2Node[behaviourArray[1]]

				if nodeName then
					return nodeName
				end
			end
		end
	end

	return nil
end

function FightViewCardMoveArrowEffect:_onEffectLoaded(success, assetItem)
	self.isLoading = false

	if not success or self.IS_DISPOSED or self.effectGo then
		return
	end

	local resObj = assetItem:GetResource()

	self.effectGo = gohelper.clone(resObj, self.root)
	self.nodeDict = {}

	for _, nodeName in pairs(self.Behaviour2Node) do
		self.nodeDict[nodeName] = gohelper.findChild(self.effectGo, nodeName)
	end

	if self.curNodeName then
		self:_showArrowNode(self.curNodeName)
	else
		gohelper.setActive(self.root, false)
	end
end

function FightViewCardMoveArrowEffect:_showArrowNode(nodeName)
	if not self.nodeDict then
		return
	end

	gohelper.setActive(self.root, true)

	for name, go in pairs(self.nodeDict) do
		gohelper.setActive(go, name == nodeName)
	end

	self:_playNodeAnim(self.nodeDict[nodeName], self:_getPlayAnimName())
end

function FightViewCardMoveArrowEffect:_getPlayAnimName()
	local viewCardItem = self.viewCardItem

	if viewCardItem.handCardType == FightEnum.CardShowType.HandCard and not FightCardDataHelper.canPlayCard(viewCardItem._cardInfoMO) then
		return self.AnimClose
	end

	return self.AnimOpen
end

function FightViewCardMoveArrowEffect:_playNodeAnim(go, animName)
	if gohelper.isNil(go) then
		return
	end

	local animator = gohelper.onceAddComponent(go, gohelper.Type_Animator)

	if gohelper.isNil(animator) then
		return
	end

	animator.speed = FightModel.instance:getUISpeed()

	animator:Play(animName, 0, 0)
end

function FightViewCardMoveArrowEffect:onDestructor()
	if self.effectGo then
		gohelper.destroy(self.effectGo)

		self.effectGo = nil
	end

	self.nodeDict = nil
end

return FightViewCardMoveArrowEffect
