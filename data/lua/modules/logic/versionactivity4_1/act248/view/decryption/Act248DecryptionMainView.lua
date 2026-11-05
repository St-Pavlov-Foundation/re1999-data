-- chunkname: @modules/logic/versionactivity4_1/act248/view/decryption/Act248DecryptionMainView.lua

module("modules.logic.versionactivity4_1.act248.view.decryption.Act248DecryptionMainView", package.seeall)

local Act248DecryptionMainView = class("Act248DecryptionMainView", BaseView)

function Act248DecryptionMainView:onInitView()
	self._goslot = gohelper.findChild(self.viewGO, "root/#go_slot")
	self._goclue = gohelper.findChild(self.viewGO, "root/#go_clue")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Act248DecryptionMainView:addEvents()
	return
end

function Act248DecryptionMainView:removeEvents()
	return
end

function Act248DecryptionMainView:_editableInitView()
	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function Act248DecryptionMainView:onUpdateParam()
	return
end

function Act248DecryptionMainView:onOpen()
	self._fileMo = self.viewParam.fileMo
	self._fileCo = self._fileMo:getConfig()

	AudioMgr.instance:trigger(AudioEnum4_1.Act248.play_ui_atlantis_reasoning_open)
end

function Act248DecryptionMainView:playAni(aniName)
	self._animator:Play(aniName, 0, 0)
end

function Act248DecryptionMainView:onClose()
	return
end

function Act248DecryptionMainView:onDestroyView()
	return
end

return Act248DecryptionMainView
