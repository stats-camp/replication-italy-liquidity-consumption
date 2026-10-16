# Replication: Liquidity and Consumption

Antonio Acconcia, Giancarlo Corsetti, and Saverio Simonelli (2020),
“Liquidity and Consumption: Evidence from Three Post-earthquake Reconstruction
Programs in Italy,” *American Economic Journal: Macroeconomics* 12 (3): 319–46.
[Paper and citation](https://www.aeaweb.org/articles?id=10.1257/mac.20180190).

This stats.camp package preserves version V1 of AEA/openICPSR package **231539**.
The study uses reconstruction programs following Italian earthquakes to examine
how access to liquidity affects homeowners’ consumption. **Every original
file, including all four do-files and datasets, is unchanged.** All twelve
tables now replicate in stats.camp; the validation record and the remaining
browser check are in [TODO.md](TODO.md). No workaround was inserted into the
authors’ analysis.

**Open in stats.camp:**
[Table 1 script](https://stats.camp/app?open=https%3A%2F%2Fgithub.com%2Fstats-camp%2Freplication-italy-liquidity-consumption.git&file=data%2FTables_1.do).
The native engine reproduces every table from the unchanged scripts; only the
browser working-directory setup remains to be verified (see below).

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
`data/` directory; `cd` is also implemented in the engine. The browser opens
the repository at `/repo`, and its working-directory handling for these bare
filenames has not been verified yet. The scripts depend on the user-written
[estout suite](https://repec.sowi.unibe.ch/stata/estout/index.html)
(`estpost`, `eststo`, `esttab`), which is not bundled in the deposit. Install
that suite in the external Stata environment when doing an independent Stata
run; stats.camp provides these commands itself.

## What runs in stats.camp

All four untouched scripts run from `data/` without errors. On 2026-10-14 and
again on 2026-10-15 they were executed in Stata 19.5 and in the native engine
on scratch copies, and every number in Tables 1, 2, 3, 4, A1, A2, A3, 5, 6,
7, 8 and 9 is equal (132 of 132 result rows, compared at the displayed
precision). This covers the seasonal and compound time-series operators
(`s2.lC`, `l2.s2.lC`), `fvset base`, nested `eststo: xi: reg`, `estpost
tabstat ... by()` with value-labelled groups, the `esttab` shorthand (`b(2)`,
`ar2(2)`, `cells()`, `postfoot()` with LaTeX braces, `nodepvar`, `nomtitle`)
and the printed table layout (row labels abbreviated with `~`, rules between
equation blocks).

Note for Stata comparisons: at Stata's default `linesize` of 80 the console
truncates the wide `esttab` tables; use `set linesize 255` before running the
scripts. The engine prints the full width.

The 2026-10-13 audit transcripts under `validation/` predate these engine
features and are kept as history; [TODO.md](TODO.md) lists what was fixed.

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

There is no deposited output transcript. The numerical reference is the
Stata 19.5 run of 2026-10-14/15 described above; the engine's results equal
it. A separate browser/Wasm run remains unverified.

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
