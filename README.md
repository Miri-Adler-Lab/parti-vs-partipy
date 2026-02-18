# parTI vs partipy

Comparison workflow for ParTI and partipy archetype outputs across multiple datasets (`hcm`, `hep`, `msx`), with both Python notebook analysis and MATLAB ParTI execution artifacts.

## Repository Layout

- `parti_vs_partipy.ipynb`: main Python analysis notebook.
- `arc_files/`: input archetype CSVs grouped by dataset.
- `output/`: generated comparison tables and panel figures.
- `parTI_matlab_run/`: MATLAB ParTI runner scripts, logs, and MATLAB outputs (`.mat`, `.fig`).

## Environment

Python notebook kernel uses:

- `numpy`
- `pandas`
- `scipy`
- `matplotlib`



## Data and Outputs

- Input source files are under `arc_files/<dataset>/`.
- Comparison outputs are written under `output/<dataset>/`:
  - `*_dist.csv`
  - `*_matching.csv`
  - `*_panel.png`
- Aggregated artifacts are written to:
  - `output/summary.csv`
  - `output/all_distance_tables.xlsx`

## Note

- `parTI_matlab_run/run_parTI_sc.m` currently includes a lab-specific ParTI path (`/sci/labs/miri.adler/avia.walfisch/particode`).. 
 - If you want to run parTI you need to add the folder to your path.
