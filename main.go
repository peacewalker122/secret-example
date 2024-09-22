package main

import (
	"os"
	"strings"
)

func main() {
	env := strings.ToUpper(os.Getenv("ENV"))

	if env == "PRODUCTION" {
		println("were at the same page")
	} else {
		println("duh, were not at the same page")
	}
}
