# FROM -> indica la imagen basa
FROM ubuntu

# RUN -> Comandos a ejecutar
RUN apt-get update
RUN apt-get install -y python
RUN echo 3.0 >> /etc/version && apt-get install -y git \
&& apt-get install -y iputils-ping
RUN mkdir /datos

# WORKDIR -> Establece el directorio de trabajo
WORKDIR /datos

RUN touch f1.txt

RUN mkdir /datos1
WORKDIR /datos1
RUN touch f2.txt

# COPY Copia de host a contenedor
COPY index.html .
COPY app.log /datos

# ADD -> añade de host a container, como COPY, pero descomprime tar y trae desde URL
ADD docs docs
ADD f* /datos/
ADD f.tar . 
#Descomprime el tar


#ENV -> Variables de entorno
ENV dir=/data dir1=/data1
RUN mkdir $dir && mkdir $dir1

#ARG -> Variables como ENV, pero en el moimento de construir la imagen, puede no tener valor 
#ARG dir2
#RUN mkdir $dir2
#ARG user
#ENV user_docker $user
#ADD add_user.sh /datos1
#RUN /datos1/add_user.sh

RUN apt-get install -y apache2

#EXPOSE -> Expone puerto
EXPOSE 80

#VOLUME 
ADD paginas /var/www/html
VOLUME ["/var/www/html"]

ADD entrypoint.sh /datos1
# CMD -> Comando por defecto que se ejecutara en el contenedor, solo puede haber 1
#ENTRYPOINT -> Punto de entrada, instruccion que se ejecutara
# ENTRYPOINT ["/bin/bash"]
CMD /datos1/entrypoint.sh
