-- chunkname: @modules/logic/bossrush/view/v4a1/V4a1_BossRush_DangerItem.lua

module("modules.logic.bossrush.view.v4a1.V4a1_BossRush_DangerItem", package.seeall)

local V4a1_BossRush_DangerItem = class("V4a1_BossRush_DangerItem", ListScrollCellExtend)

function V4a1_BossRush_DangerItem:onInitView()
	self._goGrid = gohelper.findChild(self.viewGO, "grid")
	self._goitem = gohelper.findChild(self.viewGO, "grid/#go_item")
	self._goLine = gohelper.findChild(self.viewGO, "grid/image_bg")
	self._imgLine = gohelper.findChildImage(self.viewGO, "grid/image_bg/image_fg")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V4a1_BossRush_DangerItem:addEvents()
	return
end

function V4a1_BossRush_DangerItem:removeEvents()
	return
end

function V4a1_BossRush_DangerItem:_editableInitView()
	self._items = self:getUserDataTb_()

	gohelper.setActive(self._goitem, false)

	self._imgLine.fillAmount = 0
end

function V4a1_BossRush_DangerItem:_editableAddEvents()
	return
end

function V4a1_BossRush_DangerItem:_editableRemoveEvents()
	return
end

function V4a1_BossRush_DangerItem:onUpdateMO(score, episodeId, monsterId, isPlayAni)
	self._score = score
	self._arrivedPhase = 0
	self._episodeId = episodeId

	local moList = V4a1_BossRushModel.instance:getScoreSkillMos(episodeId)
	local count = 0

	self:_killTween()

	local _moList = {}

	if moList and #moList > 0 then
		self._singleProgress = 0.9 / #moList

		local lastScore = 0

		for i, mo in ipairs(moList) do
			local _mo = mo

			if _mo then
				if _mo[1] and lastScore < score then
					local rate = (score - lastScore) / (_mo[1].score - lastScore)

					self._arrivedPhase = i - 1 + rate
					lastScore = _mo[1].score
				end

				table.insert(_moList, _mo)
			end
		end
	end

	local curIndex = math.floor(self._arrivedPhase)

	for i, mo in ipairs(_moList) do
		if mo.hidden ~= 1 then
			local item = self:_getItem(i)
			local isArraive = i < self._arrivedPhase
			local isNow = i == curIndex

			UISpriteSetMgr.instance:setV4a1BossRushSprite(item.imgarrived, "v4a1_bossrush_score_light_lv_" .. i)
			UISpriteSetMgr.instance:setV4a1BossRushSprite(item.imgnow, "v4a1_bossrush_score_light_lv_" .. i)
			UISpriteSetMgr.instance:setV4a1BossRushSprite(item.imgnormal, "v4a1_bossrush_score_lv_" .. i)

			local fillAmount = 0

			if not isPlayAni then
				gohelper.setActive(item.imgarrived.gameObject, isArraive)
				gohelper.setActive(item.imgnow.gameObject, isNow)
				gohelper.setActive(item.imgnormal.gameObject, not isArraive and not isNow)

				fillAmount = Mathf.Clamp(self._arrivedPhase - i + 1, 0, 1)
			else
				gohelper.setActive(item.imgarrived.gameObject, false)
				gohelper.setActive(item.imgnow.gameObject, false)
				gohelper.setActive(item.imgnormal.gameObject, true)
			end

			item.imgLine.fillAmount = fillAmount
			count = count + 1
		end
	end

	for i, item in ipairs(self._items) do
		if i == 1 then
			gohelper.setActive(item.imgLine, count > 1)
		end

		gohelper.setSibling(item.go, count - i + 1)
		gohelper.setActive(item.go, i <= count)
	end

	ZProj.UGUIHelper.RebuildLayout(self._goGrid.transform)

	local itemWidth = recthelper.getWidth(self._goGrid.transform) / count

	if count > 0 then
		for i, item in ipairs(self._items) do
			local lineWidth = i == 1 and itemWidth / 2 + 10 or itemWidth - 18

			recthelper.setWidth(item.goLine.transform, lineWidth)
			recthelper.setWidth(item.imgLine.transform, lineWidth - 18)

			if i == 1 then
				gohelper.setActive(item.imgLine, count > 1)
			end
		end
	end

	if count < self._arrivedPhase then
		if not self._extraLine then
			local item1 = self:_getItem(count)
			local extraGoLine = gohelper.cloneInPlace(item1.goLine)

			gohelper.setAsFirstSibling(extraGoLine)

			extraGoLine.transform.pivot = Vector2(0, 0.5)

			recthelper.setWidth(extraGoLine.transform, itemWidth / 2)
			recthelper.setAnchorX(extraGoLine.transform, 18)

			self._extraLine = gohelper.findChildImage(extraGoLine, "progress")
			self._extraLine.transform.pivot = Vector2(0, 0.5)
			self._extraLine.transform.anchorMin = Vector2(0, 0.5)
			self._extraLine.transform.anchorMax = Vector2(0, 0.5)

			recthelper.setAnchorX(self._extraLine.transform, 0)

			local width = recthelper.getWidth(extraGoLine.transform)

			recthelper.setWidth(self._extraLine.transform, width)

			self._extraLine.fillAmount = isPlayAni and 0 or 1

			gohelper.setActive(self._extraLine, true)
		end
	elseif self._extraLine then
		gohelper.setActive(self._extraLine, false)
	end

	self._showItemCount = count

	return count > 0
