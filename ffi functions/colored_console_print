local ffi = require("ffi")

ffi.cdef[[
    int* GetProcAddress(
        void* hModule,
        const char* lpProcName
    );

    void* GetModuleHandleA(
        const char* lpModuleName
    );

    typedef struct {
        unsigned char r, g, b, a;
    } Color;

    typedef void(__cdecl *ColorMsgFn)(const Color&, const char*);
]]

local function color_print(msg, r, g, b, a)
    local colmsg = ffi.cast("ColorMsgFn", ffi.C.GetProcAddress(ffi.C.GetModuleHandleA("tier0.dll"), "?ConColorMsg@@YAXABVColor@@PBDZZ"))

    local color = ffi.new("Color")
    color.r = r
    color.g = g
    color.b = b
    color.a = a

    colmsg(color, msg)
end

color_print("Hello World\n", 0, 255, 0, 255)
