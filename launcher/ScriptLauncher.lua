-- ============================================================
--  Yuki's TRD Hub — Loader
--  Starlight-style UI
-- ============================================================

local Players    = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

-- ── Colours (mirrors Starlight's Orca theme) ─────────────────
local C_BG       = Color3.fromRGB(15,  15,  15)   -- window background
local C_HEADER   = Color3.fromRGB(20,  20,  20)   -- header bar
local C_DIVIDER  = Color3.fromRGB(35,  35,  35)   -- separator line
local C_BTN      = Color3.fromRGB(28,  28,  28)   -- button base
local C_BTN_HOV  = Color3.fromRGB(38,  38,  38)   -- button hover
local C_ACCENT   = Color3.fromRGB(198, 107, 240)  -- purple accent
local C_ACCENT2  = Color3.fromRGB(240, 107, 180)  -- pink accent (Universal)
local C_TEXT     = Color3.fromRGB(255, 255, 255)
local C_SUBTEXT  = Color3.fromRGB(140, 140, 140)
local C_CLOSE    = Color3.fromRGB(80,  80,  80)

-- ── Helpers ───────────────────────────────────────────────────
local function corner(r, p)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, r)
    c.Parent = p
    return c
end
local function stroke(t, c, p)
    local s = Instance.new("UIStroke")
    s.Thickness = t
    s.Color = c
    s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    s.Parent = p
    return s
end
local function padding(top, right, bottom, left, p)
    local pad = Instance.new("UIPadding")
    pad.PaddingTop    = UDim.new(0, top)
    pad.PaddingRight  = UDim.new(0, right)
    pad.PaddingBottom = UDim.new(0, bottom)
    pad.PaddingLeft   = UDim.new(0, left)
    pad.Parent = p
    return pad
end
local function label(text, size, font, color, parent)
    local l = Instance.new("TextLabel")
    l.Text              = text
    l.TextSize          = size
    l.Font              = font or Enum.Font.GothamBold
    l.TextColor3        = color or C_TEXT
    l.BackgroundTransparency = 1
    l.Size              = UDim2.new(1, 0, 1, 0)
    l.TextXAlignment    = Enum.TextXAlignment.Left
    l.Parent            = parent
    return l
end
local function tween(obj, props, t)
    TweenService:Create(obj, TweenInfo.new(t or 0.15, Enum.EasingStyle.Quad), props):Play()
end

-- ── Cleanup any existing loader ───────────────────────────────
local existing = LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("YukiLoader")
if existing then existing:Destroy() end

-- ── Root ScreenGui ────────────────────────────────────────────
local gui = Instance.new("ScreenGui")
gui.Name              = "YukiLoader"
gui.ResetOnSpawn      = false
gui.ZIndexBehavior    = Enum.ZIndexBehavior.Sibling
gui.Parent            = LocalPlayer:WaitForChild("PlayerGui")

-- ── Window (260 × 96) ─────────────────────────────────────────
local win = Instance.new("Frame")
win.Name              = "Window"
win.Size              = UDim2.new(0, 260, 0, 96)
win.Position          = UDim2.new(0.5, -130, 0.5, -48)
win.BackgroundColor3  = C_BG
win.BorderSizePixel   = 0
win.Parent            = gui
corner(8, win)
stroke(1, C_DIVIDER, win)

-- Drop shadow (decorative frame behind window)
local shadow = Instance.new("Frame")
shadow.Size              = UDim2.new(1, 16, 1, 16)
shadow.Position          = UDim2.new(0, -8, 0, -8)
shadow.BackgroundColor3  = Color3.fromRGB(0, 0, 0)
shadow.BackgroundTransparency = 0.6
shadow.BorderSizePixel   = 0
shadow.ZIndex            = win.ZIndex - 1
shadow.Parent            = win
corner(12, shadow)

