-- chunkname: @modules/logic/versionactivity4_1/guessgamenew/view/GuessGameNewSelectItem.lua

module("modules.logic.versionactivity4_1.guessgamenew.view.GuessGameNewSelectItem", package.seeall)

local GuessGameNewSelectItem = class("GuessGameNewSelectItem", SimpleListItem)

function GuessGameNewSelectItem:onInit()
	self._gonormal = gohelper.findChild(self.viewGO, "anim/State_Normal")
	self._gorock = gohelper.findChild(self.viewGO, "anim/State_Normal/#card_Rock")
	self._goscissors = gohelper.findChild(self.viewGO, "anim/State_Normal/#card_Scissors")
	self._gopaper = gohelper.findChild(self.viewGO, "anim/State_Normal/#card_Paper")
	self._goplay = gohelper.findChild(self.viewGO, "anim/State_Normal/#go_play")
	self._golight = gohelper.findChild(self.viewGO, "anim/cardlight")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "anim/btnClick", AudioEnum3_2.play_ui_shengyan_box_songjin_click)
	self._itemAnim = self.viewGO:GetComponent(gohelper.Type_Animator)
end

function GuessGameNewSelectItem:onAddListeners()
	self:addClickCb(self._btnclick, self.onClick, self)
end

function GuessGameNewSelectItem:onRemoveListeners()
	return
end

function GuessGameNewSelectItem:onItemShow(data)
	self._mo = data
	self._cardType = data.cardType

	gohelper.setActive(self._gorock, self._cardType == ChatRoomEnum.CardType.Rock)
	gohelper.setActive(self._goscissors, self._cardType == ChatRoomEnum.CardType.Scissors)
	gohelper.setActive(self._gopaper, self._cardType == ChatRoomEnum.CardType.Paper)
end

function GuessGameNewSelectItem:getCardType()
	return self._cardType
end

function GuessGameNewSelectItem:onSelectChange(value)
	if self._isPlayCard then
		gohelper.setActive(self._goplay, value)

		if value then
			self._itemAnim:Play("select")
		else
			self._itemAnim:Play("in", 0, 1)
		end

		self:refreshCardLight()
	end
end

function GuessGameNewSelectItem:setPlayCardActive(value)
	self._isPlayCard = value

	self:refreshCardLight()
end

function GuessGameNewSelectItem:refreshCardLight()
	gohelper.setActive(self._golight, self._isPlayCard and not self._isSelected)
end

function GuessGameNewSelectItem:playOutAnim()
	self._itemAnim:Play("out")
end

function GuessGameNewSelectItem:onClick()
	if self._mo.onClickFunc then
		self._mo.onClickFunc(self._mo.context, self)
	end

	if self._lastClickTime and Time.time - self._lastClickTime < 0.5 then
		self:onClickDouble()
	end

	self._lastClickTime = Time.time
end

function GuessGameNewSelectItem:onClickDouble()
	if self._mo.onClickDoubleFunc then
		self._mo.onClickDoubleFunc(self._mo.context, self)
	end
end

return GuessGameNewSelectItem
