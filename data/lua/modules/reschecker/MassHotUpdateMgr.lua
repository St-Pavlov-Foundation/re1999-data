-- chunkname: @modules/reschecker/MassHotUpdateMgr.lua

module("modules.reschecker.MassHotUpdateMgr", package.seeall)

local MassHotUpdateMgr = class("MassHotUpdateMgr")

function MassHotUpdateMgr:ctor()
	self._maxRetryCount = 3
end

function MassHotUpdateMgr:loadUnmatchRes(cb, cbObj)
	self._time = Time.time
	self.cb = cb
	self.cbObj = cbObj
	self._retryCount = 0
	self._useBackupUrl = false
	SLFramework.GameUpdate.MassHotUpdate.Instance.useBackground = false

	local url, backupUrl = GameUrlConfig.getMassHotUpdateUrl()
	local gameId = SDKMgr.instance:getGameId()

	url = url .. "/" .. gameId
	backupUrl = backupUrl .. "/" .. gameId

	local allSize = SLFramework.GameUpdate.MassHotUpdate.Instance:SetUrlAndBackupUrl(url, backupUrl)

	self.eventDispatcher = SLFramework.GameLuaEventDispatcher.Instance

	self.eventDispatcher:AddListener(self.eventDispatcher.MassHotUpdate_DownloadFinish, self.onDownloadFinish, self)
	self.eventDispatcher:AddListener(self.eventDispatcher.MassHotUpdate_Progress, self.onDownloadProgress, self)
	self.eventDispatcher:AddListener(self.eventDispatcher.MassHotUpdate_NotEnoughDiskSpace, self._onDiskSpaceNotEnough, self)

	local isManualFixRes = UnityEngine.PlayerPrefs.GetFloat(PlayerPrefsKey.Manual_FixRes)

	self._fixResEntrance = isManualFixRes == 1 and "主动修复" or "自动修复"

	local resourceFixupData = {
		count = 0,
		status = "start",
		entrance = self._fixResEntrance
	}

	SDKDataTrackMgr.instance:trackResourceFixup(resourceFixupData)

	local progressMsg = booterLang("res_fixing") .. "\n" .. booterLang("fixed_content_tips")

	BootLoadingView.instance:showMsg(progressMsg)

	local timer = Timer.New(function()
		self:_startLoadUnmatchRes()
	end, 0.1)

	timer:Start()
end

function MassHotUpdateMgr:_startLoadUnmatchRes()
	self._lastRecvSize = 0
	self._allSize = 0

	SLFramework.ResChecker.Instance:LoadUnmatchRes()

	local allSize = SLFramework.GameUpdate.MassHotUpdate.Instance:GetAllSize()

	self._allSize = tonumber(tostring(allSize))
	self._lastFailedFileCount = 0
end

function MassHotUpdateMgr:onDownloadProgress(curSize, allSize)
	if self._allSize == 0 then
		local progressMsg = booterLang("mass_download")

		BootLoadingView.instance:show(0, progressMsg)

		return
	end

	local curSizeNum = tonumber(tostring(curSize))

	curSize = self._lastRecvSize + curSizeNum
	allSize = tonumber(tostring(allSize))

	local percent = curSize / self._allSize

	curSize = HotUpdateMgr.instance:_fixSizeStr(curSize)

	local allSize = HotUpdateMgr.instance:_fixSizeStr(self._allSize)
	local progressMsg = string.format(booterLang("mass_download_Progress"), curSize, allSize)

	HotUpdateProgress.instance:setProgressDownloadRes(percent, progressMsg)
end

