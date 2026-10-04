
-- MM2 by KSANEX
-- Loader v2.1

local URL = "https://raw.githubusercontent.com/ksanexrbx-sys/MM2-by-KSANEX-/refs/heads/main/main.lua"

local success, source = pcall(function()
    return game:HttpGet(URL)
end)

if not success then
    warn("[KSANEX] Download failed")
    return
end

if type(source) ~= "string" or #source == 0 then
    warn("[KSANEX] Empty script")
    return
end

local compileSuccess, chunk = pcall(loadstring, source)

if not compileSuccess or type(chunk) ~= "function" then
    warn("[KSANEX] Compilation failed")
    return
end

local runSuccess, err = pcall(chunk)

if not runSuccess then
    warn("[KSANEX] Error:", err)
end
