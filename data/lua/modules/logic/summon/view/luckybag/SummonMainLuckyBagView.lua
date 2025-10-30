-- chunkname: @modules/logic/summon/view/luckybag/SummonMainLuckyBagView.lua

module("modules.logic.summon.view.luckybag.SummonMainLuckyBagView", package.seeall)

local SummonMainLuckyBagView = class("SummonMainLuckyBagView", BaseView)

function SummonMainLuckyBagView:onInitView()
	self._goui = gohelper.findChild(self.viewGO, "#go_ui")
	self._gocharacteritem1 = gohelper.findChild(self.viewGO, "#go_ui/current/right/#go_characteritem1")
	self._gocharacteritem2 = gohelper.findChild(self.viewGO, "#go_ui/current/right/#go_characteritem2")
	self._btnsummon1 = gohelper.findChildButtonWithAudio(self.viewGO, "#go_ui/summonbtns/summon1/#btn_summon1")
	self._simagecurrency1 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/summonbtns/summon1/currency/#simage_currency1")
	self._txtcurrency11 = gohelper.findChildText(self.viewGO, "#go_ui/summonbtns/summon1/currency/#txt_currency1_1")
	self._txtcurrency12 = gohelper.findChildText(self.viewGO, "#go_ui/summonbtns/summon1/currency/#txt_currency1_2")
	self._gosummon10 = gohelper.findChild(self.viewGO, "#go_ui/summonbtns/summon10")
	self._btnsummon10 = gohelper.findChildButtonWithAudio(self.viewGO, "#go_ui/summonbtns/summon10/#btn_summon10")
	self._simagecurrency10 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/summonbtns/summon10/currency/#simage_currency10")
	self._txtcurrency101 = gohelper.findChildText(self.viewGO, "#go_ui/summonbtns/summon10/currency/#txt_currency10_1")
	self._txtcurrency102 = gohelper.findChildText(self.viewGO, "#go_ui/summonbtns/summon10/currency/#txt_currency10_2")
	self._gopageitem = gohelper.findChild(self.viewGO, "#go_ui/pageicon/#go_pageitem")
	self._golefttop = gohelper.findChild(self.viewGO, "#go_ui/#go_lefttop")
	self._gorighttop = gohelper.findChild(self.viewGO, "#go_ui/#go_righttop")
	self._gosummonbtns = gohelper.findChild(self.viewGO, "#go_ui/summonbtns")
	self._goluckybagbtns = gohelper.findChild(self.viewGO, "#go_ui/#go_luckybagopen")
	self._goluckbagbtn = gohelper.findChild(self.viewGO, "#go_ui/#go_luckybagopen/btnopenluckbag")
	self._btnluckybagbtn = gohelper.findChildButtonWithAudio(self.viewGO, "#go_ui/#go_luckybagopen/btnopenluckbag/#btn_openluckbag")
	self._goalreadyinvited = gohelper.findChild(self.viewGO, "#go_ui/#go_luckybagopen/#go_alreadyinvited")
	self._txtdeadline = gohelper.findChildText(self.viewGO, "#go_ui/current/#txt_deadline")
	self._simageline = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#txt_deadline/#simage_line")
	self._txttimes = gohelper.findChildText(self.viewGO, "#go_ui/#go_remaintimes/bg/#txt_times")
	self._simageluckybag = gohelper.findChildSingleImage(self.viewGO, "#go_ui/#go_luckybagopen/btnopenluckbag/#simage_jinfangjie")
	self._goremaintimes = gohelper.findChild(self.viewGO, "#go_ui/#go_remaintimes")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SummonMainLuckyBagView:addEvents()
	self._btnluckybagbtn:AddClickListener(self._btnopenluckbagOnClick, self)
	self._btnsummon1:AddClickListener(self._btnsummon1OnClick, self)
	self._btnsummon10:AddClickListener(self._btnsummon10OnClick, self)
end

function SummonMainLuckyBagView:removeEvents()
	self._btnluckybagbtn:RemoveClickListener()
	self._btnsummon1:RemoveClickListener()
	self._btnsummon10:RemoveClickListener()
end

SummonMainLuckyBagView.preloadList = {
	"singlebg/summon/heroversion_2_4/v2a4_fudai/v2a4_fudai_summon_fullbg1.png",
	"singlebg/summon/heroversion_2_4/v2a4_fudai/v2a4_fudai_summon_role1.png",
	"singlebg/summon/heroversion_2_4/v2a4_fudai/v2a4_fudai_summon_role2.png"
}

