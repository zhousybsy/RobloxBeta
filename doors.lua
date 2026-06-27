-- ================  ================
local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/whenheer/uy/refs/heads/main/mainui.lua"))()

local Window = WindUI:CreateWindow({
        Title = "TnineHub<font color='#00FF00'>1.5</font>",
        Icon = "rbxassetid://4483362748",
        IconTransparency = 0.5,
        IconThemed = true,
        Author = "作者TnineHub",
        Folder = "CloudHub",
        Size = UDim2.fromOffset(400, 300),
        Transparent = true,
        Theme = "Light",
        User = {
            Enabled = true,
            Callback = function() print("clicked") end,
            Anonymous = false
        },
        SideBarWidth = 200,
        ScrollBarEnabled = true,
        Background = "rbxassetid://111122821357551"
    })
    

        Window:EditOpenButton({
            Title = " TnineHub脚本",
            Icon = "sword",
            CornerRadius = UDim.new(0, 16),
            StrokeThickness = 2,
            Color = ColorSequence.new(Color3.fromHex("FF0F7B"), Color3.fromHex("F89B29")),
            Draggable = true
        })
            
Window:Tag({
    Title = "TnineHub",
    Color = Color3.fromHex("#30ff6a")
})

Window:Tag({
        Title = "TnineHub", -- 标签汉化
        Color = Color3.fromHex("#315dff")
    })
    local TimeTag = Window:Tag({
        Title = "DOORS",
        Color = Color3.fromHex("#000000")
    })

local Tabs = {
    Main = Window:Section({ Title = "通用", Opened = true }),
    gn = Window:Section({ Title = "功能", Opened = true }),    
}

local TabHandles = {
    Elements = Tabs.Main:Tab({ Title = "玩家功能", Icon = "layout-grid" }),
    ESPgn = Tabs.gn:Tab({ Title = "视觉功能", Icon = "layout-grid" }),
    pbgn = Tabs.gn:Tab({ Title = "屏蔽实体", Icon = "layout-grid" }),
    tzgn = Tabs.gn:Tab({ Title = "通知功能", Icon = "layout-grid" }),
    fzgn = Tabs.gn:Tab({ Title = "辅助功能", Icon = "layout-grid" }),    
}


local intensitySlider = TabHandles.Elements:Slider({
    Title = "玩家速度",
    Desc = "speedwalk",
    Value = { Min = 0, Max = 1000, Default = 16 },
    Callback = function(Value)
        _G.WalkSpeedTp = Value
    end
})

local intensitySlider = TabHandles.Elements:Slider({
    Title = "玩家跳跃",
    Desc = "JumpPower",
    Value = { Min = 0, Max = 1000, Default = 50 },
    Callback = function(value)
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = value
    end
})

local intensitySlider = TabHandles.Elements:Slider({
    Title = "玩家重力",
    Desc = "gravity",
    Value = { Min = 0, Max = 1000, Default = 309 },
    Callback = function(value)
        game.Workspace.Gravity = value
    end
})

TabHandles.Elements:Divider()

local featureToggle = TabHandles.Elements:Toggle({
    Title = "夜视",
    Desc = "使你的游戏亮度提高",
    Value = false,
    Callback = function(state) 
        if state then
		    game.Lighting.Ambient = Color3.new(1, 1, 1)
            else
		    game.Lighting.Ambient = Color3.new(0, 0, 0)
            end
        WindUI:Notify({
            Title = "脚本中心：",
            Content = state and "夜视已开启，若仍不清楚可开启去雾功能" or "夜视已关闭",
            Icon = state and "check" or "x",
            Duration = 2
        })
    end
})

xrayEnabled = false
function xray()
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") and not v.Parent:FindFirstChildWhichIsA("Humanoid") and not v.Parent.Parent:FindFirstChildWhichIsA("Humanoid") then
            v.LocalTransparencyModifier = xrayEnabled and 0.5 or 0
        end
    end
end

local featureToggle = TabHandles.Elements:Toggle({
    Title = "地图透视",
    Desc = "Xray",
    Value = false,
    Callback = function(state) 
        if state then
		    xrayEnabled = true
    xray()
            else
		    xrayEnabled = false
    xray()
            end
        WindUI:Notify({
            Title = "脚本中心：",
            Content = state and "地图透视已开启，若仍不清楚可开启其他视觉功能" or "地图透视已关闭",
            Icon = state and "check" or "x",
            Duration = 2
        })
    end
})

local toggleState = false

game:GetService("Players").LocalPlayer.Idled:connect(function()
	game:GetService("VirtualUser"):Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
	wait(1)
	game:GetService("VirtualUser"):Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)
function NoFog()
    local c = game.Lighting
    c.FogEnd = 100000
    for r, v in pairs(c:GetDescendants()) do
        if v:IsA("Atmosphere") then
            v:Destroy()
        end
    end
end
TabHandles.Elements:Button({
    Title = "去雾",
    Desc = "一键去除游戏中的雾",
    Icon = "bell",
    Callback = function()
NoFog()
local Sound = Instance.new("Sound",game:GetService("SoundService"))
            Sound.SoundId = "rbxassetid://2865227271"
            Sound:Play()
        WindUI:Notify({
            Title = "脚本中心：",
            Content = "已去雾",
            Icon = "bell",
            Duration = 3
        })
    end
})
TabHandles.Elements:Divider()

TabHandles.Elements:Button({
    Title = "飞行",
    Desc = "传统的飞行",
    Icon = "bell",
    Callback = function()
loadstring(game:HttpGet("https://pastebin.com/raw/CPSm1udG"))()
local Sound = Instance.new("Sound",game:GetService("SoundService"))
            Sound.SoundId = "rbxassetid://2865227271"
            Sound:Play()
        WindUI:Notify({
            Title = "脚本中心：",
            Content = "成功加载飞行",
            Icon = "bell",
            Duration = 3
        })
    end
})

TabHandles.ESPgn:Toggle({
    Title = "全图高亮",
    Icon = "check",
    Value = false,
    Callback = function(Value) 

_G.FullBright = Value
while _G.FullBright do
game.Lighting.Brightness = 2
game.Lighting.ClockTime = 14
game.Lighting.FogEnd = 100000
game.Lighting.GlobalShadows = false
game.Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
task.wait()
end
for i, v in pairs(_G.GetOldBright) do
game.Lighting[i] = v
end

WindUI:Notify({
            Title = "脚本中心：",
            Content = "已开启全图高亮",
            Icon = "bell",
            IconThemed = true, -- automatic color icon to theme 
            Duration = 5,
        })
	 end
})

TabHandles.ESPgn:Toggle({
    Title = "去雾",
    Icon = "check",
    Value = false,
    Callback = function(Value) 

_G.Nofog = Value
while _G.Nofog do
game:GetService("Lighting").FogStart = 100000
game:GetService("Lighting").FogEnd = 200000
for i, v in pairs(game:GetService("Lighting"):GetChildren()) do
if v.ClassName == "Atmosphere" then
v.Density = 0
v.Haze = 0
end
end
task.wait()
end
game:GetService("Lighting").FogStart = 0
game:GetService("Lighting").FogEnd = 1000
for i, v in pairs(game:GetService("Lighting"):GetChildren()) do
if v.ClassName == "Atmosphere" then
v.Density = 0.3
v.Haze = 1
end
end

WindUI:Notify({
            Title = "脚本中心：",
            Content = "已开启全图高亮",
            Icon = "bell",
            IconThemed = true, -- automatic color icon to theme 
            Duration = 5,
        })
	 end
})


