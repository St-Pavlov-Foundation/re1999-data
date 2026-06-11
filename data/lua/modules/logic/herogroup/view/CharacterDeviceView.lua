-- chunkname: @modules/logic/herogroup/view/CharacterDeviceView.lua

module("modules.logic.herogroup.view.CharacterDeviceView", package.seeall)

local CharacterDeviceView = class("CharacterDeviceView", LuaCompBase)

function CharacterDeviceView:init(go)
	self.viewGO = go
	self._godevice = gohelper.findChild(self.viewGO, "#go_device")
	self._gonomal = gohelper.findChild(self.viewGO, "#go_device/#go_nomal")
	self._gonormalItem = gohelper.findChild(self.viewGO, "#go_device/#go_nomal/item")
	self._gospecial = gohelper.findChild(self.viewGO, "#go_device/#go_special")
	self._gospecialItem = gohelper.findChild(self.viewGO, "#go_device/#go_special/item")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CharacterDeviceView:addEvents()
	return
end

function CharacterDeviceView:removeEvents()
	return
end

local CardPath = "ui/viewres/fight/fight3_7devicecarditem.prefab"

function CharacterDeviceView:_editableInitView()
	gohelper.setActive(self._gonormalItem, false)
	gohelper.setActive(self._gospecialItem, false)

	self._cardNum = 3
	self._isLoadFinish = false

	local playcards = gohelper.findChild(self.viewGO, "playcards/card_layout")

	self._cardItems = self:getUserDataTb_()

	for i = 1, self._cardNum do
		local item = self:getUserDataTb_()

		item.root = gohelper.findChild(playcards, "card" .. i)
		self._cardItems[i] = item
	end

	self.loader = MultiAbLoader.New()

	self.loader:addPath(CardPath)
	self.loader:startLoad(self.onLoadedCallback, self)

	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function CharacterDeviceView:onLoadedCallback()
	local assetItem = self.loader:getFirstAssetItem()
	local prefab = assetItem:GetResource()

	for i, item in ipairs(self._cardItems) do
		item.index = i
		item.super = item.index == 3
		item.go = gohelper.clone(prefab, item.root)

		recthelper.setAnchor(item.go.transform, 0, 0)

		item.btn = gohelper.getClick(item.go)

		item.btn:AddClickListener(self._onSkillCardClick, self, item.index)

		item.goNormal = gohelper.findChild(item.go, "normal")
		item.goNormalSelect = gohelper.findChild(item.goNormal, "go_select")
		item.normalImageIcon = gohelper.findChildSingleImage(item.goNormal, "imgIcon")
		item.normalImageCardCover = gohelper.findChildImage(item.goNormal, "#image_cardCareer")
		item.tagIcon = gohelper.findChildSingleImage(item.goNormal, "tag/tagIcon")
		item.imageCareerBg = gohelper.findChildImage(item.goNormal, "cost/#image_numCareer")
		item.txtPower = gohelper.findChildText(item.goNormal, "cost/#txt_enough")
		item.goNormalGrayMask = gohelper.findChild(item.goNormal, "gray_mask")
		item.goNormalLock = gohelper.findChild(item.goNormal, "lock")
		item.goUnique = gohelper.findChild(item.go, "unique")
		item.goUniqueSelect = gohelper.findChild(item.goUnique, "go_select")
		item.uniqueImageIcon = gohelper.findChildSingleImage(item.goUnique, "imgIcon")
		item.goUniqueGrayMask = gohelper.findChild(item.goUnique, "gray_mask")
		item.goUniqueLock = gohelper.findChild(item.goUnique, "lock")
		item.goScanSuccess = gohelper.findChild(item.go, "success")
		item.goScanFail = gohelper.findChild(item.go, "fail")
		item.goScanLine = gohelper.findChild(item.go, "scanline")
		item.goMask = gohelper.findChild(item.go, "normal/mask")
		item.goVx1 = gohelper.findChild(item.go, "normal/vx_success")
		item.goVx2 = gohelper.findChild(item.go, "normal/vx_fail")

		gohelper.setActive(item.goNormal, not item.super)
		gohelper.setActive(item.goUnique, item.super)

		item.icon = item.super and item.uniqueImageIcon or item.normalImageIcon

		gohelper.setActive(item.goNormalGrayMask, false)
		gohelper.setActive(item.goMask, false)
		gohelper.setActive(item.goNormalLock, false)
		gohelper.setActive(item.goUniqueLock, false)
		gohelper.setActive(item.goUniqueGrayMask, false)
		gohelper.setActive(item.goScanSuccess, false)
		gohelper.setActive(item.goScanFail, false)
		gohelper.setActive(item.goScanLine, false)
		gohelper.setActive(item.goNormalSelect, false)
		gohelper.setActive(item.goUniqueSelect, false)
		gohelper.setActive(item.goVx1, false)
		gohelper.setActive(item.goVx2, false)
	end

	self._isLoadFinish = true

	self:_refreshCardUI()
