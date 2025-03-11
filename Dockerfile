FROM python:3.11-alpine
ENV TZ=Asia/Shanghai
ENV LANG en_US.UTF-8

# 设置工作目录
WORKDIR /app
# 复制当前目录的文件到容器
COPY . /app

# 安装 Python 依赖
RUN pip install --no-cache-dir -r requirements.txt

# 添加 crontab 任务
RUN echo "10 9 * * * cd /app && python main.py" > /etc/crontabs/root

# 启动 cron 并保持前台运行
CMD ["crond", "-f", "-L", "/dev/stdout"]