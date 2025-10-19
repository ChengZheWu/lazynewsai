# --- 第一階段：基底 ---
# 使用官方的 Python 3.11 輕量版作為我們的基礎環境
FROM python:3.11-slim

# --- 第二階段：設定環境 ---
# 設定工作目錄，之後的指令都會在這個資料夾內執行
WORKDIR /app

# --- 第三階段：安裝系統依賴 (Chrome 瀏覽器) ---
# 因為 Selenium 需要一個真的瀏覽器，我們要在這個 Linux 環境中安裝 Chrome
# 更新套件列表並安裝必要的工具
RUN apt-get update && apt-get install -y \
    wget \
    gnupg \
    # 安裝 Google Chrome
    && wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list' \
    && apt-get update \
    && apt-get install -y google-chrome-stable \
    # 清理安裝快取，讓我們的映像檔小一點
    && rm -rf /var/lib/apt/lists/*

# --- 第四階段：安裝 Python 依賴 ---
# 先將需求清單複製進來
COPY requirements.txt .
# 執行 pip install，安裝所有我們需要的 Python 函式庫
RUN pip install --no-cache-dir -r requirements.txt

# --- 第五階段：複製我們的程式碼 ---
# 將資料夾裡所有的 .py 檔案複製到貨櫃的 /app 資料夾中
COPY *.py ./

# --- 第六階段：設定啟動指令 ---
# 設定當這個貨櫃啟動時，預設要執行的指令
# 在這裡，我們執行之前建立的「總指揮」run_all.py
CMD ["python", "run_all.py"]