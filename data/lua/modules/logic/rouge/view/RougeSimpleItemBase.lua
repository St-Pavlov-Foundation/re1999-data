-- chunkname: @modules/logic/rouge/view/RougeSimpleItemBase.lua

local ti = table.insert
local kZeroV2 = Vector2.zero
local kZeroV3 = Vector3.zero
local kOneV3 = Vector3.one
local kOneV2 = Vector2.one
local k0505V2 = Vector2(0.5, 0.5)

module("modules.logic.rouge.view.RougeSimpleItemBase", package.seeall)

local RougeSimpleItemBase = class("RougeSimpleItemBase", ListScrollCellExtend)
local table_insert = table.insert
local UGUIHelper = ZProj.UGUIHelper
local CSRectTrHelper = SLFramework.UGUI.RectTrHelper

function RougeSimpleItemBase:ctor(ctorParam)
	RougeSimpleItemBase.super.ctor(self, ctorParam)

	self._staticData = {}

	if ctorParam then
		self._staticData.baseViewContainer = ctorParam.baseViewContainer
		self._staticData.parent = ctorParam.parent
	end
end

function RougeSimpleItemBase:init(...)
	RougeSimpleItemBase.super.init(self, ...)
	self:addEventListeners()

	return self
end

function RougeSimpleItemBase:onInitView()
	self:_editableInitView()

	return self
end

function RougeSimpleItemBase:onUpdateMO(mo)
	self:setData(mo)

	return self
end

function RougeSimpleItemBase:parent()
	return self._staticData.parent
end

function RougeSimpleItemBase:baseViewContainer()
	return self._staticData.baseViewContainer
end

function RougeSimpleItemBase:_assetGetViewContainer()
	return assert(self:baseViewContainer(), "please assign baseViewContainer by ctorParam on ctor")
end

function RougeSimpleItemBase:_assetGetParent()
	return assert(self:parent(), "please assign parent by ctorParam on ctor")
end

function RougeSimpleItemBase:regEvent(evtId, cb, cbObj)
	if not self._parent then
		logWarn("regEvent")

		return
	end

	local c = self:_assetGetViewContainer()

	c:registerCallback(evtId, cb, cbObj)
end

function RougeSimpleItemBase:unregEvent(evtId, cb, cbObj)
	if not self._parent then
		logWarn("unregEvent")

		return
	end

	local c = self:_assetGetViewContainer()

	c:unregisterCallback(evtId, cb, cbObj)
end

function RougeSimpleItemBase:dispatchEvent(evtName, ...)
	local c = self:baseViewContainer()

	if not c then
		return
	end

	c:dispatchEvent(evtName, ...)
end

function RougeSimpleItemBase:isSelected()
	return self._staticData.isSelected
end

function RougeSimpleItemBase:setSelectedSlient(isSelect)
	self._staticData.isSelected = isSelect
end

function RougeSimpleItemBase:setSelected(isSelect)
	if self:isSelected() == isSelect then
		return
	end

	self:onSelect(isSelect)
end

function RougeSimpleItemBase:onSelect(isSelect)
	RougeSimpleItemBase.super.onSelect(self, isSelect)

	self._staticData.isSelected = isSelect
end

function RougeSimpleItemBase:setIndex(index)
	self._index = index

	return self
end

function RougeSimpleItemBase:index()
	return self._index
end

function RougeSimpleItemBase:setName(name)
	self.viewGO.name = name

	return self
end

function RougeSimpleItemBase:name()
	return self.viewGO.name
end

function RougeSimpleItemBase:setActive(isActive)
	gohelper.setActive(self.viewGO, isActive)

	return self
end

function RougeSimpleItemBase:setActive01(isActive, targetTransform)
	GameUtil.setActive01(targetTransform or self._trans, isActive)

	return self
end

function RougeSimpleItemBase:posX(targetTransform)
	return recthelper.getAnchorX(targetTransform or self._trans)
end

function RougeSimpleItemBase:posY(targetTransform)
	return recthelper.getAnchorY(targetTransform or self._trans)
end

function RougeSimpleItemBase:posXY(targetTransform)
	return recthelper.getAnchor(targetTransform or self._trans)
end

function RougeSimpleItemBase:WPos()
	return self._trans.position
end

function RougeSimpleItemBase:setWPos(newWPos)
	self._trans.position = newWPos

	return self
end

function RougeSimpleItemBase:setAPos(newAPosX, newAPosY, targetTransform)
	local t = targetTransform or self._trans
	local oldX, oldY = self:posXY(t)

	recthelper.setAnchor(t, newAPosX or oldX, newAPosY or oldY)

	return self
end

function RougeSimpleItemBase:zeroPos(targetTransform)
	self:setLocalPosXY(0, 0, targetTransform)

	return self
