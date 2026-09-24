-- chunkname: @modules/logic/handbook/view/HandbookScene_Seven.lua

module("modules.logic.handbook.view.HandbookScene_Seven", package.seeall)

local HandbookScene_Seven = class("HandbookScene_Seven")
local centerCardIdx = 3
local cardCount = 5
local dragRate = 0.00075
local maxDragProgressPerFrame = 0.15
local cardDefaultPosMap = {
	0.8333,
	0.6667,
	0.5,
	0.3333,
	0.1667
}
local resetPosDuration = 0.25
local openDetailDuration = 0.1

function HandbookScene_Seven:ctor()
	self._enterAniDone = false
	self._redDotComp = nil
	self._unlockVxLoader = nil
end

function HandbookScene_Seven:setScene(scene)
	self._scene = scene
end

function HandbookScene_Seven:setupRedDot(redDotComp)
	self._redDotComp = redDotComp
end

function HandbookScene_Seven:enterScene()
	local scene = self._scene

	if scene._sevenMode then
		return
	end

	scene._tarotCardAniProgress = {}
	scene._enteringSevenMode = true

	scene._sceneAnimatorPlayer:Play(UIAnimationName.Click, nil, nil)
	scene.viewContainer:dispatchEvent(HandbookEvent.OnClickSevenSkinSuit)

	scene._tarotCardDatas = {}
	scene._skinSuitCfg = HandbookConfig.instance:getSkinSuitCfg(scene._suitId)

	local skinIdStr = scene._skinSuitCfg.skinContain
	local skinImageNameStr = scene._skinSuitCfg.tarotCardPath

	scene._skinIdList = string.splitToNumber(skinIdStr, "|")
	scene._skinCardNameList = string.split(skinImageNameStr, "|")

	for i = 1, HandbookEnum.SevenSkinCount do
		scene._tarotCardDatas[i] = {}

		if i <= #scene._skinIdList then
			local skinId = scene._skinIdList[i]
			local name = scene._skinCardNameList[i]

			scene._tarotCardDatas[i].path = string.format("%s/%s.png", HandbookEnum.SevenSkinCardDir, name)
			scene._tarotCardDatas[i].skinId = skinId
		else
			scene._tarotCardDatas[i].path = HandbookEnum.SevenSkinDefaultCardPath
		end
	end

	scene._curLeftIdx = 1
	scene._curRightIdx = 5

	if HandbookController.instance:isHandbookSkinSuitNewRedDotShow(scene._suitId) then
		local tarotSkinCount = HandbookEnum.SevenCardCount

		for i = 1, tarotSkinCount do
			local skinId = scene._skinIdList[i]

			if skinId and HandbookController.instance:isHandbookSkinUnlockRedDotShow(skinId) then
				local leftIdx = i - 2

				while leftIdx < 1 do
					leftIdx = leftIdx + tarotSkinCount
				end

				scene._curLeftIdx = leftIdx

				local rightIdx = i + 2

				while tarotSkinCount < rightIdx do
					rightIdx = rightIdx - tarotSkinCount
				end

				scene._curRightIdx = rightIdx

				break
			end
		end
	end

	if self._redDotComp then
		self._redDotComp:forceHide()
	end

	if HandbookController.instance:isHandbookSkinSuitNewRedDotShow(scene._suitId) then
		HandbookController.instance:markHandbookSkinNewRedDotShow(scene._suitId)
	end

	HandbookController.instance:statSkinSuitDetail(scene._suitId)

	scene._tarotCardGos = scene:getUserDataTb_()
	scene._tarotCardSpriteRender = scene:getUserDataTb_()
	scene._tarotCardGlowSpriteRender = scene:getUserDataTb_()
	scene._tarotCardAnimators = scene:getUserDataTb_()
	scene._tarotCardIdx2SkinIdx = {}
	scene._tarotCardUnlockVxs = scene:getUserDataTb_()
	scene._tarotCardUnlockAnimEvent = scene:getUserDataTb_()
	scene._tarotCardUnlockAnimator = scene:getUserDataTb_()

	local unlockVxPrefab = scene.viewContainer._abLoader:getAssetItem(HandbookEnum.SkinUnlockVxPath.Seven):GetResource()

	for i = 1, cardCount do
		local cardRootGo = gohelper.findChild(scene._curSceneGo, string.format("#Card/card0%d", i))

		scene._tarotCardGos[i] = gohelper.findChild(cardRootGo, "card")

		self:_setupCardClickListener(scene._tarotCardGos[i], i)

		scene._tarotCardAnimators[i] = cardRootGo:GetComponent(gohelper.Type_Animator)

		local tarotCardSpriteRenderGo = cardRootGo.transform:Find("card/sprite").gameObject

		scene._tarotCardSpriteRender[i] = tarotCardSpriteRenderGo:GetComponent(typeof(UnityEngine.SpriteRenderer))

		local goSpriteGlowEffect = gohelper.findChild(cardRootGo, "card/sprite/spriteglow")

		scene._tarotCardGlowSpriteRender[i] = goSpriteGlowEffect:GetComponent(typeof(UnityEngine.SpriteRenderer))
		scene._tarotCardIdx2SkinIdx[i] = (scene._curLeftIdx - 1 + i - 1) % HandbookEnum.SevenCardCount + 1

		local uxName = "sevenUnlockVx_" .. tostring(i)
		local unlockVxGo = gohelper.findChild(scene._tarotCardGos[i], uxName)

		unlockVxGo = unlockVxGo or gohelper.clone(unlockVxPrefab, scene._tarotCardGos[i], uxName)

		gohelper.setActive(unlockVxGo, false)
		gohelper.setAsLastSibling(unlockVxGo)

		scene._tarotCardUnlockVxs[i] = unlockVxGo

		local animEvent = unlockVxGo:GetComponent(gohelper.Type_AnimationEventWrap)

		scene._tarotCardUnlockAnimEvent[i] = animEvent

		local param = {
			self,
			i
		}

		animEvent:AddEventListener("unlock", self.onUnlockAnimPlayFinish, param)

		scene._tarotCardUnlockAnimator[i] = gohelper.findChildComponent(unlockVxGo, "", gohelper.Type_Animator)
	end

	for i = 1, cardCount do
		scene:setCardSprite(i, scene._tarotCardIdx2SkinIdx[i])
	end

	TaskDispatcher.runDelay(self.openSkinView, self, 2)
	TaskDispatcher.runDelay(self.onEnterAniDone, self, 2)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockHelper.instance:startBlock(UIBlockKey.WaitItemAnimeDone, 2)
	AudioMgr.instance:trigger(AudioEnum.Handbook.play_ui_tujianskin_group_special)