if not isGarden then
TabHandles.ESPgn:Toggle({
    Title = "钥匙",
    Icon = "check",
    Value = false,
    Callback = function(Value) 

_G.EspKey = Value
if _G.EspKey == false then
_G.KeyAdd = {}
if KeySpawn then
KeySpawn:Disconnect()
KeySpawn = nil
end
if KeyRemove then
KeyRemove:Disconnect()
KeyRemove = nil
end
for _, v in pairs(workspace:GetDescendants()) do 
if v.Name:find("Key") or v.Name == "LeverForGate" or v.Name:find("FuseObtain") then
for i, z in pairs(v:GetChildren()) do
if z.Name:find("Esp_") then
z:Destroy()
end
end
end
end
else
function Keys(v)
if ((v.Name:find("Key") or v.Name:find("FuseObtain")) and v:FindFirstChild("Hitbox")) or (v.Name == "LeverForGate" and v.PrimaryPart) then
if v:FindFirstChild("Esp_Highlight") then
	v:FindFirstChild("Esp_Highlight").FillColor = Color3.fromRGB(0, 0, 255)
	v:FindFirstChild("Esp_Highlight").OutlineColor = Color3.fromRGB(0, 0, 255)
end
if _G.EspHighlight == true and v:FindFirstChild("Esp_Highlight") == nil then
	local Highlight = Instance.new("Highlight")
	Highlight.Name = "Esp_Highlight"
	Highlight.FillColor = Color3.fromRGB(0, 0, 255) 
	Highlight.OutlineColor = Color3.fromRGB(0, 0, 255) 
	Highlight.FillTransparency = 0.5
	Highlight.OutlineTransparency = 0
	Highlight.Adornee = v
	Highlight.Parent = v
	elseif _G.EspHighlight == false and v:FindFirstChild("Esp_Highlight") then
	v:FindFirstChild("Esp_Highlight"):Destroy()
end
if v:FindFirstChild("Esp_Gui") and v["Esp_Gui"]:FindFirstChild("TextLabel") then
	v["Esp_Gui"]:FindFirstChild("TextLabel").Text = 
	        (_G.EspName == true and ((v.Name == "LeverForGate" and "拉杆") or (v.Name:find("Key") and "钥匙") or (v.Name:find("FuseObtain") and "保险丝")) or "")..
            (_G.EspDistance == true and "\n距离: ("..string.format("%.0f", Distance((v.Name == "LeverForGate" and v.PrimaryPart.Position) or ((v.Name:find("Key") or v.Name:find("FuseObtain")) and v.Hitbox.Position))).."m)" or "")
    v["Esp_Gui"]:FindFirstChild("TextLabel").TextSize = _G.EspGuiTextSize or 15
    v["Esp_Gui"]:FindFirstChild("TextLabel").TextColor3 = _G.EspGuiTextColor or Color3.new(255, 255, 255)
end
if _G.EspGui == true and v:FindFirstChild("Esp_Gui") == nil then
	GuiEsp = Instance.new("BillboardGui", v)
	GuiEsp.Adornee = v
	GuiEsp.Name = "Esp_Gui"
	GuiEsp.Size = UDim2.new(0, 100, 0, 150)
	GuiEsp.AlwaysOnTop = true
	GuiEspText = Instance.new("TextLabel", GuiEsp)
	GuiEspText.BackgroundTransparency = 1
	GuiEspText.Font = Enum.Font.Code
	GuiEspText.Size = UDim2.new(0, 100, 0, 100)
	GuiEspText.TextSize = 15
	GuiEspText.TextColor3 = Color3.new(0,0,0) 
	GuiEspText.TextStrokeTransparency = 0.5
	GuiEspText.Text = ""
	local UIStroke = Instance.new("UIStroke")
	UIStroke.Color = Color3.new(0, 0, 0)
	UIStroke.Thickness = 1.5
	UIStroke.Parent = GuiEspText
	elseif _G.EspGui == false and v:FindFirstChild("Esp_Gui") then
	v:FindFirstChild("Esp_Gui"):Destroy()
end
end
end
local function CheckKey(v)
    if not table.find(_G.KeyAdd, v) and ((v.Name:find("Key") or v.Name:find("FuseObtain")) and v:FindFirstChild("Hitbox")) or (v.Name == "LeverForGate" and v.PrimaryPart) then
        table.insert(_G.KeyAdd, v)
    end
end
for _, v in ipairs(workspace:GetDescendants()) do
	CheckKey(v)
end
KeySpawn = workspace.DescendantAdded:Connect(function(v)
    CheckKey(v)
end)
KeyRemove = workspace.DescendantRemoving:Connect(function(v)
    for i = #_G.KeyAdd, 1, -1 do
        if _G.KeyAdd[i] == v then
            table.remove(_G.KeyAdd, i)
            break
        end
    end
end)
end
while _G.EspKey do
for i, v in pairs(_G.KeyAdd) do
if v:IsA("Model") then
Keys(v)
end
end
task.wait()
end

WindUI:Notify({
            Title = "脚本中心：",
            Content = Value and "已开启透视" or "已关闭透视",
            Icon = Value and "check" or "x",
            IconThemed = true, -- automatic color icon to theme 
            Duration = 5,
        })
	 end
})
end

TabHandles.ESPgn:Toggle({
    Title = "门透视",
    Icon = "check",
    Value = false,
    Callback = function(Value) 

_G.EspDoor = Value
if _G.EspDoor == false then
for _, v in pairs(game.Workspace:FindFirstChild("CurrentRooms"):GetChildren()) do 
if v:isA("Model") then
for i, z in pairs(v:GetChildren()) do
if z.Name:find("Esp_") then
z:Destroy()
end
end
end
end
end
while _G.EspDoor do
for i, v in pairs(game.Workspace:FindFirstChild("CurrentRooms"):GetChildren()) do
if v:IsA("Model") and v:FindFirstChild("Door") and v.Door:FindFirstChild("Door") then
if v:FindFirstChild("Esp_Highlight") then
	v:FindFirstChild("Esp_Highlight").FillColor = Color3.fromRGB(0, 255, 0)
	v:FindFirstChild("Esp_Highlight").OutlineColor = Color3.fromRGB(0, 255, 0)
end
if _G.EspHighlight == true and v:FindFirstChild("Esp_Highlight") == nil then
	local Highlight = Instance.new("Highlight")
	Highlight.Name = "Esp_Highlight"
	Highlight.FillColor = Color3.fromRGB(0, 255, 0) 
	Highlight.OutlineColor = Color3.fromRGB(0, 255, 0) 
	Highlight.FillTransparency = 0.5
	Highlight.OutlineTransparency = 0
	Highlight.Adornee = v.Door
	Highlight.Parent = v
	elseif _G.EspHighlight == false and v:FindFirstChild("Esp_Highlight") then
	v:FindFirstChild("Esp_Highlight"):Destroy()
end
if v:FindFirstChild("Esp_Gui") and v["Esp_Gui"]:FindFirstChild("TextLabel") then
	v["Esp_Gui"]:FindFirstChild("TextLabel").Text = 
	        (_G.EspName == true and "门 "..((v.Door:FindFirstChild("Sign") and v.Door.Sign:FindFirstChild("Stinker") and v.Door.Sign.Stinker.Text) or (v.Door.Sign:FindFirstChild("SignText") and v.Door.Sign.SignText.Text)):gsub("^0+", "")..(v.Door:FindFirstChild("Lock") and " (锁住)" or "") or "")..
            (_G.EspDistance == true and "\n距离: ("..string.format("%.0f", Distance(v.Door.Door.Position)).."m)" or "")
    v["Esp_Gui"]:FindFirstChild("TextLabel").TextSize = _G.EspGuiTextSize or 15
    v["Esp_Gui"]:FindFirstChild("TextLabel").TextColor3 = _G.EspGuiTextColor or Color3.new(255, 255, 255)
end
if _G.EspGui == true and v:FindFirstChild("Esp_Gui") == nil then
	GuiEsp = Instance.new("BillboardGui", v)
	GuiEsp.Adornee = v.Door
	GuiEsp.Name = "Esp_Gui"
	GuiEsp.Size = UDim2.new(0, 100, 0, 150)
	GuiEsp.AlwaysOnTop = true
	GuiEspText = Instance.new("TextLabel", GuiEsp)
	GuiEspText.BackgroundTransparency = 1
	GuiEspText.Font = Enum.Font.Code
	GuiEspText.Size = UDim2.new(0, 100, 0, 100)
	GuiEspText.TextSize = 15
	GuiEspText.TextColor3 = Color3.new(0,0,0) 
	GuiEspText.TextStrokeTransparency = 0.5
	GuiEspText.Text = ""
	local UIStroke = Instance.new("UIStroke")
	UIStroke.Color = Color3.new(0, 0, 0)
	UIStroke.Thickness = 1.5
	UIStroke.Parent = GuiEspText
	elseif _G.EspGui == false and v:FindFirstChild("Esp_Gui") then
	v:FindFirstChild("Esp_Gui"):Destroy()
end
end
end
task.wait()
end

WindUI:Notify({
            Title = "脚本中心：",
            Content = state and "已开启透视" or "已关闭透视",
            Icon = state and "check" or "x",
            IconThemed = true, -- automatic color icon to theme 
            Duration = 5,
        })
	 end
})

