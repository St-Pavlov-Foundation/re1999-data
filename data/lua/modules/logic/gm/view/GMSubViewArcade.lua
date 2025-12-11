-- chunkname: @modules/logic/gm/view/GMSubViewArcade.lua

module("modules.logic.gm.view.GMSubViewArcade", package.seeall)

local GMSubViewArcade = class("GMSubViewArcade", GMSubViewBase)

function GMSubViewArcade:ctor()
	self.tabName = "街机秀"
end

function GMSubViewArcade:addEvents()
	self:addEventCb(ArcadeGameController.instance, ArcadeEvent.OnChangeArcadeRoomFinish, self._resetPortalList, self)
end

function GMSubViewArcade:removeEvents()
	self:removeEventCb(ArcadeGameController.instance, ArcadeEvent.OnChangeArcadeRoomFinish, self._resetPortalList, self)
end

function GMSubViewArcade:initViewContent()
	if self._isInit then
		return
	end

	self._isInit = true

	self:_initL1()
	self:_initL2()
	self:_initL3()
	self:_initL4()
	self:_initL5()
	self:_initL6()
	self:_initL7()
	self:_initL8()
end

function GMSubViewArcade:_initL1()
	local LStr = "L1"

	self:addLabel(LStr, "怪物Id")

	self._actMonsterId = self:addInputText(LStr, nil, "怪物id")

	self:addButton(LStr, "添加怪物", self._addMonsterId, self)
	self:addLabel(LStr, "藏品Id")

	self._actCollectionId = self:addInputText(LStr, nil, "藏品Id")

	self:addButton(LStr, "添加藏品", self._addCollectionId, self)
end

function GMSubViewArcade:_addCollectionId()
	local collectionId = tonumber(self._actCollectionId:GetText())

	if collectionId == 0 then
		return
	end

	local cfg = ArcadeConfig.instance:getCollectionCfg(collectionId)

	if not cfg then
		GameFacade.showToast(94, string.format("不存在藏品id:[%s]", collectionId))

		return
	end

	local collectionMO = ArcadeGameController.instance:gainCollection(collectionId, Vector3.zero)

	if collectionMO then
		GameFacade.showToast(94, string.format("成功[%s-%s]", cfg.name, collectionId))
	else
		GameFacade.showToast(94, string.format("失败"))
	end
end

function GMSubViewArcade:_addMonsterId()
	local monsterId = tonumber(self._actMonsterId:GetText())

	if monsterId == 0 then
		return
	end

	local cfg = ArcadeConfig.instance:getMonsterCfg(monsterId)

	if not cfg then
		GameFacade.showToast(94, string.format("不存在怪物id:%s", monsterId))

		return
	end

	local isSuccess, gridX, gridY = ArcadeGameSummonController.instance:summonMonster(monsterId)

	if isSuccess then
		GameFacade.showToast(94, string.format("成功[%s-%s](%s,%s)", cfg.name, monsterId, gridX, gridY))
	else
		GameFacade.showToast(94, string.format("没有空位"))
	end
end

function GMSubViewArcade:_initL2()
	local LStr = "L2"

	self:addLabel(LStr, "技能Id")

	self._skillIdInputText = self:addInputText(LStr, nil, "技能Id")

	self:addButton(LStr, "使用技能", self._onClickUseSkillOk, self)
	self:addLabel(LStr, "跳转房间")

	self._arcadeRoomInputText = self:addInputText(LStr, nil, "房间Id")

	self:addButton(LStr, "跳转", self._changeRoom, self)
end

function GMSubViewArcade:_onClickUseSkillOk()
	local skillId = tonumber(self._skillIdInputText:GetText())

	if not skillId or skillId == 0 then
		GameFacade.showToast(94, "请输入技能ID")

		return
	end

	if self:_isLockClick() then
		return
	end

	local target = ArcadeGameModel.instance:getCharacterMO()
	local context = {
		target = target
	}

	context.hiterList = {}
	context.atker = target

	ArcadeGameSkillController.instance:useSkill(target, skillId, context)
