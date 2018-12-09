# Copyright (C) 2004-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# Contributed by Sven Wegener (swegener@gentoo.org)

_config_vars="$_config_vars autoipd"

autoipd_depend() {
	program /usr/bin/avahi-autoipd
	after interface
}

autoipd_start() {
	_exists true || return 1

        eval args=\$autoipd_${IFVAR}

	ebegin "Starting avahi-autoipd"
	/usr/bin/avahi-autoipd --daemonize --syslog --wait ${args} "${IFACE}"
	eend "${?}" || return 1

	_show_address

	return 0
}

autoipd_stop() {
	/usr/bin/avahi-autoipd --check --syslog "${IFACE}" || return 0

	ebegin "Stopping avahi-autoipd"
	/usr/bin/avahi-autoipd --kill --syslog "${IFACE}"
	eend "${?}"
}
