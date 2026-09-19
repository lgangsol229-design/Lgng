-- ═══════════════════════════════════════════════════════
-- 🔥 LGNG HUB — VENTANA KEYS ESTILO IMAGEN + BLOQUEO PERMANENTE 🔥
-- ═══════════════════════════════════════════════════════

repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Camera = workspace.CurrentCamera
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- ==================================================
-- 🔑 SISTEMA DE KEYS — BLOQUEO PERMANENTE AL VENCER
-- ==================================================
local KEYS_AUTORIZADAS = {
    -- ⏱️ 2 HORAS
    ["LGNG-2H-001"] = {Tiempo = 7200, Expirada = false},
    ["LGNG-2H-002"] = {Tiempo = 7200, Expirada = false},
    ["LGNG-2H-003"] = {Tiempo = 7200, Expirada = false},
    ["LGNG-2H-004"] = {Tiempo = 7200, Expirada = false},
    ["LGNG-2H-005"] = {Tiempo = 7200, Expirada = false},
    -- ⏱️ 3 HORAS
    ["LGNG-3H-001"] = {Tiempo = 10800, Expirada = false},
    ["LGNG-3H-002"] = {Tiempo = 10800, Expirada = false},
    ["LGNG-3H-003"] = {Tiempo = 10800, Expirada = false},
    -- ⏱️ 4 HORAS
    ["LGNG-4H-001"] = {Tiempo = 14400, Expirada = false},
    ["LGNG-4H-002"] = {Tiempo = 14400, Expirada = false},
    -- ⏱️ 10 HORAS
    ["LGNG-10H-001"] = {Tiempo = 36000, Expirada = false},
    ["LGNG-10H-002"] = {Tiempo = 36000, Expirada = false},
}

local KEY_ACEPTADA = false
local TIEMPO_RESTANTE = 0
local KEY_USADA = ""

local function VerificarKey(keyIngresada)
    local keyLimpia = string.upper(string.gsub(keyIngresada, "%s+", ""))
    local datos = KEYS_AUTORIZADAS[keyLimpia]
    if not datos then return false, "INVALIDA" end
    if datos.Expirada then return false, "EXPIRADA_PERMANENTE" end
    return true, datos.Tiempo, keyLimpia
end

-- ==================================================
-- 🎨 VENTANA DE KEYS — ESTILO EXACTO DE LA IMAGEN
-- ==================================================
local GuiKey = Instance.new("ScreenGui")
GuiKey.Name = "LGNG_KEY_VERIFY"
GuiKey.Parent = CoreGui

-- FONDO PRINCIPAL — IGUAL A LA IMAGEN
local KeyBox = Instance.new("Frame")
KeyBox.Size = UDim2.new(0, 420, 0, 280)
KeyBox.Position = UDim2.new(0.5, -210, 0.5, -140)
KeyBox.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
KeyBox.BorderSizePixel = 0
KeyBox.Active = true
KeyBox.Draggable = true
KeyBox.Parent = GuiKey
Instance.new("UICorner", KeyBox).CornerRadius = UDim.new(0, 12)

-- 🔴 TÍTULO PRINCIPAL — EN ROJO ARRIBA
local KeyTitle = Instance.new("TextLabel", KeyBox)
KeyTitle.Size = UDim2.new(1, 0, 0, 70)
KeyTitle.Position = UDim2.new(0, 0, 0, 0)
KeyTitle.BackgroundTransparency = 1
KeyTitle.Text = "LGNG HUB"
KeyTitle.TextColor3 = Color3.fromRGB(255, 0, 0)
KeyTitle.Font = Enum.Font.GothamBlack
KeyTitle.TextScaled = true
KeyTitle.TextStrokeTransparency = 0.2
KeyTitle.TextStrokeColor3 = Color3.fromRGB(100, 0, 0)

-- SUBTÍTULO — Premium Key System
local SubTitle = Instance.new("TextLabel", KeyBox)
SubTitle.Size = UDim2.new(1, 0, 0, 30)
SubTitle.Position = UDim2.new(0, 0, 0.28, 0)
SubTitle.BackgroundTransparency = 1
SubTitle.Text = "Premium Key System"
SubTitle.TextColor3 = Color3.fromRGB(180, 180, 180)
SubTitle.Font = Enum.Font.Gotham
SubTitle.TextScaled = true

