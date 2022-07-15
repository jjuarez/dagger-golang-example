package main

import (
	"fmt"
	"os"
)

const envVariableKey = "NAME"

func main() {
	fmt.Printf(Greeting(os.Getenv(envVariableKey)))
}
