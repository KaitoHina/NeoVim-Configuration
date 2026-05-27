# Neovim Config (lazy.nvim)

一套基於 lazy.nvim 打造的現代化 Neovim 配置，支援 LSP（Java, Python, TS 等等），並**預設啟用 Nerd Font 圖示**。

## 🚀 Installation (安裝)

```bash
# 備份舊的設定
mv ~/.config/nvim ~/.config/nvim.bak

# 清除舊的設定
rm -rf ~/.config/nvim
rm -rf ~/.local/share/nvim
rm -rf ~/.local/state/nvim
rm -rf ~/.cache/nvim   # optional

# 複製此儲存庫
git clone https://github.com/your-username/your-repo.git ~/.config/nvim

# 啟動 Neovim – 插件將自動安裝
nvim

# 確保已安裝 Nerd Font 並在終端機中使用該字體
brew install --cask font-hack-nerd-font
```

## ⚠️ Important Notes (重要注意事項)

- **圖示 (Icons):** 所有 UI (lualine, bufferline, nvim-tree) 皆已預設強制啟用圖示，無需另外設定變數。請務必安裝 Nerd Fonts。
- **Java:** Java 專案應為基於 Maven/Gradle 的專案 (含有 `pom.xml` 或 `build.gradle`)。
- **外部依賴:** `ripgrep`, `fd`, `tree-sitter` – 透過 `brew` 安裝。
- **首次啟動:** 插件會自動安裝。如果安裝失敗，請執行 `:Lazy sync`。
- **Mason LSP 伺服器:** 其他語言伺服器請透過 `:Mason` 手動安裝。

---

# Neovim Plugins & Keymaps Guide (插件與快捷鍵指南)

本區塊提供 `lua/plugins` 目錄下已安裝之 Neovim 插件的概覽。

> **注意:** 你的 `<leader>` 鍵已映射為 *空白 (Space) 鍵*。

## Global

> 以下快捷鍵與特定插件無關，屬於 Neovim 全域配置。所有 `<leader>` 鍵均映射為 **空白鍵**。

### 1. Insert Mode

| 快捷鍵 | 功能 | 說明 |
|--------|------|------|
| `jk` | 退出插入模式 | 取代 `Esc`，手指不離開主鍵盤區 |
| `Ctrl s` | 儲存目前檔案 | 方便在插入模式下快速儲存 |
| `Shift Tab` | 向左縮排 | 快速調整縮排排版 |

### 2. Normal Mode

| 快捷鍵 | 功能 | 說明 |
|--------|------|------|
| `Ctrl s` | 儲存目前檔案 | |
| `<leader>nh` | 取消搜尋高亮 | 清除 `/` 或 `?` 搜尋後的高亮標記 |
| `Ctrl h` | 切換到上一個 Buffer | 類似瀏覽器標籤頁的左側切換 |
| `Ctrl l` | 切換到下一個 Buffer | 類似瀏覽器標籤頁的右側切換 |
| `Tab` | 向右縮排 | 保留原始排版快速縮排 |
| `Shift Tab` | 向左縮排 | 保留原始排版快速縮排 |

### 3. Visual Mode

| 快捷鍵 | 功能 | 說明 |
|--------|------|------|
| `J` | 將選取行向下移動一行 | 保持視覺模式，可連續移動 |
| `K` | 將選取行向上移動一行 | 保持視覺模式，可連續移動 |
| `Tab` | 向右縮排 | 視覺模式下快速向右縮排，並保持選中狀態 |
| `Shift Tab` | 向左縮排 | 視覺模式下快速向左縮排，並保持選中狀態 |

### 4. Window Management（視窗管理）

> 所有視窗快速鍵均在正常模式下生效。

| 快捷鍵 | 功能 | 備註 |
|--------|------|------|
| `<leader>sv` | 水平新增視窗 | (Vertical Split) 左右並排兩個視窗 |
| `<leader>sh` | 垂直新增視窗 | (Horizontal Split) 上下堆疊兩個視窗 |
| `<leader>h` | 跳轉到左側視窗 | |
| `<leader>j` | 跳轉到下方視窗 | |
| `<leader>k` | 跳轉到上方視窗 | |
| `<leader>l` | 跳轉到右側視窗 | |

---

### 5. 其他通用操作

| 操作 | 說明 |
|------|------|
| `:w` 或 `Ctrl s` | 儲存檔案 |
| `:q` | 關閉目前視窗 |
| `:qa` | 退出 Neovim |
| `:e <filename>` | 開啟檔案 |
| `<leader>t` | 打開底部終端機 | 
| `Ctrl l Ctrl l` | (在終端模式下) 清空終端畫面 |

