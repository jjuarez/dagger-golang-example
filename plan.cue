package main

import (
	"dagger.io/dagger"
	"universe.dagger.io/go"
	"universe.dagger.io/docker"
)

dagger.#Plan & {
	client: filesystem: ".": read: contents: dagger.#FS

	#DockerBuild: docker.#Dockerfile & {
		source: client.filesystem."./Dockerfile".read.contents
	}

	actions: {
		go_test: go.#Test & {
			source:  client.filesystem.".".read.contents
			package: "./..."
		}

		go_build: go.#Build & {
			source: client.filesystem.".".read.contents
		}

		docker_build: #DockerBuild & {
			source: client.filesystem.".".read.contents
		}
	}
}
