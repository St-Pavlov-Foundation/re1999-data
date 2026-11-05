-- chunkname: @modules/logic/versionactivity4_1/act248/view/clue/Act248ClueInfo.lua

module("modules.logic.versionactivity4_1.act248.view.clue.Act248ClueInfo", package.seeall)

local Act248ClueInfo = class("Act248ClueInfo", BaseView)

function Act248ClueInfo:onInitView()
	self._goclueinfo1 = gohelper.findChild(self.viewGO, "#go_clueinfo1")
	self._simgpicture = gohelper.findChildSingleImage(self.viewGO, "#go_clueinfo1/#go_picture")
	self._goclueinfo2 = gohelper.findChild(self.viewGO, "#go_clueinfo2")
	self._goempty = gohelper.findChild(self.viewGO, "#go_empty")
	self._txtempty = gohelper.findChildText(self.viewGO, "#go_empty/txt_empty")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Act248ClueInfo:addEvents()
	return
end

function Act248ClueInfo:removeEvents()
	return
end

function Act248ClueInfo:_editableInitView()
	self._clueDetailItem1 = MonoHelper.addNoUpdateLuaComOnceToGo(self._goclueinfo1, Act248ClueDetailItem)
	self._clueDetailItem2 = MonoHelper.addNoUpdateLuaComOnceToGo(self._goclueinfo2, Act248ClueDetailItem)
	self._clueDetailItem1.viewContainer = self.viewContainer
	self._clueDetailItem2.viewContainer = self.viewContainer

	local emptyStr = "act248_clue_empty_1"

	if self.viewName == ViewName.Act248ClueMainView then
		emptyStr = "act248_clue_empty_2"
	end

	self._txtempty.text = luaLang(emptyStr)
end

function Act248ClueInfo:onUpdateParam()
	return
end

function Act248ClueInfo:onOpen()
	self._isInit = true

	self:refreshClue(self._showClueId)
end

function Act248ClueInfo:refreshClue(showClueId)
	self._showClueId = showClueId

	if not self._isInit then
		return
	end

	local clueMo = showClueId and Act248Model.instance:getClueById(showClueId)
	local hasClue = showClueId and showClueId > 0
	local hasImg

	if clueMo then
		local clueCo = clueMo and clueMo:getConfig()

		hasImg = clueCo and not string.nilorempty(clueCo.icon)

		if hasClue then
			if hasImg then
				self._clueDetailItem1:onUpdateMO(clueMo)
				self._simgpicture:LoadImage(clueMo:getIcon())
			else
				self._clueDetailItem2:onUpdateMO(clueMo)
			end
		end
	end

	gohelper.setActive(self._goclueinfo1, hasClue and hasImg)
	gohelper.setActive(self._goclueinfo2, hasClue and not hasImg)
	gohelper.setActive(self._goempty, not hasClue)
end

function Act248ClueInfo:refreshClueDetail()
	self._clueDetailItem1:refreshDesc()
	self._clueDetailItem2:refreshDesc()
end

function Act248ClueInfo:onClose()
	return
end

function Act248ClueInfo:onDestroyView()
	self._simgpicture:UnLoadImage()
end

return Act248ClueInfo
