-- chunkname: @modules/logic/fight/entity/comp/skill/FightTLDeviceCardTriggerPowerEffect.lua

module("modules.logic.fight.entity.comp.skill.FightTLDeviceCardTriggerPowerEffect", package.seeall)

local FightTLDeviceCardTriggerPowerEffect = class("FightTLDeviceCardTriggerPowerEffect", FightTimelineTrackItem)
local FlyNodeList = {}

function FightTLDeviceCardTriggerPowerEffect.getFlyNode()
	return table.remove(FlyNodeList)
end

function FightTLDeviceCardTriggerPowerEffect.recycleFlyNode(goNode)
	gohelper.setActive(goNode, false)
	table.insert(FlyNodeList, goNode)
end

function FightTLDeviceCardTriggerPowerEffect.clearFlyNode()
	tabletool.clear(FlyNodeList)
end

function FightTLDeviceCardTriggerPowerEffect:triggerPowerChange(fightStepData)
	if not fightStepData then
		return
	end

	local targetEffectType = FightEnum.EffectType.DEVICEPOWERCHANGE
	local fightStepType = FightEnum.EffectType.FIGHTSTEP

	for _, actEffect in ipairs(fightStepData.actEffect) do
		if actEffect.effectType == targetEffectType then
			FightDataHelper.playEffectData(actEffect)

			local changeFrom = actEffect.effectNum

			FightController.instance:dispatchEvent(FightEvent.OnDevice_PowerChange, actEffect.reserveStr, changeFrom)
		elseif actEffect.effectType == fightStepType then
			self:triggerPowerChange(actEffect.fightStep)
		end
	end
end

function FightTLDeviceCardTriggerPowerEffect:onTrackStart(fightStepData, duration, paramsArr)
	local fightViewContainer = ViewMgr.instance:getContainer(ViewName.FightView)

	if not fightViewContainer then
		return
	end

	self.viewGo = fightViewContainer.viewGO
	self.viewTr = self.viewGo.transform

	local waitArea = fightViewContainer.waitingArea
	local cardItemList = waitArea and waitArea:getCardItemList()

	if not cardItemList then
		return
	end

	local cardIndex = fightStepData.cardIndex
	local cardItem = cardItemList[cardIndex]

	if not cardItem then
		return
	end

	self.fightStepData = fightStepData

	cardItem:playDeviceCardAnim(self.onDeviceAnimEventTrigger, self)

	self.cardItem = cardItem
end

function FightTLDeviceCardTriggerPowerEffect:onDeviceAnimEventTrigger(eventName)
	if eventName == "fly" then
		self:handleFlyEvent()
	elseif eventName == "finish" and self.cardItem then
		self.cardItem:clearDeviceAnim()
	end
end

local FlyNodePath = "ui/viewres/fight/fight3_7devicefly.prefab"

function FightTLDeviceCardTriggerPowerEffect:handleFlyEvent()
	local flyGo = self.getFlyNode()

	if flyGo then
		self:startFly(flyGo)
	else
		self.loader = MultiAbLoader.New()

		self.loader:addPath(FlyNodePath)
		self.loader:startLoad(self.onLoadedFlyNodeDone, self)
	end
end

function FightTLDeviceCardTriggerPowerEffect:onLoadedFlyNodeDone()
	local prefab = self.loader:getFirstAssetItem():GetResource()
	local flyGo = gohelper.clone(prefab, self.viewGo)

	self:startFly(flyGo)
end

local Career2NodeNameDict = {
	[0] = "node_fly_colorful",
	[CharacterEnum.CareerType.Yan] = "node_fly_y",
	[CharacterEnum.CareerType.Xing] = "node_fly_b"
}

function FightTLDeviceCardTriggerPowerEffect:startFly(flyGo)
	self.flyGo = flyGo

	local flyScript = flyGo:GetComponent(typeof(UnityEngine.UI.UIFlying))

	flyScript:SetAllFlyItemDoneCallback(self.onFlyItemDone, self)

	local career = self.cardItem:getCurDeviceAddCareer()
	local tr = flyGo.transform

	for i = 0, tr.childCount - 1 do
		local child = tr:GetChild(i)

		gohelper.setActive(child.gameObject, false)
	end

	local go = gohelper.findChild(flyGo, Career2NodeNameDict[career])

	flyScript:SetFlyItemObj(go)

	flyScript.startPosition = recthelper.rectToRelativeAnchorPos(self.cardItem.tr.position, self.viewTr)

	local viewContainer = ViewMgr.instance:getContainer(ViewName.FightView)
	local deviceCardItem = viewContainer and viewContainer:getCacheUserData(FightViewContainerCacheKey.UserDataKey.DeviceAreaCardItem)
	local powerWorldPos = deviceCardItem and deviceCardItem:getPowerWorldPos(career)
	local endPos

	if not powerWorldPos then
		endPos = Vector2(0, 0)
	else
		endPos = recthelper.rectToRelativeAnchorPos(powerWorldPos, self.viewTr)
	end

	flyScript.endPosition = endPos

	gohelper.setActive(flyGo, true)
	AudioMgr.instance:trigger(370803)

	self.flyScript = flyScript
end

function FightTLDeviceCardTriggerPowerEffect:onFlyItemDone()
	self:triggerPowerChange(self.fightStepData)
end

function FightTLDeviceCardTriggerPowerEffect:onTrackEnd()
	self:clear()
end

function FightTLDeviceCardTriggerPowerEffect:onDestructor()
	self:clear()
end

function FightTLDeviceCardTriggerPowerEffect:clear()
	if self.flyGo then
		self.recycleFlyNode(self.flyGo)

		self.flyGo = nil
	end

	if self.loader then
		self.loader:dispose()

		self.loader = nil
	end

	if self.cardItem then
		self.cardItem:clearDeviceAnim()

		self.cardItem = nil
	end

	if self.flyScript then
		self.flyScript:RemoveAllCallback()
		self.flyScript:StopAllFlying()

		self.flyScript = nil
	end
end

return FightTLDeviceCardTriggerPowerEffect
