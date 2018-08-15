FROM debian:jessie

ENV D_TIME_ZONE Europe/Moscow
ENV D_CODEPAGE UTF-8 
ENV D_LANG ru_RU

RUN apt-get update && apt-get -y install --no-install-recommends \
	locales \
	python3 \
	python3-pip \
	python3-sh \
	python3-jinja2 \
	python3-requests && \
pip3 install ldap3 docker-py python-consul && \
apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Set locale (fix the locale warnings)
RUN localedef -v -c -i ${D_LANG} -f ${D_CODEPAGE} ${D_LANG}.${D_CODEPAGE} || : && \
update-locale LANG=${D_LANG}.${D_CODEPAGE} && \
echo "${D_TIME_ZONE}" > /etc/timezone && dpkg-reconfigure --frontend noninteractive tzdata

ENV LC_ALL=${D_LANG}.${D_CODEPAGE}