end

function HandbookScene_Seven:_setupCardClickListener(cardGo, cardIdx)
	local clickListener = HandbookSkinScene.getOrAddBoxCollider2D(cardGo)

	clickListener:AddMouseUpListener(self.onItemClickUp, self, cardIdx)
end

function HandbookScene_Seven:openSkinView()
	local scene = self._scene

	UIBlockHelper.instance:endBlock(UIBlockKey.WaitItemAnimeDone)
	UIBlockMgrExtend.setNeedCircleMv(true)

	local viewName = HandbookSkinScene.SkinSuitId2SuitView[scene._suitId]

	if viewName then
		local viewParam = {
			skinThemeGroupId = scene._suitId
		}

		ViewMgr.instance:openView(viewName, viewParam)
	end

	AudioMgr.instance:trigger(AudioEnum.Handbook.play_ui_tujianskin_group_open)
	HandbookController.instance:statSkinSuitDetail(scene._suitId)
end

function HandbookScene_Seven:onEnterAniDone()
	local scene = self._scene

	scene._enteringSevenMode = false
	scene._sevenMode = true
	self._enterAniDone = true
	scene._maxProgress = 0.916
	scene._minProgress = 0.083
	scene._tarotCardAniProgress[1] = cardDefaultPosMap[1]
	scene._tarotCardAniProgress[2] = cardDefaultPosMap[2]
	scene._tarotCardAniProgress[3] = cardDefaultPosMap[3]
	scene._tarotCardAniProgress[4] = cardDefaultPosMap[4]
	scene._tarotCardAniProgress[5] = cardDefaultPosMap[5]

	for i = 1, cardCount do
		local aniName = "slide"

		scene:UpdateAnimProgress(scene._tarotCardAnimators[i], aniName, scene._tarotCardAniProgress[i])
		self:_refreshCardUnlockUx(i, scene._tarotCardIdx2SkinIdx[i])
	end