end

function GMSubViewArcade:_isLockClick()
	if self._nextUnLockTime and self._nextUnLockTime > Time.time then
		GameFacade.showToast(94, "点击太快了")

		return true
	end

	self._nextUnLockTime = Time.time + 0.2

	return false
end

function GMSubViewArcade:_initL3()
	local LStr = "L3"

	self:addLabel(LStr, "技能效果")

	self._skillHitInputText = self:addInputText(LStr, nil, "效果配置")

	self:addButton(LStr, "确定效果", self._onClickSkillHitOk, self)
	self:addButton(LStr, "检查技能配置", self._onClickCheckSkillOk, self)
end

function GMSubViewArcade:_onClickSkillHitOk()
	local hitStr = self._skillHitInputText:GetText()

	if string.nilorempty(hitStr) then
		GameFacade.showToast(94, "请输入技能效果")

		return
	end

	if self:_isLockClick() then
		return
	end

	local hitBase = ArcadeSkillFactory.instance:createSkillHit(hitStr)
	local target = ArcadeGameModel.instance:getCharacterMO()
	local context = {
		target = target
	}

	context.hiterList = {}
	context.atker = target

	hitBase:hit(context)
	GameFacade.showToast(94, "run hitBase: " .. hitBase.__cname)
end

local xpcall = xpcall
local __G__TRACKBACK__ = __G__TRACKBACK__

local function _createSkillFunc(skillId)
	return ArcadeSkillFactory.instance:createSkillById(skillId)
end

function GMSubViewArcade:_onClickCheckSkillOk()
	local configList = lua_arcade_passive_skill.configList
	local xpcall = xpcall
	local __G__TRACKBACK__ = __G__TRACKBACK__

	for _, cfg in ipairs(configList) do
		xpcall(_createSkillFunc, __G__TRACKBACK__, cfg.id)
	end

	GameFacade.showToast(94, "请查看Log输出")
end

