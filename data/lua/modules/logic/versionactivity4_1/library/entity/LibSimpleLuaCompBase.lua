-- chunkname: @modules/logic/versionactivity4_1/library/entity/LibSimpleLuaCompBase.lua

local Input = UnityEngine.Input

module("modules.logic.versionactivity4_1.library.entity.LibSimpleLuaCompBase", package.seeall)

local LibSimpleLuaCompBase = class("LibSimpleLuaCompBase", LuaCompBase)

function LibSimpleLuaCompBase:ctor(ctorParam)
	GameUtil.setInterface(self, self._interfaceCls)
	LibSimpleLuaCompBase.super.ctor(self, ctorParam)

	self._staticData = {}

	if ctorParam then
		self._staticData.parent = ctorParam.parent
		self._staticData.unitObj = ctorParam.unitObj
		self._staticData.sceneObj = ctorParam.sceneObj
	end
end

function LibSimpleLuaCompBase:onDestroy()
	if self._staticData then
		for key, _ in pairs(self._staticData) do
			rawset(self._staticData, key, nil)
		end

		self._staticData = nil
	end
end

function LibSimpleLuaCompBase:parent()
	return self._staticData.parent
end

function LibSimpleLuaCompBase:sceneObj()
	return self._staticData.sceneObj
end

function LibSimpleLuaCompBase:unitObj()
	return self._staticData.unitObj
end

function LibSimpleLuaCompBase:sceneId()
	return self:sceneObj():sceneId()
end

function LibSimpleLuaCompBase:levelId()
	return self:sceneObj():levelId()
end

function LibSimpleLuaCompBase:getCurScene()
	return self:sceneObj()
end

function LibSimpleLuaCompBase:getSceneContainerGO()
	return self:sceneObj():getSceneContainerGO()
end

function LibSimpleLuaCompBase:sceneGo()
	return self:sceneObj():getSceneContainerGO()
end

function LibSimpleLuaCompBase:unitGo()
	return self:unitObj():getSceneContainerGO()
end

function LibSimpleLuaCompBase:sceneTransform()
	return self:sceneObj():transform()
end

function LibSimpleLuaCompBase:unitTransform()
	return self:unitObj():transform()
end

function LibSimpleLuaCompBase:name()
	return self:containerGO().name
end

function LibSimpleLuaCompBase:setName(name)
	self:containerGO().name = name

	return self
end

function LibSimpleLuaCompBase:_getRef_ctorParam()
	if not self.__child_ctorParam then
		self.__child_ctorParam = {
			parent = self,
			sceneObj = self:sceneObj(),
			unitObj = self:unitObj()
		}
	end

	return self.__child_ctorParam
end

function LibSimpleLuaCompBase:_assertBaseThisClass(luaClass)
	if isDebugBuild then
		assert(isTypeOf(luaClass, LibSimpleLuaCompBase))
	end

	return self
end

function LibSimpleLuaCompBase:_addLuaComOnceToGo(luaClass, optCtorParam, optGo, optGoName, optParentGo)
	if not optCtorParam then
		self:_assertBaseThisClass(luaClass)
	end

	optCtorParam = optCtorParam or self:_getRef_ctorParam()
	optGo = optGo or self:create3d(optGoName or luaClass.__cname, optParentGo)

	return MonoHelper.addLuaComOnceToGo(optGo, luaClass, optCtorParam)
end

function LibSimpleLuaCompBase:_setLayer(eUnityLayer, recursive, optGo)
	if isDebugBuild then
		assert(tonumber(eUnityLayer), "eUnityLayer must be a number")
	end

	optGo = optGo or self:containerGO()

	gohelper.setLayer(optGo, eUnityLayer, recursive)

	return self
end

function LibSimpleLuaCompBase:setLayerRecursive(eUnityLayer, optGo)
	self:_setLayer(eUnityLayer, true, optGo)

	return self
end

function LibSimpleLuaCompBase:setLayerSingle(eUnityLayer, optGo)
	self:_setLayer(eUnityLayer, false, optGo)

	return self
end

function LibSimpleLuaCompBase:create3d(optGoName, optParentGo)
	optParentGo = optParentGo or self:containerGO()

	return gohelper.create3d(optParentGo, optGoName)
end

function LibSimpleLuaCompBase:getOrCreateGo(nodePath, optParentGo)
	optParentGo = optParentGo or self:containerGO()

	local go = gohelper.findChild(optParentGo, nodePath)

	if gohelper.isNil(go) then
		go = self:create3d(nodePath, optParentGo)
	end

	return go
end

function LibSimpleLuaCompBase:newGoMonoBehavior(luaClass, optCtorParam, optGoName, optParentGo)
	return self:_addLuaComOnceToGo(luaClass, optCtorParam, nil, optGoName, optParentGo)
end

function LibSimpleLuaCompBase:newLuaMonobehavior(luaClass, optCtorParam)
	return self:_addLuaComOnceToGo(luaClass, optCtorParam, self:containerGO(), nil, nil)
end

function LibSimpleLuaCompBase:newObject(luaClass, optCtorParam)
	if not optCtorParam then
		self:_assertBaseThisClass(luaClass)
	end

	optCtorParam = optCtorParam or self:_getRef_ctorParam()

	return luaClass.New(optCtorParam)
end

function LibSimpleLuaCompBase:getCSRay(optScreenPosV3, optCSCamera)
	optScreenPosV3 = optScreenPosV3 or Input.mousePosition
	optCSCamera = optCSCamera or CameraMgr.instance:getMainCamera()

	return optCSCamera:ScreenPointToRay(optScreenPosV3)
end

function LibSimpleLuaCompBase:isRayOverlapCollider2DAtZ(csRay, csCollider2Dcmp, optEndWPosZ)
	if gohelper.isNil(csCollider2Dcmp) then
		return false
	end

	local rayOrigin = csRay.origin
	local rayDirection = csRay.direction
	local stZ = rayOrigin.z
	local dirZ = rayDirection.z

	if GameUtil.approximately(dirZ, 0.0001) then
		return false
	end

	optEndWPosZ = optEndWPosZ or csCollider2Dcmp.transform.position.z

	local distance = (optEndWPosZ - stZ) / dirZ

	if distance < 0 then
		return false
	end

	local pt = rayOrigin + rayDirection * distance

	return csCollider2Dcmp:OverlapPoint(Vector2(pt.x, pt.y))
end

function LibSimpleLuaCompBase:init(...)
	LibSimpleLuaCompBase.super.init(self, ...)

	return self
end

function LibSimpleLuaCompBase:addEventListeners()
	return
end

function LibSimpleLuaCompBase:removeEventListeners()
	return
end

function LibSimpleLuaCompBase:containerGO()
	if self:unitObj() then
		return self:unitGo()
	end

	if self:sceneObj() then
		return self:sceneGo()
	end
end

function LibSimpleLuaCompBase:isValid()
	return not gohelper.isNil(self:containerGO())
end

return LibSimpleLuaCompBase
