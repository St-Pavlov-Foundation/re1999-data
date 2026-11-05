-- chunkname: @modules/logic/versionactivity4_1/guessgamenew/view/GuessGameNewPlayNpcItem.lua

module("modules.logic.versionactivity4_1.guessgamenew.view.GuessGameNewPlayNpcItem", package.seeall)

local GuessGameNewPlayNpcItem = class("GuessGameNewPlayNpcItem", GuessGameNewPlayRoleItem)

function GuessGameNewPlayNpcItem:_findNodes()
	GuessGameNewPlayRoleItem._findNodes(self)

	self._goselect = gohelper.findChild(self.go, "root/go_selectMask")
	self._gonormal = gohelper.findChild(self.go, "root/go_normal")
	self._imagechess = gohelper.findChildImage(self.go, "root/go_normal/image_chess")
	self._txtname = gohelper.findChildText(self.go, "root/go_normal/namebg/txt_name")
	self._goselecttip = gohelper.findChild(self.go, "root/go_select")
	self._godead = gohelper.findChild(self.go, "root/go_dead")
	self._gohp = gohelper.findChild(self.go, "root/go_hp")
	self._gohpitem = gohelper.findChild(self.go, "root/go_hp/go_hpitem")
	self._gotalk = gohelper.findChild(self.go, "root/go_talk")
	self._txttalk = gohelper.findChildText(self.go, "root/go_talk/bg/#txt_desc")
	self._goreducehp = gohelper.findChild(self.go, "root/go_reducehp")
	self._btnclick = gohelper.findChildButtonWithAudio(self.go, "root/btn_click")
end

function GuessGameNewPlayNpcItem:_initItem()
	GuessGameNewPlayRoleItem._initItem(self)

	self._anim = self.go:GetComponent(typeof(UnityEngine.Animator))
	self._talkAnim = self._gotalk:GetComponent(typeof(UnityEngine.Animator))
	self._reduceHpAnim = self._goreducehp:GetComponent(typeof(UnityEngine.Animator))

	gohelper.setActive(self._gotalk, false)
	gohelper.setActive(self._goreducehp, false)
	gohelper.setActive(self._godead, false)
end

function GuessGameNewPlayNpcItem:_refreshRoleInfo()
	if self._roleMo and self._roleMo.npcConfig then
		self._txtname.text = self._roleMo.npcConfig.name

		UISpriteSetMgr.instance:setV3a7Activity3ndSprite(self._imagechess, self._roleMo.npcConfig.icon)
	end
end

function GuessGameNewPlayNpcItem:showGifts(show)
	GuessGameNewPlayRoleItem.showGifts(self, show, 0.3)
end

function GuessGameNewPlayNpcItem:showRoleReduceHp()
	if self._roleMo.hp > 0 then
		AudioMgr.instance:trigger(AudioEnum4_1.GuessGameNew.play_ui_beiai_kapai_loseblood)
		gohelper.setActive(self._goreducehp, true)
		gohelper.setActive(self._godead, false)
	else
		gohelper.setActive(self._goreducehp, false)
		gohelper.setActive(self._godead, true)
		self._anim:Play("dead", 0, 0)
	end
end

function GuessGameNewPlayNpcItem:showRoleDistributeTalk()
	local bluffs = string.split(self._roleMo.npcConfig.bluffdia or "", "#")

	self._txttalk.text = bluffs and bluffs[1] or ""

	gohelper.setActive(self._gotalk, true)
	self._talkAnim:Play("open", 0, 0)

	local showTime = bluffs and bluffs[2] and tonumber(bluffs[2]) or 2

	TaskDispatcher.runDelay(self._onTalkFinished, self, showTime)
end

function GuessGameNewPlayNpcItem:_onTalkFinished()
	self._talkAnim:Play("close", 0, 0)
end

function GuessGameNewPlayNpcItem:showRoleResultTalk(right)
	local txt = right and self._roleMo.npcConfig.rightdia or self._roleMo.npcConfig.wrongdia
	local txts = string.split(txt or "", "#")

	self._txttalk.text = txts and txts[1] or ""

	gohelper.setActive(self._gotalk, true)
	self._talkAnim:Play("open", 0, 0)

	local showTime = txts and txts[2] and tonumber(txts[2]) or 2

	TaskDispatcher.runDelay(self._onTalkFinished, self, showTime)
end

function GuessGameNewPlayNpcItem:_btnclickOnClick()
	return
end

function GuessGameNewPlayNpcItem:_addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function GuessGameNewPlayNpcItem:_removeEvents()
	self._btnclick:RemoveClickListener()
end

function GuessGameNewPlayNpcItem:showRoleSelect(show)
	if self._roleMo.hp <= 0 then
		gohelper.setActive(self._godead, true)
		self._anim:Play("dead", 0, 1)

		return
	end

	local animName = show and "select" or "normal"

	self._anim:Play(animName, 0, 0)

	if not show then
		return
	end

	AudioMgr.instance:trigger(AudioEnum4_1.GuessGameNew.play_ui_beiai_kapai_choose)
	self:refreshGiftsSelect(true)
end

function GuessGameNewPlayNpcItem:destroy()
	GuessGameNewPlayRoleItem.destroy(self)
	TaskDispatcher.cancelTask(self._onTalkFinished, self)
end

return GuessGameNewPlayNpcItem