if isBackdoor then
local Toggle = Tab:Toggle({
    Title = "透视时间拉杆",
    Icon = "check",
    Value = false,
    Callback = function(Value) 

_G.EspLeverTime = Value
if _G.EspLeverTime == false then
_G.TimeLeverAdd = {}
if TimeLeverSpawn then
TimeLeverSpawn:Disconnect()
TimeLeverSpawn = nil
end
if TimeLeverRemove then
TimeLeverRemove:Disconnect()
TimeLeverRemove = nil
end
for _, v in pairs(workspace:GetDescendants()) do 
if v.Name:find("TimerLever") then
for i, z in pairs(v:GetChildren()) do
if z.Name:find("Esp_") then
z:Destroy()
end
end
end
end
else
function LeverTimes(v)
if v.Name:find("TimerLever") and v.PrimaryPart then
if v:FindFirstChild("Esp_Highlight") then
	v:FindFirstChild("Esp_Highlight").FillColor = Color3.fromRGB(0, 0, 255)
	v:FindFirstChild("Esp_Highlight").OutlineColor = Color3.fromRGB(0, 0, 255)
end
if _G.EspHighlight == true and v:FindFirstChild("Esp_Highlight") == nil then
	local Highlight = Instance.new("Highlight")
	Highlight.Name = "Esp_Highlight"
	Highlight.FillColor = Color3.fromRGB(0, 0, 255) 
	Highlight.OutlineColor = Color3.fromRGB(0, 0, 255) 
	Highlight.FillTransparency = 0.5
	Highlight.OutlineTransparency = 0
	Highlight.Adornee = v
	Highlight.Parent = v
	elseif _G.EspHighlight == false and v:FindFirstChild("Esp_Highlight") then
	v:FindFirstChild("Esp_Highlight"):Destroy()
end
if v:FindFirstChild("Esp_Gui") and v["Esp_Gui"]:FindFirstChild("TextLabel") then
	v["Esp_Gui"]:FindFirstChild("TextLabel").Text = 
	        (_G.EspName == true and "时间拉杆" or "")..
            (_G.EspDistance == true and "\n距离: ("..string.format("%.0f", Distance(v.PrimaryPart.Position)).."m)" or "")
    v["Esp_Gui"]:FindFirstChild("TextLabel").TextSize = _G.EspGuiTextSize or 15
    v["Esp_Gui"]:FindFirstChild("TextLabel").TextColor3 = _G.EspGuiTextColor or Color3.new(255, 255, 255)
end
if _G.EspGui == true and v:FindFirstChild("Esp_Gui") == nil then
	GuiEsp = Instance.new("BillboardGui", v)
	GuiEsp.Adornee = v
	GuiEsp.Name = "Esp_Gui"
	GuiEsp.Size = UDim2.new(0, 100, 0, 150)
	GuiEsp.AlwaysOnTop = true
	GuiEspText = Instance.new("TextLabel", GuiEsp)
	GuiEspText.BackgroundTransparency = 1
	GuiEspText.Font = Enum.Font.Code
	GuiEspText.Size = UDim2.new(0, 100, 0, 100)
	GuiEspText.TextSize = 15
	GuiEspText.TextColor3 = Color3.new(0,0,0) 
	GuiEspText.TextStrokeTransparency = 0.5
	GuiEspText.Text = ""
	local UIStroke = Instance.new("UIStroke")
	UIStroke.Color = Color3.new(0, 0, 0)
	UIStroke.Thickness = 1.5
	UIStroke.Parent = GuiEspText
	elseif _G.EspGui == false and v:FindFirstChild("Esp_Gui") then
	v:FindFirstChild("Esp_Gui"):Destroy()
end
end
end
local function CheckTimeLever(v)
    if not table.find(_G.TimeLeverAdd, v) and v.Name == "TimerLever" then
        table.insert(_G.TimeLeverAdd, v)
    end
end
for _, v in ipairs(workspace:GetDescendants()) do
	CheckTimeLever(v)
end
TimeLeverSpawn = workspace.DescendantAdded:Connect(function(v)
    CheckTimeLever(v)
end)
TimeLeverRemove = workspace.DescendantRemoving:Connect(function(v)
    for i = #_G.TimeLeverAdd, 1, -1 do
        if _G.TimeLeverAdd[i] == v then
            table.remove(_G.TimeLeverAdd, i)
            break
        end
    end
end)
end
while _G.EspLeverTime do
for i, v in pairs(_G.TimeLeverAdd) do
if v:IsA("Model") then
LeverTimes(v)
end
end
task.wait()
end

WindUI:Notify({
            Title = "脚本中心：",
            Content = Value and "已开启透视" or "已关闭透视",
            Icon = Value and "check" or "x",
            IconThemed = true, -- automatic color icon to theme 
            Duration = 5,
        })
	 end
})
end

