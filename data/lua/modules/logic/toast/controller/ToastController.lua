﻿-- chunkname: @modules/logic/toast/controller/ToastController.lua

module("modules.logic.toast.controller.ToastController", package.seeall)

local ToastController = class("ToastController", BaseController)

function ToastController:onInit()
	self._msgList = {}
	self._notToastList = {}
end

function ToastController:onInitFinish()
	return
end

function ToastController:addConstEvents()
	return
end

function ToastController:reInit()
	self._msgList = {}
	self._notToastList = {}
end

function ToastController:showToastWithIcon(toastid, icon, ...)
	self._icon = icon

	self:showToast(toastid, ...)

	self._icon = nil
end

function ToastController:showToastWithExternalCall()
	return
end

function ToastController:_showToast(msgObject, isTop)
	local viewName = isTop and ViewName.ToastTopView or ViewName.ToastView

	if not ViewMgr.instance:isOpen(viewName) then
		ViewMgr.instance:openView(viewName, msgObject)

		return
	end

	if ViewMgr.instance:isOpenFinish(viewName) then
		self:dispatchEvent(ToastEvent.ShowToast, msgObject)

		return
	end

	table.insert(self._msgList, msgObject)
end

function ToastController:showToast(toastid, ...)
	local o = self:PackToastObj(toastid, ...)

	if o and (isDebugBuild or o.co.notShow == 0) then
		self:_showToast(o)
	end
end

function ToastController:PackToastObj(toastid, ...)
	local co = toastid and ToastConfig.instance:getToastCO(toastid)

	if not co then
		logError(tostring(toastid) .. " 配置提示语！！《P飘字表》- export_飘字表")

		return
	end

	local extra = {
		...
	}
	local contain = false

	if co.notMerge == 0 then
		for _, v in pairs(self._notToastList) do
			local sameExtra = false

			if v.extra and #extra == #v.extra then
				local same = true

				for i = 1, #extra do
					if extra[i] ~= v.extra[i] then
						same = false

						break
					end
				end

				sameExtra = same
			end

			if v.toastid == toastid and sameExtra then
				contain = true

				break
			end
		end
	end

	local key = ""

	if #extra > 0 then
		for i = 1, #extra do
			key = key .. tostring(extra[i])
		end
	end

	key = tostring(toastid) .. key

	if not contain then
		local o = {}

		o.toastid = toastid
		o.extra = extra
		o.time = ServerTime.now()
		self._notToastList[key] = o
	elseif not self:isExpire(self._notToastList[key].time) then
		return
	else
		self._notToastList[key].time = ServerTime.now()
	end

	local o = {}

	o.co = co
	o.extra = extra
	o.sicon = self._icon

	return o
end

ToastController.DefaultIconType = 11

function ToastController:showToastWithString(msg, isTop)
	if self._notToastList[msg] and not self:isExpire(self._notToastList[msg].time) then
		return
	end

	local notToastObject = {
		time = ServerTime.now()
	}

	self._notToastList[msg] = notToastObject

	local msgObject = {
		co = {
			tips = msg,
			icon = ToastController.DefaultIconType
		}
	}

	self:_showToast(msgObject, isTop)
end

function ToastController:showToastWithCustomData(toastid, toastObjHandler, toastObjHandlerObj, toastObjHandlerParam, ...)
	local toastObj = self:PackToastObj(toastid, ...)

	if toastObj then
		if toastObjHandler then
			toastObjHandler(toastObjHandlerObj, toastObj, toastObjHandlerParam)
		end

		self:_showToast(toastObj)
	end
end

function ToastController:getToastMsg(toastid, ...)
	local o = self:PackToastObj(toastid, ...)
	local str = ""

	if o then
		if o.extra and #o.extra > 0 then
			str = GameUtil.getSubPlaceholderLuaLang(o.co.tips, o.extra)
		else
			str = o.co.tips
		end
	end

	return str
end

function ToastController:getToastMsgWithTableParam(toastId, paramList)
	local toastCO = toastId and ToastConfig.instance:getToastCO(toastId)

	if not toastCO then
		logError("[ToastController] P飘字表.xlsx - export_飘字表 sheet error 不存在 toastId = " .. tostring(toastId))

		return ""
	end

	return paramList and #paramList > 0 and GameUtil.getSubPlaceholderLuaLang(toastCO.tips, paramList) or toastCO.tips
end

function ToastController:isExpire(time)
	return ServerTime.now() - time >= 4
end

ToastController.instance = ToastController.New()

return ToastController
