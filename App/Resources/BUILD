licenses(["notice"])

filegroup(
    name = "AppIcon",
    srcs = select({
        "//config:develop": glob(["Assets.xcassets/AppIcon-Dev.appiconset/**"]),
        "//config:production": glob(["Assets.xcassets/AppIcon.appiconset/**"]),
        "//conditions:default": glob(["Assets.xcassets/AppIcon.appiconset/**"]),
    }),
    visibility = ["//visibility:public"],
)

filegroup(
    name = "Assets",
    srcs = glob([
        "**/*",
    ],
    exclude = [
        "Assets.xcassets/*.appiconset/**",
    ]),
    visibility = ["//visibility:public"],
)