-- chunkname: @modules/logic/fight/view/FightDeviceCardItem.lua

module("modules.logic.fight.view.FightDeviceCardItem", package.seeall)

local FightDeviceCardItem = class("FightDeviceCardItem", UserDataDispose)
local CardPath = "ui/viewres/fight/fight3_7devicecarditem.prefab"
local _initTypeId = 0

local function GetCardTypeId()
	_initTypeId = _initTypeId + 1

	return _initTypeId
end

FightDeviceCardItem.CardType = {
	PlayCard = GetCardTypeId(),
	WaitArea = GetCardTypeId(),
	SwitchCard = GetCardTypeId(),
	SwitchPlayCard = GetCardTypeId()
}

function FightDeviceCardItem.Create(goParent, cardType)
	local deviceItem = FightDeviceCardItem.New()

	deviceItem:init(goParent, cardType)

	return deviceItem
end

function FightDeviceCardItem:init(goParent, cardType)
	self:__onInit()

	self.goParent = goParent
	self.rectTrParent = goParent:GetComponent(gohelper.Type_RectTransform)
	self.cardType = cardType
	self.selectFrameActive = false
	self.scanLineActive = false
	self.scanSuccessActive = false
	self.scanFailActive = false
	self.loader = MultiAbLoader.New()

	self.loader:addPath(CardPath)
	self.loader:startLoad(self.onLoadedCallback, self)
end

function FightDeviceCardItem:onLoadedCallback()
	local assetItem = self.loader:getFirstAssetItem()

	self.go = gohelper.clone(assetItem:GetResource(), self.goParent)
	self.rectTr = self.go:GetComponent(gohelper.Type_RectTransform)
	self.height = recthelper.getHeight(self.rectTr)

	self:initViews()
	self:setName(self.name)
	self:afterLoadDone()
end

function FightDeviceCardItem:afterLoadDone()
	return
end

local LockTextPathList = {
	"seal/ani/txtLockName",
	"seal/notani/txtLockName",
	"sealing/ani/txtLockName",
	"sealing/notani/txtLockName",
	"unseal/ani/txtLockName"
}

function FightDeviceCardItem:initViews()
	self.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(self.go)
	self.goNormal = gohelper.findChild(self.go, "normal")
	self.goNormalSelect = gohelper.findChild(self.goNormal, "go_select")
	self.normalImageIcon = gohelper.findChildSingleImage(self.goNormal, "imgIcon")
	self.normalImageCardCover = gohelper.findChildImage(self.goNormal, "#image_cardCareer")
	self.tagIcon = gohelper.findChildSingleImage(self.goNormal, "tag/tagIcon")
	self.imageCareerBg = gohelper.findChildImage(self.goNormal, "cost/#image_numCareer")
	self.txtPower = gohelper.findChildText(self.goNormal, "cost/#txt_enough")
	self.goNormalGrayMask = gohelper.findChild(self.goNormal, "gray_mask")
	self.goNormalLock = gohelper.findChild(self.goNormal, "lock")
	self.txtLockList = self:getUserDataTb_()

	for _, path in ipairs(LockTextPathList) do
		table.insert(self.txtLockList, gohelper.findChildText(self.goNormalLock, "anim/" .. path))
	end

	self.goUnique = gohelper.findChild(self.go, "unique")
	self.goUniqueSelect = gohelper.findChild(self.goUnique, "go_select")
	self.uniqueImageIcon = gohelper.findChildSingleImage(self.goUnique, "imgIcon")
	self.goUniqueGrayMask = gohelper.findChild(self.goUnique, "gray_mask")
	self.goUniqueLock = gohelper.findChild(self.goUnique, "lock")

	for _, path in ipairs(LockTextPathList) do
		table.insert(self.txtLockList, gohelper.findChildText(self.goUniqueLock, "anim/" .. path))
	end

	self.goScanSuccess = gohelper.findChild(self.go, "success")
	self.goScanFail = gohelper.findChild(self.go, "fail")
	self.goScanLine = gohelper.findChild(self.go, "scanline")
	self.rectScanLine = self.goScanLine:GetComponent(gohelper.Type_RectTransform)
	self.goMask = gohelper.findChild(self.go, "normal/mask")

	gohelper.setActive(self.goMask, false)

	self.loadedDone = true

	self:setSelectFrameActive(self.selectFrameActive)
	self:setScanLineActive(self.scanLineActive)
	self:setScanSuccessActive(self.scanSuccessActive)
	self:setScanFailActive(self.scanFailActive)
	self:setLockActive(self.lockActive)
	self:setGrayMaskActive(self.grayMaskActive)
end

function FightDeviceCardItem:setGrayMaskActive(active)
	self.grayMaskActive = active

	if not self.loadedDone then
		return
	end

	gohelper.setActive(self.goNormalGrayMask, active)
	gohelper.setActive(self.goUniqueGrayMask, active)
end

function FightDeviceCardItem:setLockActive(active)
	self.lockActive = active

	if not self.loadedDone then
		return
	end

	gohelper.setActive(self.goUniqueLock, active)
	gohelper.setActive(self.goNormalLock, active)
