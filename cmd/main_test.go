package main

import (
	"fmt"
	"net/http"
	"net/http/httptest"
	"testing"

	"github.com/jjuarez/dagger-golang-example/internal/greeting"
	"github.com/stretchr/testify/assert"
)

func TestWithoutName(t *testing.T) {
	t.Run("your real tests should go here", func(t *testing.T) {
		testRouter := setupRouter()
		record := httptest.NewRecorder()
		req, _ := http.NewRequest("GET", "/sayhi", nil)
		want := fmt.Sprintf("{\"message\":\"Hi, %s!\"}", greeting.DefaultName)
		testRouter.ServeHTTP(record, req)

		assert.Equal(t, http.StatusOK, record.Code)
		assert.Equal(t, want, record.Body.String())
	})
}

func TestWithName(t *testing.T) {
	t.Run("your real tests should go here", func(t *testing.T) {
		testRouter := setupRouter()
		record := httptest.NewRecorder()
		req, _ := http.NewRequest("GET", "/sayhi/testing", nil)
		want := "{\"message\":\"Hi, testing!\"}"
		testRouter.ServeHTTP(record, req)

		assert.Equal(t, http.StatusOK, record.Code)
		assert.Equal(t, want, record.Body.String())
	})
}
