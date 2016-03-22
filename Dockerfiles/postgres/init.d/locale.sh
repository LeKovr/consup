
# Setup extra locale for createdb

F=/usr/share/locale/locale.alias

if [[ "$LOCALE" ]] && [[ "$LOCALE" != "en_US" ]]; then
  locale -a | grep -i $LOCALE.utf8 > /dev/null || localedef -i $LOCALE -c -f UTF-8 -A $F $LOCALE.UTF-8
fi