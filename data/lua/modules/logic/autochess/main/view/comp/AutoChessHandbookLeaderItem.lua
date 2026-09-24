-- chunkname: @modules/logic/autochess/main/view/comp/AutoChessHandbookLeaderItem.lua

module("modules.logic.autochess.main.view.comp.AutoChessHandbookLeaderItem", package.seeall)

local AutoChessHandbookLeaderItem = class("AutoChessHandbookLeaderItem", ListScrollCell)

function AutoChessHandbookLeaderItem:init(go)
	self.go = go
	self.leaderCard = MonoHelper.addNoUpdateLuaComOnceToGo(go, AutoChessLeaderCard)
end

function AutoChessHandbookLeaderItem:onUpdateMO(mo)
	self.leaderCard:setData(mo)
end

return AutoChessHandbookLeaderItem
