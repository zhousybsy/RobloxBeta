-- XA Hub - Doors lyy你爹开源


repeat task.wait() until game:IsLoaded()

local Repo = "https://raw.githubusercontent.com/deividcomsono/Obsidian/main/"
local Library = loadstring(game:HttpGet(Repo .. "Library.lua"))()
local ThemeManager = loadstring(game:HttpGet(Repo .. "addons/ThemeManager.lua"))()
local SaveManager = loadstring(game:HttpGet(Repo .. "addons/SaveManager.lua"))()
local ESP = loadstring(game:HttpGet("https://raw.githubusercontent.com/Xingtaiduan/Script/refs/heads/main/ESPLibrary.lua"))()
ESP.GlobalSettings.MaxDistance = 350

local Options = Library.Options
local Toggles = Library.Toggles
setmetatable(Options, { __index = Toggles })
setmetatable(Toggles, { __index = function() return {} end })

task.spawn(function()
    loadstring(game:HttpGet("https://raw.gitcode.com/Xingtaiduan/Scripts/raw/main/Webhook.lua"))("Fluent")
end)

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")
local PathfindingService = game:GetService("PathfindingService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer.PlayerGui
local GeneralChannel = game:GetService("TextChatService").TextChannels.RBXGeneral

local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
if Character then
            local IsAlive = LocalPlayer:GetAttribute("Alive")
            local MainUI = PlayerGui:WaitForChild("MainUI")
            local Initiator = MainUI:WaitForChild("Initiator"):WaitForChild("Main_Game")
            local MainGameModule = require(Initiator)
            local ControlModule = require(LocalPlayer.PlayerScripts:WaitForChild("PlayerModule"):WaitForChild("ControlModule"))
            local EntitySuffixes = {
                ["Backdoor"] = "",
                ["Ceiling"] = "",
                ["Moving"] = "",
                ["Ragdoll"] = "",
                ["Rig"] = "",
                ["Wall"] = "",
                ["MovingNewClone"] = "",
                ["Clock"] = " Clock",
                ["Key"] = " Key",
                ["Pack"] = " Pack",
                ["Pointer"] = " Pointer",
                ["Swarm"] = " Swarm",
                ["Live"] = "",
                ["Spawn"] = "",
                ["Entity"] = "",
            }
            local EntityConfig = {
                ["Names"] = {
                    "BackdoorRush",
                    "BackdoorLookman",
                    "RushMoving",
                    "AmbushMoving",
                    "SallyMoving",
                    "SeekMovingNewClone",
                    "Eyes",
                    "JeffTheKiller",
                    "Dread",
                    "GloombatSwarm",
                    "A60",
                    "A120",
                    "SurgeSpawn",
                    "MonumentEntity",
                    "EyestalkMoving",
                },
                ["SideNames"] = {
                    "FigureRig",
                    "GiggleCeiling",
                    "Grumble,Rig",
                    "Snare",
                    "Groundskeeper",
                    "MandrakeLive",
                    "LiveEntityBramble",
                },
                ["ShortNames"] = {
                    ["Snare"] = "地刺",
                    ["BackdoorRush"] = "Blitz",
                    ["JeffTheKiller"] = "Jeff杀手",
                    ["Groundskeeper"] = "园丁",
                    ["MonumentEntity"] = "石碑",
                },
                ["Avoid"] = {
                    "RushMoving",
                    "AmbushMoving",
                    "A60",
                },
            }
            local CutsceneNames = {
                "FigureHotelChase",
                "Elevator1",
                "MinesFinale",
            }
            local PromptConfig = {
                ["GamePrompts"] = {},
                ["Aura"] = {
                    ["ActivateEventPrompt"] = false,
                    ["AwesomePrompt"] = true,
                    ["FusesPrompt"] = true,
                    ["HerbPrompt"] = false,
                    ["LeverPrompt"] = true,
                    ["LootPrompt"] = false,
                    ["ModulePrompt"] = true,
                    ["SkullPrompt"] = false,
                    ["UnlockPrompt"] = true,
                    ["ValvePrompt"] = false,
                    ["PropPrompt"] = true,
                },
                ["AuraObjects"] = {
                    "Lock",
                    "Button",
                },
                ["Clip"] = {
                    "AwesomePrompt",
                    "FusesPrompt",
                    "HerbPrompt",
                    "HidePrompt",
                    "LeverPrompt",
                    "LootPrompt",
                    "ModulePrompt",
                    "Prompt",
                    "PushPrompt",
                    "SkullPrompt",
                    "UnlockPrompt",
                    "ValvePrompt",
                },
                ["ClipObjects"] = {
                    "LeverForGate",
                    "LiveBreakerPolePickup",
                    "LiveHintBook",
                    "Button",
                },
                ["Excluded"] = {
                    ["Prompt"] = {
                        "HintPrompt",
                        "InteractPrompt",
                    },
                    ["Parent"] = {
                        "KeyObtainFake",
                        "Padlock",
                    },
                    ["ModelAncestor"] = {
                        "DoorFake",
                    },
                },
            }
            local ESPObjects = {}
            local State = {
                ["Connections"] = {
                    ["Door"] = {},
                    ["Character"] = {},
                    ["Humanoid"] = {},
                    ["Player"] = {},
                    ["Pump"] = {},
                },
                ["Temp"] = {
                    ["FlyBody"] = nil,
                    ["Guidance"] = {},
                    ["Bridges"] = {},
                    ["PaintingDebounce"] = {},
                },
            }
            ModulesClient = ReplicatedStorage:WaitForChild( "ModulesClient")
            EntityModules = ModulesClient:WaitForChild( "EntityModules")
            GameData = ReplicatedStorage:WaitForChild( "GameData")
            FloorValue = GameData:WaitForChild( "Floor")
            LatestRoom = GameData:WaitForChild( "LatestRoom")
            LiveModifiers = ReplicatedStorage:WaitForChild( "LiveModifiers")
            IsMines = FloorValue.Value == "Mines"
            IsRooms = FloorValue.Value == "Rooms"
            IsHotel = FloorValue.Value == "Hotel"
            IsBackdoor = FloorValue.Value == "Backdoor"
            IsFools = FloorValue.Value == "Fools"
            IsRetro = FloorValue.Value == "Retro"
            IsGarden = FloorValue.Value == "Garden"
            FloorReplicated = not IsFools and ReplicatedStorage:WaitForChild( "FloorReplicated") or nil
            v5 = v5
            RemotesFolder = not IsFools and ReplicatedStorage:WaitForChild( "RemotesFolder") or ReplicatedStorage:WaitForChild( "EntityInfo")
            dO = LocalPlayer
            ZO = v5
            CurrentRoom = dO:GetAttribute( "CurrentRoom") or 0
            dO = workspace.CurrentRooms
            if not dO:FindFirstChild( tostring(CurrentRoom)) then
                CurrentRoom = LatestRoom.Value
                dO = LocalPlayer
                dO:SetAttribute( "CurrentRoom", CurrentRoom)
            end
            NextRoom = CurrentRoom + 1
            local function FormatEntityName(name)
                if EntityConfig.ShortNames[name] then
                    return EntityConfig.ShortNames[name]
                end
                for suffix, replacement in pairs(EntitySuffixes) do
                    name = name:gsub(suffix, replacement)
                end
                return name
            end
            local function ShowNotify(title, description, duration)
                if Options.NotifySound.Value then
                    local sound = Instance.new("Sound")
                    sound.SoundId = "rbxassetid://4590657391"
                    sound.Volume = Options.SoundVolume.Value
                    sound.Parent = SoundService
                    sound.PlayOnRemove = true
                    sound:Destroy()
                end
                Library:Notify({
                    Title = title,
                    Description = description,
                    Time = duration,
                })
            end
            local function AddDoorESP(room)
                v1 = arg1_4
                F = v1:WaitForChild( "Door")
                if F:GetAttribute( "Opened") then
                    return
                end
                if v1:GetAttribute( "RequiresKey") then
                    U = "[上锁]"
                end
                r67 = ESP.Add(
                    F:WaitForChild( "Door"),
                    string.format("门%s%s", tonumber(v1.Name) + 1, ""),
                    Options.DoorESPColor.Value,
                    15,
                    "DoorESP"
                )
                r68 = #State.Connections.Door + 1
                C = F:GetAttributeChangedSignal( "Opened")
                State.Connections.Door[r68] = C:Connect( function(...)
                    v5 = r67
                    v5.Destroy(v5)
                    v5 = State.Connections.Door[r68]
                    if v5 then
                        v5 = State.Connections.Door[r68]
                        v5.Disconnect(v5)
                    end
                    return
                end)
                return
            end
            local function AddObjectiveESP(object)
                local v1 = object
                if v1.Name == "TimerLever" then
                    ESP.Add({
                        ["Object"] = v1,
                        ["Name"] = string.format(
                            "时间拉杆 [+%s]",
                            v1.TakeTimer.TextLabel.Text
                        ),
                        ["Color"] = Options.ObjectiveESPColor.Value,
                        ["Tag"] = "ObjectiveESP",
                    })
                else
                    if v1.Name == "KeyObtain" then
                        ESP.Add({
                            ["Object"] = arg1_5,
                            ["Name"] = "钥匙",
                            ["Color"] = Options.ObjectiveESPColor.Value,
                            ["Tag"] = "ObjectiveESP",
                        })
                    else
                        if v1.Name == "ElectricalKeyObtain" then
                            ESP.Add({
                                ["Object"] = arg1_5,
                                ["Name"] = "电梯钥匙",
                                ["Color"] = Options.ObjectiveESPColor.Value,
                                ["Tag"] = "ObjectiveESP",
                            })
                        else
                            if v1.Name == "LeverForGate" then
                                ESP.Add({
                                    ["Object"] = arg1_5,
                                    ["Name"] = "拉杆",
                                    ["Color"] = Options.ObjectiveESPColor.Value,
                                    ["Tag"] = "ObjectiveESP",
                                })
                            else
                                if v1.Name == "LiveHintBook" then
                                    ESP.Add({
                                        ["Object"] = arg1_5,
                                        ["Name"] = "书",
                                        ["Color"] = Options.ObjectiveESPColor.Value,
                                        ["Tag"] = "ObjectiveESP",
                                    })
                                else
                                    if v1.Name == "LiveBreakerPolePickup" then
                                        ESP.Add({
                                            ["Object"] = arg1_5,
                                            ["Name"] = "断路器",
                                            ["Color"] = Options.ObjectiveESPColor.Value,
                                            ["Tag"] = "ObjectiveESP",
                                        })
                                    else
                                        if v1.Name == "MinesGenerator" then
                                            ESP.Add({
                                                ["Object"] = arg1_5,
                                                ["Name"] = "发电机",
                                                ["Color"] = Options.ObjectiveESPColor.Value,
                                                ["Tag"] = "ObjectiveESP",
                                            })
                                        else
                                            if v1.Name == "MinesGateButton" then
                                                ESP.Add({
                                                    ["Object"] = arg1_5,
                                                    ["Name"] = "按钮",
                                                    ["Color"] = Options.ObjectiveESPColor.Value,
                                                    ["Tag"] = "ObjectiveESP",
                                                })
                                            else
                                                if v1.Name == "FuseObtain" then
                                                    ESP.Add({
                                                        ["Object"] = arg1_5,
                                                        ["Name"] = "保险丝",
                                                        ["Color"] = Options.ObjectiveESPColor.Value,
                                                        ["Tag"] = "ObjectiveESP",
                                                    })
                                                else
                                                    if v1.Name == "MinesAnchor" then
                                                        V = v1:WaitForChild( "Sign", 5)
                                                        if V then
                                                            v3 = V:FindFirstChild( "TextLabel")
                                                        end
                                                        if V then
                                                            ESP.Add({
                                                                ["Object"] = arg1_5,
                                                                ["Name"] = string.format(
                                                                    "锚点 %s",
                                                                    V.TextLabel.Text
                                                                ),
                                                                ["Color"] = Options.ObjectiveESPColor.Value,
                                                                ["Tag"] = "ObjectiveESP",
                                                            })
                                                        end
                                                    else
                                                        if v1.Name == "WaterPump" then
                                                            v4 = "!� S�"
                                                            V = v1:WaitForChild( "Wheel", 5)
                                                            F = v1.FindFirstChild(
                                                                v1,
                                                                "Progress",
                                                                true
                                                            )
                                                            if V then
                                                                if F then
                                                                    s = v5.Visible
                                                                end
                                                                v3 = F
                                                                v1:FindFirstChild( "", true)
                                                            end
                                                            if V then
                                                                r70 = #State.Connections.Pump + 1
                                                                r71 = ESP.Add({
                                                                    ["Object"] = V,
                                                                    ["Name"] = "水泵",
                                                                    ["Color"] = Options.ObjectiveESPColor.Value,
                                                                    ["Tag"] = "ObjectiveESP",
                                                                })
                                                                v4 = F:GetPropertyChangedSignal( "Visible")
                                                                State.Connections.Pump[r70] = v4:Connect( function(...)
                                                                    v5 = r71
                                                                    v5.Destroy(v5)
                                                                    v5 = State.Connections.Pump[r70]
                                                                    if v5 then
                                                                        v5 = State.Connections.Pump[r70]
                                                                        v5.Disconnect(v5)
                                                                    end
                                                                    return
                                                                end)
                                                            end
                                                        else
                                                            if arg1_5.Name == "GardenGateButton" then
                                                                ESP.Add({
                                                                    ["Object"] = arg1_5,
                                                                    ["Name"] = "按钮",
                                                                    ["Color"] = Options.ObjectiveESPColor.Value,
                                                                    ["Tag"] = "ObjectiveESP",
                                                                })
                                                            else
                                                                if arg1_5.Name == "Lever" then
                                                                    ESP.Add({
                                                                        ["Object"] = arg1_5,
                                                                        ["Name"] = "拉杆",
                                                                        ["Color"] = Options.ObjectiveESPColor.Value,
                                                                        ["Tag"] = "ObjectiveESP",
                                                                    })
                                                                end
                                                                return
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
            local function AddChestESP(chest)
                local v1 = chest
                if v1:GetAttribute( "Locked") then
                    V = "[上锁]"
                end
                ESP.Add(v1, string.format("箱子%s", ""), Options.ChestESPColor.Value, 15, "ChestESP")
                return
            end
            local function AddItemESP(item)
                local v1 = item
                V = v1.Name
                v5 = v1:FindFirstChild( "ModulePrompt")
                if v5 then
                    V = v1.ModulePrompt.ObjectText
                end
                F = v5
                s = ESPObjects[V]
                if s then
                    V = s
                    v5 = v5
                    ESP.Add(arg1_7, V, Options.ItemESPColor.Value, 15, "ItemESP")
                    return
                else
                    v3 = v1.Name
                end
            end
            local function AddSideEntityESP(entity)
                local v1 = entity
                if v1.Name == "Snare" and not v1:FindFirstChild( "Hitbox") then
                    return
                end
                if v1.PrimaryPart and v1.PrimaryPart.Transparency == 1 then
                    v1.PrimaryPart.Transparency = 0.99
                end
                ESP.Add(v1.PrimaryPart, FormatEntityName(v1.Name), Options.EntityESPColor.Value, 15, "EntityESP")
                return
            end
            local function AddGuidanceESP(part)
                local r76 = part
                v5 = r76
                r77 = v5.Clone(v5)
                r77.Anchored = true
                r77.Size = Vector3.new(3, 3)
                r77.Transparency = 0.5
                r77.Name = "_Guidance"
                v5 = r77
                v5.ClearAllChildren(v5)
                r77.Parent = workspace
                State.Temp.Guidance[r76] = r77
                r78 = ESP.Add(
                    r77,
                    "指引之光",
                    Options.GuidingLightESPColor.Value,
                    15,
                    "GuidingLightESP"
                )
                v5 = r76.AncestryChanged
                v5:Connect( function(...)
                    v3 = r76
                    if not v3:IsDescendantOf( workspace) then
                        if State.Temp.Guidance[r76] then
                            State.Temp.Guidance[r76] = nil
                        end
                        v5 = r77
                        if v5 then
                            v5 = r77
                            v5.Destroy(v5)
                        end
                        v5 = r78
                        if v5 then
                            v5 = r78
                            v5.Destroy(v5)
                        end
                    end
                    return
                end)
                return
            end
            local function r79(arg1_10, ...)
                v1 = arg1_10
                V = v1:IsA( "Model")
                if V then
                    v5 = v5
                    v3 = (v1:GetAttribute( "Pickup") or v1:GetAttribute( "PropType"))
                        and not v1:GetAttribute( "FuseID")
                    v5 = v5
                end
                return V
            end
            local function r80(arg1_11, ...)
                v1 = arg1_11
                v1:FindFirstAncestorOfClass( "Model")
                return v1:IsA( "ProximityPrompt") and not table.find(PromptConfig.Excluded.Prompt, v1.Name)
            end
            local function r81(arg1_12, ...)
                r82 = arg1_12
                if r82.Name == "AnimSaves" or r82.Name == "Keyframe" then
                    v5 = r82
                    v5.Destroy(v5)
                    return
                end
                V = v5
                F = r82
                s = F:IsA( "ProximityPrompt")
                v3 = s
                if s then
                end
            end
            local function r83(arg1_13, ...)
                v1 = arg1_13
                v3 = LocalPlayer
                v5 = v5
                return v3.DistanceFromCharacter(
                    v3,
                    v1:FindFirstAncestorWhichIsA( "BasePart")
                        or (v1:FindFirstAncestorWhichIsA( "Model") or v1.Parent)
                ) <= v1.MaxActivationDistance
            end
            local function r84(arg1_14, ...)
                v1 = arg1_14
                V = math.huge
                v4 = workspace.CurrentRooms
                s = v4[2]
                U = v4[3]
                v4 = "pairs"
                for U, v6 in pairs(v4.GetChildren(v4)) do
                    v2 = U
                    if not v6:FindFirstChild( "Assets") then
                    end
                    u = v6.Assets
                    v7 = {
                        u.GetChildren(u),
                    }
                    W = u[3]
                    d = u[2]
                    for W, v7 in pairs(table.unpack(v7)) do
                        v5 = LocalPlayer
                        u = W
                        v8 = v5:DistanceFromCharacter( v7)
                        if arg1_14(v7) and v8 < math.huge then
                            v5 = v8
                            V = v8
                            F = v7
                        end
                    end
                end
                return nil
            end
            local function r85(filter)
                local results = {}
                for _, clipName in pairs(PromptConfig.Clip) do
                    for _, obj in pairs(workspace:GetDescendants()) do
                        if obj.Name == clipName and obj:IsDescendantOf(workspace) then
                            local ok, res = pcall(filter, obj)
                            if ok and res then
                                table.insert(results, obj)
                            end
                        end
                    end
                end
                return results
            end
            local function r88(arg1_16, arg2_16, arg3_16, ...)
                V = arg2_16
                v1 = arg1_16
                if arg3_16 then
                    s = v1:WaitForChild( "Collision", 5)
                    if s then
                        v3 = arg2_16
                        s.CanCollide = v3
                        s.CanTouch = not V
                    end
                else
                    s = v1:WaitForChild( "DoorFake", 5)
                    if s then
                        s:WaitForChild( "Hidden", 5).CanTouch = not arg2_16
                        U = s:WaitForChild( "Lock", 5)
                        if U then
                            v3 = U:FindFirstChild( "UnlockPrompt")
                        end
                        if U then
                            U.UnlockPrompt.Enabled = not arg2_16
                        end
                    end
                    return
                end
            end
            local function r89(arg1_17, ...)
                r90 = arg1_17
                task.spawn(function(...)
                    if not HumanoidRootPart or not CollisionPart then
                        return
                    end
                    V = r90.Parent
                    v3 = V
                    if V then
                        task.wait()
                        F = r90.Parent
                        v5 = 1
                        if F or v1 + 1 > 200 then
                            F = r90
                            s = F:IsDescendantOf( workspace)
                            if s then
                                v5 = V
                                v3 = r90.Parent and r90.Parent.Name == "TriggerEventCollision"
                            end
                            v5 = v5
                            if s then
                                HumanoidRootPart.Anchored = true
                                task.delay(0.25, function(...)
                                    HumanoidRootPart.Anchored = false
                                    return
                                end)
                                s = r90
                                v3 = not s:IsDescendantOf( workspace) or not Options.DeleteChase.Value
                                v5 = v5
                                repeat
                                    v3 = r90
                                until v3:IsDescendantOf( workspace)
                                firetouchinterest(r90, CollisionPart, 1)
                                task.wait()
                                v3 = r90
                                if v3:IsDescendantOf( workspace) then
                                    firetouchinterest(r90, CollisionPart, 0)
                                end
                                task.wait()
                                s = r90
                                V = v5
                                v5 = V
                                if not s:IsDescendantOf( workspace) or not Options.DeleteChase.Value then
                                    V = r90
                                    v3 = not V:IsDescendantOf( workspace)
                                    if v3 then
                                        v3 = Library
                                        v3.Notify(
                                            v3,
                                            "删除追逐战成功"
                                        )
                                    end
                                    return
                                end
                            end
                        end
                    else
                        v3 = 0 > 200
                    end
                end)
                return
            end
            local function r91(arg1_18, ...)
                local p = {
                    3,
                    2,
                    24,
                }
                v1 = arg1_18
                if not v1 then
                    q[p[5]] = q[p[6]] == arg1_18
                    if q[p[7]] then
                        error(q[p[8]], 0)
                    end
                    v1 = {}
                    for F = 1, q[p[9]] do
                        v1[F] = ""
                    end
                    v1[q[p[10]]] = q[p[11]]
                    return q[p[12]](v1)
                end
                V = v1:FindFirstChild( "Code", true)
                v1:FindFirstChild( "Correct", true)
                s = V.Text ~= "..."
                v3 = s
                if s then
                    task.wait()
                    v3 = V.Text ~= "..." or not v1:IsDescendantOf( workspace)
                    if v3 then
                        if not v1:IsDescendantOf( workspace) then
                            return
                        end
                        v3 = workspace.CurrentRooms["100"]
                        v5 = not v3:FindFirstChild( "DoorToBreakDown")
                        task.wait(0.1)
                        v5 = RemotesFolder.EBF
                        v5.FireServer(v5)
                        v3 = workspace.CurrentRooms["100"]
                        if not v3:FindFirstChild( "DoorToBreakDown") then
                            return
                        end
                    end
                else
                    v3 = not v1:IsDescendantOf( workspace)
                end
            end
            local function r92(arg1_19, ...)
                v1 = arg1_19
                
                if v1:FindFirstChild( "UI") then
                    C = ""
                    U = v1[""]
                    F = U[2]
                    U = U[1]
                    for s, v2 in pairs(U.GetChildren(U)) do
                        v4 = s
                        C = v2:IsA( "ImageLabel")
                        if C then
                            v6 = tonumber(v2.Name)
                        end
                        if C then
                            ({})[v2.ImageRectOffset.v1 .. v2.ImageRectOffset.Y] = {
                                tonumber(v2.Name),
                                "_",
                            }
                        end
                    end
                    v4 = PlayerGui.PermUI.Hints
                    v2 = {
                        v4.GetChildren(v4),
                    }
                    F = v4[1]
                    s = v4[2]
                    for U, v2 in pairs(table.unpack(v2)) do
                        v4 = U
                        if v2.Name == "Icon" then
                            if ({})[v2.ImageRectOffset.v1 .. v2.ImageRectOffset.Y] then
                                ({})[v2.ImageRectOffset.v1 .. v2.ImageRectOffset.Y][2] = v2.TextLabel.Text
                            end
                        end
                    end
                    F = {}
                    U = v2[2]
                    s = v4.GetChildren(v4)
                    for v4, v6 in pairs({}) do
                        v2 = v4
                        F[v6[1]] = v6[2]
                    end
                    return table.concat(F)
                end
                return "_____"
            end
            local function r93(arg1_20, ...)
                v1 = arg1_20
                if v1:IsA( "BasePart") then
                    if v1.Name == "Guidance" and Options.GuidingLightESP.Value then
                        AddGuidanceESP(arg1_20)
                    else
                        if table.find(EntityConfig.Names, arg1_20.Name) then
                            V = FormatEntityName(arg1_20.Name)
                            if Options.EntityESP.Value then
                                ESP.Add(arg1_20, V, Options.EntityESPColor.Value, 15, "EntityESP")
                            end
                            if Options.NotifyEntity.Value then
                                ShowNotify(
                                    "实体警告",
                                    V .. " 已生成",
                                    5
                                )
                                v5 = Options.NotifyChat.Value
                                if v5 then
                                    v5 = GeneralChannel
                                    v5:SendAsync( FormatEntityName(v1.Name) .. Options.NotifyChatText.Value)
                                end
                            end
                        end
                    end
                end
                return
            end
            local function r94(arg1_21, ...)
                v1 = arg1_21
                U = v1.GetChildren
                s = {
                    U(v1),
                }
                V = U[2]
                s = U[1]
                for F, v4 in pairs(table.unpack(s)) do
                    U = F
                    task.spawn(r93, v4)
                end
                F = v1.ChildAdded
                State.Connections.CameraChildAdded = F:Connect( function(arg1_22, ...)
                    task.spawn(r93, arg1_22)
                    return
                end)
                return
            end
            local function r95(arg1_23, ...)
                r96 = arg1_23
                F = Options.NotifyEntity
                if F.Value and F:GetAttribute( "RawName") == "HaltHallway" then
                    ShowNotify(
                        "实体警告",
                        "Halt在下个房间生成",
                        5
                    )
                    v5 = Options.NotifyChat.Value
                    if v5 then
                        v5 = GeneralChannel
                        v5.SendAsync(
                            v5,
                            "Halt在下个房间生成"
                        )
                    end
                end
                task.spawn(function(...)
                    F = r96
                    v1 = F[2]
                    F = F[1]
                    for V, U in pairs(F.GetDescendants(F)) do
                        s = V
                        if Options.DeleteChase.Value and U.Name == "Collision" then
                            r81(U)
                        end
                        task.spawn(r81, U)
                        task.wait()
                    end
                    return
                end)
                V = r96.DescendantAdded
                State.Connections[r96.Name .. "DescendantAdded"] = V:Connect( function(arg1_24, ...)
                    v1 = arg1_24
                    task.wait()
                    if not v1.Parent then
                        return
                    end
                    if Options.DeleteChase.Value and v1.Name == "Collision" then
                        r89(v1)
                    end
                    task.delay(0.1, r81, v1)
                    if Options.GoldESP.Value and v1.Name == "GoldPile" then
                        ESP.Add(
                            v1,
                            string.format("金子[%s]", v1:GetAttribute( "GoldValue")),
                            Options.GoldESPColor.Value,
                            15,
                            "GoldESP"
                        )
                    else
                        V = Options.ItemESP.Value
                        if V then
                            AddSideEntityESP(arg1_24)
                        end
                        if V then
                            AddObjectiveESP(arg1_24)
                        else
                            V = Options.EntityESP.Value
                            if V then
                                v3 = table.find(EntityConfig.SideNames, arg1_24.Name)
                            end
                            if V then
                                q[p[13]](arg1_24)
                            else
                                if Options.ObjectiveESP.Value then
                                    q[p[14]](arg1_24)
                                end
                                return
                            end
                        end
                    end
                end)
                return
            end
            local function r97(arg1_25, ...)
                r98 = arg1_25
                if Toggles.ItemESP.Value then
                    AddItemESP(r98)
                end
                task.spawn(function(...)
                    v5 = r98
                    v1 = v5:WaitForChild( "ModulePrompt", 3)
                    if v1 then
                        table.insert(PromptConfig.GamePrompts, v1)
                    end
                    return
                end)
                return
            end
            local function r99(arg1_26, ...)
                Character = arg1_26
                if Character then
                    v3 = Options.EnableJump.Value
                    if v3 then
                        v3 = Character
                        v3:SetAttribute( "CanJump", true)
                    end
                    v4 = State.Connections
                    F = v4[2]
                    V = v4[1]
                    for s, v4 in pairs(v4.Character) do
                        v4.Disconnect(v4)
                        U = s
                    end
                    F = Character.ChildAdded
                    State.Connections.Character.ChildAdded = F:Connect( function(arg1_27, ...)
                        v1 = arg1_27
                        V = v1:IsA( "Tool")
                        if V then
                            V = v1.Name
                            v3 = V:match( "LibraryHintPaper")
                        end
                        if V then
                            task.wait(0.1)
                            V = r92(v1)
                            v4 = {
                                string.gsub(V, "_", "x"),
                            }
                            F = v4[2]
                            v5 = workspace
                            v5:FindFirstChild( "Padlock", true)
                            if Options.AutoLibrarySolver.Value and tonumber(V) then
                                v5 = RemotesFolder.PL
                                v5:FireServer( V)
                            end
                            if Options.NotifyPadlock.Value and F < 5 then
                                v5 = Library
                                v5.Notify(
                                    v5,
                                    string.format(
                                        "图书馆密码: %s",
                                        string.gsub(V, "_", "x")
                                    ),
                                    5
                                )
                                if Toggles.NotifyChat.Value and F == 0 then
                                    v5 = GeneralChannel
                                    v5.SendAsync(
                                        v5,
                                        string.format(
                                            "图书馆密码: %s",
                                            string.gsub(V, "_", "x")
                                        )
                                    )
                                end
                            end
                        end
                        return
                    end)
                    F = Character
                    s = F:GetAttributeChangedSignal( "CanJump")
                    State.Connections.Character.CanJump = s:Connect( function(...)
                        V = Character
                        if not V:GetAttribute( "CanJump") and Options.EnableJump.Value then
                            v5 = Character
                            v5:SetAttribute( "CanJump", true)
                        end
                        return
                    end)
                    F = Character
                    s = F:GetAttributeChangedSignal( "Crouching")
                    State.Connections.Character.Crouching = s:Connect( function(...)
                        V = Character
                        if not V:GetAttribute( "Crouching") and Options.AntiHearing.Value then
                            v5 = RemotesFolder.Crouch
                            v5:FireServer( true)
                        end
                        return
                    end)
                    F = Character
                    s = F:GetAttributeChangedSignal( "Oxygen")
                    State.Connections.Character.Oxygen = s:Connect( function(...)
                        V = Character
                        F = V:GetAttribute( "Oxygen")
                        if F < 100 and Toggles.NotifyOxygen.Value then
                            v1 = "氧气: %.1f"
                            F = Character
                            MainGameModule.caption(v1:format( F:GetAttribute( "Oxygen")), true)
                        end
                        return
                    end)
                end
                v3 = Character
                U = q[s]
                Humanoid = v3:WaitForChild( "Humanoid")
                if Humanoid then
                    v2 = State.Connections
                    U = v2[3]
                    s = v2[2]
                    for U, v2 in pairs(v2.Humanoid) do
                        v4 = U
                        v2.Disconnect(v2)
                    end
                    s = Humanoid
                    U = s:GetPropertyChangedSignal( "JumpHeight")
                    State.Connections.Humanoid.Jump = U:Connect( function(...)
                        if Options.EnableJump.Value then
                            Humanoid.JumpHeight = Options.JumpHeight.Value
                        end
                        return
                    end)
                end
                v3 = Character
                HumanoidRootPart = v3:WaitForChild( "HumanoidRootPart")
                if HumanoidRootPart then
                    s = Instance.new("BodyVelocity")
                    s.Velocity = Vector3.zero
                    s.MaxForce = Vector3.one * 9000000000
                    State.Temp.FlyBody = s
                    if Options.NoAccel.Value then
                        State.Temp.NoAccelValue = HumanoidRootPart.CustomPhysicalProperties.Density
                        U = HumanoidRootPart.CustomPhysicalProperties
                        HumanoidRootPart.CustomPhysicalProperties =
                            PhysicalProperties.new(100, U.Friction, U.Elasticity, U.FrictionWeight, U.ElasticityWeight)
                    end
                end
                v3 = Character
                CollisionPart = v3:WaitForChild( "Collision")
                if IsMines then
                    if Humanoid then
                        Humanoid.MaxSlopeAngle = Options.MaxSlopeAngle.Value
                    end
                end
                return
            end
            local function r100(arg1_28, ...)
                r101 = arg1_28
                if r101.Character then
                    if Options.PlayerESP.Value then
                        ESP.Add(r101.Character, r101.DisplayName, Options.PlayerESPColor.Value, 15, "PlayerESP")
                    end
                end
                v5 = r101.CharacterAdded
                v5:Connect( function(arg1_29, ...)
                    task.delay(0.1, function(...)
                        if Options.PlayerESP.Value then
                            ESP.Add(r101.Character, r101.DisplayName, Options.PlayerESPColor.Value, 15, "PlayerESP")
                        end
                        return
                    end)
                    V = arg1_29.ChildAdded
                    State.Connections[r101.Name .. "ChildAdded"] = V:Connect( function(arg1_30, ...)
                        v1 = arg1_30
                        V = v1:IsA( "Tool")
                        if V then
                            V = v1.Name
                            v3 = V:match( "LibraryHintPaper")
                        end
                        if V then
                            task.wait(0.1)
                            V = r92(v1)
                            v5 = workspace
                            v5:FindFirstChild( "Padlock", true)
                            if Options.AutoLibrarySolver.Value and tonumber(V) then
                                v5 = RemotesFolder.PL
                                v5:FireServer( V)
                            end
                        end
                        return
                    end)
                    return
                end)
                return
            end
            local OldNamecall
            OldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
                local args = {...}
                local method = getnamecallmethod():lower()
                if checkcaller() then
                    return OldNamecall(self, unpack(args))
                end
                if method == "fireserver" then
                    if self.Name == "ClutchHeartbeat" and Options.AutoHeartbeat.Value then
                        return
                    end
                    if self.Name == "Crouch" and Options.AntiHearing.Value then
                        args[1] = true
                        return OldNamecall(self, unpack(args))
                    end
                elseif method == "destroy" and self.Name == "RunnerNodes" then
                    return
                end
                return OldNamecall(self, unpack(args))
            end)
            zS = Library
            wS = workspace.ChildAdded
            zS.GiveSignal(
                zS,
                wS:Connect( function(arg1_32, ...)
                    v1 = arg1_32
                    task.wait(0.1)
                    V = EntityConfig.Names
                    if table.find(V, v1.Name) then
                        F = LocalPlayer
                        V = F:DistanceFromCharacter( v1.GetPivot(v1).Position) < 750
                        v3 = V
                        if V then
                            task.wait()
                            F = LocalPlayer
                            if
                                F:DistanceFromCharacter( v1.GetPivot(v1).Position) < 750
                                or not v1:IsDescendantOf( workspace)
                            then
                                V = "workspace"
                                if v1:IsDescendantOf( Env[V]) then
                                    v5 = FormatEntityName
                                    V = v5(v1.Name)
                                    if IsFools and v1.Name == "RushMoving" then
                                        v5 = arg1_32.PrimaryPart.Name
                                        v5:gsub( "New", "")
                                    end
                                    if V == "Seek" and Options.Godmode.Value then
                                        ShowNotify(
                                            "提示",
                                            "Seek追逐战请关闭上帝模式",
                                            5
                                        )
                                    end
                                    if Options.EntityESP.Value then
                                        if v1.PrimaryPart and v1.PrimaryPart.Transparency == 1 then
                                            arg1_32.PrimaryPart.Transparency = 0.99
                                        end
                                        Instance.new("Humanoid", v1)
                                        ESP.Add(v1, V, Options.EntityESPColor.Value, 15, "EntityESP")
                                    end
                                    if Options.NotifyEntity.Value then
                                        ShowNotify(
                                            "实体警告",
                                            V .. " 已生成",
                                            5
                                        )
                                        v5 = Options.NotifyChat.Value
                                        if v5 then
                                            v5 = GeneralChannel
                                            v5:SendAsync( v5(v1.Name) .. Options.NotifyChatText.Value)
                                        end
                                    end
                                    if table.find(EntityConfig.Avoid, v1.Name) then
                                        
                                        v5 = Options.AutoAvoid.Value
                                        if v5 then
                                            s = Options.Noclip.Value
                                            v5 = Options.Noclip
                                            v5:SetValue( true)
                                            v4 = not v1:IsDescendantOf( workspace)
                                            U = v4
                                            if v4 then
                                                task.wait()
                                                v5 = Character
                                                v5:PivotTo( HumanoidRootPart.CFrame * CFrame.new(0, -10, 0))
                                                if
                                                    not v1:IsDescendantOf( workspace)
                                                    or (
                                                        v1.GetPivot(v1).Position.Y > 300
                                                        or (
                                                            v1.GetPivot(v1).Position.Y < -300 or not Options.AutoAvoid.Value
                                                        )
                                                    )
                                                then
                                                    Options.Noclip.Value = Options.Noclip.Value
                                                    v5 = Character
                                                    v5:PivotTo( HumanoidRootPart.CFrame)
                                                    return
                                                end
                                            else
                                                U = v1.GetPivot(v1).Position.Y > 300
                                                    or (v1.GetPivot(v1).Position.Y < -300 or not Options.AutoAvoid.Value)
                                                v5 = Options[""]
                                            end
                                        end
                                    end
                                end
                            end
                        else
                            v3 = not v1:IsDescendantOf( workspace)
                        end
                    end
                end)
            )
            BS = workspace.Drops
            pS = BS[1]
            wS = BS[2]
            for PS, BS in pairs(BS.GetChildren(BS)) do
                zS = PS
                task.spawn(r97, BS)
            end
            zS = Library
            wS = workspace.Drops.ChildAdded
            zS.GiveSignal(
                zS,
                wS:Connect( function(arg1_33, ...)
                    task.spawn(r97, arg1_33)
                    return
                end)
            )
            BS = workspace.CurrentRooms
            wS = BS[2]
            pS = BS[1]
            for PS, BS in pairs(BS.GetChildren(BS)) do
                zS = PS
                task.spawn(r95, BS)
            end
            zS = Library
            wS = workspace.CurrentRooms.ChildAdded
            zS.GiveSignal(
                zS,
                wS:Connect( function(arg1_34, ...)
                    v3 = LocalPlayer
                    v1 = arg1_34
                    if v3:GetAttribute( "CurrentRoom") == 48 then
                        task.wait(2)
                    end
                    v6 = 19906763858997
                    task.spawn(r95, v1)
                    if Options.DoorESP.Value then
                        AddDoorESP(v1)
                    end
                    U = v1.GetDescendants
                    s = {
                        U(v1),
                    }
                    s = U[1]
                    V = U[2]
                    for F, v4 in pairs(table.unpack(s)) do
                        U = F
                        task.wait()
                        v6 = Options.WardrobeESP.Value
                        if v6 then
                            v2 = v4:GetAttribute( "LoadModule") == "Wardrobe"
                                or (v4.Name == "Rooms_Locker" or v4.Name == "RetroWardrobe")
                            v5 = task.wait
                        end
                        if v6 then
                            ESP.Add(v4, "柜子", Options.WardrobeESPColor.Value, 15, "WardrobeESP")
                        else
                            if Options.GoldESP.Value and v4.Name == "GoldPile" then
                                ESP.Add(
                                    v4,
                                    string.format("金子 [%s]", v4:GetAttribute( "GoldValue")),
                                    Options.GoldESPColor.Value,
                                    15,
                                    "GoldESP"
                                )
                            else
                                if Options.ChestESP.Value and v4:GetAttribute( "Storage") == "ChestBox" then
                                    AddChestESP(v4)
                                else
                                    v6 = Options.ItemESP.Value
                                    if v6 then
                                        r79(v4)
                                    end
                                    if v6 then
                                        AddItemESP(v4)
                                    else
                                        v6 = Options.EntityESP.Value
                                        if v6 then
                                            v2 = table.find(EntityConfig.SideNames, v4.Name)
                                        end
                                        if v6 then
                                            AddSideEntityESP(v4)
                                        else
                                            if Options.ObjectiveESP.Value then
                                                AddObjectiveESP(v4)
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                    return
                end)
            )
            if Camera then
                task.spawn(r94, Camera)
            end
            zS = Library
            wS = workspace
            PS = wS:GetPropertyChangedSignal( "CurrentCamera")
            zS.GiveSignal(
                zS,
                PS:Connect( function(...)
                    if workspace.CurrentCamera then
                        Camera = workspace.CurrentCamera
                        task.spawn(r94, Camera)
                    end
                    return
                end)
            )
            BS = Players
            wS = BS[2]
            PS = BS[3]
            for PS, BS in pairs(BS.GetPlayers(BS)) do
                zS = PS
                if BS == LocalPlayer then
                else
                    r100(BS)
                end
            end
            zS = Library
            wS = Players.PlayerAdded
            zS.GiveSignal(
                zS,
                wS:Connect( function(arg1_35, ...)
                    v1 = arg1_35
                    if v1 == LocalPlayer then
                        return
                    end
                    r100(v1)
                    return
                end)
            )
            zS = Library
            wS = LocalPlayer.CharacterAdded
            zS.GiveSignal(
                zS,
                wS:Connect( function(arg1_36, ...)
                    task.delay(1, r99, arg1_36)
                    return
                end)
            )
            zS = Library
            wS = LocalPlayer
            PS = wS:GetAttributeChangedSignal( "CurrentRoom")
            zS.GiveSignal(
                zS,
                PS:Connect( function(...)
                    v1 = LocalPlayer
                    if CurrentRoom == v1:GetAttribute( "CurrentRoom") then
                        return
                    end
                    v5 = LocalPlayer
                    CurrentRoom = v5:GetAttribute( "CurrentRoom")
                    NextRoom = CurrentRoom + 1
                    return
                end)
            )
            zS = Library
            wS = PlayerGui.ChildAdded
            zS.GiveSignal(
                zS,
                wS:Connect( function(arg1_37, ...)
                    v1 = arg1_37
                    v5 = v1.Name == "MainUI"
                    if v5 then
                        v5 = arg1_37
                        MainUI = v5
                        task.delay(1, function(...)
                            if MainUI then
                                v5 = MainUI
                                v3 = v5:WaitForChild( "Initiator")
                                Initiator = v3:WaitForChild( "Main_Game")
                                v3 = Initiator
                                if v3 then
                                    MainGameModule = require(Initiator)
                                    v3 = Initiator
                                    if v3:WaitForChild( "Health", 5) then
                                        v3 = IsHotel and Options.NoJammin.Value
                                        v3:WaitForChild( v1)
                                        if v3 then
                                            v3 = Initiator
                                            V = v3:FindFirstChild( "Jam", true)
                                            if V then
                                                V.Playing = false
                                            end
                                        end
                                    end
                                    v3 = Initiator
                                    if v3:WaitForChild( "RemoteListener", 5) then
                                        v3 = Initiator
                                        V = v3:FindFirstChild( "Modules", true)
                                        if not V then
                                            return
                                        end
                                        if Options.AntiDread.Value then
                                            F = V:FindFirstChild( "Dread", true)
                                            if F then
                                                F.Name = "_Dread"
                                            end
                                        end
                                        if Options.AntiScreech.Value then
                                            F = V:FindFirstChild( "Screech", true)
                                            if F then
                                                F.Name = "_Screech"
                                            end
                                        end
                                        if Options.NoSpiderJumpscare.Value then
                                            F = V:FindFirstChild( "SpiderJumpscare", true)
                                            if F then
                                                F.Name = "_SpiderJumpscare"
                                            end
                                        end
                                        if Options.AntiA90.Value then
                                            F = V:FindFirstChild( "A90", true)
                                            if F then
                                                F.Name = "_A90"
                                            end
                                        end
                                    end
                                end
                            end
                            return
                        end)
                    end
                    return
                end)
            )
            zS = Library
            wS = RunService.RenderStepped
            zS.GiveSignal(
                zS,
                wS:Connect( function(...)
                    
                    v1 = Toggles.ThirdPerson.Value and Library.IsMobile
                    if MainGameModule then
                        if v1 then
                            Camera.CFrame = MainGameModule.finalCamCFrame
                                * CFrame.new(Options.OffsetX.Value, Options.OffsetY.Value, Options.OffsetZ.Value)
                        end
                        MainGameModule.fovtarget = Options.FOV.Value
                        if Toggles.NoCamShake.Value then
                            MainGameModule.csgo = CFrame.new()
                            MainGameModule.bobspring.Position = Vector3.new()
                            MainGameModule.spring.Position = Vector3.new()
                        end
                    end
                    if Character then
                        if Humanoid and Options.EnableSpeedHack.Value then
                            v3 = IsFools and Humanoid and nil
                            v5 = Character
                            V = Character
                            V:SetAttribute( "SpeedBoostBehind", Options.WalkSpeed.Value)
                        end
                        if Humanoid and Options.EnableJump.Value then
                            Humanoid.JumpHeight = Options.JumpHeight.Value
                        end
                        v5 = Options.Noclip.Value
                        if v5 then
                            if HumanoidRootPart then
                                HumanoidRootPart.CanCollide = false
                            end
                            v5 = CollisionPart
                            if v5 then
                                CollisionPart.CanCollide = false
                                v5 = CollisionPart
                                if v5:FindFirstChild( "CollisionCrouch") then
                                    CollisionPart.CollisionCrouch.CanCollide = false
                                end
                            end
                            v5 = Character
                            if v5:FindFirstChild( "UpperTorso") then
                                Character.UpperTorso.CanCollide = false
                            end
                            v5 = Character
                            if v5:FindFirstChild( "LowerTorso") then
                                Character.LowerTorso.CanCollide = false
                            end
                        end
                        V = Options.DoorReach.Value
                        v3 = Options
                        if V then
                            V = workspace.CurrentRooms
                            v3 = V:FindFirstChild( LatestRoom.Value)
                        end
                        if v3 then
                            v5 = workspace.CurrentRooms[LatestRoom.Value]
                            V = v5:FindFirstChild( "Door")
                            if V then
                                v3 = V:FindFirstChild( "ClientOpen")
                            end
                            if V then
                                v5 = V.ClientOpen
                                v5.FireServer(v5)
                            end
                        end
                        
                        if Options.AutoInteract.Enabled then
                            s = U[3]
                            U = U[1]
                            for s, v2 in
                                U,
                                pairs(r85(function(arg1_38, ...)
                                    v1 = arg1_38
                                    if not v1.Parent then
                                        return false
                                    end
                                    v5 = v1.Parent
                                    if v5:GetAttribute( "JeffShop") then
                                        return false
                                    end
                                    v5 = v1.Name == "PropPrompt"
                                    if v5 then
                                        return false
                                    end
                                    F = v5
                                    s = v1.Name == "UnlockPrompt"
                                    V = s
                                    if s then
                                        v5 = v5
                                        if V and s:FindFirstChild( "Lockpick") then
                                            return false
                                        end
                                        F = v1.Parent
                                        
                                        
                                        V = F:GetAttribute( "PropType") == "Battery"
                                        v3 = v1.Parent
                                        if V then
                                            U = Character
                                            
                                            v4 = U:FindFirstChildOfClass( "Tool")
                                            if v4 then
                                                v6 = Character
                                                C = v6:FindFirstChildOfClass( "Tool")
                                                C = "Battery"
                                                F = C:GetAttribute( "RechargeProp") == C
                                                    or C:GetAttribute( "StorageProp") == "Battery"
                                                v5 = v5
                                            end
                                            v5 = v5
                                            v3 = not v4
                                        end
                                        if v3 then
                                            return false
                                        end
                                        if v1.Parent.Name == "Typewriter" then
                                            return false
                                        end
                                        if v1.Name == "ActivateEventPrompt" and v.Parent.Name == "Box" then
                                            return false
                                        end
                                        F = v1.Parent
                                        s = F:GetAttribute( "PropType")
                                        V = s == "Heal"
                                        v3 = v1.Parent
                                        if V then
                                            s = Humanoid
                                            if s then
                                                V = Humanoid.Health == Humanoid.MaxHealth
                                            end
                                            v5 = v1.Parent.Name == "Typewriter"
                                            v3 = s
                                        end
                                        if v3 then
                                            return false
                                        end
                                        if v1.Parent.Name == "MinesAnchor" then
                                            return false
                                        end
                                        if IsRetro and v1.Parent.Parent.Name == "RetroWardrobe" then
                                            return false
                                        end
                                        return PromptConfig.Aura[v1.Name] ~= nil
                                    else
                                        s = v1.Parent
                                        V = s:GetAttribute( "Locked")
                                    end
                                end))
                            do
                                r103 = v2
                                task.spawn(function(...)
                                    
                                    if
                                        r103.Enabled
                                        and s.DistanceFromCharacter(
                                                s,
                                                ("-�k�q").GetPivot("-�k�q").Position
                                            )
                                            < r103.MaxActivationDistance
                                    then
                                        V = r103.Parent.Name
                                        
                                        v1 = V == "Slot"
                                        if v1 then
                                            v1 = r103.Parent
                                            v3 = v1:GetAttribute( "Hint")
                                        end
                                        if v1 then
                                            if State.Temp.PaintingDebounce[r103] then
                                                return
                                            end
                                            v5 = Character
                                            v1 = v5:FindFirstChild( "Prop")
                                            v5 = r103.Parent
                                            V = v5:FindFirstChild( "Prop")
                                            v5 = r103.Parent
                                            U = v5:GetAttribute( "Hint")
                                            if
                                                (V and V:GetAttribute( "Hint")) ~= U
                                                and (v1 and v1:GetAttribute( "Hint")) == U
                                            then
                                                State.Temp.PaintingDebounce[r103] = true
                                                fireproximityprompt(r103)
                                                task.wait(0.3)
                                                State.Temp.PaintingDebounce[r103] = false
                                            end
                                            return
                                        end
                                        fireproximityprompt(r103)
                                    end
                                    return
                                end)
                            end
                        end
                        U = "Value"
                        if Options.AntiEyes[U] and U:FindFirstChild( "Eyes") then
                            v5 = not IsFools
                            if v5 then
                                v5 = RemotesFolder.MotorReplication
                                v5:FireServer( -649)
                            else
                                v5 = RemotesFolder.MotorReplication
                                v5:FireServer( 0, -90, 0, false)
                            end
                        end
                        if IsMines then
                            
                            if Options.AutoAnchorSolver.Value and LatestRoom.Value == 50 then
                                v2 = MainUI.MainFrame.AnchorHintFrame.Code
                                r104 = {
                                    ["DesignatedAnchor"] = MainUI.MainFrame.AnchorHintFrame.AnchorCode.Text,
                                    ["AnchorCode"] = v2.Text,
                                }
                                U = v2[2]
                                v4 = v2[3]
                                for v4, v6 in
                                    pairs(r85(function(arg1_39, ...)
                                        s = "ActivateEventPrompt"
                                        return arg1_39.Name == s and s:IsA( "Model")
                                    end))
                                do
                                    v2 = v4
                                    r105 = v6
                                    v6 = 19
                                    task.spawn(function(...)
                                        v1 = r105.Parent
                                        F = LocalPlayer
                                        v4 = r105.Parent
                                        if
                                            not (
                                                F:DistanceFromCharacter( v4.GetPivot(v4).Position)
                                                < r105.MaxActivationDistance
                                            )
                                        then
                                            return
                                        end
                                        if v1.Sign.TextLabel.Text ~= r104.DesignatedAnchor then
                                            return
                                        end
                                        v5 = v1:FindFirstChildOfClass( "RemoteFunction")
                                        v5:InvokeServer( r104.AnchorCode)
                                        return
                                    end)
                                end
                            end
                        end
                        if IsGarden then
                            F = Options.AntiMonument.Value
                            if F then
                                F = workspace
                                V = F:FindFirstChild( "MonumentEntity")
                            end
                            if F then
                                HumanoidRootPart.CFrame = CFrame.new(HumanoidRootPart.Position, workspace.MonumentEntity.PrimaryPart.Position)
                            end
                        end
                    end
                    task.spawn(function(...)
                        s = State.Temp
                        F = s.Guidance
                        v1 = s[2]
                        F = s[1]
                        for V, U in pairs(F) do
                            if not V:IsDescendantOf( workspace) then
                            else
                                U.CFrame = V.CFrame
                            end
                        end
                        return
                    end)
                    if Options.Fullbright.Value then
                        Lighting.Ambient = Color3.new(1, 1, 1)
                    end
                    return
                end)
            )
            task.spawn(r99, Character)
            

    task.spawn(r99, Character)

    local Window = Library:CreateWindow({
        Title = "Sybsy",
        Footer = "当前楼层: " .. FloorValue.Value,
        Size = UDim2.new(580, 350),
        Center = true,
        AutoShow = true,
    })

    local MainTab = Window:AddTab("主要")
    local PlayerGroup = MainTab:AddLeftGroupbox("玩家")
    local MovementGroup = MainTab:AddRightGroupbox("功能")

    PlayerGroup:AddSlider("WalkSpeed", {
        Text = "行走速度",
        Default = 5,
        Min = 0,
        Max = 50,
        Rounding = 1,
        Compact = true,
    })

    PlayerGroup:AddSlider("JumpHeight", {
        Text = "跳跃高度",
        Default = 5,
        Min = 0,
        Max = 20,
        Rounding = 1,
        Compact = true,
        Disabled = IsFools,
    })

    if IsHotel or IsMines then
        PlayerGroup:AddSlider("MaxSlopeAngle", {
            Text = "最大坡度角",
            Default = 45,
            Min = 0,
            Max = 90,
            Rounding = 1,
            Callback = function(value)
                if Humanoid then
                    Humanoid.MaxSlopeAngle = value
                end
            end,
        })
    end

    PlayerGroup:AddToggle("EnableSpeedHack", {
        Text = "启用速度修改",
        Default = false,
        Callback = function(enabled)
            if not enabled and Character then
                Character:SetAttribute("SpeedBoostBehind", 0)
            end
        end,
    })

    PlayerGroup:AddToggle("EnableJump", {
        Text = "允许跳跃",
        Default = false,
        Callback = function(enabled)
            if Character then
                Character:SetAttribute("CanJump", enabled)
            end
        end,
    })

    PlayerGroup:AddToggle("NoAccel", {
        Text = "消除加速",
        Default = false,
        Callback = function(enabled)
            if not HumanoidRootPart then return end
            if enabled then
                State.Temp.NoAccelValue = HumanoidRootPart.CustomPhysicalProperties.Density
                local props = HumanoidRootPart.CustomPhysicalProperties
                HumanoidRootPart.CustomPhysicalProperties = PhysicalProperties.new(
                    100, props.Friction, props.Elasticity, props.FrictionWeight, props.ElasticityWeight
                )
            else
                local props = HumanoidRootPart.CustomPhysicalProperties
                HumanoidRootPart.CustomPhysicalProperties = PhysicalProperties.new(
                    State.Temp.NoAccelValue or props.Density,
                    props.Friction, props.Elasticity, props.FrictionWeight, props.ElasticityWeight
                )
            end
        end,
    })

    local NoclipToggle = PlayerGroup:AddToggle("Noclip", {
        Text = "穿墙",
        Default = false,
    })
    NoclipToggle:AddKeyPicker("NoclipKey", {
        Default = "N",
        SyncToggleState = true,
        Mode = "Toggle",
    })

    local FlyToggle = PlayerGroup:AddToggle("Fly", {
        Text = "飞行",
        Default = false,
    })
    FlyToggle:AddKeyPicker("FlyKey", {
        Default = "F",
        SyncToggleState = true,
        Mode = "Toggle",
    })

    PlayerGroup:AddSlider("FlySpeed", {
        Text = "飞行速度",
        Default = 15,
        Min = 10,
        Max = 100,
        Rounding = 1,
    })

    Toggles.Fly:OnChanged(function(enabled)
        if not HumanoidRootPart then return end
        if Humanoid then
            Humanoid.PlatformStand = enabled
        end
        if State.Temp.FlyBody then
            State.Temp.FlyBody.Parent = enabled and HumanoidRootPart or nil
        end
        if enabled then
            State.Connections.Fly = RunService.RenderStepped:Connect(function()
                local move = ControlModule:GetMoveVector()
                local direction = -(Camera.CFrame.LookVector * move.Z - Camera.CFrame.RightVector * move.X)
                State.Temp.FlyBody.Velocity = direction * Options.FlySpeed.Value
            end)
        elseif State.Connections.Fly then
            State.Connections.Fly:Disconnect()
        end
    end)

    MovementGroup:AddToggle("AutoInteract", {
        Text = "自动交互",
        Default = false,
    })

    Toggles.AutoInteract:OnChanged(function(enabled)
        for _, room in pairs(workspace.CurrentRooms:GetChildren()) do
            for _, obj in pairs(room:GetDescendants()) do
                if obj:IsA("ProximityPrompt") then
                    if enabled then
                        if not obj:GetAttribute("Hold") then
                            obj:SetAttribute("Hold", obj.HoldDuration)
                        end
                        obj.HoldDuration = 0
                    else
                        obj.HoldDuration = obj:GetAttribute("Hold") or 0
                    end
                end
            end
        end
    end)

    MovementGroup:AddToggle("InstaInteract", {
        Text = "瞬间交互",
        Default = false,
        Callback = function(enabled)
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj:IsA("ProximityPrompt") and not table.find(PromptConfig.Excluded.Prompt, obj.Name) then
                    if enabled then
                        obj.RequiresLineOfSight = false
                    elseif obj:GetAttribute("Enabled") and obj:GetAttribute("Clip") then
                        obj.Enabled = obj:GetAttribute("Enabled")
                        obj.RequiresLineOfSight = obj:GetAttribute("Clip")
                    end
                end
            end
        end,
    })

    MovementGroup:AddToggle("PromptClip", {
        Text = "穿墙交互",
        Default = false,
        Callback = function(enabled)
            for _, room in pairs(workspace.CurrentRooms:GetChildren()) do
                for _, obj in pairs(room:GetDescendants()) do
                    if obj:IsA("ProximityPrompt") and not table.find(PromptConfig.Excluded.Prompt, obj.Name) then
                        if enabled then
                            obj.RequiresLineOfSight = false
                        elseif obj:GetAttribute("Enabled") and obj:GetAttribute("Clip") then
                            obj.Enabled = obj:GetAttribute("Enabled")
                            obj.RequiresLineOfSight = obj:GetAttribute("Clip")
                        end
                    end
                end
            end
        end,
    })

    MovementGroup:AddSlider("InteractDistance", {
        Text = "交互距离",
        Default = 1,
        Min = 1,
        Max = 2,
        Rounding = 1,
        Callback = function()
            for _, room in pairs(workspace.CurrentRooms:GetChildren()) do
                for _, obj in pairs(room:GetDescendants()) do
                    if obj:IsA("ProximityPrompt") and not table.find(PromptConfig.Excluded.Prompt, obj.Name) then
                        if not obj:GetAttribute("Distance") then
                            obj:SetAttribute("Distance", obj.MaxActivationDistance)
                        end
                        obj.MaxActivationDistance = obj:GetAttribute("Distance") * Options.InteractDistance.Value
                    end
                end
            end
        end,
    })

    MovementGroup:AddToggle("DoorReach", {
        Text = "延伸门范围",
        Default = false,
    })

    MovementGroup:AddToggle("AutoAvoid", {
        Text = "自动躲避",
        Default = false,
        Callback = function(enabled)
            if Humanoid then
                Humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall, not enabled)
            end
        end,
    })

    if IsHotel or IsFools then
        MovementGroup:AddToggle("AutoLibrarySolver", {
            Text = "自动图书馆解谜",
            Default = false,
            Callback = function(enabled)
                if not enabled then return end
                for _, player in pairs(Players:GetPlayers()) do
                    if player.Character then
                        local tool = player.Character:FindFirstChildOfClass("Tool")
                        if tool and tool.Name:match("LibraryHintPaper") then
                            local code = r92(tool)
                            local padlock = workspace:FindFirstChild("Padlock", true)
                            if padlock and LocalPlayer:DistanceFromCharacter(padlock:GetPivot().Position) <= 20 then
                                RemotesFolder.PL:FireServer(code)
                            end
                        end
                    end
                end
            end,
        })

        MovementGroup:AddToggle("AutoBreakerSolver", {
            Text = "自动断路器解谜",
            Default = false,
            Callback = function(enabled)
                if not enabled then return end
                local breaker = workspace.CurrentRooms:FindFirstChild("ElevatorBreaker", true)
                if breaker then r91(breaker) end
            end,
        })
    end

    if IsMines then
        MovementGroup:AddToggle("AutoAnchorSolver", {
            Text = "自动锚点解谜",
            Default = false,
        })
    end

    if IsHotel or IsBackdoor or IsFools then
        local AntiTab = Window:AddTab("防止")
        local AntiEntityGroup = AntiTab:AddLeftGroupbox("防止实体")
        local AntiMiscGroup = AntiTab:AddRightGroupbox("防止机制")

        if IsHotel or IsFools then
            AntiEntityGroup:AddToggle("AntiChandelier", {
                Text = "防止吊灯/Seek手臂",
                Default = false,
                Callback = function(enabled)
                    for _, room in pairs(workspace.CurrentRooms:GetChildren()) do
                        for _, obj in pairs(room:GetDescendants()) do
                            if obj.Name == "ChandelierObstruction" or obj.Name == "Seek_Arm" then
                                for _, part in pairs(obj:GetDescendants()) do
                                    if part:IsA("BasePart") then
                                        part.CanTouch = not enabled
                                    end
                                end
                            end
                        end
                    end
                end,
            })

            AntiEntityGroup:AddToggle("AntiA90", {
                Text = "防止A-90",
                Default = false,
                Callback = function(enabled)
                    local a90 = workspace:FindFirstChild("A90", true) or workspace:FindFirstChild("_A90", true)
                    if a90 then
                        a90.Name = enabled and "_A90" or "A90"
                    end
                end,
            })

            if LiveModifiers:FindFirstChild("Jammin") then
                AntiEntityGroup:AddToggle("AntiJamming", {
                    Text = "防止Jamming",
                    Default = false,
                    Callback = function(enabled)
                        local jam = workspace:FindFirstChild("Jam", true)
                        if jam and jam:IsA("Sound") then jam.Playing = not enabled end
                        local sound = SoundService:FindFirstChild("Jamming", true)
                        if sound then sound.Enabled = not enabled end
                    end,
                })
            end

            AntiEntityGroup:AddToggle("AntiHearing", {
                Text = "防止听力检测",
                Default = false,
            })

            AntiEntityGroup:AddToggle("InfiniteCrouch", {
                Text = "无限蹲下",
                Default = false,
                Callback = function(enabled)
                    if not IsFools then
                        RemotesFolder.Crouch:FireServer(enabled)
                    end
                end,
            })
        end

        if IsMines then
            AntiEntityGroup:AddToggle("AntiGiggle", {
                Text = "防止Giggle",
                Default = false,
                Callback = function(enabled)
                    for _, room in pairs(workspace.CurrentRooms:GetChildren()) do
                        for _, obj in pairs(room:GetChildren()) do
                            if obj.Name == "GiggleCeiling" then
                                local hitbox = obj:WaitForChild("Hitbox", 5)
                                if hitbox then hitbox.CanTouch = not enabled end
                            end
                        end
                    end
                end,
            })

            AntiEntityGroup:AddToggle("AntiGloomEggs", {
                Text = "防止Gloom蛋",
                Default = false,
                Callback = function(enabled)
                    for _, room in pairs(workspace.CurrentRooms:GetChildren()) do
                        for _, obj in pairs(room:GetChildren()) do
                            if obj.Name == "GloomPile" then
                                for _, part in pairs(obj:GetDescendants()) do
                                    if part.Name == "Egg" then
                                        part.CanTouch = not enabled
                                    end
                                end
                            end
                        end
                    end
                end,
            })
        end

        AntiEntityGroup:AddToggle("AntiSnare", {
            Text = "防止地刺",
            Default = false,
            Callback = function(enabled)
                for _, room in pairs(workspace.CurrentRooms:GetChildren()) do
                    if room:FindFirstChild("Assets") then
                        for _, obj in pairs(room.Assets:GetChildren()) do
                            if obj.Name == "Snare" then
                                local hitbox = obj:WaitForChild("Hitbox", 5)
                                if hitbox then hitbox.CanTouch = not enabled end
                            end
                        end
                    end
                end
            end,
        })

        AntiMiscGroup:AddToggle("AntiJumpscare", {
            Text = "防止惊吓",
            Default = false,
            Callback = function(enabled)
                local jumpscare = RemotesFolder.Jumpscare
                for _, conn in pairs(getconnections(jumpscare.OnClientEvent)) do
                    if enabled then conn:Disable() else conn:Enable() end
                end
            end,
        })
    end

    local ESPTab = Window:AddTab("透视")
    local ESPTypeBox = ESPTab:AddLeftTabbox()
    local DoorESPGroup = ESPTypeBox:AddTab("门")
    local ObjectiveESPGroup = ESPTypeBox:AddTab("目标")
    local ItemESPGroup = ESPTypeBox:AddTab("物品")
    local EntityESPGroup = ESPTypeBox:AddTab("实体")
    local PlayerESPGroup = ESPTypeBox:AddTab("玩家")
    local ESPSettingsGroup = ESPTab:AddRightGroupbox("ESP设置")

    DoorESPGroup:AddToggle("DoorESP", {
        Text = "门ESP",
        Default = false,
        Callback = function(enabled)
            if enabled then
                for _, room in pairs(workspace.CurrentRooms:GetChildren()) do
                    AddDoorESP(room)
                end
            else
                for _, conn in pairs(State.Connections.Door) do
                    conn:Disconnect()
                end
                ESP:Clear("DoorESP")
            end
        end,
    })
    DoorESPGroup:AddLabel("门颜色"):AddColorPicker("DoorESPColor", {
        Default = Color3.fromRGB(255, 255, 255),
        Callback = function(color)
            ESP:Update("DoorESP", { Color = color })
        end,
    })

    ObjectiveESPGroup:AddToggle("ObjectiveESP", {
        Text = "目标ESP",
        Default = false,
        Callback = function(enabled)
            if enabled then
                local room = workspace.CurrentRooms[tostring(CurrentRoom)]
                if room then
                    for _, obj in pairs(room:GetDescendants()) do
                        task.spawn(AddObjectiveESP, obj)
                    end
                end
            else
                ESP:Clear("ObjectiveESP")
            end
        end,
    })
    ObjectiveESPGroup:AddLabel("目标颜色"):AddColorPicker("ObjectiveESPColor", {
        Default = Color3.fromRGB(255, 255, 0),
        Callback = function(color)
            ESP:Update("ObjectiveESP", { Color = color })
        end,
    })

    ItemESPGroup:AddToggle("ItemESP", {
        Text = "物品ESP",
        Default = false,
    })
    ItemESPGroup:AddLabel("物品颜色"):AddColorPicker("ItemESPColor", {
        Default = Color3.fromRGB(0, 255, 0),
    })

    EntityESPGroup:AddToggle("EntityESP", {
        Text = "实体ESP",
        Default = false,
    })
    EntityESPGroup:AddLabel("实体颜色"):AddColorPicker("EntityESPColor", {
        Default = Color3.fromRGB(255, 0, 0),
    })

    EntityESPGroup:AddToggle("WardrobeESP", { Text = "柜子ESP", Default = false })
    EntityESPGroup:AddToggle("GoldESP", { Text = "金币ESP", Default = false })
    EntityESPGroup:AddToggle("ChestESP", { Text = "箱子ESP", Default = false })
    EntityESPGroup:AddToggle("GuidingLightESP", { Text = "指引之光ESP", Default = false })

    PlayerESPGroup:AddToggle("PlayerESP", {
        Text = "玩家ESP",
        Default = false,
    })
    PlayerESPGroup:AddLabel("玩家颜色"):AddColorPicker("PlayerESPColor", {
        Default = Color3.fromRGB(0, 170, 255),
    })

    ESPSettingsGroup:AddToggle("ShowHighlight", {
        Text = "显示高亮",
        Default = true,
        Callback = function(v) ESP.GlobalSettings.ShowHighlight = v end,
    })
    ESPSettingsGroup:AddToggle("ShowTextLabel", {
        Text = "显示文字",
        Default = true,
        Callback = function(v) ESP.GlobalSettings.ShowTextLabel = v end,
    })
    ESPSettingsGroup:AddToggle("ShowDistance", {
        Text = "显示距离",
        Default = true,
        Callback = function(v) ESP.GlobalSettings.ShowDistance = v end,
    })
    ESPSettingsGroup:AddSlider("MaxDistance", {
        Text = "最大距离",
        Default = 350,
        Min = 0,
        Max = 500,
        Rounding = 0,
        Callback = function(v) ESP.GlobalSettings.MaxDistance = v end,
    })
    ESPSettingsGroup:AddToggle("ShowTracer", {
        Text = "显示追踪线",
        Default = false,
        Callback = function(v) ESP.GlobalSettings.ShowTracer = v end,
    })
    ESPSettingsGroup:AddDropdown("TracerPosition", {
        Text = "追踪线位置",
        Values = { "上", "中", "下" },
        Default = 1,
        Callback = function(v)
            ESP.GlobalSettings.TracerPosition = v == "上" and "Top" or (v == "中" and "Center" or "Bottom")
        end,
    })

    if IsRooms then
        local RoomsTab = Window:AddTab("Rooms")
        local RoomsGroup = RoomsTab:AddLeftGroupbox("自动Rooms")
        RoomsGroup:AddToggle("AutoRooms", { Text = "自动Rooms", Default = false })
        RoomsGroup:AddToggle("AutoRoomsDebug", { Text = "调试模式", Default = false })
        RoomsGroup:AddToggle("ShowPathNodes", { Text = "显示路径节点", Default = false })
        RoomsGroup:AddToggle("AntiA90", { Text = "自动开启反A90", Default = true })
    end

    local MiscGroup = ESPTab:AddLeftGroupbox("杂项")
    MiscGroup:AddToggle("Fullbright", {
        Text = "全亮",
        Default = false,
        Callback = function(enabled)
            if enabled then
                Lighting.Ambient = Color3.new(1, 1, 1)
            elseif workspace.CurrentRooms:FindFirstChild(tostring(CurrentRoom)) then
                local room = workspace.CurrentRooms[tostring(CurrentRoom)]
                Lighting.Ambient = room:GetAttribute("Ambient") or Color3.new(0, 0, 0)
            else
                Lighting.Ambient = Color3.new(0, 0, 0)
            end
        end,
    })

    MiscGroup:AddToggle("NotifySound", { Text = "通知音效", Default = true })
    MiscGroup:AddSlider("SoundVolume", { Text = "音效音量", Default = 1, Min = 0, Max = 1, Rounding = 2 })
    MiscGroup:AddToggle("NotifyEntity", { Text = "实体通知", Default = true })
    MiscGroup:AddToggle("NotifyChat", { Text = "聊天通知", Default = false })
    MiscGroup:AddInput("NotifyChatText", { Text = "聊天通知后缀", Default = "" })
    MiscGroup:AddToggle("Godmode", { Text = "上帝模式", Default = false })
    MiscGroup:AddToggle("AutoHeartbeat", { Text = "自动心跳", Default = false })
    MiscGroup:AddToggle("DeleteChase", { Text = "删除追逐战", Default = false })
    MiscGroup:AddToggle("AntiEyes", { Text = "反Eyes", Default = false })
    MiscGroup:AddToggle("AntiHalt", { Text = "反Halt", Default = false })
    MiscGroup:AddToggle("AntiMonument", { Text = "反石碑", Default = false })

    local UISettingsTab = Window:AddTab("UI设置")
    local UIGroup = UISettingsTab:AddLeftGroupbox("界面")
    UIGroup:AddToggle("ShowKeybinds", {
        Text = "显示快捷键",
        Default = true,
        Callback = function(v) Library.KeybindFrame.Visible = v end,
    })
    UIGroup:AddToggle("ShowCustomCursor", {
        Text = "显示自定义光标",
        Default = true,
        Callback = function(v) Library.ShowCustomCursor = v end,
    })
    UIGroup:AddDropdown("NotifySide", {
        Text = "通知位置",
        Values = { "左侧", "右侧" },
        Default = 2,
        Callback = function(v) Library:SetNotifySide(v) end,
    })
    UIGroup:AddInput("DPIScale", {
        Text = "DPI缩放(%)",
        Default = "100",
        Callback = function(v)
            Library:SetDPIScale(tonumber(v:gsub("%%", "")))
        end,
    })
    UIGroup:AddButton({
        Text = "卸载脚本",
        Func = function()
            Library:Unload()
        end,
    })

    Library:OnUnload(function()
        ESP:Destroy()
        if State.Temp.FlyBody then
            State.Temp.FlyBody:Destroy()
        end
        for _, connections in pairs(State.Connections) do
            if typeof(connections) == "table" then
                for _, conn in pairs(connections) do
                    conn:Disconnect()
                end
            else
                connections:Disconnect()
            end
        end
    end)

end

ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
ThemeManager:SetFolder("Sybsy-Hub")
SaveManager:SetFolder("Sybsy/Doors")
SaveManager:SetSubFolder(FloorValue.Value)
ThemeManager:ApplyToTab(UISettingsTab)
SaveManager:BuildConfigSection(UISettingsTab)
SaveManager:LoadAutoloadConfig()
