local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local existingGui = PlayerGui:FindFirstChild("SideButtonGui")
if existingGui then
	existingGui:Destroy()
end

local gui = Instance.new("ScreenGui")
gui.Name = "SideButtonGui"
gui.ResetOnSpawn = false
gui.Parent = PlayerGui

local button = Instance.new("TextButton")
button.Name = "SidePrintButton"
button.Size = UDim2.new(0, 120, 0, 40)
button.Position = UDim2.new(1, -10, 0.5, 0)
button.AnchorPoint = Vector2.new(1, 0.5)
button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
button.BackgroundTransparency = 0.7
button.BorderSizePixel = 2
button.BorderColor3 = Color3.fromRGB(255, 255, 255)
button.Text = "Weld"
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.TextScaled = true
button.Font = Enum.Font.GothamSemibold
button.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = button

local stroke = Instance.new("UIStroke")
stroke.Thickness = 1
stroke.Transparency = 0.5
stroke.Parent = button

task.spawn(function()
	while true do
		StarterGui:SetCore("SendNotification", {
			Title = "RINGTA x NotImportant MADE",
			Text = "discord.gg/ringta",
			Icon = "rbxassetid://99581962287910",
			Duration = 5
		})
		task.wait(20)
	end
end)

button.MouseButton1Click:Connect(function()
	local runtimeItems = workspace:FindFirstChild("RuntimeItems")
	local train = workspace:FindFirstChild("Train")
	if not (runtimeItems and train) then return end

	local platform = train:FindFirstChild("Platform")
	if not platform then return end

	local platformPart = platform:FindFirstChild("Part")
	if not platformPart then return end

	local remote = ReplicatedStorage:FindFirstChild("Shared")
	if not remote then return end
	remote = remote:FindFirstChild("Network")
	if not remote then return end
	remote = remote:FindFirstChild("RemoteEvent")
	if not remote then return end
	remote = remote:FindFirstChild("RequestWeld")
	if not remote then return end

	for _, model in ipairs(runtimeItems:GetChildren()) do
		if model:IsA("Model") then
			for _, part in ipairs(model:GetDescendants()) do
				if (part:IsA("Part") or part:IsA("MeshPart")) and part:FindFirstChild("DragAttachment") then
					remote:FireServer(model, platformPart)
					return
				end
			end
		end
	end
end)
