module("modules.logic.playercard.model.PlayerCardSkinMo", package.seeall)

slot0 = class("PlayerCardSkinMo")

function slot0.ctor(slot0)
	slot0._config = nil
	slot0.id = nil
	slot0.icon = nil
	slot0._isEmpty = false
	slot0._isNew = false
end

function slot0.init(slot0, slot1)
	slot0._mo = slot1
	slot0.id = slot1.id
	slot0._config = ItemConfig.instance:getItemCo(slot0.id)
	slot0.icon = slot0._config.icon
end

function slot0.getConfig(slot0)
	return slot0._config
end

function slot0.checkNew(slot0)
	return slot0._isNew
end

function slot0.clearNewState(slot0)
	slot0._isNew = false
end

function slot0.isEmpty(slot0)
	return slot0._isEmpty
end

function slot0.setEmpty(slot0)
	slot0._isEmpty = true
	slot0.id = 0
end

function slot0.isUnLock(slot0)
	if slot0._isEmpty then
		return true
	end

	return ItemModel.instance:getItemCount(slot0.id) > 0
end

function slot0.canBuyInStore(slot0)
	if not StoreConfig.instance:getDecorateGoodsIdById(slot0.id) then
		return false
	end

	return true
end

function slot0.isStoreDecorateGoodsValid(slot0)
	return StoreModel.instance:isStoreDecorateGoodsValid(slot0.id)
end

function slot0.getSources(slot0)
	return slot0._config.sources
end

function slot0.checkIsUse(slot0)
	if PlayerCardModel.instance:getPlayerCardSkinId() and slot1 ~= 0 then
		return slot1 == slot0.id
	elseif slot0._isEmpty then
		return true
	end

	return false
end

return slot0
