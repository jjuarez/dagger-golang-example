package greeting

import (
	"fmt"

	"github.com/jjuarez/dagger-golang-example/internal/config"
)

// DefaultName ...
const DefaultName = "Javier"

// EnvKey
const EnvKey = "DEFAULT_NAME"

// Greting ...
func Greeting(name string) string {
	if name == "" {
		name = config.GetenvWithDefault(EnvKey, DefaultName)
	}
	return fmt.Sprintf("Hi, %s!", name)
}
