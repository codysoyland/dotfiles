sudo ln -sf /usr/share/zoneinfo/Europe/London /etc/localtime

# replace ssh config if password authentication is enabled (on by default)
if ! grep -q 'PasswordAuthentication no' /etc/ssh/sshd_config; then
    sudo cp system-configuration/etc/sshd_config /etc/ssh/
    sudo systemctl restart sshd
fi

# set keyboard layout (with caps lock as esc)
cat <<-EOF | sudo tee /etc/default/keyboard
    XKBMODEL="pc104"
    XKBLAYOUT="gb"
    XKBVARIANT=""
    XKBOPTIONS="caps:escape"
    BACKSPACE="guess"
EOF

# apply temporarily, as above requires restart (I think)
test $DISPLAY && setxkbmap -option "caps:escape" gb || true

sudo etckeeper init