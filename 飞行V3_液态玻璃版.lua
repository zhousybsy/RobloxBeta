-- ╔══════════════════════════════════════════════════════════╗
-- ║       飞行 V3  ·  液态玻璃版  (iOS Liquid Glass UI)      ║
-- ║   原作: me_ozone  ·  汉化: 秋风拂过  ·  UI重制: Glass   ║
-- ╚══════════════════════════════════════════════════════════╝

-- ────────────────────── 实例声明 ──────────────────────────
local main        = Instance.new("ScreenGui")
local Frame       = Instance.new("Frame")
local Header      = Instance.new("Frame")
local up          = Instance.new("TextButton")
local down        = Instance.new("TextButton")
local onof        = Instance.new("TextButton")
local plus        = Instance.new("TextButton")
local speed       = Instance.new("TextLabel")   -- 保留原变量名供逻辑使用
local mine        = Instance.new("TextButton")
local closebutton = Instance.new("TextButton")
local mini        = Instance.new("TextButton")
local mini2       = Instance.new("TextButton")

-- ────────────────────── iOS 液态玻璃调色板 ────────────────
local WHITE = Color3.fromRGB(255, 255, 255)
local ICE   = Color3.fromRGB(205, 225, 255)    -- 冰蓝底色
local BLU   = Color3.fromRGB(10,  132, 255)    -- iOS 系统蓝
local GRN   = Color3.fromRGB(48,  209, 88)     -- iOS 绿
local RED_C = Color3.fromRGB(255, 69,  58)     -- iOS 红
local AMBER = Color3.fromRGB(255, 200, 10)     -- iOS 黄
local DARK  = Color3.fromRGB(20,  35,  75)     -- 深色(速度显示背景)

-- ────────────────────── 工具函数 ──────────────────────────
local function addCorner(obj, r)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, r or 12)
    c.Parent = obj
end

local function addStroke(obj, col, alpha, thick)
    local s = Instance.new("UIStroke")
    s.Color        = col   or WHITE
    s.Transparency = alpha or 0.40
    s.Thickness    = thick or 1.0
    s.Parent       = obj
end

-- 玻璃高光渐变 (模拟液态玻璃反光)
local function addGlassShimmer(obj, topAlpha, botAlpha, rot)
    local g = Instance.new("UIGradient")
    g.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0,   WHITE),
        ColorSequenceKeypoint.new(1,   WHITE),
    }
    g.Transparency = NumberSequence.new{
        NumberSequenceKeypoint.new(0,    topAlpha or 0.08),
        NumberSequenceKeypoint.new(0.40, 0.38),
        NumberSequenceKeypoint.new(1,    botAlpha or 0.65),
    }
    g.Rotation = rot or 130
    g.Parent   = obj
end

-- 悬停高亮效果
local function hoverFX(btn, baseAlpha, hoverAlpha)
    btn.MouseEnter:Connect(function()
        btn.BackgroundTransparency = hoverAlpha
    end)
    btn.MouseLeave:Connect(function()
        btn.BackgroundTransparency = baseAlpha
    end)
end

-- 通用玻璃按钮工厂
local function glassButton(parent, text, x, y, w, h, col, alpha)
    local btn = Instance.new("TextButton")
    btn.Parent                 = parent
    btn.BackgroundColor3       = col or WHITE
    btn.BackgroundTransparency = alpha or 0.50
    btn.Position               = UDim2.new(0, x, 0, y)
    btn.Size                   = UDim2.new(0, w, 0, h)
    btn.Font                   = Enum.Font.GothamBold
    btn.Text                   = text
    btn.TextColor3             = WHITE
    btn.TextSize               = 13
    btn.AutoButtonColor        = false
    addCorner(btn, 10)
    addStroke(btn, WHITE, 0.52, 0.8)
    addGlassShimmer(btn, 0.08, 0.60)
    hoverFX(btn, alpha or 0.50, math.max(0, (alpha or 0.50) - 0.18))
    return btn
end

-- ════════════════════════════════════════════════════════
--                  ScreenGui
-- ════════════════════════════════════════════════════════
main.Name            = "FlyGUI_LiquidGlass"
main.Parent          = game.Players.LocalPlayer:WaitForChild("PlayerGui")
main.ZIndexBehavior  = Enum.ZIndexBehavior.Sibling
main.ResetOnSpawn    = false

