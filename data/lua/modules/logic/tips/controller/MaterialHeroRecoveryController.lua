-- chunkname: @modules/logic/tips/controller/MaterialHeroRecoveryController.lua

module("modules.logic.tips.controller.MaterialHeroRecoveryController", package.seeall)

local MaterialHeroRecoveryController = class("MaterialHeroRecoveryController", BaseController)
local __G__TRACKBACK__ = __G__TRACKBACK__
local xpcall = xpcall

function MaterialHeroRecoveryController:onInit()
	return
end

function MaterialHeroRecoveryController:addConstEvents()
	return
end

function MaterialHeroRecoveryController:openHeroRecoveryTipView(itemId)
	local itemType = MaterialEnum.MaterialType.Item
	local config = ItemModel.instance:getItemConfig(itemType, itemId)

	if not config then
		logError(string.format("物品回收角色，道具不存在。itemType:%s，itemId:%s", itemType, itemId))

		return
	end

	local heroId = tonumber(config.effect)
	local heroMO = HeroModel.instance:getByHeroId(heroId)

	if not heroMO then
		GameFacade.showToast(ToastEnum.EquipSkillCharacter)

		if not HeroConfig.instance:getHeroCO(heroId) then
			logError(string.format("物品回收角色，角色id配置错误。roleId:%s，itemId:%s", heroId, itemId))
		end

		return
	end

	ViewMgr.instance:openView(ViewName.MaterialHeroRecoveryTipView, {
		itemType = itemType,
		itemId = itemId
	})
end

function MaterialHeroRecoveryController:openHeroRecoveryWindowView(cb, cbObj)
	ViewMgr.instance:openView(ViewName.HeroRecoveryWindowView, {
		clickCb = cb,
		clickCbObj = cbObj
	})
end

function MaterialHeroRecoveryController:heroRecoverLogic(heroId)
	xpcall(self._heroRecoverLogic, __G__TRACKBACK__, self, heroId)
end

function MaterialHeroRecoveryController:_heroRecoverLogic(heroId)
	self._heroId = heroId

	local heroGoalsMO = CharacterRecommedModel.instance:getTracedHeroDevelopGoalsMO()

	if heroGoalsMO and heroGoalsMO._heroId == heroId then
		heroGoalsMO:setTraced(false)
		CharacterRecommedModel.instance:setTracedHeroDevelopGoalsMO(nil)
	end

	if CharacterSwitchListModel.instance:getMainHero() == heroId then
		local switchHeroId = 3028
		local isRandom = true
		local heroMo = HeroModel.instance:getByHeroId(heroId)

		if heroMo then
			isRandom = false
		end

		CharacterSwitchListModel.instance:changeMainHero(switchHeroId, 0, isRandom)
	end

	local playercardinfo = PlayerCardModel.instance:getCardInfo()

	if playercardinfo and not string.nilorempty(playercardinfo.heroCover) then
		local cardHeroId, _skinId, _isRandom, _isL2d = playercardinfo:getMainHero()

		if not _isRandom or cardHeroId == heroId then
			PlayerCardRpc.instance:sendSetPlayerCardHeroCoverRequest("")
		end
	end
end

MaterialHeroRecoveryController.instance = MaterialHeroRecoveryController.New()

return MaterialHeroRecoveryController
