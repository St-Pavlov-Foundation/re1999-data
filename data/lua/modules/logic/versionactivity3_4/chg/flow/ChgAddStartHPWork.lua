-- chunkname: @modules/logic/versionactivity3_4/chg/flow/ChgAddStartHPWork.lua

module("modules.logic.versionactivity3_4.chg.flow.ChgAddStartHPWork", package.seeall)

local ChgAddStartHPWork = class("ChgAddStartHPWork", GaoSiNiaoWorkBase)

function ChgAddStartHPWork.s_create(targetItem, fromHP, toHP, durationSec)
	local work = ChgAddStartHPWork.New()

	work._targetItem = targetItem
	work._fromHP = fromHP
	work._toHP = toHP
	work._durationSec = durationSec or 0.2

	if targetItem then
		targetItem:stopDeltaNumAnim()
	end

	return work
end

function ChgAddStartHPWork:onStart()
	self:clearWork()

	if not self._targetItem then
		self:onSucc()

		return
	end

	local deltaHP = self._toHP - self._fromHP

	self._tweenId = ZProj.TweenHelper.DOTweenFloat(self._fromHP, self._toHP, self._durationSec, self._onFrameCallback, self._onFinishCallback, self)

	self._targetItem:playDeltaNumAnim(deltaHP)
end

function ChgAddStartHPWork:_onFrameCallback(value)
	local num = math.floor(value)

	self._targetItem:_refreshNum(num)
end

function ChgAddStartHPWork:_onFinishCallback()
	self:onSucc()
end

function ChgAddStartHPWork:clearWork()
	GameUtil.onDestroyViewMember_TweenId(self, "_tweenId")
	ChgAddStartHPWork.super.clearWork(self)
end

return ChgAddStartHPWork
