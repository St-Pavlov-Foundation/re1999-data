-- chunkname: @modules/logic/gm/model/GMActivityStatusModel.lua

module("modules.logic.gm.model.GMActivityStatusModel", package.seeall)

local GMActivityStatusModel = class("GMActivityStatusModel", ListScrollModel)

function GMActivityStatusModel:ctor()
	GMActivityStatusModel.super.ctor(self)

	self.showOpBtn = true
	self.idReverse = false
	self.search = ""
end

function GMActivityStatusModel:reInit()
	self._hasInit = nil
end

function GMActivityStatusModel:onClickShowOpBtn()
	self.showOpBtn = not self.showOpBtn

	self:updateModel()
end

function GMActivityStatusModel:onClickReverse()
	self.idReverse = not self.idReverse

	self:reInit()
	self:updateModel()
end

function GMActivityStatusModel:setSearch(text)
	self.search = text or ""

	self:reInit()
	self:updateModel()
end

function GMActivityStatusModel:getSearch()
	return self.search
end

function GMActivityStatusModel:updateModel()
	if not self._hasInit then
		self._hasInit = true

		local list = {}
		local activityInfo = ActivityModel.instance:getActivityInfo()

		for actId, actInfo in pairs(activityInfo) do
			local actCo = actInfo.config or ActivityConfig.instance:getActivityCo(actId)
			local name = actCo and (actCo.name or actCo.nameEn) or ""
			local search = self.search
			local match = search == "" or string.find(tostring(actId), search, 1, true) or string.find(tostring(name), search, 1, true)

			if match then
				table.insert(list, {
					id = actId,
					config = actCo
				})
			end
		end

		table.sort(list, function(a, b)
			return a.id < b.id
		end)

		if self.idReverse then
			tabletool.revert(list)
		end

		self:setList(list)
	else
		self:onModelUpdate()
	end
end

GMActivityStatusModel.instance = GMActivityStatusModel.New()

return GMActivityStatusModel
