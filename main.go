package main

import (
	"fmt"
	"os"

	"github.com/jjuarez/dagger-golang-example/greeting"
)

const envVariableKey = "NAME"

func main() {
	fmt.Printf(greeting.Greeting(os.Getenv(envVariableKey)))
}
