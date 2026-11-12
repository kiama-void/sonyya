#!/bin/sh
# Preview the blog locally at http://localhost:4000/sonyya/
cd "$(dirname "$0")"
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
export LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8
export RUBYOPT="-r$(pwd)/_dev/ruby-compat.rb -W0"
exec bundle exec jekyll serve --livereload --future "$@"
