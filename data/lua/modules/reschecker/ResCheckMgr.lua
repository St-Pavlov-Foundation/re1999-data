-- chunkname: @modules/reschecker/ResCheckMgr.lua

module("modules.reschecker.ResCheckMgr", package.seeall)

local ResCheckMgr = class("ResCheckMgr")

function ResCheckMgr:ctor()
	return
end

function ResCheckMgr:startCheck(cb, cbObj)
	self.cb = cb
	self.cbObj = cbObj

	local appVersion = tonumber(BootNativeUtil.getAppVersion())
	local markVersion = SLFramework.FileHelper.ReadText(SLFramework.ResChecker.OutVersionPath)

	if tostring(appVersion) == markVersion then
		logNormal("ResCheckMgr pass, is not first init")
		self:doCallBack(true, true)

		return
	end

	SLFramework.TimeWatch.Instance:Start()

	self.eventDispatcher = SLFramework.GameLuaEventDispatcher.Instance

	self.eventDispatcher:AddListener(self.eventDispatcher.ResChecker_Finish, self.onCheckFinish, self)
	self.eventDispatcher:AddListener(self.eventDispatcher.ResChecker_Progress, self.onCheckProgress, self)

	local allLocalLang = self:_getAllLocalLang()
	local useDLC, allDLCLocalLang = self:_getDLCInfo(allLocalLang)

	if BootNativeUtil.isWindows() then
		useDLC = true

		table.insert(allDLCLocalLang, "res-HD")
	else
		local optionalUpdateInst = SLFramework.GameUpdate.OptionalUpdate.Instance
		local localVersion = optionalUpdateInst:GetLocalVersion("res-HD")
		local hasLocalVersion = not string.nilorempty(localVersion)

		if hasLocalVersion or not BootVoiceView.instance:isFirstDownloadDone() then
			useDLC = true

			table.insert(allDLCLocalLang, "res-HD")
		end
	end

	logNormal("ResCheckMgr:startCheck, allLocalLang = " .. table.concat(allLocalLang, ",") .. " useDLC = " .. tostring(useDLC) .. " allDLCLocalLang = " .. table.concat(allDLCLocalLang, ","))
	SLFramework.ResChecker.Instance:CheckAllRes(allLocalLang, useDLC, allDLCLocalLang)
end

function ResCheckMgr:onCheckProgress(doneFileNum, allFileNum)
	logNormal("ResCheckMgr:onCheckProgress, 检查进度 doneFileNum = " .. doneFileNum .. " allFileNum = " .. allFileNum)

	local percent = doneFileNum / allFileNum
	local progressMsg = string.format(booterLang("rescheker"), doneFileNum, allFileNum)

	HotUpdateProgress.instance:setProgressCheckRes(percent, doneFileNum .. "/" .. allFileNum)
end

function ResCheckMgr:onCheckFinish(allPass, allSize)
	allSize = tonumber(tostring(allSize))

	logNormal("ResCheckMgr:onCheckFinish:allPass = " .. tostring(allPass) .. " #allSize = " .. allSize .. " #cost time: " .. SLFramework.TimeWatch.Instance:Watch() .. " s")

	if allPass then
		self:doCallBack(true)
	elseif UnityEngine.Application.internetReachability == UnityEngine.NetworkReachability.ReachableViaLocalAreaNetwork then
		self:doCallBack()
	else
		local args = {}

		args.title = booterLang("hotupdate")

		local msg = booterLang("hotupdate_info")

		args.content = string.format(msg, HotUpdateMgr.instance:_fixSizeStr(allSize))
		args.leftMsg = booterLang("exit")
		args.leftCb = self._quitGame
		args.leftCbObj = self
		args.rightMsg = booterLang("download")
		args.rightCb = self.doCallBack
		args.rightCbObj = self

		BootMsgBox.instance:show(args)
	end
end

function ResCheckMgr:doCallBack(allPass, skipCheck)
	if self.eventDispatcher then
		self.eventDispatcher:RemoveListener(self.eventDispatcher.ResChecker_Finish)
		self.eventDispatcher:RemoveListener(self.eventDispatcher.ResChecker_Progress)
	end

	if allPass then
		self:markLastCheckAppVersion()

		if skipCheck then
			if self.cb then
				self.cb(self.cbObj, true)
			end
		else
			self._fakeProgress = 0
			self._fakeProgressTimer = Timer.New(function()
				self:_updateFakeProgress()
			end, 0.1, 20)

			self._fakeProgressTimer:Start()
		end
	elseif self.cb then
		self.cb(self.cbObj, allPass)
	end
end

function ResCheckMgr:_updateFakeProgress()
	self._fakeProgress = self._fakeProgress + 0.1

	HotUpdateProgress.instance:setProgressDownloadRes(self._fakeProgress)

	if self._fakeProgress >= 1 then
		self._fakeProgressTimer:Stop()

		self._fakeProgressTimer = nil

		if self.cb then
			self.cb(self.cbObj, true)
		end
	end
end

function ResCheckMgr:markLastCheckAppVersion()
	logNormal("ResCheckMgr:markLastCheckAppVersion")

	local appVersion = BootNativeUtil.getAppVersion()

	SLFramework.FileHelper.WriteTextToPath(SLFramework.ResChecker.OutVersionPath, appVersion)
end

function ResCheckMgr:_quitGame()
	logNormal("ResCheckMgr:_quitGame, 退出游戏！")
	ProjBooter.instance:quitGame()
end

function ResCheckMgr:_getAllLocalLang()
	local optionalUpdateInst = SLFramework.GameUpdate.OptionalUpdate.Instance

	optionalUpdateInst:Init()

	local langShortcuts = {}
	local supportLangList = HotUpdateVoiceMgr.instance:getSupportVoiceLangs()
	local defaultLang = GameConfig:GetDefaultVoiceShortcut()

	if not tabletool.indexOf(supportLangList, "jp") then
		table.insert(supportLangList, "jp")
	end

	if not tabletool.indexOf(supportLangList, "kr") then
		table.insert(supportLangList, "kr")
	end

	table.insert(supportLangList, "HD")

	for i = 1, #supportLangList do
		local lang = supportLangList[i]
		local default = lang == defaultLang
		local localVersion = optionalUpdateInst:GetLocalVersion(lang)
		local hasLocalVersion = not string.nilorempty(localVersion)
		local notDownloadDone = not BootVoiceView.instance:isFirstDownloadDone()

		if default or hasLocalVersion or notDownloadDone then
			table.insert(langShortcuts, lang)
		end
	end

	return langShortcuts
end

function ResCheckMgr:_getDLCInfo(allLocalLang)
	local packageTypeList = HotUpdateOptionPackageMgr.instance:getPackageNameList()
	local allDLCPackKey = {}

	for i, packageType in ipairs(packageTypeList) do
		table.insert(allDLCPackKey, HotUpdateOptionPackageMgr.instance:formatLangPackName("res", packageType))
		table.insert(allDLCPackKey, HotUpdateOptionPackageMgr.instance:formatLangPackName("media", packageType))

		for n, lang in ipairs(allLocalLang) do
			table.insert(allDLCPackKey, HotUpdateOptionPackageMgr.instance:formatLangPackName(lang, packageType))
		end
	end

	return #allDLCPackKey > 0, allDLCPackKey
end

ResCheckMgr.instance = ResCheckMgr.New()

return ResCheckMgr
