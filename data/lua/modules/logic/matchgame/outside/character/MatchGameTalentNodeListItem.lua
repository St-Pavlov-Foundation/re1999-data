-- chunkname: @modules/logic/matchgame/outside/character/MatchGameTalentNodeListItem.lua

module("modules.logic.matchgame.outside.character.MatchGameTalentNodeListItem", package.seeall)

local MatchGameTalentNodeListItem = class("MatchGameTalentNodeListItem", SimpleListItem)

function MatchGameTalentNodeListItem:onInit(viewGO)
	self._goLock = gohelper.findChild(self.viewGO, "go_Lock")
	self._imageIcon1 = gohelper.findChildSingleImage(self.viewGO, "go_Lock/image_Icon")
	self._txtCost1 = gohelper.findChildText(self.viewGO, "go_Lock/txt_Cost")
	self._imageCost1 = gohelper.findChildImage(self.viewGO, "go_Lock/txt_Cost/icon")
	self._goUnlock = gohelper.findChild(self.viewGO, "go_Unlock")
	self._imageBg2 = gohelper.findChildSingleImage(self.viewGO, "go_Unlock")
	self._imageIcon2 = gohelper.findChildSingleImage(self.viewGO, "go_Unlock/image_Icon")
	self._txtCost2 = gohelper.findChildText(self.viewGO, "go_Unlock/txt_Cost")
	self._imageCost2 = gohelper.findChildImage(self.viewGO, "go_Unlock/txt_Cost/icon")
	self._goActive = gohelper.findChild(self.viewGO, "go_Active")
	self._imageBg3 = gohelper.findChildSingleImage(self.viewGO, "go_Active")
	self._imageIcon3 = gohelper.findChildSingleImage(self.viewGO, "go_Active/image_Icon")
	self._txtCost3 = gohelper.findChildText(self.viewGO, "go_Active/txt_Cost")
	self._imageCost3 = gohelper.findChildImage(self.viewGO, "go_Active/txt_Cost/icon")
	self._goSelect = gohelper.findChild(self.viewGO, "go_Select")
	self._goEffect_Unlock = gohelper.findChild(self.viewGO, "go_UIEff_Unlock")
	self._goEffect_Unlockable = gohelper.findChild(self.viewGO, "go_UIEff_Unlockable")
	self._goEff_Activate = gohelper.findChild(self.viewGO, "go_UIEff_Activate")

	gohelper.setActive(self._goEffect_Unlock, false)
	gohelper.setActive(self._goEff_Activate, false)
end

function MatchGameTalentNodeListItem:onItemShow(data)
	self._preNodeId = self._nodeId
	self._preStatus = self._status
	self._nodeCo = data
	self._nodeId = self._nodeCo.nodeId

	local icon = self._nodeCo.icon
	local iconUrl = ResUrl.getMatchGameSingleBg(icon, "talent")

	self._imageIcon1:LoadImage(iconUrl)
	self._imageIcon2:LoadImage(iconUrl)
	self._imageIcon3:LoadImage(iconUrl)

	local branchCo = lua_activity244_talent_branch.configDict[self._nodeCo.branch]
	local bg = branchCo and branchCo.nodeBg or ""
	local bgUrl = ResUrl.getMatchGameSingleBg(bg, "talent")

	self._imageBg2:LoadImage(bgUrl)
	self._imageBg3:LoadImage(bgUrl)
	self:refreshUI()
end

function MatchGameTalentNodeListItem:refreshUI()
	self:refreshCost()
	self:refreshStatus()
	self:setPosition()
end

function MatchGameTalentNodeListItem:refreshCost()
	local costList = MatchGameConfig.instance:getTalentNodeCost(self._nodeId)
	local costNum = costList and costList[1][2] or 0

	self._txtCost1.text = costNum
	self._txtCost2.text = costNum
	self._txtCost3.text = costNum
end

function MatchGameTalentNodeListItem:refreshStatus()
	self._status = MatchGameModel.instance:getTalentNodeStatus(self._nodeId)

	gohelper.setActive(self._goLock, self._status == MatchGameEnum.TalentNodeStatus.Lock)
	gohelper.setActive(self._goUnlock, self._status == MatchGameEnum.TalentNodeStatus.Unlock)
	gohelper.setActive(self._goActive, self._status == MatchGameEnum.TalentNodeStatus.Active)
	gohelper.setActive(self._goEffect_Unlock, false)
	gohelper.setActive(self._goEff_Activate, false)
	gohelper.setActive(self._goEffect_Unlockable, false)

	if self._preNodeId == self._nodeId and self._preStatus ~= self._status then
		if self._status == MatchGameEnum.TalentNodeStatus.Active then
			AudioMgr.instance:trigger(MatchGameAudioEnum.ActiveTalent)
			gohelper.setActive(self._goEff_Activate, true)
		elseif self._status == MatchGameEnum.TalentNodeStatus.Unlock then
			gohelper.setActive(self._goEffect_Unlock, true)
		end
	end

	gohelper.setActive(self._goEffect_Unlockable, false)

	local cost = MatchGameConfig.instance:getTalentNodeCost(self._nodeId)

	if self._status == MatchGameEnum.TalentNodeStatus.Unlock then
		local isItemEnough = MatchGameModel.instance:isItemEnough(cost)

		gohelper.setActive(self._goEffect_Unlockable, isItemEnough)
	end

	local itemId = cost[1][1]

	MatchGameHelper.setItemIcon(itemId, self._imageCost1)
	MatchGameHelper.setItemIcon(itemId, self._imageCost2)
	MatchGameHelper.setItemIcon(itemId, self._imageCost3)
end

function MatchGameTalentNodeListItem:onSelectChange(isSelect)
	gohelper.setActive(self._goSelect, isSelect)
end

function MatchGameTalentNodeListItem:setPosition()
	local isEven = self.itemIndex % 2 == 0
	local posX = (self.itemIndex - 1) * MatchGameEnum.TalentNodeSpaceWidth + MatchGameEnum.TalentNodeStartSpace
	local posY = isEven and MatchGameEnum.TalentNodePosY_Even or MatchGameEnum.TalentNodePosY_Odd

	self._posX = posX
	self._posY = posY

	recthelper.setAnchor(self.transform, posX, posY)
end

function MatchGameTalentNodeListItem:getPosition()
	return self._posX, self._posY
end

function MatchGameTalentNodeListItem:onDestroy()
	self._imageIcon1:UnLoadImage()
	self._imageIcon2:UnLoadImage()
	self._imageIcon3:UnLoadImage()
	self._imageBg2:UnLoadImage()
	self._imageBg3:UnLoadImage()
end

return MatchGameTalentNodeListItem
