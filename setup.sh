#!/bin/bash
# Copyright (c) 2022 Graphcore Ltd. All rights reserved.
# Script to be sourced on launch of the Gradient Notebook
# Adapted from
# <https://github.com/graphcore/Gradient-HuggingFace/blob/826b72cba150be52e7420a3440a31e3096b73c78/setup.sh>.

# called from root folder in container
# SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

EXIT_CODE=0
echo "Graphcore setup - Starting notebook setup"
DETECTED_NUMBER_OF_IPUS=$(python .gradient/available_ipus.py)
if [[ "$1" == "test" ]]; then
    IPU_ARG="${DETECTED_NUMBER_OF_IPUS}"
else
    IPU_ARG=${1:-"${DETECTED_NUMBER_OF_IPUS}"}
fi
echo "Graphcore setup - Detected ${DETECTED_NUMBER_OF_IPUS} IPUs"
if [[ "${DETECTED_NUMBER_OF_IPUS}" == "0" ]]; then
    echo "=============================================================================="
    echo "                         IPU ERROR  DETECTED"
    echo "=============================================================================="
    echo "Connection to IPUs timed-out. This error indicates a problem with the "
    echo "hardware you are running on. Please contact Paperspace Support at "
    echo " https://docs.paperspace.com/contact-support/ "
    echo " referencing the Notebook ID: ${PAPERSPACE_METRIC_WORKLOAD_ID:-unknown}"
    echo "=============================================================================="
    exit 255
fi
# Check the state of the partition
GC_INFO_OUTPUT=$(timeout 5 gc-info -l 2>&1)
if [[ "$(echo ${GC_INFO_OUTPUT} | grep 'Partition.* \[active\]')" ]]
then
    echo "Graphcore setup - Partition check - passed"
elif [[ "$(echo ${GC_INFO_OUTPUT} | grep 'partition is not ACTIVE')" ]]
then
    echo "=============================================================================="
    echo "                         IPU ERROR  DETECTED"
    echo "=============================================================================="
    echo " IPU Partition is not active. This error indicates a problem with the "
    echo "hardware you are running on. Please contact Paperspace Support at "
    echo " https://docs.paperspace.com/contact-support/ "
    echo " referencing the Notebook ID: ${PAPERSPACE_METRIC_WORKLOAD_ID:-unknown}"
    echo "=============================================================================="
    gc-info -l
    exit 254
else
    echo "[WARNING] IPU Partition in an unrecognised state - Notebook will start normally but"
    echo "[WARNING] you may encounter hardware related errors. Get in touch with Paperspace and/or"
    echo "[WARNING] Graphcore support if you encounter unexpected behaviours or errors."
    EXIT_CODE=253
fi

echo "Graphcore setup - Starting Jupyter kernel"
jupyter lab --allow-root --ip=0.0.0.0 --no-browser --ServerApp.trust_xheaders=True \
            --ServerApp.disable_check_xsrf=False --ServerApp.allow_remote_access=True \
            --ServerApp.allow_origin='*' --ServerApp.allow_credentials=True

exit $EXIT_CODE
