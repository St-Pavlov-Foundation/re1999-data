-- chunkname: @modules/logic/sodache/view/outside/comp/SodacheCardInfoRight.lua

module("modules.logic.sodache.view.outside.comp.SodacheCardInfoRight", package.seeall)

local SodacheCardInfoRight = class("SodacheCardInfoRight", LuaCompBase)

function SodacheCardInfoRight:init(go)
	local goCard = gohelper.findChild(go, "CardItem")

	self.cardItem = MonoHelper.addNoUpdateLuaComOnceToGo(goCard, SodacheCardItem)

	self.cardItem:setActiveClick(false)

	self.imageRare = gohelper.findChildImage(go, "Tags/image_Rare")
	self.txtRare = gohelper.findChildText(go, "Tags/image_Rare/txt_Rare")
	self.goType = gohelper.findChild(go, "Tags/go_Type")
	self.txtType = gohelper.findChildText(go, "Tags/go_Type/txt_Type")
	self.imageType = gohelper.findChildImage(go, "Tags/go_Type/txt_Type/image_Type")
	self.goKezhi = gohelper.findChild(go, "Tags/go_Kezhi")
	self.imageKezhi = gohelper.findChildImage(go, "Tags/go_Kezhi/image_Kezhi")
	self.txtKezhi = gohelper.findChildText(go, "Tags/go_Kezhi/txt_Kezhi")
	self.goAdventureInfo = gohelper.findChild(go, "go_AdventureInfo")
	self.txtAdventureDesc = gohelper.findChildText(self.goAdventureInfo, "Scroll/Viewport/Content/txt_AdventureDesc")
	self.goDiceItem = gohelper.findChild(self.goAdventureInfo, "Attr/Icons/go_DiceItem")

	gohelper.setActive(self.goDiceItem, false)

	self.goBulletInfo = gohelper.findChild(go, "go_BulletInfo")
	self.txtBulletDesc = gohelper.findChildText(self.goBulletInfo, "txt_BulletDesc")
	self.goRelicInfo = gohelper.findChild(go, "go_RelicInfo")
	self.goRelicItem = gohelper.findChild(self.goRelicInfo, "Scroll/Viewport/Content/go_RelicItem")

	gohelper.setActive(self.goRelicItem, false)
end

function SodacheCardInfoRight:setData(data)
	self.data = data

	self.cardItem:updateMo(data)

	self.config = data.serverMo.itemCo

	UISpriteSetMgr.instance:setSodache2Sprite(self.imageRare, "sodache_carddetail_tag_0" .. tostring(self.config.quality))

	self.txtRare.text = luaLang("sodache_cardquality_" .. tostring(self.config.quality))

	local cardType = self.config.type

	self.txtType.text = luaLang("sodache_cardtype_" .. tostring(cardType))

	UISpriteSetMgr.instance:setSodache2Sprite(self.imageType, "sodache_handbook_icon_" .. tostring(cardType))

	local func = self["refreshType" .. tostring(cardType)]

	if func then
		func(self)
	end

	gohelper.setActive(self.goAdventureInfo, cardType == SodacheEnum.CardType.Adventure)
	gohelper.setActive(self.goBulletInfo, cardType ~= SodacheEnum.CardType.Adventure and cardType ~= SodacheEnum.CardType.Offering)
	gohelper.setActive(self.goRelicInfo, cardType == SodacheEnum.CardType.Offering)
end

function SodacheCardInfoRight:refreshType1()
	self.txtBulletDesc.text = self.config.funcDesc
end

function SodacheCardInfoRight:refreshType2()
	self.txtAdventureDesc.text = self.config.funcDesc

	local diceIds = string.splitToNumber(self.config.diceList, "#") or {}

	self._scale = #diceIds <= 3 and 1 or 0.8

	gohelper.CreateObjList(self, self._createDiceItem, diceIds, nil, self.goDiceItem, SodacheDiceItem)
end

function SodacheCardInfoRight:_createDiceItem(obj, data, index)
	obj:setData(data, true)
	transformhelper.setLocalScale(obj.go.transform, self._scale, self._scale, self._scale)
end

function SodacheCardInfoRight:refreshType3()
	self.txtBulletDesc.text = self.config.funcDesc
end

function SodacheCardInfoRight:refreshType5()
	if not self.relicItemList then
		self.relicItemList = {}
	end

	local relicCfgs = lua_sodache_upgrade.configDict[self.config.id]

	for k, config in ipairs(relicCfgs) do
		local item = self.relicItemList[k]

		if not item then
			item = self:getUserDataTb_()
			item.go = gohelper.cloneInPlace(self.goRelicItem)

			local txtNum = gohelper.findChildText(item.go, "txt_Num")

			txtNum.text = k
			item.txtDesc = gohelper.findChildText(item.go, "txt_Desc")
			self.relicItemList[k] = item
		end

		local passive = luaLang("sodache_relicupgrade_passive")
		local passiveDesc = string.format("%s%s", passive, config.effectDesc)

		if string.nilorempty(config.effect2Desc) then
			item.txtDesc.text = passiveDesc
		else
			local active = luaLang("sodache_relicupgrade_active")
			local activeDesc = string.format("%s%s", active, config.effect2Desc)

			item.txtDesc.text = string.format("%s<br>%s", passiveDesc, activeDesc)
		end

		gohelper.setActive(item.go, true)
	end

	for i = #relicCfgs + 1, #self.relicItemList do
		gohelper.setActive(self.relicItemList[i].go, false)
	end
end

return SodacheCardInfoRight