-- 📥 CUADRO DE ENTRADA DE LA KEY
local InputKey = Instance.new("TextBox", KeyBox)
InputKey.Size = UDim2.new(1, -60, 0, 50)
InputKey.Position = UDim2.new(0, 30, 0.48, 0)
InputKey.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
InputKey.Text = ""
InputKey.PlaceholderText = "INGRESA TU KEY AQUÍ"
InputKey.TextColor3 = Color3.fromRGB(255, 255, 255)
InputKey.PlaceholderColor3 = Color3.fromRGB(120, 120, 120)
InputKey.Font = Enum.Font.Gotham
InputKey.TextScaled = true
InputKey.ClearTextOnFocus = false
Instance.new("UICorner", InputKey).CornerRadius = UDim.new(0, 8)

-- 🔴 BOTÓN GRANDE ROJO — ACTIVAR SISTEMA
local BtnVerify = Instance.new("TextButton", KeyBox)
BtnVerify.Size = UDim2.new(1, -60, 0, 55)
BtnVerify.Position = UDim2.new(0, 30, 0.8, -55)
BtnVerify.BackgroundColor3 = Color3.fromRGB(220, 30, 30)
BtnVerify.Text = "ACTIVAR SISTEMA"
BtnVerify.TextColor3 = Color3.fromRGB(255, 255, 255)
BtnVerify.Font = Enum.Font.GothamBold
BtnVerify.TextScaled = true
BtnVerify.AutoLocalize = false
Instance.new("UICorner", BtnVerify).CornerRadius = UDim.new(0, 10)

-- ✅ EFECTO AL PASAR EL MOUSE EN EL BOTÓN
BtnVerify.MouseEnter:Connect(function()
    TweenService:Create(BtnVerify, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(255, 50, 50)}):Play()
end)
BtnVerify.MouseLeave:Connect(function()
    TweenService:Create(BtnVerify, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(220, 30, 30)}):Play()
end)

-- ⚠️ TEXTO DE ESTADO
local EstadoTxt = Instance.new("TextLabel", KeyBox)
EstadoTxt.Size = UDim2.new(1, 0, 0, 25)
EstadoTxt.Position = UDim2.new(0, 0, 0.72, 0)
EstadoTxt.BackgroundTransparency = 1
EstadoTxt.Text = ""
EstadoTxt.TextColor3 = Color3.fromRGB(255, 200, 0)
EstadoTxt.Font = Enum.Font.Gotham
EstadoTxt.TextScaled = true

-- 🔘 FUNCIÓN DEL BOTÓN ACTIVAR
BtnVerify.MouseButton1Click:Connect(function()
    local valida, tiempoOestado, keyUsada = VerificarKey(InputKey.Text)
    
    if tiempoOestado == "EXPIRADA_PERMANENTE" then
        EstadoTxt.Text = "🔒 ESTA KEY YA FUE UTILIZADA Y EXPIRÓ"
        EstadoTxt.TextColor3 = Color3.fromRGB(255, 50, 50)
        InputKey.Active = false
        task.wait(4)
        EstadoTxt.Text = ""
        InputKey.Active = true
        return
    end
    
    if valida then
        KEY_ACEPTADA = true
        TIEMPO_RESTANTE = tiempoOestado
        KEY_USADA = keyUsada
        EstadoTxt.Text = "✅ KEY VÁLIDA — CARGANDO..."
        EstadoTxt.TextColor3 = Color3.fromRGB(0, 255, 100)
        BtnVerify.BackgroundColor3 = Color3.fromRGB(0, 160, 60)
        BtnVerify.Text = "✓ ACTIVADO"
        InputKey.Active = false
        BtnVerify.Active = false
        task.wait(1.5)
        GuiKey:Destroy()
    else
        EstadoTxt.Text = "❌ KEY INVÁLIDA — VERIFICA TU KEY"
        EstadoTxt.TextColor3 = Color3.fromRGB(255, 80, 80)
        BtnVerify.BackgroundColor3 = Color3.fromRGB(150, 20, 20)
        task.wait(2.5)
        EstadoTxt.Text = ""
        BtnVerify.BackgroundColor3 = Color3.fromRGB(220, 30, 30)
    end
end)

