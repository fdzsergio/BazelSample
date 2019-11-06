# BazelSample

This is a small example of how to build an iOS application with *Bazel*. If you want to know how it works and how to develop an example from scratch, check the [article](https://medium.com/@fdzsergio/building-faster-in-ios-with-bazel-448a3074e73).

## Requirements

To build and test the project you need the following dependencies:
- Xcode 11.2.0
- Bazel 1.1.0
- Carthage 0.34.0

If you want to generate the Xcode project, you will need to install [Tulsi](https://github.com/bazelbuild/tulsi). You will need to setup the environment with carthage before build any target. I've built a script to automatizate this: 

> $ make setup

## Usage

To build the iOS app and generate an IPA file you will run:

> $ make build

If you want to test all targets on project run the following:

> $ make test

To run the app on simulator from terminal you could exec:

> $ make run

### Xcode project generation

To generate the xcode project from terminal you need to run:
> $ make project

This command generate a project on `Develop` environment, if you want to change it, you could run: 

> $ scripts/tulsigen config/BazelSample.tulsiproj Production

## Advanced usage 

If you want to build a release version with `Production` envinronment you need pass the following options:

> $ tools/bazelw build //App:Sample --config release --define envinronment=production

Maybe you need to config the `ios_signing_cert_name` on `.bazelrc`, and specify the `provisioning_profile` to handle the signing of the IPA file.

## References 

* https://github.com/lyft/envoy-mobile
* https://github.com/airbnb/BuckSample
* https://github.com/acecilia/BazelVSBuckSample