if isHotel then
TabHandles.ESPgn:Toggle({
    Title = "透视书",
    Icon = "check",
    Value = false,
    Callback = function(Value) 

_G.EspBook = Value
if _G.EspBook == false then
_G.BookAdd = {}
if BookSpawn then
BookSpawn:Disconnect()
BookSpawn = nil
end
if BookRemove then
BookRemove:Disconnect()
BookRemove = nil
end
for _, v in pairs(workspace:GetDescendants()) do 
if v.Name:find("LiveHintBook") then
for i, z in pairs(v:GetChildren()) do
if z.Name:find("Esp_") then
z:Destroy()
end
end
end
end
else
function Books(v)
if v.Name:find("LiveHintBook") and v.PrimaryPart then
if v:FindFirstChild("Esp_Highlight") then
	v:FindFirstChild("Esp_Highlight").FillColor = Color3.fromRGB(160, 32, 240)
	v:FindFirstChild("Esp_Highlight").OutlineColor = Color3.fromRGB(160, 32, 240)
end
if _G.EspHighlight == true and v:FindFirstChild("Esp_Highlight") == nil then
	local Highlight = Instance.new("Highlight")
	Highlight.Name = "Esp_Highlight"
	Highlight.FillColor = Color3.fromRGB(160, 32, 240) 
	Highlight.OutlineColor = Color3.fromRGB(160, 32, 240) 
	Highlight.FillTransparency = 0.5
	Highlight.OutlineTransparency = 0
	Highlight.Adornee = v
	Highlight.Parent = v
	elseif _G.EspHighlight == false and v:FindFirstChild("Esp_Highlight") then
	v:FindFirstChild("Esp_Highlight"):Destroy()
end
if v:FindFirstChild("Esp_Gui") and v["Esp_Gui"]:FindFirstChild("TextLabel") then
	v["Esp_Gui"]:FindFirstChild("TextLabel").Text = 
	        (_G.EspName == true and "书" or "")..
            (_G.EspDistance == true and "\n距离: ("..string.format("%.0f", Distance(v.PrimaryPart.Position)).."m)" or "")
    v["Esp_Gui"]:FindFirstChild("TextLabel").TextSize = _G.EspGuiTextSize or 10
    v["Esp_Gui"]:FindFirstChild("TextLabel").TextColor3 = _G.EspGuiTextColor or Color3.new(255, 255, 255)
end
if _G.EspGui == true and v:FindFirstChild("Esp_Gui") == nil then
	GuiEsp = Instance.new("BillboardGui", v)
	GuiEsp.Adornee = v
	GuiEsp.Name = "Esp_Gui"
	GuiEsp.Size = UDim2.new(0, 100, 0, 150)
	GuiEsp.AlwaysOnTop = true
	GuiEspText = Instance.new("TextLabel", GuiEsp)
	GuiEspText.BackgroundTransparency = 1
	GuiEspText.Font = Enum.Font.Code
	GuiEspText.Size = UDim2.new(0, 100, 0, 100)
	GuiEspText.TextSize = 15
	GuiEspText.TextColor3 = Color3.new(0,0,0) 
	GuiEspText.TextStrokeTransparency = 0.5
	GuiEspText.Text = ""
	local UIStroke = Instance.new("UIStroke")
	UIStroke.Color = Color3.new(0, 0, 0)
	UIStroke.Thickness = 1.5
	UIStroke.Parent = GuiEspText
	elseif _G.EspGui == false and v:FindFirstChild("Esp_Gui") then
	v:FindFirstChild("Esp_Gui"):Destroy()
end
end
end
local function CheckBook(v)
    if not table.find(_G.BookAdd, v) and v.Name == "LiveHintBook" then
        table.insert(_G.BookAdd, v)
    end
end
for _, v in ipairs(workspace:GetDescendants()) do
	CheckBook(v)
end
BookSpawn = workspace.DescendantAdded:Connect(function(v)
    CheckBook(v)
end)
BookRemove = workspace.DescendantRemoving:Connect(function(v)
    for i = #_G.BookAdd, 1, -1 do
        if _G.BookAdd[i] == v then
            table.remove(_G.BookAdd, i)
            break
        end
    end
end)
end
while _G.EspBook do
for i, v in pairs(_G.BookAdd) do
if v:IsA("Model") then
Books(v)
end
end
task.wait()
end

WindUI:Notify({
            Title = "脚本中心：",
            Content = Value and "已开启透视" or "已关闭透视",
            Icon = Value and "check" or "x",
            IconThemed = true, -- automatic color icon to theme 
            Duration = 5,
        })
	 end
})

TabHandles.ESPgn:Toggle({
    Title = "透视电箱",
    Icon = "check",
    Value = false,
    Callback = function(Value) 

_G.EspBreaker = Value
if _G.EspBreaker == false then
_G.BreakerAdd = {}
if BreakerSpawn then
BreakerSpawn:Disconnect()
BreakerSpawn = nil
end
if BreakerRemove then
BreakerRemove:Disconnect()
BreakerRemove = nil
end
for _, v in pairs(workspace:GetDescendants()) do 
if v.Name:find("LiveBreakerPolePickup") then
for i, z in pairs(v:GetChildren()) do
if z.Name:find("Esp_") then
z:Destroy()
end
end
end
end
else
function Breakers(v)
if v.Name == "LiveBreakerPolePickup" and v:FindFirstChildOfClass("ProximityPrompt") then
if v:FindFirstChild("Esp_Highlight") then
	v:FindFirstChild("Esp_Highlight").FillColor = Color3.fromRGB(25, 25, 112)
	v:FindFirstChild("Esp_Highlight").OutlineColor = Color3.fromRGB(25, 25, 112)
end
if _G.EspHighlight == true and v:FindFirstChild("Esp_Highlight") == nil then
	local Highlight = Instance.new("Highlight")
	Highlight.Name = "Esp_Highlight"
	Highlight.FillColor = Color3.fromRGB(25, 25, 112) 
	Highlight.OutlineColor = Color3.fromRGB(25, 25, 112) 
	Highlight.FillTransparency = 0.5
	Highlight.OutlineTransparency = 0
	Highlight.Adornee = v
	Highlight.Parent = v
	elseif _G.EspHighlight == false and v:FindFirstChild("Esp_Highlight") then
	v:FindFirstChild("Esp_Highlight"):Destroy()
end
if v:FindFirstChild("Esp_Gui") and v["Esp_Gui"]:FindFirstChild("TextLabel") then
	v["Esp_Gui"]:FindFirstChild("TextLabel").Text = 
	        (_G.EspName == true and "电箱" or "")..
            (_G.EspDistance == true and "\n距离: ("..string.format("%.0f", Distance(v.PrimaryPart.Position)).."m)" or "")
    v["Esp_Gui"]:FindFirstChild("TextLabel").TextSize = _G.EspGuiTextSize or 10
    v["Esp_Gui"]:FindFirstChild("TextLabel").TextColor3 = _G.EspGuiTextColor or Color3.new(255, 255, 255)
end
if _G.EspGui == true and v:FindFirstChild("Esp_Gui") == nil then
	GuiEsp = Instance.new("BillboardGui", v)
	GuiEsp.Adornee = v
	GuiEsp.Name = "Esp_Gui"
	GuiEsp.Size = UDim2.new(0, 100, 0, 150)
	GuiEsp.AlwaysOnTop = true
	GuiEspText = Instance.new("TextLabel", GuiEsp)
	GuiEspText.BackgroundTransparency = 1
	GuiEspText.Font = Enum.Font.Code
	GuiEspText.Size = UDim2.new(0, 100, 0, 100)
	GuiEspText.TextSize = 15
	GuiEspText.TextColor3 = Color3.new(0,0,0) 
	GuiEspText.TextStrokeTransparency = 0.5
	GuiEspText.Text = ""
	local UIStroke = Instance.new("UIStroke")
	UIStroke.Color = Color3.new(0, 0, 0)
	UIStroke.Thickness = 1.5
	UIStroke.Parent = GuiEspText
	elseif _G.EspGui == false and v:FindFirstChild("Esp_Gui") then
	v:FindFirstChild("Esp_Gui"):Destroy()
end
end
end
local function CheckBreaker(v)
    if not table.find(_G.BreakerAdd, v) and v.Name == "LiveBreakerPolePickup" then
        table.insert(_G.BreakerAdd, v)
    end
end
for _, v in ipairs(workspace:GetDescendants()) do
	CheckBreaker(v)
end
BreakerSpawn = workspace.DescendantAdded:Connect(function(v)
    CheckBreaker(v)
end)
BreakerRemove = workspace.DescendantRemoving:Connect(function(v)
for i = #_G.BreakerAdd, 1, -1 do
    if _G.BreakerAdd[i] == v then
        table.remove(_G.BreakerAdd, i)
        break
    end
end
end)
end
while _G.EspBreaker do
for i, v in pairs(_G.BreakerAdd) do
if v.Name == "LiveBreakerPolePickup" then
Breakers(v)
end
end
task.wait()
end

WindUI:Notify({
            Title = "脚本中心：",
            Content = Value and "已开启透视" or "已关闭透视",
            Icon = Value and "check" or "x",
            IconThemed = true, -- automatic color icon to theme 
            Duration = 5,
        })
	 end
})
end