function SummonMainLuckyBagView:_editableInitView()
	self._luckyBagCount = 2
	self._pageitems = {}
	self._animRoot = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	self._simageline:LoadImage(ResUrl.getSummonHeroIcon("title_img_deco"))

	self._rectremaintimes = self._goremaintimes.transform

	self:initSingleBg()
	self:initLuckyBagComp()
end

function SummonMainLuckyBagView:onDestroyView()
	for i = 1, self._luckyBagCount do
		local btn = self:getLuckyBagDetailBtn(i)

		if btn then
			btn:RemoveClickListener()
		end

		self["_simagerole" .. tostring(i)]:UnLoadImage()
		self["_simageshowicon" .. tostring(i)]:UnLoadImage()
	end

	self._simagecurrency1:UnLoadImage()
	self._simagecurrency10:UnLoadImage()
	self._simageline:UnLoadImage()

	if self._compFreeButton then
		self._compFreeButton:dispose()

		self._compFreeButton = nil
	end
end

function SummonMainLuckyBagView:onUpdateParam()
	return
end

function SummonMainLuckyBagView:onOpen()
	logNormal("SummonMainLuckyBagView:onOpen()")
	self:addEventCb(SummonController.instance, SummonEvent.onSummonFailed, self.onSummonFailed, self)
	self:addEventCb(SummonController.instance, SummonEvent.onSummonReply, self.onSummonReply, self)
	self:addEventCb(SummonController.instance, SummonEvent.onViewCanPlayEnterAnim, self.playerEnterAnimFromScene, self)
	self:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, self.onItemChanged, self)
	self:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, self.onItemChanged, self)
	self:addEventCb(SummonController.instance, SummonEvent.onSummonInfoGot, self.refreshView, self)
	self:addEventCb(SummonController.instance, SummonEvent.onRemainTimeCountdown, self._refreshOpenTime, self)
	self:playEnterAnim()
	self:refreshView()
	self:checkAutoOpenLuckyBag()
	SummonController.instance:dispatchEvent(SummonEvent.LuckyBagViewOpen)
end

function SummonMainLuckyBagView:playEnterAnim()
	if SummonMainModel.instance:getFirstTimeSwitch() then
		SummonMainModel.instance:setFirstTimeSwitch(false)
		self._animRoot:Play(SummonEnum.SummonCharAnimationEnter, 0, 0)
	else
		self._animRoot:Play(SummonEnum.SummonCharAnimationSwitch, 0, 0)
	end
end

function SummonMainLuckyBagView:playerEnterAnimFromScene()
	self._animRoot:Play(SummonEnum.SummonCharAnimationEnter, 0, 0)
end

function SummonMainLuckyBagView:checkAutoOpenLuckyBag()
	local curPool = SummonMainModel.instance:getCurPool()

	if not curPool then
		return
	end

	local poolId = curPool.id
	local isGot, luckyBagId = SummonLuckyBagModel.instance:isLuckyBagGot(poolId)

	if isGot and not SummonLuckyBagModel.instance:isLuckyBagOpened(poolId, luckyBagId) and SummonLuckyBagModel.instance:needAutoPopup(poolId) then
		ViewMgr.instance:openView(ViewName.SummonLuckyBagChoice, {
			poolId = poolId,
			luckyBagId = luckyBagId
		})
		SummonLuckyBagModel.instance:recordAutoPopup(poolId)
	end
end

function SummonMainLuckyBagView:onClose()
	logNormal("SummonMainLuckyBagView:onClose()")
	self:removeEventCb(SummonController.instance, SummonEvent.onSummonFailed, self.onSummonFailed, self)
	self:removeEventCb(SummonController.instance, SummonEvent.onSummonReply, self.onSummonReply, self)
	self:removeEventCb(SummonController.instance, SummonEvent.onViewCanPlayEnterAnim, self.playerEnterAnimFromScene, self)
	self:removeEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, self.onItemChanged, self)
	self:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, self.onItemChanged, self)
	self:removeEventCb(SummonController.instance, SummonEvent.onSummonInfoGot, self.refreshView, self)
	self:removeEventCb(SummonController.instance, SummonEvent.onRemainTimeCountdown, self._refreshOpenTime, self)
end

function SummonMainLuckyBagView:initSingleBg()
	for i = 1, self._luckyBagCount do
		self["_simagerole" .. tostring(i)] = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#simage_role" .. tostring(i))
		self["_simageshowicon" .. tostring(i)] = gohelper.findChildSingleImage(self.viewGO, string.format("#go_ui/current/right/#go_characteritem%s/bg/dec1", i))
	end
