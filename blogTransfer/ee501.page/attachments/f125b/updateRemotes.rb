#!/usr/bin/env ruby -wKU

glibdir = "."
Dir.chdir glibdir             # change to libdir so that requires work
glibdir = Dir.pwd

Dir.chdir "#{glibdir}/.."

submodules = `find * | grep objectivemax$`.split("\n")

submodules.each do |gitModule|
Dir.chdir "#{glibdir}/../#{gitModule}"
puts " ***********************************"
puts "Entering #{gitModule} \n"
puts "Setting #{gitModule} to tracking URL git@github.com:jamoma/ObjectiveMax.git"
`git remote set-url origin git@github.com:jamoma/ObjectiveMax.git`
end