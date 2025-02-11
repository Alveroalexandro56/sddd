-- Create the ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "KeyboardGui"
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Create the button to toggle keyboard visibility
local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(0, 100, 0, 50)
toggleButton.Position = UDim2.new(0, 10, 0, 10)
toggleButton.Text = "Open Keyboard"
toggleButton.Parent = screenGui

-- Create the keyboard frame
local keyboardFrame = Instance.new("Frame")
keyboardFrame.Size = UDim2.new(0, 400, 0, 150)
keyboardFrame.Position = UDim2.new(0, 10, 0, 70)
keyboardFrame.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
keyboardFrame.Visible = false
keyboardFrame.Parent = screenGui

-- Make the keyboard draggable
local dragging = false
local dragStart = nil
local startPos = nil

keyboardFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = keyboardFrame.Position
    end
end)

keyboardFrame.InputChanged:Connect(function(input)
    if dragging then
        local delta = input.Position - dragStart
        keyboardFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

keyboardFrame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

-- Add keys to the keyboard
local function createKey(text, position)
    local key = Instance.new("TextButton")
    key.Size = UDim2.new(0, 50, 0, 50)
    key.Position = position
    key.Text = text
    key.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
    key.Parent = keyboardFrame
end

-- Create keys for the keyboard (e.g., 'Q', 'W', 'E', etc.)
for i = 1, 10 do
    createKey(tostring(i), UDim2.new(0, (i - 1) * 50, 0, 0))
end

-- Toggle the visibility of the keyboard when the button is clicked
toggleButton.MouseButton1Click:Connect(function()
    keyboardFrame.Visible = not keyboardFrame.Visible
end)
