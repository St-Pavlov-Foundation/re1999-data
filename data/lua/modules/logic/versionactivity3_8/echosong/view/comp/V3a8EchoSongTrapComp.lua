-- chunkname: @modules/logic/versionactivity3_8/echosong/view/comp/V3a8EchoSongTrapComp.lua

module("modules.logic.versionactivity3_8.echosong.view.comp.V3a8EchoSongTrapComp", package.seeall)

local V3a8EchoSongTrapComp = class("V3a8EchoSongTrapComp", V3a8EchoSongBaseComp)

function V3a8EchoSongTrapComp:_onInitComp()
	self._recordInfo.isShow = self._go.activeSelf

	gohelper.setActive(self._go, true)

	local path = self._view.viewContainer:getSetting().otherRes.trapMask

	self._trapMaskGo = self._view:getResInst(path, self._go)

	gohelper.setActive(self._trapMaskGo, self._recordInfo.isShow)
end

function V3a8EchoSongTrapComp:isActivated()
	return self._recordInfo.isShow
end

function V3a8EchoSongTrapComp:rollback(info)
	if not self._rawRecordInfo then
		self._rawRecordInfo = self:getRecordInfo()
	end

	info = info or tabletool.copy(self._rawRecordInfo)
	self._recordInfo = info
	self._isFailed = false

	gohelper.setActive(self._trapMaskGo, self._recordInfo.isShow)
end

function V3a8EchoSongTrapComp:_checkMainPlayerInBounds()
	return not self._isFailed and self._recordInfo.isShow
end

function V3a8EchoSongTrapComp:_mainPlayerInBounds()
	self._isFailed = true

	V3a8EchoSongController.instance:dispatchEvent(V3a8EchoSongEvent.ShowResultView, false)
end

function V3a8EchoSongTrapComp:_showTriggerEffect()
	return true
end

function V3a8EchoSongTrapComp:setTrigger(type)
	if type == V3a8EchoSongEnum.TrapTriggerType.Auto then
		self._recordInfo.isShow = not self._recordInfo.isShow
	elseif type == V3a8EchoSongEnum.TrapTriggerType.Open then
		self._recordInfo.isShow = true
	elseif type == V3a8EchoSongEnum.TrapTriggerType.Close then
		self._recordInfo.isShow = false
	end

	gohelper.setActive(self._trapMaskGo, self._recordInfo.isShow)
	self:_addSwitchEffect()
end

function V3a8EchoSongTrapComp:_addSwitchEffect()
	if not self._switchEffectGo then
		local path = self._view.viewContainer:getSetting().otherRes.lockItem

		self._switchEffectGo = self._view:getResInst(path, self._go)
		self._switchEffectAnimator = self._switchEffectGo and self._switchEffectGo:GetComponent("Animator")
		self._switchEffectHide = gohelper.findChild(self._switchEffectGo, "node_mask/node_white")
		self._switchEffectShow = gohelper.findChild(self._switchEffectGo, "node_mask/node_red")

		local maskGo = gohelper.findChild(self._switchEffectGo, "node_mask")

		if maskGo then
			local w, h = recthelper.getWidth(self._go.transform), recthelper.getHeight(self._go.transform)

			recthelper.setSize(maskGo.transform, w, h)
		end
	end

	if self._switchEffectGo then
		gohelper.setActive(self._switchEffectHide, not self._recordInfo.isShow)
		gohelper.setActive(self._switchEffectShow, self._recordInfo.isShow)
		self._switchEffectAnimator:Play("unlock", 0, 0)
	else
		logError("V3a8EchoSongTrapComp:_addSwitchEffect is nil")
	end
end

return V3a8EchoSongTrapComp
