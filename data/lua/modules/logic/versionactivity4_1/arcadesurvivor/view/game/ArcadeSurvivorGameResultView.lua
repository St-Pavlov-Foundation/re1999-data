-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/view/game/ArcadeSurvivorGameResultView.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.view.game.ArcadeSurvivorGameResultView", package.seeall)

local ArcadeSurvivorGameResultView = class("ArcadeSurvivorGameResultView", BaseView)

function ArcadeSurvivorGameResultView:onInitView()
	self._gowin = gohelper.findChild(self.viewGO, "pointResult/Victory")
	self._gofail = gohelper.findChild(self.viewGO, "pointResult/Defeat")
	self._goreward = gohelper.findChild(self.viewGO, "pointResult/#go_reward")
	self._gorewardItem = gohelper.findChild(self.viewGO, "pointResult/#go_reward/#go_rewardItem")
	self._gocollection = gohelper.findChild(self.viewGO, "Info/#go_item/#scroll_collection/viewport/content")
	self._gocollectionitem = gohelper.findChild(self.viewGO, "Info/#go_item/#scroll_collection/viewport/content/#go_collectionitem")
	self._simageweaponicon = gohelper.findChildSingleImage(self.viewGO, "Info/#go_item/#go_weapon/#go_weaponitem/#image_icon")
	self._simageheroicon = gohelper.findChildSingleImage(self.viewGO, "Info/hero/mask/simage_icon")
	self._gohpbar = gohelper.findChild(self.viewGO, "Info/hero/#go_hp")
	self._gohpitem = gohelper.findChild(self.viewGO, "Info/hero/#go_hp/go_hpitem")
	self._gobase = gohelper.findChild(self.viewGO, "Info/hero/#go_base")
	self._gobaseItem = gohelper.findChild(self.viewGO, "Info/hero/#go_base/go_baseitem")
	self._txtroomnum = gohelper.findChildText(self.viewGO, "Info/#go_room/#txt_num")
	self._txtkillnum = gohelper.findChildText(self.viewGO, "Info/#go_kill/#txt_num")
	self._txtcoinsnum = gohelper.findChildText(self.viewGO, "Info/#go_coins/#txt_num")
	self._txttapenum = gohelper.findChildText(self.viewGO, "Info/#go_tape/#txt_num")
	self._gonewcharacter = gohelper.findChild(self.viewGO, "Info/#go_tips")
	self._golv = gohelper.findChild(self.viewGO, "Info/#go_lv")
	self._imagelv = gohelper.findChildImage(self.viewGO, "Info/#go_lv/#image_lv")
	self._btnclose = ArcadeSurvivorGameHelper.getArcadeSurvivorButton(self.viewGO, "#btn_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ArcadeSurvivorGameResultView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	NavigateMgr.instance:addEscape(ViewName.ArcadeSurvivorGameResultView, self._btncloseOnClick, self)
end

function ArcadeSurvivorGameResultView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function ArcadeSurvivorGameResultView:_btncloseOnClick()
	if self._isReset then
		ArcadeSurvivorGameController.instance:resetGame()
	else
		ArcadeSurvivorController.instance:openHallView()
		ArcadeSurvivorController.instance:closeGameView()
	end

	self:closeThis()
end

function ArcadeSurvivorGameResultView:_editableInitView()
	self._animator = self.viewGO:GetComponent(gohelper.Type_Animator)

	gohelper.setActive(self._golv, true)
end

function ArcadeSurvivorGameResultView:onUpdateParam()
	self._isWin = false
	self._isReset = false
	self._characterId = nil
	self._passLevelCount = 0
	self._killMonsterNum = 0
	self._allCoinNum = 0
	self._score = 0
	self._bookAddScore = 0
	self._hasUnlockCharacter = false
	self._rewardDataList = {}
	self._attrDict = {}
	self._collectionDataList = {}

	if self.viewParam then
		self._isWin = self.viewParam.isWin
		self._isReset = self.viewParam.isReset
		self._characterId = self.viewParam.characterId

		local resultStatisticsDict = self.viewParam.resultStatisticsDict or {}

		self._passLevelCount = resultStatisticsDict[ArcadeSurvivorGameEnum.CustomSaveInfoKey.PassLevelCount] or 0
		self._killMonsterNum = resultStatisticsDict[ArcadeSurvivorGameEnum.CustomSaveInfoKey.KillMonsterNum] or 0
		self._allCoinNum = resultStatisticsDict[ArcadeSurvivorGameEnum.CustomSaveInfoKey.TotalGainCoin] or 0
		self._score = self.viewParam.score or 0
		self._bookAddScore = self.viewParam.bookAddScore or 0
		self._hasUnlockCharacter = self.viewParam.hasUnlockCharacter
		self._rewardDataList = self.viewParam.rewardDataList or {}
		self._attrDict = self.viewParam.attrDict or {}
		self._collectionDataList = self.viewParam.collectionDataList or {}
	end
end

function ArcadeSurvivorGameResultView:onOpen()
	self:onUpdateParam()
	self:_refreshImages()
	self:_refreshStatistics()
	self:_refreshScore()
	self:_refreshReward()
	self:_refreshCollection()
	self:_refreshHp()
	self:_refreshAttr()
	gohelper.setActive(self._gowin, self._isWin)
	gohelper.setActive(self._gofail, not self._isWin)

	if self._isWin then
		AudioMgr.instance:trigger(AudioEnum3_3.Arcade.play_ui_yuanzheng_win)
	else
		AudioMgr.instance:trigger(AudioEnum3_3.Arcade.play_ui_yuanzheng_over)
	end

	self._animator:Play(self._isWin and "open" or "open1")
	UIBlockMgr.instance:startBlock(ArcadeSurvivorEnum.BlockKey.ResultView)
	TaskDispatcher.cancelTask(self._onBlockTimeEnd, self)
	TaskDispatcher.runDelay(self._onBlockTimeEnd, self, TimeUtil.OneSecond)
end

function ArcadeSurvivorGameResultView:_refreshImages()
	local characterIcon = ArcadeSurvivorConfig.instance:getCharacterPortrait(self._characterId)

	self._simageheroicon:LoadImage(ResUrl.getArcadeSurvivorIcon(characterIcon), self._onLoadCharacterIconFinished, self)

	local weaponCollectionId = ArcadeSurvivorConfig.instance:getCharacterWeaponCollectionId(self._characterId)
	local weaponIcon = ArcadeSurvivorConfig.instance:getCollectionIcon(weaponCollectionId)

	self._simageweaponicon:LoadImage(ResUrl.getArcadeSurvivorIcon(weaponIcon))
end

function ArcadeSurvivorGameResultView:_onLoadCharacterIconFinished()
	self._simageheroicon.gameObject:GetComponent(gohelper.Type_Image):SetNativeSize()

	local trans = self._simageheroicon.transform
	local posArr = ArcadeSurvivorConfig.instance:getCharacterPortraitOffset(self._characterId)
	local posX = posArr and tonumber(posArr[1])
	local posY = posArr and tonumber(posArr[2])

	if posX and posY then
		transformhelper.setLocalPosXY(trans, posX, posY)
	end

	local scaleArr = ArcadeSurvivorConfig.instance:getCharacterPortraitScale(self._characterId)
	local scaleX = scaleArr and tonumber(scaleArr[1])
	local scaleY = scaleArr and tonumber(scaleArr[2])

	if scaleX and scaleY then
		transformhelper.setLocalScale(trans, scaleX, scaleY, 1)
	end
end

function ArcadeSurvivorGameResultView:_refreshStatistics()
	self._txtroomnum.text = self._passLevelCount
	self._txtkillnum.text = self._killMonsterNum
	self._txtcoinsnum.text = self._allCoinNum
	self._txttapenum.text = self._bookAddScore

	gohelper.setActive(self._gonewcharacter, self._hasUnlockCharacter)
end

function ArcadeSurvivorGameResultView:_refreshScore()
	local score = self._score or 0

	if score < 0 then
		score = 0
	end

	local icon = ArcadeSurvivorConfig.instance:getGradeIcon(score)

	if icon then
		UISpriteSetMgr.instance:setV3a3EliminateSprite(self._imagelv, icon)
	end
end

function ArcadeSurvivorGameResultView:_refreshReward()
	local settleCurrencyDict = {}

	for _, currencyId in ipairs(ArcadeSurvivorEnum.SettleCurrency) do
		settleCurrencyDict[currencyId] = true
	end

	local rewardList = {}

	for _, rewardData in ipairs(self._rewardDataList) do
		if settleCurrencyDict[rewardData.id] then
			rewardList[#rewardList + 1] = rewardData
		end
	end

	gohelper.setActive(self._goreward, #rewardList > 0)

	self._rewardItemList = self:getUserDataTb_()

	gohelper.CreateObjList(self, self._onCreateRewardItem, rewardList, self._goreward, self._gorewardItem)
end

function ArcadeSurvivorGameResultView:_onCreateRewardItem(obj, data, _)
	local rewardItem = self:getUserDataTb_()

	rewardItem.id = data.id
	rewardItem.go = obj
	rewardItem.imgIcon = gohelper.findChildImage(obj, "icon")
	rewardItem.txtNum = gohelper.findChildText(obj, "#txt_num")

	local icon = ArcadeSurvivorConfig.instance:getCurrencyIcon(rewardItem.id)

	UISpriteSetMgr.instance:setArcadeSurvivorSprite(rewardItem.imgIcon, icon, true)

	rewardItem.txtNum.text = GameUtil.numberDisplay(data.count)
	self._rewardItemList[data.id] = rewardItem
end

function ArcadeSurvivorGameResultView:_refreshCollection()
	self._collectionItemDict = self:getUserDataTb_()

	gohelper.CreateObjList(self, self._onCreateCollectionItem, self._collectionDataList, self._gocollection, self._gocollectionitem)
end

function ArcadeSurvivorGameResultView:_onCreateCollectionItem(obj, data, _)
	local collectionItem = self:getUserDataTb_()

	collectionItem.id = data.id
	collectionItem.go = obj
	collectionItem.simageIcon = gohelper.findChildSingleImage(obj, "#image_icon")
	collectionItem.txtNum = gohelper.findChildText(obj, "#txt_num")

	local icon = ArcadeSurvivorConfig.instance:getCollectionIcon(collectionItem.id)

	collectionItem.simageIcon:LoadImage(ResUrl.getArcadeSurvivorIcon(icon))

	collectionItem.txtNum.text = data.count or 0
	self._collectionItemDict[collectionItem.id] = collectionItem
end

function ArcadeSurvivorGameResultView:_refreshHp()
	self._hpItemList = self:getUserDataTb_()

	local hpCap = self._attrDict[ArcadeSurvivorEnum.Attribute.hpCap] or 0
	local maxShowCount = ArcadeSurvivorConfig.instance:getConst(ArcadeSurvivorEnum.ConstId.MaxShowHpCount, true)
	local showHpCount = math.min(hpCap, maxShowCount)

	gohelper.CreateNumObjList(self._gohpbar, self._gohpitem, showHpCount, self._onCreateHpItem, self)
	self:_setHpIcon(self._attrDict[ArcadeSurvivorEnum.Attribute.hp] or 0, showHpCount)
end

function ArcadeSurvivorGameResultView:_onCreateHpItem(obj, index)
	local hpItem = self:getUserDataTb_()

	hpItem.go = obj
	hpItem.golight = gohelper.findChild(obj, "light")
	hpItem.imgIcon = gohelper.findChildImage(obj, "light")
	self._hpItemList[index] = hpItem
end

function ArcadeSurvivorGameResultView:_setHpIcon(curHp, showHpCount)
	for i, hpItem in ipairs(self._hpItemList) do
		local heartIcon = ArcadeSurvivorGameHelper.getHeartIconName(curHp, showHpCount, i)

		if heartIcon then
			UISpriteSetMgr.instance:setArcadeSurvivorSprite(hpItem.imgIcon, heartIcon)
			gohelper.setActive(hpItem.golight, true)
		else
			gohelper.setActive(hpItem.golight, false)
		end
	end
end

function ArcadeSurvivorGameResultView:_refreshAttr()
	self._attrItemDict = self:getUserDataTb_()

	local showAttrList = self:_getShowAttrList()

	gohelper.CreateObjList(self, self._onCreateAttrItem, showAttrList, self._gobase, self._gobaseItem)
end

function ArcadeSurvivorGameResultView:_getShowAttrList()
	local attrIdList = {
		ArcadeSurvivorEnum.Attribute.atk,
		ArcadeSurvivorEnum.Attribute.dodgeRate,
		ArcadeSurvivorEnum.Attribute.respawnTimes
	}
	local showAttrList = self:getUserDataTb_()

	for _, attrId in ipairs(attrIdList) do
		showAttrList[#showAttrList + 1] = {
			id = attrId,
			value = self._attrDict[attrId] or 0
		}
	end

	return showAttrList
end

function ArcadeSurvivorGameResultView:_onCreateAttrItem(obj, data, _)
	local attrItem = self:getUserDataTb_()

	attrItem.id = data.id
	attrItem.go = obj
	attrItem.txtNum = gohelper.findChildText(obj, "#txt_num")
	attrItem.imgIcon = gohelper.findChildImage(obj, "#txt_num/#image_base")

	local icon = ArcadeSurvivorConfig.instance:getAttributeIcon(attrItem.id)

	UISpriteSetMgr.instance:setArcadeSurvivorSprite(attrItem.imgIcon, icon, true)

	local showValue = ArcadeSurvivorHelper.getAttributeShowValue(attrItem.id, data.value)

	attrItem.txtNum.text = showValue
	self._attrItemDict[attrItem.id] = attrItem
end

function ArcadeSurvivorGameResultView:_onBlockTimeEnd()
	UIBlockMgr.instance:endBlock(ArcadeSurvivorEnum.BlockKey.ResultView)
end

function ArcadeSurvivorGameResultView:onClose()
	TaskDispatcher.cancelTask(self._onBlockTimeEnd, self)
	self:_onBlockTimeEnd()
end

function ArcadeSurvivorGameResultView:onDestroyView()
	self._simageheroicon:UnLoadImage()
	self._simageweaponicon:UnLoadImage()
	self:_clearCollectionItems()
end

function ArcadeSurvivorGameResultView:_clearCollectionItems()
	if not self._collectionItemDict then
		return
	end

	for _, collectionItem in pairs(self._collectionItemDict) do
		collectionItem.simageIcon:UnLoadImage()
	end
end

return ArcadeSurvivorGameResultView
