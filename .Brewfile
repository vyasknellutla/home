tap "homebrew/bundle"
tap "homebrew/core"
tap "homebrew/services"
tap "instrumenta/instrumenta"

brew "asdf"
brew "bash"
brew "coreutils"
brew "direnv"
brew "docker-completion"
brew "docker-compose-completion"
brew "doctl"
brew "faas-cli"
brew "fish"
brew "gcc"
brew "geckodriver"
brew "gh"
brew "git"
brew "git-flow-avh"
brew "git-lfs"
brew "gnupg"
brew "helm"
brew "helmfile"
brew "htop"
brew "jq"
brew "kubernetes-cli"
brew "kubectx"
brew "nmap"
brew "openapi-generator"
brew "openssh"
brew "pinentry-mac"
brew "shellcheck"
brew "testdisk"
brew "testssl"
brew "tree"
brew "util-linux"
brew "watch"
brew "watchman"
brew "wget"
brew "whalebrew"
brew "ykman"
brew "youtube-dl"
brew "zsh"
brew "instrumenta/instrumenta/kubeval"

if OS.mac?
    tap "homebrew/cask"
    tap "homebrew/cask-drivers"
    tap "homebrew/cask-fonts"
    tap "homebrew/cask-versions"
    tap "microsoft/git"

    brew "mas"

    cask "adobe-creative-cloud"
    cask "alacritty"
    cask "android-studio"
    cask "balenaetcher"
    cask "dbeaver-community"
    cask "docker"
    cask "dropbox"
    cask "firefox-developer-edition"
    cask "font-hack-nerd-font"
    cask "git-credential-manager-core"
    cask "github"
    cask "gpg-suite"
    cask "keybase"
    cask "postman"
    cask "signal"
    cask "virtualbox"
    cask "virtualbox-extension-pack"
    cask "visual-studio-code"
    cask "yubico-yubikey-manager"
    cask "zeplin"
    cask "zoomus"

    if false  # TODO: Check if user is signed into Mac App Store
        ## To get a list of installed mas apps:
        ### $ mas list | sort -k2 --ignore-case
        mas "1Password 7", id: 1333542190
        mas "Compressor", id: 424390742
        mas "Developer", id: 640199958
        mas "Final Cut Pro", id: 424389933
        mas "iMovie", id: 408981434
        mas "Keynote", id: 409183694
        mas "Logic Pro X", id: 634148309
        mas "Magnet", id: 441258766
        mas "MainStage 3", id: 634159523
        mas "Microsoft Excel", id: 462058435
        mas "Microsoft OneNote", id: 784801555
        mas "Microsoft Outlook", id: 985367838
        mas "Microsoft PowerPoint", id: 462062816
        mas "Microsoft Remote Desktop", id: 1295203466
        mas "Microsoft To Do", id: 1274495053
        mas "Microsoft Word", id: 462054704
        mas "Motion", id: 434290957
        mas "NewsGuard", id: 1438657064
        mas "NordVPN IKE", id: 1116599239
        mas "OneDrive", id: 823766827
        mas "Pages", id: 409201541
        mas "Parcel", id: 639968404
        mas "Rakuten Cash Back", id: 1451893560
        mas "Server", id: 883878097
        mas "Slack", id: 803453959
        mas "Termius", id: 1176074088
        mas "Transporter", id: 1450874784
        mas "Xcode", id: 497799835
        mas "Yubico Authenticator", id: 1497506650
    end
end
