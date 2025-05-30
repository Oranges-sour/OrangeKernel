
# OrangeKernel

OrangeKernel 是一个基于 x86 架构的教学操作系统内核，采用 C 与汇编语言编写，旨在深入学习和实践操作系统底层原理。本项目参考自《Orange's 一个操作系统的实现》，并借助 Bochs 模拟器进行调试和运行。

## 项目特点

- 架构平台：`x86 (IA-32)`
- 开发语言：`C` 与 `x86 汇编`
- 调试工具：`Bochs` 模拟器
- 学习资源：《Orange's 一个操作系统的实现》
- 编译环境：GNU 工具链 (`GCC`, `NASM`, `Make`)

## 项目结构

```
OrangeKernel/
├── boot/            # 引导扇区相关汇编代码（如 MBR、loader）
├── kernel/          # 内核核心模块（中断、内存管理、任务调度等）
├── lib/             # 常用C库函数与汇编工具函数
├── include/         # 公共头文件
├── Makefile         # 主构建文件
└── README.md        # 项目说明文档
```

### 编译项目

```bash
make image
```

### 启动内核（Bochs）

```bash
bochs
或者：
bochsdbg
```

## 学习参考

本项目的代码与设计大量参考并实现自以下资源：

- 📘《Orange's 一个操作系统的实现》—— 于渊 著
- 🔧 [Bochs 文档](https://bochs.sourceforge.io/)

## 开发进度（部分示例）

- [x] 编写引导扇区（boot sector）
- [x] 实现 GDT 和 IDT 初始化
- [x] 设置中断处理机制
- [x] 实现简单内存管理
- [x] 完成系统调用接口
- [ ] TTY控制台
- [ ] 添加简易文件系统


## 许可

本项目为学习用途，代码版权归原书作者及贡献者所有。如引用或使用本项目代码，请注明来源。


