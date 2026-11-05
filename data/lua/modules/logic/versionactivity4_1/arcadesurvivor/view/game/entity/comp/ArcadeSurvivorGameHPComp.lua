-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/view/game/entity/comp/ArcadeSurvivorGameHPComp.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.view.game.entity.comp.ArcadeSurvivorGameHPComp", package.seeall)

local ArcadeSurvivorGameHPComp = class("ArcadeSurvivorGameHPComp", LuaCompBase)

function ArcadeSurvivorGameHPComp:ctor(param)
	self._entity = param.entity
	self._compName = param.compName
end

function ArcadeSurvivorGameHPComp:init(go)
	self.go = go
	self.trans = go.transform
	self.goHpBar = gohelper.create3d(self.go, "hpBar")
	self._initialized = true

	local scene = ArcadeSurvivorGameController.instance:getGameScene()

	if scene then
		local hpItemResUrl = ResUrl.getArcadeSurvivorScenePrefabRes(ArcadeSurvivorEnum.ResDir.EntityPrefab, ArcadeSurvivorEnum.Const.HpItemResName)

		scene.loader:loadRes(hpItemResUrl, self._onLoadHpBarFinished, self)
	end

	local mo = self._entity and self._entity:getMO()

	if mo then
		local x, y = mo:getHpPos()

		transformhelper.setLocalPos(self.trans, x or 0, y or 0, ArcadeSurvivorGameEnum.Const.HpZLevel)
	end

	local scale = ArcadeSurvivorConfig.instance:getConst(ArcadeSurvivorEnum.ConstId.HpBarScale, true)

	transformhelper.setLocalScale(self.trans, scale, scale, 1)
end

function ArcadeSurvivorGameHPComp:_onLoadHpBarFinished()
	local scene = ArcadeSurvivorGameController.instance:getGameScene()

	if not self._initialized or not scene then
		return
	end

	local hpItemResUrl = ResUrl.getArcadeSurvivorScenePrefabRes(ArcadeSurvivorEnum.ResDir.EntityPrefab, ArcadeSurvivorEnum.Const.HpItemResName)
	local assetRes = scene.loader:getResource(hpItemResUrl)

	if not assetRes then
		return
	end

	self._goHpItem = gohelper.clone(assetRes, self.goHpBar)

	self:setHpCap()
	self:refreshShow()
end

function ArcadeSurvivorGameHPComp:addEventListeners()
	self:addEventCb(ArcadeSurvivorGameController.instance, ArcadeSurvivorEvent.OnChangeEntityHp, self._onHpChange, self)
	self:addEventCb(ArcadeSurvivorGameController.instance, ArcadeSurvivorEvent.OnEntityAttrChange, self._onEntityAttrChange, self)
	self:addEventCb(ArcadeSurvivorGameController.instance, ArcadeSurvivorEvent.OnEntityChangeAttrDict, self._onEntityChangeAttrDict, self)
	self:addEventCb(ArcadeSurvivorGameController.instance, ArcadeSurvivorEvent.OnResetGame, self._onResetGame, self)
end

function ArcadeSurvivorGameHPComp:removeEventListeners()
	self:removeEventCb(ArcadeSurvivorGameController.instance, ArcadeSurvivorEvent.OnChangeEntityHp, self._onHpChange, self)
	self:removeEventCb(ArcadeSurvivorGameController.instance, ArcadeSurvivorEvent.OnEntityAttrChange, self._onEntityAttrChange, self)
	self:removeEventCb(ArcadeSurvivorGameController.instance, ArcadeSurvivorEvent.OnEntityChangeAttrDict, self._onEntityChangeAttrDict, self)
	self:removeEventCb(ArcadeSurvivorGameController.instance, ArcadeSurvivorEvent.OnResetGame, self._onResetGame, self)
end

function ArcadeSurvivorGameHPComp:_onHpChange(mo)
	if not mo or not self._initialized or not self._entity then
		return
	end

	if not self:_isSameEntityMO(mo) then
		return
	end

	self:refreshHP()
	self:refreshShow()
end

function ArcadeSurvivorGameHPComp:_isSameEntityMO(mo)
	if not self._entity then
		return false
	end

	local curMO = self._entity:getMO()

	if not curMO then
		return false
	end

	return curMO:getEntityType() == mo:getEntityType() and curMO:getUid() == mo:getUid()
end

function ArcadeSurvivorGameHPComp:_onEntityAttrChange(entityType, uid, attrId)
	if not attrId or not self._initialized or not self._entity then
		return
	end

	local mo = self._entity:getMO()

	if not mo then
		return
	end

	local moEntityType = mo:getEntityType()
	local moUid = mo:getUid()

	if moEntityType ~= entityType or moUid ~= uid then
		return
	end

	local hpCapAttrId = ArcadeSurvivorEnum.Attribute.hpCap

	if attrId ~= hpCapAttrId then
		return
	end

	self:setHpCap()
	self:refreshShow()
