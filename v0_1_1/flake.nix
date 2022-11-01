{
  description = ''A library of components & systems for Polymorph'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-Polyshards-v0_1_1.flake = false;
  inputs.src-Polyshards-v0_1_1.ref   = "refs/tags/v0.1.1";
  inputs.src-Polyshards-v0_1_1.owner = "rlipsc";
  inputs.src-Polyshards-v0_1_1.repo  = "polymers";
  inputs.src-Polyshards-v0_1_1.type  = "github";
  
  inputs."polymorph".owner = "nim-nix-pkgs";
  inputs."polymorph".ref   = "master";
  inputs."polymorph".repo  = "polymorph";
  inputs."polymorph".dir   = "v0_3_1";
  inputs."polymorph".type  = "github";
  inputs."polymorph".inputs.nixpkgs.follows = "nixpkgs";
  inputs."polymorph".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-Polyshards-v0_1_1"];
    over = if builtins.pathExists ./override.nix 
           then { override = import ./override.nix; }
           else { };
  in lib.mkRefOutput (over // {
    inherit self nixpkgs ;
    src  = deps."src-Polyshards-v0_1_1";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  } );
}