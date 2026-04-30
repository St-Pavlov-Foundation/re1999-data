-- chunkname: @modules/logic/sodache/view/outside/comp/SodacheHandbookGroupItem.lua

module("modules.logic.sodache.view.outside.comp.SodacheHandbookGroupItem", package.seeall)

local SodacheHandbookGroupItem = class("SodacheHandbookGroupItem", ListScrollCell)

function SodacheHandbookGroupItem:init(go)
	self.goTitle = gohelper.findChild(go, "Title")
	self.imageType = gohelper.findChildImage(go, "Title/image_Type")
	self.txtTitle = gohelper.findChildText(go, "Title/txt_Title")
	self.txtNum = gohelper.findChildText(go, "Title/txt_Num")
	self.btnFold = gohelper.findChildButtonWithAudio(go, "Title/btn_Fold")
	self.goOff = gohelper.findChild(go, "Title/btn_Fold/Off")
	self.goOn = gohelper.findChild(go, "Title/btn_Fold/On")
	self.goLayout = gohelper.findChild(go, "Layout")
	self.goCardItem = gohelper.findChild(go, "Layout/CardItem")
	self.goMonsterItem = gohelper.findChild(go, "Layout/MonsterItem")

	self:addClickCb(self.btnFold, self._btnFoldOnClick, self)

	self.cardItemList = {}
	self.monsterItemList = {}

	gohelper.onceAddComponent(go.transform.parent, gohelper.Type_RectMask2D)
end

function SodacheHandbookGroupItem:addEventListeners()
	self:addEventCb(SodacheController.instance, SodacheEvent.OnHandbookSelectChange, self.onSelectChange, self)
	self:addEventCb(SodacheController.instance, SodacheEvent.OnPlayGroupFadeAnim, self.onPlayGroupFadeAnimation, self)
end

function SodacheHandbookGroupItem:_btnFoldOnClick()
	local isFold = self.mo.isFold
	local subType = self.mo.subType

	SodacheController.instance:dispatchEvent(SodacheEvent.OnClickGroupFoldBtn, subType, not isFold)
end

function SodacheHandbookGroupItem:onDestroy()
	if self.tweenId then
		ZProj.TweenHelper.KillById(self.tweenId)

		self.tweenId = nil
	end
end

function SodacheHandbookGroupItem:onUpdateMO(mo)
	if self.tweenId then
		return
	end

	gohelper.setActive(self.goTitle, mo.isGroupTop)
	gohelper.setActive(self.goLayout, not mo.isFold)
	gohelper.setActive(self.goOn, not mo.isFold)
	gohelper.setActive(self.goOff, mo.isFold)

	if not self.mo or self.mo ~= mo then
		self.mo = mo

		local subType = mo.subType

		UISpriteSetMgr.instance:setSodache2Sprite(self.imageType, "sodache_handbook_icon_" .. tostring(subType))

		self.txtTitle.text = luaLang("sodachehandbook_subType" .. tostring(subType))

		local cur, all = SodacheHandbookListModel.instance:getSubTypeCount(subType)

		self.txtNum.text = string.format("%d/%d", cur, all)

		if mo.type == SodacheEnum.HandBookType.Card then
			for _, v in ipairs(self.monsterItemList) do
				gohelper.setActive(v.go, false)
			end

			self:refreshCard()
		else
			for _, v in ipairs(self.cardItemList) do
				gohelper.setActive(v.go, false)
			end

			self:refreshMonster()
		end

		self:refreshSelect()
	end
end

function SodacheHandbookGroupItem:refreshCard()
	for k, config in ipairs(self.mo.handbookCfgs) do
		local item = self.cardItemList[k]

		if not item then
			item = self:getUserDataTb_()
			item.go = gohelper.cloneInPlace(self.goCardItem)

			local goCard = gohelper.findChild(item.go, "Card")

			item.cardItem = MonoHelper.addNoUpdateLuaComOnceToGo(goCard, SodacheCardItem)

			item.cardItem:setOverrideClick(self.onClickItem, self, k)

			item.goSelect = item.cardItem.goSelect
			self.cardItemList[k] = item
		end

		item.cardItem:updateMo(SodacheCardMo.Create(config.eleId))
		gohelper.setActive(item.go, true)
	end

	for i = #self.mo.handbookCfgs + 1, #self.cardItemList do
		gohelper.setActive(self.cardItemList[i].go, false)
	end