end

function SummonMainLuckyBagView:initLuckyBagComp()
	for i = 1, self._luckyBagCount do
		local name = "_btnluckybag" .. tostring(i)
		local btn = gohelper.findChildButtonWithAudio(self.viewGO, string.format("#go_ui/current/right/#go_characteritem%s/btn_detail", i))

		if btn then
			self[name] = btn

			btn:AddClickListener(SummonMainLuckyBagView.onClickLuckyBagDetail, self, i)
		end

		local txtName = "_txtName" .. tostring(i)
		local goGotVfxName = "_gogotvfx" .. tostring(i)
		local goGotImageName = "_gogotimage" .. tostring(i)

		self[txtName] = gohelper.findChildText(self.viewGO, string.format("#go_ui/current/right/#go_characteritem%s/bg/txt1", i))
		self[goGotVfxName] = gohelper.findChild(self.viewGO, string.format("#go_ui/current/right/#go_characteritem%s/bg/dec1_glow", i))
		self[goGotImageName] = gohelper.findChild(self.viewGO, string.format("#go_ui/current/right/#go_characteritem%s/bg/#simage_alreadyget", i))
	end
end

function SummonMainLuckyBagView:_btnopenluckbagOnClick()
	local poolCo = SummonMainModel.instance:getCurPool()

	if not poolCo then
		return
	end

	local isGot, luckyBagId = SummonLuckyBagModel.instance:isLuckyBagGot(poolCo.id)

	if isGot and not SummonLuckyBagModel.instance:isLuckyBagOpened(poolCo.id, luckyBagId) then
		ViewMgr.instance:openView(ViewName.SummonLuckyBagChoice, {
			poolId = poolCo.id,
			luckyBagId = luckyBagId
		})
	end
end

function SummonMainLuckyBagView:_btnsummon1OnClick()
	if SummonController.instance:isInSummonGuide() then
		return
	end

	local curPool = SummonMainModel.instance:getCurPool()

	if not curPool then
		return
	end

	local cost_type, cost_id, cost_num = SummonMainModel.getCostByConfig(curPool.cost1)
	local param = {}

	param.type = cost_type
	param.id = cost_id
	param.quantity = cost_num
	param.callback = self._summon1Confirm
	param.callbackObj = self
	param.notEnough = false

	local num = ItemModel.instance:getItemQuantity(cost_type, cost_id)
	local itemEnough = cost_num <= num
	local everyCostCount = SummonMainModel.instance.everyCostCount
	local currencyNum = SummonMainModel.instance:getOwnCostCurrencyNum()

	if not itemEnough and currencyNum < everyCostCount then
		param.notEnough = true
	end

	if itemEnough then
		param.needTransform = false

		self:_summon1Confirm()

		return
	else
		param.needTransform = true
		param.cost_type = SummonMainModel.instance.costCurrencyType
		param.cost_id = SummonMainModel.instance.costCurrencyId
		param.cost_quantity = everyCostCount
		param.miss_quantity = 1
	end

	SummonMainController.instance:openSummonConfirmView(param)
end

function SummonMainLuckyBagView:_btnsummon10OnClick()
	if not self:checkRemainTimesEnough10() then
		return
	end

	local curPool = SummonMainModel.instance:getCurPool()

	if not curPool then
		return
	end

	local cost_type, cost_id, cost_num, ownNum = SummonMainModel.getCostByConfig(curPool.cost10)
	local param = {}

	param.type = cost_type
	param.id = cost_id
	param.quantity = cost_num
	param.callback = self._summon10Confirm
	param.callbackObj = self
	param.notEnough = false
	ownNum = ownNum or ItemModel.instance:getItemQuantity(cost_type, cost_id)

	local itemEnough = cost_num <= ownNum
	local everyCostCount = SummonMainModel.instance.everyCostCount
	local currencyNum = SummonMainModel.instance:getOwnCostCurrencyNum()
	local remainCount = 10 - ownNum
	local costRemain = everyCostCount * remainCount

	if not itemEnough and currencyNum < costRemain then
		param.notEnough = true
	end

	if itemEnough then
		param.needTransform = false

		self:_summon10Confirm()

		return
	else
		param.needTransform = true
		param.cost_type = SummonMainModel.instance.costCurrencyType
		param.cost_id = SummonMainModel.instance.costCurrencyId
		param.cost_quantity = costRemain
		param.miss_quantity = remainCount
	end

	SummonMainController.instance:openSummonConfirmView(param)
end

