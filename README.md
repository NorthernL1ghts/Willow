<div align="center">

<img src="Resources/Branding/LOGO.jpg" alt="Willow — stylized tree logo with circuit-like branches" width="520" />

# Willow

*The Willow programming language.*

<br />

[![C](https://img.shields.io/badge/language-C-00599C?style=flat-square&logo=c&logoColor=white)](https://en.wikipedia.org/wiki/C_%28programming_language%29)
[![Windows](https://img.shields.io/badge/Windows-0078D6?style=flat-square&logo=windows&logoColor=white)](https://www.microsoft.com/windows)
[![Linux](https://img.shields.io/badge/Linux-FCC624?style=flat-square&logo=linux&logoColor=black)](https://kernel.org)
[![x86_64](https://img.shields.io/badge/target-x86__64-4a5568?style=flat-square)](https://en.wikipedia.org/wiki/X86-64)

</div>

<br />

## Overview

Willow is a small language project: the goal is to **build a compiler** in **C** for **Windows** and **Linux** on **x86_64**. There is no big roadmap yet—it is an experiment because it sounds like a good time.

A sample program that is intended to be **valid Willow** once the toolchain exists lives in **[`Examples/Example.wil`](Examples/Example.wil)**.

---

## Usage

Run the executable from a shell. Pass a single argument: the path to a Willow source file.

---

## Building

**Prerequisites**

- [CMake](https://cmake.org/) 3.14 or newer
- A C compiler—we develop and test with [GCC](https://gcc.gnu.org/) (GNU Compiler Collection), but any capable C toolchain should work

**Steps**

1. Configure a build directory:

   ```bash
   cmake -B build
   ```

2. Compile:

   ```bash
   cmake --build build
   ```

The resulting executable will be produced under the build tree (exact path depends on your generator and platform).
