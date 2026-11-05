-- chunkname: @modules/logic/bossrush/view/v4a1/V4a1_BossRush_SkillBuffPhaseItem.lua

module("modules.logic.bossrush.view.v4a1.V4a1_BossRush_SkillBuffPhaseItem", package.seeall)

local V4a1_BossRush_SkillBuffPhaseItem = class("V4a1_BossRush_SkillBuffPhaseItem", ListScrollCellExtend)

function V4a1_BossRush_SkillBuffPhaseItem:onInitView()
	self._txttitle = gohelper.findChildText(self.viewGO, "#txt_title")
	self._gorank = gohelper.findChild(self.viewGO, "#txt_title/#go_rank")
	self._txtnum = gohelper.findChildText(self.viewGO, "#txt_title/#go_rank/#go_normal/#txt_num")
	self._imgnormal = gohelper.findChildImage(self.viewGO, "#txt_title/#go_rank/#go_normal")
	self._imgarrived = gohelper.findChildImage(self.viewGO, "#txt_title/#go_rank/#go_arrived")
	self._imgnow = gohelper.findChildImage(self.viewGO, "#txt_title/#go_rank/#go_now")
	self._goitem = gohelper.findChild(self.viewGO, "#go_item")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V4a1_BossRush_SkillBuffPhaseItem:addEvents()
	return
end

function V4a1_BossRush_SkillBuffPhaseItem:removeEvents()
	return
end

function V4a1_BossRush_SkillBuffPhaseItem:_editableInitView()
	gohelper.setActive(self._goitem, false)

	self._buffItems = self:getUserDataTb_()
end

function V4a1_BossRush_SkillBuffPhaseItem:_editableAddEvents()
	return
end

function V4a1_BossRush_SkillBuffPhaseItem:_editableRemoveEvents()
	return
end

function V4a1_BossRush_SkillBuffPhaseItem:onUpdateMO(index, list, score, arrivedPhase)
	local targetScore = list and list[1].score or 0
	local lang = luaLang("bossrush_danger_score_title")
	local scoreStr = targetScore

	if targetScore >= 10000 then
		scoreStr = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("v4a1_bossrush_danger_score"), targetScore / 10000)
	end

	self._txttitle.text = GameUtil.getSubPlaceholderLuaLangTwoParam(lang, "#C66030", scoreStr)

	local isNormal, isArraive, isNow

	if score and score > 0 then
		if arrivedPhase and arrivedPhase == index then
			isNow = true

			UISpriteSetMgr.instance:setV4a1BossRushSprite(self._imgnow, "v4a1_bossrush_score_light_lv_" .. index)
		else
			isArraive = targetScore <= score

			UISpriteSetMgr.instance:setV4a1BossRushSprite(self._imgarrived, "v4a1_bossrush_score_light_lv_" .. index)
		end
	else
		isNormal = true

		UISpriteSetMgr.instance:setV4a1BossRushSprite(self._imgnormal, "v4a1_bossrush_score_lv_" .. index)
	end

	gohelper.setActive(self._imgarrived.gameObject, isArraive)
	gohelper.setActive(self._imgnormal.gameObject, isNormal)
	gohelper.setActive(self._imgnow.gameObject, isNow)

	local count = 0

	if list then
		for i, v in ipairs(list) do
			if v.hidden ~= 1 then
				local item = self:_getBuffItem(i)

				item:onUpdateMO(v)
				item:refreshStatus(isArraive, isNormal, isNow)

				count = count + 1
			end
		end
	end

	for i, item in ipairs(self._buffItems) do
		gohelper.setActive(item.viewGO, i <= count)
	end
end

function V4a1_BossRush_SkillBuffPhaseItem:_getBuffItem(index)
	local item = self._buffItems[index]

	if not item then
		local go = gohelper.cloneInPlace(self._goitem.gameObject)

		item = MonoHelper.addLuaComOnceToGo(go, V4a1_BossRush_SkillBuffItem)
		self._buffItems[index] = item
	end

	return item
end

function V4a1_BossRush_SkillBuffPhaseItem:onDestroyView()
	return
end

return V4a1_BossRush_SkillBuffPhaseItem
