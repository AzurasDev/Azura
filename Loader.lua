local http_request = syn and syn.request or request;
local hwidPaste = loadstring(game:HttpGet("https://toldehub.github.io/Azura/Keys.lua"))()


local body = http_request({Url = 'https://httpbin.org/get'; Method = 'GET'}).Body;
local decoded = game:GetService("HttpService"):JSONDecode(body)
local hwid = decoded.headers['Syn-Fingerprint']

for i, v in pairs(hwidPaste) do
 if v == hwid then
    loadstring(game:HttpGet("https://toldehub.github.io/Azura/Script.lua"))()
  else
    setclipboard(hwid)
  })
  end
end
