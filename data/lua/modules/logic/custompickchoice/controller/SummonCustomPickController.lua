-- chunkname: @modules/logic/custompickchoice/controller/SummonCustomPickController.lua

module("modules.logic.custompickchoice.controller.SummonCustomPickController", package.seeall)

local SummonCustomPickController = class("SummonCustomPickController", BaseController)

function SummonCustomPickController:openSummonCustomPickView(bePickChoiceHeroIdList, pickHandler, pickHandlerObj, viewParam, showMsgBoxFunc, showMsgBoxFuncObj, maxSelectCount)
	self._pickHandler = pickHandler
	self._pickHandlerObj = pickHandlerObj
	self._showMsgBoxFunc = showMsgBoxFunc
	self._showMsgBoxFuncObj = showMsgBoxFuncObj
	maxSelectCount = maxSelectCount or 1

	SummonCustomPickModel.instance:initData(bePickChoiceHeroIdList, maxSelectCount)

	local haveAllRole = SummonCustomPickModel.instance:haveAllRole()

	self._itemData = viewParam

	if haveAllRole then
		ViewMgr.instance:openView(ViewName.SummonCustomPickView, viewParam)
	else
		self:trySendSummon(viewParam)
	end
end

function SummonCustomPickController:trySendChoice(viewParam)
	self._itemData = viewParam or self._itemData

	local selectList = SummonCustomPickModel.instance:getSelectIds()

	if not selectList then
		GameFacade.showToast(ToastEnum.SummonCustomPickOneMoreSelect)

		return false
	end

	local maxSelectCount = SummonCustomPickModel.instance:getMaxSelectCount()

	if maxSelectCount > #selectList then
		if maxSelectCount == 1 then
			GameFacade.showToast(ToastEnum.SummonCustomPickOneMoreSelect)
		end

		return false
	end

	local heroNameStr = self:getSelectHeroNameStr(selectList)

	GameFacade.showMessageBox(MessageBoxIdDefine.SummonLuckyBagSelectChar, MsgBoxEnum.BoxType.Yes_No, self.realSendChoice, nil, nil, self, nil, nil, heroNameStr, "")
end

function SummonCustomPickController:realSendChoice()
	local selectList = SummonCustomPickModel.instance:getSelectIds()
	local heroId = selectList[1]
	local data = {}
	local o = {}

	o.materialId = self._itemData.id
	o.quantity = self._itemData.quantity

	table.insert(data, o)
	ItemRpc.instance:sendUseItemRequest(data, heroId)
end

function SummonCustomPickController:trySendSummon()
	GameFacade.showMessageBox(MessageBoxIdDefine.Act167SummonNeTip, MsgBoxEnum.BoxType.Yes_No, self.realSendSummon, nil, nil, self, nil, nil, viewParam)
end

function SummonCustomPickController:realSendSummon()
	CharacterModel.instance:setGainHeroViewShowState(true)
	self:registerCallback(SummonCustomPickEvent.OnSummonCustomGet, self.onSummonCustomGet, self)

	local data = {}
	local o = {}

	o.materialId = self._itemData.id
	o.quantity = self._itemData.quantity

	table.insert(data, o)
	ItemRpc.instance:sendUseItemRequest(data, 0)
end

function SummonCustomPickController:onSummonCustomGet(heroId)
	if not SummonCustomPickModel.instance:haveAllRole() then
		self:enterSummon({
			tonumber(heroId)
		})
	end

	self:unregisterCallback(SummonCustomPickEvent.OnSummonCustomGet, self.onSummonCustomGet, self)
end

function SummonCustomPickController:enterSummon(heroList)
	ViewMgr.instancee:closeAllPopupViews()
	SummonController.instance:simpleEnterSummonScene(heroList, self._onBackSummon, self)
end

function SummonCustomPickController:_onBackSummon()
	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Main then
		MainController.instance:enterMainScene(true)
	end

	VirtualSummonScene.instance:close(true)
end

function SummonCustomPickController:getSelectHeroNameStr(selectList)
	local heroNameStr = ""

	for i = 1, #selectList do
		local heroCo = HeroConfig.instance:getHeroCO(selectList[i])

		if i == 1 then
			heroNameStr = heroCo.name
		else
			heroNameStr = heroNameStr .. ", " .. heroCo.name
		end
	end

	return heroNameStr
end

function SummonCustomPickController:setSelect(heroId)
	local selectList = SummonCustomPickModel.instance:getSelectIds()
	local maxSelectCount = SummonCustomPickModel.instance:getMaxSelectCount()

	if not SummonCustomPickModel.instance:isHeroIdSelected(heroId) and maxSelectCount <= #selectList and maxSelectCount == 1 then
		SummonCustomPickModel.instance:clearSelectIds()
	end

	SummonCustomPickModel.instance:setSelectId(heroId)
	self:dispatchEvent(SummonCustomPickEvent.OnCustomPickListChanged)
end

SummonCustomPickController.instance = SummonCustomPickController.New()

LuaEventSystem.addEventMechanism(SummonCustomPickController.instance)

return SummonCustomPickController
