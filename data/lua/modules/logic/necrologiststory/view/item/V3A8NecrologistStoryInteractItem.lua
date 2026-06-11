-- chunkname: @modules/logic/necrologiststory/view/item/V3A8NecrologistStoryInteractItem.lua

module("modules.logic.necrologiststory.view.item.V3A8NecrologistStoryInteractItem", package.seeall)

local V3A8NecrologistStoryInteractItem = class("V3A8NecrologistStoryInteractItem", NecrologistStoryBaseItem)

function V3A8NecrologistStoryInteractItem:onInit()
	self.btnClick = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_open")
	self.txtBtn = gohelper.findChildTextMesh(self.viewGO, "#btn_open/#txt_place")
	self.goProgress = gohelper.findChild(self.viewGO, "progress")
	self.imgFill = gohelper.findChildImage(self.goProgress, "#image_fill")
end

function V3A8NecrologistStoryInteractItem:addEventListeners()
	self:addClickCb(self.btnClick, self.onClickBtn, self)
end

function V3A8NecrologistStoryInteractItem:removeEventListeners()
	self:removeClickCb(self.btnClick)
end

function V3A8NecrologistStoryInteractItem:onClickBtn()
	if self.isClicked then
		return
	end

	self.isClicked = true

	if self.leftTime and self.leftTime > 0 and self._tweenId then
		local mo = NecrologistStoryModel.instance:getCurStoryMO()

		if mo then
			mo:markSpecial(self:getStoryId())
		end

		self:_onFadeInFinish()
	end

	self:onPlayFinish()
end

function V3A8NecrologistStoryInteractItem:onPlayStory(isSkip)
	self.isClicked = false

	local storyConfig = self:getStoryConfig()
	local param = string.split(storyConfig.param, "#")

	self.leftTime = param[1] and tonumber(param[1]) or 0

	self:startCountDown()
end

function V3A8NecrologistStoryInteractItem:startCountDown()
	self:killTweenId()

	local hasCountDown = self.leftTime > 0

	gohelper.setActive(self.goProgress, hasCountDown)

	if self.leftTime <= 0 then
		return
	end

	self._tweenId = ZProj.TweenHelper.DOTweenFloat(1, 0, self.leftTime, self._onFadeInUpdate, self._onFadeInFinish, self, nil, EaseType.Linear)
end

function V3A8NecrologistStoryInteractItem:_onFadeInUpdate(value)
	self.imgFill.fillAmount = value
end

function V3A8NecrologistStoryInteractItem:_onFadeInFinish()
	gohelper.setActive(self.goProgress, false)
	self:killTweenId()
end

function V3A8NecrologistStoryInteractItem:killTweenId()
	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end
end

function V3A8NecrologistStoryInteractItem:caleHeight()
	return 400
end

function V3A8NecrologistStoryInteractItem:isDone()
	return self.isClicked
end

function V3A8NecrologistStoryInteractItem:onDestroy()
	self:killTweenId()
end

function V3A8NecrologistStoryInteractItem.getResPath()
	return "ui/viewres/dungeon/rolestory/item/v3a8_rolestoryinteractitem.prefab"
end

return V3A8NecrologistStoryInteractItem
