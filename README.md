# Surge 1.9.0 for Mac OS X 10.7 Lion

> **This is an unofficial fork of Surge.** Its only purpose is to make Surge 1.9.0
> run on Mac OS X 10.7 Lion. It is not made, endorsed or supported by the Surge
> Synth Team.
>
> **If you want Surge, please get it from the original project instead:**
> **[github.com/surge-synthesizer/surge](https://github.com/surge-synthesizer/surge)**
> (downloads at [surge-synthesizer.github.io](https://surge-synthesizer.github.io)).
> The original project is where Surge is developed, and its current version, Surge XT,
> is far newer than the 1.9.0 code in this fork.

Use this fork only if you need Surge on a Mac running OS X 10.7 Lion. It produces the
Surge synth and the Surge Effects Bank as AU, VST3 and VST2 plugins that run on Lion.

The plugins cannot be built on Lion itself: Lion's newest Xcode (4.6) has no C++14
support, which Surge 1.9.0 needs. Build them on a newer Mac with Xcode 11 (for example
macOS 10.14 Mojave) and copy them to the Lion machine. Build instructions and the full
list of changes are in [LION.md](LION.md).

Please report problems with this fork in this repository, not to the Surge Synth Team.

## Credits and license

Surge was created by Claes Johanson at Vember Audio and is developed by the
[Surge Synth Team](https://surge-synth-team.org/). This fork, like Surge, is licensed
under the GNU General Public License v3; see [LICENSE](LICENSE).
