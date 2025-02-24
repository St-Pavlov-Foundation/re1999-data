module("modules.logic.rouge.dlc.103.view.RougeMapView_1_103", package.seeall)

slot0 = class("RougeMapView_1_103", BaseViewExtended)

function slot0.onInitView(slot0)
	slot0._godistotrule = gohelper.findChild(slot0.viewGO, "Left/#go_distortrule")
	slot0._godistotrule2 = gohelper.findChild(slot0.viewGO, "#go_layer_right/#go_rougedistortrule")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.onOpen(slot0)
	slot0:openSubView(RougeMapAttributeComp, nil, slot0._godistotrule)
	slot0:openSubView(RougeMapBossCollectionComp, nil, slot0._godistotrule2)
end

function slot0.onClose(slot0)
end

return slot0
