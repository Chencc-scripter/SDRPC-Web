-- Roblox UI Loading System
-- Created by: Assistant

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Create ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "LoadingUI"
screenGui.Parent = playerGui
screenGui.IgnoreGuiInset = true -- 忽略安全区

-- Create UI Pages
local blackScreen = Instance.new("Frame")
blackScreen.Name = "BlackScreen"
blackScreen.Size = UDim2.new(1, 0, 1, 0)
blackScreen.BackgroundColor3 = Color3.new(0, 0, 0)
blackScreen.Parent = screenGui

local whiteScreen = Instance.new("Frame")
whiteScreen.Name = "WhiteScreen"
whiteScreen.Size = UDim2.new(1, 0, 1, 0)
whiteScreen.BackgroundColor3 = Color3.new(1, 1, 1)
whiteScreen.Visible = false
whiteScreen.Parent = screenGui

local logoScreen = Instance.new("Frame")
logoScreen.Name = "LogoScreen"
logoScreen.Size = UDim2.new(1, 0, 1, 0)
logoScreen.BackgroundColor3 = Color3.new(1, 1, 1)
logoScreen.Visible = false
logoScreen.Parent = screenGui

local logo = Instance.new("ImageLabel")
logo.Name = "Logo"
logo.Size = UDim2.new(0.5, 0, 0.5, 0)
logo.Position = UDim2.new(0.25, 0, 0.25, 0)
logo.BackgroundTransparency = 1
logo.Image = "rbxassetid://0" -- 占位符，后续替换为实际Logo
logo.Parent = logoScreen

local loadingScreen = Instance.new("Frame")
loadingScreen.Name = "LoadingScreen"
loadingScreen.Size = UDim2.new(1, 0, 1, 0)
loadingScreen.BackgroundColor3 = Color3.new(0, 0, 0)
loadingScreen.Visible = false
loadingScreen.Parent = screenGui

-- Loading Screen Elements
local titleText = Instance.new("TextLabel")
titleText.Name = "TitleText"
titleText.Size = UDim2.new(0.8, 0, 0.1, 0)
titleText.Position = UDim2.new(0.1, 0, 0.3, 0)
titleText.BackgroundTransparency = 1
titleText.Text = "中国人民解放军驻黄州市军事管理区"
titleText.TextColor3 = Color3.new(1, 0, 0)
titleText.TextSize = 36
titleText.TextWrapped = true
titleText.Parent = loadingScreen

local welcomeText = Instance.new("TextLabel")
welcomeText.Name = "WelcomeText"
welcomeText.Size = UDim2.new(0.8, 0, 0.1, 0)
welcomeText.Position = UDim2.new(0.1, 0, 0.45, 0)
welcomeText.BackgroundTransparency = 1
welcomeText.Text = "欢迎，" .. player.Name .. "!"
welcomeText.TextColor3 = Color3.new(1, 1, 1)
welcomeText.TextSize = 24
welcomeText.Parent = loadingScreen

local skipButton = Instance.new("TextButton")
skipButton.Name = "SkipButton"
skipButton.Size = UDim2.new(0.3, 0, 0.05, 0)
skipButton.Position = UDim2.new(0.35, 0, 0.55, 0)
skipButton.BackgroundTransparency = 0.7
skipButton.BackgroundColor3 = Color3.new(0, 0, 0)
skipButton.Text = "等不及了？点我跳过"
skipButton.TextColor3 = Color3.new(1, 1, 1)
skipButton.TextSize = 16
skipButton.Visible = false
skipButton.Parent = loadingScreen

local loadingBarContainer = Instance.new("Frame")
loadingBarContainer.Name = "LoadingBarContainer"
loadingBarContainer.Size = UDim2.new(0.8, 0, 0.03, 0)
loadingBarContainer.Position = UDim2.new(0.1, 0, 0.8, 0)
loadingBarContainer.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
loadingBarContainer.BorderSizePixel = 0
loadingBarContainer.CornerRadius = UDim.new(0, 10)
loadingBarContainer.Parent = loadingScreen

