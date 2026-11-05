-- chunkname: @modules/logic/versionactivity4_1/guessgamenew/view/GuessGameNewPlayRoundTipsView.lua

module("modules.logic.versionactivity4_1.guessgamenew.view.GuessGameNewPlayRoundTipsView", package.seeall)

local GuessGameNewPlayRoundTipsView = class("GuessGameNewPlayRoundTipsView", BaseView)

function GuessGameNewPlayRoundTipsView:onInitView()
	self._goroundtip = gohelper.findChild(self.viewGO, "#go_roundtip")
	self._txttips = gohelper.findChildText(self.viewGO, "#go_roundtip/#txt_tips")
	self._imageGift = gohelper.findChildImage(self.viewGO, "#go_roundtip/#image_gift")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function GuessGameNewPlayRoundTipsView:addEvents()
	return
end

function GuessGameNewPlayRoundTipsView:removeEvents()
	return
end

function GuessGameNewPlayRoundTipsView:_editableInitView()
	return
end

function GuessGameNewPlayRoundTipsView:onOpen()
	self._roundId = GuessGameNewModel.instance:getCurRound()

	AudioMgr.instance:trigger(AudioEnum4_1.GuessGameNew.play_ui_beiai_kapai_card_content)
	TaskDispatcher.runDelay(self._onStartFinished, self, 1.5)
	self:_refresh()
end

function GuessGameNewPlayRoundTipsView:_refresh()
	self._txttips.text = "Round " .. self._roundId

	local targetGiftId = GuessGameNewModel.instance:getTargetGiftId()

	self._config = GuessGameNewConfig.instance:getBoxGiftCo(targetGiftId)

	UISpriteSetMgr.instance:setV3a7Activity3ndSprite(self._imageGift, self._config.icon)
end

function GuessGameNewPlayRoundTipsView:_onStartFinished()
	self:closeThis()
end

function GuessGameNewPlayRoundTipsView:onClose()
	return
end

function GuessGameNewPlayRoundTipsView:onDestroyView()
	TaskDispatcher.cancelTask(self._onStartFinished, self)
end

return GuessGameNewPlayRoundTipsView
