# This file is used by Rack-based servers to start the application.

require File::expand_path("lib/builders", __dir__)
run(Builders::FULL_STACK)
