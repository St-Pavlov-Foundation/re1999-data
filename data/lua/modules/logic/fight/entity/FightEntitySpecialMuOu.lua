-- chunkname: @modules/logic/fight/entity/FightEntitySpecialMuOu.lua

module("modules.logic.fight.entity.FightEntitySpecialMuOu", package.seeall)

local FightEntitySpecialMuOu = class("FightEntitySpecialMuOu", FightEntityObject)

function FightEntitySpecialMuOu:getTag()
	return SceneTag.UnitNpc
end

function FightEntitySpecialMuOu:onConstructor()
	FightRenderOrderMgr.instance:unregister(self.id)
end

function FightEntitySpecialMuOu:initComponents()
	self.spine = self:addEntityComponent(self:getSpineClass())
	self.effect = self:addEntityComponent(FightEffectComp)
	self.spineRenderer = self:addEntityComponent(self:getSpineRendererClass())
end

function FightEntitySpecialMuOu:resetStandPos()
	if not self.secEntityMo then
		return
	end

	if not self.specialCo then
		return
	end

	if not gohelper.isNil(self.go) then
		local posX, posY, posZ = FightHelper.getEntityStandPos(self.secEntityMo)

		posX = posX + self.offsetX
		posY = posY + self.offsetY
		posZ = posZ + self.offsetZ

		transformhelper.setLocalPos(self.goTransform, posX, posY, posZ)
	end
end

function FightEntitySpecialMuOu:setSrcEntityPos(posX, posY, posZ)
	if not self.specialCo then
		return
	end

	if gohelper.isNil(self.go) then
		return
	end

	posX = posX + self.offsetX
	posY = posY + self.offsetY
	posZ = posZ + self.offsetZ

	transformhelper.setPos(self.goTransform, posX, posY, posZ)
end

function FightEntitySpecialMuOu:setSrcEntityMo(entityMo)
	self.secEntityMo = entityMo
end

function FightEntitySpecialMuOu:setSpecialCo(co)
	self.specialCo = co

	local offsetPos = self.specialCo.offset

	self.offsetX = offsetPos[1] or 0
	self.offsetY = offsetPos[2] or 0
	self.offsetZ = offsetPos[3] or 0
end

function FightEntitySpecialMuOu:setAlpha(alpha, duration)
	self.marked_alpha = alpha

	if self.spineRenderer then
		self.spineRenderer:setAlpha(alpha, duration)
	end

	if self.buff then
		if alpha == 0 then
			self.buff:hideBuffEffects()
		elseif alpha == 1 then
			self.buff:showBuffEffects()
		end
	end

	if self.skinSpineEffect then
		if alpha == 0 then
			self.skinSpineEffect:hideEffects()
		else
			self.skinSpineEffect:showEffects()
		end
	end

	FightController.instance:dispatchEvent(FightEvent.OnMuOuEntityVisibleChange)
end

function FightEntitySpecialMuOu:setActive(isActive, isForce)
	FightEntitySpecialMuOu.super.setActive(self, isActive, isForce)
	FightController.instance:dispatchEvent(FightEvent.OnMuOuEntityVisibleChange)
end

function FightEntitySpecialMuOu:setVisibleByPos(isVisible)
	FightEntitySpecialMuOu.super.setVisibleByPos(self, isVisible)
	FightController.instance:dispatchEvent(FightEvent.OnMuOuEntityVisibleChange)
end

function FightEntitySpecialMuOu:setRenderOrder(order)
	if self.spine then
		self.spine:setRenderOrder(FightRenderOrderMgr.MaxOrder)
	end
end

return FightEntitySpecialMuOu