TabHandles.ESPgn:Toggle({
    Title = "透视物品",
    Icon = "check",
    Value = false,
    Callback = function(Value) 

_G.EspItem = Value
if _G.EspItem == false then
_G.ItemAdd = {}
if ItemSpawn then
ItemSpawn:Disconnect()
ItemSpawn = nil
end
if ItemRemove then
ItemRemove:Disconnect()
ItemRemove = nil
end
for _, v in pairs(workspace:GetDescendants()) do 
if v.Name:find("Handle") then
for i, z in pairs(v:GetChildren()) do
if z.Name:find("Esp_") then
z:Destroy()
end
end
end
end
else
function Items(v)
if v.Name == "Handle" and v.Parent:FindFirstChildOfClass("ProximityPrompt") then
if v:FindFirstChild("Esp_Highlight") then
	v:FindFirstChild("Esp_Highlight").FillColor = Color3.fromRGB(255, 215, 0)
	v:FindFirstChild("Esp_Highlight").OutlineColor = Color3.fromRGB(255, 215, 0)
end
if _G.EspHighlight == true and v:FindFirstChild("Esp_Highlight") == nil then
	local Highlight = Instance.new("Highlight")
	Highlight.Name = "Esp_Highlight"
	Highlight.FillColor = Color3.fromRGB(255, 215, 0) 
	Highlight.OutlineColor = Color3.fromRGB(255, 215, 0) 
	Highlight.FillTransparency = 0.5
	Highlight.OutlineTransparency = 0
	Highlight.Adornee = v.Parent
	Highlight.Parent = v
	elseif _G.EspHighlight == false and v:FindFirstChild("Esp_Highlight") then
	v:FindFirstChild("Esp_Highlight"):Destroy()
end
if v:FindFirstChild("Esp_Gui") and v["Esp_Gui"]:FindFirstChild("TextLabel") then
	v["Esp_Gui"]:FindFirstChild("TextLabel").Text = 
	        (_G.EspName == true and v.Parent.Name or "")..
            (_G.EspDistance == true and "\n距离: ("..string.format("%.0f", Distance(v.Position)).."m)" or "")
    v["Esp_Gui"]:FindFirstChild("TextLabel").TextSize = _G.EspGuiTextSize or 10
    v["Esp_Gui"]:FindFirstChild("TextLabel").TextColor3 = _G.EspGuiTextColor or Color3.new(255, 255, 255)
end
if _G.EspGui == true and v:FindFirstChild("Esp_Gui") == nil then
	GuiEsp = Instance.new("BillboardGui", v)
	GuiEsp.Adornee = v.Parent
	GuiEsp.Name = "Esp_Gui"
	GuiEsp.Size = UDim2.new(0, 100, 0, 150)
	GuiEsp.AlwaysOnTop = true
	GuiEspText = Instance.new("TextLabel", GuiEsp)
	GuiEspText.BackgroundTransparency = 1
	GuiEspText.Font = Enum.Font.Code
	GuiEspText.Size = UDim2.new(0, 100, 0, 100)
	GuiEspText.TextSize = 15
	GuiEspText.TextColor3 = Color3.new(0,0,0) 
	GuiEspText.TextStrokeTransparency = 0.5
	GuiEspText.Text = ""
	local UIStroke = Instance.new("UIStroke")
	UIStroke.Color = Color3.new(0, 0, 0)
	UIStroke.Thickness = 1.5
	UIStroke.Parent = GuiEspText
	elseif _G.EspGui == false and v:FindFirstChild("Esp_Gui") then
	v:FindFirstChild("Esp_Gui"):Destroy()
end
end
end
local function CheckItem(v)
    if not table.find(_G.ItemAdd, v) and v.Name == "Handle" then
        table.insert(_G.ItemAdd, v)
    end
end
for _, v in ipairs(workspace:GetDescendants()) do
	CheckItem(v)
end
ItemSpawn = workspace.DescendantAdded:Connect(function(v)
    CheckItem(v)
end)
ItemRemove = workspace.DescendantRemoving:Connect(function(v)
for i = #_G.ItemAdd, 1, -1 do
    if _G.ItemAdd[i] == v then
        table.remove(_G.ItemAdd, i)
        break
    end
end
end)
end
while _G.EspItem do
for i, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
	if v:IsA("Tool") then
		for i, z in pairs(v:GetChildren()) do
			if z.Name:find("Esp_") then
				z:Destroy()
			end
		end
	end
end
for i, v in pairs(_G.ItemAdd) do
if v.Name == "Handle" then
Items(v)
end
end
task.wait()
end

WindUI:Notify({
            Title = "脚本中心：",
            Content = Value and "已开启透视" or "已关闭透视",
            Icon = Value and "check" or "x",
            IconThemed = true, -- automatic color icon to theme 
            Duration = 5,
        })
	 end
})

_G.EspEntityNameDis = {
	["FigureRig"] = "Figure",
	["SallyMoving"] = "Sally Window",
	["RushMoving"] = "Rush",
	["Eyes"] = "Eyes",
	["Groundskeeper"] = "Skeeper",
	["BackdoorLookman"] = "Lookman",
	["BackdoorRush"] = "Blitz",
	["MandrakeLive"] = "Mandrake",
	["GloombatSwarm"] = "Gloombat",
	["GiggleCeiling"] = "Giggle",
	["AmbushMoving"] = "Ambush"
}

TabHandles.ESPgn:Toggle({
    Title = "透视柜子全部",
    Icon = "check",
    Value = false,
    Callback = function(Value) 

_G.EspHiding = Value
if _G.EspHiding == false then
_G.HidingAdd = {}
if HidingSpawn then
HidingSpawn:Disconnect()
HidingSpawn = nil
end
if HidingRemove then
HidingRemove:Disconnect()
HidingRemove = nil
end
for _, v in pairs(workspace:GetDescendants()) do 
if v.Name == "Bed" or v.Name == "Wardrobe" or v.Name == "Backdoor_Wardrobe" or v.Name == "Locker_Large" or v.Name == "Rooms_Locker" then
for i, z in pairs(v:GetChildren()) do
if z.Name:find("Esp_") then
z:Destroy()
end
end
end
end
else
function Hidings(v)
if (v.Name == "Bed" or v.Name == "Wardrobe" or v.Name == "Backdoor_Wardrobe" or v.Name == "Locker_Large" or v.Name == "Rooms_Locker") and v.PrimaryPart then
if v:FindFirstChild("Esp_Highlight") then
	v:FindFirstChild("Esp_Highlight").FillColor = Color3.fromRGB(50, 205, 50)
	v:FindFirstChild("Esp_Highlight").OutlineColor = Color3.fromRGB(50, 205, 50)
end
if _G.EspHighlight == true and v:FindFirstChild("Esp_Highlight") == nil then
	local Highlight = Instance.new("Highlight")
	Highlight.Name = "Esp_Highlight"
	Highlight.FillColor = Color3.fromRGB(50, 205, 50) 
	Highlight.OutlineColor = Color3.fromRGB(50, 205, 50) 
	Highlight.FillTransparency = 0.5
	Highlight.OutlineTransparency = 0
	Highlight.Adornee = v
	Highlight.Parent = v
	elseif _G.EspHighlight == false and v:FindFirstChild("Esp_Highlight") then
	v:FindFirstChild("Esp_Highlight"):Destroy()
end
if v:FindFirstChild("Esp_Gui") and v["Esp_Gui"]:FindFirstChild("TextLabel") then
	v["Esp_Gui"]:FindFirstChild("TextLabel").Text = 
	        (_G.EspName == true and v.Name or "")..
            (_G.EspDistance == true and "\n距离: ("..string.format("%.0f", Distance(v.PrimaryPart.Position)).."m)" or "")
    v["Esp_Gui"]:FindFirstChild("TextLabel").TextSize = _G.EspGuiTextSize or 10
    v["Esp_Gui"]:FindFirstChild("TextLabel").TextColor3 = _G.EspGuiTextColor or Color3.new(255, 255, 255)
end
if _G.EspGui == true and v:FindFirstChild("Esp_Gui") == nil then
	GuiEsp = Instance.new("BillboardGui", v)
	GuiEsp.Adornee = v
	GuiEsp.Name = "Esp_Gui"
	GuiEsp.Size = UDim2.new(0, 100, 0, 150)
	GuiEsp.AlwaysOnTop = true
	GuiEspText = Instance.new("TextLabel", GuiEsp)
	GuiEspText.BackgroundTransparency = 1
	GuiEspText.Font = Enum.Font.Code
	GuiEspText.Size = UDim2.new(0, 100, 0, 100)
	GuiEspText.TextSize = 15
	GuiEspText.TextColor3 = Color3.new(0,0,0) 
	GuiEspText.TextStrokeTransparency = 0.5
	GuiEspText.Text = ""
	local UIStroke = Instance.new("UIStroke")
	UIStroke.Color = Color3.new(0, 0, 0)
	UIStroke.Thickness = 1.5
	UIStroke.Parent = GuiEspText
	elseif _G.EspGui == false and v:FindFirstChild("Esp_Gui") then
	v:FindFirstChild("Esp_Gui"):Destroy()
end
end
end
local function CheckHiding(v)
    if not table.find(_G.HidingAdd, v) and v.Name == "Bed" or v.Name == "Wardrobe" or v.Name == "Backdoor_Wardrobe" or v.Name == "Locker_Large" or v.Name == "Rooms_Locker" then
        table.insert(_G.HidingAdd, v)
    end
end
for _, v in ipairs(workspace:GetDescendants()) do
	CheckHiding(v)
end
BookSpawn = workspace.DescendantAdded:Connect(function(v)
    CheckHiding(v)
end)
BookRemove = workspace.DescendantRemoving:Connect(function(v)
    for i = #_G.HidingAdd, 1, -1 do
        if _G.HidingAdd[i] == v then
            table.remove(_G.HidingAdd, i)
            break
        end
    end
end)
end
while _G.EspHiding do
for i, v in pairs(_G.HidingAdd) do
if v:IsA("Model") then
Hidings(v)
end
end
task.wait()
end

WindUI:Notify({
            Title = "脚本中心：",
            Content = Value and "已开启透视" or "已关闭透视",
            Icon = Value and "check" or "x",
            IconThemed = true, -- automatic color icon to theme 
            Duration = 5,
        })
	 end
})

