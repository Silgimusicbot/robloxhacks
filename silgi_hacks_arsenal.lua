-- SILGI HACKS Mod Menu

-- Variables
local player = game.Players.LocalPlayer
local camera = workspace.CurrentCamera
local runService = game:GetService("RunService")
local userInputService = game:GetService("UserInputService")
local espEnabled = false
local aimbotEnabled = false
local fov = 100
local aimbotMode = "Head"
local target = nil

-- ESP Function
local function drawESP(part, color, textSize, text)
    local esp = Drawing.new("Line")
    esp.Color = color
    esp.Thickness = 2
    esp.Transparency = 0.5
    esp.From = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 2)
    esp.To = Vector2.new(camera:WorldToViewportPoint(part.Position).X, camera:WorldToViewportPoint(part.Position).Y)
    esp.Visible = true
    
    local textLabel = Drawing.new("Text")
    textLabel.Text = text
    textLabel.Position = Vector2.new(camera:WorldToViewportPoint(part.Position).X, camera:WorldToViewportPoint(part.Position).Y)
    textLabel.Size = textSize
    textLabel.Color = color
    textLabel.OutlineColor = Color3.new(0, 0, 0)
    textLabel.Outline = true
    textLabel.Font = Drawing.Fonts.Plex
    textLabel.Visible = true
    
    table.insert(espList, esp)
    table.insert(textList, textLabel)
end

-- ESP Types
local espTypes = {
    ["Skeleton"] = true,
    ["Box"] = true,
    ["Name"] = true
}

-- Mod Menu
local modMenu = Instance.new("ScreenGui")
modMenu.Name = "SILGI HACKS"
modMenu.Parent = game.Players.LocalPlayer.PlayerGui

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 200, 0, 200)
mainFrame.Position = UDim2.new(0, 10, 0, 10)
mainFrame.BackgroundColor3 = Color3.new(0, 0, 0)
mainFrame.BackgroundTransparency = 0.5
mainFrame.Parent = modMenu

local title = Instance.new("TextLabel")
title.Text = "SILGI HACKS"
title.Font = Enum.Font.SourceSans
title.FontSize = Enum.FontSize.Size24
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundTransparency = 1
title.Parent = mainFrame

local espToggle = Instance.new("TextButton")
espToggle.Text = "ESP: OFF"
espToggle.Font = Enum.Font.SourceSans
espToggle.FontSize = Enum.FontSize.Size18
espToggle.TextColor3 = Color3.new(1, 1, 1)
espToggle.BackgroundColor3 = Color3.new(0, 0, 0)
espToggle.BackgroundTransparency = 0.5
espToggle.Parent = mainFrame

local aimbotToggle = Instance.new("TextButton")
aimbotToggle.Text = "Aimbot: OFF"
aimbotToggle.Font = Enum.Font.SourceSans
aimbotToggle.FontSize = Enum.FontSize.Size18
aimbotToggle.TextColor3 = Color3.new(1, 1, 1)
aimbotToggle.BackgroundColor3 = Color3.new(0, 0, 0)
aimbotToggle.BackgroundTransparency = 0.5
aimbotToggle.Parent = mainFrame

local fovSlider = Instance.new("Slider")
fovSlider.MinValue = 10
fovSlider.MaxValue = 200
fovSlider.Value = fov
fovSlider.Parent = mainFrame

local aimbotModeToggle = Instance.new("TextButton")
aimbotModeToggle.Text = "Aimbot Mode: Head"
aimbotModeToggle.Font = Enum.Font.SourceSans
aimbotModeToggle.FontSize = Enum.FontSize.Size18
aimbotModeToggle.TextColor3 = Color3.new(1, 1, 1)
aimbotModeToggle.BackgroundColor3 = Color3.new(0, 0, 0)
aimbotModeToggle.BackgroundTransparency = 0.5
aimbotModeToggle.Parent = mainFrame

local skeletonToggle = Instance.new("TextButton")
skeletonToggle.Text = "Skeleton: ON"
skeletonToggle.Font = Enum.Font.SourceSans
skeletonToggle.FontSize = Enum.FontSize.Size18
skeletonToggle.TextColor3 = Color3.new(1, 1, 1)
skeletonToggle.BackgroundColor3 = Color3.new(0, 0, 0)
skeletonToggle.BackgroundTransparency = 0.5
skeletonToggle.Parent = mainFrame

local boxToggle = Instance.new("TextButton")
boxToggle.Text = "Box: ON"
boxToggle.Font = Enum.Font.SourceSans
boxToggle.FontSize = Enum.FontSize.Size18
boxToggleboxToggle.TextColor3 = Color3.new(1, 1, 1)
boxToggle.BackgroundColor3 = Color3.new(0, 0, 0)
boxToggle.BackgroundTransparency = 0.5
boxToggle.Parent = mainFrame

local nameToggle = Instance.new("TextButton")
nameToggle.Text = "Name: ON"
nameToggle.Font = Enum.Font.SourceSans
nameToggle.FontSize = Enum.FontSize.Size18
nameToggle.TextColor3 = Color3.new(1, 1, 1)
nameToggle.BackgroundColor3 = Color3.new(0, 0, 0)
nameToggle.BackgroundTransparency = 0.5
nameToggle.Parent = mainFrame

