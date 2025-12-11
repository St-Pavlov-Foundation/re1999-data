-- chunkname: @modules/logic/summon/view/SummonResultView.lua

module("modules.logic.summon.view.SummonResultView", package.seeall)

local SummonResultView = class("SummonResultView", BaseView)

function SummonResultView:onInitView()
	self._btnok = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_ok")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SummonResultView:addEvents()
	self._btnok:AddClickListener(self._btnokOnClick, self)
end

function SummonResultView:removeEvents()
	self._btnok:RemoveClickListener()
end

function SummonResultView:_btnokOnClick()
	if self._cantClose then
		return
	end

	self:closeThis()
end

function SummonResultView:_editableInitView()
	gohelper.setActive(self._goheroitem, false)

	self._heroItemTables = {}

	for i = 1, 10 do
		local heroItemTable = self:getUserDataTb_()

		heroItemTable.go = gohelper.findChild(self.viewGO, "herocontent/#go_heroitem" .. i)
		heroItemTable.txtname = gohelper.findChildText(heroItemTable.go, "name")
		heroItemTable.txtnameen = gohelper.findChildText(heroItemTable.go, "nameen")
		heroItemTable.imagerare = gohelper.findChildImage(heroItemTable.go, "rare")
		heroItemTable.equiprare = gohelper.findChildImage(heroItemTable.go, "equiprare")
		heroItemTable.imagecareer = gohelper.findChildImage(heroItemTable.go, "career")
		heroItemTable.imageequipcareer = gohelper.findChildImage(heroItemTable.go, "equipcareer")
		heroItemTable.goHeroIcon = gohelper.findChild(heroItemTable.go, "heroicon")
		heroItemTable.simageicon = gohelper.findChildSingleImage(heroItemTable.go, "heroicon/icon")
		heroItemTable.simageequipicon = gohelper.findChildSingleImage(heroItemTable.go, "equipicon")
		heroItemTable.imageicon = gohelper.findChildImage(heroItemTable.go, "heroicon/icon")
		heroItemTable.goeffect = gohelper.findChild(heroItemTable.go, "effect")
		heroItemTable.btnself = gohelper.findChildButtonWithAudio(heroItemTable.go, "btn_self")
		heroItemTable.goluckybag = gohelper.findChild(heroItemTable.go, "luckybag")
		heroItemTable.txtluckybagname = gohelper.findChildText(heroItemTable.goluckybag, "name")
		heroItemTable.txtluckybagnameen = gohelper.findChildText(heroItemTable.goluckybag, "nameen")
		heroItemTable.simageluckgbagicon = gohelper.findChildSingleImage(heroItemTable.goluckybag, "icon")

		heroItemTable.btnself:AddClickListener(self.onClickItem, {
			view = self,
			index = i
		})
		table.insert(self._heroItemTables, heroItemTable)
	end

	self._animation = self.viewGO:GetComponent(typeof(UnityEngine.Animation))

	local go_righttop = gohelper.findChild(self.viewGO, "#go_righttop")

	self._canvas = go_righttop:GetComponent(gohelper.Type_CanvasGroup)
	self._canvas.blocksRaycasts = false

	self._animation:PlayQueued("summonresult_loop", UnityEngine.QueueMode.CompleteOthers)

	self._cantClose = true
	self._tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 1.9, nil, self._tweenFinish, self, nil, EaseType.Linear)
	self._goBtn = gohelper.findChild(self.viewGO, "summonbtns")
	self._goSummon1 = gohelper.findChild(self.viewGO, "summonbtns/summon1")
	self._goSummon10 = gohelper.findChild(self.viewGO, "summonbtns/summon10")
	self._btnSummon10 = gohelper.findChildButtonWithAudio(self.viewGO, "summonbtns/summon10/#btn_summon10")
	self._simagecurrency10 = gohelper.findChildSingleImage(self.viewGO, "summonbtns/summon10/currency/#simage_currency10")
	self._txtcurrency101 = gohelper.findChildText(self.viewGO, "summonbtns/summon10/currency/#txt_currency10_1")
	self._txtcurrency102 = gohelper.findChildText(self.viewGO, "summonbtns/summon10/currency/#txt_currency10_2")

	self._btnSummon10:AddClickListener(self._btnsummon10OnClick, self)

	self._isReSummon = false
	self._canSummon = true
end

