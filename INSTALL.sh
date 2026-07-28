#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"

OS="$(uname -s)"

echo "==> Detected OS: ${OS}"

echo "==> Linking init.vim"
INIT_VIM="${HOME}/.config/nvim/init.vim"
mkdir -p "${HOME}/.config/nvim"
if [ -f "$INIT_VIM" ] ; then
    rm "$INIT_VIM"
fi
ln -sf "${SCRIPT_DIR}/init.vim" "$INIT_VIM"


echo "==> Installing colourschemes..."
cp -r "${SCRIPT_DIR}/vimfiles/colors" "${HOME}/.config/nvim"


echo "==> Setting up Python3 provider venv..."
VENV_DIR="${SCRIPT_DIR}/nvim-python3"

if [[ -d "${VENV_DIR}" ]]; then
    echo "    Removing existing venv..."
    rm -rf "${VENV_DIR}"
fi
python3 -m venv "${VENV_DIR}"
"${VENV_DIR}/bin/pip" install --quiet --upgrade pip
"${VENV_DIR}/bin/pip" install --quiet --upgrade neovim

echo "    Python3 provider installed at: ${VENV_DIR}/bin/python3"


echo "==> Installing vim-plug plugins..."
# vim-plug will auto-install itself on first launch (handled in init.vim),
# but we need to run it headlessly here
PLUG_PATH="${HOME}/.local/share/nvim/site/autoload/plug.vim"
if [[ ! -f "${PLUG_PATH}" ]]; then
    echo "    Downloading vim-plug..."
    mkdir -p "$(dirname "${PLUG_PATH}")"
    curl -fLo "${PLUG_PATH}" \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

nvim --headless +PlugInstall +qall

echo "==> Setting up vim -> nvim alias..."

add_alias() {
    local rc_file="$1"
    if [[ -f "${rc_file}" ]]; then
        if ! grep -q "alias vim=nvim" "${rc_file}"; then
            echo 'alias vim=nvim' >> "${rc_file}"
            echo "    Added alias to ${rc_file}"
        else
            echo "    Alias already present in ${rc_file}"
        fi
    fi
}

if [[ "${OS}" == "Darwin" ]]; then
    add_alias "${HOME}/.zshrc"
    add_alias "${HOME}/.bash_profile"
else
    add_alias "${HOME}/.zshrc"
    add_alias "${HOME}/.bashrc"
fi


echo "==> Installing InconsolataGo Nerd Font..."

FONT_NAME="InconsolataGo"
FONT_ARCHIVE="InconsolataGo.zip"
FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/${FONT_ARCHIVE}"

if [[ "${OS}" == "Darwin" ]]; then
    FONT_DIR="${HOME}/Library/Fonts"
else
    FONT_DIR="${HOME}/.local/share/fonts"
fi

mkdir -p "${FONT_DIR}"

TMP_DIR="$(mktemp -d)"
trap 'rm -rf "${TMP_DIR}"' EXIT

echo "    Downloading ${FONT_NAME} Nerd Font..."
curl -fLo "${TMP_DIR}/${FONT_ARCHIVE}" "${FONT_URL}"
unzip -q "${TMP_DIR}/${FONT_ARCHIVE}" -d "${TMP_DIR}/fonts"
cp "${TMP_DIR}/fonts"/*.ttf "${FONT_DIR}/" 2>/dev/null || \
    cp "${TMP_DIR}/fonts"/*.otf "${FONT_DIR}/" 2>/dev/null || true

if [[ "${OS}" != "Darwin" ]]; then
    fc-cache -f "${FONT_DIR}"
fi

echo "    Font installed to ${FONT_DIR}"

# Configure alacritty if present
ALACRITTY_CONFIG=""
if [[ -f "${HOME}/.config/alacritty/alacritty.toml" ]]; then
    ALACRITTY_CONFIG="${HOME}/.config/alacritty/alacritty.toml"
elif [[ -f "${HOME}/.config/alacritty/alacritty.yml" ]]; then
    ALACRITTY_CONFIG="${HOME}/.config/alacritty/alacritty.yml"
fi

if [[ -n "${ALACRITTY_CONFIG}" ]]; then
    echo "    Found alacritty config at ${ALACRITTY_CONFIG}"
    # Back it up first
    cp "${ALACRITTY_CONFIG}" "${ALACRITTY_CONFIG}.bak"

    if [[ "${ALACRITTY_CONFIG}" == *.toml ]]; then
        # Check if a [font] section already exists
        if grep -q '^\[font\]' "${ALACRITTY_CONFIG}"; then
            echo "    [font] section already exists in alacritty.toml - please set manually:"
            echo "      family = \"InconsolataGo Nerd Font Mono\""
        else
            cat >> "${ALACRITTY_CONFIG}" << 'EOF'

[font]
normal = { family = "InconsolataGo Nerd Font Mono", style = "Regular" }
bold   = { family = "InconsolataGo Nerd Font Mono", style = "Bold" }
italic = { family = "InconsolataGo Nerd Font Mono", style = "Italic" }
EOF
            echo "    Font config appended to alacritty.toml"
        fi
    else
        # YAML format
        if grep -q '^font:' "${ALACRITTY_CONFIG}"; then
            echo "    font: section already exists in alacritty.yml - please set manually:"
            echo "      family: InconsolataGo Nerd Font Mono"
        else
            cat >> "${ALACRITTY_CONFIG}" << 'EOF'

font:
  normal:
    family: "InconsolataGo Nerd Font Mono"
    style: Regular
  bold:
    family: "InconsolataGo Nerd Font Mono"
    style: Bold
  italic:
    family: "InconsolataGo Nerd Font Mono"
    style: Italic
EOF
            echo "    Font config appended to alacritty.yml"
        fi
    fi
else
    echo "    Alacritty config not found - skipping font configuration"
    echo "    To configure manually, add to your alacritty.toml:"
    echo '      [font]'
    echo '      normal = { family = "InconsolataGo Nerd Font Mono", style = "Regular" }'
fi

#================================================================================

echo ""
echo "==> Done!"
echo "    Remember to source your shell rc file or open a new terminal."
echo "    If using alacritty, restart it to pick up the new font."
