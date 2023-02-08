terraform {
  
}

variable "hello" {
  type = string
}


/* 
open terraform console and practice string onterpolation and directives
examples:-

"hello ${var.hello}"

"hello %{if var.hello=="akash"}correct info%{else} world %{endif}"
*/