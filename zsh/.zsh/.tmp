#!/usr/bin/env bash
# new-cpp-project.sh — scaffold a modern C++23 project.
#
# Usage:  ./new-cpp-project.sh <project-name> [target-dir]
#
# Generates: CMake (presets) + Conan 2 + Ninja/mold + GoogleTest + Benchmark
#            + clang-format + clang-tidy + pre-commit + sanitizer presets
#            + Doxygen + GitHub Actions CI (gcc & clang, debug/release/asan/ubsan)
#            + a tiny working lib + app + test so you can build immediately.
#
# After:   cd <project> && conan install . -s build_type=Debug --build=missing \
#          && cmake --preset debug && cmake --build --preset debug \
#          && ctest --preset debug

set -euo pipefail

PROJECT_NAME="${1:-}"
TARGET_DIR="${2:-.}"

if [[ -z "$PROJECT_NAME" ]]; then
  echo "usage: $0 <project-name> [target-dir]" >&2
  exit 1
fi

# project name sanity: lowercase, letters/digits/dash/underscore
if ! [[ "$PROJECT_NAME" =~ ^[a-z][a-z0-9_-]*$ ]]; then
  echo "error: project name must be lowercase, start with a letter, and" >&2
  echo "       contain only [a-z0-9_-]." >&2
  exit 1
fi

ROOT="$TARGET_DIR/$PROJECT_NAME"
if [[ -e "$ROOT" ]]; then
  echo "error: '$ROOT' already exists; refusing to overwrite." >&2
  exit 1
fi

# A C-identifier form of the project name for CMake/C++ symbols:
#   my-cool-lib  ->  my_cool_lib
NS="${PROJECT_NAME//-/_}"
NS_UPPER="$(echo "$NS" | tr '[:lower:]' '[:upper:]')"

echo ">>> creating $ROOT"
mkdir -p "$ROOT"/{cmake,include/"$NS",src,apps,tests,benchmarks,examples,docs,scripts,.github/workflows}

# ---------------------------------------------------------------- .gitignore
cat > "$ROOT/.gitignore" <<'EOF'
# Build dirs
build/
build-*/
cmake-build-*/
out/
install/

# Conan
.conan2/
CMakeUserPresets.json
conan_toolchain.cmake
conandeps_legacy.cmake
conandata.yml.bak

# Editor / LSP
.cache/
compile_commands.json
.vscode/
.idea/
*.swp
*.swo
.DS_Store

# Doxygen output
docs/html/
docs/xml/
docs/latex/

# Coverage
*.gcda
*.gcno
*.gcov
coverage/
EOF

# ---------------------------------------------------------------- .clang-format
cat > "$ROOT/.clang-format" <<'EOF'
---
Language: Cpp
BasedOnStyle: Google
Standard: c++20

ColumnLimit: 100
IndentWidth: 4
TabWidth: 4
UseTab: Never

AccessModifierOffset: -4
AlignAfterOpenBracket: Align
AllowShortFunctionsOnASingleLine: Inline
AllowShortIfStatementsOnASingleLine: Never
AllowShortLoopsOnASingleLine: false
BinPackArguments: false
BinPackParameters: false
BreakBeforeBraces: Attach
BreakConstructorInitializers: BeforeColon
ConstructorInitializerIndentWidth: 4
Cpp11BracedListStyle: true
EmptyLineBeforeAccessModifier: LogicalBlock
FixNamespaceComments: true
IncludeBlocks: Regroup
IndentCaseLabels: false
IndentPPDirectives: AfterHash
NamespaceIndentation: None
PointerAlignment: Left
QualifierAlignment: Left
ReflowComments: true
SeparateDefinitionBlocks: Always
SortIncludes: CaseSensitive
SortUsingDeclarations: true
SpaceAfterCStyleCast: false
SpaceAfterTemplateKeyword: false
SpaceBeforeAssignmentOperators: true
SpaceBeforeCpp11BracedList: false
SpaceBeforeParens: ControlStatements
SpacesInContainerLiterals: false
EOF

