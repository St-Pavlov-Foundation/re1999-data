-- chunkname: @modules/logic/gm/view/periphery/GMSubViewPeriphery.lua

module("modules.logic.gm.view.periphery.GMSubViewPeriphery", package.seeall)

local GMSubViewPeriphery = class("GMSubViewPeriphery", GMSubViewBase)

function GMSubViewPeriphery:ctor()
	self.tabName = "活动外围玩法"
end

function GMSubViewPeriphery:addLineIndex()
	self.lineIndex = self.lineIndex + 1
end

function GMSubViewPeriphery:getLineGroup()
	return "L" .. self.lineIndex
end

function GMSubViewPeriphery:initViewContent()
	if self._inited then
		return
	end

	GMSubViewBase.initViewContent(self)

	self.lineIndex = 1

	self:addTitleSplitLine("4.1主活动外围--探案玩法")
	Act248Rpc.instance:sendAct248GetInfoRequest(Act248Model.instance:getActId(), self._initAct248UI, self)
end

local Act248SaveKey_selectAct248FileIndex = "Act248SaveKey_selectAct248FileIndex"
local Act248SaveKey_selectAct248ClueIndex = "Act248SaveKey_selectAct248ClueIndex"
local Act248SaveKey_ReportToggle = "Act248SaveKey_ReportToggle"
local Act248SaveKey_ShowClueId = "Act248SaveKey_ShowClueId"
local Act248SaveKey_ShowSlotId = "Act248SaveKey_ShowSlotId"

function GMSubViewPeriphery:_initAct248UI()
	self:addLabel(self:getLineGroup(), "当前活动Id：" .. Act248Model.instance:getActId(), {
		c = "#FF5C00"
	})
	self:addButton(self:getLineGroup(), "清空数据", self._clearAct248, self)
	self:addButton(self:getLineGroup(), "清除缓存", self._clearAct248Client, self)
	self:addLineIndex()
	self:addButton(self:getLineGroup(), "打开主界面", self._openAct248View, self)
	self:addButton(self:getLineGroup(), "打开avg交互界面", self._openAct248AvgView, self)
	self:addLineIndex()
	self:addLabel(self:getLineGroup(), "档案", {
		c = "#FF5C00"
	})

	self._act248DropFile = self:addDropDown(self:getLineGroup(), "档案ID：", nil, self._onAct248FileDropValueChange, self, {
		w = 500,
		tempH = 300
	})

	self:addButton(self:getLineGroup(), "解锁", self._setUnlockFile, self)
	self:addButton(self:getLineGroup(), "自动填入所有线索", self._autoFileFillClue, self)
	self:addLineIndex()
	self:addButton(self:getLineGroup(), "结案报告", self._openAct248ReportView, self)

	self._act248ReportToggle = self:addToggle(self:getLineGroup(), "是否完成", self._setFinishAct248Report, self)
	self._act248ReportToggle.isOn = PlayerPrefsHelper.getNumber(Act248SaveKey_ReportToggle, 0) == 1

	self:addLineIndex()
	self:addLabel(self:getLineGroup(), "线索", {
		c = "#FF102A"
	})

	self._act248Dropclue = self:addDropDown(self:getLineGroup(), "未解锁线索：", nil, self._onAct248ClueDropValueChange, self, {
		w = 500,
		tempH = 300
	})

	self:addButton(self:getLineGroup(), "解锁", self._setUnlockClue, self)
	self:addButton(self:getLineGroup(), "一键解锁", self._setAllUnlockClue, self)
	self:addLineIndex()

	self._act248ShowSlotIdToggle = self:addToggle(self:getLineGroup(), "显示槽位id", self._Act248ShowSlotId, self)
	self._act248ShowSlotIdToggle.isOn = PlayerPrefsHelper.getNumber(Act248SaveKey_ShowSlotId, 0) == 1
	self._act248ShowClueIdToggle = self:addToggle(self:getLineGroup(), "显示线索id", self._Act248ShowClueId, self)
	self._act248ShowClueIdToggle.isOn = PlayerPrefsHelper.getNumber(Act248SaveKey_ShowClueId, 0) == 1

	self:_initAct248FileDrop()
	self:_initAct248ClueDrop()
end

function GMSubViewPeriphery:_openAct248View()
	Act248Controller.instance:openAct248EnterView()
end

function GMSubViewPeriphery:_clearAct248()
	local actId = Act248Model.instance:getActId()
	local info = string.format("clearAct248All %s", actId)

	Act248Model.instance:reInit()
	GMRpc.instance:sendGMRequest(info)
	GameFacade.showToast(ToastEnum.IconId, info)
	self:_initAct248ClueDrop()
	self:_clearAct248Client()
end

function GMSubViewPeriphery:_clearAct248Client()
	Act248Model.instance:clearAct248Client()
end

function GMSubViewPeriphery:_initAct248FileDrop()
	local model = Act248Model.instance:getFileModel()

	self._fileIds = {}

	local options = {}

	for _, mo in ipairs(model:getList()) do
		local str = mo.id .. "  " .. mo:getConfig().name

		table.insert(options, str)
		table.insert(self._fileIds, mo.id)
	end

	self._selectAct248FileIndex = PlayerPrefsHelper.getNumber(Act248SaveKey_selectAct248FileIndex, 1)

	if self._act248DropFile then
		self._act248DropFile:ClearOptions()
		self._act248DropFile:AddOptions(options)
		self._act248DropFile:SetValue(self._selectAct248FileIndex - 1)
	end
end

