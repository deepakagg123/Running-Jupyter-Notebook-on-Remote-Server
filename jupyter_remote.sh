#!/bin/bash
#PBS -N Notebook_job
#PBS -l select=1:ncpus=2:ngpus=1
#PBS -l walltime=24:00:00
#PBS -q serialq
#PBS -j oe

cd $PBS_O_WORKDIR

NOTEBOOK_LOGFILE=jupyterlog.out

# get tunneling info
node=$(hostname -s)
user=$(whoami)
cluster=AA.BB.CC.D               # Enter cluster IP address
port=XXXX                        # Enter a port number like 9000 
export JUPYTER_PORT=XXXX
### --After job submission open the port_forwarding.txt file for port forwarding details --###
echo -e "
Run the following command from your local machine terminal with local machine port YYYY:
$ ssh -N -f -L YYYY:${node}:${port} ${user}@${cluster}
" > port_forwarding.txt

module load anaconda/3
# launch the Jupyter Notebook run
jupyter notebook --no-browser --ip=${node} --port=${port} > ${NOTEBOOK_LOGFILE} 2>&1

