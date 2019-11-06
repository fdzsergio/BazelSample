load(
    "@build_bazel_rules_apple//apple:ios.bzl",
    "ios_application",
    "ios_unit_test",
)

load(
    "@build_bazel_rules_apple//apple:apple.bzl", 
    "apple_dynamic_framework_import",
    "apple_static_framework_import",
)

load(
    "@build_bazel_rules_swift//swift:swift.bzl", 
    "swift_library",
)

load(
    "//config:configs.bzl", 
    "swift_library_compiler_flags",
)

load(
    "//config:constants.bzl", 
    "SWIFT_VERSION",
    "MINIMUM_OS_VERSION",
    "PRODUCT_BUNDLE_IDENTIFIER_PREFIX",
)

def prebuilt_dynamic_framework(
    name,
    path,
    visibility = ["//visibility:public"],
    ):
    apple_dynamic_framework_import(
        name = name,
        framework_imports = native.glob([path + "/**",]),
        visibility = visibility,
    )

def prebuilt_static_framework(
    name,
    path,
    visibility = ["//visibility:public"],
    ):
    apple_static_framework_import(
        name = name,
        framework_imports = native.glob([path + "/**",]),
        visibility = visibility,
    )

def swift_unit_test(
    name, 
    srcs = [],
    deps = [],
    visibility = ["//visibility:public"],
    ):
    test_lib_name = name + "TestLib"
    swift_library(
        name = test_lib_name,
        srcs = srcs,
        deps = deps + [":" + name],
        module_name = test_lib_name,
        visibility = ["//visibility:private"],
    )

    ios_unit_test(
        name = name + "Tests",
        deps = [test_lib_name],
        minimum_os_version = MINIMUM_OS_VERSION,
        visibility = visibility,
    )

def first_party_library(
    name,
    deps = [],
    test_deps = [],
    swift_compiler_flags = [],
    swift_version = SWIFT_VERSION,
    visibility = ["//visibility:public"],
    ):

    native.filegroup(
        name = "Resources",
        srcs = native.glob(["Resources/**/*"]),
        visibility = ["//visibility:public"],
    )
    
    swift_unit_test(
        name = name,
        srcs = native.glob(["Tests/**/*.swift"]),
        deps = test_deps,
    )

    swift_library(
        name = name,
        module_name = name,
        srcs = native.glob(["Sources/**/*.swift"]),
        deps = deps,
        copts = swift_compiler_flags + swift_library_compiler_flags() + ["-swift-version", swift_version],
        data = [":Resources"],
        visibility = visibility,
    )


def application(
    name,
    infoplist,
    deps = [],
    test_deps = [],
    app_icons = [],
    resources = [],
    swift_version = SWIFT_VERSION,
    ):

    first_party_library(
        name = name + "Lib",
        deps = deps,
        test_deps = test_deps,
        swift_version = swift_version,
    )

    ios_application(
        name = name,
        bundle_id = PRODUCT_BUNDLE_IDENTIFIER_PREFIX + name,
        families = [
            "iphone",
        ],
        app_icons = app_icons,
        resources = resources,
        infoplists = [infoplist],
        minimum_os_version = MINIMUM_OS_VERSION,
        deps = deps + [":" + name + "Lib"],
    )
