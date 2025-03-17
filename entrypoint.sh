#!/bin/sh

# 等待 MySQL 啟動
if [ "$DATABASE_URL" != "sqlite:///%kernel.project_dir%/var/db/app.db" ]; then
    echo "⏳ 等待 MySQL 啟動..."
    until mysqladmin ping -h database --silent; do
        echo "⏳ 等待 MySQL..."
        sleep 5
    done
    echo "✅ MySQL 已啟動！"
fi

# 修正權限
echo "🔧 修正 var 目錄權限..."
chown -R www-data:www-data /var/www/html/var

# 自動執行資料庫遷移
echo "🚀 執行資料庫遷移..."
su - www-data -s /bin/sh -c 'php bin/console doctrine:migrations:migrate --no-interaction'

# 清除快取
echo "🗑️ 清除快取..."
su - www-data -s /bin/sh -c 'php bin/console cache:clear'

# 啟動 Apache
echo "🚀 啟動 Apache 伺服器..."
exec apache2-foreground

