-- chunkname: @modules/logic/versionactivity3_8/echosong/view/comp/V3a8EchoSongBaseComp.lua

module("modules.logic.versionactivity3_8.echosong.view.comp.V3a8EchoSongBaseComp", package.seeall)

local V3a8EchoSongBaseComp = class("V3a8EchoSongBaseComp", LuaCompBase)

function V3a8EchoSongBaseComp:init(go)
	self._go = go
end

function V3a8EchoSongBaseComp:getGo()
	return self._go
end

function V3a8EchoSongBaseComp:isActivated()
	return true
end

function V3a8EchoSongBaseComp:_showTriggerEffect()
	return false
end

function V3a8EchoSongBaseComp:_addTriggerEffect()
	if not self._triggerEffectGo then
		local path = self._view.viewContainer:getSetting().otherRes.switchEvent

		self._triggerEffectGo = self._view:getResInst(path, self._go)
	end

	if self._triggerEffectGo then
		gohelper.setActive(self._triggerEffectGo, false)
		gohelper.setActive(self._triggerEffectGo, true)
	else
		logError("V3a8EchoSongBaseComp:_addTriggerEffect is nil")
	end
end

function V3a8EchoSongBaseComp:initComp(view, type, id, params, paramList)
	self._view = view
	self._type = type
	self._id = id
	self._params = params
	self._paramList = paramList
	self._recordInfo = {
		type = type,
		id = id
	}
	self._tempCheckPos = Vector2()
	self._checkRect = self._go.transform.rect
	self._exitPadding = 10
	self._inBoundsState = false

	self:_onInitComp()
end

function V3a8EchoSongBaseComp:_onInitComp()
	return
end

function V3a8EchoSongBaseComp:rollback(info)
	return
end

function V3a8EchoSongBaseComp:getRecordInfo()
	return tabletool.copy(self._recordInfo)
end

function V3a8EchoSongBaseComp:getType()
	return self._type
end

function V3a8EchoSongBaseComp:_checkMainPlayerInBounds()
	return false
end

function V3a8EchoSongBaseComp:_mainPlayerInBounds()
	return
end

function V3a8EchoSongBaseComp:_mainPlayerOutOfBounds()
	return
end

function V3a8EchoSongBaseComp:_onMoveMainPlayer(anchorPos, mainPlayerWorldX, mainPlayerWorldY)
	if not self:_checkMainPlayerInBounds() then
		return
	end

	if not mainPlayerWorldX then
		return
	end

	local localPos = self._go.transform:InverseTransformPoint(mainPlayerWorldX, mainPlayerWorldY, 0)

	self._tempCheckPos.x = localPos.x
	self._tempCheckPos.y = localPos.y

	local isInside = self:_isInsideWithHysteresis(self._tempCheckPos)

	if isInside == self._inBoundsState then
		return
	end

	self._inBoundsState = isInside

	if isInside then
		self:_mainPlayerInBounds()

		if self:_showTriggerEffect() then
			self:_addTriggerEffect()
		end
	else
		self:_mainPlayerOutOfBounds()
	end
end

function V3a8EchoSongBaseComp:_isInsideWithHysteresis(checkPos)
	if not self._inBoundsState then
		return self._checkRect:Contains(checkPos)
	end

	local pad = self._exitPadding or 0
	local rect = self._checkRect

	return checkPos.x >= rect.x - pad and checkPos.x <= rect.x + rect.width + pad and checkPos.y >= rect.y - pad and checkPos.y <= rect.y + rect.height + pad
end

function V3a8EchoSongBaseComp:addEventListeners()
	V3a8EchoSongController.instance:registerCallback(V3a8EchoSongEvent.MoveMainPlayer, self._onMoveMainPlayer, self)
end

function V3a8EchoSongBaseComp:removeEventListeners()
	V3a8EchoSongController.instance:unregisterCallback(V3a8EchoSongEvent.MoveMainPlayer, self._onMoveMainPlayer, self)
end

return V3a8EchoSongBaseComp