end

function CharacterDeviceView:_refreshCardUI()
	if not self._isLoadFinish or not self._deviceMo then
		return
	end

	for i, item in ipairs(self._cardItems) do
		local index = item.index
		local skillId = self._deviceMo:getSkillId(index)
		local hasSkill = skillId ~= 0

		if hasSkill then
			local skillCO = lua_skill.configDict[skillId]

			if not skillCO then
				logError(string.format("heroID : %s, skillId not found : %s", self._heroId, skillId))
			end

			item.icon:LoadImage(ResUrl.getSkillIcon(skillCO.icon))

			if not item.super then
				local skillInfo = self._deviceMo:getSkillInfo(index)

				UISpriteSetMgr.instance:setFightSprite(item.imageCareerBg, FightDeviceHelper.getCareerImage(skillInfo[2]))

				item.txtPower.text = skillInfo[3]

				item.tagIcon:LoadImage(ResUrl.getAttributeIcon("attribute_" .. skillCO.showTag))
				UISpriteSetMgr.instance:setFightSprite(item.normalImageCardCover, FightDeviceHelper.getCareerCoverImage(skillInfo[2]))
			end
		end

		gohelper.setActive(item.go.gameObject, hasSkill)
	end
end

function CharacterDeviceView:onUpdateMO(heroId, heroMo, param, isBalance, showAttributeOption, balanceHelper)
	self._heroId = heroId
	self._heroMo = heroMo
	self._isBalance = isBalance
	self._showAttributeOption = showAttributeOption
	self._balanceHelper = balanceHelper
	self._param = param

	local heroCo = HeroConfig.instance:getHeroCO(self._heroId)

	self._heroName = heroCo.name
	self._deviceMo = SkillConfig.instance:getHeroDeviceMO(self._heroId, self._heroMo)

	if not self._deviceMo then
		return
	end

	self:_refreshUI()
end

function CharacterDeviceView:_getPowerSkillItem(index)
	if not self._normalPowerSkillItems then
		self._normalPowerSkillItems = self:getUserDataTb_()
	end

	local item = self._normalPowerSkillItems[index]

	if not item then
		item = self:getUserDataTb_()
		item.go = gohelper.cloneInPlace(self._gonormalItem)
		item.imgIcon = gohelper.findChildImage(item.go, "imgIcon")
		item.txtnum = gohelper.findChildText(item.go, "#txt_num")
		item.btn = gohelper.findChildButtonWithAudio(item.go, "bg", AudioEnum.UI.Play_ui_role_description)
		self._normalPowerSkillItems[index] = item
	end

	return item
end

function CharacterDeviceView:_getSpecialPowerSkillItem(index)
	if not self._specialPowerSkillItems then
		self._specialPowerSkillItems = self:getUserDataTb_()
	end

	local item = self._specialPowerSkillItems[index]

	if not item then
		item = self:getUserDataTb_()
		item.go = gohelper.cloneInPlace(self._gospecialItem)
		item.simgIcon = gohelper.findChildSingleImage(item.go, "imgIcon")
		item.txtnum = gohelper.findChildText(item.go, "#txt_num")
		item.btn = gohelper.findChildButtonWithAudio(item.go, "bg", AudioEnum.UI.Play_ui_role_description)
		self._specialPowerSkillItems[index] = item
	end

	return item
end

