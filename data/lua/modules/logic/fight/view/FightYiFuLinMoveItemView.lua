-- chunkname: @modules/logic/fight/view/FightYiFuLinMoveItemView.lua

module("modules.logic.fight.view.FightYiFuLinMoveItemView", package.seeall)

local FightYiFuLinMoveItemView = class("FightYiFuLinMoveItemView", FightBaseView)

FightYiFuLinMoveItemView.ItemSpacingX = 17

function FightYiFuLinMoveItemView:onInitView()
	self._rootGO = gohelper.findChild(self.viewGO, "root")
	self._heroEmptyGO = gohelper.findChild(self.viewGO, "root/hero/empty")
	self._heroHasGO = gohelper.findChild(self.viewGO, "root/hero/has")
	self._cardIcon = gohelper.findChildSingleImage(self.viewGO, "root/hero/has/heroicon")
	self._txtIndex = gohelper.findChildText(self.viewGO, "root/hero/empty/#txt_index")
	self._tokenGO = gohelper.findChild(self.viewGO, "token")
	self._clueTemplate = gohelper.findChild(self.viewGO, "token/#image_icon")
	self._passionPointGO = gohelper.findChild(self.viewGO, "root/passionpoint")
	self._dragGO = gohelper.findChild(self.viewGO, "root/btn_Click")
	self._imageToken = gohelper.findChildImage(self.viewGO, "root/hero/has/#image_token")
	self._vxGetGO = gohelper.findChild(self.viewGO, "vx_get")
	self._dragHandle = nil
	self._entityId = nil
	self._clueItemList = nil
	self._ppContainer = nil
	self._ppItemList = nil
	self._ppMaxCount = nil
	self._dragOriginPos = nil
	self._dragStartLocalPos = nil

	gohelper.setActive(self._clueTemplate, false)
	gohelper.setActive(self._vxGetGO, false)

	local tokenBgImage = self._tokenGO:GetComponent(gohelper.Type_Image)

	if tokenBgImage then
		tokenBgImage.enabled = false
	end
end

function FightYiFuLinMoveItemView:addEvents()
	return
end

function FightYiFuLinMoveItemView:removeEvents()
	if self._dragHandle then
		self._dragHandle:RemoveDragBeginListener()
		self._dragHandle:RemoveDragListener()
		self._dragHandle:RemoveDragEndListener()

		self._dragHandle = nil
	end
end

function FightYiFuLinMoveItemView:onConstructor(index, parentView)
	self.cellIndex = index
	self._parentView = parentView
end

function FightYiFuLinMoveItemView:onOpen()
	self._dragHandle = SLFramework.UGUI.UIDragListener.Get(self._dragGO)

	self._dragHandle:AddDragBeginListener(self._onDragBegin, self)
	self._dragHandle:AddDragListener(self._onDrag, self)
	self._dragHandle:AddDragEndListener(self._onDragEnd, self)
end

