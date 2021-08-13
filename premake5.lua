local raylib_dir = "../raylib"
local rlExtras_dir = "../raylibExtras/rlImGui"
local imgui_dir = "../imgui"

workspace "HelloWorld"
    configurations { "Debug", "Release" }
    location "build"

project "raylib"
	filter "configurations:Debug.DLL OR Release.DLL"
		kind "SharedLib"
		defines {"BUILD_LIBTYPE_SHARED"}
		
	filter "configurations:Debug OR Release"
		kind "StaticLib"
		
	filter "action:vs*"
		defines{"_WINSOCK_DEPRECATED_NO_WARNINGS", "_CRT_SECURE_NO_WARNINGS", "_WIN32"}
		links {"winmm"}
				
	filter{}
	
	location "build"
	language "C"
	targetdir "bin/%{cfg.buildcfg}"
	
	includedirs { raylib_dir .. "/src", raylib_dir .. "/src/external/glfw/include"}
	--[[
	vpaths 
	{
		["Header Files"] = { raylib_dir .. "/src/**.h"},
		["Source Files/*"] = {raylib_dir .. "/src/**.c"},
	}
	]]--
	files {raylib_dir .. "/src/*.h", raylib_dir .. "/src/*.c"}
	
	defines{"PLATFORM_DESKTOP", "GRAPHICS_API_OPENGL_33"}

project "imgui"
    kind "StaticLib"
    language "C++"
    includedirs { imgui_dir }
    files { imgui_dir .. "/*.h", imgui_dir .. "/*.cpp"}


project "rlImGui"
	kind "StaticLib"
	dependson "imgui"
	filter "action:vs*"
		defines{"_WINSOCK_DEPRECATED_NO_WARNINGS", "_CRT_SECURE_NO_WARNINGS", "_WIN32"}
		links {"winmm"}
				
	filter{}
	location "../raylibExtras/rlImGui/"
	language "C++"
	targetdir "bin/%{cfg.buildcfg}"
	
    links {"raylib", "imgui"}
	includedirs { raylib_dir .. "/src","rlImGui", imgui_dir}
	--[[
	vpaths 
	{
		["Header Files"] = { "rlImGui/**.h"},
		["Source Files"] = {"rlImGui/**.cpp"},
		["ImGui Files"] = { "imGui/*.h","imGui/*.cpp" },
	}
	]]--
	files {raylib_dir .. "**.h", imgui_dir .. "/**.h", "../imgui/*.cpp", "../raylibExtras/rlImGui/**.cpp", "../raylibExtras/rlImGui/**.h"}

project "HelloWorld"
    kind "ConsoleApp"
    language "C++"
    targetdir "build/bin/%{cfg.buildcfg}"

    dependson {"raylib", "imgui", "rlImGui"}
    links {"raylib", "winmm", "imgui", "rlImGui"}

    includedirs { raylib_dir .. "/src", imgui_dir, rlExtras_dir}

    files { imgui_dir .. "**.cpp", rlExtras_dir .. "**.cpp", "**.h", "**.cpp"}
    location "build/HelloWorld"
    filter "configurations:Debug"
        defines { "DEBUG" }
        symbols "On"

    filter "configurations:Release"
    defines { "NDEBUG" }
    optimize "On"
