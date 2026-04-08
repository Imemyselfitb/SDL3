outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"
SDL3_deps = {}

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
	
	-- Files included on all platforms
	files {
		"src/*.c",

		-- Main
		"src/main/SDL_main_callbacks.c",
		"src/main/generic/**.c",
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
		"src/joystick/gdk/**.c",
		"src/hidapi/*.c",
		
		-- Haptic
		"src/haptic/*.c",
		
		-- Power
		"src/power/*.c",
		
		-- Thread
		"src/thread/*.c",
		"src/thread/generic/**.c",
		
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

	defines { "SDL_STATIC" }

	filter "system:windows"
		defines { "_CRT_SECURE_NO_WARNINGS", "SDL_MAIN_HANDLED" }
		systemversion "latest"
		buildoptions { "/MP" }
		
		cdialect "C17"
		staticruntime "On"
		systemversion "latest"
		optimize "On"

		includedirs { "src/hidapi/windows" }

		SDL3_deps["windows"] = {
			-- Core Platform libs
			"kernel32",
			"user32",
			"gdi32",
			"winmm",
			"imm32",
			"ole32",
			"oleaut32",
			"uuid",
			"advapi32",
			"setupapi",
			"shell32",

			-- Graphics
			"d3d11",
			"d3d12",
		}
	
		-- Files only included on windows
		files {
			-- Main
			"src/main/windows/**.c",

			-- Core
			"src/core/windows/**.c",

			-- Events
			"src/io/windows/**.c",
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

	filter "system:linux"
		defines {
			"_GNU_SOURCE",
			"HAVE_DBUS_DBUS_H=1",
			"HAVE_STDIO_H=1",
			"HAVE_XGENERICEVENTCOOKIE=1",
			"SDL_VIDEO_DRIVER_X11_SUPPORTS_GENERIC_EVENTS=1"
		}

		cdialect "C17"
		staticruntime "On"
		optimize "On"

		buildoptions { "`pkg-config --cflags dbus-1`" }
		linkoptions  { "`pkg-config --libs dbus-1`" }

		includedirs { "src/hidapi/linux" }

		-- Link against Linux system libraries
		SDL3_deps["linux"] = {
			-- Core Platform libs
			"pthread",
			"dl",
			"m",
			"rt",

			-- Window/Graphics
			"X11",
			"Xext",
			"Xcursor",
			"Xi",
			"Xfixes",
			"Xrandr",

			"wayland-client",
			"wayland-egl",
			"wayland-cursor",

			"xkbcommon",

			-- Audio
			"asound",
			"pulse",

			-- Input
			"udev",
		}

		files {
			-- Core
			"src/core/linux/**.c",

			-- IO
			"src/io/unix/**.c",

			-- Video (X11, Wayland, KMSDRM, etc.)
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
			"src/joystick/evdev/**.c",
			"src/hidapi/linux/**.c",

			-- Haptic
			"src/haptic/linux/**.c",

			-- Power
			"src/power/linux/**.c",

			-- Thread
			"src/thread/pthread/**.c",

			-- Time
			"src/time/unix/**.c",
			"src/timer/unix/**.c",

			-- Filesystem
			"src/filesystem/unix/**.c",

			-- Dynamic Loading
			"src/loadso/dlopen/**.c",
		}