end

function RougeSimpleItemBase:uiPosToScreenPos2(targetTransform)
	return recthelper.uiPosToScreenPos2(targetTransform or self._trans)
end

function RougeSimpleItemBase:screenPosToLocal(screenPosX, screenPosY, targetTransform)
	targetTransform = targetTransform or self._trans

	local localPosV2 = CSRectTrHelper.ScreenPosToAnchorPos(Vector2.New(screenPosX, screenPosY), targetTransform.parent, CameraMgr.instance:getUICamera())

	return localPosV2
end

function RougeSimpleItemBase:setPosByScreenPos(screenPosX, screenPosY, targetTransform)
	local localPosV2 = self:screenPosToLocal(screenPosX, screenPosY, targetTransform)

	self:setLocalPosXY(localPosV2.x, localPosV2.y, targetTransform)

	return self
end

function RougeSimpleItemBase:setDock(targetRectTrans, eDock, curRectTrans, ...)
	UIDockingHelper.setDock(eDock, curRectTrans or self._trans, targetRectTrans, ...)

	return self
end

function RougeSimpleItemBase:logicParentTrans()
	local p = self:parent()

	return p:transform()
end

function RougeSimpleItemBase:transform()
	return self._trans
end

function RougeSimpleItemBase:pivot()
	return self._trans.pivot
end

function RougeSimpleItemBase:setPivot(newPivot)
	self._trans.pivot = newPivot

	return self
end

function RougeSimpleItemBase:rect()
	return self._trans.rect
end

function RougeSimpleItemBase:setAsLastSibling()
	self._trans:SetAsLastSibling()

	return self
end

function RougeSimpleItemBase:setAsFirstSibling()
	self._trans:SetAsFirstSibling()

	return self
end

function RougeSimpleItemBase:setSiblingIndex(index)
	self._trans:SetSiblingIndex(index)

	return self
end

function RougeSimpleItemBase:setParent(targetParentTrans, optWorldPositionStays, optInjectedChildTrans)
	optInjectedChildTrans = optInjectedChildTrans or self._trans

	optInjectedChildTrans:SetParent(targetParentTrans, optWorldPositionStays and true or false)

	return self
end

function RougeSimpleItemBase:setParentAndResetPosZero(targetParentTrans, optInjectedChildTrans)
	self:setParent(targetParentTrans, false, optInjectedChildTrans)
	self:zeroPos()

	return self
end

function RougeSimpleItemBase:addChildToSlot(targetChildTrans, optWorldPositionStays, optInjectedParentTrans)
	optInjectedParentTrans = optInjectedParentTrans or self._trans

	self:setParent(optInjectedParentTrans, optWorldPositionStays, targetChildTrans)

	return self
end

function RougeSimpleItemBase:localRotateZ(zDegree, targetTransform)
	transformhelper.setLocalRotation(targetTransform or self._trans, 0, 0, zDegree)

	return self
end

function RougeSimpleItemBase:setLocalPosXY(x, y, targetTransform)
	transformhelper.setLocalPosXY(targetTransform or self._trans, x, y)

	return self
end

function RougeSimpleItemBase:GetComponent(csType)
	return self.viewGO:GetComponent(csType)
end

function RougeSimpleItemBase:setW(value, targetTransform)
	recthelper.setWidth(targetTransform or self._trans, value)

	return self
end

function RougeSimpleItemBase:setH(value, targetTransform)
	recthelper.setHeight(targetTransform or self._trans, value)

	return self
end

function RougeSimpleItemBase:getW(targetTransform)
	return recthelper.getWidth(targetTransform or self._trans)
end

function RougeSimpleItemBase:getH(targetTransform)
	return recthelper.getHeight(targetTransform or self._trans)
end

function RougeSimpleItemBase:setWH(newWidth, newHeight, targetTransform)
	recthelper.setSize(targetTransform or self._trans, newWidth, newHeight)

	return self
end

function RougeSimpleItemBase:setWHByRatio(ratioX, ratioY, targetTransform)
	local t = targetTransform or self._trans
	local sz = t.sizeDelta

	t.sizeDelta = Vector2(sz.x * ratioX, sz.y * ratioY)

	return self
end

function RougeSimpleItemBase:getWH(targetTransform)
	local w = self:getW(targetTransform)
	local h = self:getH(targetTransform)

	return w, h
end

function RougeSimpleItemBase:setScale(newScaleValue, targetTransform)
	self:setScaleXYZ(newScaleValue, newScaleValue, newScaleValue, targetTransform)

	return self
end

