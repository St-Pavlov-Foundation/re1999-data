module("modules.logic.activity.view.LinkageActivity_BaseViewContainer", package.seeall)

slot0 = class("LinkageActivity_BaseViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	assert(false, "please override this function")
end

function slot0.view(slot0)
	assert(false, "please override this function")
end

function slot0.switchPage(slot0, slot1)
	slot0:view():selectedPage(slot1)
end

function slot0.itemCo2TIQ(slot0, slot1)
	if string.nilorempty(slot1) then
		return
	end

	assert(#string.split(slot1, "#") >= 2, "[LinkageActivity_BaseViewContainer] invalid itemCo=" .. tostring(slot1))

	slot3 = string.split(slot1, "#")

	return tonumber(slot3[1]), tonumber(slot3[2]), tonumber(slot3[3])
end

function slot0.getItemConfig(slot0, slot1, slot2)
	slot3 = ItemConfigGetDefine.instance:getItemConfigFunc(slot1)

	assert(slot3, "[LinkageActivity_BaseViewContainer] ItemIconGetDefine-getItemConfigFunc unsupported materialType: " .. tostring(slot1))

	slot4 = slot3(slot2)

	assert(slot4, "[LinkageActivity_BaseViewContainer] item config not found materialType=" .. tostring(slot1) .. " id=" .. tostring(slot2))

	return slot4
end

function slot0.getItemIconResUrl(slot0, slot1, slot2)
	if not slot1 or not slot2 then
		return ""
	end

	slot3 = ItemIconGetDefine.instance:getItemIconFunc(slot1)

	assert(slot3, "[LinkageActivity_BaseViewContainer] ItemIconGetDefine-getItemIconFunc unsupported materialType: " .. tostring(slot1))

	return slot3(slot0:getItemConfig(slot1, slot2)) or ""
end

function slot0.getAssetItem_VideoLoadingPng(slot0)
	return slot0:getRes(slot0._viewSetting.otherRes[1])
end

function slot0.Vxax_LinkageActivity_xxxView_Container(slot0, slot1)
	function slot0.buildViews(slot0)
		slot0._view = uv0.New()

		return {
			slot0._view
		}
	end

	function slot0.view(slot0)
		return slot0._view
	end
end

function slot0.Vxax_LinkageActivity_FullView(slot0, slot1, slot2)
end

function slot0.Vxax_LinkageActivity_PanelView(slot0, slot1, slot2)
end

function slot1(slot0)
	return _G[string.format(slot0, GameBranchMgr.instance:getMajorVer(), GameBranchMgr.instance:getMinorVer())]
end

function slot0.Vxax_LinkageActivity_FullView_ContainerImpl()
	return uv0("V%sa%s_LinkageActivity_FullViewContainer")
end

function slot0.Vxax_LinkageActivity_PanelView_ContainerImpl()
	return uv0("V%sa%s_LinkageActivity_PanelViewContainer")
end

return slot0
