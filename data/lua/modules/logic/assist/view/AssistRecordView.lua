-- chunkname: @modules/logic/assist/view/AssistRecordView.lua

module("modules.logic.assist.view.AssistRecordView", package.seeall)

local AssistRecordView = class("AssistRecordView", BaseView)

function AssistRecordView:onInitView()
	self._txtLikeCnt = gohelper.findChildText(self.viewGO, "root/Left/total/like/#txt_LikeCnt")
	self._btnGatherTip = gohelper.findChildButtonWithAudio(self.viewGO, "root/Left/total/reward/txt_title/#btn_GatherTip")
	self._txtCurCoin = gohelper.findChildText(self.viewGO, "root/Left/total/reward/layout/#txt_CurCoin")
	self._txtTotalCoin = gohelper.findChildText(self.viewGO, "root/Left/total/reward/layout/#txt_TotalCoin")
	self._goGatherTip = gohelper.findChild(self.viewGO, "root/Left/#go_GatherTip")
	self._btnCloseGatherTip = gohelper.findChildButtonWithAudio(self.viewGO, "root/Left/#go_GatherTip/#btn_CloseGatherTip")
	self._txtTip = gohelper.findChildText(self.viewGO, "root/Left/#go_GatherTip/Tip/#txt_Tip")
	self._goHeroNodes = gohelper.findChild(self.viewGO, "root/Right/#go_HeroNodes")
	self._gotopleft = gohelper.findChild(self.viewGO, "root/#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AssistRecordView:addEvents()
	self._btnGatherTip:AddClickListener(self._btnGatherTipOnClick, self)
	self._btnCloseGatherTip:AddClickListener(self._btnCloseGatherTipOnClick, self)
end

function AssistRecordView:removeEvents()
	self._btnGatherTip:RemoveClickListener()
	self._btnCloseGatherTip:RemoveClickListener()
end

function AssistRecordView:_btnGatherTipOnClick()
	gohelper.setActive(self._goGatherTip, true)
end

function AssistRecordView:_btnCloseGatherTipOnClick()
	gohelper.setActive(self._goGatherTip, false)
end

function AssistRecordView:_editableInitView()
	self:_btnCloseGatherTipOnClick()
end

function AssistRecordView:onOpen()
	local recordInfoMo = AssistRecordModel.instance:getRecordInfo()

	self._txtLikeCnt.text = recordInfoMo:getAllLikeCount()

	local hasReceived = PlayerModel.instance:getHasReceiveAssistBonus()
	local maxReceived = PlayerModel.instance:getMaxAssistRewardCount()

	self._txtCurCoin.text = hasReceived
	self._txtTotalCoin.text = maxReceived

	local langStr = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("player_assist_reward_tips"), hasReceived, maxReceived)

	self._txtTip.text = langStr

	for _, v in pairs(AssistEnum.DungeonType) do
		local go = gohelper.findChild(self.viewGO, "root/Left/game/item_" .. tostring(v))

		if go then
			local txtNum = gohelper.findChildText(go, "txt_Num")
			local dungeonStatMo = recordInfoMo:getDungeonStatByType(v)
			local count = dungeonStatMo and dungeonStatMo.count or 0

			txtNum.text = count
		end
	end

	local top3StatMos = recordInfoMo:getTop3HeroStats()

	for i = 1, 3 do
		local statMo = top3StatMos[i]

		if statMo then
			local root = gohelper.findChild(self._goHeroNodes, tostring(i))
			local cloneGo = self:getResInst(ShowCharacterCardItem.prefabPath, root)
			local item = MonoHelper.addNoUpdateLuaComOnceToGo(cloneGo, ShowCharacterCardItem)

			item:setShowParam(true, true)

			local mo = HeroModel.instance:getById(statMo.heroUid)

			item:onUpdateMO(mo)
		end
	end
end

return AssistRecordView
