{
  description = "A Nix-flake-based Python development environment";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

  outputs =
    { nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { system = "${system}"; };
    in
    {
      devShells.${system} = {
        default = pkgs.mkShell {
          venvDir = ".venv";
          packages =
            with pkgs;
            [
              ruff
              uv
              basedpyright
              python312

              # for docker
              hadolint
              dockerfile-language-server-nodejs
              docker-compose-language-service
            ]
            ++ (with pkgs.python312Packages; [
              venvShellHook
              # python-lsp-server
              # python-lsp-ruff
              # black
            ]);
        };
      };
    };
}

