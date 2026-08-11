# Homebrew Formula —— 奇语言 (qilang)
#
# 用法：
#   brew install --formula ./qi.rb          # 本地直接装
#   # 或建 tap 后：brew tap qilang-project/qi && brew install qi
#
# 说明：release 包是「原生二进制 + 静态 runtime」，解压即用。
#   编译产物零运行时依赖；qi 自身编译代码时需系统 clang（macOS 自带 Xcode CLT）。
#
# 每次发新版：跑 qi-installer/scripts/更新安装清单.sh <tag> 自动刷版本号与 sha256。
class Qi < Formula
  desc "奇语言 —— 100% 中文关键字的原生编译语言（LLVM 后端，AI 原语内置）"
  homepage "https://github.com/qilang-project/qi"
  version "2026.08.11-3"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/qilang-project/qi/releases/download/2026.08.11-3/qi-2026.08.11-3-macos-arm64.tar.gz"
      sha256 "68dac72673050e4467bc237f85d25669acdad24020727a14aa5e8adeba3a7e94"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/qilang-project/qi/releases/download/2026.08.11-3/qi-2026.08.11-3-linux-x64.tar.gz"
      sha256 "7e7503fa647dc88c56a9b0b2140ba2cbd154f22f782e8772c081ec540212ec2b"
    end
  end

  def install
    # release 包布局：bin/qi + lib/qi/（libqi_runtime.a + 捆绑动态库）
    # 装到 Homebrew prefix 后 bin 与 lib 同级，qi 按 <prefix>/lib/qi 自动找运行时库
    bin.install "bin/qi"
    (lib/"qi").install Dir["lib/qi/*"]
  end

  def caveats
    <<~EOS
      qi 编译代码时需要系统 clang 做链接：
        macOS：xcode-select --install
      编译产物（qi compile 出的可执行文件）零运行时依赖，可独立分发。
    EOS
  end

  test do
    (testpath/"你好.qi").write <<~QI
      包 主程序;
      导入 标准库.输入输出 作为 IO;
      函数 入口() { IO.打印行("brew ok"); }
    QI
    assert_match "brew ok", shell_output("#{bin}/qi run #{testpath}/你好.qi")
  end
end
