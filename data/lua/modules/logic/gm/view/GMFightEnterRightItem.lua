-- chunkname: @modules/logic/gm/view/GMFightEnterRightItem.lua

module("modules.logic.gm.view.GMFightEnterRightItem", package.seeall)

local GMFightEnterRightItem = class("GMFightEnterRightItem", ListScrollCell)
local SelectColor = Color.New(1, 0.8, 0.8, 1)
local NotSelectColor = Color.white

function GMFightEnterRightItem:init(go)
	self._btn = gohelper.findChildButtonWithAudio(go, "btn")

	self._btn:AddClickListener(self._onClickItem, self)

	self._imgBtn = gohelper.findChildImage(go, "btn")
	self._txtName = gohelper.findChildText(go, "btn/Text")
end

function GMFightEnterRightItem:onUpdateMO(mo)
	self._episodeCO = mo

	local actId = AbyssConfig.instance:getActIdByEpisodeId(self._episodeCO.id)

	logWarn(string.format("[GMFightEnter] episodeId:%s, chapterId:%s, actId:%s", tostring(self._episodeCO.id), tostring(self._episodeCO.chapterId), tostring(actId)))

	local versionStr = actId and ActivityHelper.getActivityVersion(actId) or ""

	if versionStr and versionStr ~= "" then
		self._txtName.text = "[" .. versionStr .. "] " .. self._episodeCO.name
	elseif actId then
		self._txtName.text = "[" .. actId .. "] " .. self._episodeCO.name
	else
		self._txtName.text = self._episodeCO.name
	end

	self._imgBtn.color = NotSelectColor
end

function GMFightEnterRightItem:_onClickItem()
	self._imgBtn.color = SelectColor

	self._view:closeThis()
	GMFightEnterHandler.enterFight(self._episodeCO.id)
end

function GMFightEnterRightItem:onDestroy()
	if self._btn then
		self._btn:RemoveClickListener()

		self._btn = nil
	end
end

return GMFightEnterRightItem
