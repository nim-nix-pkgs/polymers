{
  description = ''A library of components for the Polymorph ECS'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-Polymers-v0_3_0.flake = false;
  inputs.src-Polymers-v0_3_0.ref   = "refs/tags/v0.3.0";
  inputs.src-Polymers-v0_3_0.owner = "rlipsc";
  inputs.src-Polymers-v0_3_0.repo  = "polymers";
  inputs.src-Polymers-v0_3_0.type  = "github";
  
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
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-Polymers-v0_3_0"];
    over = if builtins.pathExists ./override.nix 
           then { override = import ./override.nix; }
           else { };
  in lib.mkRefOutput (over // {
    inherit self nixpkgs ;
    src  = deps."src-Polymers-v0_3_0";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  } );
}