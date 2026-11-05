-- chunkname: @modules/logic/versionactivity4_1/library/entity/LibSimpleUnitBase.lua

module("modules.logic.versionactivity4_1.library.entity.LibSimpleUnitBase", package.seeall)

local LibSimpleUnitBase = class("LibSimpleUnitBase", LibSimpleLuaCompBase)

function LibSimpleUnitBase:ctor(ctorParam)
	LibSimpleUnitBase.super.ctor(self, ctorParam)

	if ctorParam then
		self:setId(ctorParam.id)
	end

	self._compList = {}
end

function LibSimpleUnitBase:onDestroy()
	self._compList = nil
	self.go = nil
	self._trans = nil

	LibSimpleUnitBase.super.onDestroy(self)
end

function LibSimpleUnitBase:setId(id)
	self.id = id

	return self
end

function LibSimpleUnitBase:unitObj()
	return self
end

function LibSimpleUnitBase:getId()
	return self.id
end

function LibSimpleUnitBase:getSceneContainerGO()
	return self:containerGO()
end

function LibSimpleUnitBase:containerGO()
	return self.go
end

function LibSimpleUnitBase:transform()
	return self._trans
end

function LibSimpleUnitBase:isValid()
	return not gohelper.isNil(self.go)
end

function LibSimpleUnitBase:WPos()
	return self._trans.position
end

function LibSimpleUnitBase:tag()
	return SceneTag.Untagged
end

function LibSimpleUnitBase:getCompList()
	return self._compList
end

function LibSimpleUnitBase:getTag()
	return self:tag()
end

function LibSimpleUnitBase:setActive(bActive, optGo)
	gohelper.setActive(optGo or self.go, bActive)

	return self
end

function LibSimpleUnitBase:setActive01(bActive, optTrans)
	GameUtil.setActive01(optTrans or self._trans, bActive)

	return self
end

function LibSimpleUnitBase:init(go, ...)
	self.go = go
	self.go.tag = self:tag()
	self._trans = go.transform

	self:_initComponents()
end

function LibSimpleUnitBase:_initComponents()
	self:initComponents()

	return self
end

function LibSimpleUnitBase:initComponents()
	return
end

function LibSimpleUnitBase:addComp(memberName, luaClass, optCtorParam)
	if isDebugBuild then
		assert(type(memberName) == "string", debug.traceback())
	end

	local monoItem = self:newLuaMonobehavior(luaClass, optCtorParam)

	self[memberName] = monoItem

	table.insert(self._compList, monoItem)

	return monoItem
end

function LibSimpleUnitBase:beforeDestroy()
	local compList = self:getCompList()

	if compList then
		for _, comp in ipairs(compList) do
			if comp.beforeDestroy then
				comp:beforeDestroy()
			end
		end
	end
end

return LibSimpleUnitBase
