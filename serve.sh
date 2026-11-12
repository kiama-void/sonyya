#!/bin/sh
# Preview the blog locally at http://localhost:4000/sonyya/
# Articles get an Edit button (bottom right) that saves straight to the Markdown file.
cd "$(dirname "$0")"
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
export LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8
export RUBYOPT="-r$(pwd)/_dev/ruby-compat.rb -W0"

bundle exec ruby _dev/edit-server.rb &
EDIT_PID=$!
trap 'kill $EDIT_PID 2>/dev/null' EXIT INT TERM

bundle exec jekyll serve --livereload --future "$@"
