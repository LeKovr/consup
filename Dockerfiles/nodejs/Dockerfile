# consup nodejs
# node.js v 4.4.5
# See https://github.com/LeKovr/consup
#

FROM lekovr/consup_baseapp

ENV DOCKERFILE_VERSION  160526

RUN apt-get update && apt-get -y upgrade && apt-get -y install \
    git make g++ libpng-dev

RUN curl -sL https://deb.nodesource.com/setup_4.x | bash -
RUN apt-get install -y nodejs

# -------------------------------------------------------------------------------
# Extra libs

RUN npm install -g gulp bower gulp-jshint gulp-uglify gulp-connect \
  gulp-watch gulp-autoprefixer gulp-less gulp-sourcemaps gulp-rigger gulp-imagemin \
  gulp-cssnano del imagemin-pngquant browser-sync \
  gulp-concat gulp-filter gulp-main-bower-files \
  gulp-rename gulp-size gulp-load-plugins \
  yo generator-gulp-angular \
  useref ng-annotate csso rev eslint karma protractor gulp-angular-templatecache \
  autoprefixer  gulp-data           lodash \
  browserify    gulp-if             minimist \
  envify        gulp-imagemin       vinyl-buffer \
  eventify      gulp-nunjucks-html  vinyl-source-stream \
  foldero       gulp-plumber        watchify \
  glob          gulp-print          wrench \
  gulp-changed  gulp-rename         gulp-htmlmin \
  gulp-postcss gulp-util browserify-global-shim

RUN ln -s /usr/lib/node_modules /home/node_modules

# -------------------------------------------------------------------------------
# Consup

WORKDIR /home/app

ENV APPUSER op

COPY init.sh /
CMD ["/init.sh"]
