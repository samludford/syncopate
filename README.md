# Syncopate
A simple Swift library for handling clocking and synchronisation in creative music apps. Syncopate is based on **ticks**, which are inspired by the concept of a 'bang' in Max/MSP.

Syncopate can be used in apps targeting iOS 8.0 and up.

## Installation
Syncopate can be integrated into your project is via [Cocoapods](https://guides.cocoapods.org/using/getting-started.html). You can do so by adding the following to your [Podfile](https://guides.cocoapods.org/syntax/podfile.html):

```
platform :ios, '8.0'
use_frameworks!
pod 'Syncopate', :git => 'https://github.com/samludford/syncopate.git'
```

**N.b.** the `use_frameworks!` line is required for all Cocoapods written in Swift. See [this post](http://blog.cocoapods.org/CocoaPods-0.36/) for more details.

### Troubleshooting

The Swift compiler may occasionally complain that it cannot locate the Swift module (the error will appear on the `import Syncopate` line). This appears to be a bug in Xcode, and can be fixed by simply building the project.

Anyone using Xcode 7 beta may experience a `Library not loaded` / `Image not found` error when attempting to run on a device. This can be remedied by adding the Cocoapods generated framework (`Pods_[project name].framework`) to the project as an embedded binary (this can be done in the General tab of the project settings).

## Overview

Syncopate is based around the concept of a **tick**. Ticks are messages sent by instances of an `SLTicker` subclass to all conformers to the `SLTickReceiver` protocol who have registered to receive them. Using this interface chains can be built which control audio playback relative to an original tick source. There is no limit to how many `SLTickReceiver`s can be registered with an `SLTicker`, or how many different `SLTicker`s an `SLTickReceiver` can be registered with.

For example, in a typical music app the tick source might be a metronome that emits ticks at a regular time interval (an implementation is provided by the `SLMetronome` class). Registered to receive these ticks might be an object which manages an array of boolean values representing a musical rhythm. Whenever it receives a tick it moves one step along the array, emitting a tick of its own whenever it encounters a `true` value (the `SLPatternManager` class performs this task). Receiving these ticks could be an object which manages the id of an audio file, instructing the audio output system to play this file every time it gets ticked (`SLSample` implements this function, sending *play* messages to any conformer to the  `SLAudioPlayer` protocol, allowing client apps to implement audio playback however they like). If several of these chains are hooked up to the same metronome their rhythms will play in sync - to see this setup in action, please see the example app.

Syncopate also provides two protocols, `SLStateChanger` and `SLStateChangeListener`, which work in a similar manner to `SLTicker` and `SLTickReceiver`. But unlike the tick interface, which is intended to control a 'horizontal' flow of messages used to temporally synchronise audio playback, the state change interface offers a way to manage 'vertical' flows of messages not directly related to synchronised playback, for example those pertaining to user input and UI.

## BeatMachine Example App

This repository contains both the Syncopate framework and an example app, which demonstrates how the library can be used to build a (very!) basic drum sequencer.

![Alt text](https://github.com/samludford/syncopate/blob/master/Screenshots/beatmachine.png?raw=true "The Beat Machine drum sequencer")
