# homebrew-qi

[奇语言 qilang](https://github.com/qilang-project/qi) 的 Homebrew tap。

```bash
brew install qilang-project/qi/qi
# 或
brew tap qilang-project/qi
brew install qi
```

装完直接可用（`qi` 自带静态运行时，无需环境变量）：

```bash
qi run 你的程序.qi
```

编译代码需系统 clang（macOS：`xcode-select --install`）。编译产物零运行时依赖。

Formula 由 [qi-installer/scripts/更新安装清单.sh](https://github.com/qilang-project/qi/blob/main/qi-installer/scripts/更新安装清单.sh) 随每次 release 自动更新。
