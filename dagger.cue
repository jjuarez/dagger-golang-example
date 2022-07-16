package main

import (
	"dagger.io/dagger"
	"universe.dagger.io/go"
	"universe.dagger.io/docker"
)

dagger.#Plan & {
	client: env: {
		DOCKER_USERNAME: string
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
		params: image: {
			registry:  "docker.io"
			namespace: "jjuarez"
			name:      "dagger-golang-example"
			tag:       "latest"
		}

		docker_build: docker.#Dockerfile & {
			source: client.filesystem.".".read.contents
			auth: {
				"index.docker.io": {
					username: client.env.DOCKER_USERNAME
					secret:   client.env.DOCKER_PASSWORD
				}
			}
		}

		release: docker.#Push & {
			image: docker_build.output
			dest:  "\(params.image.registry)/\(params.image.namespace)/\(params.image.name):\(params.image.tag)"
		}

		build: go.#Build & {
			source:  client.filesystem.".".read.contents
			package: "./..."
		}

		test: go.#Test & {
			source:  client.filesystem.".".read.contents
			package: "./..."
		}
	}
}
