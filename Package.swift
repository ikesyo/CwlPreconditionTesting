// swift-tools-version:5.0
import PackageDescription

let package = Package(
	name: "CwlPreconditionTesting",
	products: {
		#if os(macOS)
		return [
			.library(name: "CwlPreconditionTesting", targets: ["CwlPreconditionTesting", "CwlMachBadInstructionHandler"]),
			.library(name: "CwlPosixPreconditionTesting", targets: ["CwlPosixPreconditionTesting"])
		]
		#else
		return [
			.library(name: "CwlPosixPreconditionTesting", targets: ["CwlPosixPreconditionTesting"])
		]
		#endif
	}(),
	dependencies: [
		.package(url: "https://github.com/mattgallagher/CwlCatchException.git", from: "2.0.0")
	],
	targets: {
		#if os(macOS)
		return [
			.target(
				name: "CwlPreconditionTesting",
				dependencies: [
					.target(name: "CwlMachBadInstructionHandler"),
					.product(name: "CwlCatchException")
				]
			),
			.target(
				name: "CwlPosixPreconditionTesting"
			),
			.target(name: "CwlMachBadInstructionHandler"),
			.testTarget(name: "CwlPreconditionTestingTests", dependencies: ["CwlPreconditionTesting", "CwlPosixPreconditionTesting"])
		]
		#else
		return [
			.target(
				name: "CwlPosixPreconditionTesting"
			),
			.testTarget(name: "CwlPreconditionTestingTests", dependencies: ["CwlPosixPreconditionTesting"])
		]
		#endif
	}()
)
