-- chunkname: @modules/logic/fight/view/FightBossRushScoreLevelBarView.lua

module("modules.logic.fight.view.FightBossRushScoreLevelBarView", package.seeall)

local FightBossRushScoreLevelBarView = class("FightBossRushScoreLevelBarView", FightBaseView)

function FightBossRushScoreLevelBarView:onConstructor(phaseList)
	self._phaseList = phaseList or {}
	self._curPhase = 0
	self._score = 0
end

function FightBossRushScoreLevelBarView:onInitView()
	self._items = self:getUserDataTb_()

	self:_initNodes()
	self:_createItems()
	self:_refreshItems()
	self:_refreshProgress()

	if self.PARENT_VIEW and self.PARENT_VIEW._levelBarVisible ~= nil then
		gohelper.setActive(self.viewGO, self.PARENT_VIEW._levelBarVisible)
	end

	gohelper.setActive(self.viewGO.transform.parent.gameObject, true)
end

function FightBossRushScoreLevelBarView:addEvents()
	local image = gohelper.onceAddComponent(self.viewGO, typeof(UnityEngine.UI.Image))

	image.color = Color.New(0, 0, 0, 0)
	self._click = gohelper.getClickWithDefaultAudio(self.viewGO)

	self:com_registClick(self._click, self._onClick)
end

function FightBossRushScoreLevelBarView:removeEvents()
	return
end

function FightBossRushScoreLevelBarView:_onClick()
	ViewMgr.instance:openView(ViewName.FightBossRushScoreLevelBarTipsView, {
		phaseList = self._phaseList,
		curPhase = self._curPhase
	})
end

function FightBossRushScoreLevelBarView:_initNodes()
	self._grid = gohelper.findChild(self.viewGO, "grid")

	local imageBg = gohelper.findChild(self.viewGO, "grid/image_bg")

	if imageBg then
		-- block empty
	end

	self._itemTemplate = gohelper.findChild(self.viewGO, "grid/#go_item")

	gohelper.setActive(self._itemTemplate, false)

	self.blank = gohelper.findChild(self.viewGO, "grid/blank")
end

function FightBossRushScoreLevelBarView:_applyLayoutOverrides()
	local centerAnchor = Vector2.New(0.5, 0.5)
	local gridTr = self._grid.transform

	gridTr.anchorMin = centerAnchor
	gridTr.anchorMax = centerAnchor

	local gridLayout = self._grid:GetComponent(gohelper.Type_HorizontalLayoutGroup)

	if gridLayout then
		gridLayout.spacing = -400
	end
end

function FightBossRushScoreLevelBarView:_createItems()
	local count = #self._phaseList

	for idx = count, 1, -1 do
		local phaseInfo = self._phaseList[idx]
		local go = gohelper.cloneInPlace(self._itemTemplate, "item" .. idx)

		gohelper.setActive(go, true)

		local item = self:getUserDataTb_()

		item.go = go
		item.phase = phaseInfo.phase
		item.imgnormal = gohelper.findChildImage(go, "#go_normal")
		item.imgnow = gohelper.findChildImage(go, "#go_now")
		item.imgarrived = gohelper.findChildImage(go, "#go_arrived")

		gohelper.setActive(gohelper.findChildImage(go, "progressRoot"), true)

		item.imgprogress = gohelper.findChildImage(go, "progressRoot/progress")

		UISpriteSetMgr.instance:setV4a1BossRushSprite(item.imgnormal, "v4a1_bossrush_score_lv_" .. idx)
		UISpriteSetMgr.instance:setV4a1BossRushSprite(item.imgnow, "v4a1_bossrush_score_light_lv_" .. idx)
		UISpriteSetMgr.instance:setV4a1BossRushSprite(item.imgarrived, "v4a1_bossrush_score_light_lv_" .. idx)

		self._items[idx] = item
	end

	gohelper.setAsLastSibling(self.blank)
end

function FightBossRushScoreLevelBarView:setCurPhase(curPhase)
	self._curPhase = curPhase or 0

	if self._items and #self._items > 0 then
		self:_refreshItems()
		AudioMgr.instance:trigger(410107)
	end
end

function FightBossRushScoreLevelBarView:setProgress(score)
	self._score = score or 0

	self:_refreshProgress()
end

function FightBossRushScoreLevelBarView:setVisible(visible)
	if self.viewGO then
		gohelper.setActive(self.viewGO, visible)
	end
end

function FightBossRushScoreLevelBarView:_refreshItems()
	local curIndex = 0

	for i, item in ipairs(self._items) do
		if item.phase == self._curPhase then
			curIndex = i

			break
		end
	end

	for i, item in ipairs(self._items) do
		local isArrived = curIndex > 0 and i <= curIndex
		local isNow = i == curIndex

		gohelper.setActive(item.imgarrived.gameObject, isArrived)
		gohelper.setActive(item.imgnow.gameObject, isNow)
		gohelper.setActive(item.imgnormal.gameObject, not isArrived and not isNow)
	end
end

function FightBossRushScoreLevelBarView:_refreshProgress()
	if not self._items or #self._items == 0 then
		return
	end

	for i, item in ipairs(self._items) do
		if item.imgprogress then
			local phaseInfo = self._phaseList[i]
			local needScore = phaseInfo and phaseInfo.score or 0
			local prevScore = 0

			if i > 1 then
				local prevInfo = self._phaseList[i - 1]

				prevScore = prevInfo and prevInfo.score or 0
			end

			local spanScore = needScore - prevScore

			if spanScore <= 0 then
				item.imgprogress.fillAmount = 0
			else
				item.imgprogress.fillAmount = math.max(0, math.min(1, (self._score - prevScore) / spanScore))
			end
		end
	end
end

return FightBossRushScoreLevelBarView
