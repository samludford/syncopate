# Syncopate
A simple, flexible Swift library for handling clocking and synchronisation in music apps.

## Installation
The easiest way to integrate Syncopate into your project is via [Cocoapods](https://guides.cocoapods.org/using/getting-started.html). You can do so by adding the following to your [Podfile](https://guides.cocoapods.org/syntax/podfile.html):

```
platform :ios, '8.0'
use_frameworks!
pod 'Syncopate', :git => 'https://github.com/samludford/syncopate.git'
```

**N.b.** the `use_frameworks!` line is required for all Cocoapods written in Swift. See [this post](http://blog.cocoapods.org/CocoaPods-0.36/) for more details.

## Use

Syncopate is based around 'ticks', contentless messages which are emitted by classes extending `SLTicker` and received by classes conforming to the `SLTickReceiver` protocol. Using these two interfaces 



## Example App

This repository contains both the Syncopate framework and an example app, which demonstrates how the library can be used to build a basic drum sequencer. 
