module("modules.logic.versionactivity2_7.towergift.model.DestinyStoneGiftPickChoiceListModel", package.seeall)

slot0 = class("DestinyStoneGiftPickChoiceListModel", ListScrollModel)

function slot1(slot0, slot1)
	if (slot0.heroMo.destinyStoneMo:isUnlockSlot() and 1 or 2) ~= (slot1.heroMo.destinyStoneMo:isUnlockSlot() and 1 or 2) then
		return slot5 < slot4
	end

	if slot2.rank ~= slot3.rank then
		return slot6 < slot7
	end

	return slot1.heroId < slot0.heroId
end

function slot0.initList(slot0)
	slot0._moList = {}

	for slot5, slot6 in pairs(HeroModel.instance:getAllHero()) do
		if slot6 and slot0:checkHeroOpenDestinyStone(slot6) then
			slot7 = slot6.destinyStoneMo
			slot8 = slot7:getStoneMoList()

			if slot7:isSlotMaxLevel() then
				for slot13, slot14 in pairs(slot8) do
					if not slot14.isUnlock then
						table.insert(slot0._moList, {
							heroMo = slot6,
							heroId = slot6.config.id,
							stoneMo = slot14,
							stoneId = slot14.stoneId,
							isUnLock = false
						})
					end
				end
			else
				for slot13, slot14 in pairs(slot8) do
					if ({
						isUnLock = slot14.isUnlock
					}).isUnLock then
						slot15.stonelevel = slot7.rank
					end

					slot15.heroMo = slot6
					slot15.heroId = slot6.config.id
					slot15.stoneMo = slot14
					slot15.stoneId = slot14.stoneId

					table.insert(slot0._moList, slot15)
				end
			end
		end
	end

	table.sort(slot0._moList, uv0)
	slot0:setList(slot0._moList)
end

function slot0.checkHeroOpenDestinyStone(slot0, slot1)
	if not slot1:isHasDestinySystem() then
		return false
	end

	if tonumber(CommonConfig.instance:getConstStr(CharacterDestinyEnum.DestinyStoneOpenLevelConstId[slot1.config.rare or 5])) <= slot1.level and not slot1.destinyStoneMo:checkAllUnlock() then
		return true
	end

	return false
end

function slot0.setCurrentSelectMo(slot0, slot1)
	if not slot0.currentSelectMo then
		slot0.currentSelectMo = slot1
	elseif slot0:isSelectedMo(slot1.stoneId) then
		slot0:clearSelect()
	else
		slot0.currentSelectMo = slot1
	end

	DestinyStoneGiftPickChoiceController.instance:dispatchEvent(DestinyStoneGiftPickChoiceEvent.onCustomPickListChanged)
end

function slot0.getCurrentSelectMo(slot0)
	return slot0.currentSelectMo
end

function slot0.clearSelect(slot0)
	slot0.currentSelectMo = nil
end

function slot0.isSelectedMo(slot0, slot1)
	return slot0.currentSelectMo and slot0.currentSelectMo.stoneId == slot1
end

slot0.instance = slot0.New()

return slot0
