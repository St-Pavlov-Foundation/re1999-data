-- chunkname: @modules/logic/voice/VoiceChooseModel.lua

module("modules.logic.voice.VoiceChooseModel", package.seeall)

local VoiceChooseModel = class("VoiceChooseModel", ListScrollModel)

function VoiceChooseModel:initModel(chooseLang)
	local supportLangList = HotUpdateVoiceMgr.instance:getSupportVoiceLangs()
	local list = {}
	local optionalUpdateInst = SLFramework.GameUpdate.OptionalUpdate.Instance

	for i = 1, #supportLangList do
		local lang = supportLangList[i]
		local defaultLang = GameConfig:GetDefaultVoiceShortcut()
		local localVersion = optionalUpdateInst:GetLocalVersion(lang)

		if lang == defaultLang then
			table.insert(list, 1, {
				lang = lang,
				choose = lang == chooseLang
			})
		elseif not string.nilorempty(localVersion) then
			table.insert(list, {
				lang = lang,
				choose = lang == chooseLang
			})
		end
	end

	self:setList(list)
end

function VoiceChooseModel:getChoose()
	local list = self:getList()

	for _, mo in ipairs(list) do
		if mo.choose then
			return mo.lang
		end
	end
end

function VoiceChooseModel:choose(lang)
	local list = self:getList()

	for _, mo in ipairs(list) do
		mo.choose = mo.lang == lang
	end

	self:onModelUpdate()
end

VoiceChooseModel.instance = VoiceChooseModel.New()

return VoiceChooseModel
