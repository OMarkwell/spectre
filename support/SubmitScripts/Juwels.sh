{% extends "SubmitTemplateBase.sh" %}

# Distributed under the MIT License.
# See LICENSE.txt for details.

# Supercomputer at Jülich
# More information:
# https://apps.fz-juelich.de/jsc/hps/juwels/batchsystem.html

{% block head %}
{{ super() -}}
#SBATCH --nodes {{ num_nodes | default(1) }}
#SBATCH --ntasks-per-node 1
#SBATCH --cpus-per-task 48
#SBATCH -p {{ queue | default("batch") }}
#SBATCH -t {{ time_limit | default("1-00:00:00") }}
{% endblock %}

{% block run_command %}
srun -n ${SLURM_NTASKS} \
  ${SPECTRE_EXECUTABLE} --input-file ${SPECTRE_INPUT_FILE} \
  ++ppn ${CHARM_PPN} +setcpuaffinity \
  ${SPECTRE_CHECKPOINT:+ +restart "${SPECTRE_CHECKPOINT}"}
{% endblock %}
