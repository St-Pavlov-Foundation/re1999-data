slot0 = require
slot1 = slot0("protobuf.protobuf")

module("modules.proto.ItemModule_pb", package.seeall)

slot2 = {
	MATERIALMODULE_PB = slot0("modules.proto.MaterialModule_pb"),
	USEPOWERITEMINFO_MSG = slot1.Descriptor(),
	USEPOWERITEMINFOUIDFIELD = slot1.FieldDescriptor(),
	USEPOWERITEMINFONUMFIELD = slot1.FieldDescriptor(),
	GETITEMLISTREQUEST_MSG = slot1.Descriptor(),
	USEINSIGHTITEMREQUEST_MSG = slot1.Descriptor(),
	USEINSIGHTITEMREQUESTUIDFIELD = slot1.FieldDescriptor(),
	USEINSIGHTITEMREQUESTHEROIDFIELD = slot1.FieldDescriptor(),
	ITEMCHANGEPUSH_MSG = slot1.Descriptor(),
	ITEMCHANGEPUSHITEMSFIELD = slot1.FieldDescriptor(),
	ITEMCHANGEPUSHPOWERITEMSFIELD = slot1.FieldDescriptor(),
	ITEMCHANGEPUSHINSIGHTITEMSFIELD = slot1.FieldDescriptor(),
	USEPOWERITEMREPLY_MSG = slot1.Descriptor(),
	USEPOWERITEMREPLYUIDFIELD = slot1.FieldDescriptor(),
	AUTOUSEEXPIREPOWERITEMREQUEST_MSG = slot1.Descriptor(),
	USEITEMREQUEST_MSG = slot1.Descriptor(),
	USEITEMREQUESTENTRYFIELD = slot1.FieldDescriptor(),
	USEITEMREQUESTTARGETIDFIELD = slot1.FieldDescriptor(),
	ITEM_MSG = slot1.Descriptor(),
	ITEMITEMIDFIELD = slot1.FieldDescriptor(),
	ITEMQUANTITYFIELD = slot1.FieldDescriptor(),
	ITEMLASTUSETIMEFIELD = slot1.FieldDescriptor(),
	ITEMLASTUPDATETIMEFIELD = slot1.FieldDescriptor(),
	USEPOWERITEMLISTREPLY_MSG = slot1.Descriptor(),
	USEPOWERITEMLISTREPLYUSEPOWERITEMINFOFIELD = slot1.FieldDescriptor(),
	POWERITEM_MSG = slot1.Descriptor(),
	POWERITEMUIDFIELD = slot1.FieldDescriptor(),
	POWERITEMITEMIDFIELD = slot1.FieldDescriptor(),
	POWERITEMQUANTITYFIELD = slot1.FieldDescriptor(),
	POWERITEMEXPIRETIMEFIELD = slot1.FieldDescriptor(),
	INSIGHTITEM_MSG = slot1.Descriptor(),
	INSIGHTITEMUIDFIELD = slot1.FieldDescriptor(),
	INSIGHTITEMITEMIDFIELD = slot1.FieldDescriptor(),
	INSIGHTITEMQUANTITYFIELD = slot1.FieldDescriptor(),
	INSIGHTITEMEXPIRETIMEFIELD = slot1.FieldDescriptor(),
	USEITEMREPLY_MSG = slot1.Descriptor(),
	USEITEMREPLYENTRYFIELD = slot1.FieldDescriptor(),
	USEITEMREPLYTARGETIDFIELD = slot1.FieldDescriptor(),
	USEPOWERITEMLISTREQUEST_MSG = slot1.Descriptor(),
	USEPOWERITEMLISTREQUESTUSEPOWERITEMINFOFIELD = slot1.FieldDescriptor(),
	MARKREADSUBTYPE21REPLY_MSG = slot1.Descriptor(),
	MARKREADSUBTYPE21REPLYITEMIDFIELD = slot1.FieldDescriptor(),
	AUTOUSEEXPIREPOWERITEMREPLY_MSG = slot1.Descriptor(),
	AUTOUSEEXPIREPOWERITEMREPLYUSEDFIELD = slot1.FieldDescriptor(),
	USEINSIGHTITEMREPLY_MSG = slot1.Descriptor(),
	USEINSIGHTITEMREPLYUIDFIELD = slot1.FieldDescriptor(),
	USEINSIGHTITEMREPLYHEROIDFIELD = slot1.FieldDescriptor(),
	MARKREADSUBTYPE21REQUEST_MSG = slot1.Descriptor(),
	MARKREADSUBTYPE21REQUESTITEMIDFIELD = slot1.FieldDescriptor(),
	GETITEMLISTREPLY_MSG = slot1.Descriptor(),
	GETITEMLISTREPLYITEMSFIELD = slot1.FieldDescriptor(),
	GETITEMLISTREPLYPOWERITEMSFIELD = slot1.FieldDescriptor(),
	GETITEMLISTREPLYINSIGHTITEMSFIELD = slot1.FieldDescriptor(),
	USEPOWERITEMREQUEST_MSG = slot1.Descriptor(),
	USEPOWERITEMREQUESTUIDFIELD = slot1.FieldDescriptor()
}
slot2.USEPOWERITEMINFOUIDFIELD.name = "uid"
slot2.USEPOWERITEMINFOUIDFIELD.full_name = ".UsePowerItemInfo.uid"
slot2.USEPOWERITEMINFOUIDFIELD.number = 1
slot2.USEPOWERITEMINFOUIDFIELD.index = 0
slot2.USEPOWERITEMINFOUIDFIELD.label = 1
slot2.USEPOWERITEMINFOUIDFIELD.has_default_value = false
slot2.USEPOWERITEMINFOUIDFIELD.default_value = 0
slot2.USEPOWERITEMINFOUIDFIELD.type = 3
slot2.USEPOWERITEMINFOUIDFIELD.cpp_type = 2
slot2.USEPOWERITEMINFONUMFIELD.name = "num"
slot2.USEPOWERITEMINFONUMFIELD.full_name = ".UsePowerItemInfo.num"
slot2.USEPOWERITEMINFONUMFIELD.number = 2
slot2.USEPOWERITEMINFONUMFIELD.index = 1
slot2.USEPOWERITEMINFONUMFIELD.label = 1
slot2.USEPOWERITEMINFONUMFIELD.has_default_value = false
slot2.USEPOWERITEMINFONUMFIELD.default_value = 0
slot2.USEPOWERITEMINFONUMFIELD.type = 5
slot2.USEPOWERITEMINFONUMFIELD.cpp_type = 1
slot2.USEPOWERITEMINFO_MSG.name = "UsePowerItemInfo"
slot2.USEPOWERITEMINFO_MSG.full_name = ".UsePowerItemInfo"
slot2.USEPOWERITEMINFO_MSG.nested_types = {}
slot2.USEPOWERITEMINFO_MSG.enum_types = {}
slot2.USEPOWERITEMINFO_MSG.fields = {
	slot2.USEPOWERITEMINFOUIDFIELD,
	slot2.USEPOWERITEMINFONUMFIELD
}
slot2.USEPOWERITEMINFO_MSG.is_extendable = false
slot2.USEPOWERITEMINFO_MSG.extensions = {}
slot2.GETITEMLISTREQUEST_MSG.name = "GetItemListRequest"
slot2.GETITEMLISTREQUEST_MSG.full_name = ".GetItemListRequest"
slot2.GETITEMLISTREQUEST_MSG.nested_types = {}
slot2.GETITEMLISTREQUEST_MSG.enum_types = {}
slot2.GETITEMLISTREQUEST_MSG.fields = {}
slot2.GETITEMLISTREQUEST_MSG.is_extendable = false
slot2.GETITEMLISTREQUEST_MSG.extensions = {}
slot2.USEINSIGHTITEMREQUESTUIDFIELD.name = "uid"
slot2.USEINSIGHTITEMREQUESTUIDFIELD.full_name = ".UseInsightItemRequest.uid"
slot2.USEINSIGHTITEMREQUESTUIDFIELD.number = 1
slot2.USEINSIGHTITEMREQUESTUIDFIELD.index = 0
slot2.USEINSIGHTITEMREQUESTUIDFIELD.label = 1
slot2.USEINSIGHTITEMREQUESTUIDFIELD.has_default_value = false
slot2.USEINSIGHTITEMREQUESTUIDFIELD.default_value = 0
slot2.USEINSIGHTITEMREQUESTUIDFIELD.type = 3
slot2.USEINSIGHTITEMREQUESTUIDFIELD.cpp_type = 2
slot2.USEINSIGHTITEMREQUESTHEROIDFIELD.name = "heroId"
slot2.USEINSIGHTITEMREQUESTHEROIDFIELD.full_name = ".UseInsightItemRequest.heroId"
slot2.USEINSIGHTITEMREQUESTHEROIDFIELD.number = 2
slot2.USEINSIGHTITEMREQUESTHEROIDFIELD.index = 1
slot2.USEINSIGHTITEMREQUESTHEROIDFIELD.label = 1
slot2.USEINSIGHTITEMREQUESTHEROIDFIELD.has_default_value = false
slot2.USEINSIGHTITEMREQUESTHEROIDFIELD.default_value = 0
slot2.USEINSIGHTITEMREQUESTHEROIDFIELD.type = 5
slot2.USEINSIGHTITEMREQUESTHEROIDFIELD.cpp_type = 1
slot2.USEINSIGHTITEMREQUEST_MSG.name = "UseInsightItemRequest"
slot2.USEINSIGHTITEMREQUEST_MSG.full_name = ".UseInsightItemRequest"
slot2.USEINSIGHTITEMREQUEST_MSG.nested_types = {}
slot2.USEINSIGHTITEMREQUEST_MSG.enum_types = {}
slot2.USEINSIGHTITEMREQUEST_MSG.fields = {
	slot2.USEINSIGHTITEMREQUESTUIDFIELD,
	slot2.USEINSIGHTITEMREQUESTHEROIDFIELD
}
slot2.USEINSIGHTITEMREQUEST_MSG.is_extendable = false
slot2.USEINSIGHTITEMREQUEST_MSG.extensions = {}
slot2.ITEMCHANGEPUSHITEMSFIELD.name = "items"
slot2.ITEMCHANGEPUSHITEMSFIELD.full_name = ".ItemChangePush.items"
slot2.ITEMCHANGEPUSHITEMSFIELD.number = 1
slot2.ITEMCHANGEPUSHITEMSFIELD.index = 0
slot2.ITEMCHANGEPUSHITEMSFIELD.label = 3
slot2.ITEMCHANGEPUSHITEMSFIELD.has_default_value = false
slot2.ITEMCHANGEPUSHITEMSFIELD.default_value = {}
slot2.ITEMCHANGEPUSHITEMSFIELD.message_type = slot2.ITEM_MSG
slot2.ITEMCHANGEPUSHITEMSFIELD.type = 11
slot2.ITEMCHANGEPUSHITEMSFIELD.cpp_type = 10
slot2.ITEMCHANGEPUSHPOWERITEMSFIELD.name = "powerItems"
slot2.ITEMCHANGEPUSHPOWERITEMSFIELD.full_name = ".ItemChangePush.powerItems"
slot2.ITEMCHANGEPUSHPOWERITEMSFIELD.number = 2
slot2.ITEMCHANGEPUSHPOWERITEMSFIELD.index = 1
slot2.ITEMCHANGEPUSHPOWERITEMSFIELD.label = 3
slot2.ITEMCHANGEPUSHPOWERITEMSFIELD.has_default_value = false
slot2.ITEMCHANGEPUSHPOWERITEMSFIELD.default_value = {}
slot2.ITEMCHANGEPUSHPOWERITEMSFIELD.message_type = slot2.POWERITEM_MSG
slot2.ITEMCHANGEPUSHPOWERITEMSFIELD.type = 11
slot2.ITEMCHANGEPUSHPOWERITEMSFIELD.cpp_type = 10
slot2.ITEMCHANGEPUSHINSIGHTITEMSFIELD.name = "insightItems"
slot2.ITEMCHANGEPUSHINSIGHTITEMSFIELD.full_name = ".ItemChangePush.insightItems"
slot2.ITEMCHANGEPUSHINSIGHTITEMSFIELD.number = 3
slot2.ITEMCHANGEPUSHINSIGHTITEMSFIELD.index = 2
slot2.ITEMCHANGEPUSHINSIGHTITEMSFIELD.label = 3
slot2.ITEMCHANGEPUSHINSIGHTITEMSFIELD.has_default_value = false
slot2.ITEMCHANGEPUSHINSIGHTITEMSFIELD.default_value = {}
slot2.ITEMCHANGEPUSHINSIGHTITEMSFIELD.message_type = slot2.INSIGHTITEM_MSG
slot2.ITEMCHANGEPUSHINSIGHTITEMSFIELD.type = 11
slot2.ITEMCHANGEPUSHINSIGHTITEMSFIELD.cpp_type = 10
slot2.ITEMCHANGEPUSH_MSG.name = "ItemChangePush"
slot2.ITEMCHANGEPUSH_MSG.full_name = ".ItemChangePush"
slot2.ITEMCHANGEPUSH_MSG.nested_types = {}
slot2.ITEMCHANGEPUSH_MSG.enum_types = {}
slot2.ITEMCHANGEPUSH_MSG.fields = {
	slot2.ITEMCHANGEPUSHITEMSFIELD,
	slot2.ITEMCHANGEPUSHPOWERITEMSFIELD,
	slot2.ITEMCHANGEPUSHINSIGHTITEMSFIELD
}
slot2.ITEMCHANGEPUSH_MSG.is_extendable = false
slot2.ITEMCHANGEPUSH_MSG.extensions = {}
slot2.USEPOWERITEMREPLYUIDFIELD.name = "uid"
slot2.USEPOWERITEMREPLYUIDFIELD.full_name = ".UsePowerItemReply.uid"
slot2.USEPOWERITEMREPLYUIDFIELD.number = 1
slot2.USEPOWERITEMREPLYUIDFIELD.index = 0
slot2.USEPOWERITEMREPLYUIDFIELD.label = 1
slot2.USEPOWERITEMREPLYUIDFIELD.has_default_value = false
slot2.USEPOWERITEMREPLYUIDFIELD.default_value = 0
slot2.USEPOWERITEMREPLYUIDFIELD.type = 3
slot2.USEPOWERITEMREPLYUIDFIELD.cpp_type = 2
slot2.USEPOWERITEMREPLY_MSG.name = "UsePowerItemReply"
slot2.USEPOWERITEMREPLY_MSG.full_name = ".UsePowerItemReply"
slot2.USEPOWERITEMREPLY_MSG.nested_types = {}
slot2.USEPOWERITEMREPLY_MSG.enum_types = {}
slot2.USEPOWERITEMREPLY_MSG.fields = {
	slot2.USEPOWERITEMREPLYUIDFIELD
}
slot2.USEPOWERITEMREPLY_MSG.is_extendable = false
slot2.USEPOWERITEMREPLY_MSG.extensions = {}
slot2.AUTOUSEEXPIREPOWERITEMREQUEST_MSG.name = "AutoUseExpirePowerItemRequest"
slot2.AUTOUSEEXPIREPOWERITEMREQUEST_MSG.full_name = ".AutoUseExpirePowerItemRequest"
slot2.AUTOUSEEXPIREPOWERITEMREQUEST_MSG.nested_types = {}
slot2.AUTOUSEEXPIREPOWERITEMREQUEST_MSG.enum_types = {}
slot2.AUTOUSEEXPIREPOWERITEMREQUEST_MSG.fields = {}
slot2.AUTOUSEEXPIREPOWERITEMREQUEST_MSG.is_extendable = false
slot2.AUTOUSEEXPIREPOWERITEMREQUEST_MSG.extensions = {}
slot2.USEITEMREQUESTENTRYFIELD.name = "entry"
slot2.USEITEMREQUESTENTRYFIELD.full_name = ".UseItemRequest.entry"
slot2.USEITEMREQUESTENTRYFIELD.number = 1
slot2.USEITEMREQUESTENTRYFIELD.index = 0
slot2.USEITEMREQUESTENTRYFIELD.label = 3
slot2.USEITEMREQUESTENTRYFIELD.has_default_value = false
slot2.USEITEMREQUESTENTRYFIELD.default_value = {}
slot2.USEITEMREQUESTENTRYFIELD.message_type = slot2.MATERIALMODULE_PB.M2QENTRY_MSG
slot2.USEITEMREQUESTENTRYFIELD.type = 11
slot2.USEITEMREQUESTENTRYFIELD.cpp_type = 10
slot2.USEITEMREQUESTTARGETIDFIELD.name = "targetId"
slot2.USEITEMREQUESTTARGETIDFIELD.full_name = ".UseItemRequest.targetId"
slot2.USEITEMREQUESTTARGETIDFIELD.number = 2
slot2.USEITEMREQUESTTARGETIDFIELD.index = 1
slot2.USEITEMREQUESTTARGETIDFIELD.label = 1
slot2.USEITEMREQUESTTARGETIDFIELD.has_default_value = false
slot2.USEITEMREQUESTTARGETIDFIELD.default_value = 0
slot2.USEITEMREQUESTTARGETIDFIELD.type = 4
slot2.USEITEMREQUESTTARGETIDFIELD.cpp_type = 4
slot2.USEITEMREQUEST_MSG.name = "UseItemRequest"
slot2.USEITEMREQUEST_MSG.full_name = ".UseItemRequest"
slot2.USEITEMREQUEST_MSG.nested_types = {}
slot2.USEITEMREQUEST_MSG.enum_types = {}
slot2.USEITEMREQUEST_MSG.fields = {
	slot2.USEITEMREQUESTENTRYFIELD,
	slot2.USEITEMREQUESTTARGETIDFIELD
}
slot2.USEITEMREQUEST_MSG.is_extendable = false
slot2.USEITEMREQUEST_MSG.extensions = {}
slot2.ITEMITEMIDFIELD.name = "itemId"
slot2.ITEMITEMIDFIELD.full_name = ".Item.itemId"
slot2.ITEMITEMIDFIELD.number = 1
slot2.ITEMITEMIDFIELD.index = 0
slot2.ITEMITEMIDFIELD.label = 1
slot2.ITEMITEMIDFIELD.has_default_value = false
slot2.ITEMITEMIDFIELD.default_value = 0
slot2.ITEMITEMIDFIELD.type = 13
slot2.ITEMITEMIDFIELD.cpp_type = 3
slot2.ITEMQUANTITYFIELD.name = "quantity"
slot2.ITEMQUANTITYFIELD.full_name = ".Item.quantity"
slot2.ITEMQUANTITYFIELD.number = 2
slot2.ITEMQUANTITYFIELD.index = 1
slot2.ITEMQUANTITYFIELD.label = 1
slot2.ITEMQUANTITYFIELD.has_default_value = false
slot2.ITEMQUANTITYFIELD.default_value = 0
slot2.ITEMQUANTITYFIELD.type = 5
slot2.ITEMQUANTITYFIELD.cpp_type = 1
slot2.ITEMLASTUSETIMEFIELD.name = "lastUseTime"
slot2.ITEMLASTUSETIMEFIELD.full_name = ".Item.lastUseTime"
slot2.ITEMLASTUSETIMEFIELD.number = 3
slot2.ITEMLASTUSETIMEFIELD.index = 2
slot2.ITEMLASTUSETIMEFIELD.label = 1
slot2.ITEMLASTUSETIMEFIELD.has_default_value = false
slot2.ITEMLASTUSETIMEFIELD.default_value = 0
slot2.ITEMLASTUSETIMEFIELD.type = 4
slot2.ITEMLASTUSETIMEFIELD.cpp_type = 4
slot2.ITEMLASTUPDATETIMEFIELD.name = "lastUpdateTime"
slot2.ITEMLASTUPDATETIMEFIELD.full_name = ".Item.lastUpdateTime"
slot2.ITEMLASTUPDATETIMEFIELD.number = 4
slot2.ITEMLASTUPDATETIMEFIELD.index = 3
slot2.ITEMLASTUPDATETIMEFIELD.label = 1
slot2.ITEMLASTUPDATETIMEFIELD.has_default_value = false
slot2.ITEMLASTUPDATETIMEFIELD.default_value = 0
slot2.ITEMLASTUPDATETIMEFIELD.type = 4
slot2.ITEMLASTUPDATETIMEFIELD.cpp_type = 4
slot2.ITEM_MSG.name = "Item"
slot2.ITEM_MSG.full_name = ".Item"
slot2.ITEM_MSG.nested_types = {}
slot2.ITEM_MSG.enum_types = {}
slot2.ITEM_MSG.fields = {
	slot2.ITEMITEMIDFIELD,
	slot2.ITEMQUANTITYFIELD,
	slot2.ITEMLASTUSETIMEFIELD,
	slot2.ITEMLASTUPDATETIMEFIELD
}
slot2.ITEM_MSG.is_extendable = false
slot2.ITEM_MSG.extensions = {}
slot2.USEPOWERITEMLISTREPLYUSEPOWERITEMINFOFIELD.name = "usePowerItemInfo"
slot2.USEPOWERITEMLISTREPLYUSEPOWERITEMINFOFIELD.full_name = ".UsePowerItemListReply.usePowerItemInfo"
slot2.USEPOWERITEMLISTREPLYUSEPOWERITEMINFOFIELD.number = 1
slot2.USEPOWERITEMLISTREPLYUSEPOWERITEMINFOFIELD.index = 0
slot2.USEPOWERITEMLISTREPLYUSEPOWERITEMINFOFIELD.label = 3
slot2.USEPOWERITEMLISTREPLYUSEPOWERITEMINFOFIELD.has_default_value = false
slot2.USEPOWERITEMLISTREPLYUSEPOWERITEMINFOFIELD.default_value = {}
slot2.USEPOWERITEMLISTREPLYUSEPOWERITEMINFOFIELD.message_type = slot2.USEPOWERITEMINFO_MSG
slot2.USEPOWERITEMLISTREPLYUSEPOWERITEMINFOFIELD.type = 11
slot2.USEPOWERITEMLISTREPLYUSEPOWERITEMINFOFIELD.cpp_type = 10
slot2.USEPOWERITEMLISTREPLY_MSG.name = "UsePowerItemListReply"
slot2.USEPOWERITEMLISTREPLY_MSG.full_name = ".UsePowerItemListReply"
slot2.USEPOWERITEMLISTREPLY_MSG.nested_types = {}
slot2.USEPOWERITEMLISTREPLY_MSG.enum_types = {}
slot2.USEPOWERITEMLISTREPLY_MSG.fields = {
	slot2.USEPOWERITEMLISTREPLYUSEPOWERITEMINFOFIELD
}
slot2.USEPOWERITEMLISTREPLY_MSG.is_extendable = false
slot2.USEPOWERITEMLISTREPLY_MSG.extensions = {}
slot2.POWERITEMUIDFIELD.name = "uid"
slot2.POWERITEMUIDFIELD.full_name = ".PowerItem.uid"
slot2.POWERITEMUIDFIELD.number = 1
slot2.POWERITEMUIDFIELD.index = 0
slot2.POWERITEMUIDFIELD.label = 1
slot2.POWERITEMUIDFIELD.has_default_value = false
slot2.POWERITEMUIDFIELD.default_value = 0
slot2.POWERITEMUIDFIELD.type = 3
slot2.POWERITEMUIDFIELD.cpp_type = 2
slot2.POWERITEMITEMIDFIELD.name = "itemId"
slot2.POWERITEMITEMIDFIELD.full_name = ".PowerItem.itemId"
slot2.POWERITEMITEMIDFIELD.number = 2
slot2.POWERITEMITEMIDFIELD.index = 1
slot2.POWERITEMITEMIDFIELD.label = 1
slot2.POWERITEMITEMIDFIELD.has_default_value = false
slot2.POWERITEMITEMIDFIELD.default_value = 0
slot2.POWERITEMITEMIDFIELD.type = 3
slot2.POWERITEMITEMIDFIELD.cpp_type = 2
slot2.POWERITEMQUANTITYFIELD.name = "quantity"
slot2.POWERITEMQUANTITYFIELD.full_name = ".PowerItem.quantity"
slot2.POWERITEMQUANTITYFIELD.number = 3
slot2.POWERITEMQUANTITYFIELD.index = 2
slot2.POWERITEMQUANTITYFIELD.label = 1
slot2.POWERITEMQUANTITYFIELD.has_default_value = false
slot2.POWERITEMQUANTITYFIELD.default_value = 0
slot2.POWERITEMQUANTITYFIELD.type = 5
slot2.POWERITEMQUANTITYFIELD.cpp_type = 1
slot2.POWERITEMEXPIRETIMEFIELD.name = "expireTime"
slot2.POWERITEMEXPIRETIMEFIELD.full_name = ".PowerItem.expireTime"
slot2.POWERITEMEXPIRETIMEFIELD.number = 4
slot2.POWERITEMEXPIRETIMEFIELD.index = 3
slot2.POWERITEMEXPIRETIMEFIELD.label = 1
slot2.POWERITEMEXPIRETIMEFIELD.has_default_value = false
slot2.POWERITEMEXPIRETIMEFIELD.default_value = 0
slot2.POWERITEMEXPIRETIMEFIELD.type = 5
slot2.POWERITEMEXPIRETIMEFIELD.cpp_type = 1
slot2.POWERITEM_MSG.name = "PowerItem"
slot2.POWERITEM_MSG.full_name = ".PowerItem"
slot2.POWERITEM_MSG.nested_types = {}
slot2.POWERITEM_MSG.enum_types = {}
slot2.POWERITEM_MSG.fields = {
	slot2.POWERITEMUIDFIELD,
	slot2.POWERITEMITEMIDFIELD,
	slot2.POWERITEMQUANTITYFIELD,
	slot2.POWERITEMEXPIRETIMEFIELD
}
slot2.POWERITEM_MSG.is_extendable = false
slot2.POWERITEM_MSG.extensions = {}
slot2.INSIGHTITEMUIDFIELD.name = "uid"
slot2.INSIGHTITEMUIDFIELD.full_name = ".InsightItem.uid"
slot2.INSIGHTITEMUIDFIELD.number = 1
slot2.INSIGHTITEMUIDFIELD.index = 0
slot2.INSIGHTITEMUIDFIELD.label = 1
slot2.INSIGHTITEMUIDFIELD.has_default_value = false
slot2.INSIGHTITEMUIDFIELD.default_value = 0
slot2.INSIGHTITEMUIDFIELD.type = 3
slot2.INSIGHTITEMUIDFIELD.cpp_type = 2
slot2.INSIGHTITEMITEMIDFIELD.name = "itemId"
slot2.INSIGHTITEMITEMIDFIELD.full_name = ".InsightItem.itemId"
slot2.INSIGHTITEMITEMIDFIELD.number = 2
slot2.INSIGHTITEMITEMIDFIELD.index = 1
slot2.INSIGHTITEMITEMIDFIELD.label = 1
slot2.INSIGHTITEMITEMIDFIELD.has_default_value = false
slot2.INSIGHTITEMITEMIDFIELD.default_value = 0
slot2.INSIGHTITEMITEMIDFIELD.type = 5
slot2.INSIGHTITEMITEMIDFIELD.cpp_type = 1
slot2.INSIGHTITEMQUANTITYFIELD.name = "quantity"
slot2.INSIGHTITEMQUANTITYFIELD.full_name = ".InsightItem.quantity"
slot2.INSIGHTITEMQUANTITYFIELD.number = 3
slot2.INSIGHTITEMQUANTITYFIELD.index = 2
slot2.INSIGHTITEMQUANTITYFIELD.label = 1
slot2.INSIGHTITEMQUANTITYFIELD.has_default_value = false
slot2.INSIGHTITEMQUANTITYFIELD.default_value = 0
slot2.INSIGHTITEMQUANTITYFIELD.type = 5
slot2.INSIGHTITEMQUANTITYFIELD.cpp_type = 1
slot2.INSIGHTITEMEXPIRETIMEFIELD.name = "expireTime"
slot2.INSIGHTITEMEXPIRETIMEFIELD.full_name = ".InsightItem.expireTime"
slot2.INSIGHTITEMEXPIRETIMEFIELD.number = 4
slot2.INSIGHTITEMEXPIRETIMEFIELD.index = 3
slot2.INSIGHTITEMEXPIRETIMEFIELD.label = 1
slot2.INSIGHTITEMEXPIRETIMEFIELD.has_default_value = false
slot2.INSIGHTITEMEXPIRETIMEFIELD.default_value = 0
slot2.INSIGHTITEMEXPIRETIMEFIELD.type = 5
slot2.INSIGHTITEMEXPIRETIMEFIELD.cpp_type = 1
slot2.INSIGHTITEM_MSG.name = "InsightItem"
slot2.INSIGHTITEM_MSG.full_name = ".InsightItem"
slot2.INSIGHTITEM_MSG.nested_types = {}
slot2.INSIGHTITEM_MSG.enum_types = {}
slot2.INSIGHTITEM_MSG.fields = {
	slot2.INSIGHTITEMUIDFIELD,
	slot2.INSIGHTITEMITEMIDFIELD,
	slot2.INSIGHTITEMQUANTITYFIELD,
	slot2.INSIGHTITEMEXPIRETIMEFIELD
}
slot2.INSIGHTITEM_MSG.is_extendable = false
slot2.INSIGHTITEM_MSG.extensions = {}
slot2.USEITEMREPLYENTRYFIELD.name = "entry"
slot2.USEITEMREPLYENTRYFIELD.full_name = ".UseItemReply.entry"
slot2.USEITEMREPLYENTRYFIELD.number = 1
slot2.USEITEMREPLYENTRYFIELD.index = 0
slot2.USEITEMREPLYENTRYFIELD.label = 3
slot2.USEITEMREPLYENTRYFIELD.has_default_value = false
slot2.USEITEMREPLYENTRYFIELD.default_value = {}
slot2.USEITEMREPLYENTRYFIELD.message_type = slot2.MATERIALMODULE_PB.M2QENTRY_MSG
slot2.USEITEMREPLYENTRYFIELD.type = 11
slot2.USEITEMREPLYENTRYFIELD.cpp_type = 10
slot2.USEITEMREPLYTARGETIDFIELD.name = "targetId"
slot2.USEITEMREPLYTARGETIDFIELD.full_name = ".UseItemReply.targetId"
slot2.USEITEMREPLYTARGETIDFIELD.number = 2
slot2.USEITEMREPLYTARGETIDFIELD.index = 1
slot2.USEITEMREPLYTARGETIDFIELD.label = 1
slot2.USEITEMREPLYTARGETIDFIELD.has_default_value = false
slot2.USEITEMREPLYTARGETIDFIELD.default_value = 0
slot2.USEITEMREPLYTARGETIDFIELD.type = 4
slot2.USEITEMREPLYTARGETIDFIELD.cpp_type = 4
slot2.USEITEMREPLY_MSG.name = "UseItemReply"
slot2.USEITEMREPLY_MSG.full_name = ".UseItemReply"
slot2.USEITEMREPLY_MSG.nested_types = {}
slot2.USEITEMREPLY_MSG.enum_types = {}
slot2.USEITEMREPLY_MSG.fields = {
	slot2.USEITEMREPLYENTRYFIELD,
	slot2.USEITEMREPLYTARGETIDFIELD
}
slot2.USEITEMREPLY_MSG.is_extendable = false
slot2.USEITEMREPLY_MSG.extensions = {}
slot2.USEPOWERITEMLISTREQUESTUSEPOWERITEMINFOFIELD.name = "usePowerItemInfo"
slot2.USEPOWERITEMLISTREQUESTUSEPOWERITEMINFOFIELD.full_name = ".UsePowerItemListRequest.usePowerItemInfo"
slot2.USEPOWERITEMLISTREQUESTUSEPOWERITEMINFOFIELD.number = 1
slot2.USEPOWERITEMLISTREQUESTUSEPOWERITEMINFOFIELD.index = 0
slot2.USEPOWERITEMLISTREQUESTUSEPOWERITEMINFOFIELD.label = 3
slot2.USEPOWERITEMLISTREQUESTUSEPOWERITEMINFOFIELD.has_default_value = false
slot2.USEPOWERITEMLISTREQUESTUSEPOWERITEMINFOFIELD.default_value = {}
slot2.USEPOWERITEMLISTREQUESTUSEPOWERITEMINFOFIELD.message_type = slot2.USEPOWERITEMINFO_MSG
slot2.USEPOWERITEMLISTREQUESTUSEPOWERITEMINFOFIELD.type = 11
slot2.USEPOWERITEMLISTREQUESTUSEPOWERITEMINFOFIELD.cpp_type = 10
slot2.USEPOWERITEMLISTREQUEST_MSG.name = "UsePowerItemListRequest"
slot2.USEPOWERITEMLISTREQUEST_MSG.full_name = ".UsePowerItemListRequest"
slot2.USEPOWERITEMLISTREQUEST_MSG.nested_types = {}
slot2.USEPOWERITEMLISTREQUEST_MSG.enum_types = {}
slot2.USEPOWERITEMLISTREQUEST_MSG.fields = {
	slot2.USEPOWERITEMLISTREQUESTUSEPOWERITEMINFOFIELD
}
slot2.USEPOWERITEMLISTREQUEST_MSG.is_extendable = false
slot2.USEPOWERITEMLISTREQUEST_MSG.extensions = {}
slot2.MARKREADSUBTYPE21REPLYITEMIDFIELD.name = "itemId"
slot2.MARKREADSUBTYPE21REPLYITEMIDFIELD.full_name = ".MarkReadSubType21Reply.itemId"
slot2.MARKREADSUBTYPE21REPLYITEMIDFIELD.number = 1
slot2.MARKREADSUBTYPE21REPLYITEMIDFIELD.index = 0
slot2.MARKREADSUBTYPE21REPLYITEMIDFIELD.label = 1
slot2.MARKREADSUBTYPE21REPLYITEMIDFIELD.has_default_value = false
slot2.MARKREADSUBTYPE21REPLYITEMIDFIELD.default_value = 0
slot2.MARKREADSUBTYPE21REPLYITEMIDFIELD.type = 5
slot2.MARKREADSUBTYPE21REPLYITEMIDFIELD.cpp_type = 1
slot2.MARKREADSUBTYPE21REPLY_MSG.name = "MarkReadSubType21Reply"
slot2.MARKREADSUBTYPE21REPLY_MSG.full_name = ".MarkReadSubType21Reply"
slot2.MARKREADSUBTYPE21REPLY_MSG.nested_types = {}
slot2.MARKREADSUBTYPE21REPLY_MSG.enum_types = {}
slot2.MARKREADSUBTYPE21REPLY_MSG.fields = {
	slot2.MARKREADSUBTYPE21REPLYITEMIDFIELD
}
slot2.MARKREADSUBTYPE21REPLY_MSG.is_extendable = false
slot2.MARKREADSUBTYPE21REPLY_MSG.extensions = {}
slot2.AUTOUSEEXPIREPOWERITEMREPLYUSEDFIELD.name = "used"
slot2.AUTOUSEEXPIREPOWERITEMREPLYUSEDFIELD.full_name = ".AutoUseExpirePowerItemReply.used"
slot2.AUTOUSEEXPIREPOWERITEMREPLYUSEDFIELD.number = 1
slot2.AUTOUSEEXPIREPOWERITEMREPLYUSEDFIELD.index = 0
slot2.AUTOUSEEXPIREPOWERITEMREPLYUSEDFIELD.label = 1
slot2.AUTOUSEEXPIREPOWERITEMREPLYUSEDFIELD.has_default_value = false
slot2.AUTOUSEEXPIREPOWERITEMREPLYUSEDFIELD.default_value = false
slot2.AUTOUSEEXPIREPOWERITEMREPLYUSEDFIELD.type = 8
slot2.AUTOUSEEXPIREPOWERITEMREPLYUSEDFIELD.cpp_type = 7
slot2.AUTOUSEEXPIREPOWERITEMREPLY_MSG.name = "AutoUseExpirePowerItemReply"
slot2.AUTOUSEEXPIREPOWERITEMREPLY_MSG.full_name = ".AutoUseExpirePowerItemReply"
slot2.AUTOUSEEXPIREPOWERITEMREPLY_MSG.nested_types = {}
slot2.AUTOUSEEXPIREPOWERITEMREPLY_MSG.enum_types = {}
slot2.AUTOUSEEXPIREPOWERITEMREPLY_MSG.fields = {
	slot2.AUTOUSEEXPIREPOWERITEMREPLYUSEDFIELD
}
slot2.AUTOUSEEXPIREPOWERITEMREPLY_MSG.is_extendable = false
slot2.AUTOUSEEXPIREPOWERITEMREPLY_MSG.extensions = {}
slot2.USEINSIGHTITEMREPLYUIDFIELD.name = "uid"
slot2.USEINSIGHTITEMREPLYUIDFIELD.full_name = ".UseInsightItemReply.uid"
slot2.USEINSIGHTITEMREPLYUIDFIELD.number = 1
slot2.USEINSIGHTITEMREPLYUIDFIELD.index = 0
slot2.USEINSIGHTITEMREPLYUIDFIELD.label = 1
slot2.USEINSIGHTITEMREPLYUIDFIELD.has_default_value = false
slot2.USEINSIGHTITEMREPLYUIDFIELD.default_value = 0
slot2.USEINSIGHTITEMREPLYUIDFIELD.type = 3
slot2.USEINSIGHTITEMREPLYUIDFIELD.cpp_type = 2
slot2.USEINSIGHTITEMREPLYHEROIDFIELD.name = "heroId"
slot2.USEINSIGHTITEMREPLYHEROIDFIELD.full_name = ".UseInsightItemReply.heroId"
slot2.USEINSIGHTITEMREPLYHEROIDFIELD.number = 2
slot2.USEINSIGHTITEMREPLYHEROIDFIELD.index = 1
slot2.USEINSIGHTITEMREPLYHEROIDFIELD.label = 1
slot2.USEINSIGHTITEMREPLYHEROIDFIELD.has_default_value = false
slot2.USEINSIGHTITEMREPLYHEROIDFIELD.default_value = 0
slot2.USEINSIGHTITEMREPLYHEROIDFIELD.type = 5
slot2.USEINSIGHTITEMREPLYHEROIDFIELD.cpp_type = 1
slot2.USEINSIGHTITEMREPLY_MSG.name = "UseInsightItemReply"
slot2.USEINSIGHTITEMREPLY_MSG.full_name = ".UseInsightItemReply"
slot2.USEINSIGHTITEMREPLY_MSG.nested_types = {}
slot2.USEINSIGHTITEMREPLY_MSG.enum_types = {}
slot2.USEINSIGHTITEMREPLY_MSG.fields = {
	slot2.USEINSIGHTITEMREPLYUIDFIELD,
	slot2.USEINSIGHTITEMREPLYHEROIDFIELD
}
slot2.USEINSIGHTITEMREPLY_MSG.is_extendable = false
slot2.USEINSIGHTITEMREPLY_MSG.extensions = {}
slot2.MARKREADSUBTYPE21REQUESTITEMIDFIELD.name = "itemId"
slot2.MARKREADSUBTYPE21REQUESTITEMIDFIELD.full_name = ".MarkReadSubType21Request.itemId"
slot2.MARKREADSUBTYPE21REQUESTITEMIDFIELD.number = 1
slot2.MARKREADSUBTYPE21REQUESTITEMIDFIELD.index = 0
slot2.MARKREADSUBTYPE21REQUESTITEMIDFIELD.label = 1
slot2.MARKREADSUBTYPE21REQUESTITEMIDFIELD.has_default_value = false
slot2.MARKREADSUBTYPE21REQUESTITEMIDFIELD.default_value = 0
slot2.MARKREADSUBTYPE21REQUESTITEMIDFIELD.type = 5
slot2.MARKREADSUBTYPE21REQUESTITEMIDFIELD.cpp_type = 1
slot2.MARKREADSUBTYPE21REQUEST_MSG.name = "MarkReadSubType21Request"
slot2.MARKREADSUBTYPE21REQUEST_MSG.full_name = ".MarkReadSubType21Request"
slot2.MARKREADSUBTYPE21REQUEST_MSG.nested_types = {}
slot2.MARKREADSUBTYPE21REQUEST_MSG.enum_types = {}
slot2.MARKREADSUBTYPE21REQUEST_MSG.fields = {
	slot2.MARKREADSUBTYPE21REQUESTITEMIDFIELD
}
slot2.MARKREADSUBTYPE21REQUEST_MSG.is_extendable = false
slot2.MARKREADSUBTYPE21REQUEST_MSG.extensions = {}
slot2.GETITEMLISTREPLYITEMSFIELD.name = "items"
slot2.GETITEMLISTREPLYITEMSFIELD.full_name = ".GetItemListReply.items"
slot2.GETITEMLISTREPLYITEMSFIELD.number = 1
slot2.GETITEMLISTREPLYITEMSFIELD.index = 0
slot2.GETITEMLISTREPLYITEMSFIELD.label = 3
slot2.GETITEMLISTREPLYITEMSFIELD.has_default_value = false
slot2.GETITEMLISTREPLYITEMSFIELD.default_value = {}
slot2.GETITEMLISTREPLYITEMSFIELD.message_type = slot2.ITEM_MSG
slot2.GETITEMLISTREPLYITEMSFIELD.type = 11
slot2.GETITEMLISTREPLYITEMSFIELD.cpp_type = 10
slot2.GETITEMLISTREPLYPOWERITEMSFIELD.name = "powerItems"
slot2.GETITEMLISTREPLYPOWERITEMSFIELD.full_name = ".GetItemListReply.powerItems"
slot2.GETITEMLISTREPLYPOWERITEMSFIELD.number = 2
slot2.GETITEMLISTREPLYPOWERITEMSFIELD.index = 1
slot2.GETITEMLISTREPLYPOWERITEMSFIELD.label = 3
slot2.GETITEMLISTREPLYPOWERITEMSFIELD.has_default_value = false
slot2.GETITEMLISTREPLYPOWERITEMSFIELD.default_value = {}
slot2.GETITEMLISTREPLYPOWERITEMSFIELD.message_type = slot2.POWERITEM_MSG
slot2.GETITEMLISTREPLYPOWERITEMSFIELD.type = 11
slot2.GETITEMLISTREPLYPOWERITEMSFIELD.cpp_type = 10
slot2.GETITEMLISTREPLYINSIGHTITEMSFIELD.name = "insightItems"
slot2.GETITEMLISTREPLYINSIGHTITEMSFIELD.full_name = ".GetItemListReply.insightItems"
slot2.GETITEMLISTREPLYINSIGHTITEMSFIELD.number = 3
slot2.GETITEMLISTREPLYINSIGHTITEMSFIELD.index = 2
slot2.GETITEMLISTREPLYINSIGHTITEMSFIELD.label = 3
slot2.GETITEMLISTREPLYINSIGHTITEMSFIELD.has_default_value = false
slot2.GETITEMLISTREPLYINSIGHTITEMSFIELD.default_value = {}
slot2.GETITEMLISTREPLYINSIGHTITEMSFIELD.message_type = slot2.INSIGHTITEM_MSG
slot2.GETITEMLISTREPLYINSIGHTITEMSFIELD.type = 11
slot2.GETITEMLISTREPLYINSIGHTITEMSFIELD.cpp_type = 10
slot2.GETITEMLISTREPLY_MSG.name = "GetItemListReply"
slot2.GETITEMLISTREPLY_MSG.full_name = ".GetItemListReply"
slot2.GETITEMLISTREPLY_MSG.nested_types = {}
slot2.GETITEMLISTREPLY_MSG.enum_types = {}
slot2.GETITEMLISTREPLY_MSG.fields = {
	slot2.GETITEMLISTREPLYITEMSFIELD,
	slot2.GETITEMLISTREPLYPOWERITEMSFIELD,
	slot2.GETITEMLISTREPLYINSIGHTITEMSFIELD
}
slot2.GETITEMLISTREPLY_MSG.is_extendable = false
slot2.GETITEMLISTREPLY_MSG.extensions = {}
slot2.USEPOWERITEMREQUESTUIDFIELD.name = "uid"
slot2.USEPOWERITEMREQUESTUIDFIELD.full_name = ".UsePowerItemRequest.uid"
slot2.USEPOWERITEMREQUESTUIDFIELD.number = 1
slot2.USEPOWERITEMREQUESTUIDFIELD.index = 0
slot2.USEPOWERITEMREQUESTUIDFIELD.label = 1
slot2.USEPOWERITEMREQUESTUIDFIELD.has_default_value = false
slot2.USEPOWERITEMREQUESTUIDFIELD.default_value = 0
slot2.USEPOWERITEMREQUESTUIDFIELD.type = 3
slot2.USEPOWERITEMREQUESTUIDFIELD.cpp_type = 2
slot2.USEPOWERITEMREQUEST_MSG.name = "UsePowerItemRequest"
slot2.USEPOWERITEMREQUEST_MSG.full_name = ".UsePowerItemRequest"
slot2.USEPOWERITEMREQUEST_MSG.nested_types = {}
slot2.USEPOWERITEMREQUEST_MSG.enum_types = {}
slot2.USEPOWERITEMREQUEST_MSG.fields = {
	slot2.USEPOWERITEMREQUESTUIDFIELD
}
slot2.USEPOWERITEMREQUEST_MSG.is_extendable = false
slot2.USEPOWERITEMREQUEST_MSG.extensions = {}
slot2.AutoUseExpirePowerItemReply = slot1.Message(slot2.AUTOUSEEXPIREPOWERITEMREPLY_MSG)
slot2.AutoUseExpirePowerItemRequest = slot1.Message(slot2.AUTOUSEEXPIREPOWERITEMREQUEST_MSG)
slot2.GetItemListReply = slot1.Message(slot2.GETITEMLISTREPLY_MSG)
slot2.GetItemListRequest = slot1.Message(slot2.GETITEMLISTREQUEST_MSG)
slot2.InsightItem = slot1.Message(slot2.INSIGHTITEM_MSG)
slot2.Item = slot1.Message(slot2.ITEM_MSG)
slot2.ItemChangePush = slot1.Message(slot2.ITEMCHANGEPUSH_MSG)
slot2.MarkReadSubType21Reply = slot1.Message(slot2.MARKREADSUBTYPE21REPLY_MSG)
slot2.MarkReadSubType21Request = slot1.Message(slot2.MARKREADSUBTYPE21REQUEST_MSG)
slot2.PowerItem = slot1.Message(slot2.POWERITEM_MSG)
slot2.UseInsightItemReply = slot1.Message(slot2.USEINSIGHTITEMREPLY_MSG)
slot2.UseInsightItemRequest = slot1.Message(slot2.USEINSIGHTITEMREQUEST_MSG)
slot2.UseItemReply = slot1.Message(slot2.USEITEMREPLY_MSG)
slot2.UseItemRequest = slot1.Message(slot2.USEITEMREQUEST_MSG)
slot2.UsePowerItemInfo = slot1.Message(slot2.USEPOWERITEMINFO_MSG)
slot2.UsePowerItemListReply = slot1.Message(slot2.USEPOWERITEMLISTREPLY_MSG)
slot2.UsePowerItemListRequest = slot1.Message(slot2.USEPOWERITEMLISTREQUEST_MSG)
slot2.UsePowerItemReply = slot1.Message(slot2.USEPOWERITEMREPLY_MSG)
slot2.UsePowerItemRequest = slot1.Message(slot2.USEPOWERITEMREQUEST_MSG)

return slot2
