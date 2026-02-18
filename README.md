# parTI vs partipy

Comparison workflow for ParTI and partipy archetype outputs across multiple datasets/timepoints (`hcm`, `hep`, `msx`), with both Python notebook analysis and MATLAB ParTI execution artifacts.

## Repository Layout

- `parti_vs_partipy.ipynb`: main Python analysis notebook.
- `arc_files/`: input archetype CSVs grouped by dataset.
- `output/`: generated comparison tables and panel figures.
- `parTI_matlab_run/`: MATLAB ParTI runner scripts, logs, and MATLAB outputs (`.mat`, `.fig`).

## Environment

Python notebook kernel is configured as `sc_bio_py311` and uses:

- `numpy`
- `pandas`
- `scipy`
- `matplotlib`

## Run the Python Comparison Workflow

Open the notebook and run all cells:

```powershell
conda activate sc_bio_py311
jupyter lab
```

Optional headless execution check:

```powershell
python -m nbconvert --execute --to notebook --inplace parti_vs_partipy.ipynb
```

## Run ParTI (MATLAB)

From MATLAB (or non-interactive mode), run:

```powershell
matlab -nodisplay -r "run('parTI_matlab_run/run_parTI_sc.m'); exit"
```

For SLURM environments:

```bash
sbatch parTI_matlab_run/run_parTI_slurm.sbatch
```

## Data and Outputs

- Input source files are under `arc_files/<dataset>/`.
- Comparison outputs are written under `output/<dataset>/`:
  - `*_dist.csv`
  - `*_matching.csv`
  - `*_panel.png`
- Aggregated artifacts are written to:
  - `output/summary.csv`
  - `output/all_distance_tables.xlsx`

## Notes

- `parTI_matlab_run/run_parTI_sc.m` currently includes a lab-specific ParTI path (`/sci/labs/miri.adler/avia.walfisch/particode`); update it if your environment differs.
- This repository intentionally tracks analysis artifacts currently present in the workspace.
