local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Create the main GUI container
local gui = Instance.new("ScreenGui")
gui.Name = "PopupGui"
gui.ResetOnSpawn = false
gui.Parent = PlayerGui

-- Create a centered frame
local mainFrame = Instance.new("Frame")
mainFrame.Name = "PopupFrame"
mainFrame.Parent = gui
mainFrame.Size = UDim2.new(0, 200, 0, 100)
mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.BackgroundTransparency = 0.2
mainFrame.BorderSizePixel = 0

-- Add rounded corners
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0.05, 0)
corner.Parent = mainFrame

-- Create title label
local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "TitleLabel"
titleLabel.Parent = mainFrame
titleLabel.Size = UDim2.new(1, 0, 0.3, 0)
titleLabel.Position = UDim2.new(0, 0, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "Weld Handler"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextScaled = true
titleLabel.Font = Enum.Font.GothamBold

-- Create action button inside the popup
local button = Instance.new("TextButton")
button.Name = "PopupButton"
button.Parent = mainFrame
button.Size = UDim2.new(0.8, 0, 0.4, 0)
button.Position = UDim2.new(0.5, 0, 0.55, 0)
button.AnchorPoint = Vector2.new(0.5, 0.5)
button.BackgroundColor3 = Color3.fromRGB(50, 205, 50) -- Green for action
button.BackgroundTransparency = 0.1
button.Text = "Execute Weld"
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.TextScaled = true
button.Font = Enum.Font.GothamSemibold

-- Add rounded corners to the button
local buttonCorner = Instance.new("UICorner")
buttonCorner.CornerRadius = UDim.new(0.1, 0)
buttonCorner.Parent = button

-- Add UIStroke for sleek borders
local stroke = Instance.new("UIStroke")
stroke.Thickness = 2
stroke.Transparency = 0.3
stroke.Parent = button

-- Functionality remains unchanged
button.MouseButton1Click:Connect(function()
    for _, model in pairs(workspace.RuntimeItems:GetChildren()) do
        if model:IsA("Model") then
            for _, part in pairs(model:GetDescendants()) do
                if (part:IsA("Part") or part:IsA("MeshPart")) and not part:FindFirstChild("DragAttachment") then
                    local Train = workspace:WaitForChild("Train")
                    local Platform = Train:WaitForChild("Platform")
                    local Part = Platform:WaitForChild("Part")
                    local Network = game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Network")
                    local event = Network:WaitForChild("RequestWeld")
                    event:FireServer(unpack({ part, Part }))
                end
            end
        end
    end
end)

-- Allow pressing "Q" to trigger the weld process
UserInputService.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.KeyCode == Enum.KeyCode.Q then
        button:MouseButton1Click:Fire()
    end
end)