end

local animTime = 0.2

function V4a1_BossRush_DangerItem:onPlayAnim()
	self._playAnimItemIndex = 1

	self:_checkTweenProgress()
end

function V4a1_BossRush_DangerItem:_checkTweenProgress()
	if not self._items then
		return
	end

	if self._playAnimItemIndex > self._arrivedPhase + 1 then
		self:_killTween()

		return
	end

	if self._playAnimItemIndex == self._showItemCount + 1 then
		if self._extraLine then
			self._extraLine.fillAmount = 0

			ZProj.TweenHelper.DOFillAmount(self._extraLine, 1, animTime, nil, self, nil, EaseType.Linear)
		end

		return
	end

	self:_dweenProgress()
end

function V4a1_BossRush_DangerItem:_dweenProgress()
	local item = self._items[self._playAnimItemIndex]

	if not item then
		self:_killTween()

		return
	end

	ZProj.TweenHelper.KillByObj(item.imgLine.gameObject)

	local rate = Mathf.Clamp(self._arrivedPhase - self._playAnimItemIndex + 1, 0, 1)

	item.imgLine.fillAmount = 0

	ZProj.TweenHelper.DOFillAmount(item.imgLine, rate, animTime, self._doTweenFinishProgress, self, item, EaseType.Linear)
end

function V4a1_BossRush_DangerItem:_doTweenFinishProgress(item)
	if not item then
		self:_killTween()

		return
	end

	local isArraive = self._playAnimItemIndex < self._arrivedPhase
	local isNow = self._playAnimItemIndex == self._arrivedPhase

	gohelper.setActive(item.imgarrived.gameObject, isArraive)
	gohelper.setActive(item.imgnow.gameObject, isNow)
	gohelper.setActive(item.imgnormal.gameObject, not isArraive and not isNow)

	self._playAnimItemIndex = self._playAnimItemIndex + 1

	self:_checkTweenProgress()
	AudioMgr.instance:trigger(BossRushAudioEnum.Audio.play_ui_atlantis_zm_light)
end

function V4a1_BossRush_DangerItem:_isShowItem(moList, monsterId)
	if not monsterId then
		return moList
	end

	for _, v in ipairs(moList) do
		if v.monsterId == monsterId and v.hidden ~= 1 then
			return {
				v
			}
		end
	end
end

function V4a1_BossRush_DangerItem:_getItem(index)
	local item = self._items[index]

	if not item then
		item = self:getUserDataTb_()
		item.go = gohelper.cloneInPlace(self._goitem.gameObject, index)
		item.imgnormal = gohelper.findChildImage(item.go, "#go_normal")
		item.imgarrived = gohelper.findChildImage(item.go, "#go_arrived")
		item.imgnow = gohelper.findChildImage(item.go, "#go_now")
		item.goLine = gohelper.findChild(item.go, "progressRoot")
		item.imgLine = gohelper.findChildImage(item.go, "progressRoot/progress")
		item.imgLine.transform.pivot = Vector2(1, 0.5)
		item.imgLine.transform.anchorMin = Vector2(1, 0.5)
		item.imgLine.transform.anchorMax = Vector2(1, 0.5)

		recthelper.setAnchorX(item.imgLine.transform, -18)

		item.imgLine.fillAmount = 0
		self._items[index] = item
	end

	return item
end

function V4a1_BossRush_DangerItem:setActive(isActive)
	gohelper.setActive(self.viewGO, isActive)
end

function V4a1_BossRush_DangerItem:_killTween()
	if self._extraLine then
		ZProj.TweenHelper.KillByObj(self._extraLine.gameObject)
	end

	for i, item in ipairs(self._items) do
		ZProj.TweenHelper.KillByObj(item.imgLine.gameObject)
	end
end

function V4a1_BossRush_DangerItem:onDestroyView()
	self:_killTween()
end

return V4a1_BossRush_DangerItem
