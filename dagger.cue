package main

import (
	"dagger.io/dagger"
	"universe.dagger.io/go"
	"universe.dagger.io/docker"
)

dagger.#Plan & {
	client: env: {
		DOCKER_USERNAME: string | "jjuarez"
		DOCKER_PASSWORD: dagger.#Secret
	}
	client: filesystem: ".": read: {
		contents: dagger.#FS
		exclude: [
			".git",
			".gitignore",
			"*.md",
			"*.cue",
			"service",
		]
	}

	actions: {
		docker_build: docker.#Dockerfile & {
			source: client.filesystem.".".read.contents
			dockerfile: path: "Dockerfile"
			auth: {
				"index.docker.io": {
					username: client.env.DOCKER_USERNAME
					secret:   client.env.DOCKER_PASSWORD
				}
			}
		}

		docker_push: docker.#Push & {
			image: docker_build.output
			dest:  "docker.io/jjuarez/dagger-golang-example:latest"
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
