# dstask
EXE="$(
    obtain \
        https://github.com/naggie/dstask/releases/download/v0.8/dstask-linux-amd64 \
        a8888a275ad8aa11121d45f589a22829707bd9c29ef0b19e747938c57fde313f
)"
sudo cp "${EXE}" /usr/local/bin/dstask.new
sudo chmod +x /usr/local/bin/dstask.new
sudo mv -f /usr/local/bin/{dstask.new,dstask}

sudo pacman --noconfirm -Sy git tmux vim tig zsh openssh pass httpie ncdu tree wget htop gnupg curl bash-completion jq sox ffmpeg httrack \
    python go fzf ripgrep neovim unzip

# TODO yubikey stuff
# TODO tmpreaper

# browserpass host
ZIP="$(
    obtain \
        https://github.com/browserpass/browserpass-native/releases/download/3.0.6/browserpass-linux64-3.0.6.tar.gz \
        f63047cbde5611c629b9b8e2acf6e8732dd4d9d64eba102c2cf2a3bb612b3360
)"
unzip -p "$ZIP" browserpass-linux64 | sudo dd of=/usr/local/bin/browserpass.new
sudo chmod +x /usr/local/bin/browserpass.new
sudo mv -f /usr/local/bin/{browserpass.new,browserpass}
