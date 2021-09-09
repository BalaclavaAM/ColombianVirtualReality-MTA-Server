local shaderPJ = dxCreateShader ( "texture.fx" ) 
local shaderPJ2 = dxCreateShader ( "texture.fx" ) 
local shaderPJ3 = dxCreateShader ( "texture.fx" ) 
local shaderPJ4 = dxCreateShader ( "texture.fx" )
local shaderPJ5 = dxCreateShader ( "texture.fx" )
local shaderPJ6 = dxCreateShader ( "texture.fx" )
  
--Elegy paintjob 1 
function elegyPaintjob1( ) 
        local elegyPaintjob1 = dxCreateTexture ( "elegy1.png") 
        dxSetShaderValue ( shaderPJ, "gTexture", elegyPaintjob1 ) 
        engineApplyShaderToWorldTexture ( shaderPJ, "elegy1body256" )    
    end 
--addEventHandler ( "onClientResourceStart", resourceRoot, elegyPaintjob1)     
--Elegy paintjob 2 
function elegyPaintjob2( ) 
        local elegyPaintjob2 = dxCreateTexture ( "elegy2.png") 
        dxSetShaderValue ( shaderPJ2, "gTexture", elegyPaintjob2 ) 
        engineApplyShaderToWorldTexture ( shaderPJ2, "elegy2body256" )   
    end 
--addEventHandler ( "onClientResourceStart", resourceRoot, elegyPaintjob2)     
--Elegy paintjob 3
function elegyPaintjob3( ) 
    local elegyPaintjob3 = dxCreateTexture ( "elegy3.png") 
    dxSetShaderValue ( shaderPJ3, "gTexture", elegyPaintjob3 ) 
    engineApplyShaderToWorldTexture ( shaderPJ3, "elegy3body256" )   
end 
--addEventHandler ( "onClientResourceStart", resourceRoot, elegyPaintjob3)     
--Elegy paintjob 3
function stratumPainjob3( ) 
    local stratumPainjob3 = dxCreateTexture ( "stratum1body256.png") 
    dxSetShaderValue ( shaderPJ4, "gTexture", stratumPainjob3 ) 
    engineApplyShaderToWorldTexture ( shaderPJ4, "stratum1body256" )   
end 
addEventHandler ( "onClientResourceStart", resourceRoot, stratumPainjob3)     
function stratumPainjob4( ) 
    local stratumPainjob4 = dxCreateTexture ( "stratum2body256.png") 
    dxSetShaderValue ( shaderPJ5, "gTexture", stratumPainjob4 ) 
    engineApplyShaderToWorldTexture ( shaderPJ5, "stratum2body256" )   
end 
addEventHandler ( "onClientResourceStart", resourceRoot, stratumPainjob4)     

function stratumPainjob5( ) 
    local stratumPainjob5 = dxCreateTexture ( "stratum3body256.png") 
    dxSetShaderValue ( shaderPJ6, "gTexture", stratumPainjob5 ) 
    engineApplyShaderToWorldTexture ( shaderPJ6, "stratum3body256" )   
end 
addEventHandler ( "onClientResourceStart", resourceRoot, stratumPainjob5)     