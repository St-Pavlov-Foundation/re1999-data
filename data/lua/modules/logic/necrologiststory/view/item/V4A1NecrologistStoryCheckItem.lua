-- chunkname: @modules/logic/necrologiststory/view/item/V4A1NecrologistStoryCheckItem.lua

module("modules.logic.necrologiststory.view.item.V4A1NecrologistStoryCheckItem", package.seeall)

local V4A1NecrologistStoryCheckItem = class("V4A1NecrologistStoryCheckItem", NecrologistStoryBaseItem)

function V4A1NecrologistStoryCheckItem:onInit()
	self.goRoot = gohelper.findChild(self.viewGO, "root")
	self.txtDesc = gohelper.findChildTextMesh(self.viewGO, "root/descer/txtDescer")
	self.goTraget = gohelper.findChild(self.viewGO, "root/content/target")
	self.goTxtTarget = gohelper.findChild(self.viewGO, "root/content/target/txt_target")
	self.txtNum1 = gohelper.findChildTextMesh(self.viewGO, "root/content/target/txt_num1")
	self.txtFuhao = gohelper.findChildTextMesh(self.viewGO, "root/content/target/fuhao")
	self.txtNum2 = gohelper.findChildTextMesh(self.viewGO, "root/content/target/txt_num2")
	self.goTouzi = gohelper.findChild(self.viewGO, "root/content/target/icon")
	self.goTargetResult = gohelper.findChild(self.viewGO, "root/content/target/result")
	self.goTargetFail = gohelper.findChild(self.viewGO, "root/content/target/result/fail")
	self.goTargetSuccess = gohelper.findChild(self.viewGO, "root/content/target/result/success")
	self.goHeroItem = gohelper.findChild(self.viewGO, "root/content/hero/go_heroitem")

	gohelper.setActive(self.goHeroItem, false)

	self.heroList = {}
	self.goResult = gohelper.findChild(self.viewGO, "root/result")
	self.txtSuccess = gohelper.findChildTextMesh(self.viewGO, "root/result/content/#txt_success")
	self.txtFail = gohelper.findChildTextMesh(self.viewGO, "root/result/content/#txt_fail")
	self.simage = gohelper.findChildSingleImage(self.viewGO, "root/content/icon")
end

function V4A1NecrologistStoryCheckItem:onAddEvent()
	return
end

function V4A1NecrologistStoryCheckItem:onRemoveEvent()
	return
end

function V4A1NecrologistStoryCheckItem:_onCloseViewFinish(viewName)
	if viewName == ViewName.V4A1_RoleStoryCheckView then
		self:onCheckFinish()
	end
end

function V4A1NecrologistStoryCheckItem:onClickHeroItem(item)
	if self.selectHeroId ~= nil then
		return
	end

	if not item.config then
		return
	end

	self.selectHeroId = item.config.id

	gohelper.setActive(item.goSelect, true)
	gohelper.setActive(item.goSelect1, true)
	self:startCheck()
end

function V4A1NecrologistStoryCheckItem:onPlayStory(isSkip)
	local storyConfig = self:getStoryConfig()
	local params = string.splitToNumber(storyConfig.param, "#")

	self.checkId = params[1]
	self.successSection = params[2]
	self.failSection = params[3]
	self.checkConfig = NecrologistStoryV4A1Config.instance:getCheckConfig(self.checkId)
	self.checkGroup = self.checkConfig.group

	self:refreshView()
end

function V4A1NecrologistStoryCheckItem:refreshView()
	self.txtDesc.text = luaLang(string.format("v4a1_rolestory_attrname3_%d", self.checkGroup))

	self.simage:LoadImage(string.format("singlebg/dungeon/rolestory_singlebg/storypic/%s.png", self.checkConfig.itemName))
	self:refreshHeroList()
	self:refreshTarget()
	self:refreshResult()
end

