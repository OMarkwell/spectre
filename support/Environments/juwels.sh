#!/bin/env sh

# Distributed under the MIT License.
# See LICENSE.txt for details.

spectre_load_modules() {
    # The order here is important
    module load Stages/2025
    module load GCC/13.3.0
    module load OpenMPI/5.0.5
    module load CMake/3.29.3
    module load OpenBLAS/0.3.27
    module load Boost/1.86.0
    module load GSL/2.8
    module load HDF5/1.14.5
    module load Python/3.12.3
    export CHARM_ROOT=/p/project/bbh-et/markwell1/charm
}

spectre_unload_modules() {
    # The order here is important
    module unload Stages/2025
    module unload GCC/13.3.0
    module unload OpenMPI/5.0.5
    module unload CMake/3.29.3
    module unload OpenBLAS/0.3.27
    module unload Boost/1.86.0
    module unload GSL/2.8
    module unload HDF5/1.14.5
    module unload Python/3.12.3
    }

spectre_run_cmake() {
    if [ -z ${SPECTRE_HOME} ]; then
        echo "You must set SPECTRE_HOME to the cloned SpECTRE directory"
        return 1
    fi
    spectre_load_modules
    cmake -D CMAKE_C_COMPILER=gcc \
        -D CMAKE_CXX_COMPILER=g++ \
        -D CMAKE_Fortran_COMPILER=gfortran \
        -D CHARM_ROOT=$CHARM_ROOT \
        -D MEMORY_ALLOCATOR=SYSTEM \
        -D SPEC_ROOT=/p/project/bbh-et/markwell1/spec \
        -D MACHINE=Juwels \
        -D SPECTRE_FETCH_MISSING_DEPS=ON \
        $SPECTRE_HOME
    }