function GMSubViewPeriphery:_autoFileFillClue()
	local fileId = self._fileIds[self._selectAct248FileIndex]

	if fileId then
		local fileMo = Act248Model.instance:getFileById(fileId)

		if fileMo then
			local slotMos = fileMo:getSlotMos()
			local clueIds = {}

			for _, mo in ipairs(slotMos) do
				local mos = mo:getMos()

				for _, _mo in ipairs(mos) do
					local clue = _mo:getConfig().clueId

					_mo:setFillClueId(clue)

					clueIds[_mo.id] = clue
				end
			end

			if clueIds then
				Act248Rpc.instance:sendAct248FillClueRequest(fileId, clueIds, function()
					GameFacade.showToast(ToastEnum.IconId, "线索自动填入")
				end)
			end
		end
	end
end

function GMSubViewPeriphery:_onAct248FileDropValueChange(index)
	self._selectAct248FileIndex = index + 1

	PlayerPrefsHelper.setNumber(Act248SaveKey_selectAct248FileIndex, self._selectAct248FileIndex)
end

function GMSubViewPeriphery:_setUnlockFile()
	local fileId = self._fileIds[self._selectAct248FileIndex]

	if fileId then
		local actId = Act248Model.instance:getActId()
		local info = string.format("unlockAct248File %s %s", actId, fileId)

		GMRpc.instance:sendGMRequest(info)
		GameFacade.showToast(ToastEnum.IconId, info)
	end
end

function GMSubViewPeriphery:_initAct248ClueDrop()
	local model = Act248Model.instance:getClueModel()

	self._clueIds = {}

	local options = {}

	for _, mo in ipairs(model:getList()) do
		if not mo:isUnlock() then
			local str = mo.id .. "  " .. mo:getConfig().name

			table.insert(options, str)
			table.insert(self._clueIds, mo.id)
		end
	end

	self._selectAct248ClueIndex = PlayerPrefsHelper.getNumber(Act248SaveKey_selectAct248ClueIndex, 1)

	if self._act248Dropclue then
		self._act248Dropclue:ClearOptions()
		self._act248Dropclue:AddOptions(options)
		self._act248Dropclue:SetValue(self._selectAct248ClueIndex - 1)
	end
end

function GMSubViewPeriphery:_onAct248ClueDropValueChange(index)
	self._selectAct248ClueIndex = index + 1

	PlayerPrefsHelper.setNumber(Act248SaveKey_selectAct248ClueIndex, self._selectAct248ClueIndex)
end

function GMSubViewPeriphery:_setUnlockClue()
	local clueId = self._clueIds[self._selectAct248ClueIndex]

	if clueId then
		local actId = Act248Model.instance:getActId()
		local info = string.format("unlockAct248Clue %s %s", actId, clueId)

		GMRpc.instance:sendGMRequest(info)
		GameFacade.showToast(ToastEnum.IconId, info)
	end
end

function GMSubViewPeriphery:_setAllUnlockClue()
	if self._clueIds then
		for _, id in ipairs(self._clueIds) do
			local actId = Act248Model.instance:getActId()
			local info = string.format("unlockAct248Clue %s %s", actId, id)

			GMRpc.instance:sendGMRequest(info)
		end

		GameFacade.showToast(ToastEnum.IconId, "一键解锁完成")
	end
end

function GMSubViewPeriphery:_openAct248ReportView()
	local isFinish = self._act248ReportToggle.isOn
	local fileId = self._fileIds[self._selectAct248FileIndex]

	Act248Controller.instance:openAct248ReportView(fileId, not isFinish)
end

function GMSubViewPeriphery:_setFinishAct248Report()
	PlayerPrefsHelper.setNumber(Act248SaveKey_ReportToggle, self._act248ReportToggle.isOn and 1 or 0)
end

function GMSubViewPeriphery:_openAct248AvgView()
	local storyId = Act248Model.instance:getAvgBeforeStoryId()

	Act248Controller.instance:openAct248AvgView(storyId)
end

function GMSubViewPeriphery:_Act248ShowClueId()
	local isOn = self._act248ShowClueIdToggle.isOn

	PlayerPrefsHelper.setNumber(Act248SaveKey_ShowClueId, isOn and 1 or 0)

	function Act248ClueCategoryChildItem._getClueName(SelfObj, ...)
		local co = SelfObj._mo:getConfig()

		if isOn then
			local color = "#FFFF00"

			if co.type == 1 then
				color = "red"
			elseif co.type == 1 then
				-- block empty
			end

			return string.format("<color=%s>%s  %s</color> %s", color, co.id, co.type, co.name)
		end

		return co.name
	end

	function Act248ClueCategoryChildItem._refreshLock(SelfObj, ...)
		if isOn then
			local co = SelfObj._mo:getConfig()
			local color = "#FFFF00"

			if co.type == 1 then
				color = "red"
			end

			SelfObj._txtlocked.text = string.format("<color=%s>%s  %s</color> ???", color, co.id, co.type)

			return
		end

		SelfObj._txtlocked.text = "???"
	end
end

function GMSubViewPeriphery:_Act248ShowSlotId()
	local isOn = self._act248ShowSlotIdToggle.isOn

	PlayerPrefsHelper.setNumber(Act248SaveKey_ShowSlotId, isOn and 1 or 0)

	function Act248ClueDecryptionView._getSlotTip(SelfObj, slotMo)
		local slotCo = slotMo:getConfig()
		local clueText = slotCo.tip
		local lang = luaLang("act248_clue_tip")
		local totalCount = #SelfObj._needTipSlotMos
		local tip = GameUtil.getSubPlaceholderLuaLangThreeParam(lang, SelfObj._cutTipIndex, totalCount, clueText)

		if isOn then
			local str = ""

			for _, mo in ipairs(SelfObj._needTipSlotMos) do
				local co = mo:getConfig()

				str = str .. string.format("<color=#FFFF00>%s（%s）</color>  ", co.id, co.clueId)
			end

			return str .. tip
		end

		return tip
	end
end

return GMSubViewPeriphery
