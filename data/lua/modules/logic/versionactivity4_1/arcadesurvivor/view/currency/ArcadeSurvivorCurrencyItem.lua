-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/view/currency/ArcadeSurvivorCurrencyItem.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.view.currency.ArcadeSurvivorCurrencyItem", package.seeall)

local ArcadeSurvivorCurrencyItem = class("ArcadeSurvivorCurrencyItem", ListScrollCellExtend)

function ArcadeSurvivorCurrencyItem:onInitView()
	self._image = gohelper.findChildImage(self.viewGO, "#image")
	self._txt = gohelper.findChildText(self.viewGO, "content/#txt")
	self._btnclick = ArcadeSurvivorGameHelper.getArcadeSurvivorButton(self.viewGO, "#btn_click")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ArcadeSurvivorCurrencyItem:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function ArcadeSurvivorCurrencyItem:removeEvents()
	self._btnclick:RemoveClickListener()
end

function ArcadeSurvivorCurrencyItem:_btnclickOnClick()
	local anchor = {
		x = -100,
		y = -250
	}
	local param = {
		currencyId = self._currencyId,
		root = self._parentClass._gotipview,
		anchorPos = anchor,
		originalViewName = self._parentClass.viewName
	}

	ArcadeSurvivorController.instance:openTipView(ArcadeSurvivorEnum.TipType.Currency, param)
end

function ArcadeSurvivorCurrencyItem:_editableInitView()
	return
end

function ArcadeSurvivorCurrencyItem:_editableAddEvents()
	return
end

function ArcadeSurvivorCurrencyItem:_editableRemoveEvents()
	return
end

function ArcadeSurvivorCurrencyItem:onUpdateMO(mo, isInGame, parant)
	self._currencyId = mo
	self._parentClass = parant

	local values = 0

	if isInGame then
		values = ArcadeSurvivorGameModel.instance:getCurrencyCount(mo)
	else
		values = ArcadeSurvivorOutSideModel.instance:getOutsideCurrencyCount(mo)
	end

	self._txt.text = GameUtil.numberDisplay(values)

	local smallIcon = ArcadeSurvivorConfig.instance:getCurrencySmallIcon(self._currencyId)

	if not string.nilorempty(smallIcon) then
		UISpriteSetMgr.instance:setArcadeSurvivorSprite(self._image, smallIcon)
	end
end

function ArcadeSurvivorCurrencyItem:onSelect(isSelect)
	return
end

function ArcadeSurvivorCurrencyItem:onDestroyView()
	return
end

return ArcadeSurvivorCurrencyItem
