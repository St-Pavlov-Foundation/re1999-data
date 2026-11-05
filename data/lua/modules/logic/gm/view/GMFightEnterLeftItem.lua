-- chunkname: @modules/logic/gm/view/GMFightEnterLeftItem.lua

module("modules.logic.gm.view.GMFightEnterLeftItem", package.seeall)

local GMFightEnterLeftItem = class("GMFightEnterLeftItem", ListScrollCell)
local SelectColor = Color.New(1, 0.8, 0.8, 1)
local NotSelectColor = Color.white
local PrevSelectType

function GMFightEnterLeftItem:init(go)
	self._btn = gohelper.findChildButtonWithAudio(go, "btn")

	self._btn:AddClickListener(self._onClickItem, self)

	self._imgBtn = gohelper.findChildImage(go, "btn")
	self._txtName = gohelper.findChildText(go, "btn/Text")
end

function GMFightEnterLeftItem:onUpdateMO(mo)
	self._mo = mo

	local episodeType = mo.type
	local typeName = self:_getEpisodeTypeName(episodeType)

	self._txtName.text = typeName
	self._imgBtn.color = episodeType == PrevSelectType and SelectColor or NotSelectColor

	if PrevSelectType then
		if episodeType == PrevSelectType then
			GMFightEnterFightModel.instance:setEpisodeType(episodeType)
		end
	elseif self._index == 1 then
		PrevSelectType = episodeType

		GMFightEnterFightModel.instance:setEpisodeType(episodeType)
	end
end

function GMFightEnterLeftItem:_getEpisodeTypeName(episodeType)
	for name, value in pairs(DungeonEnum.EpisodeType) do
		if value == episodeType then
			return name .. "(" .. episodeType .. ")"
		end
	end

	return tostring(episodeType)
end

function GMFightEnterLeftItem:_onClickItem()
	PrevSelectType = self._mo.type
	self._imgBtn.color = SelectColor

	GMFightEnterFightModel.instance:setEpisodeType(self._mo.type)
end

function GMFightEnterLeftItem:onSelect(isSelect)
	self._imgBtn.color = self._mo.type == PrevSelectType and SelectColor or NotSelectColor
end

function GMFightEnterLeftItem:onDestroy()
	if self._btn then
		self._btn:RemoveClickListener()

		self._btn = nil
	end
end

return GMFightEnterLeftItem
