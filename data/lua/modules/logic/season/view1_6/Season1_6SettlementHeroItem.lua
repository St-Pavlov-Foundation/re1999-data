﻿-- chunkname: @modules/logic/season/view1_6/Season1_6SettlementHeroItem.lua

module("modules.logic.season.view1_6.Season1_6SettlementHeroItem", package.seeall)

local Season1_6SettlementHeroItem = class("Season1_6SettlementHeroItem", BaseViewExtended)

function Season1_6SettlementHeroItem:onInitView()
	self._gohero = gohelper.findChild(self.viewGO, "#go_hero")
	self._simageheroicon = gohelper.findChildSingleImage(self.viewGO, "#go_hero/#simage_heroicon")
	self._imagecareer = gohelper.findChildImage(self.viewGO, "#go_hero/#image_career")
	self._gocard1 = gohelper.findChild(self.viewGO, "#go_hero/layout/#go_cards/#go_card1")
	self._gocard2 = gohelper.findChild(self.viewGO, "#go_hero/layout/#go_cards/#go_card2")
	self._gosingle = gohelper.findChild(self.viewGO, "#go_hero/layout/#go_cards/#go_single")
	self._goequip = gohelper.findChild(self.viewGO, "#go_hero/layout/#go_equip")
	self._imageequipicon = gohelper.findChildImage(self.viewGO, "#go_hero/layout/#go_equip/#image_equipicon")
	self._imageequiprare = gohelper.findChildImage(self.viewGO, "#go_hero/layout/#go_equip/#image_equiprare")
	self._gocards = gohelper.findChild(self.viewGO, "#go_hero/layout/#go_cards")
	self._equipPart = gohelper.findChild(self.viewGO, "#go_hero/layout")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season1_6SettlementHeroItem:addEvents()
	return
end

function Season1_6SettlementHeroItem:removeEvents()
	return
end

function Season1_6SettlementHeroItem:onRefreshViewParam(is_replay, hero, equip, equip_104, replay_data, trail)
	self._is_replay = is_replay
	self._hero = hero
	self._equip = equip
	self._equip_104 = equip_104
	self._replay_data = replay_data
	self._trail = trail
end

function Season1_6SettlementHeroItem:onOpen()
	self:setViewVisibleInternal(false)

	if self._is_replay then
		self:_showReplayData()
	else
		self:_showNormalData()
	end

	if self._no104Equip and self._noEquip then
		gohelper.setActive(self._equipPart, false)
	end

	gohelper.setActive(self._gocards, not self._no104Equip)
end

function Season1_6SettlementHeroItem:_showNormalData()
	if self._trail then
		self:_showTrailHeroIcon(self._trail)
	else
		self:_showHeroIcon(self._hero)
	end

	local equip_data = self._equip and EquipModel.instance:getEquip(self._equip[1])
	local equip_id = equip_data and equip_data.equipId

	self:_showEquipIcon(equip_id)

	if self._equip_104 then
		local tar_equip_104 = Activity104Model.instance:getAllItemMo()
		local uidTab = {}

		for i, v in ipairs(self._equip_104) do
			if tar_equip_104[v] then
				table.insert(uidTab, tar_equip_104[v].uid)
			end
		end

		local totalEquipCount = #uidTab

		self._no104Equip = totalEquipCount == 0

		for i, v in ipairs(uidTab) do
			self:_showEquip104(i, v, totalEquipCount)
		end
	end
end

function Season1_6SettlementHeroItem:_showTrailHeroIcon(trail)
	if not trail then
		return
	end

	local trailCo = lua_hero_trial.configDict[trail.trialId][0]
	local heroCo = HeroConfig.instance:getHeroCO(trailCo.heroId)
	local skinConfig

	if trailCo.skin > 0 then
		skinConfig = SkinConfig.instance:getSkinCo(trailCo.skin)
	else
		skinConfig = SkinConfig.instance:getSkinCo(heroCo.skinId)
	end

	local career = heroCo.career

	if skinConfig then
		self._simageheroicon:LoadImage(ResUrl.getHeadIconMiddle(skinConfig.retangleIcon))
	else
		gohelper.setActive(self.viewGO.transform.parent.gameObject, false)
	end

	if career then
		UISpriteSetMgr.instance:setCommonSprite(self._imagecareer, "lssx_" .. tostring(career))
	end
end

function Season1_6SettlementHeroItem:_showHeroIcon(heroId, skinId)
	local hero_mo = HeroModel.instance:getById(heroId)
	local career

	if hero_mo then
		skinId = skinId or hero_mo.skin
		career = hero_mo.config.career
	else
		local entityMo = FightDataHelper.entityMgr:getById(heroId)

		if entityMo then
			local monCo = lua_monster.configDict[entityMo.modelId]

			if monCo then
				skinId = skinId or monCo.skinId
				career = monCo.career
			end
		end
	end

	if skinId then
		local skinConfig = FightConfig.instance:getSkinCO(skinId)

		if skinConfig then
			self._simageheroicon:LoadImage(ResUrl.getHeadIconMiddle(skinConfig.retangleIcon))
		end
	else
		gohelper.setActive(self.viewGO.transform.parent.gameObject, false)
	end

	if career then
		UISpriteSetMgr.instance:setCommonSprite(self._imagecareer, "lssx_" .. tostring(career))
	end
end

function Season1_6SettlementHeroItem:_showEquipIcon(equip_id)
	if equip_id and equip_id ~= 0 then
		local equip_config = EquipConfig.instance:getEquipCo(equip_id)

		UISpriteSetMgr.instance:setHerogroupEquipIconSprite(self._imageequipicon, equip_config.icon)
		UISpriteSetMgr.instance:setHeroGroupSprite(self._imageequiprare, "bianduixingxian_" .. equip_config.rare)
	else
		gohelper.setActive(self._goequip, false)

		self._noEquip = true
	end
end

function Season1_6SettlementHeroItem:_showEquip104(index, uid, totalEquipCount, equipId)
	if equipId == 0 then
		return
	end

	local parentTran = totalEquipCount <= 1 and self._gosingle or self["_gocard" .. index]

	self:openSubView(Season1_6CelebrityCardGetItem, Season1_6CelebrityCardItem.AssetPath, parentTran, uid, nil, equipId)
end

function Season1_6SettlementHeroItem:_showReplayData()
	local hero_uid = self._hero

	self:_showHeroIcon(hero_uid, self._replay_data and self._replay_data.skin)
	self:_showEquipIcon(self._equip and self._equip.equipId)

	if hero_uid ~= "0" and hero_uid ~= "-100000" and self._equip_104 then
		local totalEquipCount = #self._equip_104

		self._no104Equip = totalEquipCount == 0

		for i = 1, totalEquipCount do
			self:_showEquip104(i, self._equip_104[i].equipUid, totalEquipCount, self._equip_104[i].equipId)
		end
	end
end

local EquipPosTab = {}

function Season1_6SettlementHeroItem:_refreshEquipPos()
	return
end

function Season1_6SettlementHeroItem:onClose()
	return
end

function Season1_6SettlementHeroItem:onDestroyView()
	self._simageheroicon:UnLoadImage()
end

return Season1_6SettlementHeroItem
