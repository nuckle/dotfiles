#!/usr/bin/env bash
#
# Script to notify user for new mails.
# Crontab ex:
# */3 * * * * $HOME/.local/scripts/mbsync-notify.sh [acc_name]
#

# do not duplicate
pgrep mbsync >/dev/null && { echo "mbsync is already running."; exit ;}

# First, we have to get the right variables for the mbsync file, the pass
# archive, notmuch and the GPG home.  This is done by searching common profile
# files for variable assignments. This is ugly, but there are few options that
# will work on the maximum number of machines.

eval "$(grep -h -- \
	"^\s*\(export \)\?\(MBSYNCRC\|MPOPRC\|PASSWORD_STORE_DIR\|PASSWORD_STORE_GPG_OPTS\|NOTMUCH_CONFIG\|GNUPGHOME\|MAILSYNC_MUTE\|XDG_CONFIG_HOME\|XDG_DATA_HOME\)=" \
	"$HOME/.profile" "$HOME/.bash_profile" "$HOME/.zprofile"  "$HOME/.config/shell/profile" "$HOME/.config/zsh/.zprofile" "$HOME/.zshenv" \
	"$HOME/.config/zsh/.zshenv" "$HOME/.bashrc" "$HOME/.zshrc" "$HOME/.config/zsh/.zshrc" \
	"$HOME/.pam_environment" 2>/dev/null)"


# Run mbsync once for all accs with named configs file, with quiet interface
# or specify account name as argument and define separate cron tasks for each acc

if [ -n "$1" ]
then
	mbsync -c ~/.config/isync/mbsyncrc "$1" 
else
	mbsync -c ~/.config/isync/mbsyncrc -a  
fi


# Count new mail for every maildir, only in INBOX
# since there are maildirs/accounts in a format `~/Mail/account1/subacc1`,
# `~/Mail/account1/subacc2`, `~/Mail/account2/subacc1` etc
# there should be such an expansion

maildir="$HOME/dox/mail/"
new="$(find "$maildir" -path '*/Inbox/new/*' -type f | wc -l)"

#count old mail for every maildir
old="$(find "$maildir" -path '*/Inbox/cur/*' -type f | wc -l)"

# `notify-send` requires connection to DBUS_SESSION_BUS_ADDRESS
# and one way is to export display and use X server authority cookies thru .Xauthority
# see here https://askubuntu.com/questions/298608/notify-send-doesnt-work-from-crontab
# export DISPLAY=:0; export XAUTHORITY="~/.config/xorg/.Xauthority"

# the only way I was able to make it work with cron...
export DBUS_SESSION_BUS_ADDRESS=$(cat /tmp/dbus.env)

if [ $new -gt 0 ]
then
	notify-send --icon='/usr/share/icons/Adwaita/symbolic/status/mail-unread-symbolic.svg' -a "Mbsync" "New mail!" "New: $new Old: $old"
fi
