terraform {
  
}

variable "worlds" {
  type = list
}

variable "worlds_map" {
  type = map
}


/* 
open terraform console and practice string interpolation and directives
examples:-

[for i,v in var.worlds : "from ${i} to ${v}"]
[for s in var.worlds: upper(s)]
[for k,v in var.worlds_map : "from ${k} to ${v}"]
{for i,v in var.worlds : "${i}" =>  v}    // curly braces returns a map whereas square brackets returns list
[for i,v in var.worlds_map : v if i!="mars"] // you can also use if within for expression
*/