## 🧭 Navigation & UI (檔案與視覺導航)

### 1. Nvim-Tree (`nvim-tree.lua`)
Neovim 的檔案總管樹狀視圖。

| 快捷鍵 | 功能 |
|--------|------|
| `<leader>e` | 開啟或關閉檔案總管側邊欄 |
| `<leader>[` | 將目前目錄的父目錄設為根目錄 |
| `<leader>]` | 將遊標所在目錄設為根目錄 |

### 2. Telescope (`telescope.lua`)
高度可擴展且極速的模糊搜尋工具。

| 快捷鍵 | 功能 |
|--------|------|
| `<leader>ff` | 尋找檔案 (Find Files) |
| `<leader>fg` | 全局搜尋 (Live Grep) |
| `<leader>fw` | 搜尋游標所在單字 (Grep String) |
| `<leader>f/` | 在目前 Buffer 中搜尋 (Current Buffer Fuzzy Find) |
| `<leader>fd` | 尋找診斷訊息 (Diagnostics) |
| `<leader>fr` | 恢復上一次的搜尋 (Resume) |
| `<leader>f.` | 尋找最近開啟過的檔案 (Oldfiles) |
| `<leader>fb` | 尋找已開啟的 Buffer |

### 3. Bufferline (`bufferline.lua`)
在編輯器頂部提供美觀的 Buffer 標籤頁。

| 快捷鍵 | 功能 |
|--------|------|
| `Ctrl l` | 切換到下一個 Buffer (右側標籤) |
| `Ctrl h` | 切換到上一個 Buffer (左側標籤) |

### 4. Lualine (`lualine.lua`) & Theme (`theme.lua`)
- **Lualine**: 提供底部快速且高度可自訂的狀態列。
- **Theme**: 管理色彩主題。(自動生效)

### 5. Which-Key (`whichkey.lua`)
顯示目前可用快捷鍵與分組提示，讓 `<leader>` 指令更容易記憶與探索。

| 快捷鍵 | 功能 |
|--------|------|
| `<leader>?` | 顯示目前 buffer 可用的 keymaps |

> `which-key` 也會自動整理這些分組提示：`<leader>/`, `<leader>c`, `<leader>d`, `<leader>e`, `<leader>f`, `<leader>g`, `<leader>J`, `<leader>C`, `<leader>w`。

## ⌨️ Coding & Intellisense (程式碼編寫與智慧提示)

### 1. Nvim-Cmp (`cmp.lua`)
Neovim 的代碼補全引擎。

| 快捷鍵 | 功能 |
|--------|------|
| `Tab` | 在補全選單中移動到下一個項目 |
| `Shift Tab` | 在補全選單中移動到上一個項目 |
| `Enter` | 確認選取的補全項目 |
| `Ctrl e` | 取消補全 |
| `Ctrl f` | 補全說明浮窗向下捲動 |
| `Ctrl b` | 補全說明浮窗向上捲動 |

### 2. LSP & Mason (`lspconfig.lua`, `mason.lua`)
整合語言伺服器協定 (LSP)，提供類似 IDE 的功能。

| 快捷鍵 | 功能 |
|--------|------|
| `<leader>cd`| 前往定義 (Go to Definition) |
| `<leader>cD`| 前往宣告 (Go to Declaration) |
| `<leader>cR`| 重新命名變數 (Rename) |
| `<leader>ca`| 程式碼動作 (Code Actions) |
| `<leader>cf`| 格式化檔案 (Format) |
| `<leader>cr`| 列出所有引用 (References) |
| `<leader>ci`| 列出所有實作 (Implementations) |
| `<leader>lr`| 重啟 LSP |
| `<leader>d` | 顯示行內診斷訊息 (Line Diagnostics) |
| `[ d` / `]d` | 移至上一個/下一個診斷訊息 ( Prev/Next Diagnostic ) |

### 3. Pretty Hover (`prettyhover.lua`)
美化 LSP 的懸浮視窗。

| 快捷鍵 | 功能 |
|--------|------|
| `<leader>ch` | 顯示美化後的懸浮提示 (Hover/說明文件) |
| `<leader>K`  | 顯示預設懸浮提示 (Hover) |

### 4. Noice (`noice.lua`)
美化 Neovim 的通知系統。

