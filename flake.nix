{
  description = "AAL TEBİGEP Ekip Üyeleri Veritabanı";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

  outputs =
    { nixpkgs, ... }:
    let
      forAllSystems =
        function:
        nixpkgs.lib.genAttrs nixpkgs.lib.systems.flakeExposed (
          system:
          function {
            inherit system;
            pkgs = nixpkgs.legacyPackages.${system};
          }
        );
    in
    {
      devShells = forAllSystems (
        { pkgs, ... }:
        {
          default = pkgs.mkShellNoCC {
            name = "tebidata";
            meta.description = "AAL TEBİGEP Ekip Üyeleri Veritabanı";
            packages = [ pkgs.deno ];
          };
        }
      );
    };
}