function MassHotUpdateMgr:onDownloadFinish(failedFileCount, failSize, errorCodeList, errorMsgList)
	failSize = tonumber(tostring(failSize))

	local recvSize = self._allSize - failSize

	logNormal("MassHotUpdateMgr:onDownloadFinish cost time: " .. Time.time - self._time .. " s      recvSize = " .. recvSize .. "    failSize = " .. failSize)

	self._lastRecvSize = recvSize

	if failedFileCount == 0 then
		self:doCallBack()
	else
		self._retryCount = self._retryCount + 1

		if self._lastFailedFileCount == 0 or failedFileCount / self._lastFailedFileCount < 0.5 then
			self._lastFailedFileCount = failedFileCount

			self:retryFailedFiles()

			return
		end

		local ErrorDefine = SLFramework.GameUpdate.FailError
		local failedTip = self:_getDownloadFailedTip(errorCodeList[0], errorMsgList[0])
		local count = errorCodeList.Count

		for i = 1, count - 1 do
			local code = errorCodeList[i]

			if code == ErrorDefine.NoEnoughDisk then
				failedTip = self:_getDownloadFailedTip(errorCodeList[i], errorMsgList[i])

				break
			end
		end

		if not self._useBackupCount then
			self._useBackupCount = 1
		else
			self._useBackupCount = self._useBackupCount + 1
		end

		local useBackupUrl = self._useBackupUrl

		if self._useBackupCount == 2 then
			self._useBackupUrl = not self._useBackupUrl

			SLFramework.GameUpdate.MassHotUpdate.Instance:SetUseBackupDownloadUrl(self._useBackupUrl)

			self._useBackupCount = 0
		end

		if BootNativeUtil.getPackageName() ~= "com.shenlan.m.reverse1999.nearme.gamecenter" and SDKMgr.instance:isIgnoreFileMissing() then
			if useBackupUrl == true then
				self._lastFailedFileCount = failedFileCount

				self:_skip()
			else
				self:retryFailedFiles()
			end

			return
		end

		self._lastFailedFileCount = failedFileCount

		local args = {}

		args.title = booterLang("hotupdate")
		args.content = string.format(booterLang("mass_download_fail_other"), failedTip, failedFileCount)
		args.leftMsg = booterLang("skip")
		args.leftMsgEn = "skip"
		args.leftCb = self._skip
		args.leftCbObj = self
		args.rightMsg = booterLang("retry")
		args.rightCb = self.retryFailedFiles
		args.rightCbObj = self

		BootMsgBox.instance:show(args)
	end
end

function MassHotUpdateMgr:retryFailedFiles()
	logNormal("MassHotUpdateMgr:retryFailedFiles ,   retryCount:" .. self._retryCount)
	SLFramework.GameUpdate.MassHotUpdate.Instance:RetryFailedFiles()
end

function MassHotUpdateMgr:_onDiskSpaceNotEnough()
	logNormal("修复错误，设备磁盘空间不足！")

	local args = {}

	args.title = booterLang("hotupdate")
	args.content = booterLang("unpack_error")
	args.leftMsg = booterLang("exit")
	args.leftCb = self._quitGame
	args.leftCbObj = self
	args.rightMsg = nil

	BootMsgBox.instance:show(args)
end

function MassHotUpdateMgr:_getDownloadFailedTip(errorCode, errorMsg)
	local ErrorDefine = SLFramework.GameUpdate.FailError

	errorCode = ErrorDefine.IntToEnum(errorCode)
	self._errorCode = errorCode
	errorMsg = errorMsg or ""

	if errorCode == ErrorDefine.DownloadErrer then
		return booterLang("download_fail_download_error")
	elseif errorCode == ErrorDefine.NotFound then
		return booterLang("download_fail_not_found")
	elseif errorCode == ErrorDefine.ServerPause then
		return booterLang("download_fail_server_pause")
	elseif errorCode == ErrorDefine.TimeOut then
		return booterLang("download_fail_time_out")
	elseif errorCode == ErrorDefine.NoEnoughDisk then
		return booterLang("download_fail_no_enough_disk")
	elseif errorCode == ErrorDefine.MD5CheckError then
		return booterLang("download_fail_md5_check_error")
	else
		return booterLang("download_fail_other") .. tostring(errorMsg)
	end
end

function MassHotUpdateMgr:_skip()
	self:doCallBack(true)
end

function MassHotUpdateMgr:doCallBack(isSkip)
	if self.eventDispatcher then
		self.eventDispatcher:RemoveListener(self.eventDispatcher.MassHotUpdate_DownloadFinish)
		self.eventDispatcher:RemoveListener(self.eventDispatcher.MassHotUpdate_Progress)
		self.eventDispatcher:RemoveListener(self.eventDispatcher.MassHotUpdate_NotEnoughDiskSpace)
	end

	if isSkip ~= true then
		ResCheckMgr.instance:markLastCheckAppVersion()
		UnityEngine.PlayerPrefs.DeleteKey(PlayerPrefsKey.Manual_FixRes)
	end

	local resourceFixupData = {
		status = isSkip and "fail" or "success",
		count = self._lastFailedFileCount,
		entrance = self._fixResEntrance
	}

	SDKDataTrackMgr.instance:trackResourceFixup(resourceFixupData)

	if self.cb then
		self.cb(self.cbObj)
	end
end

function MassHotUpdateMgr:_quitGame()
	logNormal("MassHotUpdateMgr:_quitGame, 退出游戏！")
	ProjBooter.instance:quitGame()
end

MassHotUpdateMgr.instance = MassHotUpdateMgr.New()

return MassHotUpdateMgr
