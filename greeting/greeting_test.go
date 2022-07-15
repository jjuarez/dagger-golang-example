package greeting

import (
	"fmt"
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestGreeting(t *testing.T) {
	t.Run("greeting using the default name", func(t *testing.T) {
		got := Greeting("")
		want := fmt.Sprintf("Hi, %s!", DefaultName)

		assert.Equal(t, got, want, "The should be equal using the default name")
	})

	t.Run("greeting using an specific name", func(t *testing.T) {
		got := Greeting("TestingName")
		want := "Hi, TestingName!"

		assert.Equal(t, got, want, "They should be equal using a custom name")
	})
}