-- ESP Toggle Function
espToggle.MouseButton1Click:Connect(function()
    if not espEnabled then
        espEnabled = true
        espToggle.Text = "ESP: ON"
        for _, v in pairs(game.Players:GetPlayers()) do
            if v ~= player and v.Character and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 then
                local character = v.Character
                local head = character:FindFirstChild("Head")
                local body = character:FindFirstChild("HumanoidRootPart")
                if espTypes["Skeleton"] then
                    drawESP(head, Color3.new(1, 0, 0), 12, v.Name)
                    drawESP(body, Color3.new(0, 1, 0), 12, v.Name)
                end
                if espTypes["Box"] then
                    local box = Drawing.new("Square")
                    box.Color = Color3.new(1, 1, 0)
                    box.Thickness = 2
                    box.Transparency = 0.5
                    box.Size = Vector2.new(10, 10)
                    box.Position = Vector2.new(camera:WorldToViewportPoint(body.Position).X, camera:WorldToViewportPoint(body.Position).Y)
                    box.Visible = true
                    table.insert(espList, box)
                end
                if espTypes["Name"] then
                    local nameLabel = Drawing.new("Text")
                    nameLabel.Text = v.Name
                    nameLabel.Position = Vector2.new(camera:WorldToViewportPoint(head.Position).X, camera:WorldToViewportPoint(head.Position).Y)
                    nameLabel.Size = 12
                    nameLabel.Color = Color3.new(1, 1, 1)
                    nameLabel.OutlineColor = Color3.new(0, 0, 0)
                    nameLabel.Outline = true
                    nameLabel.Font = Drawing.Fonts.Plex
                    nameLabel.Visible = true
                    table.insert(textList, nameLabel)
                end
            end
        end
    else
        espEnabled = false
        espToggle.Text = "ESP: OFF"
        for _, v in pairs(espList) do
            v.Visible = false
        end
        for _, v in pairs(textList) do
            v.Visible = false
        end
    end
end)

-- ESP Type Toggles
skeletonToggle.MouseButton1Click:Connect(function()
    if espTypes["Skeleton"] then
        espTypes["Skeleton"] = false
        skeletonToggle.Text = "Skeleton: OFF"
    else
        espTypes["Skeleton"] = true
        skeletonToggle.Text = "Skeleton: ON"
    end
end)

boxToggle.MouseButton1Click:Connect(function()
    if espTypes["Box"] then
        espTypes["Box"] = false
        boxToggle.Text = "Box: OFF"
    else
        espTypes["Box"] = true
        boxToggle.Text = "Box: ON"
    end
end)

nameToggle.MouseButton1Click:Connect(function()
    if espTypes["Name"] then
        espTypes["Name"] = false
        nameToggle.Text = "Name: OFF"
    else
        espTypes["Name"] = true
        nameToggle.Text = "Name: ON"
    end
end)

-- Aimbot Function
local function aimbot()
    if aimbotEnabled and target then
        local character = target.Character
        local head = character:FindFirstChild("Head")
        local body = character:FindFirstChild("HumanoidRootPart")
        local pos = (aimbotMode == "Head" and head or body).Position
        camera.CFrame = CFrame.new(camera.CFrame.Position, pos)
    end
end

-- Aimbot Toggle Function
aimbotToggle.MouseButton1Click:Connect(function()
    if not aimbotEnabled then
        aimbotEnabled = true
        aimbotToggle.Text = "Aimbot: ON"
    else
        aimbotEnabled = false
        aimbotToggle.Text = "Aimbot: OFF"
        target = nil
    end
end)

-- Aimbot Mode Toggle Function
aimbotModeToggle.MouseButton1Click:Connect(function()
    if aimbotMode == ""Head" then
        aimbotMode = "Body"
        aimbotModeToggle.Text = "Aimbot Mode: Body"
    else
        aimbotMode = "Head"
        aimbotModeToggle.Text = "Aimbot Mode: Head"
    end
end)

-- FOV Slider Function
fovSlider.Changed:Connect(function()
    fov = fovSlider.Value
end)

-- RightShift Toggle
userInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.RightShift then
        if modMenu.Enabled then
            local tween = tweenService:Create(modMenu, tweenInfo, {Position = UDim2.new(0, -200, 0, 10)})
            tween:Play()
            modMenu.Enabled = false
        else
            local tween = tweenService:Create(modMenu, tweenInfo, {Position = UDim2.new(0, 10, 0, 10)})
            tween:Play()
            modMenu.Enabled = true
        end
    end
end)

-- Right Mouse Button Hold
userInputService.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton2 then
        local closestPlayer
        local distance = math.huge
        for _, v in pairs(game.Players:GetPlayers()) do
            if v ~= player and v.Character and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 then
                local character = v.Character
                local head = character:FindFirstChild("Head")
                local body = character:FindFirstChild("HumanoidRootPart")
                local pos = (aimbotMode == "Head" and head or body).Position
                local magnitude = (pos - player.Character.HumanoidRootPart.Position).Magnitude
                if magnitude < distance and magnitude < fov then
                    distance = magnitude
                    closestPlayer = v
                end
            end
        end
        if closestPlayer then
            target = closestPlayer
        end
    end
end)

userInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton2 then
        target = nil
    end
end)

-- Run Aimbot Function
runService.Heartbeat:Connect(aimbot)

-- Initialize ESP List and Text List
local espList = {}
local textList = {}

-- Initialize Mod Menu Animation
local tweenService = game:GetService("TweenService")
local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local modMenuTween = tweenService:Create(modMenu, tweenInfo, {Position = UDim2.new(0, 10, 0, 10)})
modMenuTween:Play()
