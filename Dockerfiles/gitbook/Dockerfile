# consup gitbook
# node.js v6
# See https://github.com/LeKovr/consup
#

FROM lekovr/consup_nodejs

ENV DOCKERFILE_VERSION  161116

# -------------------------------------------------------------------------------
# Gitbook & libs

RUN sudo apt-get install -y xvfb imagemagick  libgl1-mesa-glx libxcomposite1

# GitBook from https://www.gitbook.com/
RUN npm install gitbook-cli -g

# Calibre from https://calibre-ebook.com/
RUN wget -nv -O- https://raw.githubusercontent.com/kovidgoyal/calibre/master/setup/linux-installer.py \
  | sudo python -c "import sys; main=lambda:sys.stderr.write('Download failed\n'); exec(sys.stdin.read()); main()"

RUN gosu op gitbook fetch
