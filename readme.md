# Part-DB Docker 部署指南 🚀

這是一個 **基於 Docker 的 Part-DB 部署方案**，你可以使用 **Docker Compose** 來快速建置你的 Part-DB 伺服器，並輕鬆管理電子零件資料庫。

---

## 📌 **環境需求**
- Docker (推薦使用 [Docker Desktop](https://www.docker.com/get-started/))
- Docker Compose

---

## 📦 **如何安裝 Part-DB**
### 1️⃣ **下載專案**
請先 `git clone` 本專案，或將檔案下載到你的伺服器：
```sh
git clone https://github.com/oliver0804/partdb-docker.git
cd partdb-docker
```

### 2️⃣ **設定資料庫密碼**
請編輯 docker-compose.yml，找到 MySQL 設定 部分，修改：
```yaml
MYSQL_ROOT_PASSWORD: YOUR_ROOT_PASSWORD
MYSQL_PASSWORD: YOUR_DATABASE_PASSWORD
DATABASE_URL: mysql://partdb:YOUR_DATABASE_PASSWORD@database:3306/partdb
```

請確保 MYSQL_PASSWORD 和 DATABASE_URL 的密碼一致。

### 🚀 **啟動 Part-DB**
啟動 Part-DB 只需要執行：
```sh
docker-compose up -d --build
```

這會：
✅ 自動建置 Part-DB
✅ 下載並啟動 MySQL
✅ 安裝所有依賴並執行資料庫遷移
✅ 啟動 Apache Web 伺服器

成功後，你可以在瀏覽器輸入：
```
http://localhost:8080
```

### 🔑 **預設帳號**
- 使用者名稱：admin
- 密碼：啟動時會顯示在 docker logs partdb

如需查看密碼：
```sh
docker logs partdb | grep "password"
```

---

## 🔄 **更新 Part-DB**
如果想更新到最新版，只需執行：
```sh
docker-compose down
docker-compose up -d --build
```

---

## ❌ **停止 & 移除 Part-DB**
如果要暫時停止服務：
```sh
docker-compose down
```

如果要**完全移除資料庫與檔案**：
```sh
docker-compose down -v
rm -rf db mysql uploads public_media
```
⚠️ 注意：這會刪除所有資料！

---

## 🛠 **常見問題**

### 🔹 **無法登入？**
可能是 admin 密碼未顯示，請執行：
```sh
docker logs partdb | grep "password"
```

或重置密碼：
```sh
docker exec --user=www-data partdb php bin/console app:user:reset-password admin
```

### 🔹 **無法訪問 http://localhost:8080？**
請檢查容器狀態：
```sh
docker ps
```

如果 partdb 容器沒有運行，請查看日誌：
```sh
docker logs partdb
```

---

🎉 恭喜你！Part-DB 現在已經成功部署！




