# C++ Development Setup for Neovim

This configuration adds comprehensive C++ development support to your Neovim setup, inspired by modern IDE features.

## Features Added

### 1. Language Server (LSP) - `clangd`
- **Intelligent code completion** with detailed function signatures
- **Go to definition/declaration** (`<leader>gd`)
- **Find references** (`<leader>gr`)
- **Hover documentation** (`K`)
- **Code actions** (`<leader>ca`)
- **Automatic header insertion** (IWYU style)
- **Clang-tidy integration** for linting

### 2. Debugging - `codelldb`
- **Visual debugging interface** (nvim-dap-ui)
- **Inline variable values** while debugging (nvim-dap-virtual-text)
- **VSCode launch.json support** for project-specific debug configs
- **Attach to running process** capability

#### Debug Keymaps
- `<Leader>dt` - Toggle breakpoint
- `<Leader>dc` - Continue/Start debugging
- `<Leader>dso` - Step over
- `<Leader>dsi` - Step into
- `<Leader>dsx` - Step out
- `<Leader>dr` - Open REPL
- `<Leader>dl` - Run last debug configuration
- `<Leader>dx` - Terminate debugging

### 3. Formatting - `clang-format`
- **Auto-format on save** (respects `.clang-format` file)
- **Manual format** with `<leader>cf`
- **Fallback to LLVM style** if no `.clang-format` found

### 4. CMake Integration
- **CMake LSP** (neocmake) for CMakeLists.txt editing
- **Build/Run/Debug** directly from Neovim
- **Target selection** for multi-target projects
- **Build type switching** (Debug/Release/etc.)

#### CMake Keymaps
- `<leader>cg` - CMake Generate (configure)
- `<leader>cb` - CMake Build
- `<leader>cr` - CMake Run
- `<leader>cd` - CMake Debug
- `<leader>cs` - CMake Select Build Type
- `<leader>ct` - CMake Select Build Target
- `<leader>cc` - CMake Close output
- `<leader>cC` - CMake Clean

### 5. Task Runner - Overseer
- **VSCode tasks.json support** for build automation
- **Pre-launch tasks** before debugging
- **Custom build commands** per project

#### Overseer Keymaps
- `<leader>or` - Run task
- `<leader>ot` - Toggle task list
- `<leader>oa` - Task action
- `<leader>oi` - Overseer info

## Installation

### System Dependencies

Install these tools on your system:

```bash
# On Ubuntu/Debian
sudo apt install clang clangd clang-format cmake gdb

# On Arch Linux
sudo pacman -S clang cmake gdb

# On macOS
brew install llvm cmake
```

### Neovim Plugins

The configuration will automatically install these via Mason:
- `clangd` (C++ LSP)
- `neocmake` (CMake LSP)
- `codelldb` (Debugger adapter)
- `clang-format` (Code formatter)

After updating your config, run:
```vim
:Lazy sync
:MasonInstall clangd neocmake codelldb clang-format
```

## Project Setup

### For Simple C++ Projects

1. **Create `.vscode` directory** in your project root
2. **Copy example configs**:
   ```bash
   cp examples/vscode-cpp/launch.json .vscode/
   cp examples/vscode-cpp/tasks.json .vscode/
   cp examples/vscode-cpp/.clang-format .
   ```
3. **Adjust paths** in the JSON files to match your project structure

### For CMake Projects

1. **Generate compile_commands.json** (required for clangd):
   ```bash
   cmake -B build -DCMAKE_EXPORT_COMPILE_COMMANDS=1
   ln -s build/compile_commands.json .
   ```
2. **Use CMake commands** from Neovim:
   - `<leader>cg` to generate/configure
   - `<leader>cb` to build
   - `<leader>cd` to debug

### Competitive Programming Setup

For single-file C++ programs (like competitive programming):

1. **Create build directory**: `mkdir build`
2. **Use the default debug config** - it will prompt for the executable path
3. **Or set up tasks.json** for quick compilation

Example workflow:
1. Write your solution in `main.cpp`
2. Press `<leader>or` and select "build-cpp" task
3. Press `<leader>dc` to start debugging
4. Input will be handled via stdio (codelldb feature)

## Usage Tips

### Clangd Configuration

Clangd uses `compile_commands.json` to understand your project. Generate it with:
- **CMake**: `-DCMAKE_EXPORT_COMPILE_COMMANDS=1`
- **Make**: Use [Bear](https://github.com/rizsotto/Bear)
- **Manual**: Create a `.clangd` config file

### Format Configuration

Place `.clang-format` in your project root to define formatting style. Example included.

### Debug Configuration

The `launch.json` supports variables:
- `${workspaceFolder}` - Project root
- `${file}` - Current file path
- `${fileBasenameNoExtension}` - Current filename without extension
- `${command:pickProcess}` - Interactive process picker

### Build Tasks

The `tasks.json` can define:
- **Compilation commands** (clang++, g++)
- **CMake builds**
- **Test runners**
- **Clean commands**

Tasks marked as `"preLaunchTask"` in launch.json run before debugging.

## Troubleshooting

### Clangd not working
- Ensure `compile_commands.json` exists in project root or build folder
- Check `:LspInfo` to see if clangd attached
- Restart LSP: `:LspRestart`

### Debugger not starting
- Verify executable path is correct
- Check executable has debug symbols (`-g` flag)
- Ensure codelldb is installed: `:Mason`

### Formatting not working
- Install clang-format: `:Mason`
- Check file type: `:set filetype?` (should be `cpp` or `c`)
- Manual format: `<leader>cf`

## References

- Inspired by: https://igorlfs.github.io/neovim-cpp-dbg
- Clangd docs: https://clangd.llvm.org/
- nvim-dap docs: https://github.com/mfussenegger/nvim-dap
- CMake tools: https://github.com/Civitasv/cmake-tools.nvim
