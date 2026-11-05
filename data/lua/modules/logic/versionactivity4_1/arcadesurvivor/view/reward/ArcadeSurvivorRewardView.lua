-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/view/reward/ArcadeSurvivorRewardView.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.view.reward.ArcadeSurvivorRewardView", package.seeall)

local ArcadeSurvivorRewardView = class("ArcadeSurvivorRewardView", BaseView)

function ArcadeSurvivorRewardView:onInitView()
	self.btnReward = ArcadeSurvivorGameHelper.getArcadeSurvivorButton(self.viewGO, "#btn_click")
	self._txtScore = gohelper.findChildTextMesh(self.viewGO, "Left/title/#txt_score")
	self._gonormalline = gohelper.findChild(self.viewGO, "Left/progress/#scroll_view/Viewport/Content/#go_fillbg/#go_fill")
	self._btnclose = ArcadeSurvivorGameHelper.getArcadeSurvivorButton(self.viewGO, "#btn_close")
	self._rectnormalline = self._gonormalline.transform

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ArcadeSurvivorRewardView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self:addClickCb(self.btnReward, self.onClickReward, self)
	self:addEventCb(ArcadeSurvivorController.instance, ArcadeSurvivorEvent.OnGainReward, self.onGainReward, self)
end

function ArcadeSurvivorRewardView:removeEvents()
	self._btnclose:RemoveClickListener()
	self:removeClickCb(self.btnReward)
	self:removeEventCb(ArcadeSurvivorController.instance, ArcadeSurvivorEvent.OnGainReward, self.onGainReward, self)
end

function ArcadeSurvivorRewardView:_btncloseOnClick()
	self:closeThis()
end

function ArcadeSurvivorRewardView:onClickModalMask()
	self:_btncloseOnClick()
end

function ArcadeSurvivorRewardView:onClickReward()
	local scrollView = self.viewContainer:getScrollView()

	scrollView:moveToByIndex(self.rewardIndex - 3, 1)
end

function ArcadeSurvivorRewardView:onGainReward()
	self:refreshView()
end

function ArcadeSurvivorRewardView:_editableInitView()
	self.startSpace = 2
	self.cellWidth = 268
	self.space = 0
	self.rewardIndex = 40
end

function ArcadeSurvivorRewardView:onOpen()
	self:refreshView()
	AudioMgr.instance:trigger(AudioEnum3_3.Arcade.play_ui_yuanzheng_interface_open)
end

function ArcadeSurvivorRewardView:refreshView()
	self:refreshReward()
	self:refreshProgress()
end

function ArcadeSurvivorRewardView:refreshReward()
	ArcadeSurvivorRewardListModel.instance:refreshList()
end

function ArcadeSurvivorRewardView:refreshProgress()
	local score = ArcadeSurvivorOutSideModel.instance:getScore()

	self._txtScore.text = GameUtil.numberDisplay(score)

	local moList = ArcadeSurvivorRewardListModel.instance:getList()
	local curIndex = #moList
	local curShowIndex

	for i, mo in ipairs(moList) do
		if curShowIndex == nil and not mo:isGainReward() then
			curShowIndex = i
		end

		if score < mo:getScore() then
			curIndex = i - 1

			break
		end
	end

	local curScore = moList[curIndex] and moList[curIndex].score or 0
	local nextScore = moList[curIndex + 1] and moList[curIndex + 1].score or curScore
	local beginPos = 0
	local nodeWidth = self:getNodeWidth(curIndex, beginPos)
	local offsetWidth = self:getNodeWidth(curIndex + 1, beginPos) - nodeWidth
	local perWidth = 0

	if curScore < nextScore then
		perWidth = (score - curScore) / (nextScore - curScore) * offsetWidth
	end

	recthelper.setWidth(self._rectnormalline, nodeWidth + perWidth)

	if not self.isPlayMove then
		self.isPlayMove = true

		if curShowIndex ~= nil then
			local scrollView = self.viewContainer:getScrollView()

			scrollView:moveToByIndex(curShowIndex, 0.2)
		end
	end
end

function ArcadeSurvivorRewardView:getNodeWidth(index, beginPos)
	beginPos = beginPos or 0

	local nodeWidth = beginPos

	if index > 0 then
		nodeWidth = (index - 1) * (self.cellWidth + self.space) + (self.startSpace + self.cellWidth * 0.5) + beginPos
	end

	return nodeWidth
end

function ArcadeSurvivorRewardView:onClose()
	return
end

function ArcadeSurvivorRewardView:onDestroyView()
	return
end

return ArcadeSurvivorRewardView
