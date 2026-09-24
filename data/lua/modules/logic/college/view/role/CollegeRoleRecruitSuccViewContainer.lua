-- chunkname: @modules/logic/college/view/role/CollegeRoleRecruitSuccViewContainer.lua

module("modules.logic.college.view.role.CollegeRoleRecruitSuccViewContainer", package.seeall)

local CollegeRoleRecruitSuccViewContainer = class("CollegeRoleRecruitSuccViewContainer", BaseViewContainer)

function CollegeRoleRecruitSuccViewContainer:buildViews()
	local views = {}

	table.insert(views, CollegeRoleRecruitSuccView.New())
	table.insert(views, CollegeCurrencyView.New("root/#go_righttop"))
	table.insert(views, CollegeVisibleBaseView.New())

	return views
end

return CollegeRoleRecruitSuccViewContainer
