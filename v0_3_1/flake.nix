{
  description = ''A library of components and systems for the Polymorph ECS'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-polymers-v0_3_1.flake = false;
  inputs.src-polymers-v0_3_1.ref   = "refs/tags/v0.3.1";
  inputs.src-polymers-v0_3_1.owner = "rlipsc";
  inputs.src-polymers-v0_3_1.repo  = "polymers";
  inputs.src-polymers-v0_3_1.dir   = "";
  inputs.src-polymers-v0_3_1.type  = "github";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-polymers-v0_3_1"];
    over = if builtins.pathExists ./override.nix 
           then { override = import ./override.nix; }
           else { };
  in lib.mkRefOutput (over // {
    inherit self nixpkgs ;
    src  = deps."src-polymers-v0_3_1";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  } );
}