local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/dangerpasha/atomsrc/refs/heads/main/source')))();

OrionLib:MakeNotification({
	Name = "War Tycoon Hack",
	Content = "Welcome!",
	Time = 3
});

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Workspace = game:GetService("Workspace");
local Players = game:GetService("Players");
local Player = Players.LocalPlayer;

local Window = OrionLib:MakeWindow({ Name = "atomclient", IntroEnabled = false });
local MainTab = Window:MakeTab({ Name = "Main" });
local HacksSection = MainTab:AddSection({ Name = "Hack Buttons" });
local VisualsTab = Window:MakeTab({ Name = "Visuals" });
local VisualsSection = VisualsTab:AddSection({ Name = "Visuals" });
local TycoonsTab = Window:MakeTab({ Name = "Tycoons" });
local TycoonsSection = TycoonsTab:AddSection({ Name = "Tycoons" });
local TeleportsTab = Window:MakeTab({ Name = "Teleports" });
local TeleportsSection = TeleportsTab:AddSection({ Name = "Teleports" });

local speedHackValue = 40;

local Players = game:GetService("Players")

local teamColors = {
    ["Alpha"] = Color3.fromRGB(255, 0, 0),
    ["Bravo"] = Color3.fromRGB(226, 150, 3),
    ["Charlie"] = Color3.fromRGB(231, 222, 5),
    ["Delta"] = Color3.fromRGB(65, 227, 0),
    ["Echo"] = Color3.fromRGB(3, 154, 9),
    ["Foxtrot"] = Color3.fromRGB(0, 237, 215),
    ["Golf"] = Color3.fromRGB(1, 131, 240),
    ["Hotel"] = Color3.fromRGB(0, 18, 235),
    ["Kilo"] = Color3.fromRGB(153, 0, 229),
    ["Lima"] = Color3.fromRGB(198, 132, 241),
    ["Omega"] = Color3.fromRGB(235, 4, 230),
    ["Sierra"] = Color3.fromRGB(171, 149, 129),
    ["Romeo"] = Color3.fromRGB(154, 102, 111),
    ["Tango"] = Color3.fromRGB(84, 68, 53),
    ["Victor"] = Color3.fromRGB(255, 255, 255),
    ["Zulu"] = Color3.fromRGB(53, 57, 58),
}

local function highlightPlayer(player)
    if player.Character then
        for _, child in ipairs(player.Character:GetChildren()) do
            if child:IsA("Highlight") then
                child:Destroy()
            end
        end

        local team = player.Team
        if team and teamColors[team.Name] then
            local highlight = Instance.new("Highlight")
            highlight.Parent = player.Character
            highlight.FillColor = teamColors[team.Name]
            highlight.OutlineTransparency = 1
        end
    end
end

local function enableESP()
    for _, player in ipairs(Players:GetPlayers()) do
        highlightPlayer(player)
        player.CharacterAdded:Connect(function()
            highlightPlayer(player)
        end)
        player:GetPropertyChangedSignal("Team"):Connect(function()
            highlightPlayer(player)
        end)
    end

    Players.PlayerAdded:Connect(function(player)
        player.CharacterAdded:Connect(function()
            highlightPlayer(player)
        end)

        player:GetPropertyChangedSignal("Team"):Connect(function()
            highlightPlayer(player)
        end)
    end)
end

VisualsSection:AddButton({
    Name = "ESP",
    Callback = function()
        enableESP()
    end
})

HacksSection:AddButton({
    Name = "Aimbot",
    Callback = function ()
	local UIS = game:GetService("UserInputService")
local CurrentCam = Workspace.CurrentCamera
local PLAYER = Players.LocalPlayer

-- Настройки для аимбота
local aimFov = 200 -- Радиус области, где аимбот будет искать противников
local aimPart = "Head" -- Часть тела, на которую будет происходить прицеливание
local aimEnabled = false -- Переключатель состояния аимбота

-- Функция нахождения ближайшего противника
local function getClosestPlayerToMouse()
    local closestPlayer = nil
    local shortestDistance = aimFov

    for _, player in pairs(Players:GetPlayers()) do
        if player ~= PLAYER and player.Team ~= PLAYER.Team then
            local character = player.Character
            if character and character:FindFirstChild(aimPart) and character.Humanoid.Health > 0 then
                local screenPos, onScreen = CurrentCam:WorldToViewportPoint(character[aimPart].Position)
                if onScreen then
                    local mousePos = UIS:GetMouseLocation()
                    local distance = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
                    if distance < shortestDistance then
                        closestPlayer = player
                        shortestDistance = distance
                    end
                end
            end
        end
    end
    return closestPlayer
end

-- Функция наведения на выбранную цель
local function aimAtTarget(target)
    if target and target.Character then
        local targetPart = target.Character:FindFirstChild(aimPart)
        if targetPart then
            CurrentCam.CFrame = CFrame.lookAt(CurrentCam.CFrame.Position, targetPart.Position)
        end
    end
end

-- Обработчик нажатия колесика мыши
UIS.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton3 then
        aimEnabled = true
        while aimEnabled do
            local closestPlayer = getClosestPlayerToMouse()
            aimAtTarget(closestPlayer)
            wait(0.01)
        end
    end
end)

-- Отключение аимбота при отпускании колесика мыши
UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton3 then
        aimEnabled = false
    end
end)

});

