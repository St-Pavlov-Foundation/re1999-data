-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/view/hall/ArcadeSurvivorDifficultyView.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.view.hall.ArcadeSurvivorDifficultyView", package.seeall)

local ArcadeSurvivorDifficultyView = class("ArcadeSurvivorDifficultyView", BaseView)

function ArcadeSurvivorDifficultyView:onInitView()
	self._godifficultitem = gohelper.findChild(self.viewGO, "root/#scroll_DifficultList/Viewport/Content/#go_difficultitem")
	self._goitem = gohelper.findChild(self.viewGO, "root/#scroll_DifficultList/Viewport/Content/#go_difficultitem/item")
	self._txtDesc = gohelper.findChildText(self.viewGO, "root/Scroll View/Viewport/content/#txt_Desc")
	self._btnclose = ArcadeSurvivorGameHelper.getArcadeSurvivorButton(self.viewGO, "root/#btn_close")
	self._btnenter = ArcadeSurvivorGameHelper.getArcadeSurvivorButton(self.viewGO, "root/#btn_enter")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ArcadeSurvivorDifficultyView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnenter:AddClickListener(self._btnenterOnClick, self)
end

function ArcadeSurvivorDifficultyView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnenter:RemoveClickListener()
end

function ArcadeSurvivorDifficultyView:_btncloseOnClick()
	self:closeThis()
end

function ArcadeSurvivorDifficultyView:_btnenterOnClick()
	local selectItem = self._difficultyItemList[self._selectIndex]
	local difficulty = selectItem and selectItem.difficulty

	if not difficulty then
		return
	end

	ArcadeSurvivorController.instance:beginTransitionGame(difficulty)
	self:closeThis()
end

function ArcadeSurvivorDifficultyView:_onClickDifficultyItem(selectIndex)
	local selectItem = self._difficultyItemList[selectIndex]

	if not selectItem then
		return
	end

	local isUnlock = ArcadeSurvivorController.instance:checkDifficultyUnlock(selectItem.difficulty, ToastEnum.ArcadeSurvivorDifficultyLock)

	if not isUnlock then
		return
	end

	if self._selectIndex == selectIndex then
		return
	end

	self._selectIndex = selectIndex

	for index, item in ipairs(self._difficultyItemList) do
		local isSelected = index == self._selectIndex

		gohelper.setActive(item.goselect, isSelected)
	end

	self._txtDesc.text = ArcadeSurvivorConfig.instance:getDifficultyDesc(selectItem.difficulty)
end

function ArcadeSurvivorDifficultyView:_editableInitView()
	self._selectIndex = nil
	self._difficultyItemList = {}
end

local DEFAULT_SELECT_INDEX = 1

function ArcadeSurvivorDifficultyView:onOpen()
	local interactiveId = ArcadeSurvivorHallModel.instance:getInInteractiveHallUnitId()
	local minDifficulty = ArcadeSurvivorConfig.instance:getHallUnitDifficulty(interactiveId)
	local dataList = {
		minDifficulty
	}
	local difficultyList = ArcadeSurvivorConfig.instance:getDifficultyIdList()

	for _, difficulty in ipairs(difficultyList) do
		if minDifficulty < difficulty then
			dataList[#dataList + 1] = difficulty
		end
	end

	gohelper.CreateObjList(self, self._onCreateDifficultyItem, dataList, self._godifficultitem, self._goitem)

	local selectIndex = DEFAULT_SELECT_INDEX
	local maxDifficulty

	for index, difficulty in ipairs(dataList) do
		if ArcadeSurvivorOutSideModel.instance:isUnlockDifficulty(difficulty) and (not maxDifficulty or maxDifficulty < difficulty) then
			maxDifficulty = difficulty
			selectIndex = index
		end
	end

	self:_onClickDifficultyItem(selectIndex)
	AudioMgr.instance:trigger(AudioEnum3_3.Arcade.play_ui_yuanzheng_interface_open)
end

function ArcadeSurvivorDifficultyView:_onCreateDifficultyItem(obj, difficulty, index)
	local item = self:getUserDataTb_()

	item.go = obj
	item.difficulty = difficulty
	item.goselect = gohelper.findChild(obj, "#go_select")
	item.btnclick = ArcadeSurvivorGameHelper.getArcadeSurvivorClickListener(obj, "#btn_click")

	self:addClickCb(item.btnclick, self._onClickDifficultyItem, self, index)

	local txtnum = gohelper.findChildText(obj, "#txt_num")

	txtnum.text = index

	local golocked = gohelper.findChild(obj, "#go_locked")
	local gofinish = gohelper.findChild(obj, "#go_finish")
	local gounlock = gohelper.findChild(obj, "#go_unlock")
	local isUnlock = ArcadeSurvivorOutSideModel.instance:isUnlockDifficulty(difficulty)

	if isUnlock then
		local finishCount = ArcadeSurvivorOutSideModel.instance:getFinishDifficultyCount(difficulty)
		local isFinish = finishCount > 0

		gohelper.setActive(gofinish, isFinish)
		gohelper.setActive(gounlock, not isFinish)
		gohelper.setActive(golocked, false)

		local animator = obj:GetComponent(gohelper.Type_Animator)

		if animator and isFinish then
			local key = ArcadeSurvivorHallEnum.PlayerPrefsKey.DifficultyFinishAnim
			local prefsVal = ArcadeSurvivorOutSideModel.instance:getPlayerPrefsValue(key, difficulty, 0, true)
			local isPlayAnim = prefsVal == 0

			animator:Play("finish", 0, isPlayAnim and 0 or 1)

			if isPlayAnim then
				AudioMgr.instance:trigger(AudioEnum4_1.ArcadeSurvivor.play_ui_atlantis_nandu_finish)
			end

			ArcadeSurvivorOutSideModel.instance:setPlayerPrefsValue(key, difficulty, 1, true)
		end
	else
		gohelper.setActive(gofinish, false)
		gohelper.setActive(gounlock, false)
		gohelper.setActive(golocked, true)
	end

	self._difficultyItemList[index] = item
end

function ArcadeSurvivorDifficultyView:onClose()
	self._selectIndex = nil
end

function ArcadeSurvivorDifficultyView:onDestroyView()
	self._difficultyItemList = nil
end

return ArcadeSurvivorDifficultyView
