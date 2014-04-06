# Bootstrapping

Get [Xcode](https://itunes.apple.com/gb/app/xcode/id497799835?mt=12) first,
since it’ll take a while to download.

Install Homebrew, and prepare for brewing:

    ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
    PATH="/usr/local/bin:${PATH}"
    brew update
    brew doctor

Next, we need git and stow:

    brew install git stow
    
Then clone this repo, switch to the appropriate branch, and run the setup
script:

    mkdir ~/Repos && cd Repos
    git clone git@github.com:LeoBakerHytch/dotfiles.git && cd dotfiles
    git checkout mac
    ./scripts/setup
    ./scripts/configure

# Security

Don’t forget to turn on the firewall!