end

function SodacheHandbookGroupItem:refreshMonster()
	for k, config in ipairs(self.mo.handbookCfgs) do
		local item = self.monsterItemList[k]

		if not item then
			item = self:getUserDataTb_()
			item.go = gohelper.cloneInPlace(self.goMonsterItem)
			item.goSelect = gohelper.findChild(item.go, "go_Select")
			item.simageIcon = gohelper.findChildSingleImage(item.go, "simage_Icon")
			item.imageTag = gohelper.findChildImage(item.go, "image_Tag")
			item.imageCareer = gohelper.findChildImage(item.go, "image_Career")
			self.monsterItemList[k] = item

			local btnClick = gohelper.findChildButtonWithAudio(item.go, "btn_Click")

			self:addClickCb(btnClick, self.onClickItem, self, k)
		end

		local monsterCo = lua_monster.configDict[config.eleId]

		if monsterCo then
			local skinCo = lua_monster_skin.configDict[monsterCo.skinId]

			item.simageIcon:LoadImage(ResUrl.monsterHeadIcon(skinCo.headIcon))
			UISpriteSetMgr.instance:setEnemyInfoSprite(item.imageCareer, "sxy_" .. tostring(monsterCo.career))
		end

		gohelper.setActive(item.go, true)
	end

	for i = #self.mo.handbookCfgs + 1, #self.monsterItemList do
		gohelper.setActive(self.monsterItemList[i].go, false)
	end
end

function SodacheHandbookGroupItem:onClickItem(index)
	local handbookCfg = self.mo.handbookCfgs[index]

	if handbookCfg then
		SodacheController.instance:dispatchEvent(SodacheEvent.OnClickHandbookItem, handbookCfg.id)
	end
end

function SodacheHandbookGroupItem:onSelectChange(handbookId)
	self.selectId = handbookId

	self:refreshSelect()
end

function SodacheHandbookGroupItem:refreshSelect()
	local list = self.mo.type == SodacheEnum.HandBookType.Card and self.cardItemList or self.monsterItemList

	for k, config in ipairs(self.mo.handbookCfgs) do
		if list[k] then
			gohelper.setActive(list[k].goSelect, config.id == self.selectId)
		end
	end
end

function SodacheHandbookGroupItem:onPlayGroupFadeAnimation(effectParams)
	if not effectParams or effectParams.mo ~= self.mo then
		return
	end

	self.tempMo = effectParams.mo
	self.tempFold = effectParams.isFold

	local orginLineHeight = effectParams.orginLineHeight
	local targetLineHeight = effectParams.targetLineHeight
	local duration = effectParams.duration

	gohelper.setActive(self.goLayout, true)

	self.tweenId = ZProj.TweenHelper.DOTweenFloat(orginLineHeight, targetLineHeight, duration, self.onOpenTweenFrameCallback, self.onOpenTweenFinishCallback, self, nil, EaseType.Linear)
end

function SodacheHandbookGroupItem:onOpenTweenFrameCallback(value)
	if self.tempMo then
		self.tempMo:overrideLineHeight(value)
		SodacheHandbookListModel.instance:onModelUpdate()
	end
end

function SodacheHandbookGroupItem:onOpenTweenFinishCallback()
	self.tweenId = nil

	if self.tempMo then
		self.tempMo:clearOverrideLineHeight()
		self.tempMo:setIsFold(self.tempFold)

		self.tempMo = nil
		self.tempFold = nil

		SodacheHandbookListModel.instance:onModelUpdate()
	end
end

return SodacheHandbookGroupItem
