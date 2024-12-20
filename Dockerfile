FROM jenkins/jenkins:lts

USER root

# Устанавливаем Docker CLI
RUN apt-get update && apt-get install -y \
    lsb-release \
    curl \
    ca-certificates \
    && curl -fsSL https://download.docker.com/linux/debian/gpg | tee /usr/share/keyrings/docker-archive-keyring.asc \
    && echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.asc] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list \
    && apt-get update \
    && apt-get install -y docker-ce-cli \
    && rm -rf /var/lib/apt/lists/*

# Добавляем пользователя Jenkins в группу с ID 999
RUN groupadd -g 999 docker && usermod -aG docker jenkins

# Устанавливаем необходимые плагины Jenkins для работы с Docker
RUN jenkins-plugin-cli --plugins "docker-workflow"

# Переходим к пользователю Jenkins
USER jenkins