# ---------------------------------------------------------------- .clang-tidy
cat > "$ROOT/.clang-tidy" <<'EOF'
---
# Start strict; disable only with a reason. Add/remove over time.
Checks: >
  bugprone-*,
  cert-*,
  clang-analyzer-*,
  concurrency-*,
  cppcoreguidelines-*,
  hicpp-*,
  misc-*,
  modernize-*,
  performance-*,
  portability-*,
  readability-*,
  -bugprone-easily-swappable-parameters,
  -cppcoreguidelines-avoid-magic-numbers,
  -cppcoreguidelines-pro-bounds-pointer-arithmetic,
  -cppcoreguidelines-pro-bounds-array-to-pointer-decay,
  -hicpp-no-array-decay,
  -misc-non-private-member-variables-in-classes,
  -misc-include-cleaner,
  -modernize-use-trailing-return-type,
  -readability-magic-numbers,
  -readability-identifier-length

WarningsAsErrors: ''
HeaderFilterRegex: '.*'
FormatStyle: file

CheckOptions:
  - key: readability-identifier-naming.NamespaceCase
    value: lower_case
  - key: readability-identifier-naming.ClassCase
    value: CamelCase
  - key: readability-identifier-naming.StructCase
    value: CamelCase
  - key: readability-identifier-naming.FunctionCase
    value: lower_case
  - key: readability-identifier-naming.VariableCase
    value: lower_case
  - key: readability-identifier-naming.PrivateMemberSuffix
    value: _
  - key: readability-identifier-naming.ConstantCase
    value: lower_case
  - key: readability-identifier-naming.MacroDefinitionCase
    value: UPPER_CASE
EOF

# ---------------------------------------------------------------- CMakeLists
cat > "$ROOT/CMakeLists.txt" <<EOF
cmake_minimum_required(VERSION 3.28)
project($NS
    VERSION 0.1.0
    DESCRIPTION "$PROJECT_NAME"
    LANGUAGES CXX
)

# --- Global settings ---------------------------------------------------------
set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)  # for clangd

# Default build type if someone forgets a preset
if(NOT CMAKE_BUILD_TYPE AND NOT CMAKE_CONFIGURATION_TYPES)
    set(CMAKE_BUILD_TYPE RelWithDebInfo CACHE STRING "" FORCE)
endif()

list(APPEND CMAKE_MODULE_PATH \${CMAKE_SOURCE_DIR}/cmake)
include(Warnings)
include(Sanitizers)

# --- Options -----------------------------------------------------------------
option(${NS_UPPER}_BUILD_TESTS      "Build unit tests"          ON)
option(${NS_UPPER}_BUILD_BENCHMARKS "Build benchmarks"          OFF)
option(${NS_UPPER}_BUILD_EXAMPLES   "Build examples"            OFF)
option(${NS_UPPER}_BUILD_DOCS       "Build Doxygen docs target" OFF)

# --- Dependencies (Conan provides these) ------------------------------------
find_package(spdlog REQUIRED)

# --- Library ----------------------------------------------------------------
add_subdirectory(src)

# --- Executables ------------------------------------------------------------
add_subdirectory(apps)

# --- Tests ------------------------------------------------------------------
if(${NS_UPPER}_BUILD_TESTS)
    enable_testing()
    add_subdirectory(tests)
endif()

if(${NS_UPPER}_BUILD_BENCHMARKS)
    add_subdirectory(benchmarks)
endif()

if(${NS_UPPER}_BUILD_EXAMPLES)
    add_subdirectory(examples)
endif()

if(${NS_UPPER}_BUILD_DOCS)
    add_subdirectory(docs)
endif()
EOF

# ---------------------------------------------------------------- cmake/Warnings.cmake
cat > "$ROOT/cmake/Warnings.cmake" <<'EOF'
# Common warnings target. Link PRIVATE to any target you own.
# Usage:  target_link_libraries(mylib PRIVATE project_warnings)
add_library(project_warnings INTERFACE)