-- ════════════════════════════════════════════════════════
--  主面板  222 × 102 px  — 液态磨砂玻璃
-- ════════════════════════════════════════════════════════
Frame.Name                   = "Frame"
Frame.Parent                 = main
Frame.BackgroundColor3       = ICE
Frame.BackgroundTransparency = 0.18
Frame.Position               = UDim2.new(0.10, 0, 0.38, 0)
Frame.Size                   = UDim2.new(0, 222, 0, 102)
Frame.Active                 = true
Frame.Draggable              = true
Frame.ClipsDescendants       = true
addCorner(Frame, 20)
addStroke(Frame, WHITE, 0.25, 1.5)
addGlassShimmer(Frame, 0.03, 0.45, 115)

-- 顶部高光线 (玻璃边缘光)
local topEdge = Instance.new("Frame")
topEdge.Parent                 = Frame
topEdge.BackgroundColor3       = WHITE
topEdge.BackgroundTransparency = 0.25
topEdge.Position               = UDim2.new(0.05, 0, 0, 0)
topEdge.Size                   = UDim2.new(0.90, 0, 0, 1)
topEdge.BorderSizePixel        = 0

-- 左侧高光线
local leftEdge = Instance.new("Frame")
leftEdge.Parent                 = Frame
leftEdge.BackgroundColor3       = WHITE
leftEdge.BackgroundTransparency = 0.38
leftEdge.Position               = UDim2.new(0, 0, 0.05, 0)
leftEdge.Size                   = UDim2.new(0, 1, 0.90, 0)
leftEdge.BorderSizePixel        = 0

-- ════════════════════════════════════════════════════════
--  标题栏  222 × 30 px
-- ════════════════════════════════════════════════════════
Header.Name                   = "Header"
Header.Parent                 = Frame
Header.BackgroundColor3       = WHITE
Header.BackgroundTransparency = 0.68
Header.Size                   = UDim2.new(1, 0, 0, 30)
Header.Position               = UDim2.new(0, 0, 0, 0)
addCorner(Header, 20)

-- 标题文字
local TitleLbl = Instance.new("TextLabel")
TitleLbl.Parent               = Header
TitleLbl.BackgroundTransparency = 1
TitleLbl.Position             = UDim2.new(0, 12, 0, 0)
TitleLbl.Size                 = UDim2.new(1, -96, 1, 0)
TitleLbl.Font                 = Enum.Font.GothamBold
TitleLbl.Text                 = "✈  飞行 V3"
TitleLbl.TextColor3           = WHITE
TitleLbl.TextSize             = 13
TitleLbl.TextXAlignment       = Enum.TextXAlignment.Left

-- 标题栏分隔线
local divider = Instance.new("Frame")
divider.Parent                 = Frame
divider.BackgroundColor3       = WHITE
divider.BackgroundTransparency = 0.60
divider.Position               = UDim2.new(0, 10, 0, 30)
divider.Size                   = UDim2.new(1, -20, 0, 1)
divider.BorderSizePixel        = 0

-- ────────── 关闭按钮 [✕] — iOS 红 ──────────
closebutton.Name                   = "Close"
closebutton.Parent                 = Header
closebutton.BackgroundColor3       = RED_C
closebutton.BackgroundTransparency = 0.05
closebutton.Position               = UDim2.new(1, -62, 0.5, -11)
closebutton.Size                   = UDim2.new(0, 26, 0, 22)
closebutton.Font                   = Enum.Font.GothamBold
closebutton.Text                   = "✕"
closebutton.TextColor3             = WHITE
closebutton.TextSize               = 11
closebutton.AutoButtonColor        = false
addCorner(closebutton, 8)
addStroke(closebutton, WHITE, 0.58, 0.8)
addGlassShimmer(closebutton, 0.05, 0.42)
hoverFX(closebutton, 0.05, 0.00)

-- ────────── 隐藏按钮 [−] — iOS 黄 ──────────
mini.Name                   = "minimize"
mini.Parent                 = Header
mini.BackgroundColor3       = AMBER
mini.BackgroundTransparency = 0.05
mini.Position               = UDim2.new(1, -32, 0.5, -11)
mini.Size                   = UDim2.new(0, 26, 0, 22)
mini.Font                   = Enum.Font.GothamBold
mini.Text                   = "−"
mini.TextColor3             = WHITE
mini.TextSize               = 16
mini.AutoButtonColor        = false
addCorner(mini, 8)
addStroke(mini, WHITE, 0.58, 0.8)
addGlassShimmer(mini, 0.05, 0.42)
hoverFX(mini, 0.05, 0.00)

