-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/view/develop/ArcadeSurvivorTalentView.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.view.develop.ArcadeSurvivorTalentView", package.seeall)

local ArcadeSurvivorTalentView = class("ArcadeSurvivorTalentView", BaseView)

function ArcadeSurvivorTalentView:onInitView()
	self._scrolltalent = gohelper.findChildScrollRect(self.viewGO, "root/#scroll_talent")
	self._goitem = gohelper.findChild(self.viewGO, "root/#go_item")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ArcadeSurvivorTalentView:addEvents()
	return
end

function ArcadeSurvivorTalentView:removeEvents()
	return
end

function ArcadeSurvivorTalentView:_editableInitView()
	return
end

function ArcadeSurvivorTalentView:onUpdateParam()
	return
end

function ArcadeSurvivorTalentView:onOpen()
	ArcadeSurvivorTalentListModel.instance:setMOList()
end

function ArcadeSurvivorTalentView:onTabSwitchOpen()
	ArcadeSurvivorTalentListModel.instance:onModelUpdate()
end

function ArcadeSurvivorTalentView:onClose()
	return
end

function ArcadeSurvivorTalentView:onDestroyView()
	return
end

return ArcadeSurvivorTalentView