if(CMAKE_CXX_COMPILER_ID MATCHES "GNU|Clang")
    target_compile_options(project_warnings INTERFACE
        -Wall
        -Wextra
        -Wpedantic
        -Wshadow
        -Wnon-virtual-dtor
        -Wold-style-cast
        -Wcast-align
        -Wunused
        -Woverloaded-virtual
        -Wconversion
        -Wsign-conversion
        -Wnull-dereference
        -Wdouble-promotion
        -Wformat=2
        -Wimplicit-fallthrough
    )
    if(CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
        target_compile_options(project_warnings INTERFACE
            -Wmisleading-indentation
            -Wduplicated-cond
            -Wduplicated-branches
            -Wlogical-op
            -Wuseless-cast
        )
    endif()
endif()
EOF

# ---------------------------------------------------------------- cmake/Sanitizers.cmake
cat > "$ROOT/cmake/Sanitizers.cmake" <<'EOF'
# Sanitizers come in through presets; this module just exposes an INTERFACE
# target you can link to selectively.
add_library(project_sanitizers INTERFACE)

set(_san "${ENABLE_SANITIZER}")
if(_san)
    if(_san STREQUAL "address")
        target_compile_options(project_sanitizers INTERFACE
            -fsanitize=address -fno-omit-frame-pointer -g)
        target_link_options(project_sanitizers INTERFACE -fsanitize=address)
    elseif(_san STREQUAL "undefined")
        target_compile_options(project_sanitizers INTERFACE
            -fsanitize=undefined -fno-omit-frame-pointer -g)
        target_link_options(project_sanitizers INTERFACE -fsanitize=undefined)
    elseif(_san STREQUAL "thread")
        target_compile_options(project_sanitizers INTERFACE
            -fsanitize=thread -fno-omit-frame-pointer -g)
        target_link_options(project_sanitizers INTERFACE -fsanitize=thread)
    elseif(_san STREQUAL "address+undefined")
        target_compile_options(project_sanitizers INTERFACE
            -fsanitize=address,undefined -fno-omit-frame-pointer -g)
        target_link_options(project_sanitizers INTERFACE
            -fsanitize=address,undefined)
    endif()
endif()
EOF

# ---------------------------------------------------------------- CMakePresets.json
cat > "$ROOT/CMakePresets.json" <<EOF
{
    "version": 6,
    "cmakeMinimumRequired": { "major": 3, "minor": 28, "patch": 0 },
    "configurePresets": [
        {
            "name": "base",
            "hidden": true,
            "generator": "Ninja",
            "binaryDir": "\${sourceDir}/build/\${presetName}",
            "cacheVariables": {
                "CMAKE_EXPORT_COMPILE_COMMANDS": "ON",
                "CMAKE_TOOLCHAIN_FILE": "\${sourceDir}/build/\${presetName}/generators/conan_toolchain.cmake"
            }
        },
        {
            "name": "debug",
            "inherits": "base",
            "cacheVariables": { "CMAKE_BUILD_TYPE": "Debug" }
        },
        {
            "name": "release",
            "inherits": "base",
            "cacheVariables": { "CMAKE_BUILD_TYPE": "Release" }
        },
        {
            "name": "relwithdebinfo",
            "inherits": "base",
            "cacheVariables": { "CMAKE_BUILD_TYPE": "RelWithDebInfo" }
        },
        {
            "name": "asan",
            "inherits": "base",
            "cacheVariables": {
                "CMAKE_BUILD_TYPE": "Debug",
                "ENABLE_SANITIZER": "address+undefined"
            }
        },
        {
            "name": "tsan",
            "inherits": "base",
            "cacheVariables": {
                "CMAKE_BUILD_TYPE": "Debug",
                "ENABLE_SANITIZER": "thread"
            }
        }
    ],
    "buildPresets": [
        { "name": "debug",          "configurePreset": "debug" },
        { "name": "release",        "configurePreset": "release" },
        { "name": "relwithdebinfo", "configurePreset": "relwithdebinfo" },
        { "name": "asan",           "configurePreset": "asan" },
        { "name": "tsan",           "configurePreset": "tsan" }
    ],
    "testPresets": [
        { "name": "debug",   "configurePreset": "debug",   "output": { "outputOnFailure": true } },
        { "name": "release", "configurePreset": "release", "output": { "outputOnFailure": true } },
        { "name": "asan",    "configurePreset": "asan",    "output": { "outputOnFailure": true } },
        { "name": "tsan",    "configurePreset": "tsan",    "output": { "outputOnFailure": true } }
    ]
}
EOF

# ---------------------------------------------------------------- conanfile.py
cat > "$ROOT/conanfile.py" <<EOF
from conan import ConanFile
from conan.tools.cmake import CMakeToolchain, CMakeDeps, cmake_layout


class ${NS^}Recipe(ConanFile):
    name = "$NS"
    version = "0.1.0"
    settings = "os", "compiler", "build_type", "arch"

    # Add deps here as you need them. These are examples:
    def requirements(self):
        self.requires("spdlog/1.15.0")
        self.requires("fmt/11.0.2", override=True)
        if self.conf.get("user.${NS}:with_tests", default=True, check_type=bool):
            self.test_requires("gtest/1.15.0")
            self.test_requires("benchmark/1.9.0")

    def layout(self):
        cmake_layout(self)

    def generate(self):
        tc = CMakeToolchain(self)
        tc.user_presets_path = False  # don't overwrite your CMakePresets
        tc.generate()
        deps = CMakeDeps(self)
        deps.generate()
EOF

# ---------------------------------------------------------------- src tree
cat > "$ROOT/src/CMakeLists.txt" <<EOF
# The library target. Keep it a library and let apps/tests link it.
add_library(${NS}_lib
    greeter.cpp
)
add_library(${NS}::lib ALIAS ${NS}_lib)

target_include_directories(${NS}_lib
    PUBLIC
        \$<BUILD_INTERFACE:\${CMAKE_SOURCE_DIR}/include>
        \$<INSTALL_INTERFACE:include>
)

target_link_libraries(${NS}_lib
    PUBLIC
        spdlog::spdlog
    PRIVATE
        project_warnings
        project_sanitizers
)

target_compile_features(${NS}_lib PUBLIC cxx_std_23)
EOF

cat > "$ROOT/include/$NS/greeter.hpp" <<EOF
#pragma once

#include <string>
#include <string_view>

namespace ${NS} {

/// Returns a greeting for the given name.
///
/// Example:
/// \\code
/// auto msg = ${NS}::greet("world");  // "Hello, world!"
/// \\endcode
[[nodiscard]] std::string greet(std::string_view name);

}  // namespace ${NS}
EOF

cat > "$ROOT/src/greeter.cpp" <<EOF
#include "${NS}/greeter.hpp"

#include <spdlog/spdlog.h>

#include <format>

namespace ${NS} {

std::string greet(std::string_view name) {
    spdlog::debug("greet() called with name='{}'", name);
    return std::format("Hello, {}!", name);
}

}  // namespace ${NS}
EOF

# ---------------------------------------------------------------- apps
cat > "$ROOT/apps/CMakeLists.txt" <<EOF
add_executable(${NS} main.cpp)
target_link_libraries(${NS}
    PRIVATE
        ${NS}::lib
        project_warnings
        project_sanitizers
)
EOF

cat > "$ROOT/apps/main.cpp" <<EOF
#include "${NS}/greeter.hpp"

#include <spdlog/spdlog.h>

#include <iostream>
#include <string>

int main(int argc, char** argv) {
    spdlog::set_level(spdlog::level::info);
    const std::string name = (argc > 1) ? argv[1] : "world";
    std::cout << ${NS}::greet(name) << '\\n';
    return 0;
}
EOF

# ---------------------------------------------------------------- tests
cat > "$ROOT/tests/CMakeLists.txt" <<EOF
find_package(GTest REQUIRED)
include(GoogleTest)

add_executable(${NS}_tests
    test_greeter.cpp
)
target_link_libraries(${NS}_tests
    PRIVATE
        ${NS}::lib
        GTest::gtest
        GTest::gtest_main
        project_warnings
        project_sanitizers
)
gtest_discover_tests(${NS}_tests)
EOF

cat > "$ROOT/tests/test_greeter.cpp" <<EOF
#include "${NS}/greeter.hpp"

#include <gtest/gtest.h>

TEST(GreeterTest, GreetsAName) {
    EXPECT_EQ(${NS}::greet("world"), "Hello, world!");
}

TEST(GreeterTest, GreetsEmptyName) {
    EXPECT_EQ(${NS}::greet(""), "Hello, !");
}
EOF

# ---------------------------------------------------------------- benchmarks
cat > "$ROOT/benchmarks/CMakeLists.txt" <<EOF
find_package(benchmark REQUIRED)

add_executable(${NS}_bench bench_greeter.cpp)
target_link_libraries(${NS}_bench
    PRIVATE
        ${NS}::lib
        benchmark::benchmark
        benchmark::benchmark_main
        project_warnings
)
EOF

cat > "$ROOT/benchmarks/bench_greeter.cpp" <<EOF
#include "${NS}/greeter.hpp"

#include <benchmark/benchmark.h>

static void BM_Greet(benchmark::State& state) {
    for (auto _ : state) {
        auto s = ${NS}::greet("world");
        benchmark::DoNotOptimize(s);
    }
}
BENCHMARK(BM_Greet);

BENCHMARK_MAIN();
EOF

# ---------------------------------------------------------------- docs (Doxygen)
cat > "$ROOT/docs/CMakeLists.txt" <<EOF
find_package(Doxygen REQUIRED)

set(DOXYGEN_PROJECT_NAME        "${NS}")
set(DOXYGEN_PROJECT_BRIEF       "${PROJECT_NAME}")
set(DOXYGEN_OUTPUT_DIRECTORY    \${CMAKE_CURRENT_BINARY_DIR})
set(DOXYGEN_RECURSIVE           YES)
set(DOXYGEN_GENERATE_HTML       YES)
set(DOXYGEN_GENERATE_LATEX      NO)
set(DOXYGEN_EXTRACT_ALL         YES)
set(DOXYGEN_EXTRACT_PRIVATE     NO)
set(DOXYGEN_EXTRACT_STATIC      YES)
set(DOXYGEN_USE_MDFILE_AS_MAINPAGE \${CMAKE_SOURCE_DIR}/README.md)

doxygen_add_docs(docs
    \${CMAKE_SOURCE_DIR}/include
    \${CMAKE_SOURCE_DIR}/src
    \${CMAKE_SOURCE_DIR}/README.md
    COMMENT "Generating Doxygen HTML docs"
)
EOF

# ---------------------------------------------------------------- pre-commit
cat > "$ROOT/.pre-commit-config.yaml" <<'EOF'
repos:
  - repo: https://github.com/pre-commit/pre-commit-hooks
    rev: v5.0.0
    hooks:
      - id: trailing-whitespace
      - id: end-of-file-fixer
      - id: check-yaml
      - id: check-added-large-files

  - repo: https://github.com/pre-commit/mirrors-clang-format
    rev: v19.1.3
    hooks:
      - id: clang-format
        types_or: [c++, c]
EOF

# ---------------------------------------------------------------- GitHub Actions
cat > "$ROOT/.github/workflows/ci.yml" <<EOF
name: ci

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  build-and-test:
    runs-on: ubuntu-24.04
    strategy:
      fail-fast: false
      matrix:
        preset: [debug, release, asan]
        compiler: [gcc, clang]
    steps:
      - uses: actions/checkout@v4

      - name: Install build tools
        run: |
          sudo apt-get update
          sudo apt-get install -y ninja-build mold clang-19 clang-tidy-19 \\
              lld-19 pipx
          pipx install conan

      - name: Pick compiler
        run: |
          if [ "\${{ matrix.compiler }}" = "clang" ]; then
            echo "CC=clang-19"  >> \$GITHUB_ENV
            echo "CXX=clang++-19" >> \$GITHUB_ENV
          else
            echo "CC=gcc"  >> \$GITHUB_ENV
            echo "CXX=g++" >> \$GITHUB_ENV
          fi

      - name: Conan install
        run: |
          conan profile detect --force
          conan install . -s build_type=Debug --build=missing \\
              -of build/\${{ matrix.preset }}

      - name: Configure
        run: cmake --preset \${{ matrix.preset }}

      - name: Build
        run: cmake --build --preset \${{ matrix.preset }} -j

      - name: Test
        run: ctest --preset \${{ matrix.preset }}
EOF

# ---------------------------------------------------------------- README
cat > "$ROOT/README.md" <<EOF
# $PROJECT_NAME

> A C++23 project scaffolded with CMake + Conan 2 + Ninja + mold.

## Build

Requires: CMake >= 3.28, Conan 2, Ninja, a C++23 compiler (gcc 14+ or clang 18+).

\`\`\`bash
# 1. Install deps into the preset's build dir
conan install . -s build_type=Debug --build=missing -of build/debug

# 2. Configure + build
cmake --preset debug
cmake --build --preset debug -j

# 3. Run tests
ctest --preset debug

# 4. Run the app
./build/debug/apps/$NS world
\`\`\`

## Presets

| Preset           | What                                     |
|------------------|------------------------------------------|
| \`debug\`          | Debug, no sanitizer                      |
| \`release\`        | Release, no sanitizer                    |
| \`relwithdebinfo\` | Release + debug info (profile this one)  |
| \`asan\`           | Debug + AddressSanitizer + UBSan         |
| \`tsan\`           | Debug + ThreadSanitizer                  |

Build with \`cmake --build --preset <name>\`, test with \`ctest --preset <name>\`.

## Layout

- \`include/$NS/\` — public headers
- \`src/\`          — library implementation
- \`apps/\`         — executables
- \`tests/\`        — GoogleTest units
- \`benchmarks/\`   — Google Benchmark harnesses (opt-in: \`-D${NS_UPPER}_BUILD_BENCHMARKS=ON\`)
- \`cmake/\`        — reusable CMake modules
- \`docs/\`         — Doxygen target (opt-in: \`-D${NS_UPPER}_BUILD_DOCS=ON\`)
EOF

# ---------------------------------------------------------------- LICENSE (MIT)
cat > "$ROOT/LICENSE" <<EOF
MIT License

Copyright (c) $(date +%Y)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND.
EOF

# ---------------------------------------------------------------- helper scripts
cat > "$ROOT/scripts/format.sh" <<'EOF'
#!/usr/bin/env bash
# Format all tracked C/C++ files in place.
set -euo pipefail
cd "$(git rev-parse --show-toplevel)"
git ls-files '*.cpp' '*.hpp' '*.h' '*.cc' '*.cxx' \
    | xargs -r clang-format -i
EOF
chmod +x "$ROOT/scripts/format.sh"

cat > "$ROOT/scripts/tidy.sh" <<'EOF'
#!/usr/bin/env bash
# Run clang-tidy against the current build's compile_commands.json.
#   usage: scripts/tidy.sh [preset]   # preset defaults to 'debug'
set -euo pipefail
cd "$(git rev-parse --show-toplevel)"
PRESET="${1:-debug}"
BUILD_DIR="build/$PRESET"
if [[ ! -f "$BUILD_DIR/compile_commands.json" ]]; then
    echo "no compile_commands in $BUILD_DIR -- configure the preset first." >&2
    exit 1
fi
git ls-files 'src/*.cpp' 'apps/*.cpp' 'tests/*.cpp' \
    | xargs -r clang-tidy -p "$BUILD_DIR"
EOF
chmod +x "$ROOT/scripts/tidy.sh"

# ---------------------------------------------------------------- git init
if command -v git >/dev/null; then
    (cd "$ROOT" && git init -q -b main && git add . && \
        git -c user.email=you@example.com -c user.name=you \
            commit -q -m "chore: scaffold $PROJECT_NAME")
    echo ">>> initialized git repo on branch 'main' with one commit"
fi

echo
echo ">>> done. next steps:"
echo "    cd $ROOT"
echo "    conan install . -s build_type=Debug --build=missing -of build/debug"
echo "    cmake --preset debug"
echo "    cmake --build --preset debug -j"
echo "    ctest --preset debug"
echo "    ./build/debug/apps/$NS world"