-- ⏳ CONTADOR DE TIEMPO — AL ACABAR BLOQUEA LA KEY PARA SIEMPRE
task.spawn(function()
    while task.wait(1) do
        if KEY_ACEPTADA then
            TIEMPO_RESTANTE = TIEMPO_RESTANTE - 1
            if TIEMPO_RESTANTE <= 0 then
                -- 🔒 MARCAR KEY COMO EXPIRADA PERMANENTE
                KEYS_AUTORIZADAS[KEY_USADA].Expirada = true
                KEY_ACEPTADA = false
                
                -- VENTANA DE BLOQUEO
                local GuiBloqueo = Instance.new("ScreenGui")
                GuiBloqueo.Name = "LGNG_BLOQUEADO"
                GuiBloqueo.Parent = CoreGui
                
                local BloqueoBox = Instance.new("Frame")
                BloqueoBox.Size = UDim2.new(0, 400, 0, 220)
                BloqueoBox.Position = UDim2.new(0.5, -200, 0.5, -110)
                BloqueoBox.BackgroundColor3 = Color3.fromRGB(25, 10, 10)
                BloqueoBox.Active = true
                BloqueoBox.Draggable = true
                BloqueoBox.Parent = GuiBloqueo
                Instance.new("UICorner", BloqueoBox).CornerRadius = UDim.new(0, 12)
                
                local BloqueoTexto = Instance.new("TextLabel", BloqueoBox)
                BloqueoTexto.Size = UDim2.new(1, 0, 1, 0)
                BloqueoTexto.BackgroundTransparency = 1
                BloqueoTexto.Text = "🔒 ACCESO EXPIRADO\n\nESTA KEY YA NO SE PUEDE USAR\nYA ESTÁ BLOQUEADA PERMANENTEMENTE\n\nCONTACTA PARA OTRA KEY"
                BloqueoTexto.TextColor3 = Color3.fromRGB(255, 60, 60)
                BloqueoTexto.Font = Enum.Font.GothamBold
                BloqueoTexto.TextScaled = true
                BloqueoTexto.TextWrapped = true
                
                task.wait(0.5)
                if CoreGui:FindFirstChild("LGNG_HUB") then CoreGui.LGNG_HUB:Destroy() end
                return
            end
        end
    end
end)

-- ESPERAR VERIFICACIÓN DE KEY
repeat task.wait(0.5) until KEY_ACEPTADA or not GuiKey:IsDescendantOf(game)
if not KEY_ACEPTADA then return end

-- ==================================================
-- 🔥 HUB PRINCIPAL — TODO COMPLETO
-- ==================================================
local AimOn = false
local EspOn = false
local AIM_SMOOTH = 8
local AIM_RANGE = 350
local AIM_OFFSET = Vector3.new(0, -0.5, 0)
local SkeletonColor = Color3.fromRGB(255, 0, 0)
local WhiteESP = Color3.fromRGB(255, 255, 255)
local TimeColor = Color3.fromRGB(0, 255, 0)
local BAR_WIDTH, BAR_HEIGHT = 50, 6

-- 🔋 ESTAMINA INFINITA
task.spawn(function()
    while task.wait(0.1) do
        if LocalPlayer.Character then
            LocalPlayer.Character:SetAttribute("Stamina", 100)
            LocalPlayer.Character:SetAttribute("StaminaDrain", 0)
            local Stamina = LocalPlayer.Character:FindFirstChild("Stamina")
            if Stamina and Stamina:IsA("NumberValue") then Stamina.Value = 100 end
        end
    end
end)

-- 🎨 MENÚ PRINCIPAL
local Gui = Instance.new("ScreenGui")
Gui.Name = "LGNG_HUB"
Gui.Parent = CoreGui