function RougeSimpleItemBase:setScaleXYZ(newScaleX, newScaleY, newScaleZ, targetTransform)
	transformhelper.setLocalScale(targetTransform or self._trans, newScaleX or 1, newScaleY or 1, newScaleZ or 1)

	return self
end

function RougeSimpleItemBase:XYWH(targetTransform)
	local w = recthelper.getWidth(targetTransform or self._trans)
	local h = recthelper.getHeight(targetTransform or self._trans)
	local x, y = self:posXY()

	return x, y, w, h
end

function RougeSimpleItemBase:isOverlaps(lhsRectTr, rhsRectTr)
	rhsRectTr = rhsRectTr or self._trans

	if not lhsRectTr or not rhsRectTr then
		return false
	end

	return UGUIHelper.Overlaps(lhsRectTr, rhsRectTr, CameraMgr.instance:getUICamera())
end

function RougeSimpleItemBase:_onSetScrollParentGameObject(limitScrollRectCmp)
	if gohelper.isNil(limitScrollRectCmp) then
		return
	end

	local c = self:baseViewContainer()

	if not c then
		return
	end

	local go = c:getScrollViewGo()

	if gohelper.isNil(go) then
		return
	end

	limitScrollRectCmp.parentGameObject = go
end

function RougeSimpleItemBase:_fillUserDataTb(prefixStr, outGoList, outCmpList)
	local i = 1
	local cmp = self[prefixStr .. i]

	while not gohelper.isNil(cmp) do
		if outGoList then
			table_insert(outGoList, cmp.gameObject)
		end

		if outCmpList then
			table_insert(outCmpList, cmp)
		end

		i = i + 1
		cmp = self[prefixStr .. i]
	end
end

function RougeSimpleItemBase:_getRef_ctorParam()
	if not self.__child_ctorParam then
		self.__child_ctorParam = {
			parent = self,
			baseViewContainer = self:baseViewContainer()
		}
	end

	return self.__child_ctorParam
end

function RougeSimpleItemBase:newObject(luaClass)
	if isDebugBuild then
		assert(isTypeOf(luaClass, RougeSimpleItemBase), debug.traceback())
	end

	return luaClass.New(self:_getRef_ctorParam())
end

function RougeSimpleItemBase:childCount()
	return self._trans and self._trans.childCount or 0
end

function RougeSimpleItemBase:saveRectTransfromData(optTrans)
	optTrans = optTrans or self:transform()

	local infoDataList = self:getUserDataTb_()

	ti(infoDataList, optTrans.anchorMin)
	ti(infoDataList, optTrans.anchorMax)
	ti(infoDataList, optTrans.pivot)
	ti(infoDataList, optTrans.anchoredPosition)
	ti(infoDataList, optTrans.sizeDelta)
	ti(infoDataList, optTrans.localScale)

	return infoDataList
end

function RougeSimpleItemBase:loadRectTransfromData(infoDataList, optTrans)
	optTrans = optTrans or self:transform()
	optTrans.anchorMin = infoDataList[1]
	optTrans.anchorMax = infoDataList[2]
	optTrans.pivot = infoDataList[3]
	optTrans.anchoredPosition = infoDataList[4]
	optTrans.sizeDelta = infoDataList[5]
	optTrans.localScale = infoDataList[6]

	return self
end

function RougeSimpleItemBase:setFullscreenStretch(optTrans)
	optTrans = optTrans or self:transform()
	optTrans.anchorMin = kZeroV2
	optTrans.anchorMax = kOneV2
	optTrans.pivot = k0505V2
	optTrans.anchoredPosition = kZeroV2
	optTrans.sizeDelta = kZeroV2
	optTrans.localScale = kOneV3
end

function RougeSimpleItemBase:resetTransform(optTrans)
	optTrans = optTrans or self:transform()
	optTrans.pivot = k0505V2
	optTrans.anchorMin = k0505V2
	optTrans.anchorMax = k0505V2
	optTrans.offsetMin = kZeroV2
	optTrans.offsetMax = kZeroV2
	optTrans.localScale = kOneV3
	optTrans.localRotation = Quaternion.New(0, 0, 0, 1)
	optTrans.anchoredPosition3D = kZeroV3
end

function RougeSimpleItemBase:_editableInitView()
	self._trans = self.viewGO.transform
end

function RougeSimpleItemBase:setData(mo)
	self._mo = mo

	return self
end

function RougeSimpleItemBase:refresh()
	self:onUpdateMO(self._mo)

	return self
end

function RougeSimpleItemBase:onDestroyView()
	self:removeEventListeners()
	RougeSimpleItemBase.super.onDestroyView(self)
end

function RougeSimpleItemBase:setGrayscale(go, isGray)
	UGUIHelper.SetGrayscale(go, isGray)

	return self
end

return RougeSimpleItemBase
