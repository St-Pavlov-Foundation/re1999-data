-- chunkname: @modules/logic/versionactivity4_1/library/scene/comp/V4a1_LibrarySceneBgmComp.lua

module("modules.logic.versionactivity4_1.library.scene.comp.V4a1_LibrarySceneBgmComp", package.seeall)

local V4a1_LibrarySceneBgmComp = class("V4a1_LibrarySceneBgmComp", BaseSceneComp)

function V4a1_LibrarySceneBgmComp:onScenePrepared(sceneId, levelId)
	self:refreshBgm()
	self:addEventListeners()
end

function V4a1_LibrarySceneBgmComp:addEventListeners()
	return
end

function V4a1_LibrarySceneBgmComp:removeEventListeners()
	return
end

function V4a1_LibrarySceneBgmComp:_onChangeBg()
	self:refreshBgm()
end

function V4a1_LibrarySceneBgmComp:refreshBgm()
	local useBg = UdimoItemModel.instance:getUseBg()
	local bgmId = UdimoConfig.instance:getBgBgm(useBg)

	if not bgmId or self._curBgmId == bgmId then
		return
	end

	self._curBgmId = bgmId

	AudioBgmManager.instance:modifyAndPlay(AudioBgmEnum.Layer.Udimo, bgmId, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
end

function V4a1_LibrarySceneBgmComp:onSceneClose(sceneId, levelId)
	self:removeEventListeners()
end

return V4a1_LibrarySceneBgmComp
