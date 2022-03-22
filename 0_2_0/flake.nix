{
  description = ''A library of ready made components covering networking, database queries, graphics, and console IO for use with Polymorph'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-Polymers-0_2_0.flake = false;
  inputs.src-Polymers-0_2_0.owner = "rlipsc";
  inputs.src-Polymers-0_2_0.ref   = "0_2_0";
  inputs.src-Polymers-0_2_0.repo  = "polymers";
  inputs.src-Polymers-0_2_0.type  = "github";
  
  inputs."polymorph".owner = "nim-nix-pkgs";
  inputs."polymorph".ref   = "master";
  inputs."polymorph".repo  = "polymorph";
  inputs."polymorph".dir   = "v0_3_0";
  inputs."polymorph".type  = "github";
  inputs."polymorph".inputs.nixpkgs.follows = "nixpkgs";
  inputs."polymorph".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-Polymers-0_2_0"];
  in lib.mkRefOutput {
    inherit self nixpkgs ;
    src  = deps."src-Polymers-0_2_0";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  };
}