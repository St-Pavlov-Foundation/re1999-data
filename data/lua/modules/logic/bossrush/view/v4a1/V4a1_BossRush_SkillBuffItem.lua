-- chunkname: @modules/logic/bossrush/view/v4a1/V4a1_BossRush_SkillBuffItem.lua

module("modules.logic.bossrush.view.v4a1.V4a1_BossRush_SkillBuffItem", package.seeall)

local V4a1_BossRush_SkillBuffItem = class("V4a1_BossRush_SkillBuffItem", ListScrollCellExtend)

function V4a1_BossRush_SkillBuffItem:onInitView()
	self._imagenormalbg = gohelper.findChildImage(self.viewGO, "#image_normalbg")
	self._imageactivedbg = gohelper.findChildImage(self.viewGO, "#image_activedbg")
	self._imagenotactivedbg = gohelper.findChildImage(self.viewGO, "#image_notactivedbg")
	self._txtbuff = gohelper.findChildText(self.viewGO, "#txt_buff")
	self._imageicon = gohelper.findChildImage(self.viewGO, "#txt_buff/#image_icon")
	self._imageline = gohelper.findChildImage(self.viewGO, "#txt_buff/#image_line")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V4a1_BossRush_SkillBuffItem:addEvents()
	return
end

function V4a1_BossRush_SkillBuffItem:removeEvents()
	return
end

function V4a1_BossRush_SkillBuffItem:_editableInitView()
	self:refreshStatus(false, true)
end

function V4a1_BossRush_SkillBuffItem:_editableAddEvents()
	return
end

function V4a1_BossRush_SkillBuffItem:_editableRemoveEvents()
	return
end

function V4a1_BossRush_SkillBuffItem:onUpdateMO(mo)
	self._mo = mo
	self._txtbuff.text = mo.spDesc

	if not string.nilorempty(mo.icon) then
		UISpriteSetMgr.instance:setV4a1BossRushSprite(self._imageicon, mo.icon)
	end
end

function V4a1_BossRush_SkillBuffItem:refreshStatus(isArraive, isNormal, isNow)
	if isNow then
		isArraive = true
	end

	gohelper.setActive(self._imagenormalbg.gameObject, isNormal)
	gohelper.setActive(self._imageactivedbg.gameObject, isArraive)
	gohelper.setActive(self._imagenotactivedbg.gameObject, not isNormal and not isArraive)
end

function V4a1_BossRush_SkillBuffItem:onDestroyView()
	return
end

return V4a1_BossRush_SkillBuffItem