local MainBox = Instance.new("Frame")
MainBox.Size = UDim2.new(0, 280, 0, 115)
MainBox.Position = UDim2.new(0.5, -140, 0.02, 0)
MainBox.BackgroundColor3 = Color3.fromRGB(10, 10, 18)
MainBox.Active = true
MainBox.Draggable = true
MainBox.ClipsDescendants = true
MainBox.Parent = Gui
Instance.new("UICorner", MainBox).CornerRadius = UDim.new(0, 16)

local UIStroke = Instance.new("UIStroke")
UIStroke.Thickness = 3
UIStroke.Color = Color3.fromRGB(255, 0, 0)
UIStroke.Parent = MainBox

task.spawn(function()
    local colores = {Color3.fromRGB(255,0,0), Color3.fromRGB(255,150,0), Color3.fromRGB(255,0,0)}
    while Gui.Parent do
        for _, c in ipairs(colores) do
            TweenService:Create(UIStroke, TweenInfo.new(0.6), {Color = c}):Play()
            task.wait(0.6)
        end
    end
end)

local Title = Instance.new("TextLabel", MainBox)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundColor3 = Color3.fromRGB(45, 0, 0)
Title.Text = "🔥 LGNG HUB 🔥"
Title.TextColor3 = Color3.fromRGB(255, 215, 0)
Title.Font = Enum.Font.GothamBold
Title.TextScaled = true
Instance.new("UICorner", Title).CornerRadius = UDim.new(0, 16)

local AimBtn = Instance.new("TextButton", MainBox)
AimBtn.Size = UDim2.new(0, 120, 0, 55)
AimBtn.Position = UDim2.new(0, 10, 0, 50)
AimBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
AimBtn.Text = "❌ AIMBOT"
AimBtn.TextColor3 = Color3.fromRGB(255, 120, 120)
AimBtn.Font = Enum.Font.GothamBold
AimBtn.TextScaled = true
AimBtn.Parent = MainBox
Instance.new("UICorner", AimBtn).CornerRadius = UDim.new(0, 12)

local EspBtn = Instance.new("TextButton", MainBox)
EspBtn.Size = UDim2.new(0, 120, 0, 55)
EspBtn.Position = UDim2.new(0, 150, 0, 50)
EspBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
EspBtn.Text = "❌ ESP"
EspBtn.TextColor3 = Color3.fromRGB(220, 220, 220)
EspBtn.Font = Enum.Font.GothamBold
EspBtn.TextScaled = true
EspBtn.Parent = MainBox
Instance.new("UICorner", EspBtn).CornerRadius = UDim.new(0, 12)

local function SwitchAim() 
    AimOn = not AimOn
    AimBtn.Text = AimOn and "✅ AIMBOT" or "❌ AIMBOT"
    AimBtn.TextColor3 = AimOn and Color3.fromRGB(80, 255, 120) or Color3.fromRGB(255, 120, 120)
    AimBtn.BackgroundColor3 = AimOn and Color3.fromRGB(0, 80, 30) or Color3.fromRGB(30, 30, 45)
end
local function SwitchEsp() 
    EspOn = not EspOn
    EspBtn.Text = EspOn and "✅ ESP" or "❌ ESP"
    EspBtn.TextColor3 = EspOn and Color3.fromRGB(255, 80, 80) or Color3.fromRGB(220, 220, 220)
    EspBtn.BackgroundColor3 = EspOn and Color3.fromRGB(80, 20, 30) or Color3.fromRGB(30, 30, 45)
end
AimBtn.MouseButton1Click:Connect(SwitchAim)
EspBtn.MouseButton1Click:Connect(SwitchEsp)
UIS.InputBegan:Connect(function(i, g) 
    if g then return end
    if i.KeyCode == Enum.KeyCode.Z then SwitchAim() end
    if i.KeyCode == Enum.KeyCode.X then SwitchEsp() end
end)

-- ==================================================
-- 🔫 SISTEMA DE ARMAS + ESP COMPLETO
-- ==================================================
local Settings = { WeaponESP = true }
local Items = ReplicatedStorage:WaitForChild("Items")
local WeaponRegistry = {}