local loadingBar = Instance.new("Frame")
loadingBar.Name = "LoadingBar"
loadingBar.Size = UDim2.new(0, 0, 1, 0)
loadingBar.Position = UDim2.new(0, 0, 0, 0)
loadingBar.BackgroundColor3 = Color3.new(1, 1, 1)
loadingBar.BorderSizePixel = 0
loadingBar.CornerRadius = UDim.new(0, 10)
loadingBar.Parent = loadingBarContainer

local loadingText = Instance.new("TextLabel")
loadingText.Name = "LoadingText"
loadingText.Size = UDim2.new(1, 0, 0.5, 0)
loadingText.Position = UDim2.new(0, 0, -0.7, 0)
loadingText.BackgroundTransparency = 1
loadingText.Text = "加载中... 0%"
loadingText.TextColor3 = Color3.new(1, 1, 1)
loadingText.TextSize = 14
loadingText.Parent = loadingBarContainer

-- Background Image Carousel
local backgroundContainer = Instance.new("Frame")
backgroundContainer.Name = "BackgroundContainer"
backgroundContainer.Size = UDim2.new(1, 0, 1, 0)
backgroundContainer.Position = UDim2.new(0, 0, 0, 0)
backgroundContainer.BackgroundTransparency = 1
backgroundContainer.Parent = loadingScreen

local backgroundImages = {}
for i = 1, 6 do
    local bgImage = Instance.new("ImageLabel")
    bgImage.Name = "BackgroundImage" .. i
    bgImage.Size = UDim2.new(1, 0, 1, 0)
    bgImage.Position = UDim2.new(0, 0, 0, 0)
    bgImage.BackgroundTransparency = 1
    bgImage.Image = "rbxassetid://0" -- 占位符，后续替换为实际图片
    bgImage.Visible = false
    bgImage.Parent = backgroundContainer
    table.insert(backgroundImages, bgImage)
end

local overlay = Instance.new("Frame")
overlay.Name = "Overlay"
overlay.Size = UDim2.new(1, 0, 1, 0)
overlay.Position = UDim2.new(0, 0, 0, 0)
overlay.BackgroundColor3 = Color3.new(0, 0, 0)
overlay.BackgroundTransparency = 0.5
overlay.Parent = backgroundContainer

-- Main Menu Screen
local mainMenu = Instance.new("Frame")
mainMenu.Name = "MainMenu"
mainMenu.Size = UDim2.new(1, 0, 1, 0)
mainMenu.BackgroundColor3 = Color3.new(0, 0, 0)
mainMenu.Visible = false
mainMenu.Parent = screenGui

local mainBackground = Instance.new("ImageLabel")
mainBackground.Name = "MainBackground"
mainBackground.Size = UDim2.new(1, 0, 1, 0)
mainBackground.Position = UDim2.new(0, 0, 0, 0)
mainBackground.BackgroundTransparency = 1
mainBackground.Image = "rbxassetid://0" -- 占位符，后续替换为实际背景
mainBackground.Parent = mainMenu

local blurOverlay = Instance.new("Frame")
blurOverlay.Name = "BlurOverlay"
blurOverlay.Size = UDim2.new(1, 0, 1, 0)
blurOverlay.Position = UDim2.new(0, 0, 0, 0)
blurOverlay.BackgroundColor3 = Color3.new(0, 0, 0)
blurOverlay.BackgroundTransparency = 0.7
blurOverlay.Parent = mainMenu

-- Top Navigation Bar
local navBar = Instance.new("Frame")
navBar.Name = "NavBar"
navBar.Size = UDim2.new(1, 0, 0.1, 0)
navBar.Position = UDim2.new(0, 0, 0, 0)
navBar.BackgroundColor3 = Color3.new(0, 0, 0)
navBar.BackgroundTransparency = 0.8
navBar.Parent = mainMenu

