--[[
    SILENT ASSASSIN - ULTIMATE SCRIPT (COMPLETE VERSION)
    Features: ESP Box, Teleport, Kill All, WalkSpeed, JumpPower
    Author: Ghost Dev
]]

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("SILENT ASSASSIN - TERMINATOR", "Midnight")

-- [TAB 1: CHIẾN ĐẤU - KILL ALL]
local Combat = Window:NewTab("Combat")
local CombatSection = Combat:NewSection("Annihilation Mode")

CombatSection:NewToggle("AUTO KILL ALL", "Dịch chuyển & Tiêu diệt liên tục", function(state)
    _G.KillAll = state
    spawn(function()
        while _G.KillAll do
            task.wait(0.1) -- Tốc độ quét mục tiêu
            for _, v in pairs(game.Players:GetPlayers()) do
                if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v.Character.Humanoid.Health > 0 then
                    -- Dịch chuyển ra sau lưng kẻ địch (Tránh bị bắn trả)
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
                    
                    -- Tự động cầm vũ khí và chém
                    local tool = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") or game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool")
                    if tool then
                        tool.Parent = game.Players.LocalPlayer.Character
                        tool:Activate()
                    end
                end
                if not _G.KillAll then break end
            end
        end
    end)
end)

-- [TAB 2: THỊ GIÁC - ESP]
local Visuals = Window:NewTab("Visuals")
local VisualSection = Visuals:NewSection("Wallhack & Tracking")

VisualSection:NewButton("ENABLE ESP BOX", "Nhìn xuyên tường (Khung đỏ)", function()
    for _, v in pairs(game.Players:GetPlayers()) do
        if v ~= game.Players.LocalPlayer and v.Character then
            -- Xóa ESP cũ nếu có
            if v.Character:FindFirstChild("ESP_Box") then v.Character.ESP_Box:Destroy() end
            
            local Box = Instance.new("BoxHandleAdornment")
            Box.Name = "ESP_Box"
            Box.Parent = v.Character:FindFirstChild("HumanoidRootPart")
            Box.Adornee = v.Character:FindFirstChild("HumanoidRootPart")
            Box.AlwaysOnTop = true
            Box.ZIndex = 10
            Box.Size = Vector3.new(4, 5, 1)
            Box.Transparency = 0.6
            Box.Color3 = Color3.fromRGB(255, 0, 0)
        end
    end
end)

-- [TAB 3: DI CHUYỂN - TELEPORT]
local Tele = Window:NewTab("Teleport")
local TeleSection = Tele:NewSection("Flash Move")

TeleSection:NewButton("Teleport to Target", "Dịch chuyển tới người chơi ngẫu nhiên", function()
    local p = game.Players:GetPlayers()
    local target = p[math.random(1, #p)]
    if target ~= game.Players.LocalPlayer and target.Character then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame
    end
end)

-- [TAB 4: CÀI ĐẶT NHÂN VẬT]
local Player = Window:NewTab("Player")
local PlayerSection = Player:NewSection("Physical Hack")

PlayerSection:NewSlider("WalkSpeed", "Tốc độ chạy", 250, 16, function(s)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s
end)

PlayerSection:NewSlider("JumpPower", "Lực nhảy", 200, 50, function(s)
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = s
end)

PlayerSection:NewButton("God Mode (Bản nhẹ)", "Chống chết (Tùy map)", function()
    game.Players.LocalPlayer.Character.Humanoid.MaxHealth = 999999
    game.Players.LocalPlayer.Character.Humanoid.Health = 999999
end)