function SummonResultView:onDestroyView()
	for i = 1, 10 do
		local heroItemTable = self._heroItemTables[i]

		if heroItemTable then
			if heroItemTable.simageicon then
				heroItemTable.simageicon:UnLoadImage()
			end

			if heroItemTable.simageequipicon then
				heroItemTable.simageequipicon:UnLoadImage()
			end

			if heroItemTable.btnself then
				heroItemTable.btnself:RemoveClickListener()
			end

			if heroItemTable.simageluckgbagicon then
				heroItemTable.simageluckgbagicon:UnLoadImage()
			end
		end
	end

	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)
	end

	self._btnSummon10:RemoveClickListener()
end

function SummonResultView:onOpen()
	self:addEventCb(SummonController.instance, SummonEvent.onSummonReply, self.onSummonReply, self)
	self:addEventCb(SummonController.instance, SummonEvent.onSummonFailed, self.onSummonFailed, self)
	self:addEventCb(StoreController.instance, StoreEvent.GoodsModelChanged, self._refreshCost, self)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_LuckDraw_TenHero_OpenAll)

	local summonResultList = self.viewParam.summonResultList

	self._curPool = self:getCurPool()
	self._summonResultList = {}

	for i, v in ipairs(summonResultList) do
		table.insert(self._summonResultList, v)
	end

	if self._curPool then
		SummonModel.sortResult(self._summonResultList, self._curPool.id)
	end

	SummonModel.instance:cacheReward(self._summonResultList)
	self:_refreshUI()
	NavigateMgr.instance:addEscape(ViewName.SummonResultView, self._btnokOnClick, self)
	self:_setSummonBtnActive(true)
	self:exReward()
end

function SummonResultView:onClose()
	self:removeEventCb(SummonController.instance, SummonEvent.onSummonReply, self.onSummonReply, self)
	self:removeEventCb(SummonController.instance, SummonEvent.onSummonFailed, self.onSummonFailed, self)
	self:removeEventCb(StoreController.instance, StoreEvent.GoodsModelChanged, self._refreshCost, self)

	if not self._isReSummon and not self:_showCommonPropView() then
		SummonController.instance:dispatchEvent(SummonEvent.onSummonResultClose)
	end
end

function SummonResultView:onCloseFinish()
	PopupController.instance:showPopupView()
end

function SummonResultView.onClickItem(params)
	local view = params.view
	local index = params.index
	local summonReward = view._summonResultList[index]

	if summonReward.heroId and summonReward.heroId ~= 0 then
		ViewMgr.instance:openView(ViewName.SummonHeroDetailView, {
			heroId = summonReward.heroId
		})
	elseif summonReward.equipId and summonReward.equipId ~= 0 then
		EquipController.instance:openEquipView({
			equipId = summonReward.equipId
		})
	elseif summonReward:isLuckyBag() then
		GameFacade.showToast(ToastEnum.SummonLuckyBagGoMainViewOpen)
	end
end

function SummonResultView:_tweenFinish()
	self._cantClose = false
	self._canvas.blocksRaycasts = true
end

function SummonResultView:_refreshUI()
	for i = 1, #self._summonResultList do
		local summonReward = self._summonResultList[i]

		if summonReward.heroId and summonReward.heroId ~= 0 then
			self:_refreshHeroItem(self._heroItemTables[i], summonReward)
		elseif summonReward.equipId and summonReward.equipId ~= 0 then
			self:_refreshEquipItem(self._heroItemTables[i], summonReward)
		elseif summonReward:isLuckyBag() then
			self:_refreshLuckyBagItem(self._heroItemTables[i], summonReward)
		else
			gohelper.setActive(self._heroItemTables[i].go, false)
		end
	end

	for i = #self._summonResultList + 1, #self._heroItemTables do
		gohelper.setActive(self._heroItemTables[i].go, false)
	end

	self:_refreshCost()
end

local function onImageLoaded(heroItemTable)
	if not gohelper.isNil(heroItemTable.imageicon) then
		heroItemTable.imageicon:SetNativeSize()
	end
end

function SummonResultView:_refreshEquipItem(heroItemTable, summonReward)
	gohelper.setActive(heroItemTable.goHeroIcon, false)
	gohelper.setActive(heroItemTable.simageequipicon.gameObject, true)
	gohelper.setActive(heroItemTable.goluckybag, false)
	gohelper.setActive(heroItemTable.txtname, true)
	gohelper.setActive(heroItemTable.txtnameen, true)

	local equipId = summonReward.equipId
	local equipCo = EquipConfig.instance:getEquipCo(equipId)

	heroItemTable.txtname.text = equipCo.name
	heroItemTable.txtnameen.text = equipCo.name_en

	UISpriteSetMgr.instance:setSummonSprite(heroItemTable.imagerare, "pingzhi_" .. tostring(CharacterEnum.Color[equipCo.rare]))
	UISpriteSetMgr.instance:setSummonSprite(heroItemTable.equiprare, "equiprare_" .. tostring(CharacterEnum.Color[equipCo.rare]))
	gohelper.setActive(heroItemTable.imagecareer.gameObject, false)
	gohelper.setActive(heroItemTable.simageicon.gameObject, false)
	heroItemTable.simageequipicon:LoadImage(ResUrl.getSummonEquipGetIcon(equipCo.icon), onImageLoaded, heroItemTable)
	EquipHelper.loadEquipCareerNewIcon(equipCo, heroItemTable.imageequipcareer, 1, "lssx")
	self:_refreshEffect(equipCo.rare, heroItemTable)
	gohelper.setActive(heroItemTable.go, true)
