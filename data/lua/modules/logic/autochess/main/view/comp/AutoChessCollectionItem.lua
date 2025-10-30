﻿-- chunkname: @modules/logic/autochess/main/view/comp/AutoChessCollectionItem.lua

module("modules.logic.autochess.main.view.comp.AutoChessCollectionItem", package.seeall)

local AutoChessCollectionItem = class("AutoChessCollectionItem", LuaCompBase)

function AutoChessCollectionItem:init(go)
	self.go = go
	self.simageBg = gohelper.findChildSingleImage(go, "#simage_Bg")
	self.simageCollection = gohelper.findChildSingleImage(go, "#simage_Collection")
	self.txtName = gohelper.findChildText(go, "namebg/#txt_Name")
	self.txtDesc = gohelper.findChildText(go, "scroll_desc/viewport/content/#txt_Desc")
	self.goNew = gohelper.findChild(go, "#go_New")
	self.goLock = gohelper.findChild(go, "#go_Lock")
	self.txtLock = gohelper.findChildText(go, "#go_Lock/#txt_Lock")
end

function AutoChessCollectionItem:setData(collectionId)
	self.config = AutoChessConfig.instance:getCollectionCfg(collectionId)
	self.txtName.text = self.config.name
	self.txtDesc.text = self.config.skilldesc

	local icon = "movingchess_handbook_panelbg_" .. self.config.quality

	self.simageBg:LoadImage(ResUrl.getMovingChessIcon(icon, "handbook"))

	if self.config.isSp then
		local unlockLvl = AutoChessConfig.instance:getCollectionUnlockLevel(self.config.id)
		local actMo = Activity182Model.instance:getActMo()

		self.isLock = unlockLvl > actMo.warnLevel
		self.txtLock.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("autochess_warnlevel_unlock"), unlockLvl)

		gohelper.setActive(self.goLock, self.isLock)
	end

	self.simageCollection:LoadImage(ResUrl.getAutoChessIcon(self.config.image, "collection"))
end

function AutoChessCollectionItem:refreshNewTag()
	local isNew = false

	if not self.isLock then
		isNew = AutoChessHelper.getUnlockReddot(AutoChessStrEnum.ClientReddotKey.SpecialCollection, self.config.id)
	end

	gohelper.setActive(self.goNew, isNew)
end

return AutoChessCollectionItem
