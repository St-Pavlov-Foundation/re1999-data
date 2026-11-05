-- chunkname: @modules/logic/versionactivity4_1/library/entity/comp/V4a1_LibraryBubbleComp_Desc3.lua

module("modules.logic.versionactivity4_1.library.entity.comp.V4a1_LibraryBubbleComp_Desc3", package.seeall)

local V4a1_LibraryBubbleComp_Desc3 = class("V4a1_LibraryBubbleComp_Desc3", V4a1_LibraryBubbleComp_DescBase)
local kChatNodeName = "bubble_chat"

function V4a1_LibraryBubbleComp_Desc3:ctor(...)
	V4a1_LibraryBubbleComp_Desc3.super.ctor(self, ...)

	self._remainTime = 0
end

function V4a1_LibraryBubbleComp_Desc3:init(...)
	V4a1_LibraryBubbleComp_Desc3.super.init(self, ...)
	self:_getChatNode()

	return self
end

function V4a1_LibraryBubbleComp_Desc3:beforeDestroy()
	self._finishCb = nil
	self._finishCbObj = nil
	self._isPlaying = false
	self._curDescId = nil
	self._bubbleGO = nil
	self._curBubbleTr = nil
	self._chatCanvas = nil
	self._chatNode = nil
end

function V4a1_LibraryBubbleComp_Desc3:onUpdate()
	if not self:isPlaying() then
		return
	end

	self._remainTime = self._remainTime - UnityEngine.Time.deltaTime

	if self._remainTime > 0 then
		return
	end

	local descId = self._curDescId
	local descCo = descId and V4a1_LibraryConfig.instance:getChatDescCO(descId)

	if descCo and descCo.nextId and descCo.nextId ~= -1 then
		local nextDescCo = V4a1_LibraryConfig.instance:getChatDescCO(descCo.nextId)

		if nextDescCo then
			self:_applyDescCo(nextDescCo)

			return
		end
	end

	self:_execFinishCb()
	self:stop()
end

function V4a1_LibraryBubbleComp_Desc3:show(descCo, finishCb, finishCbObj)
	self:stop()

	local bubbleGO = self:_getBubble()

	if not bubbleGO then
		if finishCb then
			self._finishCb = nil
			self._finishCbObj = nil

			callWithCatch(finishCb, finishCbObj, self)
		else
			self:_execFinishCb()
		end

		return
	end

	self._finishCb = finishCb
	self._finishCbObj = finishCbObj

	gohelper.setActive(self._gotalk, true)
	gohelper.setActive(self._goemoji, false)
	self:_applyDescCo(descCo)

	self._isPlaying = true

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_atlantis4_1_text)
end

function V4a1_LibraryBubbleComp_Desc3:_applyDescCo(descCo)
	self._txtdesc.text = descCo.desc
	self._remainTime = descCo.duration
	self._curDescId = descCo.id
end

function V4a1_LibraryBubbleComp_Desc3:_getBubble()
	local chatNode = self:_getChatNode()

	if not chatNode then
		return
	end

	if not gohelper.isNil(self._bubbleGO) then
		gohelper.setActive(self._bubbleGO, true)

		return self._bubbleGO
	end

	local templateGo = self:getBubbleDescTemplate()

	if not templateGo then
		return
	end

	local bubbleGO = gohelper.clone(templateGo, chatNode, "bubble")

	self:_resetBubbleRect(bubbleGO.transform)

	self._bubbleGO = bubbleGO

	self:_bindBubbleNodes(bubbleGO)
	gohelper.setActive(bubbleGO, true)

	return bubbleGO
end

function V4a1_LibraryBubbleComp_Desc3:_bindBubbleNodes(bubbleGO)
	self._curBubbleGO = bubbleGO
	self._curBubbleTr = bubbleGO.transform
	self._gotalk = gohelper.findChild(bubbleGO, "#go_talk")
	self._goemoji = gohelper.findChild(bubbleGO, "#go_emoji")
	self._txtdesc = gohelper.findChildText(bubbleGO, "#go_talk/bg/#txt_desc")
end

local kUIUnitToWorldUnit = 0.01
local CanvasT = typeof(UnityEngine.Canvas)

function V4a1_LibraryBubbleComp_Desc3:_getChatNode()
	if not gohelper.isNil(self._chatNode) then
		return self._chatNode
	end

	if gohelper.isNil(self._chatNode) then
		local chatPos = self:getChatPosByCO()
		local scale = self:getScaleByCO() * kUIUnitToWorldUnit

		self._chatNode = self:create3d(kChatNodeName, self:unitGo())

		transformhelper.setLocalPosXY(self._chatNode.transform, chatPos[1], chatPos[2])
		transformhelper.setLocalScale(self._chatNode.transform, scale, scale, scale)
		self:setLayerRecursive(UnityLayer.Unit, self._chatNode)

		self._chatCanvas = gohelper.onceAddComponent(self._chatNode, CanvasT)
		self._chatCanvas.renderMode = RenderModes.get(RenderModes.WorldSpace)
		self._chatCanvas.worldCamera = CameraMgr.instance:getMainCamera()
		self._chatCanvas.overrideSorting = true
		self._chatCanvas.sortingLayerName = V4a1_LibraryConfig.instance:getCharSortingLayerName()
		self._chatCanvas.sortingOrder = self:chatCanvasSortingOrder()
	end

	return self._chatNode
end

local kV2Zero = Vector2.zero
local kV20_5 = Vector2(0.5, 0.5)

function V4a1_LibraryBubbleComp_Desc3:_resetBubbleRect(rectTransform)
	rectTransform.anchorMin = kV20_5
	rectTransform.anchorMax = kV20_5
	rectTransform.pivot = kV20_5
	rectTransform.sizeDelta = kV2Zero
end

function V4a1_LibraryBubbleComp_Desc3:_execFinishCb()
	if self._finishCb then
		local callback = self._finishCb
		local callbackObj = self._finishCbObj

		self._finishCb = nil
		self._finishCbObj = nil

		callWithCatch(callback, callbackObj, self)
	end
end

function V4a1_LibraryBubbleComp_Desc3:stop()
	self._isPlaying = false
	self._remainTime = 0
	self._curDescId = nil

	if not gohelper.isNil(self._bubbleGO) then
		gohelper.setActive(self._bubbleGO, false)
	end
end

return V4a1_LibraryBubbleComp_Desc3