end

function SummonResultView:_refreshHeroItem(heroItemTable, summonReward)
	gohelper.setActive(heroItemTable.imageequipcareer.gameObject, false)
	gohelper.setActive(heroItemTable.goHeroIcon, true)
	gohelper.setActive(heroItemTable.goluckybag, false)
	gohelper.setActive(heroItemTable.txtname, true)
	gohelper.setActive(heroItemTable.txtnameen, true)

	local heroId = summonReward.heroId
	local heroConfig = HeroConfig.instance:getHeroCO(heroId)
	local skinConfig = SkinConfig.instance:getSkinCo(heroConfig.skinId)

	gohelper.setActive(heroItemTable.equiprare.gameObject, false)
	gohelper.setActive(heroItemTable.simageequipicon.gameObject, false)

	heroItemTable.txtname.text = heroConfig.name
	heroItemTable.txtnameen.text = heroConfig.nameEng

	UISpriteSetMgr.instance:setSummonSprite(heroItemTable.imagerare, "pingzhi_" .. tostring(CharacterEnum.Color[heroConfig.rare]))
	UISpriteSetMgr.instance:setCommonSprite(heroItemTable.imagecareer, "lssx_" .. tostring(heroConfig.career))
	heroItemTable.simageicon:LoadImage(ResUrl.getHeadIconMiddle(skinConfig.retangleIcon))

	if heroItemTable.effect then
		gohelper.destroy(heroItemTable.effect)

		heroItemTable.effect = nil
	end

	self:_refreshEffect(heroConfig.rare, heroItemTable)
	gohelper.setActive(heroItemTable.go, true)
end

function SummonResultView:_refreshLuckyBagItem(heroItemTable, summonReward)
	gohelper.setActive(heroItemTable.goluckybag, true)
	gohelper.setActive(heroItemTable.equiprare.gameObject, false)
	gohelper.setActive(heroItemTable.simageequipicon.gameObject, false)
	gohelper.setActive(heroItemTable.imagecareer.gameObject, false)
	gohelper.setActive(heroItemTable.simageicon.gameObject, false)
	gohelper.setActive(heroItemTable.txtname, false)
	gohelper.setActive(heroItemTable.txtnameen, false)

	local luckyBagId = summonReward.luckyBagId

	if not self._curPool then
		return
	end

	local co = SummonConfig.instance:getLuckyBag(self._curPool.id, luckyBagId)

	heroItemTable.txtluckybagname.text = co.name
	heroItemTable.txtluckybagnameen.text = co.nameEn or ""

	heroItemTable.simageluckgbagicon:LoadImage(ResUrl.getSummonCoverBg(co.icon))
	UISpriteSetMgr.instance:setSummonSprite(heroItemTable.imagerare, "pingzhi_" .. tostring(CharacterEnum.Color[SummonEnum.LuckyBagRare]))
	self:_refreshEffect(SummonEnum.LuckyBagRare, heroItemTable)
	gohelper.setActive(heroItemTable.go, true)
end

function SummonResultView:_refreshEffect(rare, heroItemTable)
	local effectPath

	if rare == 3 then
		effectPath = self.viewContainer:getSetting().otherRes[1]
	elseif rare == 4 then
		effectPath = self.viewContainer:getSetting().otherRes[2]
	elseif rare == 5 then
		effectPath = self.viewContainer:getSetting().otherRes[3]
	end

	if effectPath then
		heroItemTable.effect = self.viewContainer:getResInst(effectPath, heroItemTable.goeffect, "effect")

		local animation = heroItemTable.effect:GetComponent(typeof(UnityEngine.Animation))

		animation:PlayQueued("ssr_loop", UnityEngine.QueueMode.CompleteOthers)
	end
end

function SummonResultView:onUpdateParam()
	local paramResultList = self.viewParam.summonResultList

	self._summonResultList = {}
	self._curPool = self:getCurPool()

	for i, v in ipairs(paramResultList) do
		table.insert(self._summonResultList, v)
	end

	if self._curPool then
		SummonModel.sortResult(self._summonResultList, self._curPool.id)
	end

	self:_refreshUI()
