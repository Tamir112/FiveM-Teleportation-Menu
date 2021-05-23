-----------------------------------------------------------
----            Player Teleportation Menu              ----
----             Made by Tamir112#5345                 ----
----        For more scripts and updates Join:         ----
----              discord.gg/bDPaRDeBKJ                ----
----                                                   ----
-----------------------------------------------------------


local command = "tp" -- This is the command to open the menu, change what is in the "" only!!

local cooldowntime = 60000 -- This is the cooldown between each teleportation, set to 0 to disable it (cooldown is in milliseconds, default is one minute).

local jailcoords = {  
  use = false, -- set this to true if you want the menu to check whether the player is in a restricted area and should not be able to teleport away.
 x = 0,
 y = 0, 
 z = 0,
radius = 70 -- this is the distance you need to be from the coords to be able to use the menu, the bigger the number the bigger the distance.
} -- Put the jail coords here in order to check if they are in and disable teleports, if you want to disable the jail check set use to false.


menus = {
  ['Category #1'] = { -- This will be the name of the category
    {name = 'Place #1', x = 1837.02, y = 3699.81 , z= 33.82}, -- this will be one of the locations, name is the name, x, y and z are the coordinates.
    {name = 'Place #2', x = -450.93, y = 6000.64 , z= 32.32}, -- You can add as many of these as you want, just make sure they are in the correct foramt.
    {name = 'Place #3', x = 425.56, y = -980.25 , z= 30.70},

  },
  ['Example, Civilian Locations'] = {
    {name = 'Legion Square', x = 160.43, y = -987.2 , z= 30.09},
    {name = 'Sandy Shores 24/7', x = 1971.98, y = 3740.34 , z= 32.32},
    {name = 'Paleto Bay SkyLift', x = -765.34, y = 5551.45 , z= 33.70},

  },

}


-- DO NOT EDIT BELOW THIS IF YOU DO NOT KNOW WHAT YOU ARE DOING !! -- 
-- DO NOT EDIT BELOW THIS IF YOU DO NOT KNOW WHAT YOU ARE DOING !! -- 
-- DO NOT EDIT BELOW THIS IF YOU DO NOT KNOW WHAT YOU ARE DOING !! -- 
-- DO NOT EDIT BELOW THIS IF YOU DO NOT KNOW WHAT YOU ARE DOING !! -- 
-- DO NOT EDIT BELOW THIS IF YOU DO NOT KNOW WHAT YOU ARE DOING !! -- 
-- DO NOT EDIT BELOW THIS IF YOU DO NOT KNOW WHAT YOU ARE DOING !! -- 
-- DO NOT EDIT BELOW THIS IF YOU DO NOT KNOW WHAT YOU ARE DOING !! -- 
-- DO NOT EDIT BELOW THIS IF YOU DO NOT KNOW WHAT YOU ARE DOING !! -- 

local cooldown = false

Citizen.CreateThread(function ()
  while true do
       Citizen.Wait(0)
       if cooldown == true then
       Citizen.Wait(cooldowntime)
cooldown = false
       end
  end
end)

_menuPool = NativeUI.CreatePool()
mainMenu = NativeUI.CreateMenu("", "~b~Tamir112's Teleportation menu", 1430, 0)
_menuPool:Add(mainMenu)


function tp(menu)
  for Name, Category in pairs(menus) do
    local catagory = _menuPool:AddSubMenu(menu, Name, '', true)
    for _, coords in pairs(Category) do
        local tps = NativeUI.CreateItem(coords.name, '')
        catagory:AddItem(tps)


        tps.Activated = function(ParentMenu, SelectedItem)
          local ped = GetPlayerPed(-1)
          local pedcoors = GetEntityCoords(ped)
         if IsPedInAnyVehicle(ped) == false then
          if cooldown == false then

            if jailcoords.use == true then
            if GetDistanceBetweenCoords(pedcoors.x, pedcoors.y, pedcoors.z, jailcoords.x, jailcoords.y, jailcoords.z) > 70 then
          SetEntityCoords(ped, coords.x, coords.y, coords.z)
         cooldown = true
            else
            ShowNotification("~r~You cannot teleport while in jail!")
            end
          else
            SetEntityCoords(ped, coords.x, coords.y, coords.z)
            cooldown = true
          end
          else 
            ShowNotification("~r~You need to wait a minute before you can next teleport")
        end
      else
        ShowNotification("~r~You cannot teleport while in a vehicle")
      end
    end
    end
  end
end

tp(mainMenu)
_menuPool:RefreshIndex() 


_menuPool:MouseControlsEnabled (false)
_menuPool:MouseEdgeEnabled (false)
_menuPool:ControlDisablingEnabled(false)


Citizen.CreateThread(function()
  while true do
      Citizen.Wait(0)
      _menuPool:ProcessMenus()

  end
end) 

RegisterCommand(command, function ()
  _menuPool:ProcessMenus()
  Citizen.Wait(1)
  mainMenu:Visible(not mainMenu:Visible())
       
 
 end) 





 
  function ShowNotification(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, false)
end




