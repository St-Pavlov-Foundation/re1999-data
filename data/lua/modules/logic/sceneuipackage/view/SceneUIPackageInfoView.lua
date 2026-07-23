-- chunkname: @modules/logic/sceneuipackage/view/SceneUIPackageInfoView.lua

module("modules.logic.sceneuipackage.view.SceneUIPackageInfoView", package.seeall)

local SceneUIPackageInfoView = class("SceneUIPackageInfoView", BaseView)

function SceneUIPackageInfoView:onInitView()
	self._gomainUI = gohelper.findChild(self.viewGO, "middle/#go_mainUI")
	self._gooverview = gohelper.findChild(self.viewGO, "middle/#go_overview")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "middle/#go_overview/#btn_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SceneUIPackageInfoView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self:addEventCb(MainUISwitchController.instance, MainUISwitchEvent.PreviewSwitchUIVisible, self._onSwitchUIVisible, self)
end

function SceneUIPackageInfoView:removeEvents()
	self._btnclose:RemoveClickListener()
	self:removeEventCb(MainUISwitchController.instance, MainUISwitchEvent.PreviewSwitchUIVisible, self._onSwitchUIVisible, self)
end

function SceneUIPackageInfoView:_btncloseOnClick()
	self:closeThis()
end

function SceneUIPackageInfoView:_editableInitView()
	self._root = gohelper.findChild(self.viewGO, "root")
	self._gorawImage = gohelper.findChild(self._root, "RawImage")
	self._rawImage = gohelper.onceAddComponent(self._gorawImage, gohelper.Type_RawImage)
end

function SceneUIPackageInfoView:onUpdateParam()
	return
end

function SceneUIPackageInfoView:_onSwitchUIVisible(visible)
	return
end

function SceneUIPackageInfoView:onOpen()
	local sceneId = self.viewParam and self.viewParam.sceneId or MainSceneSwitchModel.instance:getCurSceneId()

	self:_onShowSceneInfo(sceneId)
end

function SceneUIPackageInfoView:_onShowSceneInfo(id)
	self._sceneId = id

	MainSceneSwitchCameraController.instance:showScene(id, self._showSceneFinished, self)
end

function SceneUIPackageInfoView:_showSceneFinished(rt)
	gohelper.setActive(self._gorawImage, true)
	MainSceneSwitchInfoDisplayView.adjustRt(self._rawImage, rt)
end

function SceneUIPackageInfoView.adjustRt(rawImage, rt)
	rawImage.texture = rt

	rawImage:SetNativeSize()

	local width = rt.width
	local root = ViewMgr.instance:getUIRoot().transform
	local containerWidth = recthelper.getWidth(root)
	local scale = containerWidth / width

	transformhelper.setLocalScale(rawImage.transform, scale, scale, 1)
end

function SceneUIPackageInfoView:onClose()
	if not self.viewParam.isCloseMoHideScene then
		MainSceneSwitchCameraController.instance:clear()
	end
end

function SceneUIPackageInfoView:onDestroyView()
	return
end

return SceneUIPackageInfoView
