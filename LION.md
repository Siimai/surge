# Surge 1.9.0 for Mac OS X 10.7 Lion

This branch (`lion-1.9.0`) is Surge 1.9.0 with the changes needed to build
plugins that run on Mac OS X 10.7.5 Lion: the Surge synth (AU, VST3, VST2) and
the Surge Effects Bank (AU, VST3, VST2). It is not supported upstream.

## Requirements

The plugins run on Lion but cannot be built there: the newest Xcode for Lion
(4.6, clang 3.2) has no C++14 support. Build on a newer Mac and copy the
plugins to the Lion machine.

- A Mac that can run **Xcode 11** (tested: macOS 10.14.6 Mojave, Xcode 11.3.1,
  10.15 SDK). Xcode 12+ can no longer target 10.7.
- CMake 3.15 or newer (tested with 3.22.6).
- Optional, for VST2: the Steinberg VST 2.4 SDK. It is not redistributable and
  is not part of this repository; point `VST2SDK_DIR` at your own copy.

## Build

```
git clone --recurse-submodules -b lion-1.9.0 https://github.com/Siimai/surge.git
cd surge
export VST2SDK_DIR=/path/to/vstsdk2.4      # optional, enables VST2
cmake -S . -B build -DBUILD_SURGE_JUCE_PLUGINS=ON
cmake --build build --target Surge-AU-Packaged Surge-VST3-Packaged \
      Surge-VST2-Packaged surge-fx_AU surge-fx_VST3 surge-fx_VST -- -j2
```

Leave out `Surge-VST2-Packaged` and `surge-fx_VST` without a VST2 SDK.

Products:

- `build/surge_products/Surge.component`, `Surge.vst3`, `Surge.vst`
- `build/surge-fx_artefacts/Release/{AU,VST3,VST}/SurgeEffectsBank.*`

Install them into `/Library/Audio/Plug-Ins/{Components,VST3,VST}` and clear
`~/Library/Caches/AudioUnitCache`.

## What differs from release_1.9.0

- macOS defaults: deployment target 10.7, `x86_64` only, `-stdlib=libc++`
  (clang defaults to the absent libstdc++ below 10.9).
- `patches/vstgui-lion.patch`, applied to `vstgui.surge` at configure time:
  `MAX_OS_X_VERSION_*` typos in `mactimer.cpp` and `nsviewframe.mm` made
  version guards always false, so the editor called 10.9/10.10-only APIs.
- `patches/juce-6.0.7-lion.patch`, applied to the JUCE checkout at configure
  time: guards `setAccessoryViewDisclosed:` and `setMinFullScreenContentSize:`
  (10.11+) and avoids `objectForKeyedSubscript:` (10.8+).
- JUCE is cloned over `https://` (GitHub no longer serves `git://`).
- Effects Bank AU links `AudioUnit.framework` first so `AudioUnitGetParameter`
  and friends bind to it; on 10.7 they are not in AudioToolbox.
- The VST2 SDK sources are compiled without `-Werror` and with
  `-Wno-c++11-narrowing`; the 2006-era SDK does not compile cleanly as C++14.

## Testing on Lion

`auval` on 10.7 runs the 32-bit validator; validate the 64-bit plugins with:

```
arch -x86_64 /usr/bin/auvaltool -v aumu Srge VmbA   # Surge
arch -x86_64 /usr/bin/auvaltool -v aufx SFXB VmbA   # Surge Effects Bank
```
