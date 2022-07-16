package config

import "os"

// GetenvWithDefault ...
func GetenvWithDefault(key string, defaultValue string) string {
	value := os.Getenv(key)

	if value != "" {
		return value
	}

	return defaultValue
}
