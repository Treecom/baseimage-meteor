###
# From phusion/baseimage: https://github.com/phusion/baseimage-docker
# Look for newer releases: https://github.com/phusion/baseimage-docker/releases
###
FROM phusion/baseimage:0.10.1
LABEL name="baseimage-meteor" version="0.2.0"

# You can owerwrite ENVs from docker files or docker-compose
ENV ROOT_URL http://localhost/ \
  PORT 3000 \
  METEOR_SETTINGS {} \
  MONGO_URL mongodb://mongodb/meteor \
  MONGO_OPLOG_URL mongodb://mongodb/local \
  MAIL_URL smtps://user:password@mailhost:465/

COPY example/.meteor/service/meteor /etc/service

# Install things and Meteor
RUN \
  adduser --system --group meteor --home /home/meteor \
  && apt-get update \
  && apt-get upgrade -y -o Dpkg::Options::="--force-confold" \
  && apt-get --yes install git curl python build-essential g++ \
  && curl -sL https://install.meteor.com/ | sed s/--progress-bar/-sL/g | sh

# Copy Meteor folder
ONBUILD COPY . /build

# Build APP
ONBUILD RUN \
  cd /build \
  && if [ -d /build/.meteor/service ]; then cp -R /build/.meteor/service/* /etc/service; fi \
  && if [ -f /etc/service/meteor/run ]; then chmod +x /etc/service/meteor/run; fi \
  && echo "Meteor app release: $(cat .meteor/release | sed 's/METEOR@//')" \
  && echo "Meteor updated to release: $(meteor --version --allow-superuser)" \
  && export "NODE=$(find /root/.meteor -path '*bin/node' | grep '.meteor/packages/meteor-tool/' | sort -rb | head -n 1)" \
  && ln -sf ${NODE} /usr/local/bin/node \
  && echo "$(dirname $(dirname "$NODE"))/lib/node_modules" > /etc/container_environment/NODE_PATH \
  && export "NPM_PATH=$(dirname "$NODE")/npm" \
  && echo "$NPM_PATH" > /etc/container_environment/NPM_PATH \
  && $NPM_PATH install --quiet \
  && $NPM_PATH build \
  && meteor build --architecture=os.linux.x86_64 --server-only --allow-superuser --directory / \
  && (cd /bundle/programs/server && $NPM_PATH install --quiet && $NPM_PATH install bcrypt --quiet) \
  && echo  "$NPM_PATH\n - npm install DONE" \
  && chown meteor:meteor -Rh /bundle ~/.meteor \
  && apt-get --yes purge git curl \
  && apt-get --yes autoremove \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /build

# init baseimage services
CMD ["/sbin/my_init"]
