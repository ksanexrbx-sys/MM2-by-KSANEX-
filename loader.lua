-- MM2 by KSANEX
-- Loader v2.1

local URL = "ВСТАВЬ_RAW_ССЫЛКУ_MAIN_LUA"

local success, result = pcall(function()
    return game:HttpGet(URL)
end)

if not success then
    warn("[KSANEX] Download failed")
    return
end

if type(result) ~= "string" or #result == 0 then
    warn("[KSANEX] Empty script")
    return
end

local compile, script = pcall(loadstring, result)

if not compile or not script then
    warn("[KSANEX] Compile failed")
    return
end

local executed, err = pcall(script)

if not executed then
    warn("[KSANEX] Execution error:", err)
end
