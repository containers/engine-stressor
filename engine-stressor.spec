%if "%{?copr_username}" != "rhcontainerbot"
%bcond_with copr
%else
%bcond_without copr
%endif

Name: engine-stressor
# Set different Epochs for copr and koji
%if %{with copr}
Epoch: 101
%endif
# Keep Version in upstream specfile at 0. It will be automatically set
# to the correct value by Packit for copr and koji builds.
# IGNORE this comment if you're looking at it in dist-git.
Version: 0.1.0
%if %{defined autorelease}
Release: %autorelease
%else
Release: 1
%endif
License: Apache-2.0
URL: https://github.com/containers/engine-stressor
Summary: A stressor tool for containers engines
Source0: %{url}/archive/v%{version}.tar.gz
BuildArch: noarch
Requires: podman
Requires: sudo
Requires: stress-ng
Requires: aardvark-dns

# Requirements for cgroupv2 ?
BuildRequires:  systemd
Requires:       systemd >= 239
Requires:       kernel >= 5.0

%description
A collection of scripts wrapped with cgroupv2 namespaces to stress podman
and make sure containers are not escaping it's delimitations if there 
are memory, CPU or others interferences in the system.

%prep
%autosetup -Sgit -n %{name}-%{version}

%build
%{__make} all

%install
%{__make} DESTDIR=%{buildroot} DATADIR=%{_datadir} install

#define license tag if not already defined
%{!?_licensedir:%global license %doc}

%files
%license LICENSE
%doc CODE-OF-CONDUCT.md NOTICE README.md SECURITY.md LICENSE
%{_bindir}/%{name}
%dir %{_datadir}/%{name}
%{_datadir}/engine-stressor/cgroup
%{_datadir}/engine-stressor/stress
%{_datadir}/engine-stressor/constants
%{_datadir}/engine-stressor/memory
%{_datadir}/engine-stressor/podman
%{_datadir}/engine-stressor/engine-operations
%{_datadir}/engine-stressor/processes
%{_datadir}/engine-stressor/network
%{_datadir}/engine-stressor/volume
%{_datadir}/engine-stressor/systemd
%{_datadir}/engine-stressor/system
%{_datadir}/engine-stressor/date
%{_datadir}/engine-stressor/rpm
%{_datadir}/engine-stressor/selinux

%changelog
%if %{defined autochangelog}
%autochangelog
%else
* Sun May 19 2024 RH Container Bot <rhcontainerbot@fedoraproject.org>
- Placeholder changelog for envs that are not autochangelog-ready
%endif
