-- chunkname: @modules/logic/versionactivity4_1/library/flow/LibFlowSequenceBase.lua

module("modules.logic.versionactivity4_1.library.flow.LibFlowSequenceBase", package.seeall)

local Base = GaoSiNiaoFlowSequence_Base
local LibFlowSequenceBase = class("LibFlowSequenceBase", Base)

function LibFlowSequenceBase:ctor(...)
	Base.ctor(self, ...)
end

function LibFlowSequenceBase:sceneObj()
	return self._sceneObj
end

function LibFlowSequenceBase:viewObj()
	return self._viewObj
end

function LibFlowSequenceBase:viewContainer()
	return self._viewContainer
end

function LibFlowSequenceBase:dragContext()
	return self._dragContext
end

function LibFlowSequenceBase:start(obj, ...)
	if isTypeOf(obj, BaseScene) then
		self:startBySceneObj(obj, ...)
	elseif isTypeOf(obj, BaseView) then
		self:startByViewObj(obj, ...)
	elseif isTypeOf(obj, RougeSimpleItemBase) then
		self:startByRougeSimpleItemBase(obj, ...)
	else
		assert(false, "[LibFlowSequenceBase] unsupport obj type" .. (obj and obj.cls and obj.cls.__cname) or type(oobj))
	end
end

function LibFlowSequenceBase:startBySceneObj(sceneObj)
	self:reset()

	self._sceneObj = sceneObj

	Base.start(self)
end

function LibFlowSequenceBase:startByViewObj(viewObj)
	self:reset()

	self._viewObj = viewObj
	self._viewContainer = viewObj.viewContainer

	Base.start(self)
end

function LibFlowSequenceBase:startByRougeSimpleItemBase(itemObj)
	self:reset()

	self._parentObj = itemObj:parent()
	self._viewContainer = itemObj:baseViewContainer()

	Base.start(self)
end

function LibFlowSequenceBase:startByDragContext(dragContext)
	self:reset()

	self._dragContext = dragContext
	self._viewObj = dragContext._viewObj
	self._viewContainer = dragContext._viewContainer

	Base.start(self)
end

function LibFlowSequenceBase:onStart()
	assert(false, "plase override this, and do addWork here")
end

return LibFlowSequenceBase