function SummonMainLuckyBagView:_summon10Confirm()
	local curPool = SummonMainModel.instance:getCurPool()

	if not curPool then
		return
	end

	SummonMainController.instance:sendStartSummon(curPool.id, 10, false, true)
end

function SummonMainLuckyBagView:checkRemainTimesEnough10()
	local curPool = SummonMainModel.instance:getCurPool()

	if curPool then
		local gachaMaxTimes = SummonLuckyBagModel.instance:getGachaRemainTimes(curPool.id)

		if gachaMaxTimes >= 10 then
			return true
		else
			GameFacade.showToast(ToastEnum.SummonLuckyBagLessThanSummon10)

			return false
		end
	end
end

function SummonMainLuckyBagView:_summon1Confirm()
	local curPool = SummonMainModel.instance:getCurPool()

	if not curPool then
		return
	end

	SummonMainController.instance:sendStartSummon(curPool.id, 1, false, true)
end

function SummonMainLuckyBagView:onClickLuckyBagDetail(index)
	local pool = SummonMainModel.instance:getCurPool()

	if not pool then
		return
	end

	local luckyBagList = SummonConfig.instance:getSummonLuckyBag(pool.id)

	if not luckyBagList then
		return
	end

	local luckyBagId = luckyBagList[index]

	if luckyBagId then
		SummonMainController.instance:openSummonDetail(pool, luckyBagId)
	end
end

function SummonMainLuckyBagView:refreshView()
	self.summonSuccess = false

	local list = SummonMainModel.instance:getList()

	if not list or #list <= 0 then
		gohelper.setActive(self._goui, false)

		return
	end

	self:refreshPoolUI()
end

function SummonMainLuckyBagView:refreshPoolUI()
	local pool = SummonMainModel.instance:getCurPool()

	if not pool then
		return
	end

	self:refreshLuckyBagStatus(pool)
	self:refreshLuckyBagDetails(pool)
	self:_refreshOpenTime()
end

function SummonMainLuckyBagView:refreshLuckyBagDetails(poolCo)
	local luckyBagList = SummonConfig.instance:getSummonLuckyBag(poolCo.id)

	if luckyBagList and next(luckyBagList) then
		local len = #luckyBagList

		for i = 1, self._luckyBagCount do
			local btn = self:getLuckyBagDetailBtn(i)

			if btn ~= nil then
				gohelper.setActive(btn, i <= len)
			end

			local txtName = "_txtName" .. tostring(i)
			local txt = self[txtName]

			if txt ~= nil then
				gohelper.setActive(txt, i <= len)

				if i <= len then
					local luckyBagId = luckyBagList[i]
					local luckyBagCo = SummonConfig.instance:getLuckyBag(poolCo.id, luckyBagId)

					txt.text = luckyBagCo.name
				end
			end
		end
	end
end

SummonMainLuckyBagView.RemainTimesPosition = {
	NoLuckyBag = {
		x = -232.5,
		y = 113.9
	},
	ExistLuckyBag = {
		x = 140,
		y = 113.9
	}
}

function SummonMainLuckyBagView:refreshLuckyBagStatus(poolCo)
	local isGot, luckyBagId = SummonLuckyBagModel.instance:isLuckyBagGot(poolCo.id)

	gohelper.setActive(self._goluckybagbtns, isGot)
	gohelper.setActive(self._gosummonbtns, not isGot)

	if isGot then
		self:refreshGotStatus(poolCo, luckyBagId)
	else
		self:refreshGachaStatus(poolCo)
	end
end

function SummonMainLuckyBagView:refreshGotStatus(poolCo, luckyBagId)
	local isOpen = SummonLuckyBagModel.instance:isLuckyBagOpened(poolCo.id, luckyBagId)

	gohelper.setActive(self._goalreadyinvited, isOpen)
	gohelper.setActive(self._goluckbagbtn, not isOpen)

	local luckyBagCo = SummonConfig.instance:getLuckyBag(poolCo.id, luckyBagId)

	if luckyBagCo then
		self._simageluckybag:LoadImage(ResUrl.getSummonCoverBg(luckyBagCo.icon))
	end

	gohelper.setActive(self._goremaintimes, not isOpen)

	if not isOpen then
		local anchorPos = SummonMainLuckyBagView.RemainTimesPosition.ExistLuckyBag

		recthelper.setAnchor(self._rectremaintimes, anchorPos.x, anchorPos.y)
		self:refreshRemainTimes(poolCo)
	end

	local idList = SummonConfig.instance:getSummonLuckyBag(poolCo.id)

	if idList then
		self:setLuckyBagIconVfx(tabletool.indexOf(idList, luckyBagId))
	else
		self:setLuckyBagIconVfx(-1)
	end
