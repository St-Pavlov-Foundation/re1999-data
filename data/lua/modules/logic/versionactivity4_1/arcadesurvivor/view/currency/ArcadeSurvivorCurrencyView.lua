-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/view/currency/ArcadeSurvivorCurrencyView.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.view.currency.ArcadeSurvivorCurrencyView", package.seeall)

local ArcadeSurvivorCurrencyView = class("ArcadeSurvivorCurrencyView", BaseView)

function ArcadeSurvivorCurrencyView:ctor(currencyList, isInGame)
	self._currencyList = currencyList or {}
	self._currencyDict = {}

	for _, currencyId in ipairs(self._currencyList) do
		self._currencyDict[currencyId] = true
	end

	self._isInGame = isInGame
end

function ArcadeSurvivorCurrencyView:onInitView()
	self._gotipview = gohelper.findChild(self.viewGO, "tipview")
	self._goroot = gohelper.findChild(self.viewGO, "#go_root")
	self._goitem = gohelper.findChild(self.viewGO, "#go_item")
	self._image = gohelper.findChildImage(self.viewGO, "#go_item/#image")
	self._txt = gohelper.findChildText(self.viewGO, "#go_item/content/#txt")
	self._golight = gohelper.findChild(self.viewGO, "#Light")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ArcadeSurvivorCurrencyView:addEvents()
	self:addEventCb(ArcadeSurvivorController.instance, ArcadeSurvivorEvent.OnOutsideCurrencyChangePush, self._onOutsideCurrencyChangePush, self)
	self:addEventCb(ArcadeSurvivorGameController.instance, ArcadeSurvivorEvent.OnGameCurrencyChange, self._onGameCurrencyChange, self)
	self:addEventCb(ArcadeSurvivorGameController.instance, ArcadeSurvivorEvent.OnResetGame, self._onResetGame, self)
end

function ArcadeSurvivorCurrencyView:removeEvents()
	self:removeEventCb(ArcadeSurvivorController.instance, ArcadeSurvivorEvent.OnOutsideCurrencyChangePush, self._onOutsideCurrencyChangePush, self)
	self:removeEventCb(ArcadeSurvivorGameController.instance, ArcadeSurvivorEvent.OnGameCurrencyChange, self._onGameCurrencyChange, self)
	self:removeEventCb(ArcadeSurvivorGameController.instance, ArcadeSurvivorEvent.OnResetGame, self._onResetGame, self)
end

function ArcadeSurvivorCurrencyView:_onOutsideCurrencyChangePush()
	if self._isInGame then
		return
	end

	self:refreshView()
end

function ArcadeSurvivorCurrencyView:_onGameCurrencyChange(currencyId)
	if not self._isInGame then
		return
	end

	if self._currencyDict and self._currencyDict[currencyId] then
		self:refreshView()
	end
end

function ArcadeSurvivorCurrencyView:_onResetGame()
	if not self._isInGame then
		return
	end

	self:refreshView()
end

function ArcadeSurvivorCurrencyView:_editableInitView()
	gohelper.setActive(self._goitem, false)
end

function ArcadeSurvivorCurrencyView:onUpdateParam()
	return
end

function ArcadeSurvivorCurrencyView:onOpen()
	self:refreshView()
end

function ArcadeSurvivorCurrencyView:setCurrencyList(currencyList)
	self._currencyList = currencyList

	self:refreshView()
end

function ArcadeSurvivorCurrencyView:refreshView()
	if not self._currencyList then
		return
	end

	gohelper.CreateObjList(self, self._createItemCB, self._currencyList, self._goroot, self._goitem, ArcadeSurvivorCurrencyItem)
end

function ArcadeSurvivorCurrencyView:_createItemCB(obj, data, index)
	obj:onUpdateMO(data, self._isInGame, self)
end

function ArcadeSurvivorCurrencyView:onClose()
	return
end

function ArcadeSurvivorCurrencyView:onDestroyView()
	return
end

return ArcadeSurvivorCurrencyView
