-- chunkname: @modules/logic/versionactivity4_1/library/entity/comp/V4a1_LibraryBubbleComp.lua

module("modules.logic.versionactivity4_1.library.entity.comp.V4a1_LibraryBubbleComp", package.seeall)

local V4a1_LibraryBubbleComp = class("V4a1_LibraryBubbleComp", LibSimpleLuaCompBase)

function V4a1_LibraryBubbleComp:ctor(...)
	V4a1_LibraryBubbleComp.super.ctor(self, ...)

	self._usedChatIds = {}
	self._remainChatIds = {}
	self._bubbleIdList = {}
	self._isPlaying = false
	self._bubbleIndex = 0
end

function V4a1_LibraryBubbleComp:_skinId()
	return self:unitObj():skinId()
end

function V4a1_LibraryBubbleComp:_getCharChatIds()
	return V4a1_LibraryConfig.instance:getCharChatIds(self:_skinId())
end

function V4a1_LibraryBubbleComp:init(...)
	V4a1_LibraryBubbleComp.super.init(self, ...)

	self._usedChatIds = self:_getCharChatIds()
	self._remainChatIds = {}
	self._descComp = self:newObject(V4a1_LibraryBubbleComp_Desc3):init()
	self._emojiComp = self:newObject(V4a1_LibraryBubbleComp_Emoji):init()
end

function V4a1_LibraryBubbleComp:beforeDestroy()
	self._onChatFinishCb = nil
	self._onChatFinishCbObj = nil

	self:stop()
	GameUtil.beforeDestroyMember(self, "_descComp")
	GameUtil.beforeDestroyMember(self, "_emojiComp")
end

function V4a1_LibraryBubbleComp:onDestroy()
	self._onChatFinishCb = nil
	self._onChatFinishCbObj = nil

	GameUtil.beforeDestroyMember(self, "_descComp")
	GameUtil.beforeDestroyMember(self, "_emojiComp")
	V4a1_LibraryBubbleComp.super.onDestroy(self)
end

function V4a1_LibraryBubbleComp:onUpdate()
	if not self:isPlaying() then
		return
	end

	if self._descComp then
		self._descComp:onUpdate()
	end

	if self._emojiComp then
		self._emojiComp:onUpdate()
	end
end

function V4a1_LibraryBubbleComp:playRandomChat(chatFinishCb, chatFinishCbObj)
	if self:isPlaying() then
		return
	end

	self:stop()

	if #self._remainChatIds <= 0 then
		self._remainChatIds = GameUtil.shuffleArray(self._usedChatIds)
		self._usedChatIds = {}
	end

	if #self._remainChatIds <= 0 then
		if chatFinishCb then
			self._onChatFinishCb = nil
			self._onChatFinishCbObj = nil

			callWithCatch(chatFinishCb, chatFinishCbObj, self)
		else
			self:_execFinishCb()
		end

		return
	end

	self._onChatFinishCb = chatFinishCb
	self._onChatFinishCbObj = chatFinishCbObj

	local newChatId = table.remove(self._remainChatIds)

	table.insert(self._usedChatIds, newChatId)

	self._bubbleIdList = V4a1_LibraryConfig.instance:getChatBubbleIds(newChatId)
	self._bubbleIndex = 0

	self:_playNextBubble()
end

function V4a1_LibraryBubbleComp:_playNextBubble()
	self._isPlaying = true
	self._bubbleIndex = self._bubbleIndex + 1

	if self:_hasNotUsedBubble() then
		local bubbleId = self._bubbleIdList[self._bubbleIndex]

		self:_onPlayBubble(bubbleId)
	else
		self:_onChatFinished()
	end
end

function V4a1_LibraryBubbleComp:_onPlayBubble(bubbleId)
	local descCo = V4a1_LibraryConfig.instance:getChatDescCO(bubbleId)
	local emojiCo = V4a1_LibraryConfig.instance:getChatEmojiCO(bubbleId)

	if descCo then
		self._descComp:show(descCo, self._onBubbleFinished, self)
	elseif emojiCo then
		self._emojiComp:show(emojiCo, self._onBubbleFinished, self)
	else
		self:_playNextBubble()
	end
end

function V4a1_LibraryBubbleComp:_hasNotUsedBubble()
	return self._bubbleIndex <= #self._bubbleIdList
end

function V4a1_LibraryBubbleComp:_hasNextBubble()
	return self._bubbleIndex < #self._bubbleIdList
end

function V4a1_LibraryBubbleComp:_onBubbleFinished()
	local intervalSec = V4a1_LibraryConfig.instance:getBubbleIntervalSec()

	if self:_hasNextBubble() and intervalSec > 0 then
		TaskDispatcher.cancelTask(self._onBubbleIntervalDone)
		TaskDispatcher.runDelay(self._onBubbleIntervalDone, self, intervalSec)
	else
		self:_playNextBubble()
	end
end

function V4a1_LibraryBubbleComp:_onBubbleIntervalDone()
	TaskDispatcher.cancelTask(self._onBubbleIntervalDone)
	self:_playNextBubble()
end

function V4a1_LibraryBubbleComp:_onChatFinished()
	self:_execFinishCb()
	self:stop()
end

function V4a1_LibraryBubbleComp:_execFinishCb()
	if self._onChatFinishCb then
		local callback = self._onChatFinishCb
		local callbackObj = self._onChatFinishCbObj

		self._onChatFinishCb = nil
		self._onChatFinishCbObj = nil

		callWithCatch(callback, callbackObj, self)
	end
end

function V4a1_LibraryBubbleComp:stop()
	TaskDispatcher.cancelTask(self._onBubbleIntervalDone)

	self._isPlaying = false
	self._bubbleIdList = {}
	self._bubbleIndex = 0

	if self._descComp and self._descComp:isPlaying() then
		self._descComp:stop()
	end

	if self._emojiComp and self._emojiComp:isPlaying() then
		self._emojiComp:stop()
	end
end

function V4a1_LibraryBubbleComp:isPlaying()
	return self._isPlaying and true or false
end

return V4a1_LibraryBubbleComp
