load(
    "//config:constants.bzl", 
    "SWIFT_DEBUG_COMPILER_FLAGS",
    "SWIFT_RELEASE_COMPILER_FLAGS",
    )

# This function switches the compiler flags according to the configuration
def swift_library_compiler_flags():
    return select({
        "//config:develop" : SWIFT_DEBUG_COMPILER_FLAGS,
        "//config:production" : SWIFT_RELEASE_COMPILER_FLAGS,
        "//conditions:default": SWIFT_DEBUG_COMPILER_FLAGS,
    })