local function registerItems(folder)
    for _, tool in ipairs(folder:GetChildren()) do
        if tool:IsA("Tool") then
            local handle = tool:FindFirstChild("Handle")
            local displayName = tool:GetAttribute("DisplayName") or tool.Name
            local itemId = tool:GetAttribute("ItemId") or tool:GetAttribute("Id") or tool.Name
            local key
            if handle then
                local mesh = handle:FindFirstChildOfClass("SpecialMesh")
                if mesh and mesh.MeshId ~= "" then
                    key = mesh.MeshId .. (mesh.TextureId or "")
                elseif handle:IsA("MeshPart") and handle.MeshId ~= "" then
                    key = handle.MeshId .. (handle.TextureID or "")
                end
            end
            if not key and itemId and itemId ~= "" and itemId ~= tool.Name then key = "ITEMID_" .. itemId end
            if not key then key = "NAME_" .. displayName .. "_" .. tool.Name end
            WeaponRegistry[key] = { Name = displayName, ToolName = tool.Name }
        end
    end
end

local function scanFolders(folder)
    registerItems(folder)
    folder.ChildAdded:Connect(function(child) task.wait(0.1) if child:IsA("Folder") then scanFolders(child) else registerItems(folder) end end)
    for _, child in ipairs(folder:GetChildren()) do if child:IsA("Folder") then scanFolders(child) end end
end
scanFolders(Items)

local function getItemKey(tool)
    local handle = tool:FindFirstChild("Handle")
    local displayName = tool:GetAttribute("DisplayName") or tool.Name
    local itemId = tool:GetAttribute("ItemId") or tool:GetAttribute("Id") or tool.Name
    if handle then
        local mesh = handle:FindFirstChildOfClass("SpecialMesh")
        if mesh and mesh.MeshId ~= "" then return mesh.MeshId .. (mesh.TextureId or "") end
        if handle:IsA("MeshPart") and handle.MeshId ~= "" then return handle.MeshId .. (handle.TextureID or "") end
    end
    if itemId and itemId ~= "" and itemId ~= tool.Name then return "ITEMID_" .. itemId end
    return "NAME_" .. displayName .. "_" .. tool.Name
end

local function getWeapons(player)
    local items = {}
    local function scan(container)
        if not container then return end
        for _, tool in ipairs(container:GetChildren()) do
            if tool:IsA("Tool") and tool.Name ~= "Fists" then
                local info = WeaponRegistry[getItemKey(tool)]
                if info then table.insert(items, { Name = info.Name }) end
            end
        end
    end
    scan(player:FindFirstChild("Backpack"))
    scan(player.Character)
    return items
end

-- 🦴 ESP: ESQUELETO + NOMBRE + BARRA DE VIDA + ARMAS
local ESPObjects = {}
local Skeleton = {}
local HealthBg = {}
local HealthBar = {}
local NameText = {}
local TimeText = {}
local Joints = {
    {"Head","UpperTorso"},{"UpperTorso","LowerTorso"},
    {"LowerTorso","LeftUpperLeg"},{"LeftUpperLeg","LeftLowerLeg"},
    {"LowerTorso","RightUpperLeg"},{"RightUpperLeg","RightLowerLeg"},
    {"UpperTorso","LeftUpperArm"},{"LeftUpperArm","LeftLowerArm"},
    {"UpperTorso","RightUpperArm"},{"RightUpperArm","RightLowerArm"}
}

local function NewLine() local l = Drawing.new("Line"); l.Thickness = 2.5; l.Color = SkeletonColor; l.Visible = false; return l end
local function NewSquare(fill, col) local s = Drawing.new("Square"); s.Thickness = 1; s.Filled = fill; s.Color = col; s.Visible = false; return s end
local function NewNameText() local t = Drawing.new("Text"); t.Size = 16; t.Center = true; t.Outline = true; t.Font = 2; t.Color = WhiteESP; t.Visible = false; return t end
local function NewTimeText() local t = Drawing.new("Text"); t.Size = 14; t.Center = true; t.Outline = true; t.Font = 2; t.Color = TimeColor; t.Visible = false; return t end

