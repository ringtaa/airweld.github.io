local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Create a single button instance
local button = Instance.new("TextButton")
button.Name = "ClickButton"
button.Size = UDim2.new(0, 120, 0, 40)
button.Position = UDim2.new(0.5, -60, 0.5, -20)
button.AnchorPoint = Vector2.new(0.5, 0.5)
button.BackgroundColor3 = Color3.fromRGB(50, 150, 250)
button.BackgroundTransparency = 0.2
button.Text = "Click"
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.TextScaled = true
button.Font = Enum.Font.GothamSemibold
button.Parent = LocalPlayer:WaitForChild("PlayerGui")

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
