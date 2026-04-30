-- chunkname: @modules/logic/versionactivity3_7/wmz/flow/WmzGameStartFlow.lua

local sf = string.format

module("modules.logic.versionactivity3_7.wmz.flow.WmzGameStartFlow", package.seeall)

local Base = WmzFlowSequence
local WmzGameStartFlow = class("WmzGameStartFlow", Base)

function WmzGameStartFlow:ctor(...)
	Base.ctor(self, ...)
end

function WmzGameStartFlow:onStart()
	self.viewObj:_clearCache()
	self.viewObj:_refreshMap()
	self.viewObj:_refreshItems()
	self.viewObj:setText_txtTarget(GameUtil.getSubPlaceholderLuaLang(luaLang("V3a7_Wmz_GameView_txtTarget"), {
		self.viewContainer:zoneClearCurAndMax()
	}))
end

return WmzGameStartFlow
