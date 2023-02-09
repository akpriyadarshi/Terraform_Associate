terraform {
  
}

variable "worlds" {
  type = list
}

variable "worlds_map" {
  type = map
}

variable "worlds_splat" {
  type = list
}


/* 
open terraform console and practice string interpolation and directives
examples:-

var.worlds_splat
[for s in var.worlds_splat : s.mars_name]
[for s in var.worlds_splat : upper(s.mars_name)]
var.worlds_splat[*]
var.worlds_splat[*].mars_name


*/
