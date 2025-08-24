#!/bin/bash
ccap=""
cd deviceQuery
echo "Attempting to autodetect CUDA compute capability..."
# Get the HIGHEST compute capability among detected devices, strip the dot (e.g., 8.9 -> 89)
make >cuda_build_log.txt 2>&1 && ccap=$(./deviceQuery | awk '/CUDA Capability/ {print $NF}' | tr -d '.' | sort -nr | head -n 1)
if [ -n "${ccap}" ]; then
	echo "Detected ccap=${ccap}"
else
	echo "Autodetection failed, falling back to ccap=30 (set the ccap variable to override this)"
	ccap="30"
fi
cd -
echo ${ccap} > cuda_version.txt
