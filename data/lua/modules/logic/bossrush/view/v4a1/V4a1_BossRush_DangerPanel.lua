-- chunkname: @modules/logic/bossrush/view/v4a1/V4a1_BossRush_DangerPanel.lua

module("modules.logic.bossrush.view.v4a1.V4a1_BossRush_DangerPanel", package.seeall)

local V4a1_BossRush_DangerPanel = class("V4a1_BossRush_DangerPanel", ListScrollCellExtend)

function V4a1_BossRush_DangerPanel:onInitView()
	self._btninfo = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_info")
	self._gotitle = gohelper.findChild(self.viewGO, "title")
	self._godanger = gohelper.findChild(self.viewGO, "#go_danger")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V4a1_BossRush_DangerPanel:addEvents()
	if self._btninfo then
		self._btninfo:AddClickListener(self._btninfoOnClick, self)
	end
end

function V4a1_BossRush_DangerPanel:removeEvents()
	if self._btninfo then
		self._btninfo:RemoveClickListener()
	end
end

function V4a1_BossRush_DangerPanel:_btninfoOnClick()
	V4a1_BossRushController.instance:openSkillBuffView(self._score, self._episodeId, self._monsterId)
end

function V4a1_BossRush_DangerPanel:_editableInitView()
	return
end

function V4a1_BossRush_DangerPanel:_editableAddEvents()
	return
end

function V4a1_BossRush_DangerPanel:_editableRemoveEvents()
	return
end

function V4a1_BossRush_DangerPanel:onUpdateMO(score, episodeId, monsterId, isPlayAni, isHideTitle)
	self._score = score
	self._episodeId = episodeId
	self._monsterId = monsterId

	gohelper.setActive(self._gotitle, not isHideTitle)

	if self._dangerItem then
		return self._dangerItem:onUpdateMO(score, episodeId, monsterId, isPlayAni)
	end
end

function V4a1_BossRush_DangerPanel:onPlayAnim()
	if self._dangerItem then
		self._dangerItem:onPlayAnim()
	end
end

function V4a1_BossRush_DangerPanel:setViewContainer(viewContainer)
	self.viewContainer = viewContainer

	if not self._dangerItem then
		local go = viewContainer:getResInst(BossRushEnum.ResPath.v4a1_bossrush_danger, self._godanger)

		self._dangerItem = MonoHelper.addLuaComOnceToGo(go, V4a1_BossRush_DangerItem)
	end
end

function V4a1_BossRush_DangerPanel:onDestroyView()
	return
end

return V4a1_BossRush_DangerPanel