TabHandles.ESPgn:Toggle({
    Title = "透视玩家",
    Icon = "check",
    Value = false,
    Callback = function(Value) 

_G.EspPlayer = Value
if _G.EspPlayer == false then
for i, v in pairs(game.Players:GetChildren()) do
	if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("Head") and v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChild("Humanoid") then
		for x, b in pairs(v.Character:GetChildren()) do
			if b.Name:find("Esp_") then
				b:Destroy()
			end
		end
	end
end
end
while _G.EspPlayer do
for i, v in pairs(game.Players:GetChildren()) do
if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("Head") and v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChild("Humanoid") then
if v.Character:FindFirstChild("Esp_Highlight") then
	v.Character:FindFirstChild("Esp_Highlight").FillColor = Color3.new(255, 255, 255)
	v.Character:FindFirstChild("Esp_Highlight").OutlineColor = Color3.new(255, 255, 255)
end
if _G.EspHighlight == true and v.Character:FindFirstChild("Esp_Highlight") == nil then
	local Highlight = Instance.new("Highlight")
	Highlight.Name = "Esp_Highlight"
	Highlight.FillColor = Color3.fromRGB(255, 255, 255) 
	Highlight.OutlineColor = Color3.fromRGB(255, 255, 255) 
	Highlight.FillTransparency = 0.5
	Highlight.OutlineTransparency = 0
	Highlight.Adornee = v.Character
	Highlight.Parent = v.Character
	elseif _G.EspHighlight == false and v.Character:FindFirstChild("Esp_Highlight") then
	v.Character:FindFirstChild("Esp_Highlight"):Destroy()
end
if v.Character:FindFirstChild("Esp_Gui") and v.Character["Esp_Gui"]:FindFirstChild("TextLabel") then
	v.Character["Esp_Gui"]:FindFirstChild("TextLabel").Text = 
	        (_G.EspName == true and v.Name or "")..
            (_G.EspDistance == true and "\n距离: ("..string.format("%.0f", Distance(v.Character.HumanoidRootPart.Position)).."m)" or "")..
            (_G.EspHealth == true and "\n血量: [ "..(v.Character.Humanoid.Health <= 0 and "Dead" or string.format("%.0f", (v.Character.Humanoid.Health))).." ]" or "")
    v.Character["Esp_Gui"]:FindFirstChild("TextLabel").TextSize = _G.EspGuiTextSize or 10
    v.Character["Esp_Gui"]:FindFirstChild("TextLabel").TextColor3 = _G.EspGuiTextColor or Color3.new(255, 255, 255)
end
if _G.EspGui == true and v.Character:FindFirstChild("Esp_Gui") == nil then
	GuiPlayerEsp = Instance.new("BillboardGui", v.Character)
	GuiPlayerEsp.Adornee = v.Character.Head
	GuiPlayerEsp.Name = "Esp_Gui"
	GuiPlayerEsp.Size = UDim2.new(0, 100, 0, 150)
	GuiPlayerEsp.AlwaysOnTop = true
	GuiPlayerEsp.StudsOffset = Vector3.new(0, 3, 0)
	GuiPlayerEspText = Instance.new("TextLabel", GuiPlayerEsp)
	GuiPlayerEspText.BackgroundTransparency = 1
	GuiPlayerEspText.Font = Enum.Font.Code
	GuiPlayerEspText.Size = UDim2.new(0, 100, 0, 100)
	GuiPlayerEspText.TextSize = 15
	GuiPlayerEspText.TextColor3 = Color3.new(0,0,0) 
	GuiPlayerEspText.TextStrokeTransparency = 0.5
	GuiPlayerEspText.Text = ""
	local UIStroke = Instance.new("UIStroke")
	UIStroke.Color = Color3.new(0, 0, 0)
	UIStroke.Thickness = 1.5
	UIStroke.Parent = GuiPlayerEspText
	elseif _G.EspGui == false and v.Character:FindFirstChild("Esp_Gui") then
	v.Character:FindFirstChild("Esp_Gui"):Destroy()
end
end
end
task.wait()
end

WindUI:Notify({
            Title = "脚本中心：",
            Content = Value and "已开启透视" or "已关闭透视",
            Icon = Value and "check" or "x",
            IconThemed = true, -- automatic color icon to theme 
            Duration = 5,
        })
	 end
})

TabHandles.ESPgn:Toggle({
    Title = "文本显示",
    Icon = "check",
    Value = false,
    Callback = function(Value) 

_G.EspGui = Value

WindUI:Notify({
            Title = "脚本中心：",
            Content = Value and "已开启文本显示" or "已关闭文本显示",
            Icon = Value and "check" or "x",
            IconThemed = true, -- automatic color icon to theme 
            Duration = 5,
        })
	 end
})

TabHandles.ESPgn:Toggle({
    Title = "高亮显示",
    Icon = "check",
    Value = false,
    Callback = function(Value) 

_G.EspHighlight = Value

WindUI:Notify({
            Title = "脚本中心：",
            Content = Value and "已开启高亮显示" or "已关闭高亮显示",
            Icon = Value and "check" or "x",
            IconThemed = true, -- automatic color icon to theme 
            Duration = 5,
        })
	 end
})

local intensitySlider = TabHandles.ESPgn:Slider({
    Title = "文本大小",
    Desc = "speedwalk",
    Value = { Min = 5, Max = 50, Default = 10 },
    Callback = function(Value)
        _G.EspGuiTextSize = Value
    end
})

TabHandles.ESPgn:Toggle({
    Title = "名称显示",
    Desc = "需先开启“文本显示”",
    Icon = "check",
    Value = false,
    Callback = function(Value) 

_G.EspName = Value

WindUI:Notify({
            Title = "脚本中心：",
            Content = Value and "已开启名称显示" or "已关闭名称显示",
            Icon = Value and "check" or "x",
            IconThemed = true, -- automatic color icon to theme 
            Duration = 5,
        })
	 end
})

TabHandles.ESPgn:Toggle({
    Title = "距离显示",
    Desc = "需先开启“文本显示”",
    Icon = "check",
    Value = false,
    Callback = function(Value) 

_G.EspDistance = Value

WindUI:Notify({
            Title = "脚本中心：",
            Content = Value and "已开启距离显示" or "已关闭距离显示",
            Icon = Value and "check" or "x",
            IconThemed = true, -- automatic color icon to theme 
            Duration = 5,
        })
	 end
})

