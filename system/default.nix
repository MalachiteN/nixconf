let nixFilesInDir = 
 		builtins.filter (x: x != null) (
 			builtins.attrValues (
 				builtins.mapAttrs (
 					name: type: if type == "regular" 
 								&& builtins.match ".*\\.nix" name != null
 								&& name != "default.nix"
 					then ./. + "/${name}" 
 					else null
 				) (builtins.readDir ./.)
 			)
 		);
in
	 nixFilesInDir