function GMSubViewArcade:_onInitL3Text()
	local list = {}

	for i = 1, 10 do
		list[#list + 1] = i
	end

	RoomHelper.randomArray(list)
	table.sort(list, GMSubViewArcade._sortNum)

	local concatStr = table.concat(list, " ")

	logError("========= > " .. #list)
	logError("msg lock: " .. concatStr .. " len:" .. #list)
end

function GMSubViewArcade._sortNum(a, b)
	local aIdx = a % 2
	local bIdx = b % 2

	if aIdx ~= bIdx then
		return aIdx < bIdx
	end
end

function GMSubViewArcade:_changeRoom()
	local roomId = tonumber(self._arcadeRoomInputText:GetText())

	if not roomId or roomId == 0 then
		return
	end

	local cfg = ArcadeConfig.instance:getRoomCfg(roomId, true)

	if not cfg then
		return
	end

	ArcadeGameController.instance:change2Room(roomId)
	GameFacade.showToast(94, string.format("跳转到房间：%s", roomId))
end

function GMSubViewArcade:_initL4()
	local LStr = "L4"
	local strList = {
		"选择资源"
	}

	self._resourceList = {}

	local resIdList = {}

	for _, resId in pairs(ArcadeGameEnum.CharacterResource) do
		resIdList[#resIdList + 1] = resId
	end

	table.sort(resIdList, function(a, b)
		return a < b
	end)

	for _, resId in ipairs(resIdList) do
		self._resourceList[#self._resourceList + 1] = resId

		local name = ArcadeConfig.instance:getAttributeName(resId)

		strList[#strList + 1] = name
	end

	self:addDropDown(LStr, "添加资源", strList, self._onResSelectChange, self, {
		tempH = 450,
		total_w = 650,
		drop_w = 415
	})

	self._changeResCountText = self:addInputText(LStr, nil, "更改数量")

	self:addButton(LStr, "确定", self._onClickResChangeOk, self)
end

function GMSubViewArcade:_onResSelectChange(index)
	self._selectedRes = self._resourceList[index]
end

function GMSubViewArcade:_onClickResChangeOk()
	if not self._selectedRes then
		GameFacade.showToast(94, "未选择资源")

		return
	end

	local changeCount = tonumber(self._changeResCountText:GetText())

	if not changeCount or changeCount == 0 then
		GameFacade.showToast(94, "未填写变更数量")

		return
	end

	ArcadeGameController.instance:changeResCount(self._selectedRes, changeCount, Vector3.zero)

	local name = ArcadeConfig.instance:getAttributeName(self._selectedRes)

	GameFacade.showToast(94, string.format("%s数量更改：%s", name, changeCount))
end

function GMSubViewArcade:_initL5()
	local LStr = "L5"

	self:addLabel(LStr, "地块")

	self._floorIdInputText = self:addInputText(LStr, nil, "地块id")

	self:addButton(LStr, "生成", self._onClickCreateFloorOk, self)
	self:addButton(LStr, "清除", self._onClickClearFloorOk, self)
	self:addButton(LStr, "获取当前房间ID", self._onClickCurRoom, self)
end

function GMSubViewArcade:_getInputFloorId()
	local floorIdStr = self._floorIdInputText:GetText()

	if string.nilorempty(floorIdStr) then
		GameFacade.showToast(94, "请输入地块id")

		return
	end

	local floorId = tonumber(floorIdStr)

	if not ArcadeConfig.instance:getSkillFloorCfg(floorId) then
		GameFacade.showToast(94, "不存在地块Id:%s", floorIdStr)

		return
	end

	return floorId
end

function GMSubViewArcade:_onClickCreateFloorOk()
	local floorId = self:_getInputFloorId()

	if not floorId or self:_isLockClick() then
		return
	end

	local dataList = {}

	for x = 2, 6 do
		for y = 2, 5 do
			table.insert(dataList, {
				id = floorId,
				x = x,
				y = y
			})
		end
	end

	ArcadeGameFloorController.instance:tryAddFloorByList(dataList)
end

function GMSubViewArcade:_onClickClearFloorOk()
	local floorId = self:_getInputFloorId()

	if not floorId or self:_isLockClick() then
		return
	end

	local floorMOList = {}
	local entityType = ArcadeGameEnum.EntityType.Floor

	tabletool.addValues(floorMOList, ArcadeGameModel.instance:getEntityMOList(entityType))

	for _, floorMO in ipairs(floorMOList) do
		if floorMO and floorMO:getId() == floorId then
			ArcadeGameController.instance:removeEntity(entityType, floorMO:getUid())
		end
	end
end

function GMSubViewArcade:_onClickCurRoom()
	local roomId = ArcadeGameModel.instance:getCurRoomId()

	GameFacade.showToastString(roomId)
end

function GMSubViewArcade:_initL6()
	local LStr = "L6"

	self:addLabel(LStr, "交互物")

	self._interactIdInputText = self:addInputText(LStr, nil, "交互物id")

	self:addButton(LStr, "生成", self._onClickCreateInteractOk, self)
	self:addLabel(LStr, "炸弹")

	self._bombIdInputText = self:addInputText(LStr, nil, "炸弹id")

	self:addButton(LStr, "生成", self._onClickCreateBombOk, self)
end

function GMSubViewArcade:_onClickCreateInteractOk()
	local interactIdStr = self._interactIdInputText:GetText()

	if string.nilorempty(interactIdStr) then
		GameFacade.showToast(94, "请输入交互物id")

		return
	end

	local interactId = tonumber(interactIdStr)

	if not ArcadeConfig.instance:getInteractiveCfg(interactId) then
		GameFacade.showToast(94, "不存在交互物id:" .. interactIdStr)

		return
	end

	if self:_isLockClick() then
		return
	end

	ArcadeGameSummonController.instance:summonInteractiveList({
		interactId
	})
end

function GMSubViewArcade:_onClickCreateBombOk()
	local bombIdStr = self._bombIdInputText:GetText()

	if string.nilorempty(bombIdStr) then
		GameFacade.showToast(94, "请输入炸弹id")

		return
	end

	local bombId = tonumber(bombIdStr)

	if not ArcadeConfig.instance:getBombCfg(bombId) then
		GameFacade.showToast(94, "不存在炸弹id:" .. bombIdStr)

		return
	end

	if self:_isLockClick() then
		return
	end

	ArcadeGameSummonController.instance:summonBombList({
		bombId
	})
end

function GMSubViewArcade:_initL7()
	local LStr = "L7"
	local strList = {}

	self._portalIdList = {}

	local difficulty = ArcadeGameModel.instance:getDifficulty()
	local curAreaIndex = ArcadeGameModel.instance:getCurAreaIndex()

	if difficulty and curAreaIndex then
		local portalIdList = ArcadeGameModel.instance:getRoomPortalIdList()

		for i, portalId in ipairs(portalIdList) do
			self._portalIdList[i - 1] = portalId

			local name = ArcadeConfig.instance:getInteractiveName(portalId)

			strList[i] = string.format("%s-%s", portalId, name)
		end
	end

	self._portalDropDown = self:addDropDown(LStr, "传送门", strList, self._onChangeSelectPortal, self, {
		tempH = 450,
		total_w = 650,
		drop_w = 515
	})
	self._selectedPortalId = self._portalIdList[0]

	self:addButton(LStr, "确定", self._onClickPortalOk, self)
	self:addButton(LStr, "重置传送门", self._resetPortalList, self)
end

function GMSubViewArcade:_resetPortalList()
	self._portalIdList = {}

	local strList = {}
	local difficulty = ArcadeGameModel.instance:getDifficulty()
	local curAreaIndex = ArcadeGameModel.instance:getCurAreaIndex()

	if difficulty and curAreaIndex then
		local portalIdList = ArcadeGameModel.instance:getRoomPortalIdList()

		for i, portalId in ipairs(portalIdList) do
			self._portalIdList[i - 1] = portalId

			local name = ArcadeConfig.instance:getInteractiveName(portalId)

			strList[i] = string.format("%s-%s", portalId, name)
		end
	end

	self._portalDropDown:ClearOptions()
	self._portalDropDown:AddOptions(strList)
	self._portalDropDown:SetValue(0)

	self._selectedPortalId = self._portalIdList[0]
end

function GMSubViewArcade:_onChangeSelectPortal(index)
	self._selectedPortalId = self._portalIdList[index]
end

function GMSubViewArcade:_onClickPortalOk()
	if not self._selectedPortalId then
		GameFacade.showToast(94, "未选择传送门")

		return
	end

	local optionList = ArcadeConfig.instance:getInteractiveOptionList(self._selectedPortalId)

	if not optionList then
		return
	end

	if #optionList > 1 then
		logError(string.format("GMSubViewArcade:_onClickPortalOk error, portal:%s has more than one option", self._selectedPortalId))
	end

	local optionId = optionList[1]
	local optionParam = ArcadeConfig.instance:getEventOptionParam(optionId)
	local result = ArcadeGameController.instance:triggerEventOption(nil, nil, optionId, optionParam, true, true)

	if result then
		GameFacade.showToast(94, string.format("触发传送门：%s", self._selectedPortalId))
	end
end

function GMSubViewArcade:_initL8()
	local LStr = "L8"

	self:addButton(LStr, "打印属性", self._onClickLogAttr, self)
end

function GMSubViewArcade:_onClickLogAttr()
	local log = ""
	local gameAttrDict = ArcadeGameModel.instance._gameAttributeDict

	if gameAttrDict then
		for attrId, val in pairs(gameAttrDict) do
			log = log .. string.format("\n%s:%s", attrId, val)
		end
	end

	log = log .. "\n"

	local gameSwitchDict = ArcadeGameModel.instance._gameSwitchDict

	if gameSwitchDict then
		for attrId, val in pairs(gameSwitchDict) do
			log = log .. string.format("\n%s:%s", attrId, val)
		end
	end

	logError(log)
end

return GMSubViewArcade
