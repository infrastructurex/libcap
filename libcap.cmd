docker buildx build --build-arg ARCH=x64 --build-arg LINUX_ARCH=x86_64 --build-arg TAG=0 --progress=plain --output type=local,dest=build .
