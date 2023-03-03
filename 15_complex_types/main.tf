terraform {
  
}

## list ##
variable "planet" {
  type = list
  default = ["mars", "earth", "venus"]
}

## map ##
variable "plans" {
  type = map
  default = {
    "planA" = "50 USD",
    "planB" = "100 USD",
    "planC" = "500 USD"
  }
}



## object ##
variable "plan" {
  type = object({
    PlanName = string
    PlanAmount = number

  })
  default = {
    "PlanName" = "50 USD",
    "PlanAmount" = 100
  }
}

## tuple ##
variable "random" {
  type = tuple([string,number,bool])
  default = ["hello",10,false]
}






/*
open terraform console

1. var.plans
2. var.plans["planA"]
3. var.plan
4. var.random

*/