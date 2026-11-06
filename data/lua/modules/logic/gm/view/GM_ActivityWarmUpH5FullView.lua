-- chunkname: @modules/logic/gm/view/GM_ActivityWarmUpH5FullView.lua

local ti = table.insert
local sf = string.format

module("modules.logic.gm.view.GM_ActivityWarmUpH5FullView", package.seeall)

local GM_ActivityWarmUpH5FullView = class("GM_ActivityWarmUpH5FullView", BaseView)
local kYellow = "#FFFF00"

function GM_ActivityWarmUpH5FullView.register()
	GM_ActivityWarmUpH5FullView.ActivityWarmUpH5FullView_register(ActivityWarmUpH5FullView)
end

function GM_ActivityWarmUpH5FullView.ActivityWarmUpH5FullView_register(T)
	GMMinusModel.instance:saveOriginalFunc(T, "_editableInitView")
	GMMinusModel.instance:saveOriginalFunc(T, "addEvents")
	GMMinusModel.instance:saveOriginalFunc(T, "removeEvents")
	GMMinusModel.instance:saveOriginalFunc(T, "_reqUrl")

	function T._editableInitView(selfObj, ...)
		GMMinusModel.instance:callOriginalSelfFunc(selfObj, "_editableInitView", ...)

		local btnGM = GMMinusModel.instance:addBtnGM(selfObj)

		UIDockingHelper.setDock(UIDockingHelper.Dock.RT_LB, btnGM.transform, selfObj.viewGO.transform, -15)
	end

	function T:addEvents(...)
		GMMinusModel.instance:callOriginalSelfFunc(self, "addEvents", ...)
		GMMinusModel.instance:btnGM_AddClickListener(self)
		GM_ActivityWarmUpH5FullViewContainer.addEvents(self)
	end

	function T:removeEvents(...)
		GMMinusModel.instance:callOriginalSelfFunc(self, "removeEvents", ...)
		GMMinusModel.instance:btnGM_RemoveClickListener(self)
		GM_ActivityWarmUpH5FullViewContainer.removeEvents(self)
	end

	function T:_reqUrl(...)
		if GM_ActivityWarmUpH5FullView.s_OnUseTestEnv then
			local kGameId = tostring(SDKMgr.instance:getGameId())
			local kChannelId = tostring(SDKMgr.instance:getChannelId())
			local kSubChannelId = tostring(SDKMgr.instance:getSubChannelId())
			local kServerType = 2
			local kBaseUrl = "https://notice-test.sl916.com/app-activity/h5-entry/query?"
			local strBuf = {}

			ti(strBuf, kBaseUrl)
			ti(strBuf, sf("gameId=%s", kGameId))
			ti(strBuf, sf("channelId=%s", kChannelId))
			ti(strBuf, sf("subChannelId=%s", kSubChannelId))
			ti(strBuf, sf("serverType=%s", kServerType))
			ti(strBuf, sf("timestamp=%s", ServerTime.now() * 1000))

			local reqUrl = table.concat(strBuf, "&")

			return reqUrl
		end

		return GMMinusModel.instance:callOriginalSelfFunc(self, "_reqUrl", ...)
	end

	function T._gm_onUseTestEnv(selfObj)
		selfObj._retrySendReqCnt = 0

		selfObj:onUpdateParam()
	end

	function T._gm_onClickDeleteLocalFile(selfObj)
		selfObj:_deleteLocalFiles()
	end

	function T._gm_onClickDeletePlayerPrefsKey(selfObj)
		local tbl = {
			[1] = "[ActivityWarmUpH5FullView:_gm_onClickDeletePlayerPrefsKey] =========== begin",
			[2] = "last: " .. tostring(selfObj.viewContainer:getDownloadedPicUrl())
		}

		selfObj.viewContainer:clearDownloadedPicUrl()
		ti(tbl, "current: " .. tostring(selfObj.viewContainer:getDownloadedPicUrl()))
		ti(tbl, "[ActivityWarmUpH5FullView:_gm_onClickDeletePlayerPrefsKey] =========== end")
		ddde(table.concat(tbl, "\n"))
	end
end

function GM_ActivityWarmUpH5FullView:onInitView()
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "btnClose")
	self._item1Toggle = gohelper.findChildToggle(self.viewGO, "viewport/content/item1/Toggle")
	self._item2Btn = gohelper.findChildButtonWithAudio(self.viewGO, "viewport/content/item2/Button")
	self._item3Btn = gohelper.findChildButtonWithAudio(self.viewGO, "viewport/content/item3/Button")
end

function GM_ActivityWarmUpH5FullView:addEvents()
	self._btnClose:AddClickListener(self.closeThis, self)
	self._item1Toggle:AddOnValueChanged(self._onItem1ToggleValueChanged, self)
	self._item2Btn:AddClickListener(self._onItem2Click, self)
	self._item3Btn:AddClickListener(self._onItem3Click, self)
end

function GM_ActivityWarmUpH5FullView:removeEvents()
	self._btnClose:RemoveClickListener()
	self._item1Toggle:RemoveOnValueChanged()
	self._item2Btn:RemoveClickListener()
	self._item3Btn:RemoveClickListener()
end

function GM_ActivityWarmUpH5FullView:onOpen()
	self:_refreshItem1()
end

function GM_ActivityWarmUpH5FullView:onDestroyView()
	return
end

GM_ActivityWarmUpH5FullView.s_OnUseTestEnv = false

function GM_ActivityWarmUpH5FullView:_refreshItem1()
	local isOn = GM_ActivityWarmUpH5FullView.s_OnUseTestEnv

	self._item1Toggle.isOn = isOn
end

function GM_ActivityWarmUpH5FullView:_onItem1ToggleValueChanged()
	local isOn = self._item1Toggle.isOn

	GM_ActivityWarmUpH5FullView.s_OnUseTestEnv = isOn

	GMController.instance:dispatchEvent(GMEvent.ActivityWarmUpH5FullView_OnUseTestEnv, isOn)
end

function GM_ActivityWarmUpH5FullView:_onItem2Click()
	GMController.instance:dispatchEvent(GMEvent.ActivityWarmUpH5FullView_OnClickDeleteLocalFile)
end

function GM_ActivityWarmUpH5FullView:_onItem3Click()
	GMController.instance:dispatchEvent(GMEvent.ActivityWarmUpH5FullView_OnClickDeletePlayerPrefsKey)
end

return GM_ActivityWarmUpH5FullView