end

function SummonMainLuckyBagView:refreshGachaStatus(poolCo)
	self:refreshCost()
	self:refreshFreeSummonButton(poolCo)
	self:setLuckyBagIconVfx(-1)

	local anchorPos = SummonMainLuckyBagView.RemainTimesPosition.NoLuckyBag

	recthelper.setAnchor(self._rectremaintimes, anchorPos.x, anchorPos.y)
	self:refreshRemainTimes(poolCo)
end

function SummonMainLuckyBagView:setLuckyBagIconVfx(luckyBagIndex)
	for i = 1, self._luckyBagCount do
		local goGotVfxName = "_gogotvfx" .. tostring(i)
		local goGotImageName = "_gogotimage" .. tostring(i)

		gohelper.setActive(self[goGotVfxName], luckyBagIndex == i)
		gohelper.setActive(self[goGotImageName], luckyBagIndex == i)
	end
end

function SummonMainLuckyBagView:refreshFreeSummonButton(poolCo)
	self._compFreeButton = self._compFreeButton or SummonFreeSingleGacha.New(self._btnsummon1.gameObject, poolCo.id)

	self._compFreeButton:refreshUI()
end

function SummonMainLuckyBagView:refreshRemainTimes(poolCo)
	local times = SummonConfig.getSummonSSRTimes(poolCo)
	local summonServerMO = SummonMainModel.instance:getPoolServerMO(poolCo.id)

	if summonServerMO and summonServerMO.luckyBagMO then
		self._txttimes.text = string.format("%s/%s", summonServerMO.luckyBagMO.summonTimes, times)
	else
		self._txttimes.text = "-"
	end
end

function SummonMainLuckyBagView:refreshCost()
	local curPool = SummonMainModel.instance:getCurPool()

	if curPool then
		self:_refreshSingleCost(curPool.cost1, self._simagecurrency1, "_txtcurrency1")

		local gachaMaxTimes = SummonLuckyBagModel.instance:getGachaRemainTimes(curPool.id)

		if gachaMaxTimes and gachaMaxTimes >= 10 then
			ZProj.UGUIHelper.SetGrayscale(self._btnsummon10.gameObject, false)
			ZProj.UGUIHelper.SetGrayscale(self._simagecurrency10.gameObject, false)
		else
			ZProj.UGUIHelper.SetGrayscale(self._btnsummon10.gameObject, true)
			ZProj.UGUIHelper.SetGrayscale(self._simagecurrency10.gameObject, true)
		end

		self:_refreshSingleCost(curPool.cost10, self._simagecurrency10, "_txtcurrency10")
	end
end

function SummonMainLuckyBagView:_refreshSingleCost(costs, icon, numTxt)
	local cost_type, cost_id, cost_num = SummonMainModel.getCostByConfig(costs, true)
	local cost_icon = SummonMainModel.getSummonItemIcon(cost_type, cost_id)

	icon:LoadImage(cost_icon)

	local num = ItemModel.instance:getItemQuantity(cost_type, cost_id)
	local enough = cost_num <= num

	self[numTxt .. "1"].text = luaLang("multiple") .. cost_num
	self[numTxt .. "2"].text = ""
end

function SummonMainLuckyBagView:_refreshOpenTime()
	local curPool = SummonMainModel.instance:getCurPool()

	if not curPool then
		return
	end

	local poolMO = SummonMainModel.instance:getPoolServerMO(curPool.id)

	if poolMO ~= nil and poolMO.offlineTime ~= 0 and poolMO.offlineTime < TimeUtil.maxDateTimeStamp then
		local time = poolMO.offlineTime - ServerTime.now()

		self._txtdeadline.text = string.format(luaLang("summonmainequipprobup_deadline"), SummonModel.formatRemainTime(time))
	else
		self._txtdeadline.text = ""
	end
end

function SummonMainLuckyBagView:getLuckyBagDetailBtn(i)
	return self["_btnluckybag" .. tostring(i)]
end

function SummonMainLuckyBagView:onSummonFailed()
	self.summonSuccess = false

	self:refreshCost()
end

function SummonMainLuckyBagView:onSummonReply()
	self.summonSuccess = true
end

function SummonMainLuckyBagView:onItemChanged()
	if SummonController.instance.isWaitingSummonResult or self.summonSuccess then
		return
	end

	self:refreshCost()
end

return SummonMainLuckyBagView