local function RemoveESP(player)
    if ESPObjects[player] then for _, wd in pairs(ESPObjects[player].Weapons) do wd.Visible = false; wd:Destroy() end; ESPObjects[player] = nil end
    if Skeleton[player] then for _, l in pairs(Skeleton[player]) do l.Visible = false; l:Destroy() end; Skeleton[player] = nil end
    if HealthBg[player] then HealthBg[player]:Destroy(); HealthBg[player] = nil end
    if HealthBar[player] then HealthBar[player]:Destroy(); HealthBar[player] = nil end
    if NameText[player] then NameText[player]:Destroy(); NameText[player] = nil end
    if TimeText[player] then TimeText[player]:Destroy(); TimeText[player] = nil end
end

local function VincularJugador(p)
    if p == LocalPlayer then return end
    ESPObjects[p] = { Weapons = {} }
    NameText[p] = NewNameText()
    TimeText[p] = NewTimeText()
    p.CharacterAdded:Connect(function() task.wait(0.1); ESPObjects[p] = { Weapons = {} }; NameText[p] = NewNameText(); TimeText[p] = NewTimeText() end)
    p.CharacterRemoving:Connect(function()
        if ESPObjects[p] then for _, wd in pairs(ESPObjects[p].Weapons) do wd.Visible = false end end
        if Skeleton[p] then for _, l in pairs(Skeleton[p]) do l.Visible = false end end
        if NameText[p] then NameText[p].Visible = false end
        if TimeText[p] then TimeText[p].Visible = false end
        if HealthBg[p] then HealthBg[p].Visible = false; HealthBar[p].Visible = false end
    end)
end

for _, p in pairs(Players:GetPlayers()) do VincularJugador(p) end
Players.PlayerAdded:Connect(VincularJugador)
Players.PlayerRemoving:Connect(RemoveESP)

