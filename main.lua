
-- MM2 by KSANEX v2.1
-- Main GUI | Purple Edition

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local guiParent = player:WaitForChild("PlayerGui")

local old = guiParent:FindFirstChild("KSANEX_MM2")
if old then old:Destroy() end

local gui = Instance.new("ScreenGui")
gui.Name = "KSANEX_MM2"
gui.ResetOnSpawn = false
gui.Parent = guiParent

local purple = Color3.fromRGB(155, 85, 235)

local main = Instance.new("Frame")
main.Size = UDim2.fromOffset(320, 390)
main.Position = UDim2.new(0.5, -160, 0.5, -195)
main.BackgroundColor3 = Color3.fromRGB(23, 19, 34)
main.BorderSizePixel = 0
main.Active = true
main.Parent = gui

Instance.new("UICorner", main).CornerRadius =
    UDim.new(0, 12)

local outline = Instance.new("UIStroke", main)
outline.Color = purple
outline.Thickness = 2

-- Header
local header = Instance.new("TextLabel")
header.Size = UDim2.new(1, 0, 0, 55)
header.BackgroundTransparency = 1
header.Text = "MM2 by KSANEX"
header.TextColor3 = Color3.fromRGB(210, 170, 255)
header.Font = Enum.Font.GothamBold
header.TextSize = 21
header.Parent = main

-- Drag window
local UIS = game:GetService("UserInputService")
local dragging = false
local dragStart
local startPosition

header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPosition = main.Position
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        main.Position = UDim2.new(
            startPosition.X.Scale,
            startPosition.X.Offset + delta.X,
            startPosition.Y.Scale,
            startPosition.Y.Offset + delta.Y
        )
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

local function createButton(text, y, callback)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0.88, 0, 0, 40)
    button.Position = UDim2.new(0.06, 0, 0, y)
    button.BackgroundColor3 = Color3.fromRGB(90, 48, 145)
    button.TextColor3 = Color3.new(1, 1, 1)
    button.Text = text
    button.Font = Enum.Font.GothamBold
    button.TextSize = 13
    button.Parent = main

    Instance.new("UICorner", button).CornerRadius =
        UDim.new(0, 8)

    button.Activated:Connect(callback)
    return button
end

-- ESP
local esp = false
local highlights = {}

local function updateESP()
    for _, item in pairs(highlights) do
        item:Destroy()
    end
    table.clear(highlights)

    if not esp then return end

    for _, target in ipairs(Players:GetPlayers()) do
        if target ~= player and target.Character then
            local h = Instance.new("Highlight")
            h.Adornee = target.Character
            h.FillColor = purple
            h.OutlineColor = Color3.new(1, 1, 1)
            h.FillTransparency = 0.7
            h.Parent = gui
            highlights[target] = h
        end
    end
end

local espButton = createButton("ESP: OFF", 70, function()
    esp = not esp
    espButton.Text = esp and "ESP: ON" or "ESP: OFF"
    updateESP()
end)

-- Player Names
local names = false
local tags = {}

local function updateNames()
    for _, tag in pairs(tags) do
        tag:Destroy()
    end
    table.clear(tags)

    if not names then return end

    for _, target in ipairs(Players:GetPlayers()) do
        if target ~= player and target.Character then
            local head = target.Character:FindFirstChild("Head")
            if head then
                local tag = Instance.new("BillboardGui")
                tag.Size = UDim2.fromOffset(150, 30)
                tag.StudsOffset = Vector3.new(0, 2.5, 0)
                tag.AlwaysOnTop = true
                tag.Adornee = head
                tag.Parent = gui

                local label = Instance.new("TextLabel")
                label.Size = UDim2.fromScale(1, 1)
                label.BackgroundTransparency = 1
                label.Text = target.DisplayName
                label.TextColor3 = Color3.fromRGB(210, 170, 255)
                label.TextStrokeTransparency = 0.3
                label.Font = Enum.Font.GothamBold
                label.TextSize = 13
                label.Parent = tag

                tags[target] = tag
            end
        end
    end
end

local namesButton = createButton("PLAYER NAMES: OFF", 120, function()
    names = not names
    namesButton.Text = names and "PLAYER NAMES: ON" or "PLAYER NAMES: OFF"
    updateNames()
end)

-- Role Info
createButton("ROLE INFO", 170, function()
    for _, target in ipairs(Players:GetPlayers()) do
        local role = target:GetAttribute("Role")
        print(target.Name .. ": " .. tostring(role or "Unknown"))
    end
end)

-- Round Timer
createButton("ROUND TIMER", 220, function()
    local timer = workspace:GetAttribute("RoundTimer")
    print("Round timer: " .. tostring(timer or "Unavailable"))
end)

-- Hide
createButton("HIDE MENU", 270, function()
    main.Visible = false
end)

-- Close
createButton("CLOSE HUB", 320, function()
    for _, item in pairs(highlights) do
        item:Destroy()
    end

    for _, tag in pairs(tags) do
        tag:Destroy()
    end

    gui:Destroy()
end)

print("MM2 by KSANEX v2.1 loaded!")