end

function HandbookScene_Seven:_exitScene()
	local scene = self._scene

	if not scene._sevenMode then
		return
	end

	scene._sevenMode = false
	self._enterAniDone = false
	scene._tarotCardAniProgress = {}

	scene._sceneAnimatorPlayer:Play(UIAnimationName.Back, nil, nil)
	scene.viewContainer:dispatchEvent(HandbookEvent.OnExitSevenSkinSuit)
	TaskDispatcher.runDelay(self.onExitAniDone, self, 2)
end

function HandbookScene_Seven:onExitAniDone()
	if self._redDotComp then
		self._redDotComp:resetForceHide()
	end
end

function HandbookScene_Seven:exitScene()
	local scene = self._scene

	if not scene._sevenMode and not scene._enteringSevenMode then
		return
	end

	scene._sevenMode = false
	scene._enteringSevenMode = false
	self._enterAniDone = false
	scene._tarotCardAniProgress = {}

	scene._sceneAnimatorPlayer:Play(UIAnimationName.Back, nil, nil)
	scene.viewContainer:dispatchEvent(HandbookEvent.OnExitSevenSkinSuit)
	TaskDispatcher.runDelay(self.onExitAniDone, self, 2)
end

function HandbookScene_Seven:isInMode()
	local scene = self._scene

	return scene._sevenMode or scene._enteringSevenMode
end

function HandbookScene_Seven:onUnlockAnimPlayFinish(param)
	local target = param[1]
	local cardIdx = param[2]
end

function HandbookScene_Seven:_refreshCardUnlockUx(cardGoIdx, skinIdx)
	local scene = self._scene
	local animator = scene._tarotCardUnlockAnimator[cardGoIdx]
	local skinId = scene._tarotCardDatas[skinIdx].skinId
	local haveSkin = skinId and HeroModel.instance:checkHasSkin(skinId)

	gohelper.setActive(scene._tarotCardUnlockVxs[cardGoIdx], haveSkin)

	if haveSkin then
		local showUnlockAnim = HandbookController.instance:isHandbookSkinUnlockRedDotShow(skinId)
		local unlockVxGo = scene._tarotCardUnlockVxs[cardGoIdx]

		gohelper.setAsLastSibling(unlockVxGo)

		if showUnlockAnim then
			AudioMgr.instance:trigger(HandbookEnum.Audio.play_ui_activity_hero37_checkpoint_gather)
			HandbookController.instance:delaySendUnlockSkinRedDotInfo(skinId)

			local animEvent = scene._tarotCardUnlockAnimEvent[cardGoIdx]

			animEvent:AddEventListener("unlock", self.onUnlockAnimPlayFinish, {
				self,
				cardGoIdx
			})

			self._pendingOpenAnimCards = self._pendingOpenAnimCards or {}
			self._pendingOpenAnimCards[cardGoIdx] = true

			TaskDispatcher.runDelay(self._delayPlayOpenAnim, self, 0.1)
		else
			animator:Play(HandbookEnum.SkinUnlockAnimName.Idle, 0, 0)
		end
	end
end

function HandbookScene_Seven:_delayPlayOpenAnim()
	local scene = self._scene

	if self._pendingOpenAnimCards then
		for cardGoIdx, _ in pairs(self._pendingOpenAnimCards) do
			local animator = scene._tarotCardUnlockAnimator[cardGoIdx]

			if animator then
				animator:Play(HandbookEnum.SkinUnlockAnimName.Open, 0, 0)
			end
		end

		self._pendingOpenAnimCards = nil
	end
