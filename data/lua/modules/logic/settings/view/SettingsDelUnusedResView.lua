-- chunkname: @modules/logic/settings/view/SettingsDelUnusedResView.lua

module("modules.logic.settings.view.SettingsDelUnusedResView", package.seeall)

local SettingsDelUnusedResView = class("SettingsDelUnusedResView", BaseView)

function SettingsDelUnusedResView:onInitView()
	self._scrollcontent = gohelper.findChildScrollRect(self.viewGO, "view/#scroll_content")
	self._btndelete = gohelper.findChildButtonWithAudio(self.viewGO, "view/btn/#btn_delete")
	self._btncancel = gohelper.findChildButtonWithAudio(self.viewGO, "view/btn/#btn_cancel")
	self._simageleftbg = gohelper.findChildSingleImage(self.viewGO, "view/bg/#simage_leftbg")
	self._simagerightbg = gohelper.findChildSingleImage(self.viewGO, "view/bg/#simage_rightbg")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SettingsDelUnusedResView:addEvents()
	self._btncancel:AddClickListener(self._btncloseOnClick, self)
	self._btndelete:AddClickListener(self._btndeleteOnClick, self)
end

function SettingsDelUnusedResView:removeEvents()
	self._btncancel:RemoveClickListener()
	self._btndelete:RemoveClickListener()
end

function SettingsDelUnusedResView:_btndeleteOnClick()
	if self._selecetType == 2 then
		local supportLangList = HotUpdateVoiceMgr.instance:getSupportVoiceLangs()

		for i, packname in pairs(OptionPackageEnum.Package) do
			HotUpdateOptionPackageMgr.instance:delLocalPackSetName(packname)
			HotUpdateOptionPackageMgr.instance:delLocalPackSetName(HotUpdateOptionPackageMgr.instance:formatLangPackName("res", packname))
			HotUpdateOptionPackageMgr.instance:delLocalPackSetName(HotUpdateOptionPackageMgr.instance:formatLangPackName("media", packname))

			for n, lang in pairs(supportLangList) do
				HotUpdateOptionPackageMgr.instance:delLocalPackSetName(HotUpdateOptionPackageMgr.instance:formatLangPackName(lang, packname))
			end
		end
	end

	SLFramework.ResChecker.Instance:DelUnusedRes(self._selecetType)
	PlayerPrefsHelper.setNumber(PlayerPrefsKey.Manual_FixRes, 1)
	SLFramework.FileHelper.DeleteFile(SLFramework.ResChecker.OutVersionPath)
	ResCheckMgr.instance:DeleteOutVersion()
	GameFacade.showMessageBox(MessageBoxIdDefine.DeleteUnusedResDone, MsgBoxEnum.BoxType.Yes, function()
		PlayerPrefsHelper.save()

		if BootNativeUtil.isAndroid() then
			if SDKMgr.restartGame ~= nil then
				SDKMgr.instance:restartGame()
			else
				ProjBooter.instance:quitGame()
			end
		else
			ProjBooter.instance:quitGame()
		end
	end)
	self:closeThis()
end

function SettingsDelUnusedResView:_btncloseOnClick()
	SLFramework.ResChecker.Instance:ClearUnusedResList()
	self:closeThis()
end

function SettingsDelUnusedResView:_editableInitView()
	self._simageleftbg:LoadImage(ResUrl.getCommonIcon("bg_1"))
	self._simagerightbg:LoadImage(ResUrl.getCommonIcon("bg_2"))

	local saveType = {
		"res-HD"
	}
	local unusedResSizeArr = SLFramework.ResChecker.Instance:GetUnusedResSize(saveType)
	local size1 = tonumber(tostring(unusedResSizeArr[0]))
	local size2 = tonumber(tostring(unusedResSizeArr[1]))
	local sizeStr1 = HotUpdateMgr.fixSizeStr(size1)
	local sizeStr2 = HotUpdateMgr.fixSizeStr(size1 + size2)

	self._listData = {
		{
			type = 1,
			txt = luaLang("SettingsDelUnusedResView_1"),
			sizeStr = sizeStr1
		},
		{
			type = 2,
			txt = luaLang("SettingsDelUnusedResView_2"),
			sizeStr = sizeStr2
		}
	}

	self.viewContainer:setListData(self._listData)
	self.viewContainer:selectCell(1)
end

function SettingsDelUnusedResView:selectCell(index)
	self.viewContainer:selectCell(index)
end

function SettingsDelUnusedResView:onUpdateParam()
	self:_refreshButton()
end

function SettingsDelUnusedResView:onOpen()
	self:addEventCb(SettingsVoicePackageController.instance, SettingsEvent.OnChangeSelecetDelUnusedRes, self._updateSelecet, self)
end

function SettingsDelUnusedResView:onClose()
	self:removeEventCb(SettingsVoicePackageController.instance, SettingsEvent.OnChangeSelecetDelUnusedRes, self._updateSelecet, self)
end

function SettingsDelUnusedResView:_updateSelecet(type)
	self._selecetType = type
end

function SettingsDelUnusedResView:onDestroyView()
	self._simageleftbg:UnLoadImage()
	self._simagerightbg:UnLoadImage()
end

return SettingsDelUnusedResView
