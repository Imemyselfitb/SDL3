outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

project "SDL3"
	location "SDL3"
	kind "StaticLib"
	language "C"

	targetname "SDL3"
	targetdir "lib/"
	objdir "bin-int/"

	includedirs {
		"include",
		"include/build_config",
		"src",
		"src/hidapi/hidapi"
	}

	linkoptions { "/NODEFAULTLIB" }
	links {
        "version",
        "imm32",
        "winmm",
        "setupapi"
    }

	-- Files included on all platforms
	files {
		"src/*.c",

		-- Main
		"src/main/SDL_main_callbacks.c",
		"src/core/*.c",

		-- stdlib
		"src/stdlib/*.c",
		"src/libm/*.c",

		-- Device Specs
		"src/cpuinfo/*.c",
		"src/storage/**.c",

		-- Events
		"src/io/*.c",
		"src/io/generic/**.c",
		"src/sensor/*.c",
		"src/events/*.c",
		"src/process/*.c",

		-- Atomic
		"src/atomic/*.c",

		-- Dynapi
		"src/dynapi/*.c",

		-- Tray
		"src/tray/*.c",

		-- File Dialogs
		"src/dialog/*.c",
		
		-- Video
		"src/video/*.c",
		"src/video/yuv2rgb/*.c",
		"src/video/offscreen/*.c",
		"src/video/dummy/*.c",
		"src/render/**.c",
		"src/render/software/*.c",
		"src/gpu/*.c",
		"src/camera/*.c",
		"src/camera/dummy/*.c",
		
		-- Audio (DirectSound, WASAPI)
 		"src/audio/*.c",
		
		-- Joystick / HID
		"src/joystick/*.c",
		"src/joystick/virtual/**.c",
		"src/joystick/hidapi/**.c",
		"src/hidapi/*.c",
		
		-- Haptic
		"src/haptic/*.c",
		
		-- Power
		"src/power/*.c",
		
		-- Thread
		"src/thread/*.c",
		
		-- Time
		"src/time/*.c",
		"src/timer/*.c",
		
		-- Filesystem
		"src/filesystem/*.c",

		-- Locale
		"src/locale/*.c",

		-- Misc
		"src/misc/*.c",
		"src/loadso/*.c",
	}


	filter "system:windows"
		defines { "SDL_STATIC", "_CRT_SECURE_NO_WARNINGS", "SDL_STATIC", "SDL_MAIN_HANDLED" }
		systemversion "latest"

		includedirs { "src/hidapi/windows" }
	
		-- Files only included on windows
		files {
			"src/*.c",

			-- Main
			"src/main/windows/**.c",
			"src/main/generic/SDL_sysmain_callbacks.c",

			-- Core
			"src/core/windows/**.c",

			-- Events
			"src/io/windows/**.c",
			"src/io/generic/SDL_asyncio_generic.c", -- Implementation not defined in io/windows
			"src/sensor/windows/**.c",
			"src/process/windows/**.c",

			-- Tray
			"src/tray/windows/**.c",

			-- File Dialogs
			"src/dialog/windows/**.c",
		
			-- Video (Direct3D, Windows, etc.)
			"src/video/windows/**.c",
			"src/video/directx/**.c",
			"src/video/yuv2rgb/**.c",
			"src/video/mediafoundation/**.c",
			"src/gpu/vulkan/**.c",
			"src/gpu/d3d12/**.c",
			"src/camera/mediafoundation/**.c",
		
			-- Audio (DirectSound, WASAPI)
 			"src/audio/directsound/**.c",
			"src/audio/wasapi/**.c",
			"src/audio/disk/**.c",
			"src/audio/dummy/**.c",
		
			-- Joystick / HID
			"src/joystick/windows/**.c",
		
			-- Haptic
			"src/haptic/windows/**.c",
		
			-- Power
			"src/power/windows/**.c",
		
			-- Thread
			"src/thread/windows/**.c",
			"src/thread/generic/SDL_sysrwlock.c",
			"src/thread/generic/SDL_syscond.c",
		
			-- Time
			"src/time/windows/**.c",
			"src/timer/windows/**.c",
		
			-- Filesystem
			"src/filesystem/windows/**.c",

			-- Locale
			"src/locale/windows/**.c",

			-- Miscellany
			"src/misc/windows/**.c",
			"src/loadso/windows/**.c",
		}

	--[[
	filter "system:linux"
		defines { "SDL_STATIC" }

		includedirs { "src/hidapi/linux" }

		files {
			"src/*.c",

			-- Core
			"src/core/linux/**.c",
		
			-- Video (X11, Wayland, etc.)
			"src/video/x11/**.c",
			"src/video/wayland/**.c",
			"src/video/kmsdrm/**.c",
			"src/video/dummy/**.c",
		
			-- Audio (ALSA, Pulse, etc.)
			"src/audio/alsa/**.c",
			"src/audio/pulseaudio/**.c",
			"src/audio/disk/**.c",
			"src/audio/dummy/**.c",
		
			-- Joystick / HID
			"src/joystick/linux/**.c",
			"src/hidapi/linux/**.c",

			-- Haptic
			"src/haptic/linux/**.c",

			-- Power
			"src/power/linux/**.c",

			-- Thread
			"src/thread/pthread/**.c",

			-- Timer
			"src/timer/unix/**.c",

			-- Filesystem
			"src/filesystem/unix/**.c",

			-- Misc
			"src/loadso/dlopen/**.c",
		}
	]]
	
	filter "system:windows"
		cdialect "C17"
		staticruntime "On"
		systemversion "latest"
		optimize "On"
