﻿-- chunkname: @modules/logic/versionactivity2_2/enter/view/subview/V2a2_TianShiNaNaEnterView.lua

module("modules.logic.versionactivity2_2.enter.view.subview.V2a2_TianShiNaNaEnterView", package.seeall)

local V2a2_TianShiNaNaEnterView = class("V2a2_TianShiNaNaEnterView", VersionActivityEnterBaseSubView)

function V2a2_TianShiNaNaEnterView:onInitView()
	self._txtLimitTime = gohelper.findChildTextMesh(self.viewGO, "image_LimitTimeBG/#txt_LimitTime")
	self._txtDescr = gohelper.findChildTextMesh(self.viewGO, "#txt_Descr")
	self._btnEnter = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_Enter")
	self._gored = gohelper.findChild(self.viewGO, "Right/#btn_Enter/#go_reddot")
	self._btnLocked = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_Locked")
	self._btnTrial = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#go_Try/image_TryBtn")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V2a2_TianShiNaNaEnterView:addEvents()
	self._btnEnter:AddClickListener(self._enterGame, self)
	self._btnLocked:AddClickListener(self._clickLock, self)
	self._btnTrial:AddClickListener(self._clickTrial, self)
end

function V2a2_TianShiNaNaEnterView:removeEvents()
	self._btnEnter:RemoveClickListener()
	self._btnLocked:RemoveClickListener()
	self._btnTrial:RemoveClickListener()
end

function V2a2_TianShiNaNaEnterView:_editableInitView()
	self.actCo = ActivityConfig.instance:getActivityCo(VersionActivity2_2Enum.ActivityId.TianShiNaNa)
	self._txtDescr.text = self.actCo.actDesc
end

function V2a2_TianShiNaNaEnterView:onOpen()
	V2a2_TianShiNaNaEnterView.super.onOpen(self)
	RedDotController.instance:addRedDot(self._gored, RedDotEnum.DotNode.V2a2TianShiNaNaTaskRed, VersionActivity2_2Enum.ActivityId.TianShiNaNa)
	self:_refreshTime()
end

function V2a2_TianShiNaNaEnterView:_enterGame()
	TianShiNaNaController.instance:openMainView()
end

function V2a2_TianShiNaNaEnterView:_clickLock()
	local toastId, toastParamList = OpenHelper.getToastIdAndParam(self.actCo.openId)

	if toastId and toastId ~= 0 then
		GameFacade.showToastWithTableParam(toastId, toastParamList)
	end
end

function V2a2_TianShiNaNaEnterView:_clickTrial()
	if ActivityHelper.getActivityStatus(VersionActivity2_2Enum.ActivityId.TianShiNaNa) == ActivityEnum.ActivityStatus.Normal then
		local episodeId = self.actCo.tryoutEpisode

		if episodeId <= 0 then
			logError("没有配置对应的试用关卡")

			return
		end

		local config = DungeonConfig.instance:getEpisodeCO(episodeId)

		DungeonFightController.instance:enterFight(config.chapterId, episodeId)
	else
		self:_clickLock()
	end
end

function V2a2_TianShiNaNaEnterView:everySecondCall()
	self:_refreshTime()
end

function V2a2_TianShiNaNaEnterView:_refreshTime()
	local actInfoMo = ActivityModel.instance:getActivityInfo()[VersionActivity2_2Enum.ActivityId.TianShiNaNa]

	if actInfoMo then
		local offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()

		gohelper.setActive(self._txtLimitTime.gameObject, offsetSecond > 0)

		if offsetSecond > 0 then
			local dateStr = TimeUtil.SecondToActivityTimeFormat(offsetSecond)

			self._txtLimitTime.text = dateStr
		end

		local isLock = ActivityHelper.getActivityStatus(VersionActivity2_2Enum.ActivityId.TianShiNaNa) ~= ActivityEnum.ActivityStatus.Normal

		gohelper.setActive(self._btnEnter, not isLock)
		gohelper.setActive(self._btnLocked, isLock)
	end
end

return V2a2_TianShiNaNaEnterView