TabHandles.ESPgn:Toggle({
    Title = "玩家血量显示",
    Desc = "需先开启“文本显示”",
    Icon = "check",
    Value = false,
    Callback = function(Value) 

_G.EspHealth = Value

WindUI:Notify({
            Title = "脚本中心：",
            Content = Value and "已开启血量显示" or "已关闭血量显示",
            Icon = Value and "check" or "x",
            IconThemed = true, -- automatic color icon to theme 
            Duration = 5,
        })
	 end
})

Screech = false
ClutchHeart = false
local old
old = hookmetamethod(game,"__namecall",newcclosure(function(self,...)
    local args = {...}
    local method = getnamecallmethod()
    if tostring(self) == "Screech" and method == "FireServer" and Screech == true then
        args[1] = true
        return old(self,unpack(args))
    end
    if tostring(self) == "ClutchHeartbeat" and method == "FireServer" and ClutchHeart == true then
        args[2] = true
        return old(self,unpack(args))
    end
    return old(self,...)
end))

workspace.DescendantAdded:Connect(function(v)
if v:IsA("Model") and v.Name == "Screech" then
v:Destroy()
end
end)

TabHandles.pbgn:Toggle({
    Title = "防Screech",
    Icon = "check",
    Value = false,
    Callback = function(Value) 
_G.AntiScreech = Value
Screech = Value
WindUI:Notify({
            Title = "脚本中心：",
            Content = Value and "已开启防Screech" or "已关闭防Screech",
            Icon = Value and "check" or "x",
            IconThemed = true, -- automatic color icon to theme 
            Duration = 5,
        })
	 end
})

TabHandles.pbgn:Toggle({
    Title = "防Halt",
    Icon = "check",
    Value = false,
    Callback = function(Value) 
_G.NoHalt = Value
local HaltShade = EntityModules:FindFirstChild("Shade") or EntityModules:FindFirstChild("_Shade")
if HaltShade then
    HaltShade.Name = _G.NoHalt and "_Shade" or "Shade"
end
WindUI:Notify({
            Title = "脚本中心：",
            Content = Value and "已开启防Halt" or "已关闭防Halt",
            Icon = Value and "check" or "x",
            IconThemed = true, -- automatic color icon to theme 
            Duration = 5,
        })
	 end
})

TabHandles.pbgn:Toggle({
    Title = "防Eyes",
    Icon = "check",
    Value = false,
    Callback = function(Value) 
_G.NoEyes = Value
while _G.NoEyes do
if workspace:FindFirstChild("Eyes") or workspace:FindFirstChild("BackdoorLookman") then
if game:GetService("ReplicatedStorage"):FindFirstChild("RemotesFolder") then
game:GetService("ReplicatedStorage"):WaitForChild("RemotesFolder"):WaitForChild("MotorReplication"):FireServer(-649)
end
end
task.wait()
end
WindUI:Notify({
            Title = "脚本中心：",
            Content = Value and "已开启防Eyes" or "已关闭防Eyes",
            Icon = Value and "check" or "x",
            IconThemed = true, -- automatic color icon to theme 
            Duration = 5,
        })
	 end
})

TabHandles.pbgn:Toggle({
    Title = "防Look Man",
    Icon = "check",
    Value = false,
    Callback = function(Value) 
_G.NoEyes = Value
while _G.NoEyes do
if workspace:FindFirstChild("Eyes") or workspace:FindFirstChild("BackdoorLookman") then
if game:GetService("ReplicatedStorage"):FindFirstChild("RemotesFolder") then
game:GetService("ReplicatedStorage"):WaitForChild("RemotesFolder"):WaitForChild("MotorReplication"):FireServer(-649)
end
end
task.wait()
end
WindUI:Notify({
            Title = "脚本中心：",
            Content = Value and "已开启防Look Man" or "已关闭防Look Man",
            Icon = Value and "check" or "x",
            IconThemed = true, -- automatic color icon to theme 
            Duration = 5,
        })
	 end
})

_G.EntityChoose = {"Rush", "Seek", "Eyes", "Sally Window", "LookMan", "Giggle", "GloombatSwarm", "Ambush", "A-60", "A-120", "Groundskeeper", "Mandrake", "Surge", "Monument" ,"Eyestalk" ,"Bramble" }

TabHandles.tzgn:Toggle({
    Title = "开启实体生成通知",
    Icon = "check",
    Value = false,
    Callback = function(Value) 
_G.NotifyEntity = Value
if _G.NotifyEntity then
    EntityChild = workspace.ChildAdded:Connect(function(child)
        for _, v in ipairs(_G.EntityChoose) do
            if child:IsA("Model") and child.Name:find(v) then
                repeat task.wait() until not child:IsDescendantOf(workspace) or (game.Players.LocalPlayer:DistanceFromCharacter(child:GetPivot().Position) < 1000)
                if child:IsDescendantOf(workspace) then
                    WindUI:Notify({Title = v.." 已生成!", Duration = 5})
                    if _G.NotifyEntityChat then
                        local text = _G.ChatNotify or ""
                        game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync(text..v.." 已生成!")
                    end
                end
            end
        end
    end)
else
    if EntityChild then
        EntityChild:Disconnect()
        EntityChild = nil
    end
end
WindUI:Notify({
            Title = "脚本中心：",
            Content = Value and "已开启防Eyes" or "已关闭防Eyes",
            Icon = Value and "check" or "x",
            IconThemed = true, -- automatic color icon to theme 
            Duration = 5,
        })
	 end
})

TabHandles.tzgn:Toggle({
    Title = "开启聊天栏通知",
    Icon = "check",
    Value = false,
    Callback = function(Value) 
_G.NotifyEntityChat = Value
WindUI:Notify({
            Title = "脚本中心：",
            Content = Value and "已开启聊天栏通知" or "已关闭防聊天栏通知",
            Icon = Value and "check" or "x",
            IconThemed = true, -- automatic color icon to theme 
            Duration = 5,
        })
	 end
})

local intensitySlider = TabHandles.fzgn:Slider({
    Title = "透明度",
    Desc = "speedwalk",
    Step = 0.1,
    Value = { Min = 0, Max = 1, Default = 0.5 },
    Callback = function(Value)
        _G.TransparencyHide = Value
    end
})

TabHandles.fzgn:Toggle({
    Title = "柜子/床透明",
    Icon = "check",
    Value = false,
    Callback = function(Value) 

_G.HidingTransparency = Value
while _G.HidingTransparency do
if game.Players.LocalPlayer.Character:GetAttribute("Hiding") then
	for _, v in pairs(workspace.CurrentRooms:GetDescendants()) do
		if v:IsA("ObjectValue") and v.Name == "HiddenPlayer" then
			if v.Value == game.Players.LocalPlayer.Character then
                local hidePart = {}
                for _, i in pairs(v.Parent:GetChildren()) do
                    if i:IsA("BasePart") then
		                i.Transparency = _G.TransparencyHide or 0.5
		                table.insert(hidePart, i)
		            end
		        end
            repeat task.wait()
                for _, h in pairs(hidePart) do
                    h.Transparency = _G.TransparencyHide or 0.5
                    task.wait()
                end
            until not game.Players.LocalPlayer.Character:GetAttribute("Hiding") or not _G.HidingTransparency
            for _, n in pairs(hidePart) do
                n.Transparency = 0
                task.wait()
            end
            break
		end
	end
end
end
task.wait()
end

WindUI:Notify({
            Title = "脚本中心：",
            Content = Value and "已开启透明" or "已关闭透明",
            Icon = Value and "check" or "x",
            IconThemed = true, -- automatic color icon to theme 
            Duration = 5,
        })
	 end
})