function V4A1NecrologistStoryCheckItem:refreshHeroList()
	local heroList = NecrologistStoryV4A1Config.instance:getRoleList()

	for i = 1, math.max(#heroList, #self.heroList) do
		local config = heroList[i]
		local item = self:getHeroItem(i)

		if item then
			self:refreshHeroItem(item, config)
		end
	end
end

function V4A1NecrologistStoryCheckItem:getHeroItem(index)
	local item = self.heroList[index]

	if not item then
		item = self:getUserDataTb_()
		item.go = gohelper.cloneInPlace(self.goHeroItem, tostring(index))
		item.txtAddNum = gohelper.findChildTextMesh(item.go, "numbg/txt_num")
		item.simageHero = gohelper.findChildSingleImage(item.go, "simage_hero")
		item.txtName = gohelper.findChildTextMesh(item.go, "attr/txt_name")
		item.txtNum = gohelper.findChildTextMesh(item.go, "attr/#txt_num")
		item.goSelect = gohelper.findChild(item.go, "go_select")
		item.goSelect1 = gohelper.findChild(item.go, "go_select1")
		item.btnClick = gohelper.findChildButtonWithAudio(item.go, "btn_click")

		self:addClickCb(item.btnClick, self.onClickHeroItem, self, item)

		self.heroList[index] = item
	end

	return item
end

function V4A1NecrologistStoryCheckItem:refreshHeroItem(item, config)
	item.config = config

	gohelper.setActive(item.go, config ~= nil)

	if not config then
		return
	end

	local attrs = string.splitToNumber(config.stats, "|")
	local attrVal = attrs[self.checkGroup] or 0

	item.txtAddNum.text = string.format("%+d", self:getCheckAddValue(attrVal))
	item.txtName.text = luaLang(string.format("v4a1_rolestory_attrname2_%d", self.checkGroup))
	item.txtNum.text = attrVal

	if self.checkConfig.hide2 == 1 then
		item.simageHero:LoadImage(string.format("singlebg/dungeon/rolestory_singlebg/3113/rolestory_3113_card_smallblack_%s.png", config.res))
	else
		item.simageHero:LoadImage(string.format("singlebg/dungeon/rolestory_singlebg/3113/rolestory_3113_cardrolesmall_%s.png", config.res))
	end

	gohelper.setActive(item.goSelect, self.selectHeroId == config.id)
	gohelper.setActive(item.goSelect1, self.selectHeroId == config.id)
end

function V4A1NecrologistStoryCheckItem:refreshTarget()
	local hasSelect = self.selectHeroId ~= nil

	if hasSelect then
		gohelper.setActive(self.goTxtTarget, false)
		gohelper.setActive(self.txtNum1, true)
		gohelper.setActive(self.txtFuhao, true)
		gohelper.setActive(self.goTouzi, true)
		gohelper.setActive(self.txtNum2, true)
		gohelper.setActive(self.goTargetResult, true)

		local isSuccess = self:isCheckSuccess()

		gohelper.setActive(self.goTargetSuccess, isSuccess)
		gohelper.setActive(self.goTargetFail, not isSuccess)

		self.txtFuhao.text = isSuccess and "≤" or ">"
		self.txtNum1.text = self.checkConfig.hide1 == 0 and self.checkConfig.type or "???"
		self.txtNum2.text = string.format("%+d", self:getSelectAddValue())
	else
		gohelper.setActive(self.goTxtTarget, true)
		gohelper.setActive(self.txtNum1, true)
		gohelper.setActive(self.txtFuhao, false)
		gohelper.setActive(self.goTouzi, true)
		gohelper.setActive(self.txtNum2, false)
		gohelper.setActive(self.goTargetResult, false)

		local targetVal = self.checkConfig.hide1 == 0 and self.checkConfig.type or "???"

		self.txtNum1.text = string.format("<color=#8F6411>%s</color>", targetVal)
	end
end

function V4A1NecrologistStoryCheckItem:refreshResult()
	if not self:isDone() then
		gohelper.setActive(self.goResult, false)

		return
	end

	gohelper.setActive(self.goResult, true)

	local isCheckSuccess = self:isCheckSuccess()

	gohelper.setActive(self.txtSuccess, isCheckSuccess)
	gohelper.setActive(self.txtFail, not isCheckSuccess)

	local addVal = self:getSelectAddValue()
	local resultVal = self.resultVal
	local checkVal = self.checkConfig.hide1 == 0 and self.checkConfig.type or "???"
	local txt = string.format("%s%s%s（%s%+d）", checkVal, isCheckSuccess and "≤" or ">", resultVal + addVal, resultVal, addVal)
	local mo = NecrologistStoryModel.instance:getGameMO(NecrologistStoryEnum.RoleStoryId.V4A1)

	mo:setCheckSuccess(self.checkId, isCheckSuccess)

	if isCheckSuccess then
		self.txtSuccess.text = txt
	else
		self.txtFail.text = txt
	end
end

function V4A1NecrologistStoryCheckItem:getCheckAddValue(attrVal)
	attrVal = attrVal or 0

	local addVal = math.modf((attrVal - 10) * 0.5)

	return addVal
end

function V4A1NecrologistStoryCheckItem:getSelectAddValue()
	local heroConfig = NecrologistStoryV4A1Config.instance:getRoleConfig(self.selectHeroId)
	local attrs = string.splitToNumber(heroConfig.stats, "|")
	local attrVal = attrs[self.checkGroup] or 0
	local addVal = self:getCheckAddValue(attrVal)

	return addVal
end

function V4A1NecrologistStoryCheckItem:isCheckSuccess()
	local addVal = self:getSelectAddValue()
	local resultVal = self.resultVal
	local checkVal = self.checkConfig.type

	return checkVal <= resultVal + addVal
end

function V4A1NecrologistStoryCheckItem:startCheck()
	local startVal = self.checkConfig.type == 0 and 3 or 1
	local endVal = 20
	local randomVal = math.random(startVal, endVal)

	self.resultVal = randomVal

	self:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	ViewMgr.instance:openView(ViewName.V4A1_RoleStoryCheckView, {
		randomVal = randomVal,
		addVal = self:getSelectAddValue(),
		isSuccess = self:isCheckSuccess()
	})
end

function V4A1NecrologistStoryCheckItem:onCheckFinish()
	self:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	self:refreshView()
	self:refreshHeight()

	local isSuccess = self:isCheckSuccess()
	local sectionId = isSuccess and self.successSection or self.failSection

	NecrologistStoryController.instance:dispatchEvent(NecrologistStoryEvent.OnSelectSection, sectionId, nil, 0)
end

function V4A1NecrologistStoryCheckItem:caleHeight()
	return self:isDone() and 766 or 666
end

function V4A1NecrologistStoryCheckItem:isDone()
	return self.resultVal ~= nil
end

function V4A1NecrologistStoryCheckItem:onDestroy()
	for _, item in ipairs(self.heroList) do
		item.simageHero:UnLoadImage()
		self:removeClickCb(item.btnClick)
	end

	self.simage:UnLoadImage()
end

function V4A1NecrologistStoryCheckItem.getResPath()
	return "ui/viewres/dungeon/rolestory/v4a1/v4a1_rolestorycheckitem.prefab"
end

return V4A1NecrologistStoryCheckItem
