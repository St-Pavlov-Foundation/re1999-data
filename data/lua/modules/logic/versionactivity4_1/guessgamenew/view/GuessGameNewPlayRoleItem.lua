-- chunkname: @modules/logic/versionactivity4_1/guessgamenew/view/GuessGameNewPlayRoleItem.lua

module("modules.logic.versionactivity4_1.guessgamenew.view.GuessGameNewPlayRoleItem", package.seeall)

local GuessGameNewPlayRoleItem = class("GuessGameNewPlayRoleItem", LuaCompBase)

function GuessGameNewPlayRoleItem:init(go, giftGo)
	self.go = go
	self._giftGo = giftGo

	self:_findNodes()
	self:_initItem()
	self:_addEvents()
end

function GuessGameNewPlayRoleItem:_findNodes()
	self._gogifts = gohelper.findChild(self.go, "root/go_gifts")
	self._goreducehp = gohelper.findChild(self.go, "root/go_reducehp")
end

function GuessGameNewPlayRoleItem:_initItem()
	gohelper.setActive(self.go, true)
	gohelper.setParent(self._giftGo, self._gogifts)
	gohelper.setActive(self._gogifts, false)
	gohelper.setActive(self._giftGo, false)
	gohelper.setActive(self._gohpitem, false)

	self._giftItems = self:getUserDataTb_()
	self._hpItems = self:getUserDataTb_()
end

function GuessGameNewPlayRoleItem:_addEvents()
	return
end

function GuessGameNewPlayRoleItem:_removeEvents()
	return
end

function GuessGameNewPlayRoleItem:getRoleType()
	return self._roleType or GuessGameNewEnum.RoleType.Player
end

function GuessGameNewPlayRoleItem:refresh(roleType)
	self._roleType = roleType or self:getRoleType()
	self._roleMo = GuessGameNewModel.instance:getRoleData(self._roleType)

	self:_refreshRoleInfo()
	self:refreshHp()
end

function GuessGameNewPlayRoleItem:showRole(show)
	gohelper.setActive(self.go, show)
end

function GuessGameNewPlayRoleItem:_refreshRoleInfo()
	return
end

function GuessGameNewPlayRoleItem:refreshHp()
	local initHp = GuessGameNewConfig.instance:getConstNumberValue(GuessGameNewEnum.ConstId.LifeValue)

	for i = 1, initHp do
		if not self._hpItems[i] then
			self._hpItems[i] = GuessGameNewPlayHpItem.New()

			local go = gohelper.clone(self._gohpitem, self._gohp)

			self._hpItems[i]:init(go, i, self:getRoleType())
		end

		self._hpItems[i]:refresh()
	end
end

function GuessGameNewPlayRoleItem:showGifts(show, giftScale)
	if not show then
		gohelper.setActive(self._gogifts, false)

		return
	end

	gohelper.setActive(self._gogifts, true)

	self._roleMo = GuessGameNewModel.instance:getRoleData(self:getRoleType())

	if not self._roleMo then
		return
	end

	local giftList = self._roleMo.gifts

	for i = 1, #giftList do
		if not self._giftItems[i] then
			self._giftItems[i] = GuessGameNewPlayGiftItem.New()

			local go = gohelper.clone(self._giftGo, self._gogifts)

			self._giftItems[i]:init(go, i)
		end

		self._giftItems[i]:refresh(giftList[i])
		self._giftItems[i]:setScale(giftScale or 1)
	end

	for _, giftItem in pairs(self._giftItems) do
		giftItem:showItem(true)
	end

	self:_afterShowGifts()
end

function GuessGameNewPlayRoleItem:_afterShowGifts()
	return
end

function GuessGameNewPlayRoleItem:hideSelectGifts()
	gohelper.setActive(self._gogifts, true)

	for index, item in ipairs(self._giftItems) do
		local showItem = not LuaUtil.tableContains(self._roleMo.selectGifts, index)

		item:showItem(showItem)
	end
end

function GuessGameNewPlayRoleItem:refreshGiftsSelect(show)
	if not self._giftItems then
		return
	end

	local roleMo = self._roleMo or GuessGameNewModel.instance:getRoleData(self:getRoleType())

	if not roleMo then
		return
	end

	for index, item in ipairs(self._giftItems) do
		local showSelect = show and LuaUtil.tableContains(roleMo.selectGifts, index)

		item:showSelect(showSelect)
	end
end

function GuessGameNewPlayRoleItem:showRoleDistributeTalk()
	return
end

function GuessGameNewPlayRoleItem:showRoleResultTalk(right)
	return
end

function GuessGameNewPlayRoleItem:showRoleSelect(show)
	self:refreshGiftsSelect(show)
end

function GuessGameNewPlayRoleItem:showGiftOpen(show)
	if self._giftItems then
		for _, item in pairs(self._giftItems) do
			item:showOpen(show)
		end
	end
end

function GuessGameNewPlayRoleItem:showRoleReduceHp()
	AudioMgr.instance:trigger(AudioEnum4_1.GuessGameNew.play_ui_beiai_kapai_loseblood)
	gohelper.setActive(self._goreducehp, true)
end

function GuessGameNewPlayRoleItem:showMask()
	return
end

function GuessGameNewPlayRoleItem:destroy()
	if self._hpItems then
		for _, item in pairs(self._hpItems) do
			item:destroy()
		end

		self._hpItems = nil
	end

	if self._giftItems then
		for _, item in pairs(self._giftItems) do
			item:destroy()
		end

		self._giftItems = nil
	end

	self:_removeEvents()
end

return GuessGameNewPlayRoleItem
