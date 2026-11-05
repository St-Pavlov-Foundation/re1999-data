-- chunkname: @modules/logic/versionactivity4_1/library/entity/comp/V4a1_LibraryBubbleComp_Desc2.lua

module("modules.logic.versionactivity4_1.library.entity.comp.V4a1_LibraryBubbleComp_Desc2", package.seeall)

local V4a1_LibraryBubbleComp_Desc2 = class("V4a1_LibraryBubbleComp_Desc2", V4a1_LibraryBubbleComp_DescBase)

function V4a1_LibraryBubbleComp_Desc2:ctor(...)
	V4a1_LibraryBubbleComp_Desc2.super.ctor(self, ...)

	self._bubblePool = {}
end

function V4a1_LibraryBubbleComp_Desc2:show(descCo, finishCb, finishCbObj)
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

	self._txtdesc.text = descCo.desc
	self._remainTime = descCo.duration
	self._curDescId = descCo.id
	self._isPlaying = true

	self:_refreshBubblePos()
end

function V4a1_LibraryBubbleComp_Desc2:onUpdate()
	if not self._isPlaying then
		return
	end

	self:_refreshBubblePos()

	self._remainTime = self._remainTime - UnityEngine.Time.deltaTime

	if self._remainTime > 0 then
		return
	end

	local descId = self._curDescId
	local descCo = descId and self:getChatDescCO(descId)

	if descCo and descCo.nextId and descCo.nextId ~= -1 then
		local nextCo = self:getChatDescCO(descCo.nextId)

		if nextCo then
			self:_showNext(nextCo)

			return
		end
	end

	self:_execFinishCb()
	self:stop()
end

function V4a1_LibraryBubbleComp_Desc2:_showNext(descCo)
	self._txtdesc.text = descCo.desc
	self._remainTime = descCo.duration
	self._curDescId = descCo.id
end

function V4a1_LibraryBubbleComp_Desc2:_getBubble()
	local mainView = self:getMainView()
	local template = mainView and mainView:getBubbleDescTemplate()

	if not template then
		return
	end

	for _, bubbleGO in ipairs(self._bubblePool) do
		if not gohelper.isNil(bubbleGO) and not bubbleGO.activeSelf then
			self:_bindBubbleNodes(bubbleGO)
			gohelper.setActive(bubbleGO, true)

			return bubbleGO
		end
	end

	local bubbleGO = gohelper.clone(template, mainView.viewGO, "bubble_" .. tostring(self:_skinId()))

	self:_resetBubbleRect(bubbleGO.transform)
	table.insert(self._bubblePool, bubbleGO)
	self:_bindBubbleNodes(bubbleGO)
	gohelper.setActive(bubbleGO, true)

	return bubbleGO
end

function V4a1_LibraryBubbleComp_Desc2:_bindBubbleNodes(bubbleGO)
	self._curBubbleGO = bubbleGO
	self._curBubbleTr = bubbleGO.transform
	self._gotalk = gohelper.findChild(bubbleGO, "#go_talk")
	self._goemoji = gohelper.findChild(bubbleGO, "#go_emoji")
	self._txtdesc = gohelper.findChildText(bubbleGO, "#go_talk/bg/#txt_desc")
end

function V4a1_LibraryBubbleComp_Desc2:_resetBubbleRect(rectTransform)
	rectTransform.anchorMin = Vector2(0.5, 0.5)
	rectTransform.anchorMax = Vector2(0.5, 0.5)
	rectTransform.pivot = Vector2(0.5, 0.5)
	rectTransform.sizeDelta = Vector2.zero
end

function V4a1_LibraryBubbleComp_Desc2:_refreshBubblePos()
	if not self._curBubbleTr then
		return
	end

	local mainView = self:getMainView()

	if not mainView then
		return
	end

	local pos = self:getUnitPosition()
	local chatPos = self:getChatPosByCO()
	local worldPos = Vector3(pos.x + (chatPos[1] or 0), pos.y + (chatPos[2] or 0), pos.z)
	local screenPos = CameraMgr.instance:getMainCamera():WorldToScreenPoint(worldPos)
	local anchorX, anchorY = recthelper.screenPosToAnchorPos2(screenPos, mainView.viewGO.transform)

	anchorX, anchorY = self:_clampBubblePos(anchorX, anchorY, mainView.viewGO.transform)
	self._curBubbleTr.anchoredPosition = Vector2(anchorX, anchorY)
end

function V4a1_LibraryBubbleComp_Desc2:_clampBubblePos(anchorX, anchorY, viewTr)
	local halfViewWidth = recthelper.getWidth(viewTr) * 0.5
	local halfViewHeight = recthelper.getHeight(viewTr) * 0.5
	local halfBubbleWidth = recthelper.getWidth(self._curBubbleTr) * 0.5
	local halfBubbleHeight = recthelper.getHeight(self._curBubbleTr) * 0.5

	anchorX = GameUtil.clamp(anchorX, -halfViewWidth + halfBubbleWidth, halfViewWidth - halfBubbleWidth)
	anchorY = GameUtil.clamp(anchorY, -halfViewHeight + halfBubbleHeight, halfViewHeight - halfBubbleHeight)

	return anchorX, anchorY
end

function V4a1_LibraryBubbleComp_Desc2:_execFinishCb()
	if self._finishCb then
		local callback = self._finishCb
		local callbackObj = self._finishCbObj

		self._finishCb = nil
		self._finishCbObj = nil

		callWithCatch(callback, callbackObj, self)
	end
end

function V4a1_LibraryBubbleComp_Desc2:stop()
	self._isPlaying = false
	self._remainTime = nil
	self._curDescId = nil
	self._finishCb = nil
	self._finishCbObj = nil

	if not gohelper.isNil(self._curBubbleGO) then
		gohelper.setActive(self._curBubbleGO, false)
	end
end

function V4a1_LibraryBubbleComp_Desc2:beforeDestroy()
	self:stop()

	for _, bubbleGO in ipairs(self._bubblePool or {}) do
		if not gohelper.isNil(bubbleGO) then
			gohelper.destroy(bubbleGO)
		end
	end

	self._bubblePool = nil
	self._curBubbleGO = nil
	self._curBubbleTr = nil
end

return V4a1_LibraryBubbleComp_Desc2
