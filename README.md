# azure-cni-dev-scripts
It contains the scripts/config needed for azure cni

## Scripts
### 1. cpu_mem.sh
It is used to get the cpu and memory usage of the cilium pods and nodes in the cluster. It will generate a csv file with the name nodes.csv, pod.csv and operator.csv. 
The script accepts the name of folder where the csv files will be generated as an argument.
Example:
```
./cpu_mem.sh <folder_name>
```