end

function SummonResultView:exReward()
	local rewardList, cacheCount = SummonModel.instance:getCacheReward()

	self.rewards = SummonModel.getRewardList(rewardList)

	if self._curPool and self._curPool.ticketId ~= 0 then
		SummonModel.appendRewardTicket(self._summonResultList, self.rewards, self._curPool.ticketId, cacheCount)
	end
end

function SummonResultView:_showCommonPropView()
	if GuideController.instance:isGuiding() and GuideModel.instance:getDoingGuideId() == 102 then
		return false
	end

	if #self.rewards <= 0 then
		return false
	end

	table.sort(self.rewards, SummonModel.sortRewards)
	PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.CommonPropView, self.rewards)
	SummonModel.instance:clearCacheReward()

	return true
end

function SummonResultView:getCurPool()
	return self.viewParam.curPool
end

function SummonResultView:_setSummonBtnActive(active)
	gohelper.setActive(self._goBtn, active)
	gohelper.setActive(self._goSummon1, false)

	local curPool = self:getCurPool()
	local mo = SummonMainModel.instance:getPoolServerMO(curPool.id)

	if SummonMainModel.validContinueTenPool(curPool.id) then
		gohelper.setActive(self._goSummon10, true)
		self:_summonTrack("summon10_auto_show")
	else
		gohelper.setActive(self._goSummon10, false)
	end
end

function SummonResultView:_btnsummon10OnClick()
	if not self._canSummon then
		return
	end

	local curPool = self:getCurPool()

	if not curPool then
		return
	end

	local heroId = SummonModel.instance:getSummonFullExSkillHero(curPool.id)

	if heroId == nil then
		self:_btnsummon10OnClick_2()
	else
		local heroConfig = HeroConfig.instance:getHeroCO(heroId)
		local heroName = heroConfig.name

		GameFacade.showOptionAndParamsMessageBox(MessageBoxIdDefine.SummonHeroExFull, MsgBoxEnum.BoxType.Yes_No, MsgBoxEnum.optionType.Daily, curPool.id, self._btnsummon10OnClick_2, nil, nil, self, nil, nil, heroName)
	end

	self:_summonTrack("summon10_click")
end

function SummonResultView:_btnsummon10OnClick_2()
	local curPool = self:getCurPool()

	if not curPool then
		return
	end

	local cost_type, cost_id, cost_num = SummonMainModel.getCostByConfig(curPool.cost10)
	local param = {}

	param.type = cost_type
	param.id = cost_id
	param.quantity = cost_num
	param.callback = self._summon10Confirm
	param.callbackObj = self
	param.noCallback = self._btnokOnClick
	param.noCallbackObj = self
	param.notEnough = false

	local ownNum = ItemModel.instance:getItemQuantity(cost_type, cost_id)
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
	PopupController.instance:endPopupView()
end

function SummonResultView:_summon10Confirm()
	local curPool = self:getCurPool()

	if not curPool then
		return
	end

	self._canSummon = false

	SummonMainController.instance:sendStartSummon(curPool.id, 10, false, true)
end

function SummonResultView:_refreshCost()
	local curPool = self:getCurPool()

	if curPool then
		self:_refreshSingleCost(curPool.cost10, self._simagecurrency10, "_txtcurrency10")
	end
end

function SummonResultView:_refreshSingleCost(costs, icon, numTxt)
	local cost_type, cost_id, cost_num = SummonMainModel.getCostByConfig(costs)
	local cost_icon = SummonMainModel.getSummonItemIcon(cost_type, cost_id)

	icon:LoadImage(cost_icon)

	local num = ItemModel.instance:getItemQuantity(cost_type, cost_id)
	local enough = cost_num <= num

	self[numTxt .. "1"].text = luaLang("multiple") .. cost_num
	self[numTxt .. "2"].text = ""
end

function SummonResultView:onSummonReply()
	self:_summonShowExitAnim()
end

function SummonResultView:onSummonFailed()
	self._canSummon = true
end

function SummonResultView:_summonShowExitAnim()
	self._isReSummon = true
	self._canSummon = true

	self:closeThis()
end

function SummonResultView:_summonTrack(butName)
	local curPool = self:getCurPool()

	StatController.instance:track(StatEnum.EventName.ButtonClick, {
		[StatEnum.EventProperties.PoolName] = curPool and curPool.nameCn or "",
		[StatEnum.EventProperties.ButtonName] = butName,
		[StatEnum.EventProperties.ViewName] = self.viewName
	})
end

return SummonResultView