if isHotel then
TabHandles.fzgn:Toggle({
    Title = "自动提示密码",
    Icon = "check",
    Value = false,
    Callback = function(Value) 

_G.NotifyEntity = Value
if _G.NotifyEntity then
local function Deciphercode(v)
local Hints = game.Players.LocalPlayer.PlayerGui:WaitForChild("PermUI"):WaitForChild("Hints")

local code = {[1] = " _",[2] = " _", [3] = " _", [4] = " _", [5] = " _"}
    for i, v in pairs(v:WaitForChild("UI"):GetChildren()) do
        if v:IsA("ImageLabel") and v.Name ~= "Image" then
            for b, n in pairs(Hints:GetChildren()) do
                if n:IsA("ImageLabel") and n.Visible and v.ImageRectOffset == n.ImageRectOffset then
                    code[tonumber(v.Name)] = n:FindFirstChild("TextLabel").Text 
                end
            end
        end
    end 
    return code
end
local function CodeAll(v)
	if v:IsA("Tool") and v.Name == "LibraryHintPaper" then
        local code = table.concat(Deciphercode(v))
        if code then
	        ui:Notify({Title = "Code: "..code, Duration = 5})
			if _G.NotifyEntityChat2 then
				if not _G.ChatNotify then
					TextChat = ""
				else
					TextChat = _G.ChatNotify
				end
				if TextChat then
					game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync(TextChat..code)
				end
			end
	        if workspace:FindFirstChild("Padlock") and Distance(workspace.Padlock:GetPivot().Position) <= 30 then
				if game:GetService("ReplicatedStorage"):FindFirstChild("RemotesFolder") then
					game:GetService("ReplicatedStorage"):WaitForChild("RemotesFolder"):WaitForChild("LP"):FireServer(code)
				end
			end
		end
    end
end
Getpaper = game.Players.LocalPlayer.Character.ChildAdded:Connect(function(v)
CodeAll(v)
end)
else
if Getpaper then
Getpaper:Disconnect()
Getpaper = nil
end
end

WindUI:Notify({
            Title = "脚本中心：",
            Content = Value and "已开启自动提示" or "已关闭自动提示",
            Icon = Value and "check" or "x",
            IconThemed = true, -- automatic color icon to theme 
            Duration = 5,
        })
	 end
})
end

TabHandles.fzgn:Toggle({
    Title = "聊天栏提示密码",
    Icon = "check",
    Value = false,
    Callback = function(Value) 

_G.NotifyEntityChat2 = Value

WindUI:Notify({
            Title = "脚本中心：",
            Content = Value and "已开启聊天栏提示" or "已关闭聊天栏提示",
            Icon = Value and "check" or "x",
            IconThemed = true, -- automatic color icon to theme 
            Duration = 5,
        })
	 end
})

TabHandles.fzgn:Toggle({
    Title = "无限氧气",
    Icon = "check",
    Value = false,
    Callback = function(Value) 

_G.ActiveInfOxygen = Value 
while _G.ActiveInfOxygen do 
if game.Players.LocalPlayer.Character:GetAttribute("Oxygen") then
game.Players.LocalPlayer.Character:SetAttribute("Oxygen",99999)
end
task.wait()
end 
if game.Players.LocalPlayer.Character:GetAttribute("Oxygen") then
game.Players.LocalPlayer.Character:SetAttribute("Oxygen",100)
end

WindUI:Notify({
            Title = "脚本中心：",
            Content = Value and "已开启无限氧气" or "已关闭无限氧气",
            Icon = Value and "check" or "x",
            IconThemed = true, -- automatic color icon to theme 
            Duration = 5,
        })
	 end
})

local Button = Tab:Button({
    Title = "自定义界面",
    Desc = "个性化您的体验",
    Image = "palette",
    ImageSize = 20,
    Color = "White"
})

local themes = {}
for themeName, _ in pairs(WindUI:GetThemes()) do
    table.insert(themes, themeName)
end
table.sort(themes)

local themeDropdown = TabHandles.Appearance:Dropdown({
    Title = "主题选择",
    Values = themes,
    Value = "Dark",
    Callback = function(theme)
        WindUI:SetTheme(theme)
        WindUI:Notify({
            Title = "主题应用",
            Content = theme,
            Icon = "palette",
            Duration = 2
        })
    end
})

local transparencySlider = TabHandles.Appearance:Slider({
    Title = "透明度",
    Value = { 
        Min = 0,
        Max = 1,
        Default = 0.2,
    },
    Step = 0.1,
    Callback = function(value)
        Window:ToggleTransparency(tonumber(value) > 0)
        WindUI.TransparencyValue = tonumber(value)
    end
})

TabHandles.Appearance:Toggle({
    Title = "启用黑色主题",
    Desc = "使用黑色调主题方案",
    Value = true,
    Callback = function(state)
        WindUI:SetTheme(state and "Dark" or "Light")
        themeDropdown:Select(state and "Dark" or "Light")
    end
})

TabHandles.Appearance:Button({
    Title = "创建新主题",
    Icon = "plus",
    Callback = function()
        Window:Dialog({
            Title = "创建主题",
            Content = "此功能很快就会推出",
            Buttons = {
                {
                    Title = "确认",
                    Variant = "Primary"
                }
            }
        })
    end
})

TabHandles.Config:Paragraph({
    Title = "配置管理",
    Desc = "保存你的设置",
    Image = "save",
    ImageSize = 20,
    Color = "White"
})

local configName = "default"
local configFile = nil
local MyPlayerData = {
    name = "Player1",
    level = 1,
    inventory = { "sword", "shield", "potion" }
}

TabHandles.Config:Input({
    Title = "配置名称",
    Value = configName,
    Callback = function(value)
        configName = value
    end
})

local ConfigManager = Window.ConfigManager
if ConfigManager then
    ConfigManager:Init(Window)
    
    TabHandles.Config:Button({
        Title = "保存配置",
        Icon = "save",
        Variant = "Primary",
        Callback = function()
            configFile = ConfigManager:CreateConfig(configName)
            
            configFile:Register("featureToggle", featureToggle)
            configFile:Register("intensitySlider", intensitySlider)
            configFile:Register("modeDropdown", modeDropdown)
            configFile:Register("themeDropdown", themeDropdown)
            configFile:Register("transparencySlider", transparencySlider)
            
            configFile:Set("playerData", MyPlayerData)
            configFile:Set("lastSave", os.date("%Y-%m-%d %H:%M:%S"))
            
            if configFile:Save() then
                WindUI:Notify({ 
                    Title = "保存配置", 
                    Content = "保存为："..configName,
                    Icon = "check",
                    Duration = 3
                })
            else
                WindUI:Notify({ 
                    Title = "错误", 
                    Content = "保存失败",
                    Icon = "x",
                    Duration = 3
                })
            end
        end
    })

    TabHandles.Config:Button({
        Title = "加载配置",
        Icon = "folder",
        Callback = function()
            configFile = ConfigManager:CreateConfig(configName)
            local loadedData = configFile:Load()
            
            if loadedData then
                if loadedData.playerData then
                    MyPlayerData = loadedData.playerData
                end
                
                local lastSave = loadedData.lastSave or "Unknown"
                WindUI:Notify({ 
                    Title = "加载配置", 
                    Content = "正在加载："..configName.."\n上次保存："..lastSave,
                    Icon = "refresh-cw",
                    Duration = 5
                })
                
                TabHandles.Config:Paragraph({
                    Title = "玩家数据",
                    Desc = string.format("名字: %s\n等级: %d\n库存: %s", 
                        MyPlayerData.name, 
                        MyPlayerData.level, 
                        table.concat(MyPlayerData.inventory, ", "))
                })
            else
                WindUI:Notify({ 
                    Title = "错误", 
                    Content = "加载失败",
                    Icon = "x",
                    Duration = 3
                })
            end
        end
    })
else
    TabHandles.Config:Paragraph({
        Title = "配置管理不可用",
        Desc = "此功能需要配置管理",
        Image = "alert-triangle",
        ImageSize = 20,
        Color = "White"
    })
end