-- chunkname: @modules/logic/assist/model/rpcmo/RoleBadgeRecordMo.lua

module("modules.logic.assist.model.rpcmo.RoleBadgeRecordMo", package.seeall)

local RoleBadgeRecordMo = pureTable("RoleBadgeRecordMo")

function RoleBadgeRecordMo:init(data)
	self.heroUid = data.heroUid

	self:updateWears(data.wears)

	self.badges, self.badgesMap = GameUtil.rpcInfosToListAndMap(data.badges, RoleBadgeMo, "id", self.badgesMap)

	table.sort(self.badges, function(a, b)
		if a.config.groupId == b.config.groupId then
			return a.config.level < b.config.level
		else
			return a.config.groupId < b.config.groupId
		end
	end)
end

function RoleBadgeRecordMo:updateBadge(data)
	if not self.heroUid then
		self.heroUid = data.heroUid

		self:updateWears(data.wears)
	end

	local newGroupMap = {}
	local finish = AssistEnum.BadgeStatus.Finish

	for _, badge in ipairs(data.badges) do
		local badgeMo = self:getBadgeMo(badge.id)

		if not badgeMo then
			badgeMo = RoleBadgeMo.New()
			self.badgesMap[badge.id] = badgeMo
			self.badges[#self.badges + 1] = badgeMo
		end

		local oldStatus = badgeMo.status

		badgeMo:init(badge)

		if badgeMo.status == finish and oldStatus ~= finish then
			newGroupMap[badgeMo.config.groupId] = true
		end
	end

	local heroMo = HeroModel.instance:getById(self.heroUid)

	for groupId in pairs(newGroupMap) do
		local groupCfg = RoleBadgeConfig.instance:getBadgeGroupCo(groupId)

		ToastController.instance:showToastWithIcon(ToastEnum.AssistRoleBadgeGet, nil, heroMo.heroName, groupCfg.groupTitle)
	end
end

function RoleBadgeRecordMo:updateWears(data)
	self.wears, self.wearsMap = GameUtil.rpcInfosToListAndMap(data, RoleBadgeWearMo, "position", self.wearsMap)
end

function RoleBadgeRecordMo:getBadgeMo(id)
	return self.badgesMap and self.badgesMap[id]
end

function RoleBadgeRecordMo:getWearMo(position)
	return self.wearsMap and self.wearsMap[position]
end

function RoleBadgeRecordMo:getWearPos(badgeId)
	for _, wearMo in ipairs(self.wears) do
		if wearMo.badgeId == badgeId then
			return wearMo.position
		end
	end
end

function RoleBadgeRecordMo:getWearCnt()
	local wearCount = 0

	for _, wearMo in ipairs(self.wears) do
		if wearMo.badgeId ~= 0 then
			wearCount = wearCount + 1
		end
	end

	return wearCount
end

function RoleBadgeRecordMo:getActiveBadgeCfg(groupId)
	for i = #self.badges, 1, -1 do
		local badgeMo = self.badges[i]
		local config = badgeMo.config

		if config.groupId == groupId and badgeMo.status == AssistEnum.BadgeStatus.Finish then
			return config
		end
	end
end

function RoleBadgeRecordMo:getFirstEmptyWearPos()
	if #self.wears == 0 then
		return 1
	end

	for i, wearMo in ipairs(self.wears) do
		if wearMo.badgeId == 0 then
			return i
		end
	end
end

return RoleBadgeRecordMo