end

function FightDeviceCardItem:setLockText(text)
	if not self.loadedDone then
		return
	end

	for _, txt in ipairs(self.txtLockList) do
		txt.text = text
	end
end

function FightDeviceCardItem:playLockAnim(animName, animDoneCallback, animDoneCallbackObj)
	if not self.loadedDone then
		return
	end

	if not self.skillCo then
		return
	end

	self.animDoneCallback = animDoneCallback
	self.animDoneCallbackObj = animDoneCallbackObj

	self:setLockActive(true)

	local animGo

	if self.isBigSkill then
		animGo = gohelper.findChild(self.goUniqueLock, "anim")
	else
		animGo = gohelper.findChild(self.goNormalLock, "anim")
	end

	local animComp = animGo and ZProj.ProjAnimatorPlayer.Get(animGo)

	if animComp then
		animComp:Play(animName, self.playLockAnimDone, self)
	end
end

function FightDeviceCardItem:playLockAnimDone()
	local animDoneCallback = self.animDoneCallback
	local animDoneCallbackObj = self.animDoneCallbackObj

	self.animDoneCallback = nil
	self.animDoneCallbackObj = nil

	if animDoneCallback then
		animDoneCallback(animDoneCallbackObj)
	end
end

function FightDeviceCardItem:hide()
	if self.loadedDone then
		gohelper.setActive(self.go, false)
	end
end

function FightDeviceCardItem:show()
	if self.loadedDone then
		gohelper.setActive(self.go, true)
	end
end

function FightDeviceCardItem:refreshUI(deviceSkillInfo)
	if not self.loadedDone then
		return
	end

	if not deviceSkillInfo then
		return
	end

	self.deviceSkillInfo = deviceSkillInfo

	local skillCo = lua_skill.configDict[deviceSkillInfo.skillId]
	local isBigSkill = skillCo.isBigSkill == 1

	self.skillCo = skillCo
	self.isBigSkill = isBigSkill

	gohelper.setActive(self.goNormal, not isBigSkill)
	gohelper.setActive(self.goUnique, isBigSkill)

	local targetIconUrl = ResUrl.getSkillIcon(skillCo.icon)

	if isBigSkill then
		self.uniqueImageIcon:LoadImage(targetIconUrl)
	else
		self.normalImageIcon:LoadImage(targetIconUrl)

		local tagUrl = ResUrl.getAttributeIcon("attribute_" .. skillCo.showTag)

		self.tagIcon:LoadImage(tagUrl)
		UISpriteSetMgr.instance:setFightSprite(self.imageCareerBg, FightDeviceHelper.getCareerImage(deviceSkillInfo.costType))

		self.txtPower.text = deviceSkillInfo.costValue

		UISpriteSetMgr.instance:setFightSprite(self.normalImageCardCover, FightDeviceHelper.getCareerCoverImage(deviceSkillInfo.costType))
	end
end

function FightDeviceCardItem:getDeviceSkillInfo()
	return self.deviceSkillInfo
end

function FightDeviceCardItem:getSkillCo()
	return self.skillCo
end

function FightDeviceCardItem:setName(name)
	if string.nilorempty(name) then
		name = "device_card_item"
	end

	self.name = name

	if not self.loadedDone then
		return
	end

	self.go.name = name
end

function FightDeviceCardItem:setSelectFrameActive(active)
	self.selectFrameActive = active

	if not self.loadedDone then
		return
	end

	gohelper.setActive(self.goNormalSelect, active)
	gohelper.setActive(self.goUniqueSelect, active)
end

function FightDeviceCardItem:setScanLineActive(active)
	self.scanLineActive = active

	if not self.loadedDone then
		return
	end

	gohelper.setActive(self.goScanLine, false)
end

function FightDeviceCardItem:setScanSuccessActive(active)
	self.scanSuccessActive = active

	if not self.loadedDone then
		return
	end

	gohelper.setActive(self.goScanSuccess, active)
end

function FightDeviceCardItem:setScanFailActive(active)
	self.scanFailActive = active

	if not self.loadedDone then
		return
	end

	gohelper.setActive(self.goScanFail, active)
end

function FightDeviceCardItem:getRectTr()
	return self.rectTr
end

function FightDeviceCardItem:playAnim(animName, callback, callbackObj)
	if self.animatorPlayer then
		self.animatorPlayer:Play(animName, callback, callbackObj)
	end
end

function FightDeviceCardItem:dispose()
	self.animDoneCallback = nil
	self.animDoneCallbackObj = nil

	if self.loader then
		self.loader:dispose()

		self.loader = nil
	end

	if self.tagIcon then
		self.tagIcon:UnLoadImage()

		self.tagIcon = nil
	end

	if self.normalImageIcon then
		self.normalImageIcon:UnLoadImage()

		self.normalImageIcon = nil
	end

	if self.uniqueImageIcon then
		self.uniqueImageIcon:UnLoadImage()

		self.uniqueImageIcon = nil
	end

	self:__onDispose()
end

return FightDeviceCardItem
