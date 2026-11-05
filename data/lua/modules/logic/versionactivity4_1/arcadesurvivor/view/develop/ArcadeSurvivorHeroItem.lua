-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/view/develop/ArcadeSurvivorHeroItem.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.view.develop.ArcadeSurvivorHeroItem", package.seeall)

local ArcadeSurvivorHeroItem = class("ArcadeSurvivorHeroItem", ListScrollCellExtend)

function ArcadeSurvivorHeroItem:onInitView()
	self._gounlock = gohelper.findChild(self.viewGO, "unlock")
	self._simagehero = gohelper.findChildSingleImage(self.viewGO, "unlock/#simage_hero")
	self._imagehero = gohelper.findChildImage(self.viewGO, "unlock/#simage_hero")
	self._gonew = gohelper.findChild(self.viewGO, "#go_reddot")
	self._goequiped = gohelper.findChild(self.viewGO, "unlock/go_equiped")
	self._gohp = gohelper.findChild(self.viewGO, "unlock/go_hp")
	self._golock = gohelper.findChild(self.viewGO, "lock")
	self._simagelockhero = gohelper.findChildSingleImage(self.viewGO, "lock/#simage_hero")
	self._goselect = gohelper.findChild(self.viewGO, "go_select")
	self._btnclick = ArcadeSurvivorGameHelper.getArcadeSurvivorButton(self.viewGO, "btn_click")
	self._gohp = gohelper.findChild(self.viewGO, "unlock/go_hp")
	self._gobg = gohelper.findChild(self.viewGO, "bg")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ArcadeSurvivorHeroItem:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function ArcadeSurvivorHeroItem:removeEvents()
	self._btnclick:RemoveClickListener()
end

function ArcadeSurvivorHeroItem:_btnclickOnClick()
	local showId = ArcadeSurvivorHeroModel.instance:getSelectHeroId()
	local id = self._mo:getId()

	if showId == id then
		return
	end

	ArcadeSurvivorHeroModel.instance:setSelectHeroId(id)
	ArcadeSurvivorHeroModel.instance:markHeroRead(id)
	ArcadeSurvivorController.instance:dispatchEvent(ArcadeSurvivorEvent.OnClickHeroItem, id)
end

function ArcadeSurvivorHeroItem:_editableInitView()
	gohelper.setActive(self._gohp, false)

	self._anim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function ArcadeSurvivorHeroItem:_editableAddEvents()
	self:addEventCb(ArcadeSurvivorController.instance, ArcadeSurvivorEvent.onFinishPlayOpenAnimHeroView, self._checkUnlockAnim, self)
end

function ArcadeSurvivorHeroItem:_editableRemoveEvents()
	self:removeEventCb(ArcadeSurvivorController.instance, ArcadeSurvivorEvent.onFinishPlayOpenAnimHeroView, self._checkUnlockAnim, self)
end

function ArcadeSurvivorHeroItem:onUpdateMO(mo)
	self._mo = mo

	self:refreshView()
end

function ArcadeSurvivorHeroItem:refreshView()
	self:_refreshStatus()
end

function ArcadeSurvivorHeroItem:_checkUnlockAnim()
	local isLock = self._mo:isLock()
	local prefsKey, key = self._mo:getPlayUnlockAnimKey()
	local value = ArcadeSurvivorOutSideModel.instance:getPlayerPrefsValue(prefsKey, key, 0, true)

	if isLock then
		gohelper.setActive(self._golock, true)
		gohelper.setActive(self._gounlock, false)
		gohelper.setActive(self._gobg, false)
	elseif value == 0 then
		self._anim:Play("unlock", 0, 0)
		ArcadeSurvivorOutSideModel.instance:setPlayerPrefsValue(prefsKey, key, 1, true)
	end
end

function ArcadeSurvivorHeroItem:_refreshStatus()
	local isLock = self._mo:isLock()
	local isSelect = self._mo:isSelect()
	local isNew = not isLock and self._mo:isNew()
	local isEquip = self._mo:isEquip()

	gohelper.setActive(self._golock, isLock)
	gohelper.setActive(self._gounlock, not isLock)
	gohelper.setActive(self._goselect, isSelect)
	gohelper.setActive(self._goequiped, isEquip)
	gohelper.setActive(self._gonew, isNew)
	gohelper.setActive(self._gobg, not isLock)

	local icon = self._mo.handbookMO:getIcon()

	if not string.nilorempty(icon) then
		self._simagehero:LoadImage(ResUrl.getArcadeSurvivorIcon(icon))
		self._simagelockhero:LoadImage(ResUrl.getArcadeSurvivorIcon(icon))
	end

	if not isLock then
		local color = isSelect and Color.white or GameUtil.parseColor("#808080")

		self._imagehero.color = color
	end
end

function ArcadeSurvivorHeroItem:onDestroyView()
	self._simagehero:UnLoadImage()
	self._simagelockhero:UnLoadImage()
end

return ArcadeSurvivorHeroItem
