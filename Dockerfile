# Executer docker-compose up
FROM php:7.4-fpm

# Recuperer l'archive git
RUN curl -L https://github.com/do-community/travellist-laravel-demo/archive/tutorial-1.0.1.zip -o travellist.zip

# Mettre a jour le systeme
RUN apt update

# Installer unzip si ce n'est pas deja fait
RUN apt install unzip

# Unzip l'archive
RUN unzip travellist.zip

# Remplacer le dossier par un nom plus court
RUN mv travellist-laravel-demo-tutorial-1.0.1 travellist-demo

# Se deplacer dans ce dossier
RUN cd travellist-demo

# Arguments definis dans le docker-compose.yml
ARG user
ARG uid

# Installer les dependances du systeme
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

# Derniere version de composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Mettre en place le repertoire de travail
WORKDIR /var/www
# USER $user

# Supprimer le dockerignore
RUN rm -rf .dockerignore

# Nginx (remplacer le contenu manuellement du fichier "docker-compose/nginx/travellist.conf" par le fichier "nginx.conf")
RUN mkdir -p docker-compose/nginx
RUN touch docker-compose/nginx/travellist.conf

# Mysql (remplacer le contenu manuellement du fichier "docker-compose/mysql/init_db.sql" par le fichier "mysql.txt")
RUN mkdir docker-compose/mysql
RUN touch docker-compose/mysql/init_db.sql