end

function HandbookScene_Seven:onItemClickUp(cardId)
	local scene = self._scene

	if scene._dragging or not scene._sevenMode then
		return
	end

	if not scene.sceneVisible then
		return
	end

	local skinIdx = scene._tarotCardIdx2SkinIdx[cardId]

	self:doCardPosToMiddle(skinIdx)
end

function HandbookScene_Seven:doCardDragBegin()
	local scene = self._scene

	for i = 1, cardCount do
		local curProgress = scene._tarotCardAniProgress[i]
		local cardPoxIdx = scene:_checkCardPosIdx(curProgress)

		if cardPoxIdx == centerCardIdx then
			local cardAnimator = scene._tarotCardAnimators[i]
			local skinIdx = scene._tarotCardIdx2SkinIdx[i]
			local skinId = scene._tarotCardDatas[skinIdx].skinId
			local skinCfg = SkinConfig.instance:getSkinCo(skinId)

			if not skinCfg then
				return
			end

			if skinId == 310003 then
				local spCardGo = cardAnimator.transform:Find("card/card_sp").gameObject
				local spCardAnimator = spCardGo:GetComponent(gohelper.Type_Animator)

				spCardAnimator:Play(UIAnimationName.Close)
			end
		end
	end
end

function HandbookScene_Seven:getMiddleSkinIdx()
	local scene = self._scene
	local offset = (HandbookEnum.SevenCardCount - 1) / 2
	local targetMiddleIdx = (scene._curLeftIdx - 1 + offset) % HandbookEnum.SevenSkinCount + 1

	return targetMiddleIdx
end

function HandbookScene_Seven:doCardPosToMiddle(skinIdx)
	local scene = self._scene
	local skinId = scene._tarotCardDatas[skinIdx].skinId

	if self:getMiddleSkinIdx() == skinIdx then
		if skinId then
			scene:openSkinDetailView(skinId)
		end

		return
	end

	self:doCardDragToMiddleBegin()

	scene._dragResetPosTweens = {}
	scene._dragging = true
	scene._tempSkinId = skinId

	local removeProgressOffset, idxAdd = scene:_checkFirstCardPosIdxByMiddleSkinIdx(skinIdx)

	scene._curProgressOffset = 0

	local changeNum = math.abs(idxAdd)

	scene._leftChangeNum = changeNum
	scene._rightChangeNum = changeNum

	if scene._tweenCardPosTweenId then
		ZProj.TweenHelper.KillById(scene._tweenCardPosTweenId)

		scene._tweenCardPosTweenId = nil
	end

	local duration = resetPosDuration

	TaskDispatcher.runDelay(self.onDoCardPosToMiddleEnd, self, duration + openDetailDuration)

	local tweenCardPosTweenId = ZProj.TweenHelper.DOTweenFloat(0, removeProgressOffset, duration, self.cardPosToMiddleTweenFrameCallback, self.cardPosToMiddleTweenEndCallback, self)

	scene._tweenCardPosTweenId = tweenCardPosTweenId
end

function HandbookScene_Seven:onDoCardPosToMiddleEnd()
	local scene = self._scene

	scene._dragging = false

	scene:openSkinDetailView(scene._tempSkinId)
	TaskDispatcher.cancelTask(self.onDoCardPosToMiddleEnd, self)

	scene._tempSkinId = nil
end