-- ── Header bar ────────────────────────────────────────────────
local header = Instance.new("Frame")
header.Name             = "Header"
header.Size             = UDim2.new(1, 0, 0, 38)
header.BackgroundColor3 = C_HEADER
header.BorderSizePixel  = 0
header.Parent           = win
corner(8, header)

-- Square off bottom corners of header
local headerSquare = Instance.new("Frame")
headerSquare.Size              = UDim2.new(1, 0, 0.5, 0)
headerSquare.Position          = UDim2.new(0, 0, 0.5, 0)
headerSquare.BackgroundColor3  = C_HEADER
headerSquare.BorderSizePixel   = 0
headerSquare.Parent            = header

-- Accent dot
local dot = Instance.new("Frame")
dot.Size             = UDim2.new(0, 7, 0, 7)
dot.Position         = UDim2.new(0, 14, 0.5, -3)
dot.BackgroundColor3 = C_ACCENT
dot.BorderSizePixel  = 0
dot.Parent           = header
corner(4, dot)

-- Title text
local titleLbl = Instance.new("TextLabel")
titleLbl.Size               = UDim2.new(1, -70, 1, 0)
titleLbl.Position           = UDim2.new(0, 28, 0, 0)
titleLbl.BackgroundTransparency = 1
titleLbl.Text               = "Yuki's Loader"
titleLbl.TextSize           = 13
titleLbl.Font               = Enum.Font.GothamBold
titleLbl.TextColor3         = C_TEXT
titleLbl.TextXAlignment     = Enum.TextXAlignment.Left
titleLbl.Parent             = header

-- Subtitle text
local subLbl = Instance.new("TextLabel")
subLbl.Size               = UDim2.new(1, -70, 1, 0)
subLbl.Position           = UDim2.new(0, 28, 0, 0)
subLbl.BackgroundTransparency = 1
subLbl.Text               = ""
subLbl.TextSize           = 11
subLbl.Font               = Enum.Font.Gotham
subLbl.TextColor3         = C_SUBTEXT
subLbl.TextXAlignment     = Enum.TextXAlignment.Left
subLbl.TextYAlignment     = Enum.TextYAlignment.Bottom
subLbl.Parent             = header
padding(0, 0, 6, 0, subLbl)

-- Close button
local closeBtn = Instance.new("TextButton")
closeBtn.Size               = UDim2.new(0, 24, 0, 24)
closeBtn.Position           = UDim2.new(1, -32, 0.5, -12)
closeBtn.BackgroundColor3   = C_CLOSE
closeBtn.Text               = "X"
closeBtn.TextSize           = 10
closeBtn.Font               = Enum.Font.GothamBold
closeBtn.TextColor3         = C_SUBTEXT
closeBtn.BorderSizePixel    = 0
closeBtn.Parent             = header
corner(5, closeBtn)

closeBtn.MouseEnter:Connect(function()
    tween(closeBtn, { BackgroundColor3 = Color3.fromRGB(200, 60, 60), TextColor3 = C_TEXT })
end)
closeBtn.MouseLeave:Connect(function()
    tween(closeBtn, { BackgroundColor3 = C_CLOSE, TextColor3 = C_SUBTEXT })
end)
closeBtn.MouseButton1Click:Connect(function()
    tween(win, { BackgroundTransparency = 1 }, 0.2)
    task.wait(0.2)
    gui:Destroy()
end)

-- Make window draggable
do
    local dragging, dragStart, startPos
    header.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos  = win.Position
        end
    end)
    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            win.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y
            )
        end
    end)
    game:GetService("UserInputService").InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
end

-- ── Divider ───────────────────────────────────────────────────
local div = Instance.new("Frame")
div.Size             = UDim2.new(1, -24, 0, 1)
div.Position         = UDim2.new(0, 12, 0, 38)
div.BackgroundColor3 = C_DIVIDER
div.BorderSizePixel  = 0
div.Parent           = win

