# parTI vs partipy

This repository provides a workflow for comparing archetype outputs produced by ParTI and partipy across multiple datasets (`hcm`, `hep`, `msx`).
It integrates Python-based notebook analysis with artifacts generated from MATLAB ParTI executions.

## Repository Structure

- `parti_vs_partipy.ipynb` – Main Python analysis notebook  
- `arc_files/` – Input archetype CSV files organized by dataset  
- `output/` – Generated comparison tables and panel figures  
- `parTI_matlab_run/` – MATLAB ParTI runner scripts, logs, and output files (`.mat`, `.fig`)

## Environment

The Python notebook is executed using a kernel that includes:

- `numpy`  
- `pandas`  
- `scipy`  
- `matplotlib`

## Data and Outputs

- Input files are located under: `arc_files/<dataset>/`  
- Dataset-specific comparison results are written to: `output/<dataset>/`  
  - `*_dist.csv` – distance matrices  
  - `*_matching.csv` – Hungarian-matched tables  
  - `*_panel.png` – visualization panels  

- Aggregated outputs are saved to:  
  - `output/summary.csv`  
  - `output/all_distance_tables.xlsx`

## Note

- The script `parTI_matlab_run/run_parTI_sc.m` currently contains a lab-specific ParTI path:  
  `/sci/labs/miri.adler/avia.walfisch/particode`  
- To run ParTI locally, this folder must be added to your MATLAB path.