local navButtons = {
    {name = "队伍", position = UDim2.new(0.1, 0, 0.25, 0)},
    {name = "商店", position = UDim2.new(0.3, 0, 0.25, 0)},
    {name = "首页", position = UDim2.new(0.5, 0, 0.25, 0)},
    {name = "服务器", position = UDim2.new(0.7, 0, 0.25, 0)},
    {name = "开发者", position = UDim2.new(0.9, 0, 0.25, 0)}
}

for _, buttonInfo in ipairs(navButtons) do
    local button = Instance.new("TextButton")
    button.Name = buttonInfo.name .. "Button"
    button.Size = UDim2.new(0.15, 0, 0.5, 0)
    button.Position = buttonInfo.position
    button.BackgroundTransparency = 0.7
    button.BackgroundColor3 = Color3.new(0, 0, 0)
    button.Text = buttonInfo.name
    button.TextColor3 = Color3.new(1, 1, 1)
    button.TextSize = 18
    button.Parent = navBar
end

-- Left Side Buttons
local leftPanel = Instance.new("Frame")
leftPanel.Name = "LeftPanel"
leftPanel.Size = UDim2.new(0.2, 0, 0.8, 0)
leftPanel.Position = UDim2.new(0, 0, 0.1, 0)
leftPanel.BackgroundTransparency = 1
leftPanel.Parent = mainMenu

local deployButton = Instance.new("TextButton")
deployButton.Name = "DeployButton"
deployButton.Size = UDim2.new(0.8, 0, 0.2, 0)
deployButton.Position = UDim2.new(0.1, 0, 0.1, 0)
deployButton.BackgroundColor3 = Color3.new(0, 0, 0)
deployButton.BackgroundTransparency = 0.7
deployButton.Text = "部署"
deployButton.TextColor3 = Color3.new(1, 1, 1)
deployButton.TextSize = 20
deployButton.Parent = leftPanel

local serverButton = Instance.new("TextButton")
serverButton.Name = "ServerButton"
serverButton.Size = UDim2.new(0.8, 0, 0.15, 0)
serverButton.Position = UDim2.new(0.1, 0, 0.35, 0)
serverButton.BackgroundColor3 = Color3.new(0, 0, 0)
serverButton.BackgroundTransparency = 0.7
serverButton.Text = "服务器"
serverButton.TextColor3 = Color3.new(1, 1, 1)
serverButton.TextSize = 18
serverButton.Parent = leftPanel

local creatorButton = Instance.new("TextButton")
creatorButton.Name = "CreatorButton"
creatorButton.Size = UDim2.new(0.8, 0, 0.15, 0)
creatorButton.Position = UDim2.new(0.1, 0, 0.55, 0)
creatorButton.BackgroundColor3 = Color3.new(0, 0, 0)
creatorButton.BackgroundTransparency = 0.7
creatorButton.Text = "创作者"
creatorButton.TextColor3 = Color3.new(1, 1, 1)
creatorButton.TextSize = 18
creatorButton.Parent = leftPanel

local shopButton = Instance.new("TextButton")
shopButton.Name = "ShopButton"
shopButton.Size = UDim2.new(0.8, 0, 0.2, 0)
shopButton.Position = UDim2.new(0.1, 0, 0.75, 0)
shopButton.BackgroundColor3 = Color3.new(0, 0, 0)
shopButton.BackgroundTransparency = 0.7
shopButton.Text = "商店"
shopButton.TextColor3 = Color3.new(1, 1, 1)
shopButton.TextSize = 20
shopButton.Parent = leftPanel

-- Animation Functions
local function fadeIn(element, duration)
    local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local tween = TweenService:Create(element, tweenInfo, {BackgroundTransparency = 0, TextTransparency = 0, ImageTransparency = 0})
    tween:Play()
    return tween
end

local function fadeOut(element, duration)
    local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local tween = TweenService:Create(element, tweenInfo, {BackgroundTransparency = 1, TextTransparency = 1, ImageTransparency = 1})
    tween:Play()
    return tween
