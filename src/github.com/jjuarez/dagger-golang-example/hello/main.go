package main

import (
	"fmt"
	"os"

	"github.com/jjuarez/dagger-golang-example/greeting"
)

func main() {
	name := os.Getenv("NAME")
	if name == "" {
		name = "JJ"
	}
	fmt.Printf(greeting.Greeting(name))
}
