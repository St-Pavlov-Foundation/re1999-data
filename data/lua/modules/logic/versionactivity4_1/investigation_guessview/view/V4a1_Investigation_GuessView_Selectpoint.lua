-- chunkname: @modules/logic/versionactivity4_1/investigation_guessview/view/V4a1_Investigation_GuessView_Selectpoint.lua

module("modules.logic.versionactivity4_1.investigation_guessview.view.V4a1_Investigation_GuessView_Selectpoint", package.seeall)

local V4a1_Investigation_GuessView_Selectpoint = class("V4a1_Investigation_GuessView_Selectpoint", RougeSimpleItemBase)

function V4a1_Investigation_GuessView_Selectpoint:onInitView()
	self._btnclickArea = gohelper.findChildButtonWithAudio(self.viewGO, "bubble_select/#btn_clickArea")
	self._txtdec = gohelper.findChildText(self.viewGO, "bubble_select/bubble_talk/#txt_dec")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V4a1_Investigation_GuessView_Selectpoint:addEvents()
	self._btnclickArea:AddClickListener(self._btnclickAreaOnClick, self)
end

function V4a1_Investigation_GuessView_Selectpoint:removeEvents()
	self._btnclickArea:RemoveClickListener()
end

local kPadding = 10

function V4a1_Investigation_GuessView_Selectpoint:getBubbleObj()
	local p = self:parent()

	return p:getBubbleObj(self:bubbleId())
end

function V4a1_Investigation_GuessView_Selectpoint:_btnclickAreaOnClick()
	local mo = self._mo
	local bActive = not self._bubbleTalkGo.activeSelf
	local onDelayHideHandler = self._onDelayHide
	local obj = self:getBubbleObj()

	if obj then
		if obj:bDisActive() then
			return
		elseif obj:bWaitingClick() then
			bActive = true
			onDelayHideHandler = self._onDelayHideAndShowNext

			obj:toNextState()
		end
	end

	self:setActive_bubbleTalkGo(bActive)

	if bActive then
		TaskDispatcher.cancelTask(onDelayHideHandler, self)
		TaskDispatcher.runDelay(onDelayHideHandler, self, mo and tonumber(mo.duration) or 2)
	end

	local p = self:parent()

	p:onTrackBubbleOnClick(self)
end

function V4a1_Investigation_GuessView_Selectpoint:_onDelayHide()
	self:setActive_bubbleTalkGo(false)
end

function V4a1_Investigation_GuessView_Selectpoint:_onDelayHideAndShowNext()
	self:setActive_bubbleTalkGo(false)

	local p = self:parent()

	p:onBubbleHided(self)
end

function V4a1_Investigation_GuessView_Selectpoint:ctor(...)
	V4a1_Investigation_GuessView_Selectpoint.super.ctor(self, ...)
end

function V4a1_Investigation_GuessView_Selectpoint:onDestroyView()
	TaskDispatcher.cancelTask(self._onDelayHide, self)
	TaskDispatcher.cancelTask(self._onDelayHideAndShowNext, self)
	V4a1_Investigation_GuessView_Selectpoint.super.onDestroyView(self)
end

function V4a1_Investigation_GuessView_Selectpoint:_editableInitView()
	V4a1_Investigation_GuessView_Selectpoint.super._editableInitView(self)

	self._animator = gohelper.findChild(self.viewGO, "bubble_select"):GetComponent(gohelper.Type_Animator)

	gohelper.setActive(self._goselect1, false)
	gohelper.setActive(self._goselect2, true)

	self._txtdec.text = ""
	self._bubbleTalkGo = gohelper.findChild(self.viewGO, "bubble_select/bubble_talk")
	self._goTalkTrans = self._bubbleTalkGo.transform
	self._anchorX, self._anchorY = recthelper.getAnchor(self._goTalkTrans)

	self:setActive_bubbleTalkGo(false)
end

function V4a1_Investigation_GuessView_Selectpoint:setData(mo)
	V4a1_Investigation_GuessView_Selectpoint.super.setData(self, mo)
	self:setActive(true)
	self:setDesc(mo.desc)
	UIDockingHelper.setClampToScreen(self._goTalkTrans, kPadding)

	local obj = self:getBubbleObj()

	if obj then
		if obj:bWaitingClick() then
			self:playLoopAnim()
		else
			self:stopLoopAnim()
		end
	end
end

function V4a1_Investigation_GuessView_Selectpoint:setDesc(desc)
	self._txtdec.text = desc or ""
end

function V4a1_Investigation_GuessView_Selectpoint:setPosXY(x, y)
	x = x or self._anchorX
	y = y or self._anchorY

	recthelper.setAnchor(self._goTalkTrans, self._anchorX, self._anchorY)
	self:setAPos(x, y)
end

function V4a1_Investigation_GuessView_Selectpoint:playLoopAnim()
	self._animator:Play(UIAnimationName.Open)
end

function V4a1_Investigation_GuessView_Selectpoint:stopLoopAnim()
	self._animator:Play(UIAnimationName.Idle)
end

function V4a1_Investigation_GuessView_Selectpoint:bubbleId()
	return self._mo and self._mo.id or -1
end

function V4a1_Investigation_GuessView_Selectpoint:setActive_bubbleTalkGo(bActive)
	gohelper.setActive(self._bubbleTalkGo, bActive)
end

return V4a1_Investigation_GuessView_Selectpoint
