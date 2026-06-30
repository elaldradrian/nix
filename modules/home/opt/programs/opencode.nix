{
  lib,
  pkgs,
  config,
  ...
}:
let
  # ── fdx: FlowDeck's tree-sitter code reader, built from the FlowDeck repo ──
  fdx = pkgs.rustPlatform.buildRustPackage rec {
    pname = "fdx";
    version = "0.6.0-alpha.8";
    src = pkgs.fetchFromGitHub {
      owner = "DVNghiem";
      repo = "FlowDeck";
      rev = version; # tag == HEAD 9d71dc7
      hash = "sha256-22+0hoN6K0klvfc/cXQqIrWeFzTeRQigf+kLnJkZ9TI="; # ← switch once, paste the real hash from the error
    };
    cargoHash = "sha256-2DDDo4NAXjt4HI+QbPsjUq702rD5A+S7GVluOWTGQEs="; # ← ditto; nix prints the correct value on first build
    doCheck = false;
    meta = {
      description = "FlowDeck token-optimized file reader";
      mainProgram = "fdx";
      license = lib.licenses.mit;
    };
  };

  # ── codegraph: prebuilt npm bundle (vendored Node 24), patchelf'd ──
  codegraph =
    let
      version = "1.1.3";
      sources = {
        "x86_64-linux" = {
          plat = "linux-x64";
          hash = "sha256-CleNR47J1phcv1Ixm3ECnaRHWlFLd9gdqBwMHFgKT4I=";
        };
        "aarch64-darwin" = {
          plat = "darwin-arm64";
          hash = "sha256-0VcjEoMod5QR7WG/u7TRNzdlEZw9W1sf+ch/p2w0x/I=";
        };
      };
      sysName = pkgs.stdenv.hostPlatform.system;
      sel = sources.${sysName} or (throw "codegraph: unsupported system ${sysName}");
    in
    pkgs.stdenv.mkDerivation {
      pname = "codegraph";
      inherit version;
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/@colbymchenry/codegraph-${sel.plat}/-/codegraph-${sel.plat}-${version}.tgz";
        inherit (sel) hash;
      };
      sourceRoot = "package";
      dontConfigure = true;
      dontBuild = true;
      # Linux: fix the vendored node's interpreter + libstdc++/libgcc_s.
      # Darwin: Mach-O links system dylibs; nothing to patch.
      nativeBuildInputs = lib.optionals pkgs.stdenv.isLinux [ pkgs.autoPatchelfHook ];
      buildInputs = lib.optionals pkgs.stdenv.isLinux [ pkgs.stdenv.cc.cc.lib ];
      installPhase = ''
        runHook preInstall
        mkdir -p "$out/libexec/codegraph" "$out/bin"
        cp -r node lib bin "$out/libexec/codegraph/"
        chmod +x "$out/libexec/codegraph/node" "$out/libexec/codegraph/bin/codegraph"
        # the wrapper resolves symlinks before computing its dir, so a symlink is fine
        ln -s "$out/libexec/codegraph/bin/codegraph" "$out/bin/codegraph"
        runHook postInstall
      '';
      meta = {
        description = "Semantic code intelligence CLI for AI coding agents";
        mainProgram = "codegraph";
        license = lib.licenses.mit;
      };
    };
in
{
  options = { };

  config = lib.mkIf config.opt.features.devUtils.enable {
    home.packages = [
      pkgs.opencode # drop if opencode is already provided elsewhere
      pkgs.nodejs # opencode's runtime for npm plugins/providers; drop if already present
      pkgs.git
      fdx
      codegraph
    ];

    home.sessionVariables = {
      OPENCODE_EXPERIMENTAL_LSP_TOOL = "true";
      OPENCODE_ENABLE_EXA = "true";
      # fdx is on PATH from nix — never let FlowDeck's postinstall try to cargo-build it
      FDX_SKIP = "1";
      # NOTE: deliberately NOT setting FLOWDECK_CODEGRAPH_AUTO_INSTALL.
      # codegraph is already on PATH, so FlowDeck detects it via `codegraph --version`
      # and never shells out to `npm install -g`.
    };

    sops.secrets = {
      opencode_remote_baseurl = { };
      opencode_remote_api_key = { };
    };

    sops.templates.opencode-config = {
      path = "${config.home.homeDirectory}/.config/opencode/opencode.json";
      content = builtins.toJSON {
        "$schema" = "https://opencode.ai/config.json";
        plugin = [
          "@simonwjackson/opencode-direnv"
          "@dv.nghiem/flowdeck"
        ];
        default_agent = "orchestrator";
        model = "llama-server/qwen3.6-27b";
        lsp = true;
        formatter = true;
        permission = {
          bash = {
            "*" = "ask";
          };
          edit = "allow";
          read = {
            "*" = "allow";
            "*.env" = "deny";
            "*.env.*" = "deny";
            "*.env.example" = "allow";
          };
          glob = "allow";
          grep = "allow";
          lsp = "allow";
          task = "allow";
          skill = "allow";
          question = "allow";
          webfetch = "allow";
          websearch = "allow";
          codesearch = "allow";
          external_directory = "ask";
          doom_loop = "ask";
        };
        provider = {
          "llama-server" = {
            npm = "@ai-sdk/openai-compatible";
            name = "llama.cpp";
            options = {
              baseURL = config.sops.placeholder.opencode_remote_baseurl;
              apiKey = "{file:${config.sops.secrets.opencode_remote_api_key.path}}";
            };
            models = {
              "qwen3.6-27b" = {
                name = "Qwen3.6-27B";
                limit = {
                  context = 190000;
                  output = 16384;
                };
              };
              "qwen3.6-35b-a3b" = {
                name = "Qwen3.6-35B-A3B";
                limit = {
                  context = 250000;
                  output = 16384;
                };
              };
            };
          };
        };
      };
    };
  };
}
