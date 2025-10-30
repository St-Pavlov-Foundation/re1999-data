-- chunkname: @modules/logic/summon/view/luckybag/SummonGetLuckyBagView.lua

module("modules.logic.summon.view.luckybag.SummonGetLuckyBagView", package.seeall)

local SummonGetLuckyBagView = class("SummonGetLuckyBagView", BaseView)

function SummonGetLuckyBagView:onInitView()
	self._txtname = gohelper.findChildText(self.viewGO, "content/#go_collection/txt_name")
	self._txtnameen = gohelper.findChildText(self.viewGO, "content/#go_collection/en")
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "content/#go_collection/#simage_icon")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SummonGetLuckyBagView:addEvents()
	return
end

function SummonGetLuckyBagView:removeEvents()
	return
end

function SummonGetLuckyBagView:_editableInitView()
	self._bgClick = gohelper.getClick(self.viewGO)

	self._bgClick:AddClickListener(self._onClickBG, self)
end

function SummonGetLuckyBagView:onDestroyView()
	self._bgClick:RemoveClickListener()
end

function SummonGetLuckyBagView:onOpen()
	logNormal("SummonGetLuckyBagView onOpen")
	AudioMgr.instance:trigger(AudioEnum.Summon.play_ui_wulu_lucky_bag_gain)
	self:refreshView()
end

function SummonGetLuckyBagView:onClose()
	return
end

function SummonGetLuckyBagView:refreshView()
	local poolId = self.viewParam.poolId
	local luckyBagId = self.viewParam.luckyBagId
	local luckyBagCo = SummonConfig.instance:getLuckyBag(poolId, luckyBagId)

	if luckyBagCo then
		self._txtname.text = luckyBagCo.name
		self._txtnameen.text = luckyBagCo.nameEn or ""

		self._simageicon:LoadImage(ResUrl.getSummonCoverBg(luckyBagCo.icon))
	end
end

function SummonGetLuckyBagView:_onClickBG()
	self:closeThis()
end

return SummonGetLuckyBagView
