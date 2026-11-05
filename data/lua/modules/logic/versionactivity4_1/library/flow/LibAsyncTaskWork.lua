-- chunkname: @modules/logic/versionactivity4_1/library/flow/LibAsyncTaskWork.lua

module("modules.logic.versionactivity4_1.library.flow.LibAsyncTaskWork", package.seeall)

local LibAsyncTaskWork = class("LibAsyncTaskWork", WmzWorkBase)

function LibAsyncTaskWork.s_create(sender, evtName, a1, a2, a3, a4, a5)
	local work = LibAsyncTaskWork.New()

	work._sender = sender
	work._evtName = evtName
	work._a1 = a1
	work._a2 = a2
	work._a3 = a3
	work._a4 = a4
	work._a5 = a5

	return work
end

function LibAsyncTaskWork.s_createWithFunc(func, sender, evtName, a1, a2, a3, a4, a5)
	local work = LibAsyncTaskWork.s_create(sender, evtName, a1, a2, a3, a4, a5)

	work._func = func

	return work
end

function LibAsyncTaskWork:onStart()
	self:clearWork()

	if not self._sender then
		logWarn("_sender is null")
		self:onSucc()

		return
	end

	if not self._evtName then
		logWarn("_evtName is null")
		self:onSucc()

		return
	end

	local func = self._func or self._sender.onExec_LibAsyncTaskWork

	if not func then
		logWarn("_func is null")
		self:onSucc()

		return
	end

	self:startBlock(nil, 1)
	self._sender:registerCallback(self._evtName, self._onDispatchedEvt, self)
	func(self._sender)
end

function LibAsyncTaskWork:_onDispatchedEvt(a1, a2, a3, a4, a5)
	if self._a1 ~= nil then
		if a1 ~= self._a1 then
			return
		end

		if a2 ~= self._a2 then
			return
		end

		if a3 ~= self._a3 then
			return
		end

		if a4 ~= self._a4 then
			return
		end

		if a5 ~= self._a5 then
			return
		end
	end

	self._sender:unregisterCallback(self._evtName, self._onDispatchedEvt, self)
	self:onSucc()
end

function LibAsyncTaskWork:clearWork()
	if self._sender and self._evtName then
		self._sender:unregisterCallback(self._evtName, self._onDispatchedEvt, self)
	end
end

return LibAsyncTaskWork