| 快捷鍵 | 功能 |
|--------|------|
| `<leader>nn` | 查看歷史通知 (Noice History) |
| `<leader>nd` | 清除所有通知 (Dismiss All Notifications) |

### 5. Tree-sitter (`treesitter.lua`)
提供進階的語法高亮。(自動生效)

### 6. Toggleterm (`toggleterm.lua`)

| 快捷鍵 | 功能 |
|--------|------|
| `Ctrl \` | 開啟/關閉浮動終端機 |

## 🛠️ Editing Utilities (實用編輯輔助工具)

### 1. Autopairs (`autopairs.lua`)
自動補全括號與引號。(自動生效)

### 2. Comment (`comment.lua`)
輕鬆註解或取消註解程式碼。

| 快捷鍵 | 功能 |
|--------|------|
| `<leader>/` | 註解或取消註解目前行 |
| `<leader>/` | (在視覺模式) 註解或取消註解選取的區塊 |

### 3. Rainbow (`rainbow.lua`)
以不同顏色顯示嵌套的括號。(自動生效)

### 4. Todo-Comments (`todo-comments.lua`)
高亮顯示並集中管理程式碼中的註解標籤。

| 快捷鍵 | 功能 |
|--------|------|
| `]t` | 跳轉到檔案內的**下一個** TODO 標籤 |
| `[t` | 跳轉到檔案內的**上一個** TODO 標籤 |
| `<leader>ft` | 開啟 Telescope 搜尋專案內**所有的** TODO 標籤 |

## ☕ Development Tools (開發環境與工作流)

### 1. Gitsigns (`git.lua`)
在行號旁顯示 Git 差異標記 (`+`, `~`, `-`)。(自動生效)

### 2. Code Runner (`coderunner.lua`)
快速執行單一程式碼檔案。

| 快捷鍵 | 功能 |
|--------|------|
| `<leader>r` | 執行目前程式碼檔案 |

### 3. Java & Spring Boot Development (`jdtls.lua`, `springboot-nvim.lua`)
提供完整的 Java 開發與 Spring Boot 支援。

| 快捷鍵 (Java) | 功能 |
|---------------|------|
| `<leader>Jo` | 整理 Imports (Organize Imports) |
| `<leader>Jv` | 重構：提取變數 (Extract Variable) |
| `<leader>JC` | 重構：提取常量 (Extract Constant) |
| `<leader>Jt` | 執行目前游標下的測試方法 (Test Method) |
| `<leader>JT` | 執行目前測試類別 (Test Class) |
| `<leader>Ju` | 更新專案設定 (Update Config) |

| 快捷鍵 (Spring Boot) | 功能 |
|----------------------|------|
| `<leader>Jr` | 執行 Spring Boot 專案 |
| `<leader>Jc` | 建立 Java Class |
| `<leader>Ji` | 建立 Java Interface |
| `<leader>Je` | 建立 Java Enum |

### 4. Debugging (`nvim-dap.lua`)
基於 DAP 的程式除錯環境整合。

| 快捷鍵 | 功能 |
|--------|------|
| `<leader>dt` | 切換中斷點 (Toggle Breakpoint) |
| `<leader>ds` | 開始/繼續執行 (Start Debug / Continue) |
| `<leader>dc` | 關閉除錯介面 (Close UI) |
| `<leader>do` | 打開除錯介面 (Open UI) |
| `<leader>dT` | 切換除錯介面 (Toggle UI) |
| `<leader>dr` | 執行到游標處 (Run to Cursor) |
| `<leader>dq` | 強制終止除錯、關閉 UI 並清除相關的終端機 (Quit & Clean) |

### 5. CMake Tools (`cmake.lua`)
提供 C/C++ CMake 專案的 configure、build、run 與 debug 支援。

| 快捷鍵 | 功能 |
|--------|------|
| `<leader>Cg` | Configure / Generate CMake 專案並重新啟動 LSP |
| `<leader>Cb` | Build CMake 專案 |
| `<leader>CB` | Clean + Build |
| `<leader>Cc` | Clean CMake 專案 |
| `<leader>Ct` | 選擇 Build Type (Select Build Type) |
| `<leader>Cr` | Run 目前檔案對應的 CMake target |
| `<leader>Cq` | 快速執行 CMake target |
| `<leader>Cd` | Debug 目前檔案對應的 CMake target |

## 🚀 Neovim 啟動優化指南

1. 啟動 nvim 後輸入 `:Lazy`
2. 按 `shift + p` 查看 nvim 的啟動時間
3. 找出哪些插件啟動耗時較長
4. 設定插件僅在需要時啟動