-- ────────── 展开按钮 [+] — iOS 蓝 ──────────
mini2.Name                   = "minimize2"
mini2.Parent                 = Frame
mini2.BackgroundColor3       = BLU
mini2.BackgroundTransparency = 0.15
mini2.Position               = UDim2.new(0, 6, 0, 5)
mini2.Size                   = UDim2.new(0, 32, 0, 22)
mini2.Font                   = Enum.Font.GothamBold
mini2.Text                   = "+"
mini2.TextColor3             = WHITE
mini2.TextSize               = 16
mini2.Visible                = false
mini2.AutoButtonColor        = false
addCorner(mini2, 8)
addStroke(mini2, WHITE, 0.55, 0.8)
addGlassShimmer(mini2, 0.08, 0.45)
hoverFX(mini2, 0.15, 0.00)

-- ════════════════════════════════════════════════════════
--  控制按钮  (布局: Frame 222px，两侧 8px 内边距)
--
--  第一行 y=37:  [▲ 上 44] [+ 加速 52] [速度 44] [- 减速 48]
--               8 + 44 + 6 + 52 + 4 + 44 + 4 + 48 + 12 = 222 ✓
--  第二行 y=69:  [▼ 下 44] [► 飞行: 关 ─────────────── 154]
--               8 + 44 + 6 + 154 + 10 = 222 ✓
-- ════════════════════════════════════════════════════════

-- 上升 — iOS 蓝
up = glassButton(Frame, "▲  上", 8, 37, 44, 28, BLU, 0.32)

-- 加速 — 白玻璃
plus = glassButton(Frame, "+ 加速", 58, 37, 52, 28, WHITE, 0.50)

-- 速度显示 — 深色玻璃 (TextLabel)
speed.Name                   = "speed"
speed.Parent                 = Frame
speed.BackgroundColor3       = DARK
speed.BackgroundTransparency = 0.32
speed.Position               = UDim2.new(0, 116, 0, 37)
speed.Size                   = UDim2.new(0, 44, 0, 28)
speed.Font                   = Enum.Font.GothamBold
speed.Text                   = "1"
speed.TextColor3             = WHITE
speed.TextSize               = 14
speed.TextScaled             = true
addCorner(speed, 10)
addStroke(speed, WHITE, 0.52, 0.8)
addGlassShimmer(speed, 0.12, 0.58)

-- 减速 — 白玻璃
mine = glassButton(Frame, "- 减速", 166, 37, 48, 28, WHITE, 0.50)

-- 下降 — iOS 蓝
down = glassButton(Frame, "▼  下", 8, 69, 44, 28, BLU, 0.32)

-- 飞行开关 — iOS 绿 (宽按钮，状态色会切换)
onof = glassButton(Frame, "►  飞行: 关", 58, 69, 154, 28, GRN, 0.25)
onof.TextSize = 13

-- ════════════════════════════════════════════════════════
--                  逻辑代码 (原版保留)
-- ════════════════════════════════════════════════════════
speeds = 1

local speaker = game:GetService("Players").LocalPlayer
local chr     = game.Players.LocalPlayer.Character
local hum     = chr and chr:FindFirstChildWhichIsA("Humanoid")

nowe = false

game:GetService("StarterGui"):SetCore("SendNotification", {
    Title    = "✈ 飞行 V3  ·  Glass Edition";
    Text     = "原作:Sybsy  ·  汉化: Sybsy";
    Icon     = "rbxthumb://type=Asset&id=5107182114&w=150&h=150";
    Duration = 5;
})

