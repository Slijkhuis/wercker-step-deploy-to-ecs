#!/bin/sh

# https://github.com/wercker/step-bash-template

set +e
# This set +e is here because -u operates differently between ash and bash

DIR=$WERCKER_STEP_ROOT
if [ ! -n "$WERCKER_BASH_TEMPLATE_INPUT" ]; then
  export WERCKER_BASH_TEMPLATE_INPUT="*.template*"
fi

if [ ! -n "$WERCKER_BASH_TEMPLATE_OUTPUT" ]; then
  export WERCKER_BASH_TEMPLATE_OUTPUT="./"
fi

for input in $WERCKER_BASH_TEMPLATE_INPUT; do
  outname=$(echo "$input" | sed 's/\.template//')
  case "$WERCKER_BASH_TEMPLATE_OUTPUT" in
    */)
      output="$WERCKER_BASH_TEMPLATE_OUTPUT$outname"
      ;;
    *)
      output=$WERCKER_BASH_TEMPLATE_OUTPUT
  esac
  echo "Templating $input -> $output"

  if [ -e /dev/urandom ]; then
    RANDO=$(LANG=C tr -cd 0-9 </dev/urandom | head -c 12)
  else
    RANDO=2344263247
  fi

  "$DIR/template.sh" "$input" > "$output" 2>$RANDO

  if [ ! -z "$WERCKER_BASH_TEMPLATE_ERROR_ON_EMPTY" ]; then
    if [ -s $RANDO ]; then
      cat $RANDO
      rm -f $RANDO
      exit 1
    fi
  fi
  rm -f $RANDO
done
