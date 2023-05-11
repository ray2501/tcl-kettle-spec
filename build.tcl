#!/usr/bin/tclsh

set arch "noarch"
set base "tcl-kettle-0.1_git20221209"

if {[file exists $base]} {
    file delete -force $base
}

set var [list git clone https://github.com/andreas-kupries/kettle.git $base]
exec >@stdout 2>@stderr {*}$var

cd $base

set var2 [list git checkout 96a08d425f3f151966cea8a0005758fd97115958]
exec >@stdout 2>@stderr {*}$var2

set var2 [list git reset --hard]
exec >@stdout 2>@stderr {*}$var2

file delete -force .git

cd ..

if {[file exists $base]} {
    file delete -force $base/.git
}

set var2 [list tar czvf ${base}.tar.gz $base]
exec >@stdout 2>@stderr {*}$var2

if {[file exists build]} {
    file delete -force build
}

file mkdir build/BUILD build/RPMS build/SOURCES build/SPECS build/SRPMS
file copy -force $base.tar.gz build/SOURCES

set buildit [list rpmbuild --target $arch --define "_topdir [pwd]/build" -bb tcl-kettle.spec]
exec >@stdout 2>@stderr {*}$buildit

# Remove our source code
file delete -force $base
file delete -force $base.tar.gz

