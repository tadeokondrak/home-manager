{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.programs.clang-format;
in
{
  options.programs.clang-format = {
    enable = mkEnableOption "clang-format";
    settings = mkOption {
      type = types.attrs;
      default = {};
      description = ''
        Settings to be written to ~/.clang-format. See <link xlink:href="https://clang.llvm.org/docs/ClangFormatStyleOptions.html" /> for documentation.
      '';
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ pkgs.clang-tools ];
    home.file.".clang-format".text = mkIf (cfg.settings != {}) (builtins.toJSON cfg.settings);
  };

  meta.maintainers = with maintainers; [ tadeokondrak ];
}
