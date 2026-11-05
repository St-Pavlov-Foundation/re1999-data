-- chunkname: @modules/logic/versionactivity4_1/guessgamenew/view/GuessGameNewPlayNpcGuessRolesView.lua

module("modules.logic.versionactivity4_1.guessgamenew.view.GuessGameNewPlayNpcGuessRolesView", package.seeall)

local GuessGameNewPlayNpcGuessRolesView = class("GuessGameNewPlayNpcGuessRolesView", BaseView)

function GuessGameNewPlayNpcGuessRolesView:onInitView()
	self._gorole1 = gohelper.findChild(self.viewGO, "#go_role1")
	self._gorole2 = gohelper.findChild(self.viewGO, "#go_role2")
	self._gorole3 = gohelper.findChild(self.viewGO, "#go_role3")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function GuessGameNewPlayNpcGuessRolesView:addEvents()
	return
end

function GuessGameNewPlayNpcGuessRolesView:removeEvents()
	return
end

function GuessGameNewPlayNpcGuessRolesView:_editableInitView()
	self._roleItems = self:getUserDataTb_()

	self:_addSelfEvents()
end

function GuessGameNewPlayNpcGuessRolesView:onUpdateParam()
	return
end

function GuessGameNewPlayNpcGuessRolesView:onOpen()
	AudioMgr.instance:trigger(AudioEnum4_1.GuessGameNew.play_ui_fight_card_flip)
	self:_initRoles()
end

function GuessGameNewPlayNpcGuessRolesView:_initRoles()
	local otherRes = self.viewContainer._viewSetting.otherRes
	local curRoleType = GuessGameNewModel.instance:getCurPlayRole()
	local nextRoleType = GuessGameNewModel.instance:getNextPlayRole()

	for _, roleMo in ipairs(GuessGameNewModel.instance:getRoleDatas()) do
		local roleType = roleMo.roleType
		local roleItem = self._roleItems[roleType]

		if not roleItem then
			local isPlayer = roleType == GuessGameNewEnum.RoleType.Player
			local ItemClass = isPlayer and GuessGameNewPlayPlayerItem or GuessGameNewPlayNpcItem
			local parent = self["_gorole" .. roleType]

			roleItem = ItemClass.New()

			roleItem:init(self:getResInst(otherRes[isPlayer and 2 or 3], parent), self:getResInst(otherRes[1], parent))

			self._roleItems[roleType] = roleItem
		end

		roleItem:refresh(roleType)

		local show = roleType == curRoleType or roleType == nextRoleType

		roleItem:showRole(show)
	end

	for _, roleItem in pairs(self._roleItems) do
		if roleItem:getRoleType() == curRoleType then
			roleItem:showRoleDistributeTalk()
		end

		if roleItem:getRoleType() == GuessGameNewEnum.RoleType.Player then
			roleItem:showMask(true)
		end
	end
end

function GuessGameNewPlayNpcGuessRolesView:_addSelfEvents()
	local controller = GuessGameNewController.instance

	self._selfEvents = {
		[GuessGameNewEvent.OnReduceRoleHp] = self._onReduceRoleHp,
		[GuessGameNewEvent.OnShowRoleResultBubble] = self._onShowRoleResultBubble
	}

	for event, handler in pairs(self._selfEvents) do
		self:addEventCb(controller, event, handler, self)
	end
end

function GuessGameNewPlayNpcGuessRolesView:_removeSelfEvents()
	local controller = GuessGameNewController.instance

	for event, handler in pairs(self._selfEvents) do
		self:removeEventCb(controller, event, handler, self)
	end
end

function GuessGameNewPlayNpcGuessRolesView:_onReduceRoleHp(roleType)
	for _, roleItem in pairs(self._roleItems) do
		roleItem:refreshHp()

		if roleItem:getRoleType() == roleType then
			roleItem:showRoleReduceHp()
		end
	end
end

function GuessGameNewPlayNpcGuessRolesView:_onShowRoleResultBubble(roleType)
	local nextRoleType = GuessGameNewModel.instance:getNextPlayRole()

	for _, roleItem in pairs(self._roleItems) do
		if roleItem:getRoleType() == nextRoleType and nextRoleType ~= GuessGameNewEnum.RoleType.Player then
			local isRight = roleType ~= nextRoleType

			roleItem:showRoleResultTalk(isRight)
		end
	end
end

function GuessGameNewPlayNpcGuessRolesView:onClose()
	return
end

function GuessGameNewPlayNpcGuessRolesView:onDestroyView()
	if self._roleItems then
		for _, v in pairs(self._roleItems) do
			v:destroy()
		end

		self._roleItems = nil
	end

	self:_removeSelfEvents()
end

return GuessGameNewPlayNpcGuessRolesView
