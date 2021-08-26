-- shitsploit detector -sekawn
if identifyexecutor() ~= "Scriptware" and (syn and syn.request) == nil then
    return error("bad exploit (more commonly known as a shitsploit) detected")
end

-- made better httpget using syn/http.request -sekawn
local HttpGet = function(url)
    return (http or syn).request({Url=url,Method="GET"}).Body
end

loadstring(HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()

-- this table is 100% completely useless but i'll keep it in
local info = {
    owner = "LuaLighter",
    repo = "Infinite-Store",
    folder = "plugins"
}
local plugins = {}

-- rewrote all of the github api code -sekawn
local HttpService = game:GetService("HttpService")
local DecodeJSON = function(json)
    return HttpService.JSONDecode(HttpService,json)
end
for _, plugin in ipairs(DecodeJSON(HttpGet(string.format("https://api.github.com/repos/%s/%s/contents/%s",info.owner,info.repo,info.folder)))) do
    plugins[plugin.name] = plugin.download_url
end

-- epic protect gui function -sekawn (credit to Toon#6216 or <@524359788952551424>)
local ParentGui
do
    local Prote = loadstring(HttpGet("https://raw.githubusercontent.com/Toon-arch/Property-Module/main/prote.lua"))()
    local secureString = function()
         return game:GetService("HttpService"):GenerateGUID(false):gsub("-", ""):sub(1, math.random(25, 30))
    end
    ParentGui = function(Gui)
         Prote.ProtectInstance(Gui)
         Gui.Name = secureString()
         if (not is_sirhurt_closure) and (syn and syn.protect_gui) then
              syn.protect_gui(Gui)    
              Gui.Parent = game:GetService("CoreGui")
         elseif get_hidden_gui or gethui then
              local HiddenUI = get_hidden_gui or gethui
              Gui.Parent = HiddenUI()
         elseif game:GetService("CoreGui"):FindFirstChild("RobloxGui") then
              Gui.Parent = game:GetService("CoreGui")["RobloxGui"]    
         else
              Gui.Parent = game:GetService("CoreGui")
         end
    end
end

local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local TextBox = Instance.new("TextBox")
local TextButton = Instance.new("TextButton")

ParentGui(ScreenGui)
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Frame.Position = UDim2.new(0.678832114, 0, 0.78295821, 0)
Frame.Size = UDim2.new(0, 245, 0, 121)

TextBox.Parent = Frame
TextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextBox.Position = UDim2.new(0.0897959173, 0, 0.504132211, 0)
TextBox.Size = UDim2.new(0, 200, 0, 50)
TextBox.Font = Enum.Font.SourceSans
TextBox.PlaceholderText = "pluginname"
TextBox.Text = ""
TextBox.TextColor3 = Color3.fromRGB(0, 0, 0)
TextBox.TextSize = 14.000

TextButton.Parent = Frame
TextButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextButton.Position = UDim2.new(0.0897959173, 0, 0.0909090936, 0)
TextButton.Size = UDim2.new(0, 200, 0, 50)
TextButton.Font = Enum.Font.SourceSans
TextButton.Text = "install"
TextButton.TextColor3 = Color3.fromRGB(0, 0, 0)
TextButton.TextSize = 14.000

-- pretty much rewrote this section but it works now and you can optionally put .iy
TextButton.MouseButton1Down:Connect(function()
    local TextBox_Text = string.lower(TextBox.Text)
    if string.sub(TextBox_Text,-3) ~= ".iy" then
        TextBox_Text ..= ".iy"
    end
    for name, url in pairs(plugins) do
        if string.lower(name) == TextBox_Text then
            writefile(name, HttpGet(url))
            addPlugin(name)
        end
    end
end)
