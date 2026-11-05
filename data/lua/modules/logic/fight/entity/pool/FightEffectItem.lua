-- chunkname: @modules/logic/fight/entity/pool/FightEffectItem.lua

module("modules.logic.fight.entity.pool.FightEffectItem", package.seeall)

local FightEffectItem = class("FightEffectItem", FightBaseClass)

function FightEffectItem:onConstructor(mgr, uniqueId, path, side, hangPointGO, dontPlay)
	self.mgr = mgr
	self.uniqueId = uniqueId
	self.path = path
	self.side = side
	self.dontPlay = dontPlay
	self.isLoaded = false
	self.isLoading = false
	self._canDestroy = false
	self.containerGO = nil
	self.containerTr = nil
	self.effectGO = nil
	self.hangPointGO = nil
	self._layer = nil
	self._renderOrder = nil
	self._effectScale = nil
	self._nonActiveKeyList = {}
	self._nonPosActiveKeyList = {}
	self.callback = nil
	self.callbackObj = nil
	self.cus_localPosX = nil
	self.cus_localPosY = nil
	self.cus_localPosZ = nil

	local nameArr = FightStrUtil.instance:getSplitCache(path, "/")
	local name = nameArr[#nameArr]

	self.containerGO = gohelper.create3d(mgr:getPoolContainerGO(), name)
	self.containerTr = self.containerGO.transform

	self:setHangPointGO(hangPointGO or mgr:getPoolContainerGO())
end

function FightEffectItem:startLoad()
	if self.isLoaded or self.isLoading then
		return
	end

	self.isLoading = true

	self:com_loadAsset(self.path, self._onAssetLoaded)
end

function FightEffectItem:_onAssetLoaded(success, assetItem)
	self.isLoading = false

	if self.IS_DISPOSED then
		return
	end

	if not success or not assetItem then
		logError("load effect fail: " .. tostring(self.path))
		self:doCallback(false)

		return
	end

	self:_instantiateEffectGO(assetItem)

	self.isLoaded = true

	if self.mgr and self.mgr:isUsingEffect(self) then
		self:doCallback(true)
		self:setTimeScale(FightModel.instance:getSpeed())
		self:setActive(false)
		self:play()
	end
end

function FightEffectItem:_instantiateEffectGO(assetItem)
	if gohelper.isNil(self.containerGO) then
		return
	end

	local wholeEffectGO = gohelper.clone(assetItem:GetResource(), self.containerGO)
	local effectGO = wholeEffectGO
	local effectSuffix

	if self.side == FightEnum.EntitySide.MySide then
		effectSuffix = "_r"
	elseif self.side == FightEnum.EntitySide.EnemySide then
		effectSuffix = "_l"
	end

	if not string.nilorempty(effectSuffix) then
		local wholeEffectTr = wholeEffectGO.transform
		local childCount = wholeEffectTr.childCount

		for i = 0, childCount - 1 do
			local child = wholeEffectTr:GetChild(i)
			local childName = child.name
			local len = string.len(childName)

			if string.sub(childName, len - 1, len) == effectSuffix then
				effectGO = child.gameObject

				gohelper.addChild(self.containerGO, effectGO)
				gohelper.destroy(wholeEffectGO)

				break
			end
		end
	end

	gohelper.removeEffectNode(effectGO)
	self:setEffectGO(effectGO)
end

function FightEffectItem:play()
	if self.effectGO and not self.dontPlay then
		self:setActive(true)

		local effectShakeComp = self.effectGO:GetComponent(typeof(ZProj.EffectShakeComponent))

		if effectShakeComp then
			local speed = FightModel.instance:getSpeed()
			local magnitudePercent = 1

			if speed > 1.4 then
				magnitudePercent = 1 - 0.3 * (speed - 1.4) / 1.4
			end

			effectShakeComp:Play(CameraMgr.instance:getCameraShake(), speed, magnitudePercent)

			if FightGameMgr.entityPhysicsWhenCameraShakeMgr then
				FightGameMgr.entityPhysicsWhenCameraShakeMgr:startShake()
			end
		end
	end
end

function FightEffectItem:setEffectGO(effectGO)
	self.effectGO = effectGO

	if self._effectScale then
		transformhelper.setLocalScale(self.effectGO.transform, self._effectScale, self._effectScale, self._effectScale)
	end

	if self._renderOrder then
		self:setRenderOrder(self._renderOrder, true)
	end

	self.cus_localPosX, self.cus_localPosY, self.cus_localPosZ = transformhelper.getLocalPos(self.effectGO.transform)

	if self._nonPosActiveKeyList and #self._nonPosActiveKeyList > 0 then
		self:playActiveByPos(false)
	end
end

function FightEffectItem:setLayer(layer)
	self._layer = layer

	gohelper.setLayer(self.effectGO, self._layer, true)
end

function FightEffectItem:setHangPointGO(hangPointGO)
	if not gohelper.isNil(hangPointGO) and not gohelper.isNil(self.containerGO) and self.hangPointGO ~= hangPointGO then
		self.hangPointGO = hangPointGO

		self.containerGO.transform:SetParent(self.hangPointGO.transform, true)
		transformhelper.setLocalRotation(self.containerGO.transform, 0, 0, 0)
		transformhelper.setLocalScale(self.containerGO.transform, 1, 1, 1)
	end
end

function FightEffectItem:setLocalPos(x, y, z)
	if self.containerTr then
		transformhelper.setLocalPos(self.containerTr, x, y, z)
		self:clearTrail()
	end
end

function FightEffectItem:setWorldPos(x, y, z)
	if self.containerTr then
		transformhelper.setPos(self.containerTr, x, y, z)
		self:clearTrail()
	end
end

function FightEffectItem:setCallback(callback, callbackObj)
	self.callback = callback
	self.callbackObj = callbackObj
end

function FightEffectItem:setActive(isActive, nonActiveKey)
	nonActiveKey = nonActiveKey or "default"

	if self.containerGO then
		if isActive then
			tabletool.removeValue(self._nonActiveKeyList, nonActiveKey)
			gohelper.setActive(self.containerGO, #self._nonActiveKeyList == 0)
		else
			if not tabletool.indexOf(self._nonActiveKeyList, nonActiveKey) then
				table.insert(self._nonActiveKeyList, nonActiveKey)
			end

			gohelper.setActive(self.containerGO, false)
		end
	end
end

function FightEffectItem:setActiveByPos(isActive, nonActiveKey)
	nonActiveKey = nonActiveKey or "default"

	if self.containerGO then
		if isActive then
			tabletool.removeValue(self._nonPosActiveKeyList, nonActiveKey)
			self:playActiveByPos(#self._nonPosActiveKeyList == 0)
		else
			if not tabletool.indexOf(self._nonPosActiveKeyList, nonActiveKey) then
				table.insert(self._nonPosActiveKeyList, nonActiveKey)
			end

			self:playActiveByPos(false)
		end
	else
		logError("Effect container is nil, setActive fail: " .. tostring(self.path))
	end
end

function FightEffectItem:playActiveByPos(state)
	if self.effectGO and self.cus_localPosX then
		if state then
			transformhelper.setLocalPos(self.effectGO.transform, self.cus_localPosX, self.cus_localPosY, self.cus_localPosZ)
		else
			transformhelper.setLocalPos(self.effectGO.transform, self.cus_localPosX + 20000, self.cus_localPosY + 20000, self.cus_localPosZ + 20000)
		end
	end
end

function FightEffectItem:onReturnPool()
	self._nonActiveKeyList = {}
	self._nonPosActiveKeyList = {}

	self:playActiveByPos(true)
end

function FightEffectItem:setRenderOrder(order, force)
	if not order then
		return
	end

	local oldOrder = self._renderOrder

	self._renderOrder = order

	if not force and order == oldOrder then
		return
	end

	if not gohelper.isNil(self.effectGO) then
		local effectOrderContainer = self.effectGO:GetComponent(typeof(ZProj.EffectOrderContainer))

		if effectOrderContainer then
			effectOrderContainer:SetBaseOrder(order)
		end
	end
end

function FightEffectItem:setTimeScale(timeScale)
	if self.effectGO then
		local effectTimeScale = gohelper.onceAddComponent(self.effectGO, typeof(ZProj.EffectTimeScale))

		effectTimeScale:SetTimeScale(timeScale)
	end
end

function FightEffectItem:clearTrail()
	if self.effectGO then
		local effectTimeScale = gohelper.onceAddComponent(self.effectGO, typeof(ZProj.EffectTimeScale))

		effectTimeScale:ClearTrail()
	end
end

function FightEffectItem:doCallback(success)
	if self.callback then
		if self.callbackObj then
			self.callback(self.callbackObj, self, success)
		else
			self.callback(self, success)
		end

		self.callback = nil
		self.callbackObj = nil
	end
end

function FightEffectItem:setEffectScale(scale)
	self._effectScale = scale

	if self.effectGO then
		transformhelper.setLocalScale(self.effectGO.transform, self._effectScale, self._effectScale, self._effectScale)
	end
end

function FightEffectItem:markCanDestroy()
	self._canDestroy = true
end

function FightEffectItem:onDestructor()
	if self.containerGO and not gohelper.isNil(self.containerGO) then
		gohelper.destroy(self.containerGO)
	end

	self.containerGO = nil
	self.containerTr = nil
	self.effectGO = nil
	self.hangPointGO = nil
	self.callback = nil
	self.callbackObj = nil
	self.mgr = nil
end

return FightEffectItem