function CharacterDeviceView:_refreshUI()
	self:_refreshCardUI()

	self._powerSkills = self._deviceMo:getPowerSkills()
	self._specialPowerSkill = self._deviceMo:getSpecialPowerSkills()

	local count1 = 0

	if self._powerSkills then
		for i, info in ipairs(self._powerSkills) do
			local item = self:_getPowerSkillItem(i)
			local skillId = info.skillId
			local energyType = info.energyType
			local count = info.energyCount
			local powerCo = lua_device_power.configDict[energyType] and lua_device_power.configDict[energyType][count]

			if powerCo then
				UISpriteSetMgr.instance:setUiCharacterSprite(item.imgIcon, powerCo.powerIcon)
			end

			item.txtnum.text = string.format("<size=18>%s</size>%s", luaLang("multiple"), info.count)

			item.btn:AddClickListener(self._onDeviceNormalSkillCardClick, self, i)

			count1 = count1 + 1
		end
	end

	for i = 1, #self._normalPowerSkillItems do
		local item = self._normalPowerSkillItems[i]

		gohelper.setActive(item.go, i <= count1)
	end

	local count2 = 0

	if self._specialPowerSkill then
		for i, info in ipairs(self._specialPowerSkill) do
			local item = self:_getSpecialPowerSkillItem(i)
			local skillId = info.skillId
			local skillCO = lua_skill.configDict[skillId]

			item.simgIcon:LoadImage(ResUrl.getSkillIcon(skillCO.icon))

			item.txtnum.text = string.format("<size=18>%s</size>%s", luaLang("multiple"), info.count)

			item.btn:AddClickListener(self._onDeviceSecialSkillCardClick, self, i)

			count2 = count2 + 1
		end
	end

	for i = 1, #self._specialPowerSkillItems do
		local item = self._specialPowerSkillItems[i]

		gohelper.setActive(item.go, i <= count2)
	end
end

function CharacterDeviceView:_onDeviceNormalSkillCardClick(index)
	if self._powerSkills then
		local skillInfo = self._powerSkills[index]

		if skillInfo then
			local skillIdList = {
				skillInfo.skillId
			}

			self:_onDeviceSkillCardClick(skillIdList)
		end
	end
end

function CharacterDeviceView:_onDeviceSecialSkillCardClick(index)
	if self._specialPowerSkill then
		local skillInfo = self._specialPowerSkill[index]

		if skillInfo then
			local skillIdList = {
				skillInfo.skillId
			}

			self:_onDeviceSkillCardClick(skillIdList)
		end
	end
end

function CharacterDeviceView:_onDeviceSkillCardClick(skillIdList, skillIndex)
	if self._heroId then
		local info = {}

		if self._deviceMo then
			info.super = skillIndex == 3
			info.skillIndex = skillIndex
			info.skillIdList = skillIdList
			info.isBalance = self._isBalance
			info.monsterName = self._heroName
			info.heroId = self._heroId
			info.heroMo = self._heroMo

			if self._param then
				info.anchorX = self._param.skillTipX
				info.anchorY = self._param.skillTipY
				info.adjustBuffTip = self._param.adjustBuffTip
				info.showAssassinBg = self._param.showAssassinBg
			end

			info.isDeviceSkill = true

			ViewMgr.instance:openView(ViewName.SkillTipView, info)
		end
	end
end

function CharacterDeviceView:_onSkillCardClick(index)
	if self._heroId and self._deviceMo then
		local skillid = self._deviceMo:getSkillId(index)

		self:_onDeviceSkillCardClick({
			skillid
		}, index)
	end

	AudioMgr.instance:trigger(AudioEnum.UI.Play_ui_role_description)
end

function CharacterDeviceView:playAnim(animName)
	if not self._animator then
		return
	end

	self._animator:Play(animName, 0, 0)
end

function CharacterDeviceView:onDestroy()
	if self._normalPowerSkillItems then
		for i = 1, #self._normalPowerSkillItems do
			local item = self._normalPowerSkillItems[i]

			item.btn:RemoveClickListener()
		end
	end

	if self._specialPowerSkillItems then
		for i = 1, #self._specialPowerSkillItems do
			local item = self._specialPowerSkillItems[i]

			item.btn:RemoveClickListener()
			item.simgIcon:UnLoadImage()
		end
	end

	for i, item in ipairs(self._cardItems) do
		item.btn:RemoveClickListener()
		item.icon:UnLoadImage()
		item.tagIcon:UnLoadImage()
	end

	if self.loader then
		self.loader:dispose()

		self.loader = nil
	end
end

return CharacterDeviceView
