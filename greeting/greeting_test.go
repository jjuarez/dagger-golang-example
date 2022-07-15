package main

import (
	"fmt"
	"testing"
)

func TestGreeting(t *testing.T) {

	assertCorrectMessage := func(t testing.TB, got, want string) {
		t.Helper()
		if got != want {
			t.Errorf("got %q want %q", got, want)
		}
	}

	t.Run("greeting to the default name", func(t *testing.T) {
		got := Greeting("")
		want := fmt.Sprintf("Hi, %s!", DefaultName)
		assertCorrectMessage(t, got, want)
	})

	t.Run("greetin to an specific name", func(t *testing.T) {
		got := Greeting("TestingName")
		want := "Hi, TestingName!"
		assertCorrectMessage(t, got, want)
	})
}
