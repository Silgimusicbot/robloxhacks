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

local backgroundImage = Instance.new("ImageLabel")
backgroundImage.Size = UDim2.new(0, 200, 0, 200)
backgroundImage.Position = UDim2.new(0, 0, 0, 0)
backgroundImage.Image = "file:///C:/Users/Admin/Downloads/images.jpg"
backgroundImage.Parent = mainFrame

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

-- ESP Toggle Function
espToggle.MouseButton1Click:Connect(function()
    if not espEnabled then
        espEnabled = true
        espToggle.Text = "ESP: ON"
        for _, v in pairs(game.Players:GetPlayers()) do
            if v ~= player and v.Characterand v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 then
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
    if aimbotMode == "Head" then
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
            modMenu.Enabled = false
            mainFrame:TweenPosition(UDim2.new(0, -200, 0, 10), "Out", "Quad", 0.5)
        else
            modMenu.Enabled = true
            mainFrame:TweenPosition(UDim2.new(0, 10, 0, 10), "Out", "Quad", 0.5)
        end
    endend
end)

-- Run the aimbot function every frame
runService.RenderStepped:Connect(aimbot)

-- Initialize the espList and textList tables
local espList = {}
local textList = {}

-- Initialize the target variable
target = nil

-- Set the camera's camera type to custom
camera.CameraType = Enum.CameraType.Custom

-- Set the camera's field of view
camera.FieldOfView = fov

-- Set the camera's camera mode to lock first person
camera.CameraMode = Enum.CameraMode.LockFirstPerson

-- Set the camera's head locked to true
camera.HeadLocked = true

-- Set the camera's head sensitivity to 0
camera.HeadSensitivity = 0

-- Set the camera's rotation to 0, 0, 0
camera.Rotation = Vector3.new(0, 0, 0)

-- Set the camera's position to 0, 0, 0
camera.Position = Vector3.new(0, 0, 0)

-- Set the camera's focus to the player's character
camera.Focus = player.Character.HumanoidRootPart

-- Set the camera's viewport size to the screen size
camera.ViewportSize = Vector2.new(1024, 576)

-- Set the camera's near clip plane to 0.1
camera.NearClipPlane = 0.1

-- Set the camera's far clip plane to 1000
camera.FarClipPlane = 1000

-- Set the camera's orthographic scale to 1
camera.OrthographicScale = 1

-- Set the camera's orthographic offset to 0, 0
camera.OrthographicOffset = Vector2.new(0, 0)

-- Set the camera's camera min zoom to 0.1
camera.CameraMinZoom = 0.1

-- Set the camera's camera max zoom to 10
camera.CameraMaxZoom = 10

-- Set the camera's camera zoom to 1
camera.CameraZoom = 1

-- Set the camera's camera field of view to 80
camera.CameraFieldOfView = 80

-- Set the camera's camera aspect ratio to 1.77777777777778
camera.CameraAspectRatio = 1.77777777777778

-- Set the camera's camera near clip plane to 0.1
camera.CameraNearClipPlane = 0.1

-- Set the camera's camera far clip plane to 1000
camera.CameraFarClipPlane = 1000

-- Set the camera's camera orthographic scale to 1
camera.CameraOrthographicScale = 1

-- Set the camera's camera orthographic offset to 0, 0
camera.CameraOrthographicOffset = Vector2.new(0, 0)

-- Set the camera's camera min zoom to 0.1
camera.CameraMinZoom = 0.1

-- Set the camera's camera max zoom to 10
camera.CameraMaxZoom = 10

-- Set the camera's camera zoom to 1
camera.CameraZoom = 1

-- Set the camera's camera field of view to 80
camera.CameraFieldOfView = 80

-- Set the camera's camera aspect ratio to 1.77777777777778
camera.CameraAspectRatio = 1.77777777777778