-- 🔁 LOOP PRINCIPAL
RunService.RenderStepped:Connect(function()
    if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then return end
    local CenterX = Camera.ViewportSize.X / 2
    local CenterY = Camera.ViewportSize.Y / 2
    local Target = nil
    local MinDist = AIM_RANGE

    -- 🎯 AIMBOT
    if AimOn then
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Head") and p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.Health > 0 then
                local headPos = p.Character.Head.Position + AIM_OFFSET
                local pos, vis = Camera:WorldToViewportPoint(headPos)
                if vis then
                    local dist = (Vector2.new(pos.X, pos.Y) - Vector2.new(CenterX, CenterY)).Magnitude
                    if dist < MinDist then MinDist = dist; Target = headPos end
                end
            end
        end
        if Target then Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, Target), 1 / AIM_SMOOTH) end
    end

    -- ❌ OCULTAR TODO SI ESP ESTÁ APAGADO
    if not EspOn then
        for _, p in pairs(ESPObjects) do if ESPObjects[p] then for _, wd in pairs(ESPObjects[p].Weapons) do wd.Visible = false end end end
        for _, p in pairs(Skeleton) do if Skeleton[p] then for _, l in pairs(Skeleton[p]) do l.Visible = false end end end
        for _, p in pairs(NameText) do if NameText[p] then NameText[p].Visible = false end end
        for _, p in pairs(TimeText) do if TimeText[p] then TimeText[p].Visible = false end end
        for _, p in pairs(HealthBg) do if HealthBg[p] then HealthBg[p].Visible = false; HealthBar[p].Visible = false end end
        return
    end

    -- ✅ DIBUJAR TODO SI ESP ESTÁ ACTIVO
    for _, p in ipairs(Players:GetPlayers()) do
        if p == LocalPlayer then continue end
        local objs = ESPObjects[p]
        local c = p.Character
        if not c or not c:FindFirstChild("Humanoid") or c.Humanoid.Health <= 0 or not c:FindFirstChild("HumanoidRootPart") or not c:FindFirstChild("Head") then
            if objs then for _, wd in pairs(objs.Weapons) do wd.Visible = false end end
            if Skeleton[p] then for _, l in pairs(Skeleton[p]) do l.Visible = false end end
            if NameText[p] then NameText[p].Visible = false end
            if TimeText[p] then TimeText[p].Visible = false end
            if HealthBg[p] then HealthBg[p].Visible = false; HealthBar[p].Visible = false end
            continue
        end

        local root = c.HumanoidRootPart
        local head = c.Head
        local screenPos, onScreen = Camera:WorldToViewportPoint(root.Position)
        local hpos, hv = Camera:WorldToViewportPoint(head.Position)
        local hp = c.Humanoid.Health / c.Humanoid.MaxHealth

        if onScreen and hv then
            -- ⏰ HORA
            local hora = os.date("%H:%M:%S")
            TimeText[p].Text = "⏰ " .. hora
            TimeText[p].Position = Vector2.new(hpos.X, hpos.Y - 70)
            TimeText[p].Visible = true

            -- 👤 NOMBRE
            NameText[p].Text = "👤 " .. p.Name
            NameText[p].Position = Vector2.new(hpos.X, hpos.Y - 50)
            NameText[p].Visible = true

            -- 🟩 BARRA DE VIDA
            if not HealthBg[p] then HealthBg[p] = NewSquare(true, Color3.fromRGB(40,40,40)) end
            if not HealthBar[p] then HealthBar[p] = NewSquare(true, Color3.fromRGB(0,255,0)) end
            local barX = hpos.X - BAR_WIDTH/2
            local barY = hpos.Y - 35
            HealthBg[p].Size = Vector2.new(BAR_WIDTH, BAR_HEIGHT)
            HealthBg[p].Position = Vector2.new(barX, barY)
            HealthBg[p].Visible = true
            HealthBar[p].Size = Vector2.new(BAR_WIDTH * hp, BAR_HEIGHT)
            HealthBar[p].Position = Vector2.new(barX, barY)
            HealthBar[p].Visible = true

            -- 🦴 ESQUELETO ROJO
            if not Skeleton[p] then Skeleton[p] = {}; for i = 1, #Joints do Skeleton[p][i] = NewLine() end end
            for i, pair in ipairs(Joints) do
                local a = c:FindFirstChild(pair[1])
                local b = c:FindFirstChild(pair[2])
                if a and b then
                    local pa, va = Camera:WorldToViewportPoint(a.Position)
                    local pb, vb = Camera:WorldToViewportPoint(b.Position)
                    if va and vb then
                        Skeleton[p][i].From = Vector2.new(pa.X, pa.Y)
                        Skeleton[p][i].To = Vector2.new(pb.X, pb.Y)
                        Skeleton[p][i].Visible = true
                    else Skeleton[p][i].Visible = false end
                end
            end

            -- 🔫 ESP DE ARMAS
            local h = (Camera.ViewportSize.Y / screenPos.Z) * 2.6
            local y = screenPos.Y - h/2
            for _, wd in pairs(objs.Weapons) do wd.Visible = false end
            local items = getWeapons(p)
            for i, w in ipairs(items) do
                if not objs.Weapons[i] then
                    local txt = Drawing.new("Text")
                    txt.Size = 11; txt.Center = true; txt.Outline = true; txt.Font = 2
                    objs.Weapons[i] = txt
                end
                local draw = objs.Weapons[i]
                draw.Text = w.Name; draw.Color = WhiteESP
                draw.Position = Vector2.new(screenPos.X, y + h + 4 + ((i - 1) * 10))
                draw.Visible = true
            end
        else
            if objs then for _, wd in pairs(objs.Weapons) do wd.Visible = false end end
            if Skeleton[p] then for _, l in pairs(Skeleton[p]) do l.Visible = false end end
            if NameText[p] then NameText[p].Visible = false end
            if TimeText[p] then TimeText[p].Visible = false end
            if HealthBg[p] then HealthBg[p].Visible = false; HealthBar[p].Visible = false end
        end
    end
end)

print("✅ LGNG HUB CARGADO | VENTANA KEYS ESTILO PREMIUM + BLOQUEO PERMANENTE + TODO ✅")
