-- chunkname: @modules/logic/versionactivity4_1/library/entity/comp/V4a1_LibrarySpineComp.lua

module("modules.logic.versionactivity4_1.library.entity.comp.V4a1_LibrarySpineComp", package.seeall)

local V4a1_LibrarySpineComp = class("V4a1_LibrarySpineComp", UnitSpine)

function V4a1_LibrarySpineComp:ctor(entity)
	V4a1_LibrarySpineComp.super.ctor(self, entity)

	if not V4a1_LibrarySpineComp.kSortingLayerName then
		V4a1_LibrarySpineComp.kSortingLayerName = V4a1_LibraryConfig.instance:getCharSortingLayerName()
	end
end

function V4a1_LibrarySpineComp:init(go)
	V4a1_LibrarySpineComp.super.init(self, go)

	self._willDestroy = false

	self:_loadSpine()
end

function V4a1_LibrarySpineComp:_skinId()
	return self.unitSpawn:getId()
end

function V4a1_LibrarySpineComp:_skinCo()
	return SkinConfig.instance:getSkinCo(self:_skinId())
end

function V4a1_LibrarySpineComp:_lua_v4a1_library_charCO()
	return V4a1_LibraryConfig.instance:getCharCO(self:_skinId())
end

function V4a1_LibrarySpineComp:_loadSpine()
	local skinCo = self:_skinCo()

	if not skinCo then
		logError("[V4a1_LibrarySpineComp] skin config is nil, skinId:" .. tostring(self:_skinId()))

		return
	end

	local resPath = ResUrl.getSpineBxhyPrefab(skinCo.spine)

	self:setResPath(resPath, self._onSpineLoaded, self)
end

function V4a1_LibrarySpineComp:_onSpineLoaded()
	if self._willDestroy or gohelper.isNil(self._spineGo) then
		return
	end

	local lua_v4a1_library_charCO = self:_lua_v4a1_library_charCO()
	local scale = V4a1_LibraryConfig.instance:getScaleByCO(lua_v4a1_library_charCO)
	local sortingOrder = V4a1_LibraryConfig.instance:getSortingOrderByCO(lua_v4a1_library_charCO)
	local collider2DSize = V4a1_LibraryConfig.instance:getCollider2DSizeByCO(lua_v4a1_library_charCO)
	local collider2DOffset = V4a1_LibraryConfig.instance:getCollider2DOffsetByCO(lua_v4a1_library_charCO)

	transformhelper.setLocalScale(self._spineTr, scale, scale, scale)

	self._spineRenderer.sortingLayerName = V4a1_LibrarySpineComp.kSortingLayerName

	self:setRenderOrder(sortingOrder, true)

	local boxCollider = gohelper.addBoxCollider2D(self._spineGo, collider2DSize)

	boxCollider.offset = collider2DOffset

	gohelper.setLayer(self._spineGo, UnityLayer.Unit, true)

	self._boxCollider2D = boxCollider
end

function V4a1_LibrarySpineComp:getBoxCollider2D()
	return self._boxCollider2D
end

function V4a1_LibrarySpineComp:getSpineGO()
	return self._spineGo
end

function V4a1_LibrarySpineComp:playState(animState)
	if self._willDestroy or not animState then
		return
	end

	if animState == V4a1_LibraryEnum.SpineAnim.Walk and not self:hasAnimation(animState) and self:hasAnimation("walk") then
		animState = "walk"
	end

	self:play(animState, true, true)
end

function V4a1_LibrarySpineComp:refreshOrderLayer()
	return
end

function V4a1_LibrarySpineComp:beforeDestroy()
	self._willDestroy = true

	self:removeAllAnimEventCallback()
end

return V4a1_LibrarySpineComp