HacksSection:AddButton({
    Name = "Delete Doors and Gates",
    Callback = function ()
        for k,v in pairs(Workspace.Tycoon.Tycoons:GetChildren()) do
            for x,y in pairs(v.PurchasedObjects:GetChildren()) do
                if(y.Name:find("Door") or y.Name:find("Gate")) then y:destroy(); end;
            end;
        end;
    end
});

HacksSection:AddButton({
    Name = "Get Ready (deletes your visual armor and helmet)",
    Callback = function ()
        for k,v in pairs(Player.Character:GetChildren()) do
            if(v.ClassName == "Accessory") then v:destroy() end;
            if(v.Name:find("Armor")) then v.Mesh:destroy() end;
            if(v.Name:find("Helmet")) then v:destroy() end;
        end;
    end
});

HacksSection:AddButton({
	Name = "Anti-Riot Shield",
	Callback = function ()
		while true do
			wait(0);
			for k,v in pairs(Players:GetChildren()) do
				if(v.Name ~= Player.Name) then
					for _,l in pairs(Workspace[v.Name]:GetChildren()) do
						if(l.Name == "SRiot Shield" or l.Name == "Riot Shield") then l:destroy(); end;
					end;
				end;
			end;
		end;
	end    
})

HacksSection:AddButton({
	Name = "Infinite Ammo and NoReload",
	Callback = function ()
        ReplicatedStorage.BulletFireSystem.GunReload:destroy();
        local gunReload = Instance.new("Part");
        gunReload.Name = "GunReload";
        gunReload.Parent = ReplicatedStorage.BulletFireSystem;
        while true do
            wait(0);
            for _,v in pairs(Player.Character:GetChildren()) do
                if(v.ClassName == "Tool") then v.ACS_Modulo.Variaveis.Ammo.Value = 9999; end;
            end;
        end;
	end    
});

HacksSection:AddSlider({
	Name = "SpeedHack",
	Min = 5,
	Max = 100,
	Default = 25,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	Callback = function (value)
		speedHackValue = value;
	end    
});

TycoonsSection:AddButton({
    Name = "Your Base ("..Player.leaderstats.Team.Value..")",
    Callback = function ()
        Player.Character.HumanoidRootPart.CFrame = Workspace.Tycoon.Tycoons[Player.leaderstats.Team.Value].Essentials.Spawn.CFrame;
    end
});

for _, v in pairs({"Alpha","Bravo","Charlie","Delta","Echo","Foxtrot","Kilo","Lima","Omega","Tango","Victor","Zulu"}) do
    if(v ~= Player.leaderstats.Team.Value) then
        TycoonsSection:AddButton({
            Name = v,
            Callback = function ()
                Player.Character.HumanoidRootPart.CFrame = Workspace.Tycoon.Tycoons[v].Essentials.Spawn.CFrame;
            end 
        });
    end;
end;

TeleportsTab:AddButton({
    Name = "Capture Point",
    Callback = function ()
        Player.Character.HumanoidRootPart.CFrame = Workspace.Beams.CapturePoint1.CFrame;
    end
});

TeleportsTab:AddButton({
    Name = "Oil Barrel",
    Callback = function ()
        for _, v in pairs(Workspace.Beams:GetChildren()) do
            if(v.Name:find("Warehouse")) then
                Player.Character.HumanoidRootPart.CFrame = Workspace.Beams[v.Name].CFrame;
                break;
            end;
        end;
    end
});

TeleportsTab:AddButton({
    Name = "AirDrop",
    Callback = function ()
        for _,v in pairs(Workspace.Beams:GetChildren()) do
            if(v.Name:find("Airdrop_")) then Player.Character.HumanoidRootPart.CFrame = v.CFrame; end;
        end;
    end
});

TeleportsTab:AddButton({
    Name = "Vehicle Crate",
    Callback = function ()
        Player.Character.HumanoidRootPart.CFrame = CFrame.new(Workspace.Beams.VehicleCrate.Position.X, Workspace.Beams.VehicleCrate.Position.Y + 20, Workspace.Beams.VehicleCrate.Position.Z);
    end
});

local playersTable = {};

for _,v in pairs(Workspace:GetChildren()) do
    for z, d in pairs(v:GetChildren()) do
        if(v.Name ~= Player.Name and d.Name == "Humanoid") then table.insert(playersTable, v.Name.." ("..Players[v.Name].leaderstats.Team.Value..")"); end;
    end;
end;

local playerDropdown = TeleportsTab:AddDropdown({
    Name = "Players",
    Options = playersTable,
    Callback = function (v)
        Player.Character.HumanoidRootPart.CFrame = Workspace[v].Head.CFrame;
    end
});

OrionLib:Init();

local function getSpeedHackValue ()
    return speedHackValue;
end;

while true do
    wait(0);
	Workspace[Player.Name].Humanoid.WalkSpeed = getSpeedHackValue();
    playersTable = {};
    for _,v in pairs(Workspace:GetChildren()) do
        for z, d in pairs(v:GetChildren()) do
            if(v.Name ~= Player.Name and d.Name == "Humanoid") then
                for b, a in pairs(Players[v.Name]:GetChildren()) do
                    if(a.Name == "leaderstats") then table.insert(playersTable, v.Name.." ("..a.Team.Value..")"); end;
                end;
            end;
        end;
    end;
    playerDropdown:Refresh(playersTable, true);
end;
