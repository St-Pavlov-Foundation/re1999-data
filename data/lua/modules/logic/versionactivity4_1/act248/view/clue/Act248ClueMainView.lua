-- chunkname: @modules/logic/versionactivity4_1/act248/view/clue/Act248ClueMainView.lua

module("modules.logic.versionactivity4_1.act248.view.clue.Act248ClueMainView", package.seeall)

local Act248ClueMainView = class("Act248ClueMainView", BaseView)

function Act248ClueMainView:onInitView()
	self._goclueinfo = gohelper.findChild(self.viewGO, "root/middle/clueinfo")
	self._goclueinfo1 = gohelper.findChild(self.viewGO, "root/middle/clueinfo/#go_clueinfo1")
	self._goclueinfo2 = gohelper.findChild(self.viewGO, "root/middle/clueinfo/#go_clueinfo2")
	self._goempty = gohelper.findChild(self.viewGO, "root/middle/clueinfo/#go_empty")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Act248ClueMainView:addEvents()
	return
end

function Act248ClueMainView:removeEvents()
	return
end

function Act248ClueMainView:_editableInitView()
	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function Act248ClueMainView:onUpdateParam()
	return
end

function Act248ClueMainView:onOpen()
	Act248Model.instance:refreshClueNew()
end

function Act248ClueMainView:playAni(aniName)
	self._animator:Play(aniName, 0, 0)
end

function Act248ClueMainView:onClose()
	Act248Model.instance:refreshClueNew()

	if self.viewParam.closeCb then
		self.viewParam.closeCb(self.viewParam.closeCbobj)
	end
end

function Act248ClueMainView:onDestroyView()
	return
end

return Act248ClueMainView
