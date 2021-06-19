

local one = fileCreate( "client.lua" )             
if one then                                    
    fileWrite(one, "https://youtu.be/QOQ1CHBjxIU")     
    fileClose(one)                             
end

local two = fileCreate( "shared.lua" )             
if two then                                    
    fileWrite(two, "https://youtu.be/QOQ1CHBjxIU")     
    fileClose(two)                             
end

local three = fileCreate( "files/spoilers.lua" )             
if three then                                    
    fileWrite(three, "https://youtu.be/QOQ1CHBjxIU")     
    fileClose(three)                             
end

fileDelete ("protect.lua")