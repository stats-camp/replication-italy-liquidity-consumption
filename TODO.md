# Missing features and verification tasks

Audit date: 2026-10-13. Preserve the deposited scripts and data while addressing
these features in the stats.camp engine. Evidence and diagnostic snippets are
indexed in [validation/audit.json](validation/audit.json) and
[validation/probes.json](validation/probes.json).

## Confirmed engine gaps

- [ ] **IT-1 — Parse continued table options containing LaTeX braces.**
  `Tables_1.do:13` and `Tables_2_3_4_A1_A2_A3.do:129` fail before execution:
  `block header is missing before '{'`. Treat braces inside the continued
  `esttab ... postfoot(...)` option as option text and retain the supplied
  footnote. Verify both complete original scripts parse unchanged.
- [ ] **IT-2 — Seasonal and compound time-series operators.**
  Evaluate `s2.lC`, `s2.lCF`, `s2.lCO`, `s2.lIncome`, `s2.lSize`, and
  `s2.Earners` in expressions, dependent variables, and regression varlists;
  support combinations such as `l2.s2.lC` and `l2.s2.lCF`.
  Independent probes of `gen actual=s2.lC`, `gen actual=l2.s2.lC`, and
  `reg s2.lC ...` fail. Use the stored `nquest`/`Year` declaration, correct
  panel boundaries, time gaps, and missing-value/sample rules.
  `S2.x` is the lag-two seasonal difference, and `L2.S2.x` is that difference
  lagged two periods. [Stata time-series manual](https://www.stata.com/manuals15/ts.pdf).
  The `f2.INDEXLIQ` lead and dataset declarations already execute; preserve
  that behavior.
- [ ] **IT-3 — Factor-variable base settings.**
  Implement `fvset base 1979 Year`, currently an unknown command at Table 4’s
  line 71. Verify the baseline used by subsequent `i.Year` expansions,
  including restricted samples that exclude 1979.
- [ ] **IT-4 — Nested estimation prefixes.**
  `eststo: xi: reg ...` fails with `internal error: wrapped xi passed to
  standalone handler`, `r(198)`. Direct `xi: reg ..., r` works in the probe.
  Execute and store the wrapped model while preserving factor-variable,
  sample, and robust-variance behavior. This affects Tables 3, A2, and A3.
- [ ] **IT-5 — Post grouped summary estimates.**
  `estpost tabstat ..., columns(statistics) statistics(mean) by(...) nototal`
  is an unknown command. Support its posted means, variable/group labels,
  result layout, and storage for Table 1, A1, and 8.
  [estpost documentation](https://repec.sowi.unibe.ch/stata/estout/estpost.html).
- [ ] **IT-6 — esttab numeric shorthand.**
  `b(2)` fails with `invalid numeric format: 2`; the scripts also use `b(1)`.
  `ar2(2)` rejects an argument. Accept decimal-place shorthand for coefficient
  and adjusted-R-squared formatting; retain complete Stata display formats.
  [esttab syntax and formats](https://repec.sowi.unibe.ch/stata/estout/help-esttab.html).
- [ ] **IT-7 — esttab summary cells and layout options.**
  Independent probes reject `cells(mean(fmt(%10.2fc)))`, `postfoot(...)`,
  `nodepvar`, and `nomtitle`. Support these options, the per-variable format
  lists in A1, `%...fc` displays, and the original multi-model/table layout.
  The `mtitle(...)` abbreviation already works on a stored regression.

## Checks still required after the blockers are resolved

These are verification tasks, not additional features known to be missing.

- [ ] Execute all four untouched original scripts from the `data/` working
  directory and record a complete transcript and original-file hash check.
- [ ] Validate coefficients, robust standard errors, estimation samples,
  missing-value exclusions, omitted terms, grouped means, and the median-based
  split used by Table A3 against a licensed Stata run and the published tables.
- [ ] Check the correct seven stored Table 2 models, model order/wildcards,
  displayed variable labels, custom significance cutoffs, table headings,
  adjusted R-squared, decimal precision, and footnotes against the authors’
  requested tables. Executing a table command alone is not table parity.
- [ ] **Pending browser setup — provide working-directory or runtime path
  support.** The scripts need a `data/` working directory, while the browser
  starts at `/repo` and currently rejects `cd`. Provide the required setup
  without editing the original do-files, then verify all entrypoints in the
  browser/Wasm engine. Native execution does not establish browser parity.

No complete table script passed in the audited engine. The deposit provides
no output transcript, and the local Stata license has expired, so a fresh Stata
numerical comparison remains outstanding. No do-file was changed and no engine
feature was implemented for this package preparation.

## Validation against Stata (2026-10-14)

Stata 19.5 and the engine ran the four unchanged scripts from scratch copies of
`data/` without errors. After fixing `eststo` ordering (sets listed
alphabetically, columns permuted in Tables 5–8), naming `estpost tabstat`'s
`by()` groups by their value labels (Stata's equation names, "Emilia Romagna"
rather than "0") and printing `estpost` results in Stata's `matlist` layout,
every number in Tables 1, 2, 3, 4, A1, A2, A3, 5, 6, 7, 8 and 9 equals Stata's,
and with row labels abbreviated to the label width (`Diff-in-Diff ~81`) and
rules between equation blocks the printed tables are identical line for line.
