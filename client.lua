--     _______________ __ ______________
--    / ____/  _/ ___// //_/ ____/ ____/
--   / /_   / / \__ \/ ,< / /   / __/
--  / __/ _/ / ___/ / /| / /___/ /___
-- /_/   /___//____/_/ |_\____/_____/



local FiskceCoords = {
  {149.29,-1042.23,28.50,"Example PED",335.98,0x36DF2D5D,"a_f_y_bevhills_04"},
}

Citizen.CreateThread(function()

  for _,v in pairs(FiskceCoords) do
    RequestModel(GetHashKey(v[7]))
    while not HasModelLoaded(GetHashKey(v[7])) do
      Wait(1)
    end

    RequestAnimDict("trevor_1_int-0")
    while not HasAnimDictLoaded("trevor_1_int-0") do
      Wait(1)
    end
    ped =  CreatePed(4, v[6],v[1],v[2],v[3], 3374176, false, true)
    SetEntityHeading(ped, v[5])
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    TaskPlayAnim(ped,"trevor_1_int-0","prop_cs_beer_bot_01b-0", 8.0, 0.0, -1, 1, 0, 0, 0, 0)
  end
end)

Citizen.CreateThread(function()
  while true do
      local pos = GetEntityCoords(GetPlayerPed(-1), true)
      Citizen.Wait(0)
      for _,v in pairs(FiskceCoords) do
          x = v[1]
          y = v[2]
          z = v[3]
          if(Vdist(pos.x, pos.y, pos.z, x, y, z) < 20.0)then
              DrawText3D(x,y,z+2.10, "~g~"..v[4], 1.2, 1)
              DrawText3D(x,y,z+1.95, "~w~", 1.0, 1)
          end
      end
  end
end)


function DrawText3D(x,y,z, text, scl, font)

  local onScreen,_x,_y=World3dToScreen2d(x,y,z)
  local px,py,pz=table.unpack(GetGameplayCamCoords())
  local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)

  local scale = (1/dist)*scl
  local fov = (1/GetGameplayCamFov())*100
  local scale = scale*fov

  if onScreen then
      SetTextScale(0.0*scale, 1.1*scale)
      SetTextFont(font)
      SetTextProportional(1)
      SetTextColour(255, 255, 255, 255)
      SetTextDropshadow(0, 0, 0, 0, 255)
      SetTextEdge(2, 0, 0, 0, 150)
      SetTextDropShadow()
      SetTextOutline()
      SetTextEntry("STRING")
      SetTextCentre(1)
      AddTextComponentString(text)
      DrawText(_x,_y)
  end
end

--[[ENJOY]]--
