-- chunkname: @modules/logic/bossrush/view/v3a2/V3a2_BossRush_RankView.lua

module("modules.logic.bossrush.view.v3a2.V3a2_BossRush_RankView", package.seeall)

local V3a2_BossRush_RankView = class("V3a2_BossRush_RankView", BaseView)

function V3a2_BossRush_RankView:onInitView()
	self._simagefull = gohelper.findChildSingleImage(self.viewGO, "#simage_full")
	self._goinfo = gohelper.findChild(self.viewGO, "#go_info")
	self._txtDescr = gohelper.findChildText(self.viewGO, "#go_info/#txt_Descr")
	self._scrollprogress = gohelper.findChildScrollRect(self.viewGO, "#scroll_progress")
	self._btnLv = gohelper.findChildButtonWithAudio(self.viewGO, "Lv")
	self._imageSliderFG = gohelper.findChildImage(self.viewGO, "Lv/#image_SliderFG")
	self._txtrank = gohelper.findChildText(self.viewGO, "Lv/#txt_rank")
	self._goTips = gohelper.findChild(self.viewGO, "Lv/#go_Tips")
	self._txtTips = gohelper.findChildText(self.viewGO, "Lv/#go_Tips/#txt_Tips")
	self._txtname = gohelper.findChildText(self.viewGO, "#go_info/txt_Title")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a2_BossRush_RankView:addEvents()
	self._btnLv:AddClickListener(self._btnLVOnClick, self)
	self:addEventCb(BossRushController.instance, BossRushEvent.onClaimRankBonus, self.claimRankBonus, self)
end

function V3a2_BossRush_RankView:removeEvents()
	self._btnLv:RemoveClickListener()
	self:removeEventCb(BossRushController.instance, BossRushEvent.onClaimRankBonus, self.claimRankBonus, self)
end

function V3a2_BossRush_RankView:_btnLVOnClick()
	self:_showLvTxt(not self._isShowLvTxt)
end

function V3a2_BossRush_RankView:_editableInitView()
	self._levels = self:getUserDataTb_()

	for i = 1, 5 do
		local item = self:getUserDataTb_()
		local go = gohelper.findChild(self.viewGO, "Lv/leve" .. i)

		item.go = go
		item.simgLv = gohelper.findChildSingleImage(go, "Lv")
		self._levels[i] = item
	end
end

function V3a2_BossRush_RankView:_getRankBGPath(rank)
	local levelBg = V3a2_BossRushModel.instance:getRankLevelBg(self._season, rank)

	if not string.nilorempty(levelBg) then
		local icon = string.gsub(levelBg, "main_scorebg_lv", "rank_lvbg")

		return ResUrl.getBossRushRankSinglebg(icon)
	end
end

function V3a2_BossRush_RankView:onUpdateParam()
	return
end

function V3a2_BossRush_RankView:onOpen()
	self._season = self.viewParam and self.viewParam.season or 1

	V3a2_BossRush_RankListModel.instance:setMoList(self._season)

	local seasonMo = V4a1_BossRushModel.instance:getSeasonMo(self._season)

	self:refreshUI()

	local exp, needExp = V3a2_BossRushModel.instance:getRankExpProgress(self._season)

	self._txtTips.text = string.format("%s/%s", exp, needExp)

	self:_showLvTxt(false)

	self._txtname.text = seasonMo.co.nameLevel
end

function V3a2_BossRush_RankView:_showLvTxt(isShow)
	gohelper.setActive(self._goTips, isShow)

	self._isShowLvTxt = isShow
end

V3a2_BossRush_RankView.UI_CLICK_BLOCK_KEY = "V3a2_BossRush_RankView_UI_CLICK_BLOCK_KEY"

function V3a2_BossRush_RankView:_claimBonusCb()
	self:refreshUI()
	V3a2_BossRush_RankListModel.instance:onModelUpdate()
	UIBlockMgr.instance:endBlock(V3a2_BossRush_RankView.UI_CLICK_BLOCK_KEY)
end

function V3a2_BossRush_RankView:claimRankBonus()
	if V3a2_BossRushModel.instance:isCanClaimRankBonus(self._season) then
		UIBlockMgr.instance:startBlock(V3a2_BossRush_RankView.UI_CLICK_BLOCK_KEY)

		local actId = V3a9_BossRushModel.instance:getActIdBySeason(self._season)

		BossRushRpc.instance:sendAct128GetMilestoneBonusRequest(actId, self._claimBonusCb, self)
	end
end

function V3a2_BossRush_RankView:refreshUI()
	local moList = V3a2_BossRush_RankListModel.instance:getList()
	local rank = V3a2_BossRushModel.instance:getRank(self._season)

	self._txtrank.text = rank

	local exp, needExp = V3a2_BossRushModel.instance:getRankExpProgress(self._season)
	local value = Mathf.Clamp01(exp / needExp)

	self._imageSliderFG.fillAmount = value

	local spLevelBg = V3a2_BossRushModel.instance:getRankSpLevelBg(self._season, rank)

	for i, item in pairs(self._levels) do
		if i == spLevelBg then
			item.simgLv:LoadImage(self:_getRankBGPath(rank))
		end

		gohelper.setActive(item.go, i == spLevelBg)
	end

	if moList and #moList > 1 then
		local firstCanGetBouns = V3a2_BossRush_RankListModel.instance:getFirstCanGetBouns() or 1

		if self._tweenId then
			ZProj.TweenHelper.KillById(self._tweenId)

			self._tweenId = nil
		end

		local hvn = (firstCanGetBouns - 1) / (#moList - 1)

		self._scrollprogress.horizontalNormalizedPosition = 0
		self._tweenId = ZProj.TweenHelper.DOTweenFloat(0, hvn, 0.1, self._frameCallback, nil, self, nil, EaseType.Linear)
	end
end

function V3a2_BossRush_RankView:_frameCallback(value)
	self._scrollprogress.horizontalNormalizedPosition = value
end

function V3a2_BossRush_RankView:_createItemCB(obj, data, index)
	obj:onUpdateMO(data, self)
end

function V3a2_BossRush_RankView:onClose()
	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end
end

function V3a2_BossRush_RankView:onDestroyView()
	for _, item in pairs(self._levels) do
		item.simgLv:UnLoadImage()
	end
end

return V3a2_BossRush_RankView
