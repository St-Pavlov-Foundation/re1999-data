-- chunkname: @modules/logic/versionactivity4_1/investigation_guessview/model/V4a1_Investigation_Bubble.lua

module("modules.logic.versionactivity4_1.investigation_guessview.model.V4a1_Investigation_Bubble", package.seeall)

local V4a1_Investigation_Bubble = class("V4a1_Investigation_Bubble")
local State = {
	Clicked = 2,
	WaitingClick = 1,
	DisActive = 0
}

V4a1_Investigation_Bubble.State = State

function V4a1_Investigation_Bubble:bDisActive()
	return self._state == State.DisActive
end

function V4a1_Investigation_Bubble:bWaitingClick()
	return self._state == State.WaitingClick
end

function V4a1_Investigation_Bubble:bClicked()
	return self._state == State.Clicked
end

function V4a1_Investigation_Bubble:ctor(ctx, gpIndex, activity238_bubble_desc_id)
	self._ctx = ctx
	self._state = State.DisActive
	self._gpIndex = gpIndex
	self._bubbleDescCO = Sp02_GuessMeConfig.instance:getBubbleDescCO(activity238_bubble_desc_id)

	self:resetToInit()
end

function V4a1_Investigation_Bubble:toNextState()
	if self._state < State.Clicked then
		self._state = self._state + 1
	end
end

function V4a1_Investigation_Bubble:setState(state)
	self._state = state
end

function V4a1_Investigation_Bubble:resetToInit()
	self._dayId = -1
	self._state = State.DisActive
end

function V4a1_Investigation_Bubble:dayId()
	return self._dayId
end

function V4a1_Investigation_Bubble:setDayId(dayId)
	self._dayId = dayId or -1
end

function V4a1_Investigation_Bubble:bubbleId()
	return self._bubbleDescCO.id
end

function V4a1_Investigation_Bubble:gpIndex()
	return self._gpIndex
end

return V4a1_Investigation_Bubble