end

function ArcadeSurvivorGameHPComp:_onEntityChangeAttrDict(entityType, uid, changedAttrDict)
	if not changedAttrDict or not self._initialized or not self._entity then
		return
	end

	local mo = self._entity:getMO()

	if not mo then
		return
	end

	local moEntityType = mo:getEntityType()
	local moUid = mo:getUid()

	if moEntityType ~= entityType or moUid ~= uid then
		return
	end

	local hpCapAttrId = ArcadeSurvivorEnum.Attribute.hpCap
	local hasHpCapChange = changedAttrDict[hpCapAttrId] ~= nil

	if not hasHpCapChange then
		return
	end

	self:setHpCap()
	self:refreshShow()
end

function ArcadeSurvivorGameHPComp:_onResetGame()
	self:setHpCap()
	self:refreshShow()
end

function ArcadeSurvivorGameHPComp:setHpCap()
	local isHpItemReady = self._goHpItem and not gohelper.isNil(self._goHpItem)

	if not isHpItemReady or not self._entity then
		return
	end

	local mo = self._entity:getMO()
	local hpCap = mo and mo:getAttrValue(ArcadeSurvivorEnum.Attribute.hpCap) or 0
	local maxShowCount = ArcadeSurvivorConfig.instance:getConst(ArcadeSurvivorEnum.ConstId.MaxShowHpCount, true)

	self._showHpCount = math.min(hpCap, maxShowCount)
	self._hpItemList = {}

	gohelper.CreateNumObjList(self.goHpBar, self._goHpItem, self._showHpCount, self._onCreateHpItem, self)
	self:refreshHP()
end

function ArcadeSurvivorGameHPComp:_onCreateHpItem(obj, index)
	local hpItem = self:getUserDataTb_()

	hpItem.go = obj
	hpItem.trans = obj.transform
	hpItem.golight = gohelper.findChild(hpItem.go, "light")
	hpItem.goback = gohelper.findChild(hpItem.go, "back")
	hpItem.hpGODict = self:getUserDataTb_()

	local transLight = hpItem.golight.transform
	local childCount = transLight.childCount

	for i = 1, childCount do
		local child = transLight:GetChild(i - 1)

		hpItem.hpGODict[child.name] = child.gameObject
	end

	local interval = ArcadeSurvivorConfig.instance:getConst(ArcadeSurvivorEnum.ConstId.HpItemSpace, true)
	local startPos = -((self._showHpCount - 1) / 2) * interval
	local x = startPos + (index - 1) * interval

	transformhelper.setLocalPos(hpItem.trans, x, 0, 0)

	self._hpItemList[index] = hpItem
end

function ArcadeSurvivorGameHPComp:refreshHP()
	if not self._entity then
		return
	end

	local entityMO = self._entity:getMO()
	local curHp = entityMO and entityMO:getHp() or 0
	local hpItemList = self._hpItemList

	if not hpItemList then
		return
	end

	local showHpCount = #hpItemList

	for i, hpItem in ipairs(hpItemList) do
		local belongHpSeqIndex = ArcadeGameHelper.getHPSeqIndex(curHp, showHpCount, i)

		if belongHpSeqIndex and belongHpSeqIndex >= 0 then
			local imgIndex = ArcadeSurvivorConfig.instance:getHpColorImgIndex(belongHpSeqIndex)

			for index, goHp in pairs(hpItem.hpGODict) do
				gohelper.setActive(goHp, index == imgIndex)
			end

			gohelper.setActive(hpItem.golight, true)
			gohelper.setActive(hpItem.goback, false)
		else
			gohelper.setActive(hpItem.golight, false)
			gohelper.setActive(hpItem.goback, true)
		end
	end
end

function ArcadeSurvivorGameHPComp:refreshShow()
	if not self._entity then
		return
	end

	local isShow = false
	local mo = self._entity:getMO()

	if mo then
		local entityType = mo:getEntityType()

		if entityType == ArcadeSurvivorEnum.EntityType.Character then
			isShow = true
		else
			local characterMO = ArcadeSurvivorGameModel.instance:getCharacterMO()
			local curHp = mo:getHp() or 0
			local hpCap = mo:getAttrValue(ArcadeSurvivorEnum.Attribute.hpCap)

			if curHp < hpCap then
				isShow = true
			elseif characterMO then
				isShow = ArcadeSurvivorGameHelper.entityIsAdjacent(mo, characterMO)
			end
		end
	end

	gohelper.setActive(self.goHpBar, isShow)
end

function ArcadeSurvivorGameHPComp:clear()
	self._entity = nil
	self._initialized = false
	self._hpItemList = nil
end

function ArcadeSurvivorGameHPComp:onDestroy()
	return
end

return ArcadeSurvivorGameHPComp