function FightYiFuLinMoveItemView:refreshItem(position, entityId)
	if self._txtIndex then
		self._txtIndex.text = tostring(position)
	end

	self._entityId = entityId

	local entityMO = entityId and FightDataHelper.entityMgr:getById(entityId)

	if entityMO then
		gohelper.setActive(self._heroHasGO, true)
		gohelper.setActive(self._heroEmptyGO, false)
		self:_refreshHeadIcon(entityMO)

		local showImageToken = false

		for i = 1, #lua_fight_move_clue.configList do
			local config = lua_fight_move_clue.configList[i]

			if config.heroId == entityMO.modelId and config.facetsId == entityMO.destinyStone then
				gohelper.setActive(self._imageToken.gameObject, true)
				UISpriteSetMgr.instance:setFightSprite(self._imageToken, config.icon)

				showImageToken = true

				break
			end
		end

		if not showImageToken then
			gohelper.setActive(self._imageToken.gameObject, false)
		end
	else
		gohelper.setActive(self._imageToken.gameObject, false)
		gohelper.setActive(self._heroHasGO, false)
		gohelper.setActive(self._heroEmptyGO, true)
	end

	local clueList = self:_getPositionClueList(position)
	local matchedIndices = self:_calcClueMatch(entityMO, clueList)
	local effectCount = self:_calcMatchEffectCount(entityMO, #matchedIndices)
	local loopClueSet = {}

	for k = 1, effectCount do
		loopClueSet[matchedIndices[k]] = true
	end

	self:_refreshPassionPoint(entityMO, effectCount)
	self:_refreshClueList(clueList, loopClueSet)
	gohelper.setActive(self._vxGetGO, effectCount > 0)

	if effectCount > 0 then
		AudioMgr.instance:trigger(410064)
	end

	self.hasMatch = effectCount > 0
end

function FightYiFuLinMoveItemView:_refreshHeadIcon(entityMO)
	local skinConfig = FightConfig.instance:getSkinCO(entityMO.skin)

	if not skinConfig then
		return
	end

	local url = ""

	if entityMO:isEnemySide() then
		url = ResUrl.monsterHeadIcon(skinConfig.headIcon)
	else
		url = ResUrl.getHeadIconSmall(skinConfig.retangleIcon)
	end

	self._cardIcon:LoadImage(url)
end

function FightYiFuLinMoveItemView:_getPositionClueList(position)
	local clueArea = FightDataHelper.getClueArea(FightEnum.TeamType.MySide)
	local positionData = clueArea and clueArea:getPositionData(position)

	return positionData and positionData.clues or {}
end

function FightYiFuLinMoveItemView:_refreshClueList(clueList, loopClueSet)
	gohelper.setActive(self._tokenGO, #clueList > 0)

	self._clueItemList = self._clueItemList or {}

	for i, clueData in ipairs(clueList) do
		local item = self._clueItemList[i]

		if not item then
			item = self:_createClueItem(i)
			self._clueItemList[i] = item
		end

		gohelper.setActive(item.go, true)

		local clueCo = lua_fight_move_clue.configDict[clueData.clueId]

		if clueCo then
			UISpriteSetMgr.instance:setFightSprite(item.image, clueCo.icon)
		end

		if item.animator then
			if loopClueSet and loopClueSet[i] then
				item.animator:Play("loop", 0, 0)
			else
				item.animator:Play("idle", 0, 0)
			end
		end
	end

	for i = #clueList + 1, #self._clueItemList do
		gohelper.setActive(self._clueItemList[i].go, false)
	end
end

function FightYiFuLinMoveItemView:_calcClueMatch(entityMO, clueList)
	local matchedIndices = {}

	if not entityMO then
		return matchedIndices
	end

	for i, clueData in ipairs(clueList) do
		local clueCo = lua_fight_move_clue.configDict[clueData.clueId]

		if clueCo and clueCo.heroId == entityMO.modelId and clueCo.facetsId == entityMO.destinyStone then
			matchedIndices[#matchedIndices + 1] = i
		end
	end

	return matchedIndices
end

function FightYiFuLinMoveItemView:_calcMatchEffectCount(entityMO, matchedCount)
	if not entityMO or matchedCount <= 0 then
		return 0
	end

	if entityMO.exPointType ~= FightEnum.ExPointType.Clue then
		return 0
	end

	local space = entityMO:getMaxExPoint() - entityMO:getExPoint()

	if space <= 0 then
		return 0
	end

	return math.min(matchedCount, space)
end

function FightYiFuLinMoveItemView:_createClueItem(index)
	local go = gohelper.clone(self._clueTemplate, self._tokenGO, "clue" .. index)

	return {
		go = go,
		image = go:GetComponent(gohelper.Type_Image),
		animator = go:GetComponent(gohelper.Type_Animator)
	}
end

function FightYiFuLinMoveItemView:_refreshPassionPoint(entityMO, previewCount)
	if not entityMO or entityMO.exPointType ~= FightEnum.ExPointType.Clue then
		self:_clearPassionPoint()

		return
	end

	self:_ensurePassionPointRes()

	if not self._ppContainer then
		return
	end

	gohelper.setActive(self._ppContainer, true)

	local max = entityMO:getMaxExPoint()
	local cur = entityMO:getExPoint()

	self._ppItemList = self._ppItemList or {}

	if self._ppMaxCount ~= max then
		for i = 1, max do
			local item = self._ppItemList[i]

			if not item then
				item = self:_createPassionPointItem(i)
				self._ppItemList[i] = item
			end

			gohelper.setActive(item.go, true)
		end

		for i = max + 1, #self._ppItemList do
			gohelper.setActive(self._ppItemList[i].go, false)
		end

		recthelper.setAnchorX(self._passionPointGO.transform, -(max - 1) * FightYiFuLinMoveItemView.ItemSpacingX / 2)

		self._ppMaxCount = max
	end

	previewCount = previewCount or 0

	for i = 1, max do
		local item = self._ppItemList[i]

		if item then
			if i <= cur then
				item.animator:Play("get", 0, 1)
			elseif i <= cur + previewCount then
				item.animator:Play("canuse", 0, 0)
			else
				item.animator:Play("in", 0, 1)
			end
		end
	end
end

function FightYiFuLinMoveItemView:_ensurePassionPointRes()
	if self._ppContainer then
		return
	end

	local setting = self.viewContainer and self.viewContainer:getSetting()
	local ppPath = setting and setting.otherRes and setting.otherRes[2]

	if not ppPath then
		return
	end

	local ppGO = self:getResInst(ppPath, self._passionPointGO, "specialpassionpoint")

	transformhelper.setLocalPos(ppGO.transform, 0, 0, 0)

	self._ppContainer = ppGO
	self._ppDownTemplate = gohelper.findChild(ppGO, "down")
	self._ppUpTemplate = gohelper.findChild(ppGO, "up")

	gohelper.setActive(self._ppDownTemplate, false)
	gohelper.setActive(self._ppUpTemplate, false)
end

function FightYiFuLinMoveItemView:_createPassionPointItem(index)
	local template = index % 2 == 1 and self._ppDownTemplate or self._ppUpTemplate
	local go = gohelper.clone(template, self._ppContainer, index)

	transformhelper.setLocalPos(go.transform, (index - 1) * FightYiFuLinMoveItemView.ItemSpacingX, 0, 0)

	return {
		go = go,
		animator = go:GetComponent(gohelper.Type_Animator)
	}
end

function FightYiFuLinMoveItemView:_clearPassionPoint()
	if self._ppContainer then
		gohelper.setActive(self._ppContainer, false)
	end

	if self._ppItemList then
		for _, item in ipairs(self._ppItemList) do
			gohelper.setActive(item.go, false)
		end
	end

	self._ppMaxCount = nil
end

function FightYiFuLinMoveItemView:_onDragBegin(param, pointerEventData)
	local lp = self._rootGO.transform.localPosition

	self._dragOriginPos = {
		x = lp.x,
		y = lp.y,
		z = lp.z
	}
	self._dragStartLocalPos = self:_screenToParentLocal(pointerEventData.position)

	if self._parentView then
		self._parentView:onItemDragBegin(self.cellIndex)
	end
end

function FightYiFuLinMoveItemView:_onDrag(param, pointerEventData)
	if not self._dragOriginPos or not self._dragStartLocalPos then
		return
	end

	local curLocal = self:_screenToParentLocal(pointerEventData.position)

	if not curLocal then
		return
	end

	local dx = curLocal.x - self._dragStartLocalPos.x

	transformhelper.setLocalPos(self._rootGO.transform, self._dragOriginPos.x + dx, self._dragOriginPos.y, self._dragOriginPos.z)
end

function FightYiFuLinMoveItemView:_onDragEnd(param, pointerEventData)
	if self._dragOriginPos then
		transformhelper.setLocalPos(self._rootGO.transform, self._dragOriginPos.x, self._dragOriginPos.y, self._dragOriginPos.z)
	end

	self._dragOriginPos = nil
	self._dragStartLocalPos = nil

	if self._parentView then
		self._parentView:onItemDragEnd(self.cellIndex, pointerEventData)
	end
end

function FightYiFuLinMoveItemView:_screenToParentLocal(screenPos)
	local uiCamera = CameraMgr.instance:getUICamera()
	local parentTr = self.viewGO.transform
	local localPos = Vector2.zero
	local isRect, localPos = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(parentTr, screenPos, uiCamera, localPos)

	if not isRect then
		return nil
	end

	return localPos
end

function FightYiFuLinMoveItemView:getIndex()
	return self.cellIndex
end

function FightYiFuLinMoveItemView:getEntityId()
	return self._entityId
end

function FightYiFuLinMoveItemView:getRectTransform()
	return self.viewGO:GetComponent(gohelper.Type_RectTransform)
end

function FightYiFuLinMoveItemView:onClose()
	return
end

function FightYiFuLinMoveItemView:onDestroyView()
	if self._cardIcon then
		self._cardIcon:UnLoadImage()
	end

	self._clueItemList = nil
	self._ppItemList = nil
	self._ppContainer = nil
	self._ppMaxCount = nil
end

return FightYiFuLinMoveItemView
