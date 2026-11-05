-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/view/hall/ArcadeSurvivorHeroTalkItem.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.view.hall.ArcadeSurvivorHeroTalkItem", package.seeall)

local ArcadeSurvivorHeroTalkItem = class("ArcadeSurvivorHeroTalkItem", LuaCompBase)

function ArcadeSurvivorHeroTalkItem:init(go)
	self.viewGO = go
	self._goroot = gohelper.findChild(self.viewGO, "root")
	self._scrollinfo = gohelper.findChildScrollRect(self.viewGO, "root/#scroll_info")
	self._txttalk = gohelper.findChildText(self.viewGO, "root/#scroll_info/Viewport/Content/#txt_talk")
	self._goArrowTips = gohelper.findChild(self.viewGO, "root/#go_ArrowTips")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ArcadeSurvivorHeroTalkItem:_editableInitView()
	local constTime = ArcadeSurvivorConfig.instance:getConst(ArcadeSurvivorEnum.ConstId.TalkIntervalTime, true)

	self._spawnInterval = constTime / ArcadeSurvivorEnum.Const.PermillageBase
	self.updateHandle = UpdateBeat:CreateListener(self._onFrame, self)

	UpdateBeat:AddListener(self.updateHandle)
end

function ArcadeSurvivorHeroTalkItem:addEventListeners()
	self:addEventCb(ArcadeSurvivorController.instance, ArcadeSurvivorEvent.NPCTalk, self._onNPCTalk, self)
end

function ArcadeSurvivorHeroTalkItem:removeEventListeners()
	self:removeEventCb(ArcadeSurvivorController.instance, ArcadeSurvivorEvent.NPCTalk, self._onNPCTalk, self)
end

function ArcadeSurvivorHeroTalkItem:_onNPCTalk(id)
	if self.mo.id ~= id then
		return
	end

	self:checkPlayTalk()
end

function ArcadeSurvivorHeroTalkItem:onUpdateMO(mo)
	self.mo = mo
	self._isTalking = false

	local isFirst = self:isFirstTalk()
	local interactiveId = ArcadeSurvivorHallModel.instance:getInInteractiveHallUnitId()

	if isFirst or interactiveId == self.mo.id then
		self:checkPlayTalk()
	end
end

function ArcadeSurvivorHeroTalkItem:checkPlayTalk()
	local isFirst = self:isFirstTalk()
	local condition = isFirst and ArcadeSurvivorHallEnum.TalkConditionType.First or ArcadeSurvivorHallEnum.TalkConditionType.Trigger
	local groupId = self.mo:getTalkGroupId(condition)

	self:_startPlayTalk(groupId)
end

function ArcadeSurvivorHeroTalkItem:isFirstTalk()
	local value = ArcadeSurvivorOutSideModel.instance:getPlayerPrefsValue(ArcadeSurvivorHallEnum.PlayerPrefsKey.HallNPCFirst, self.mo.id, 0, true)

	return value == 0
end

function ArcadeSurvivorHeroTalkItem:_startPlayTalk(groupId)
	gohelper.setActive(self._goroot, true)

	self._curGroup = groupId
	self._curstep = 1

	self:_playTalk()

	self._isTalking = true

	AudioMgr.instance:trigger(AudioEnum3_3.Arcade.play_ui_yuanzheng_bubble_popup)
end

function ArcadeSurvivorHeroTalkItem:_onFrame()
	if not self._isTalking or not LuaUtil.tableNotEmpty(self._contentInfo) then
		return
	end

	if self._scrollinfo.verticalNormalizedPosition > 0 then
		self._scrollinfo.verticalNormalizedPosition = 0
	end

	local currentTime = Time.time

	if currentTime - self._lastSpawnTime < self._spawnInterval then
		return
	end

	if self._curContentIndex >= self._contentLen + 1 then
		if not self._nextStepTimeMS then
			local timeMs = ArcadeSurvivorConfig.instance:getConst(ArcadeSurvivorEnum.ConstId.NextStepTimeMS, true)
			local time = timeMs / ArcadeSurvivorEnum.Const.PermillageBase

			self._nextStepTimeMS = math.max(1, time)
		end

		if currentTime - self._lastSpawnTime > self._nextStepTimeMS then
			self._curstep = self._curstep + 1

			self:_playTalk()
		end

		return
	end

	self._curContentIndex = self._curContentIndex + 1

	local content = self._contentInfo[self._curContentIndex]

	if not string.nilorempty(content) then
		self:_showTalk(content)
	end

	self._lastSpawnTime = Time.time
end

function ArcadeSurvivorHeroTalkItem:_playTalk()
	local infoList, isBlock = self.mo:getStepContentInfo(self._curGroup, self._curstep)

	if not infoList or #infoList == 0 then
		self:_finishTalk()

		return
	end

	self._contentInfo = infoList
	self._contentLen = #infoList
	self._lastSpawnTime = Time.time
	self._curContentIndex = 0

	self:_showTalk("")
	ArcadeSurvivorController.instance:dispatchEvent(ArcadeSurvivorEvent.NPCTalkBlock, isBlock)
end

function ArcadeSurvivorHeroTalkItem:_showTalk(content)
	self._txttalk.text = content
end

function ArcadeSurvivorHeroTalkItem:_finishTalk()
	ArcadeSurvivorController.instance:dispatchEvent(ArcadeSurvivorEvent.NPCTalkBlock, false)

	local isFirst = self:isFirstTalk()

	if isFirst then
		ArcadeSurvivorOutSideModel.instance:setPlayerPrefsValue(ArcadeSurvivorHallEnum.PlayerPrefsKey.HallNPCFirst, self.mo.id, 1, true)
	end

	gohelper.setActive(self._goroot, false)

	self._isTalking = false
end

function ArcadeSurvivorHeroTalkItem:onDestroy()
	if self.updateHandle then
		UpdateBeat:RemoveListener(self.updateHandle)
	end
end

return ArcadeSurvivorHeroTalkItem
