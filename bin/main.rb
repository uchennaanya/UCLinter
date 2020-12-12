#!/usr/bin/env ruby

require_relative '../lib/lint_files.rb'
require_relative '../lib/check.rb'

uclinter = Uclinter.new

uclinter.my_linter
