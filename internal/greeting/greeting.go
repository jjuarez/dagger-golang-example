package greeting

import "fmt"

// DefaultName ...
const DefaultName = "Javier"

// Greting ...
func Greeting(name string) string {
	if name == "" {
		name = DefaultName
	}
	return fmt.Sprintf("Hi, %s!", name)
}
