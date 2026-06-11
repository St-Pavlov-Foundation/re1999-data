-- chunkname: @modules/logic/versionactivity3_8/echosong/view/comp/V3a8EchoSongWallComp.lua

module("modules.logic.versionactivity3_8.echosong.view.comp.V3a8EchoSongWallComp", package.seeall)

local V3a8EchoSongWallComp = class("V3a8EchoSongWallComp", V3a8EchoSongBaseComp)

function V3a8EchoSongWallComp:_onInitComp()
	if not self._params then
		logError("V3a8EchoSongWallComp:_onInitComp params is nil", self._type, self._id)
	end

	self._recordInfo.isShow = true
end

function V3a8EchoSongWallComp:rollback(info)
	if not self._rawRecordInfo then
		self._rawRecordInfo = self:getRecordInfo()
	end

	info = info or tabletool.copy(self._rawRecordInfo)
	self._recordInfo = info

	gohelper.setActive(self._go, self._recordInfo.isShow)
end

function V3a8EchoSongWallComp:addEventListeners()
	V3a8EchoSongWallComp.super.addEventListeners(self)
	V3a8EchoSongController.instance:registerCallback(V3a8EchoSongEvent.FinishEvent1, self._onFinishEvent1, self)
end

function V3a8EchoSongWallComp:removeEventListeners()
	V3a8EchoSongWallComp.super.removeEventListeners(self)
	V3a8EchoSongController.instance:unregisterCallback(V3a8EchoSongEvent.FinishEvent1, self._onFinishEvent1, self)
end

function V3a8EchoSongWallComp:_onFinishEvent1(id)
	if self._params and tabletool.indexOf(self._params, id) then
		self._recordInfo[id] = true

		for k, v in pairs(self._params) do
			if not self._recordInfo[v] then
				return
			end
		end

		self._recordInfo.isShow = false

		self:_addSwitchEffect()
	end
end

function V3a8EchoSongWallComp:_addSwitchEffect()
	if not self._switchEffectGo then
		local path = self._view.viewContainer:getSetting().otherRes.lockItem

		self._switchEffectGo = self._view:getResInst(path, self._go)
		self._switchEffectAnimator = self._switchEffectGo and ZProj.ProjAnimatorPlayer.Get(self._switchEffectGo)
		self._switchEffectHide = gohelper.findChild(self._switchEffectGo, "node_mask/node_white")
		self._switchEffectShow = gohelper.findChild(self._switchEffectGo, "node_mask/node_red")

		local maskGo = gohelper.findChild(self._switchEffectGo, "node_mask")

		if maskGo then
			local w, h = recthelper.getWidth(self._go.transform), recthelper.getHeight(self._go.transform)

			recthelper.setSize(maskGo.transform, w, h)
		end
	end

	if self._switchEffectGo then
		gohelper.setActive(self._switchEffectHide, true)
		gohelper.setActive(self._switchEffectShow, false)
		self._switchEffectAnimator:Play("unlock", self._unlockDone, self)
	else
		logError("V3a8EchoSongWallComp:_addSwitchEffect is nil")
	end
end

function V3a8EchoSongWallComp:_unlockDone()
	gohelper.setActive(self._go, false)
end

return V3a8EchoSongWallComp
