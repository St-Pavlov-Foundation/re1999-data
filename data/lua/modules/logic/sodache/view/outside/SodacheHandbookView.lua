-- chunkname: @modules/logic/sodache/view/outside/SodacheHandbookView.lua

module("modules.logic.sodache.view.outside.SodacheHandbookView", package.seeall)

local SodacheHandbookView = class("SodacheHandbookView", BaseView)

function SodacheHandbookView:onInitView()
	self._btnCardTab = gohelper.findChildButtonWithAudio(self.viewGO, "Tab/Card/#btn_CardTab")
	self._btnMonsterTab = gohelper.findChildButtonWithAudio(self.viewGO, "Tab/Monster/#btn_MonsterTab")
	self._scrollCard = gohelper.findChildScrollRect(self.viewGO, "#scroll_Card")
	self._goCardInfo = gohelper.findChild(self.viewGO, "Right/#go_CardInfo")
	self._goMonsterInfo = gohelper.findChild(self.viewGO, "Right/#go_MonsterInfo")
	self._goEmpty = gohelper.findChild(self.viewGO, "Right/#go_Empty")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SodacheHandbookView:addEvents()
	self._btnCardTab:AddClickListener(self._btnCardTabOnClick, self)
	self._btnMonsterTab:AddClickListener(self._btnMonsterTabOnClick, self)
end

function SodacheHandbookView:removeEvents()
	self._btnCardTab:RemoveClickListener()
	self._btnMonsterTab:RemoveClickListener()
end

local switchEvt = "switch content"
local freshEvt = "refresh content"

function SodacheHandbookView:_btnCardTabOnClick()
	if self.type == SodacheEnum.HandBookType.Card then
		return
	end

	self.type = SodacheEnum.HandBookType.Card

	self.animCard:Play("select", 0, 0)
	self.animMonster:Play("unselect", 0, 0)
	self.animScroll:Play("refresh", 0, 0)
end

function SodacheHandbookView:_btnMonsterTabOnClick()
	if self.type == SodacheEnum.HandBookType.Monster then
		return
	end

	self.type = SodacheEnum.HandBookType.Monster

	self.animCard:Play("unselect", 0, 0)
	self.animMonster:Play("select", 0, 0)
	self.animScroll:Play("refresh", 0, 0)
end

function SodacheHandbookView:_editableInitView()
	self.cardInfo = MonoHelper.addNoUpdateLuaComOnceToGo(self._goCardInfo, SodacheCardInfoRight)
	self.goNormal = gohelper.findChild(self._goMonsterInfo, "Monster/go_Normal")
	self.goBoss = gohelper.findChild(self._goMonsterInfo, "Monster/go_Boss")
	self.simageMonster = gohelper.findChildSingleImage(self._goMonsterInfo, "Monster/simage_Monster")
	self.imageCareer = gohelper.findChildImage(self._goMonsterInfo, "Monster/image_Career")
	self.txtDesc1 = gohelper.findChildText(self._goMonsterInfo, "scroll_Desc/Viewport/Content/txt_Desc1")
	self.txtDesc2 = gohelper.findChildText(self._goMonsterInfo, "scroll_Desc/Viewport/Content/txt_Desc2")
	self.animCard = gohelper.findChildAnim(self.viewGO, "Tab/Card")
	self.animMonster = gohelper.findChildAnim(self.viewGO, "Tab/Monster")
	self.animScroll = gohelper.findChildAnim(self.viewGO, "#scroll_Card")
	self.animScrollEvent = self.animScroll.gameObject:GetComponent(gohelper.Type_AnimationEventWrap)

	self.animScrollEvent:AddEventListener(switchEvt, self._onSwitchEnd, self)

	self.animRight = gohelper.findChildAnim(self.viewGO, "Right")
	self.animRightEvent = self.animRight.gameObject:GetComponent(gohelper.Type_AnimationEventWrap)

	self.animRightEvent:AddEventListener(freshEvt, self._onFreshEnd, self)
end

function SodacheHandbookView:onOpen()
	self:addEventCb(SodacheController.instance, SodacheEvent.OnClickHandbookItem, self.onClickItem, self)
	self:_btnCardTabOnClick()
end

function SodacheHandbookView:onDestroyView()
	self.animScrollEvent:RemoveEventListener(switchEvt)
	self.animRightEvent:RemoveEventListener(freshEvt)
	TaskDispatcher.cancelTask(self.delaySelect, self)
end

function SodacheHandbookView:delaySelect()
	local handbookId = SodacheHandbookListModel.instance:getTypeFirstHnadbookId(self.type)

	self:onClickItem(handbookId)
end

function SodacheHandbookView:onClickItem(handbookId)
	if self.handbookId == handbookId then
		return
	end

	self.handbookId = handbookId

	SodacheController.instance:dispatchEvent(SodacheEvent.OnHandbookSelectChange, handbookId)
	self.animRight:Play("refresh", 0, 0)
end

function SodacheHandbookView:refreshMonsterInfo(config)
	local monsterCo = lua_monster.configDict[config.eleId]

	if monsterCo then
		local skinCo = lua_monster_skin.configDict[monsterCo.skinId]

		self.simageMonster:LoadImage(ResUrl.monsterHeadIcon(skinCo.headIcon))
		UISpriteSetMgr.instance:setEnemyInfoSprite(self.imageCareer, "sxy_" .. tostring(monsterCo.career))

		self.txtDesc1.text = monsterCo.highPriorityDes
		self.txtDesc2.text = config.monsterDesc
	else
		logError(string.format("怪物表不存在怪物ID ： %s", config.eleId))
	end
end

function SodacheHandbookView:_onSwitchEnd()
	SodacheHandbookListModel.instance:setData(self.type)

	local handbookId = SodacheHandbookListModel.instance:getTypeFirstHnadbookId(self.type)

	self.switching = true

	self:onClickItem(handbookId, true)
end

function SodacheHandbookView:_onFreshEnd()
	local config = lua_sodache_handbook.configDict[self.handbookId]

	if config then
		if config.tab1 == SodacheEnum.HandBookType.Monster then
			self:refreshMonsterInfo(config)
		else
			self.cardInfo:setData(SodacheCardMo.Create(config.eleId))
		end
	end

	if self.switching then
		gohelper.setActive(self._goCardInfo, self.type == SodacheEnum.HandBookType.Card)
		gohelper.setActive(self._goMonsterInfo, self.type == SodacheEnum.HandBookType.Monster)

		self.switching = false
	end
end

return SodacheHandbookView
