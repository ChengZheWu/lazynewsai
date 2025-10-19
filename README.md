# AI-Powered Automated Financial News Podcast (AI 財經新聞自動生成 Podcast)


這是一個全自動化的雲原生系統，旨在每日定時抓取台股 (TW) 與美股 (US) 的最新財經新聞，利用大型語言模型 (LLM) 進行深度分析與摘要，並透過文字轉語音 (TTS) 技術生成 Podcast 音檔，最終將文字報告與語音檔自動派送到指定信箱。

這不僅是一個 Side Project，更是一個結合了數據工程、MLOps、Serverless 架構與自動化流程的完整實戰紀錄。

## ✨ 核心功能 (Features)

- **🌍 多市場支援**：可參數化設定，同時支援台股 (`TW`) 與美股 (`US`) 的新聞處理流程。
- **🧠 AI 驅動分析**：使用 **Google Gemini API** 閱讀數十篇新聞，生成高品質、有觀點的市場摘要報告。
- **🗣️ 自動語音生成**：整合 **Azure AI Speech** 服務，將文字報告轉換為聲線自然流暢的 MP3 語音檔。
- **☁️ Serverless 架構**：整個運算核心部署在 **AWS Fargate** 上，無需管理任何伺服器，按需使用，成本效益極高。
- **⏰ 精準自動排程**：透過 **Amazon EventBridge Scheduler** 設定多個 Cron 排程，可在指定時區 (Asia/Taipei) 的特定時間點，觸發對應市場的任務。
- **⚙️ 高度自動化**：整合 **n8n** 建立視覺化工作流，自動從 S3 下載成品、打包並寄送 Email，實現端到端的自動化。
- **🛡️ 健壯性與監控**：整合 **Amazon CloudWatch** 進行日誌監控與警報，並在基礎設施層與應用層皆設計了重試機制，確保系統穩定運行。

## 🛠️ 技術棧 (Tech Stack)

| 類別 | 技術 |
| :--- | :--- |
| **核心程式** | Python |
| **網頁爬蟲** | Selenium, BeautifulSoup, requests |
| **資料庫** | SQLite (RDBMS) |
| **Local開發環境** | Python venv |
| **容器技術** | Docker |
| **雲端架構 (AWS)** | ECR, ECS Fargatre (severless), EventBridge, IAM, SNS, CloudWatch, S3, Boto3 |
| **AI** | Google Gemini API (分析), Azure AI Speech (語音), AI輔助開發 |
| **自動化流程** | n8n |
| **版本控制** | Git |

## 📈 未來展望 (Future Improvements)

- [ ] **Web 前端介面**: 建立一個簡單的 Web 介面來展示歷史報告與收聽 Podcast。
- [ ] **更進階的 AI 應用**: 嘗試不同的 LLM 或語音模型，或加入情緒分析、關鍵實體識別等功能。