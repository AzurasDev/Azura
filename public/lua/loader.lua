local http_request = syn and syn.request or request;
local hwidPaste = loadstring(game:HttpGet("https://RespectfulInsecureListener.whowho2.repl.co/lua/keyhhhhgr.lua"))()
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

local body = http_request({Url = 'https://httpbin.org/get'; Method = 'GET'}).Body;
local decoded = game:GetService("HttpService"):JSONDecode(body)
local hwid = decoded.headers['Syn-Fingerprint']

for i, v in pairs(hwidPaste) do
if v == hwid then
    loadstring(game:HttpGet(('https://respectfulinsecurelistener.whowho2.repl.co/lua/main.lua')))()
else
    setclipboard(hwid)
    OrionLib:MakeNotification({
        Name = "Not whitelisted!",
        Content = "Join the discord and open an ticket (whitelist code copied to clipboard)",
        Image = "rbxassetid://4483345998",
        Time = 10
    })
    
    --[[
    Title = <string> - The title of the notification.
    Content = <string> - The content of the notification.
    Image = <string> - The icon of the notification.
    Time = <number> - The duration of the notfication.
    ]]
end
end