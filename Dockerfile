# 檔名: Dockerfile (v1.1 更新版)

# --- 第一階段：基底 ---
FROM python:3.11-slim

# --- 第二階段：設定環境 ---
WORKDIR /app

# --- 第三階段：安裝系統依賴 (Chrome 瀏覽器) [核心修正點] ---
# 更新套件列表並安裝必要的工具 (ca-certificates, gnupg, wget)
RUN apt-get update && apt-get install -y \
    ca-certificates \
    gnupg \
    wget \
    # 建立存放金鑰的資料夾
    && install -m 0755 -d /etc/apt/keyrings \
    # 下載 Google 的安全金鑰，並存放到推薦的位置
    && wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | gpg --dearmor -o /etc/apt/keyrings/google-chrome.gpg \
    # 新增 Google Chrome 的軟體來源，並明確指定要用哪個金鑰驗證
    && echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/google-chrome.gpg] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list \
    # 再次更新套件列表，讓系統知道有 Chrome 可以安裝了
    && apt-get update \
    # 安裝 Google Chrome 穩定版
    && apt-get install -y google-chrome-stable \
    # 清理安裝快取，讓我們的映像檔小一點
    && rm -rf /var/lib/apt/lists/*

# --- 第四階段：安裝 Python 依賴 ---
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# --- 第五階段：複製我們的程式碼 ---
COPY *.py ./

# --- 第六階段：設定啟動指令 ---
CMD ["python", "run_all.py"]