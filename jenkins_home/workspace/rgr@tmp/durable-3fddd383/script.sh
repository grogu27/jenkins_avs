
                        if docker ps -a --filter "name=${DOCKER_CONTAINER_NAME}" -q; then
                            echo "Stopping and removing existing container..."
                            docker stop ${DOCKER_CONTAINER_NAME}
                            docker rm ${DOCKER_CONTAINER_NAME}
                        else
                            echo "No existing container found, skipping stop and remove."
                        fi
                    