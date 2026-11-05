-- chunkname: @modules/logic/necrologiststory/view/item/V4A1NecrologistStoryHeroItem.lua

module("modules.logic.necrologiststory.view.item.V4A1NecrologistStoryHeroItem", package.seeall)

local V4A1NecrologistStoryHeroItem = class("V4A1NecrologistStoryHeroItem", NecrologistStoryBaseItem)

function V4A1NecrologistStoryHeroItem:onInit()
	self.goCardFront = gohelper.findChild(self.viewGO, "root/#go_cardFront")
	self.simageCard = gohelper.findChildSingleImage(self.viewGO, "root/#go_cardFront/#simage_bg")
	self.txtName = gohelper.findChildTextMesh(self.viewGO, "root/#go_cardFront/#txt_desc")
	self.attrItems = {}

	for i = 1, 4 do
		self:createAttrItem(i)
	end

	self.goCardBack = gohelper.findChild(self.viewGO, "root/#go_cardBack")
	self.simageBg = gohelper.findChildSingleImage(self.viewGO, "root/#go_cardBack/#simage_bg")
	self.txtDesc = gohelper.findChildTextMesh(self.viewGO, "root/#go_cardBack/ScrollView/Viewport/Content/#txt_desc")
	self.btnClick = gohelper.findChildButtonWithAudio(self.viewGO, "root")
	self.anim = gohelper.findComponentAnim(self.viewGO)
end

function V4A1NecrologistStoryHeroItem:onAddEvent()
	self:addClickCb(self.btnClick, self.onClickBtn, self)
end

function V4A1NecrologistStoryHeroItem:onRemoveEvent()
	self:removeClickCb(self.btnClick)
end

function V4A1NecrologistStoryHeroItem:onClickBtn()
	self:changeCard(not self.isBack)
end

function V4A1NecrologistStoryHeroItem:onPlayStory(isSkip)
	if self:hasGuide() then
		isSkip = false

		local mo = NecrologistStoryModel.instance:getCurStoryMO()

		mo:setIsAuto(false)
	end

	self:refreshView()
	self:changeCard(self.isBack)
	self:onPlayFinish()
end

function V4A1NecrologistStoryHeroItem:changeCard(isBack)
	local showBack = isBack == true

	if showBack == self.isBack then
		return
	end

	self.isBack = showBack

	self.anim:Play(showBack and "back" or "front", 0, 0)
	AudioMgr.instance:trigger(AudioEnum.NecrologistStory.play_ui_wulu_aizila_forward_paper)
end

function V4A1NecrologistStoryHeroItem:refreshView()
	local storyConfig = self:getStoryConfig()
	local heroId = tonumber(storyConfig.param)
	local heroConfig = NecrologistStoryV4A1Config.instance:getRoleConfig(heroId)

	self:refreshFront(heroConfig)
	self:refreshBack(heroConfig)
end

function V4A1NecrologistStoryHeroItem:refreshFront(heroConfig)
	self:refreshAttrList(heroConfig.stats)

	self.txtName.text = heroConfig.name

	self.simageCard:LoadImage(string.format("singlebg/dungeon/rolestory_singlebg/3113/rolestory_3113_cardrole_%s.png", heroConfig.res))
end

function V4A1NecrologistStoryHeroItem:refreshBack(heroConfig)
	self.txtDesc.text = heroConfig.desc

	self.simageBg:LoadImage(string.format("singlebg/dungeon/rolestory_singlebg/3113/rolestory_3113_card_%s.png", heroConfig.res))
end

function V4A1NecrologistStoryHeroItem:refreshAttrList(stats)
	local attr = string.splitToNumber(stats, "|")

	for i, v in ipairs(self.attrItems) do
		self:refreshAttrItem(v, attr[i])
	end
end

function V4A1NecrologistStoryHeroItem:createAttrItem(index)
	local item = self:getUserDataTb_()

	item.index = index
	item.go = gohelper.findChild(self.viewGO, string.format("root/#go_cardFront/Attr/attr%d", index))
	item.txtName = gohelper.findChildTextMesh(item.go, "txt_name")
	item.txtValue = gohelper.findChildTextMesh(item.go, "#txt_num")
	self.attrItems[index] = item
end

function V4A1NecrologistStoryHeroItem:refreshAttrItem(item, value)
	item.txtName.text = luaLang(string.format("v4a1_rolestory_attrname_%d", item.index))
	item.txtValue.text = value or 0
end

function V4A1NecrologistStoryHeroItem:caleHeight()
	return 650
end

function V4A1NecrologistStoryHeroItem:isDone()
	return true
end

function V4A1NecrologistStoryHeroItem:hasGuide()
	return not GuideController.instance:isForbidGuides() and not GuideModel.instance:isGuideFinish(GuideEnum.GuideId.NecrologistStoryV4A1Hero)
end

function V4A1NecrologistStoryHeroItem:onDestroy()
	self.simageCard:UnLoadImage()
	self.simageBg:UnLoadImage()
end

function V4A1NecrologistStoryHeroItem.getResPath()
	return "ui/viewres/dungeon/rolestory/v4a1/v4a1_rolestoryrolecarditem.prefab"
end

return V4A1NecrologistStoryHeroItem
