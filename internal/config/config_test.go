package config

import (
	"os"
	"testing"

	"github.com/stretchr/testify/assert"
)

const TestEnvVariableKey = "TEST_ENV_VARIABLE"
const TestDefaultValue = "DEFAULT_VALUE"
const CustomValue = "CUSTOM_VALUE"

func TestConfigWithDefault(t *testing.T) {
	t.Run("get env variable which exists", func(t *testing.T) {
		os.Setenv(TestEnvVariableKey, CustomValue)
		got := GetenvWithDefault(TestEnvVariableKey, TestDefaultValue)
		want := CustomValue

		assert.Equal(t, got, want, "The should be equal using custom value for the environment variable")

		os.Setenv(TestEnvVariableKey, "")
	})

	t.Run("get env variable which not exist and will use the default value", func(t *testing.T) {
		os.Setenv(TestEnvVariableKey, "")
		got := GetenvWithDefault(TestEnvVariableKey, TestDefaultValue)
		want := TestDefaultValue

		assert.Equal(t, got, want, "They should be equal using the default value for the enviornment variaable")
	})
}
