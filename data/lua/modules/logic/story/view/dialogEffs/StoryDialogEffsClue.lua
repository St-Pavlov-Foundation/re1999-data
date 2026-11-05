-- chunkname: @modules/logic/story/view/dialogEffs/StoryDialogEffsClue.lua

module("modules.logic.story.view.dialogEffs.StoryDialogEffsClue", package.seeall)

local StoryDialogEffsClue = class("StoryDialogEffsClue", StoryDialogEffsBase)

function StoryDialogEffsClue:ctor()
	StoryDialogEffsClue.super.ctor(self)

	self._cluePrefabPath = "ui/viewres/story/correctionfluid.prefab"

	table.insert(self._resList, self._cluePrefabPath)

	self._clueItems = {}
end

function StoryDialogEffsClue:start(targetTxt, clueList, callback, callbackobj)
	if self:isPlayFinished() then
		if callback then
			callback(callbackobj)
		end

		return
	end

	self:clear()

	self._targetTxt = targetTxt
	self._clueList = clueList or {}
	self.isPlaying = true
	self.needTween = true
	self._finishCallback = callback
	self._finishCallbackObj = callbackobj

	self:playEffect()
end

function StoryDialogEffsClue:playEffect()
	if not self._targetTxt or #self._clueList == 0 then
		self:onPlayFinished()

		return
	end

	if not self._cluePrefab then
		if not self._loader then
			self:loadRes()
		end

		return
	end

	self._textInfo = self._targetTxt:GetTextInfo(self._targetTxt.text)

	self:buildClueItems()
	self:playClueAnim()
end

function StoryDialogEffsClue:onLoadFinished()
	local assetItem = self._loader:getAssetItem(self._cluePrefabPath)

	self._cluePrefab = assetItem:GetResource(self._cluePrefabPath)

	self:playEffect()
end

function StoryDialogEffsClue:clear()
	self.isPlaying = false
	self._isPlayFinished = false

	TaskDispatcher.cancelTask(self.realPlayAnim, self)
	self:_killTween()

	for _, item in ipairs(self._clueItems) do
		gohelper.setActive(item.go, false)
	end

	self._targetTxt = nil
	self._clueList = {}
end