-- ── Button factory ────────────────────────────────────────────
local function makeButton(text, subtext, yOffset, accent, callback)
    local btn = Instance.new("TextButton")
    btn.Size              = UDim2.new(1, -24, 0, 38)
    btn.Position          = UDim2.new(0, 12, 0, yOffset)
    btn.BackgroundColor3  = C_BTN
    btn.BorderSizePixel   = 0
    btn.Text              = ""
    btn.AutoButtonColor   = false
    btn.Parent            = win
    corner(6, btn)

    -- Left accent bar
    local bar = Instance.new("Frame")
    bar.Size             = UDim2.new(0, 3, 0.6, 0)
    bar.Position         = UDim2.new(0, 0, 0.2, 0)
    bar.BackgroundColor3 = accent
    bar.BorderSizePixel  = 0
    bar.Parent           = btn
    corner(3, bar)

    -- Label
    local lbl = Instance.new("TextLabel")
    lbl.Size              = UDim2.new(1, -18, 0, 18)
    lbl.Position          = UDim2.new(0, 14, 0, 6)
    lbl.BackgroundTransparency = 1
    lbl.Text              = text
    lbl.TextSize          = 12
    lbl.Font              = Enum.Font.GothamBold
    lbl.TextColor3        = C_TEXT
    lbl.TextXAlignment    = Enum.TextXAlignment.Left
    lbl.Parent            = btn

    -- Subtext
    local sub = Instance.new("TextLabel")
    sub.Size              = UDim2.new(1, -18, 0, 14)
    sub.Position          = UDim2.new(0, 14, 0, 22)
    sub.BackgroundTransparency = 1
    sub.Text              = subtext
    sub.TextSize          = 10
    sub.Font              = Enum.Font.Gotham
    sub.TextColor3        = C_SUBTEXT
    sub.TextXAlignment    = Enum.TextXAlignment.Left
    sub.Parent            = btn

    -- Arrow icon
    local arrow = Instance.new("TextLabel")
    arrow.Size              = UDim2.new(0, 20, 1, 0)
    arrow.Position          = UDim2.new(1, -24, 0, 0)
    arrow.BackgroundTransparency = 1
    arrow.Text              = "›"
    arrow.TextSize          = 20
    arrow.Font              = Enum.Font.GothamBold
    arrow.TextColor3        = C_SUBTEXT
    arrow.Parent            = btn

    btn.MouseEnter:Connect(function()
        tween(btn,   { BackgroundColor3 = C_BTN_HOV })
        tween(arrow, { TextColor3 = accent })
        tween(lbl,   { TextColor3 = accent })
    end)
    btn.MouseLeave:Connect(function()
        tween(btn,   { BackgroundColor3 = C_BTN })
        tween(arrow, { TextColor3 = C_SUBTEXT })
        tween(lbl,   { TextColor3 = C_TEXT })
    end)
    btn.MouseButton1Click:Connect(function()
        tween(btn, { BackgroundColor3 = Color3.fromRGB(accent.R*0.6*255, accent.G*0.6*255, accent.B*0.6*255) }, 0.05)
        task.wait(0.08)
        tween(btn, { BackgroundColor3 = C_BTN_HOV }, 0.1)
        callback()
    end)

    return btn
end

-- ── Load button ───────────────────────────────────────────────
makeButton(
    "Load Yuki's Hub",
    "Total Roblox Drama • Universal Script",
    48,
    C_ACCENT,
    function()
        gui:Destroy()
        task.spawn(function()
            local ok, err = pcall(function()
                loadstring(game:HttpGet(
                    "https://raw.githubusercontent.com/Yatoshisan/Yukis_TRD_Hub/refs/heads/main/launcher/launcher.lua"
                ))()
            end)
            if not ok then warn("[YukiLoader] Load failed: " .. tostring(err)) end
        end)
    end
)

-- ── Entrance animation ────────────────────────────────────────
win.BackgroundTransparency = 1
win.Position = UDim2.new(0.5, -130, 0.5, -36)
tween(win, { BackgroundTransparency = 0, Position = UDim2.new(0.5, -130, 0.5, -48) }, 0.25)