-- ────── 飞行开关 ──────
onof.MouseButton1Down:connect(function()

    if nowe == true then
        -- 关闭飞行 → 复原为绿色"飞行: 关"
        nowe = false
        onof.Text                   = "►  飞行: 关"
        onof.BackgroundColor3       = GRN
        onof.BackgroundTransparency = 0.25

        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing,true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown,true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Flying,true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall,true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp,true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping,true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Landed,true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics,true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding,true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Running,true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics,true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated,true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.StrafingNoPhysics,true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming,true)
        speaker.Character.Humanoid:ChangeState(Enum.HumanoidStateType.RunningNoPhysics)
    else
        -- 开启飞行 → 切换为红色"飞行: 开"
        nowe = true
        onof.Text                   = "■  飞行: 开"
        onof.BackgroundColor3       = RED_C
        onof.BackgroundTransparency = 0.20

        for i = 1, speeds do
            spawn(function()
                local hb = game:GetService("RunService").Heartbeat
                tpwalking = true
                local chr = game.Players.LocalPlayer.Character
                local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
                while tpwalking and hb:Wait() and chr and hum and hum.Parent do
                    if hum.MoveDirection.Magnitude > 0 then
                        chr:TranslateBy(hum.MoveDirection)
                    end
                end
            end)
        end
        game.Players.LocalPlayer.Character.Animate.Disabled = true
        local Char = game.Players.LocalPlayer.Character
        local Hum  = Char:FindFirstChildOfClass("Humanoid") or Char:FindFirstChildOfClass("AnimationController")
        for i,v in next, Hum:GetPlayingAnimationTracks() do
            v:AdjustSpeed(0)
        end
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing,false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown,false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Flying,false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall,false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp,false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping,false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Landed,false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics,false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding,false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Running,false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics,false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated,false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.StrafingNoPhysics,false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming,false)
        speaker.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Swimming)
    end

    -- R6 / R15 飞行物理 (原版逻辑)
    if game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").RigType == Enum.HumanoidRigType.R6 then

        local plr      = game.Players.LocalPlayer
        local torso    = plr.Character.Torso
        local ctrl     = {f=0,b=0,l=0,r=0}
        local lastctrl = {f=0,b=0,l=0,r=0}
        local maxspeed = 50
        local speed    = 0

        local bg = Instance.new("BodyGyro", torso)
        bg.P         = 9e4
        bg.maxTorque = Vector3.new(9e9,9e9,9e9)
        bg.cframe    = torso.CFrame
        local bv = Instance.new("BodyVelocity", torso)
        bv.velocity  = Vector3.new(0,0.1,0)
        bv.maxForce  = Vector3.new(9e9,9e9,9e9)
        if nowe == true then
            plr.Character.Humanoid.PlatformStand = true
        end
        while nowe == true or game:GetService("Players").LocalPlayer.Character.Humanoid.Health == 0 do
            game:GetService("RunService").RenderStepped:Wait()
            if ctrl.l+ctrl.r ~= 0 or ctrl.f+ctrl.b ~= 0 then
                speed = speed+.5+(speed/maxspeed)
                if speed > maxspeed then speed = maxspeed end
            elseif not (ctrl.l+ctrl.r ~= 0 or ctrl.f+ctrl.b ~= 0) and speed ~= 0 then
                speed = speed-1
                if speed < 0 then speed = 0 end
            end
            if (ctrl.l+ctrl.r) ~= 0 or (ctrl.f+ctrl.b) ~= 0 then
                bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector*(ctrl.f+ctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(ctrl.l+ctrl.r,(ctrl.f+ctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed
                lastctrl = {f=ctrl.f,b=ctrl.b,l=ctrl.l,r=ctrl.r}
            elseif (ctrl.l+ctrl.r) == 0 and (ctrl.f+ctrl.b) == 0 and speed ~= 0 then
                bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector*(lastctrl.f+lastctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(lastctrl.l+lastctrl.r,(lastctrl.f+lastctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed
            else
                bv.velocity = Vector3.new(0,0,0)
            end
            bg.cframe = game.Workspace.CurrentCamera.CoordinateFrame * CFrame.Angles(-math.rad((ctrl.f+ctrl.b)*50*speed/maxspeed),0,0)
        end
        ctrl = {f=0,b=0,l=0,r=0}
        lastctrl = {f=0,b=0,l=0,r=0}
        speed = 0
        bg:Destroy()
        bv:Destroy()
        plr.Character.Humanoid.PlatformStand = false
        game.Players.LocalPlayer.Character.Animate.Disabled = false
        tpwalking = false

    else
        local plr        = game.Players.LocalPlayer
        local UpperTorso = plr.Character.UpperTorso
        local ctrl       = {f=0,b=0,l=0,r=0}
        local lastctrl   = {f=0,b=0,l=0,r=0}
        local maxspeed   = 50
        local speed      = 0

        local bg = Instance.new("BodyGyro", UpperTorso)
        bg.P         = 9e4
        bg.maxTorque = Vector3.new(9e9,9e9,9e9)
        bg.cframe    = UpperTorso.CFrame
        local bv = Instance.new("BodyVelocity", UpperTorso)
        bv.velocity  = Vector3.new(0,0.1,0)
        bv.maxForce  = Vector3.new(9e9,9e9,9e9)
        if nowe == true then
            plr.Character.Humanoid.PlatformStand = true
        end
        while nowe == true or game:GetService("Players").LocalPlayer.Character.Humanoid.Health == 0 do
            wait()
            if ctrl.l+ctrl.r ~= 0 or ctrl.f+ctrl.b ~= 0 then
                speed = speed+.5+(speed/maxspeed)
                if speed > maxspeed then speed = maxspeed end
            elseif not (ctrl.l+ctrl.r ~= 0 or ctrl.f+ctrl.b ~= 0) and speed ~= 0 then
                speed = speed-1
                if speed < 0 then speed = 0 end
            end
            if (ctrl.l+ctrl.r) ~= 0 or (ctrl.f+ctrl.b) ~= 0 then
                bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector*(ctrl.f+ctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(ctrl.l+ctrl.r,(ctrl.f+ctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed
                lastctrl = {f=ctrl.f,b=ctrl.b,l=ctrl.l,r=ctrl.r}
            elseif (ctrl.l+ctrl.r) == 0 and (ctrl.f+ctrl.b) == 0 and speed ~= 0 then
                bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector*(lastctrl.f+lastctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(lastctrl.l+lastctrl.r,(lastctrl.f+lastctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed
            else
                bv.velocity = Vector3.new(0,0,0)
            end
            bg.cframe = game.Workspace.CurrentCamera.CoordinateFrame * CFrame.Angles(-math.rad((ctrl.f+ctrl.b)*50*speed/maxspeed),0,0)
        end
        ctrl = {f=0,b=0,l=0,r=0}
        lastctrl = {f=0,b=0,l=0,r=0}
        speed = 0
        bg:Destroy()
        bv:Destroy()
        plr.Character.Humanoid.PlatformStand = false
        game.Players.LocalPlayer.Character.Animate.Disabled = false
        tpwalking = false
    end
end)

-- ────── 上升按钮 ──────
local tis
up.MouseButton1Down:connect(function()
    tis = up.MouseEnter:connect(function()
        while tis do
            wait()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame =
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 1, 0)
        end
    end)
end)
up.MouseLeave:connect(function()
    if tis then tis:Disconnect(); tis = nil end
end)

-- ────── 下降按钮 ──────
local dis
down.MouseButton1Down:connect(function()
    dis = down.MouseEnter:connect(function()
        while dis do
            wait()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame =
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, -1, 0)
        end
    end)
end)
down.MouseLeave:connect(function()
    if dis then dis:Disconnect(); dis = nil end
end)

-- ────── 角色重生 ──────
game:GetService("Players").LocalPlayer.CharacterAdded:Connect(function(char)
    wait(0.7)
    game.Players.LocalPlayer.Character.Humanoid.PlatformStand = false
    game.Players.LocalPlayer.Character.Animate.Disabled = false
end)

-- ────── 加速 ──────
plus.MouseButton1Down:connect(function()
    speeds = speeds + 1
    speed.Text = speeds
    if nowe == true then
        tpwalking = false
        for i = 1, speeds do
            spawn(function()
                local hb = game:GetService("RunService").Heartbeat
                tpwalking = true
                local chr = game.Players.LocalPlayer.Character
                local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
                while tpwalking and hb:Wait() and chr and hum and hum.Parent do
                    if hum.MoveDirection.Magnitude > 0 then
                        chr:TranslateBy(hum.MoveDirection)
                    end
                end
            end)
        end
    end
end)

-- ────── 减速 ──────
mine.MouseButton1Down:connect(function()
    if speeds == 1 then
        speed.Text = "MIN"
        wait(1)
        speed.Text = speeds
    else
        speeds = speeds - 1
        speed.Text = speeds
        if nowe == true then
            tpwalking = false
            for i = 1, speeds do
                spawn(function()
                    local hb = game:GetService("RunService").Heartbeat
                    tpwalking = true
                    local chr = game.Players.LocalPlayer.Character
                    local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
                    while tpwalking and hb:Wait() and chr and hum and hum.Parent do
                        if hum.MoveDirection.Magnitude > 0 then
                            chr:TranslateBy(hum.MoveDirection)
                        end
                    end
                end)
            end
        end
    end
end)

-- ────── 关闭 ──────
closebutton.MouseButton1Click:Connect(function()
    main:Destroy()
end)

-- ────── 隐藏面板 ──────
mini.MouseButton1Click:Connect(function()
    Header.Visible               = false
    divider.Visible              = false
    topEdge.Visible              = false
    leftEdge.Visible             = false
    up.Visible                   = false
    down.Visible                 = false
    onof.Visible                 = false
    plus.Visible                 = false
    speed.Visible                = false
    mine.Visible                 = false
    mini2.Visible                = true
    Frame.BackgroundTransparency = 1
end)

-- ────── 展开面板 ──────
mini2.MouseButton1Click:Connect(function()
    Header.Visible               = true
    divider.Visible              = true
    topEdge.Visible              = true
    leftEdge.Visible             = true
    up.Visible                   = true
    down.Visible                 = true
    onof.Visible                 = true
    plus.Visible                 = true
    speed.Visible                = true
    mine.Visible                 = true
    mini2.Visible                = false
    Frame.BackgroundTransparency = 0.18
end)
