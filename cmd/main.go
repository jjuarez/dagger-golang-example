package main

import (
	"net/http"

	"github.com/gin-gonic/gin"
	"github.com/jjuarez/dagger-golang-example/internal/greeting"
)

const envVariableKey = "DEFAULT_NAME"

func setupRouter() *gin.Engine {
	gin.ForceConsoleColor()
	router := gin.Default()

	router.GET("/sayhi", func(context *gin.Context) {
		greetingMessage := greeting.Greeting("")
		context.JSON(http.StatusOK, gin.H{"message": greetingMessage})
	})

	router.GET("/sayhi/:name", func(context *gin.Context) {
		name := context.Param("name")
		greetingMessage := greeting.Greeting(name)
		context.JSON(http.StatusOK, gin.H{"message": greetingMessage})
	})

	return router
}

func main() {
	router := setupRouter()
	router.Run() // listen and server on 0.0.0.0:${PORT}
}
