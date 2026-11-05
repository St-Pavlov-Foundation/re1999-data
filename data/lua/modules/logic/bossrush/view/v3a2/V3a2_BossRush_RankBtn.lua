-- chunkname: @modules/logic/bossrush/view/v3a2/V3a2_BossRush_RankBtn.lua

module("modules.logic.bossrush.view.v3a2.V3a2_BossRush_RankBtn", package.seeall)

local V3a2_BossRush_RankBtn = class("V3a2_BossRush_RankBtn", LuaCompBase)

function V3a2_BossRush_RankBtn:ctor(season)
	self._season = season
end

function V3a2_BossRush_RankBtn:onInitView()
	self._simageProp = gohelper.findChildSingleImage(self.viewGO, "#simage_Prop")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_click")
	self._imageIcon = gohelper.findChildImage(self.viewGO, "rank")
	self._imageSliderFG = gohelper.findChildImage(self.viewGO, "rank/#image_SliderFG")
	self._txtrank = gohelper.findChildText(self.viewGO, "rank/#txt_rank")
	self._txtname = gohelper.findChildText(self.viewGO, "txt_Lv")
	self._goreddot = gohelper.findChild(self.viewGO, "#go_reddot")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a2_BossRush_RankBtn:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function V3a2_BossRush_RankBtn:removeEvents()
	self._btnclick:RemoveClickListener()
end

function V3a2_BossRush_RankBtn:_btnclickOnClick()
	V4a1_BossRushController.instance:openRankView(self._season)
end

function V3a2_BossRush_RankBtn:init(go)
	self.viewGO = go

	self:onInitView()
end

function V3a2_BossRush_RankBtn:addEventListeners()
	self:addEvents()
end

function V3a2_BossRush_RankBtn:removeEventListeners()
	self:removeEvents()
end

function V3a2_BossRush_RankBtn:_editableInitView()
	self._reddot = RedDotController.instance:addRedDot(self._goreddot, RedDotEnum.DotNode.BossRushRankBonus, self._season)
end

function V3a2_BossRush_RankBtn:onDestroy()
	ZProj.TweenHelper.KillByObj(self._imageSliderFG)
end

function V3a2_BossRush_RankBtn:refreshUI()
	self._season = self._season or V4a1_BossRushModel.instance:getCurSeason()

	local seasonMo = V4a1_BossRushModel.instance:getSeasonMo(self._season)
	local rank = V3a2_BossRushModel.instance:getRank(self._season)

	self._txtrank.text = rank

	local value = self:_getFillAmount()

	self._imageSliderFG.fillAmount = value

	self:_refreshIcon()

	self._txtname.text = seasonMo.co.nameLevel
end

function V3a2_BossRush_RankBtn:_refreshIcon()
	local rank = V3a2_BossRushModel.instance:getRank(self._season)
	local bgIcon = V3a2_BossRushModel.instance:getRankLevelBg(self._season, rank)

	if bgIcon then
		if self._season == 1 then
			UISpriteSetMgr.instance:setV1a4BossRushSprite(self._imageIcon, bgIcon)
		else
			UISpriteSetMgr.instance:setV4a1BossRushSprite(self._imageIcon, bgIcon)
		end
	end
end

function V3a2_BossRush_RankBtn:_getFillAmount()
	local exp, needExp = V3a2_BossRushModel.instance:getRankExpProgress(self._season)
	local value = Mathf.Clamp01(exp / needExp)

	return value
end

function V3a2_BossRush_RankBtn:playAnim()
	ZProj.TweenHelper.KillByObj(self._imageSliderFG)

	local fillAmount = self:_getFillAmount()
	local rank = V3a2_BossRushModel.instance:getRank(self._season)

	self._txtrank.text = rank

	self:_refreshIcon()

	if self._imageSliderFG.fillAmount == fillAmount then
		return
	end

	if fillAmount > self._imageSliderFG.fillAmount then
		ZProj.TweenHelper.DOFillAmount(self._imageSliderFG, fillAmount, 0.3, nil, nil, nil, EaseType.Linear)
	else
		self._imageSliderFG.fillAmount = fillAmount
	end
end

return V3a2_BossRush_RankBtn
