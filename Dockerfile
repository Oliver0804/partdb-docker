# 使用官方 Part-DB 映像
FROM jbtronics/part-db1:latest

# 設定工作目錄
WORKDIR /var/www/html

# 確保 Composer 可用
RUN apt-get update && apt-get install -y composer unzip

# 啟用 Composer 允許 root 運行
ENV COMPOSER_ALLOW_SUPERUSER=1

# 允許 Composer 安裝插件
RUN composer config --global allow-plugins.symfony/flex true

# 安裝 Symfony Flex（這一步很重要）
RUN composer global require symfony/flex

# 確保 `symfony-cmd` 存在
RUN composer dump-autoload

# 安裝 PHP 依賴，確保 bin/console 存在
RUN composer install --no-interaction --no-dev --optimize-autoloader

# 修正權限
RUN chown -R www-data:www-data /var/www/html

# 預設啟動指令
CMD ["apache2-foreground"]

