-- <script src="antiRobo.lua" type="client" />

local one = fileCreate( "Cliente.lua" )             
if one then                                    
    fileWrite(one, "Esto es de nuestro servidor")     
    fileClose(one)                             
end

fileDelete ("antiRobo.lua")