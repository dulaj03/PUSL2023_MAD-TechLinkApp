@echo off
"C:\\Users\\DELL\\AppData\\Local\\Android\\sdk\\cmake\\3.22.1\\bin\\cmake.exe" ^
  "-HC:\\flutter\\packages\\flutter_tools\\gradle\\src\\main\\groovy" ^
  "-DCMAKE_SYSTEM_NAME=Android" ^
  "-DCMAKE_EXPORT_COMPILE_COMMANDS=ON" ^
  "-DCMAKE_SYSTEM_VERSION=23" ^
  "-DANDROID_PLATFORM=android-23" ^
  "-DANDROID_ABI=x86" ^
  "-DCMAKE_ANDROID_ARCH_ABI=x86" ^
  "-DANDROID_NDK=C:\\Users\\DELL\\AppData\\Local\\Android\\sdk\\ndk\\27.0.12077973" ^
  "-DCMAKE_ANDROID_NDK=C:\\Users\\DELL\\AppData\\Local\\Android\\sdk\\ndk\\27.0.12077973" ^
  "-DCMAKE_TOOLCHAIN_FILE=C:\\Users\\DELL\\AppData\\Local\\Android\\sdk\\ndk\\27.0.12077973\\build\\cmake\\android.toolchain.cmake" ^
  "-DCMAKE_MAKE_PROGRAM=C:\\Users\\DELL\\AppData\\Local\\Android\\sdk\\cmake\\3.22.1\\bin\\ninja.exe" ^
  "-DCMAKE_LIBRARY_OUTPUT_DIRECTORY=F:\\NSBM New\\2nd Year\\2nd Sem\\Mobile Application Development\\TechLink-All_in_one_integrated_ecosystem_for_IT_industry\\tech_link\\build\\app\\intermediates\\cxx\\Debug\\1q3s1b21\\obj\\x86" ^
  "-DCMAKE_RUNTIME_OUTPUT_DIRECTORY=F:\\NSBM New\\2nd Year\\2nd Sem\\Mobile Application Development\\TechLink-All_in_one_integrated_ecosystem_for_IT_industry\\tech_link\\build\\app\\intermediates\\cxx\\Debug\\1q3s1b21\\obj\\x86" ^
  "-DCMAKE_BUILD_TYPE=Debug" ^
  "-BF:\\NSBM New\\2nd Year\\2nd Sem\\Mobile Application Development\\TechLink-All_in_one_integrated_ecosystem_for_IT_industry\\tech_link\\android\\app\\.cxx\\Debug\\1q3s1b21\\x86" ^
  -GNinja ^
  -Wno-dev ^
  --no-warn-unused-cli
