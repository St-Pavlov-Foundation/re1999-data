-- chunkname: @modules/logic/versionactivity4_1/guessgamenew/view/GuessGameNewPlayRoleTipsView.lua

module("modules.logic.versionactivity4_1.guessgamenew.view.GuessGameNewPlayRoleTipsView", package.seeall)

local GuessGameNewPlayRoleTipsView = class("GuessGameNewPlayRoleTipsView", BaseView)

function GuessGameNewPlayRoleTipsView:onInitView()
	self._goroletip = gohelper.findChild(self.viewGO, "#go_roletip")
	self._txttips = gohelper.findChildText(self.viewGO, "#go_roletip/#txt_tips")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function GuessGameNewPlayRoleTipsView:addEvents()
	return
end

function GuessGameNewPlayRoleTipsView:removeEvents()
	return
end

function GuessGameNewPlayRoleTipsView:_editableInitView()
	return
end

function GuessGameNewPlayRoleTipsView:onUpdateParam()
	return
end

function GuessGameNewPlayRoleTipsView:onOpen()
	AudioMgr.instance:trigger(AudioEnum4_1.GuessGameNew.play_ui_beiai_kapai_play_round)
	TaskDispatcher.runDelay(self._onStartFinished, self, 1.5)
	self:_refresh()
end

function GuessGameNewPlayRoleTipsView:_refresh()
	local curRole = GuessGameNewModel.instance:getCurPlayRole()
	local name = ""
	local roleMo = GuessGameNewModel.instance:getRoleData(curRole)

	if curRole == GuessGameNewEnum.RoleType.Player then
		name = PlayerModel.instance:getPlayerName()
	else
		local npcCo = roleMo.npcConfig

		if npcCo then
			name = npcCo.name
		end
	end

	self._txttips.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("guessgame_npcround_tip"), name)
end

function GuessGameNewPlayRoleTipsView:_onStartFinished()
	self:closeThis()
end

function GuessGameNewPlayRoleTipsView:onClose()
	return
end

function GuessGameNewPlayRoleTipsView:onDestroyView()
	TaskDispatcher.cancelTask(self._onStartFinished, self)
end

return GuessGameNewPlayRoleTipsView
