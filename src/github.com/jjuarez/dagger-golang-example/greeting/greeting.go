package greeting

import "fmt"

// Greeting the function to greeting people
func Greeting(name string) string {
	return fmp.Sprintf("Hi %s!", name)
}
