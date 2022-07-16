package main

import (
	"dagger.io/dagger"
	"universe.dagger.io/go"
	"universe.dagger.io/docker"
)

dagger.#Plan & {
	client: filesystem: ".": read: {
		contents: dagger.#FS
		exclude: [
			".gitignore",
			".git",
		]
	}

	actions: {
		docker_build: docker.#Dockerfile & {
			source: client.filesystem.".".read.contents
			dockerfile: path: "Dockerfile"
		}

		go_build: go.#Build & {
			source:  client.filesystem.".".read.contents
			package: "./..."
		}

		go_test: go.#Test & {
			source:  client.filesystem.".".read.contents
			package: "./..."
		}
	}
}