function StoryDialogEffsClue:buildClueItems()
	local characterInfo = self._textInfo.characterInfo
	local list = {}

	for _, clue in ipairs(self._clueList) do
		local lineRanges = {}
		local cur

		for i = clue.startChar, clue.endChar do
			local ci = characterInfo[i]

			if ci and ci.isVisible then
				if not cur or cur.line ~= ci.lineNumber then
					cur = {
						line = ci.lineNumber,
						first = i,
						last = i
					}

					table.insert(lineRanges, cur)
				else
					cur.last = i
				end
			end
		end

		local delay = clue.delay or 0

		for _, range in ipairs(lineRanges) do
			table.insert(list, {
				clue = clue,
				firstChar = range.first,
				lastChar = range.last,
				delay = delay
			})

			delay = 0
		end
	end

	for i = 1, math.max(#list, #self._clueItems) do
		local item = self:getClueItem(i)

		self:updateClueItem(item, list[i])
	end
end

function StoryDialogEffsClue:getClueItem(index)
	local item = self._clueItems[index]

	if not item then
		item = self:getUserDataTb_()
		item.go = gohelper.clone(self._cluePrefab, self._targetTxt.gameObject, tostring(index))
		item.transform = item.go.transform
		item.image = item.go:GetComponent(gohelper.Type_Image)
		self._clueItems[index] = item
	else
		gohelper.addChild(self._targetTxt.gameObject, item.go)
	end

	return item
end

function StoryDialogEffsClue:updateClueItem(item, data)
	item.data = data

	gohelper.setActive(item.go, false)
end

function StoryDialogEffsClue:playClueAnim()
	self._animIndex = 0

	self:playNextAnim()
end

function StoryDialogEffsClue:playNextAnim()
	local nextIndex = self._animIndex + 1
	local item = self._clueItems[nextIndex]

	self._animIndex = nextIndex

	if not item or not item.data then
		self:realPlayAnim()

		return
	end

	local data = item.data
	local delayTime = data.delay or 0

	if delayTime > 0 then
		TaskDispatcher.runDelay(self.realPlayAnim, self, delayTime)
	else
		self:realPlayAnim()
	end
end

function StoryDialogEffsClue:realPlayAnim()
	local item = self._clueItems[self._animIndex]

	if not item or not item.data then
		self:onPlayFinished()

		return
	end

	self:playItemAnim(item)
end

function StoryDialogEffsClue:playItemAnim(item)
	if not self._targetTxt then
		return
	end

	local data = item.data

	if not data then
		return
	end

	local firstChar = data.firstChar
	local lastChar = data.lastChar
	local characterInfo = self._textInfo.characterInfo
	local firstCi = characterInfo[firstChar]
	local lastCi = characterInfo[lastChar]
	local lineInfo = self._textInfo.lineInfo[firstCi.lineNumber]

	if not firstCi or not lastCi or not lineInfo then
		return
	end

	local color = data.clue.color or "#FFEA88"

	SLFramework.UGUI.GuiHelper.SetColor(item.image, color)
	ZProj.UGUIHelper.SetColorAlpha(item.image, 0.6)

	local uiCamera = CameraMgr.instance:getUICamera()
	local contentTransform = self._targetTxt.transform
	local leftBottom = Vector3(firstCi.bottomLeft.x, lineInfo.descender, 0)
	local rightBottom = Vector3(lastCi.bottomRight.x, lineInfo.descender, 0)
	local leftTop = Vector3(firstCi.bottomLeft.x, lineInfo.ascender, 0)
	local bl = uiCamera:WorldToScreenPoint(contentTransform:TransformPoint(leftBottom))
	local br = uiCamera:WorldToScreenPoint(contentTransform:TransformPoint(rightBottom))
	local tl = uiCamera:WorldToScreenPoint(contentTransform:TransformPoint(leftTop))
	local p0 = contentTransform:InverseTransformPoint(uiCamera:ScreenToWorldPoint(bl))
	local p1 = contentTransform:InverseTransformPoint(uiCamera:ScreenToWorldPoint(br))
	local pTop = contentTransform:InverseTransformPoint(uiCamera:ScreenToWorldPoint(tl))
	local width = math.abs(p1.x - p0.x)
	local height = math.abs(pTop.y - p0.y)
	local posX = p0.x
	local centerY = (pTop.y + p0.y) / 2

	gohelper.setActive(item.go, true)
	recthelper.setAnchor(item.transform, posX, centerY)

	if self.needTween then
		local speed = data.clue.speed or 1

		if speed > 0 then
			local strLen = lastChar - firstChar + 1
			local time = 0.05 * strLen / speed

			recthelper.setWidth(item.transform, 0)

			item.tweenId = ZProj.TweenHelper.DOTweenFloat(0, width, time, self.onItemFrameUpdate, self.onItemAnimFinish, self, item, EaseType.Linear)
		else
			recthelper.setWidth(item.transform, width)
			self:onItemAnimFinish(item)
		end
	else
		if item.tweenId then
			ZProj.TweenHelper.KillById(item.tweenId)

			item.tweenId = nil
		end

		recthelper.setWidth(item.transform, width)
		self:onItemAnimFinish(item)
	end
end

function StoryDialogEffsClue:onItemFrameUpdate(value, item)
	recthelper.setWidth(item.transform, value)
end

function StoryDialogEffsClue:onItemAnimFinish(item)
	self:playNextAnim()
end

function StoryDialogEffsClue:onPlayFinished()
	self._isPlayFinished = true
	self.isPlaying = false

	local callback = self._finishCallback
	local callbackobj = self._finishCallbackObj

	self._finishCallback = nil
	self._finishCallbackObj = nil

	if callback then
		callback(callbackobj)
	end
end

function StoryDialogEffsClue:directShow()
	if not self.isPlaying then
		return
	end

	self.needTween = false

	TaskDispatcher.cancelTask(self.realPlayAnim, self)
	self:realPlayAnim()
end

function StoryDialogEffsClue:isCluePlaying()
	return self.isPlaying
end

function StoryDialogEffsClue:isPlayFinished()
	return self._isPlayFinished
end

function StoryDialogEffsClue:_killTween()
	if not self._clueItems then
		return
	end

	for _, item in ipairs(self._clueItems) do
		if item.tweenId then
			ZProj.TweenHelper.KillById(item.tweenId)

			item.tweenId = nil
		end
	end
end

function StoryDialogEffsClue:destroy()
	StoryDialogEffsClue.super.destroy(self)
	self:clear()
end

return StoryDialogEffsClue
