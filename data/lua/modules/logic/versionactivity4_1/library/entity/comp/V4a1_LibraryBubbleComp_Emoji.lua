-- chunkname: @modules/logic/versionactivity4_1/library/entity/comp/V4a1_LibraryBubbleComp_Emoji.lua

module("modules.logic.versionactivity4_1.library.entity.comp.V4a1_LibraryBubbleComp_Emoji", package.seeall)

local V4a1_LibraryBubbleComp_Emoji = class("V4a1_LibraryBubbleComp_Emoji", V4a1_LibraryBubbleComp_Impl)
local kEemojiNodeName = "bubble_emoji"

function V4a1_LibraryBubbleComp_Emoji:ctor(...)
	V4a1_LibraryBubbleComp_Emoji.super.ctor(self, ...)
end

function V4a1_LibraryBubbleComp_Emoji:init(...)
	V4a1_LibraryBubbleComp_Emoji.super.init(self, ...)
	self:_getChatNode()

	return self
end

function V4a1_LibraryBubbleComp_Emoji:beforeDestroy()
	self._finishCb = nil
	self._finishCbObj = nil

	GameUtil.beforeDestroyMember(self, "_bubbleItem")

	self._chatNode = nil
end

function V4a1_LibraryBubbleComp_Emoji:show(emojiCo, finishCb, finishCbObj)
	self:stop(true)

	local bubbleItem = self:_getBubble()

	if not bubbleItem then
		if finishCb then
			self._finishCb = nil
			self._finishCbObj = nil

			callWithCatch(finishCb, finishCbObj, self)
		else
			self:onExecFinishCb()
		end

		return
	end

	self._finishCb = finishCb
	self._finishCbObj = finishCbObj

	self._bubbleItem:play(emojiCo)
end

function V4a1_LibraryBubbleComp_Emoji:onUpdate()
	if self._bubbleItem then
		self._bubbleItem:onUpdate()
	end
end

function V4a1_LibraryBubbleComp_Emoji:_getChatNode()
	if gohelper.isNil(self._chatNode) then
		local entityGO = self:unitGo()
		local emojiPos = self:getEmojiPosByCO()

		self._chatNode = gohelper.findChild(entityGO, kEemojiNodeName)

		if gohelper.isNil(self._chatNode) then
			self._chatNode = self:create3d(kEemojiNodeName, entityGO)
		end

		transformhelper.setLocalPosXY(self._chatNode.transform, emojiPos[1], emojiPos[2])
	end

	return self._chatNode
end

function V4a1_LibraryBubbleComp_Emoji:_getBubble()
	local chatNode = self:_getChatNode()

	if not chatNode then
		return
	end

	if GameUtil.isValid(self._bubbleItem) then
		return self._bubbleItem
	end

	local templateGo = self:getBubbleEmojiTemplate()

	if not templateGo then
		return
	end

	local bubbleGo = gohelper.clone(templateGo, chatNode, "bubble")

	self._bubbleItem = self:newObject(V4a1_M_S22_DYTSG_Icon)

	self._bubbleItem:init(bubbleGo)

	return self._bubbleItem
end

function V4a1_LibraryBubbleComp_Emoji:onExecFinishCb()
	if self._finishCb then
		local callback = self._finishCb
		local callbackObj = self._finishCbObj

		self._finishCb = nil
		self._finishCbObj = nil

		callWithCatch(callback, callbackObj, self)
	end
end

function V4a1_LibraryBubbleComp_Emoji:stop(bForce)
	if GameUtil.isValid(self._bubbleItem) then
		self._bubbleItem:stop(bForce)
	end
end

function V4a1_LibraryBubbleComp_Emoji:isPlaying()
	if GameUtil.isValid(self._bubbleItem) then
		return self._bubbleItem:isPlaying()
	end

	return false
end

return V4a1_LibraryBubbleComp_Emoji
