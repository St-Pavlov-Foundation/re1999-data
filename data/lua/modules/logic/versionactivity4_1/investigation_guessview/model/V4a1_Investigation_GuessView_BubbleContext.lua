-- chunkname: @modules/logic/versionactivity4_1/investigation_guessview/model/V4a1_Investigation_GuessView_BubbleContext.lua

local ti = table.insert

module("modules.logic.versionactivity4_1.investigation_guessview.model.V4a1_Investigation_GuessView_BubbleContext", package.seeall)

local V4a1_Investigation_GuessView_BubbleContext = class("V4a1_Investigation_GuessView_BubbleContext", UserDataDispose)

function V4a1_Investigation_GuessView_BubbleContext:ctor()
	self:clear()
end

function V4a1_Investigation_GuessView_BubbleContext:clear()
	self:__onDispose()
	self:__onInit()

	self._enabled = false
	self._viewObj = false
	self._viewContainer = false
	self._bubbles = {}
	self._taskConfigList = {}
end

function V4a1_Investigation_GuessView_BubbleContext:reset(current_V4a1_Investigation_GuessView)
	self:clear()

	self._viewObj = current_V4a1_Investigation_GuessView
	self._viewContainer = self._viewObj.viewContainer
	self._taskConfigList = Sp02_GuessMeConfig.instance:getConfigList(self:_actId())

	self:_initBubbles()
end

function V4a1_Investigation_GuessView_BubbleContext:_actId()
	return self._viewContainer:actId()
end

function V4a1_Investigation_GuessView_BubbleContext:_initBubbles()
	for i, config in ipairs(self._taskConfigList) do
		local id = config.id

		for j, bubbleId in ipairs(config.bubbleIds) do
			local bubbleObj = V4a1_Investigation_Bubble.New(self, j, bubbleId)

			bubbleObj:setDayId(id)

			self._bubbles[bubbleId] = bubbleObj

			if j == 1 then
				bubbleObj:toNextState()
			end
		end
	end
end

function V4a1_Investigation_GuessView_BubbleContext:taskConfigList()
	return self._taskConfigList or {}
end

function V4a1_Investigation_GuessView_BubbleContext:taskCount()
	return #self._taskConfigList
end

function V4a1_Investigation_GuessView_BubbleContext:getTaskCoByIndex(index)
	return self._taskConfigList[index]
end

function V4a1_Investigation_GuessView_BubbleContext:getBubbleIdListByDay(dayId)
	local config = self._taskConfigList[dayId]

	return config and config.bubbleIds or {}
end

function V4a1_Investigation_GuessView_BubbleContext:getBubbleObj(bubbleId)
	return self._bubbles[bubbleId]
end

return V4a1_Investigation_GuessView_BubbleContext