end

local function slideIn(element, direction, duration)
    local startPos = element.Position
    local endPos = element.Position
    
    if direction == "left" then
        startPos = UDim2.new(-1, 0, endPos.Y.Scale, endPos.Y.Offset)
    elseif direction == "right" then
        startPos = UDim2.new(1, 0, endPos.Y.Scale, endPos.Y.Offset)
    elseif direction == "up" then
        startPos = UDim2.new(endPos.X.Scale, endPos.X.Offset, -1, 0)
    elseif direction == "down" then
        startPos = UDim2.new(endPos.X.Scale, endPos.X.Offset, 1, 0)
    end
    
    element.Position = startPos
    local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local tween = TweenService:Create(element, tweenInfo, {Position = endPos})
    tween:Play()
    return tween
end

-- Loading Function
local function loadAssets()
    local totalItems = 0
    local loadedItems = 0
    
    -- Count all models and parts in Workspace
    local function countItems(parent)
        for _, child in ipairs(parent:GetChildren()) do
            if child:IsA("Model") or child:IsA("Part") then
                totalItems = totalItems + 1
            end
            countItems(child)
        end
    end
    
    countItems(workspace)
    
    -- Simulate loading process
    local loadDelay = 0.1
    local maxLoadTime = 15
    local startTime = tick()
    
    while loadedItems < totalItems and tick() - startTime < maxLoadTime do
        wait(loadDelay)
        loadedItems = loadedItems + 1
        
        -- Update loading bar
        local progress = math.min(loadedItems / totalItems, 1)
        loadingBar.Size = UDim2.new(progress, 0, 1, 0)
        loadingText.Text = string.format("加载中... %.0f%%", progress * 100)
    end
    
    -- Ensure loading bar reaches 100%
    loadingBar.Size = UDim2.new(1, 0, 1, 0)
    loadingText.Text = "加载中... 100%"
end

-- Background Image Carousel
local function startBackgroundCarousel()
    local currentImage = 1
    local imageCount = #backgroundImages
    local displayTime = 3
    
    while loadingScreen.Visible do
        -- Show current image
        local image = backgroundImages[currentImage]
        image.Visible = true
        fadeIn(image, 1)
        
        -- Wait for display time
        wait(displayTime)
        
        -- Hide current image
        fadeOut(image, 1)
        wait(0.5)
        image.Visible = false
        
        -- Move to next image
        currentImage = currentImage % imageCount + 1
    end
end

-- Main Loading Sequence
local function mainLoadingSequence()
    -- Black screen for 5 seconds
    wait(5)
    
    -- Fade to white screen
    whiteScreen.Visible = true
    fadeIn(whiteScreen, 1)
    wait(1)
    
    -- Show logo screen
    logoScreen.Visible = true
    fadeIn(logo, 1)
    wait(3)
    
    -- Fade out logo
    fadeOut(logo, 1)
    wait(1)
    
    -- Fade to loading screen
    loadingScreen.Visible = true
    fadeIn(loadingScreen, 1)
    wait(1)
    
    -- Start background carousel
    spawn(startBackgroundCarousel)
    
    -- Show skip button after 15 seconds
    wait(15)
    skipButton.Visible = true
    fadeIn(skipButton, 0.5)
    
    -- Load assets
    loadAssets()
    
    -- Fade out loading screen
    fadeOut(loadingScreen, 1)
    wait(1)
    loadingScreen.Visible = false
    
    -- Show main menu
    mainMenu.Visible = true
    fadeIn(mainMenu, 1)
end

-- Skip button functionality
skipButton.MouseButton1Click:Connect(function()
    -- Fade out loading screen
    fadeOut(loadingScreen, 1)
    wait(1)
    loadingScreen.Visible = false
    
    -- Show main menu
    mainMenu.Visible = true
    fadeIn(mainMenu, 1)
end)

-- Start the loading sequence
mainLoadingSequence()