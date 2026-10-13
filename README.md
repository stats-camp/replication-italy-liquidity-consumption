# Replication: Liquidity and Consumption

Antonio Acconcia, Giancarlo Corsetti, and Saverio Simonelli (2020),
“Liquidity and Consumption: Evidence from Three Post-earthquake Reconstruction
Programs in Italy,” *American Economic Journal: Macroeconomics* 12 (3): 319–46.
[Paper and citation](https://www.aeaweb.org/articles?id=10.1257/mac.20180190).

This stats.camp package preserves version V1 of AEA/openICPSR package **231539**.
The study uses reconstruction programs following Italian earthquakes to examine
how access to liquidity affects homeowners’ consumption. **Every original
file, including all four do-files and datasets, is unchanged.** Missing engine
features are recorded in [TODO.md](TODO.md); no workaround was inserted into
the authors’ analysis.

**Open in stats.camp:**
[Table 1 script](https://stats.camp/app?open=https%3A%2F%2Fgithub.com%2Fstats-camp%2Freplication-italy-liquidity-consumption.git&file=data%2FTables_1.do).
Opening a script does not make the full replication runnable; the current
blockers are documented below.

## Files and launch directory

There is no master script. Each do-file loads its matching dataset and targets
these tables:

| Original script | Dataset rows × variables | Intended results |
| --- | --- | --- |
| `data/Tables_1.do` | 11 × 6 | Table 1 |
| `data/Tables_2_3_4_A1_A2_A3.do` | 5,945 × 20 | Tables 2–4 and A1–A3 |
| `data/Tables_5_6_7_8.do` | 3,006 × 24 | Tables 5–8 |
| `data/Tables_9.do` | 3,427 × 17 | Table 9 |

The original [Readme.tex](data/Readme.tex) says the datasets contain the data
needed for all results. The deposit has 11 files totaling 758,494 bytes
(0.758 MB); its largest file is `data/Tables_2_3_4_A1_A2_A3.dta` at 316,741
bytes. The original license and macOS metadata file are also retained.

**The scripts require the working directory to be `data/`.** Their `use`
commands refer to bare dataset filenames. In local Stata, from the repository
root, set the working directory before running an unchanged script:

```stata
cd "data"
do Tables_1.do
```

Run the other three scripts the same way, selecting their original filenames.
For native stats_core checks, launch the executable from a scratch copy of the
`data/` directory. The browser opens the repository at `/repo` and currently
rejects `cd`; its runner still needs working-directory or runtime path support
for these relative filenames. Opening `data/Tables_1.do` is available for
inspection, but does not provide that setup or a successful replication run.
The scripts depend on the user-written
[estout suite](https://repec.sowi.unibe.ch/stata/estout/index.html)
(`estpost`, `eststo`, `esttab`), which is not bundled in the deposit.
Install that suite in the external Stata environment when doing an independent
Stata run. This dependency does not resolve stats.camp’s implementation gaps.

## What runs in stats.camp

Native audit on **2026-10-13**: all four datasets load and describe successfully.
The original Table 2 segment fits and stores seven OLS models. Data filtering,
logarithms, local macros, loops, quiet blocks, preservation, variable labels,
and grouped observation counts execute in the probes. Direct `xi: reg ..., r`
succeeds, and stored estimation results can be listed.

The two panel datasets restore their `nquest`/`Year` declarations on load.
The `f2.INDEXLIQ` expressions execute in both. A simple stored-regression
`esttab, mtitle(...)` also executes. These command-level checks are partial
execution evidence, not a validation of all published results.

**No complete table-producing script currently finishes:**

| Untouched script | First stopping point |
| --- | --- |
| `Tables_1.do` | Parsing line 13: LaTeX braces in `postfoot(...)` are mistaken for a program block, before any command executes |
| `Tables_2_3_4_A1_A2_A3.do` | Same parser issue at line 129, before execution |
| `Tables_5_6_7_8.do` | First regression, line 20: `s2.lC` cannot be evaluated |
| `Tables_9.do` | First regression, line 19: `s2.lC` cannot be evaluated |

Isolated probes reveal later blockers too: `estpost` and `fvset` are unknown;
`eststo: xi: reg` fails when the prefixes are nested; `esttab` rejects the
scripts’ decimal-format shorthands and several summary/table options.
[TODO.md](TODO.md) lists the confirmed gaps and the checks required after
implementing them.

## Audit and source integrity

The audit used copies of the original files in fresh `/tmp` directories with
the working directory set to their data directory. Diagnostic snippets and
original script segments were run separately to expose downstream blockers;
the deposited scripts themselves were never edited. See
[the structured audit](validation/audit.json),
[the diagnostic command index](validation/probes.json), and the bounded logs
under `validation/`.

[Source manifest](validation/source-manifest.json) records the SHA-256 and byte
size of every original file and the source archive. All 11 files were compared
byte for byte against `231539-V1.zip` after auditing. Archive SHA-256:

```text
ad6f8d2178e4606ad16b513f12852539623c3e6b0d2a0b69a1c6aeb6a698daa0
```

There is no deposited output transcript. A fresh Stata comparison was
unavailable because the installed license has expired. Numerical parity,
complete table formatting, and a separate browser/Wasm run remain unverified.

## Source, attribution, and license

Acconcia, Antonio, Giancarlo Corsetti, and Saverio Simonelli. 2020.
“Replication package for: Liquidity and Consumption: Evidence from Three
Post-earthquake Reconstruction Programs in Italy.” American Economic
Association [publisher].
[AEA dataset record](https://www.aeaweb.org/journals/dataset?id=10.1257%2Fmac.20180190);
[openICPSR package 231539, V1](https://www.openicpsr.org/openicpsr/project/231539/version/V1/view).
The live openICPSR metadata page could not be fetched during this audit;
attribution was checked against the authors’ original readme and the AEA
paper record.

The original [LICENSE.txt](LICENSE.txt) applies the modified BSD license to
code and Creative Commons Attribution 4.0 to data and other objects, with
copyright 2020 American Economic Association. Cite the researchers’ paper and
deposit when using these materials. stats-camp hosts this preserved copy;
the researchers retain their scholarly attribution.
