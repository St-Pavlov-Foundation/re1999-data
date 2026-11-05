-- chunkname: @modules/logic/versionactivity4_1/guessgamenew/view/GuessGameNewPlayPlayerItem.lua

module("modules.logic.versionactivity4_1.guessgamenew.view.GuessGameNewPlayPlayerItem", package.seeall)

local GuessGameNewPlayPlayerItem = class("GuessGameNewPlayPlayerItem", GuessGameNewPlayRoleItem)

function GuessGameNewPlayPlayerItem:_findNodes()
	GuessGameNewPlayRoleItem._findNodes(self)

	self._gonormal = gohelper.findChild(self.go, "root/go_normal")
	self._godarkmask = gohelper.findChild(self.go, "root/go_normal/go_darkMask")
	self._simagehero = gohelper.findChildSingleImage(self.go, "root/go_normal/#simage_hero")
	self._txtname = gohelper.findChildText(self.go, "root/go_normal/namebg/txt_name")
	self._gohp = gohelper.findChild(self.go, "root/go_normal/go_hp")
	self._gohpitem = gohelper.findChild(self.go, "root/go_normal/go_hp/go_hpitem")
	self._goselectmask = gohelper.findChild(self.go, "root/go_selectMask")
	self._goreducehp = gohelper.findChild(self.go, "root/go_reducehp")
	self._btnok = gohelper.findChildButtonWithAudio(self.go, "root/btn_ok")
end

function GuessGameNewPlayPlayerItem:_initItem()
	GuessGameNewPlayRoleItem._initItem(self)
	gohelper.setActive(self._btnok, false)

	local playerInfo = PlayerModel.instance:getPlayinfo()

	self._txtname.text = playerInfo.name

	if not self._liveHeadIcon then
		local commonLiveIcon = IconMgr.instance:getCommonLiveHeadIcon(self._simagehero)

		self._liveHeadIcon = commonLiveIcon
	end

	self._liveHeadIcon:setLiveHead(playerInfo.portrait)
end

function GuessGameNewPlayPlayerItem:refresh(roleType)
	GuessGameNewPlayRoleItem.refresh(self, roleType or GuessGameNewEnum.RoleType.Player)
	gohelper.setActive(self._btnok.gameObject, self._showOk)
end

function GuessGameNewPlayPlayerItem:_afterShowGifts()
	AudioMgr.instance:trigger(AudioEnum4_1.GuessGameNew.play_ui_beiai_kapai_turnover)

	for _, giftItem in pairs(self._giftItems) do
		giftItem:showOpen(true)
		giftItem:playAnim("flip_open")
	end
end

function GuessGameNewPlayPlayerItem:_onClickBtnOk()
	local roleMo = GuessGameNewModel.instance:getRoleData(GuessGameNewEnum.RoleType.Player)
	local selectGifts = roleMo.selectGifts

	if #selectGifts < 2 or #selectGifts > 5 then
		GameFacade.showToast(ToastEnum.GuessGameNewSelectCardNotInRange)

		return
	end

	gohelper.setActive(self._btnok.gameObject, false)
	GuessGameNewController.instance:dispatchEvent(GuessGameNewEvent.OnRoleSelectCardFinished)
end

function GuessGameNewPlayPlayerItem:_addEvents()
	self._btnok:AddClickListener(self._onClickBtnOk, self)
end

function GuessGameNewPlayPlayerItem:_removeEvents()
	self._btnok:RemoveClickListener()
end

function GuessGameNewPlayPlayerItem:show(show)
	gohelper.setActive(self.go, show)
end

function GuessGameNewPlayPlayerItem:showRoleSelect(show)
	if not self._giftItems then
		return
	end

	if show == nil then
		show = true
	end

	local roleMo = self._roleMo or GuessGameNewModel.instance:getRoleData(self:getRoleType())

	if not roleMo then
		return
	end

	for index, item in ipairs(self._giftItems) do
		local lastIn = LuaUtil.tableContains(self._selectGifts, index)
		local curIn = LuaUtil.tableContains(roleMo.selectGifts, index)

		if lastIn and not curIn then
			item:playAnim("open_selectout", 0, 0)
			item:showSelect(false)
		end

		if not lastIn and curIn then
			item:playAnim("open_selectin", 0, 0)
			AudioMgr.instance:trigger(AudioEnum4_1.GuessGameNew.play_ui_beiai_kapai_discard)
			item:showSelect(true)
		end
	end

	self._selectGifts = LuaUtil.deepCopy(roleMo.selectGifts)
end

function GuessGameNewPlayPlayerItem:refreshGiftsSelect(show)
	GuessGameNewPlayRoleItem.refreshGiftsSelect(self, show)

	self._selectGifts = {}
end

function GuessGameNewPlayPlayerItem:showMask(show)
	gohelper.setActive(self._godarkmask, show)
end

function GuessGameNewPlayPlayerItem:setRoleCardSelectCallback(callback, callbackobj)
	self._roleCardSelectCallback = callback
	self._roleCardSelectCallbackObj = callbackobj
	self._showOk = true

	GuessGameNewController.instance:dispatchEvent(GuessGameNewEvent.OnShowGuessAnnounceTips)

	if self._giftItems then
		for _, item in pairs(self._giftItems) do
			item:setClickCallback(self._roleCardSelectCallback, self._roleCardSelectCallbackObj)
		end
	end
end

function GuessGameNewPlayPlayerItem:clearRoleCardSelectCallback()
	self._roleCardSelectCallback = nil
	self._roleCardSelectCallbackObj = nil

	if self._giftItems then
		for _, item in pairs(self._giftItems) do
			item:clearClickCallback()
		end
	end
end

function GuessGameNewPlayPlayerItem:destroy()
	GuessGameNewPlayRoleItem.destroy(self)
	self._simagehero:UnLoadImage()
	self:clearRoleCardSelectCallback()
end

return GuessGameNewPlayPlayerItem
