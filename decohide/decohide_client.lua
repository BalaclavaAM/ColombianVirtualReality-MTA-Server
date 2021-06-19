local objectsBlacklist = {}
local objectsCache = {}
local isDecohideEnabled = false

-- settings
local prefixColor = "#FF7C50" -- Output messages prefix clor (HEX)


-- initialize the resource
function initializeDecohide()
    outputDebugString("[decohide] Successfully initialized '" .. getResourceName(getThisResource()) .. "' resource!", 0, 0, 100, 150)

    -- register blacklisted objects from the meta file
    local blackedFile = XML.load("objects.xml")
    local blackedList = blackedFile:getChildren()
    for i, blacked in pairs(blackedList) do
        local blackedModel = tonumber(blacked:getValue())
        objectsBlacklist[blackedModel] = true
    end
end
addEventHandler("onClientResourceStart", resourceRoot, initializeDecohide)

-- decohide toggler
function toggleDecohide()
    if (not isDecohideEnabled) then
        isDecohideEnabled = true
        outputChatBox(prefixColor .. "[CVR] #FFFFFFDecoraciones #30D158desactivadas", 255, 255, 255, true)
        checkObjects()
    else
        isDecohideEnabled = false
        outputChatBox(prefixColor .. "[CVR] #FFFFFFDecoraciones #FF9F0Aactivadas", 255, 255, 255, true)
        checkObjects()
    end
end
addCommandHandler("disabletex", toggleDecohide)

-- handle objects on map start
function handleObjects()
    resetObjectsCache()
    for i, object in pairs(getElementsByType("object")) do
        local objectModel = object:getModel()
        if (objectsBlacklist[objectModel]) then
            table.insert(objectsCache, {
                object = object,
                scale = object:getScale()
            })
        end
    end
    checkObjects()
end
addEventHandler("onClientMapStarting", root, handleObjects)


-- check objects (based on decohide state)
function checkObjects()
    if (isDecohideEnabled) then
        for i, object in pairs(objectsCache) do
            object.object:setScale(0)
        end
    else
        for i, object in pairs(objectsCache) do
            object.object:setScale(object.scale)
        end
    end
end


-- reset cached objects
function resetObjectsCache()
    objectsCache = {}
end