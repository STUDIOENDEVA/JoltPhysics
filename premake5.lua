project "JoltPhysics"
	kind "StaticLib"
	language "C++"
	location (path.join(project_root, "build"))

	targetdir ("%{bindir}/%{prj.name}")
	objdir ("%{intdir}/%{prj.name}")

	warnings "Off"

	includedirs { "." }

	files
	{
		"Jolt/**.h",
		"Jolt/**.cpp",
		"Jolt/**.inl"
	}

	removefiles
	{
		"Jolt/Compute/CPU/**",
		"Jolt/Compute/DX12/**",
		"Jolt/Compute/MTL/**",
		"Jolt/Compute/VK/**",
		"Jolt/Shaders/**"
	}

	defines { "JPH_OBJECT_STREAM" }

	filter "system:windows"
		systemversion "latest"
		staticruntime "On"
		defines { "_CRT_SECURE_NO_WARNINGS" }
		vectorextensions "AVX2"
		defines {
			"JPH_USE_AVX2",
			"JPH_USE_AVX",
			"JPH_USE_SSE4_1",
			"JPH_USE_SSE4_2",
			"JPH_USE_LZCNT",
			"JPH_USE_TZCNT",
			"JPH_USE_F16C",
			"JPH_USE_FMADD"
		}
		buildoptions { "/fp:fast" }
	filter ""

	filter "system:linux or system:macosx"
		pic "On"
		staticruntime "On"
	filter ""

	filter { "system:linux", "architecture:x86_64" }
		buildoptions { "-mavx2", "-mbmi", "-mpopcnt", "-mlzcnt", "-mf16c", "-mfma" }
		defines {
			"JPH_USE_AVX2",
			"JPH_USE_AVX",
			"JPH_USE_SSE4_1",
			"JPH_USE_SSE4_2",
			"JPH_USE_LZCNT",
			"JPH_USE_TZCNT",
			"JPH_USE_F16C",
			"JPH_USE_FMADD"
		}
	filter ""

	filter "configurations:Debug"
		runtime "Debug"
		symbols "on"
	filter ""

	filter "configurations:DebugEditor"
		runtime "Debug"
		symbols "on"
	filter ""

	filter "configurations:Release"
		runtime "Release"
		optimize "on"
	filter ""

	filter "configurations:ReleaseEditor"
		runtime "Release"
		optimize "on"
	filter ""

	filter "configurations:Dist"
		runtime "Release"
		optimize "on"
		symbols "off"
	filter ""
