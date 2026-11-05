-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/view/tip/ArcadeSurvivorWeaponTipsView.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.view.tip.ArcadeSurvivorWeaponTipsView", package.seeall)

local ArcadeSurvivorWeaponTipsView = class("ArcadeSurvivorWeaponTipsView", ArcadeSurvivorTipsChildViewBase)

function ArcadeSurvivorWeaponTipsView:init(go)
	self.viewGO = go
	self._simagecontentbg = gohelper.findChildSingleImage(self.viewGO, "contentbg")
	self._txtnum = gohelper.findChildText(self.viewGO, "Top/boom/#txt_num")
	self._simageweaponicon = gohelper.findChildSingleImage(self.viewGO, "Top/weapon/has/#image_icon")
	self._scrolltips = gohelper.findChildScrollRect(self.viewGO, "#scroll_tips")
	self._txtname = gohelper.findChildText(self.viewGO, "#scroll_tips/Viewport/Content/#txt_name")
	self._imageline = gohelper.findChildImage(self.viewGO, "#scroll_tips/Viewport/Content/#txt_name/line1")
	self._txtdec = gohelper.findChildText(self.viewGO, "#scroll_tips/Viewport/Content/#txt_dec")
	self._txtatk = gohelper.findChildText(self.viewGO, "#scroll_tips/Viewport/Content/#go_attri/go_attriitem/#txt_num")
	self._txtatkInterval = gohelper.findChildText(self.viewGO, "#scroll_tips/Viewport/Content/#go_attri/go_attriitem_2/#txt_num")
	self._txtcriRate = gohelper.findChildText(self.viewGO, "#scroll_tips/Viewport/Content/#go_attri/go_attriitem_3/#txt_num")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ArcadeSurvivorWeaponTipsView:addEventListeners()
	return
end

function ArcadeSurvivorWeaponTipsView:removeEventListeners()
	return
end

function ArcadeSurvivorWeaponTipsView:onUpdateMO(mo, tipview)
	self._isInSide = mo.isInSide
	self._showNew = false

	if self._isInSide then
		if not self._weaponId or self._weaponId ~= mo.weaponId then
			self._showNew = true
		end

		self._weaponId = mo.weaponId
	else
		if not self._weaponMO or mo.weaponMO and self._weaponMO.type ~= mo.weaponMO.type then
			self._showNew = true
		end

		self._weaponMO = mo.weaponMO
	end

	ArcadeSurvivorWeaponTipsView.super.onUpdateMO(self, mo, tipview)
end

function ArcadeSurvivorWeaponTipsView:isPlayOpenAnim()
	return self._showNew or self._isChange
end

function ArcadeSurvivorWeaponTipsView:refreshView()
	local name, icon, descWithAttr
	local characterId = self._mo.characterId
	local characterMO = ArcadeSurvivorGameModel.instance:getCharacterMO()

	if self._weaponMO then
		name = self._weaponMO:getName()

		local desc = self._weaponMO:getDesc()

		descWithAttr = ArcadeSurvivorHelper.getCollectionDescWithAttr(desc, characterId)
		icon = self._weaponMO:getIcon()
	else
		name = ArcadeSurvivorConfig.instance:getCollectionName(self._weaponId)

		local desc = ArcadeSurvivorConfig.instance:getCollectionDesc(self._weaponId)

		descWithAttr = ArcadeSurvivorHelper.getCollectionDescWithAttr(desc, characterId, characterMO)
		icon = ArcadeSurvivorConfig.instance:getCollectionIcon(self._weaponId)
	end

	self._txtname.text = name
	self._txtdec.text = descWithAttr

	local atk = ArcadeSurvivorConfig.instance:getCharacterAtk(characterId)
	local atkInterval = ArcadeSurvivorConfig.instance:getCharacterAtkInterval(characterId)
	local criRate = ArcadeSurvivorConfig.instance:getCharacterCriRate(characterId)

	if self._isInSide and characterMO then
		atk = characterMO:getAttrValue(ArcadeSurvivorEnum.Attribute.atk)
		atkInterval = characterMO:getAttrValue(ArcadeSurvivorEnum.Attribute.atkInterval)
		criRate = characterMO:getAttrValue(ArcadeSurvivorEnum.Attribute.criRate)
	end

	self._txtatk.text = atk
	self._txtatkInterval.text = atkInterval

	local factor = ArcadeSurvivorEnum.Const.PermillageBase / ArcadeSurvivorEnum.Const.PercentBase

	self._txtcriRate.text = criRate / factor

	if not string.nilorempty(icon) then
		local res = ResUrl.getArcadeSurvivorIcon(icon)

		self._simageweaponicon:LoadImage(res)
	end

	local tipBgRes = "game/v3a3_eliminate_game_tipsbg3"

	self._simagecontentbg:LoadImage(ResUrl.getArcadeSurvivorIcon(tipBgRes))

	local tipNameColor = "#E6E0F2"

	self._txtname.color = GameUtil.parseColor(tipNameColor)

	local tipLineColor = "#A49BB9"

	self._imageline.color = GameUtil.parseColor(tipLineColor)
end

function ArcadeSurvivorWeaponTipsView:onDestroy()
	self._simageweaponicon:UnLoadImage()
	self._simagecontentbg:UnLoadImage()
end

return ArcadeSurvivorWeaponTipsView
