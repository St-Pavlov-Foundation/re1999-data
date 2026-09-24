-- chunkname: @modules/logic/college/view/other/CollegeStoryView.lua

module("modules.logic.college.view.other.CollegeStoryView", package.seeall)

local CollegeStoryView = class("CollegeStoryView", BaseView)

function CollegeStoryView:onInitView()
	self._btnFull = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_fullscreen")
	self._goHeadBg = gohelper.findChild(self.viewGO, "dialog/headbg")
	self._simageHead = gohelper.findChildSingleImage(self.viewGO, "dialog/#simage_Head")
	self._simageItem = gohelper.findChildSingleImage(self.viewGO, "dialog/#simage_Item")
	self._simageRoleLeft = gohelper.findChildSingleImage(self.viewGO, "roles/#simage_Role_Left")
	self._simageRoleRight = gohelper.findChildSingleImage(self.viewGO, "roles/#simage_Role_Right")
	self._txtname = gohelper.findChildTextMesh(self.viewGO, "dialog/#go_name/namelayout/#txt_namecn1")
	self._godialog = gohelper.findChild(self.viewGO, "dialog")
	self._btnSkip = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_skip")
	self._animLeft = gohelper.findComponentAnim(self._simageRoleLeft.gameObject)
	self._animRight = gohelper.findComponentAnim(self._simageRoleRight.gameObject)
end

function CollegeStoryView:addEvents()
	self._btnFull:AddClickListener(self._playNextStep, self)
	self._btnSkip:AddClickListener(self._skipStory, self)
end

function CollegeStoryView:removeEvents()
	self._btnFull:RemoveClickListener()
	self._btnSkip:RemoveClickListener()
end

function CollegeStoryView:onOpen()
	CollegeHelper.instance:setViewVisible(self.viewName, true)

	self._curStepIndex = 0
	self._txtComp = MonoHelper.addNoUpdateLuaComOnceToGo(self._godialog, TMPFadeIn)

	gohelper.setActive(self._simageHead, false)
	gohelper.setActive(self._goHeadBg, false)
	gohelper.setActive(self._simageRoleLeft, false)
	gohelper.setActive(self._simageRoleRight, false)
	gohelper.setActive(self._simageItem, false)
	self:_playNextStep()
end

function CollegeStoryView:onClickModalMask()
	self:_skipStory()
end

function CollegeStoryView:_skipStory()
	GameFacade.showMessageBox(MessageBoxIdDefine.StorySkipConfirm, MsgBoxEnum.BoxType.Yes_No, self.closeThis, nil, nil, self)
end

function CollegeStoryView:_playNextStep()
	if self._txtComp:isPlaying() then
		self._txtComp:conFinished()
		self:_onTalkEnd()

		return
	end

	self._curStepIndex = self._curStepIndex + 1

	local step = self.viewParam.steps[self._curStepIndex]

	if not step then
		self:closeThis()

		return
	end

	local func = self["_playStep_type" .. step.type]

	if func then
		func(self, step)
	else
		logError("Unknown step type: " .. tostring(step.type))
	end
end

function CollegeStoryView:_playStep_type1(step)
	local preImage = self._curImage

	self._curAnim = nil

	if string.nilorempty(step.picture) then
		self._curImage = nil
	elseif self.viewParam.type == CollegeEnum.StoryType.ImageText2 then
		self._curImage = self._simageHead
	elseif step.position == "left" then
		self._curImage = self._simageRoleLeft
		self._curAnim = self._animLeft
	elseif step.position == "right" then
		self._curImage = self._simageRoleRight
		self._curAnim = self._animRight
	else
		self._curImage = nil
	end

	gohelper.setActive(self._goHeadBg, self._curImage == self._simageHead)
	gohelper.setActive(self._simageHead, self._curImage == self._simageHead)
	gohelper.setActive(self._simageRoleLeft, self._curImage == self._simageRoleLeft)
	gohelper.setActive(self._simageRoleRight, self._curImage == self._simageRoleRight)

	if preImage and preImage ~= self._curImage then
		preImage:UnLoadImage()
	end

	self._txtComp:playNormalText(step.desc, self._onTalkEnd, self)

	self._txtname.text = step.name

	if self._curImage then
		local pngPath = step.picture

		if self.viewParam.type == CollegeEnum.StoryType.ImageText2 then
			pngPath = ResUrl.getCollegeSingleBg(pngPath, "headicon_small")
		else
			pngPath = ResUrl.getCollegeSingleBg(pngPath, "headicon_middle")
		end

		self._curImage:LoadImage(pngPath, self._onImageLoaded, self)
	end

	if self._curAnim then
		self._curAnim:Play("talk", 0, 1)
	end
end

function CollegeStoryView:_onImageLoaded()
	if self.viewParam.type == CollegeEnum.StoryType.ImageText1 then
		self:reSizeImage(self._curImage)
	end
end

function CollegeStoryView:reSizeImage(img)
	if img and img.isActiveAndEnabled then
		self._imgDict = self._imgDict or self:getUserDataTb_()

		if not self._imgDict[img] then
			self._imgDict[img] = img:GetComponent(gohelper.Type_Image)
		end

		self._imgDict[img]:SetNativeSize()
	end
end

function CollegeStoryView:_playStep_type2(step)
	gohelper.setActive(self._simageItem, true)
	self._simageItem:LoadImage(ResUrl.getCollegeSingleBg(step.picture, "item"), self._onItemImageLoaded, self)

	if self._curAnim then
		self._curAnim:Play("quiet")
	end
end

function CollegeStoryView:_onItemImageLoaded()
	self:reSizeImage(self._simageItem)
end

function CollegeStoryView:_playStep_type3(step)
	gohelper.setActive(self._simageItem, false)

	if self._curAnim then
		self._curAnim:Play("talk")
	end
end

function CollegeStoryView:_onTalkEnd()
	return
end

function CollegeStoryView:onClose()
	CollegeHelper.instance:setViewVisible(self.viewName, false)
end

return CollegeStoryView
