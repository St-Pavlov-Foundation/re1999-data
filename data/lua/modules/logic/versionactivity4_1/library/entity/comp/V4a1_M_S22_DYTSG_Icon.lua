-- chunkname: @modules/logic/versionactivity4_1/library/entity/comp/V4a1_M_S22_DYTSG_Icon.lua

module("modules.logic.versionactivity4_1.library.entity.comp.V4a1_M_S22_DYTSG_Icon", package.seeall)

local V4a1_M_S22_DYTSG_Icon = class("V4a1_M_S22_DYTSG_Icon", LibSimpleUnitBase)
local CSAnimatorPlayer = SLFramework.AnimatorPlayer

function V4a1_M_S22_DYTSG_Icon:ctor(...)
	self:__onInit()
	V4a1_M_S22_DYTSG_Icon.super.ctor(self, ...)

	self._remainTime = -1
	self._isPlaying = true
	self._name2IdxDict = {}
	self._indexToHideList = {}
end

function V4a1_M_S22_DYTSG_Icon:beforeDestroy()
	V4a1_M_S22_DYTSG_Icon.super.beforeDestroy(self)
	self:__onDispose()
end

function V4a1_M_S22_DYTSG_Icon:init(...)
	V4a1_M_S22_DYTSG_Icon.super.init(self, ...)

	self._rootGo = gohelper.findChild(self.go, "root")
	self._animatorPlayer = CSAnimatorPlayer.Get(self._rootGo)

	self:_init_bubbleGoList()
end

function V4a1_M_S22_DYTSG_Icon:_init_bubbleGoList()
	self._bubbleGoList = self:getUserDataTb_()

	local i = 1

	repeat
		local go = gohelper.findChild(self._rootGo, string.format("biaoqing/v4a1_m_s22_dytsg_icon_%s", i))
		local isNil = gohelper.isNil(go)

		if not isNil then
			gohelper.setActive(go, false)

			self._name2IdxDict[go.name] = i

			table.insert(self._bubbleGoList, go)
		end

		i = i + 1
	until isNil
end

function V4a1_M_S22_DYTSG_Icon:onUpdate()
	if not self._isPlaying then
		return
	end

	self._remainTime = self._remainTime - UnityEngine.Time.deltaTime

	if self._remainTime > 0 then
		return
	end

	self:_execFinishCb()
	self:stop()
end

function V4a1_M_S22_DYTSG_Icon:_hideAllBubble()
	for i, go in ipairs(self._bubbleGoList or {}) do
		gohelper.setActive(go, false)
	end

	self._indexToHideList = {}
end

function V4a1_M_S22_DYTSG_Icon:_showBubble(index)
	for i, go in ipairs(self._bubbleGoList) do
		gohelper.setActive(go, i == index)
	end
end

function V4a1_M_S22_DYTSG_Icon:_hideBubble(index)
	if not index then
		return
	end

	gohelper.setActive(self._bubbleGoList[index], false)
end

function V4a1_M_S22_DYTSG_Icon:_execFinishCb()
	local p = self:parent()

	p:onExecFinishCb()
end

function V4a1_M_S22_DYTSG_Icon:_getLastPlayingIndex()
	return self._name2IdxDict[self:_emojiResName()]
end

function V4a1_M_S22_DYTSG_Icon:_emojiId()
	return self._emojiCo and self._emojiCo.id
end

function V4a1_M_S22_DYTSG_Icon:_emojiResName()
	return self._emojiCo and self._emojiCo.resName or ""
end

function V4a1_M_S22_DYTSG_Icon:isPlaying()
	return self._isPlaying and true or false
end

function V4a1_M_S22_DYTSG_Icon:play(emojiCo)
	local lastIndex = self:_stopLast(self._onAnimCloseDoneAndPlayNext, self)

	self._emojiCo = emojiCo

	if not lastIndex then
		self:_onAnimCloseDoneAndPlayNext()
	end
end

function V4a1_M_S22_DYTSG_Icon:stop(bForce)
	if bForce then
		self:_hideAllBubble()

		self._isPlaying = false
		self._emojiCo = nil
	else
		table.insert(self._indexToHideList, self:_getLastPlayingIndex())
		self:_stopLast(self._onAnimCloseDoneWithoutNext, self)
	end

	self._remainTime = -1
end

function V4a1_M_S22_DYTSG_Icon:_onAnimCloseDoneWithoutNext()
	local index = table.remove(self._indexToHideList, 1)

	if index then
		self:_hideBubble(index)
	end

	if #self._indexToHideList == 0 and index == self:_getLastPlayingIndex() then
		self._isPlaying = false
		self._emojiCo = nil
	end
end

function V4a1_M_S22_DYTSG_Icon:_stopLast(closeDoneCb, closeDoneCbObj)
	self._isPlaying = false

	local index = self:_getLastPlayingIndex()

	if index then
		self:_showBubble(index)
		self:_playAnimClose(closeDoneCb, closeDoneCbObj)
	end

	return index
end

function V4a1_M_S22_DYTSG_Icon:_onAnimCloseDoneAndPlayNext()
	local index = self:_getLastPlayingIndex()

	self:_showBubble(index)

	self._remainTime = index and self._emojiCo.duration or -1

	if self._remainTime > 0 then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_atlantis4_1_bubble)
		self:_playAnimOpen(self._onAnimOpenDone, self)
	end
end

function V4a1_M_S22_DYTSG_Icon:_onAnimOpenDone()
	if self._emojiCo then
		self._isPlaying = true
	else
		self:stop(true)
	end
end

function V4a1_M_S22_DYTSG_Icon:_playAnimOpen(...)
	self:_playAnim(UIAnimationName.Open, ...)
end

function V4a1_M_S22_DYTSG_Icon:_playAnimClose(...)
	self:_playAnim(UIAnimationName.Close, ...)
end

function V4a1_M_S22_DYTSG_Icon:_playAnim(animName, ...)
	self._animatorPlayer:Play(animName, ...)
end

return V4a1_M_S22_DYTSG_Icon
