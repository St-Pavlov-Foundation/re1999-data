-- chunkname: @modules/logic/bossrush/view/v4a1/V4a1_BossRush_SkillBuffView.lua

module("modules.logic.bossrush.view.v4a1.V4a1_BossRush_SkillBuffView", package.seeall)

local V4a1_BossRush_SkillBuffView = class("V4a1_BossRush_SkillBuffView", BaseView)

function V4a1_BossRush_SkillBuffView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_close")
	self._txttitle = gohelper.findChildText(self.viewGO, "root/#txt_title")
	self._scrollBuff = gohelper.findChildScrollRect(self.viewGO, "root/#scroll_Buff")
	self._gobuff = gohelper.findChild(self.viewGO, "root/#scroll_Buff/Viewport/Content/#go_buff")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V4a1_BossRush_SkillBuffView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function V4a1_BossRush_SkillBuffView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function V4a1_BossRush_SkillBuffView:_btncloseOnClick()
	self:closeThis()
end

function V4a1_BossRush_SkillBuffView:_editableInitView()
	return
end

function V4a1_BossRush_SkillBuffView:onUpdateParam()
	return
end

function V4a1_BossRush_SkillBuffView:onOpen()
	self:_refreshBuff()
end

function V4a1_BossRush_SkillBuffView:_refreshBuff()
	local episodeId = self.viewParam.episodeId
	local score = self.viewParam.score
	local monsterId = self.viewParam.monsterId

	if not episodeId then
		return
	end

	if not self._skillBuffPanel then
		self._skillBuffPanel = MonoHelper.addLuaComOnceToGo(self._scrollBuff.content.gameObject, V4a1_BossRush_SkillBuffPanel)
	end

	self._skillBuffPanel:onUpdateMO(episodeId, score, monsterId)
end

function V4a1_BossRush_SkillBuffView:onClose()
	return
end

function V4a1_BossRush_SkillBuffView:onDestroyView()
	return
end

return V4a1_BossRush_SkillBuffView