function HandbookScene_Seven:cardPosToMiddleTweenFrameCallback(value)
	local scene = self._scene
	local difference = value - scene._curProgressOffset

	scene._curProgressOffset = value

	for i, cardAnimator in ipairs(scene._tarotCardAnimators) do
		local curProgress = scene._tarotCardAniProgress[i]
		local dragAnimationName = "slide"
		local newProgress = curProgress + difference
		local changeSprite = false

		if newProgress >= scene._maxProgress then
			scene._tarotCardAniProgress[i] = scene._minProgress + newProgress - scene._maxProgress

			if scene._rightChangeNum > 0 then
				scene._curLeftIdx = scene._curLeftIdx >= HandbookEnum.SevenSkinCount and 1 or scene._curLeftIdx + 1
				scene._curRightIdx = scene._curRightIdx >= HandbookEnum.SevenSkinCount and 1 or scene._curRightIdx + 1

				scene:setCardSprite(i, scene._curRightIdx)

				scene._tarotCardIdx2SkinIdx[i] = scene._curRightIdx
				changeSprite = true
				scene._rightChangeNum = scene._rightChangeNum - 1
			end
		elseif newProgress <= scene._minProgress then
			scene._tarotCardAniProgress[i] = scene._maxProgress + newProgress - scene._minProgress

			if scene._leftChangeNum > 0 then
				scene._curLeftIdx = scene._curLeftIdx <= 1 and HandbookEnum.SevenSkinCount or scene._curLeftIdx - 1
				scene._curRightIdx = scene._curRightIdx <= 1 and HandbookEnum.SevenSkinCount or scene._curRightIdx - 1

				scene:setCardSprite(i, scene._curLeftIdx)

				scene._tarotCardIdx2SkinIdx[i] = scene._curLeftIdx
				changeSprite = true
				scene._leftChangeNum = scene._leftChangeNum - 1
			end
		else
			scene._tarotCardAniProgress[i] = newProgress
		end

		scene:UpdateAnimProgress(cardAnimator, dragAnimationName, scene._tarotCardAniProgress[i])
	end
end

function HandbookScene_Seven:doCardDragToMiddleBegin()
	local scene = self._scene

	for i = 1, cardCount do
		local curProgress = scene._tarotCardAniProgress[i]
		local cardPoxIdx = scene:_checkCardPosIdx(curProgress)

		if cardPoxIdx == centerCardIdx then
			local cardAnimator = scene._tarotCardAnimators[i]
			local skinIdx = scene._tarotCardIdx2SkinIdx[i]
			local skinId = scene._tarotCardDatas[skinIdx].skinId
			local skinCfg = SkinConfig.instance:getSkinCo(skinId)

			if not skinCfg then
				return
			end

			if skinId == 310003 then
				local spCardGo = cardAnimator.transform:Find("card/card_sp").gameObject
				local spCardAnimator = spCardGo:GetComponent(gohelper.Type_Animator)

				spCardAnimator:Play(UIAnimationName.Close)
			end
		end
	end
end

function HandbookScene_Seven:cardPosToMiddleTweenEndCallback()
	local scene = self._scene

	for i = 1, cardCount do
		self:playSpCardOpenAni(i)
	end
end

function HandbookScene_Seven:doCardPosResetTween()
	local scene = self._scene

	scene._dragResetPosTweens = {}

	local firstCardResetToIdx = 0

	for i = 1, cardCount do
		local curProgress = scene._tarotCardAniProgress[i]

		if i == 1 then
			firstCardResetToIdx = scene:_checkCardPosIdx(curProgress)
		end

		local resetIdx = firstCardResetToIdx + (i - 1)

		resetIdx = resetIdx > cardCount and resetIdx - cardCount or resetIdx

		local resetProgress = cardDefaultPosMap[resetIdx]
		local resetCardPosTweenId = ZProj.TweenHelper.DOTweenFloat(curProgress, resetProgress, resetPosDuration, self.cardPosResetTweenFrameCallback, self.cardPosResetTweenEndCallback, self, i)

		scene._dragResetPosTweens[i] = resetCardPosTweenId

		self:playSpCardOpenAni(i)
	end
end

function HandbookScene_Seven:cardPosResetTweenFrameCallback(value, idx)
	local scene = self._scene
	local dragAnimationName = "slide"
	local cardAnimator = scene._tarotCardAnimators[idx]

	scene._tarotCardAniProgress[idx] = value

	scene:UpdateAnimProgress(cardAnimator, dragAnimationName, value)
