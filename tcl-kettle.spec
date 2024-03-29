%define buildroot %{_tmppath}/%{name}

Name:          tcl-kettle
Summary:       A build system for pure Tcl, and critcl packages 
Version:       0.1_git20221209
Release:       0
License:       TCL
Group:         Development/Libraries/Tcl
Source:        %{name}-%{version}.tar.gz
URL:           https://github.com/andreas-kupries/kettle
BuildRequires: tcl >= 8.5
Requires:      tcl >= 8.5
Requires:      critcl
Requires:      critcl-devel
BuildRoot:     %{buildroot}

%description
Kettle is an application and set of packages providing support for
the easy building and installation of pure Tcl packages.

%prep
%setup -q -n %{name}-%{version}

%build

%install
tclsh ./kettle -f build.tcl --lib-dir %{buildroot}%_datadir/tcl install-packages
tclsh ./kettle -f build.tcl --bin-dir %{buildroot}/usr/bin install-app-kettle
sed -i 's/tclsh8.6/tclsh/g' %{buildroot}/usr/bin/kettle

%clean
rm -rf %buildroot

%files
%defattr(-,root,root)
/usr/bin/kettle
%_datadir/tcl

