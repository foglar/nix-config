set positional-arguments

@default:
    just update

@deploy profile:
    just clone
    just hardware-generation ~/.dotfiles/kogami
    just hardware-generation ~/.dotfiles/ginoza
    just build $1

@clone:
    git clone https://git.foglar.tech/foglar/dotfiles.git ~/.dotfiles
@quick-clone:
    git clone https://git.foglar.tech/foglar/dotfiles.git ~/.dotfiles --depth 1
@update:
    cd ~/.dotfiles && git pull && nix flake update
@remove:
    gum confirm && rm -rf ~/.dotfiles || echo "File ~/.dotfiles not removed"

@install rebuild-argument entrypoint:
    sudo nixos-rebuild $1 --flake ~/.dotfiles#$2

@switch flake-entrypoint:
    just install switch $1

@build flake-entrypoint:
    just install build $1

@hardware-generation path:
    sudo nixos-generate-config --dir $1
