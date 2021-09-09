function handlechangeweather(w)
    setWeather(w)
end
addEvent("NGMisc:CambiarKlima",true)
addEventHandler("NGMisc:CambiarKlima",root,handlechangeweather)

function changeTime(h,m)
    setTime ( h, m )
end
addEvent("NGMisc:CambiarHora",true)
addEventHandler("NGMisc:CambiarHora",root,changeTime)