end

function HandbookScene_Seven:cardPosResetTweenEndCallback(idx)
	return
end

function HandbookScene_Seven:playSpCardOpenAni(i)
	local scene = self._scene
	local cardAnimator = scene._tarotCardAnimators[i]
	local skinIdx = scene._tarotCardIdx2SkinIdx[i]
	local skinId = scene._tarotCardDatas[skinIdx].skinId
	local skinCfg = SkinConfig.instance:getSkinCo(skinId)

	if not skinCfg then
		return
	end

	local curProgress = scene._tarotCardAniProgress[i]
	local cardPosIdx = scene:_checkCardPosIdx(curProgress)

	if cardPosIdx == centerCardIdx and skinId == 310003 then
		local spCardGo = cardAnimator.transform:Find("card/card_sp").gameObject
		local spCardAnimator = spCardGo:GetComponent(gohelper.Type_Animator)

		gohelper.setActive(spCardGo, true)
		spCardAnimator:Play(UIAnimationName.Open)
	end
end

function HandbookScene_Seven:onDragging(offsetX)
	local scene = self._scene

	if scene._enteringSevenMode or not scene._sevenMode then
		return
	end

	scene._dragging = true

	if scene._moveToOtherSuitAni then
		return
	end

	if scene._dragResetPosTweens and #scene._dragResetPosTweens > 0 then
		for i = 1, #scene._dragResetPosTweens do
			ZProj.TweenHelper.KillById(scene._dragResetPosTweens[i])
		end

		scene._dragResetPosTweens = {}
	end

	local progressDiff = dragRate * offsetX

	progressDiff = Mathf.Clamp(progressDiff, -maxDragProgressPerFrame, maxDragProgressPerFrame)

	for i, cardAnimator in ipairs(scene._tarotCardAnimators) do
		local curProgress = scene._tarotCardAniProgress[i]
		local dragAnimationName = "slide"
		local newProgress = curProgress - progressDiff

		if newProgress >= scene._maxProgress then
			scene._tarotCardAniProgress[i] = scene._minProgress + newProgress - scene._maxProgress
			scene._curLeftIdx = scene._curLeftIdx >= HandbookEnum.SevenSkinCount and 1 or scene._curLeftIdx + 1
			scene._curRightIdx = scene._curRightIdx >= HandbookEnum.SevenSkinCount and 1 or scene._curRightIdx + 1

			scene:setCardSprite(i, scene._curRightIdx)

			scene._tarotCardIdx2SkinIdx[i] = scene._curRightIdx
		elseif newProgress <= scene._minProgress then
			scene._tarotCardAniProgress[i] = scene._maxProgress + newProgress - scene._minProgress
			scene._curLeftIdx = scene._curLeftIdx <= 1 and HandbookEnum.SevenSkinCount or scene._curLeftIdx - 1
			scene._curRightIdx = scene._curRightIdx <= 1 and HandbookEnum.SevenSkinCount or scene._curRightIdx - 1

			scene:setCardSprite(i, scene._curLeftIdx)

			scene._tarotCardIdx2SkinIdx[i] = scene._curLeftIdx
		else
			scene._tarotCardAniProgress[i] = newProgress
		end

		scene:UpdateAnimProgress(cardAnimator, dragAnimationName, scene._tarotCardAniProgress[i])
	end
end

function HandbookScene_Seven:onClose()
	TaskDispatcher.cancelTask(self.onEnterAniDone, self)
	TaskDispatcher.cancelTask(self.onExitAniDone, self)
	TaskDispatcher.cancelTask(self.openSkinView, self)
	TaskDispatcher.cancelTask(self.onDoCardPosToMiddleEnd, self)

	local scene = self._scene

	if scene._tweenCardPosTweenId then
		ZProj.TweenHelper.KillById(scene._tweenCardPosTweenId)

		scene._tweenCardPosTweenId = nil
	end
end

return HandbookScene_Seven
