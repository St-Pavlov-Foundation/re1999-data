-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/view/tip/ArcadeSurvivorCurrencyTipsView.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.view.tip.ArcadeSurvivorCurrencyTipsView", package.seeall)

local ArcadeSurvivorCurrencyTipsView = class("ArcadeSurvivorCurrencyTipsView", ArcadeSurvivorTipsChildViewBase)

function ArcadeSurvivorCurrencyTipsView:init(go)
	self.viewGO = go
	self._txtname = gohelper.findChildText(self.viewGO, "root/title/layout/#txt_name")
	self._imageicon = gohelper.findChildImage(self.viewGO, "root/title/#image_icon")
	self._txtdesc = gohelper.findChildText(self.viewGO, "root/#txt_desc")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ArcadeSurvivorCurrencyTipsView:addEvents()
	return
end

function ArcadeSurvivorCurrencyTipsView:removeEvents()
	return
end

function ArcadeSurvivorCurrencyTipsView:onUpdateMO(mo, tipview)
	self._showNewCurrency = self._currencyId ~= mo.currencyId
	self._currencyId = mo.currencyId

	ArcadeSurvivorCurrencyTipsView.super.onUpdateMO(self, mo, tipview)
end

function ArcadeSurvivorCurrencyTipsView:refreshView()
	local icon = ArcadeSurvivorConfig.instance:getCurrencyIcon(self._currencyId)

	if not string.nilorempty(icon) then
		UISpriteSetMgr.instance:setArcadeSurvivorSprite(self._imageicon, icon)
	end

	local name = ArcadeSurvivorConfig.instance:getCurrencyName(self._currencyId)

	self._txtname.text = name

	local desc = ArcadeSurvivorConfig.instance:getCurrencyDesc(self._currencyId)

	self._txtdesc.text = desc
end

function ArcadeSurvivorCurrencyTipsView:isPlayOpenAnim()
	return self._showNewCurrency or self._isChange
end

function ArcadeSurvivorCurrencyTipsView:onDestroy()
	return
end

return ArcadeSurvivorCurrencyTipsView
