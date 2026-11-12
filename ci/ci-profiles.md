# CI profiles

Default PR checks use a fast gate on Flutter 3.38.5:

- Native static analysis, root unit tests, CI policy tests and one publish dry-run.
- Real native SDK startup on Android, iOS, macOS and Windows: initialize, read a
  nonempty SDK version, release. Errors fail the check; this is not a mock.
- An Android release APK with 16 KB alignment verification and a Web example build.
- Apple package/linkage checks and source consumers when packaging inputs change.

A normal PR allocates nine runners including the permission check, with two macOS
workers. Apple packaging changes add two macOS workers: eleven runners total,
four on macOS. GitHub also displays skipped deep-regression jobs; they allocate
no runners. Fast native workers have a 20-minute ceiling, not a latency promise.

The fast gate deliberately does not run the full API and screenshot suites.
This reduces per-PR regression depth: rendering and less common API regressions
can be discovered later. The existing latest-stable weekly coverage remains;
use the manual current-version/full suite on the target release ref when deeper
validation is needed. No screenshot thresholds or full regression cases were removed.

Apple checks are selected for native source, manifests, package layout, example,
SwiftPM fixtures or CI-tool changes. See check_apple_changes.py. Renames include
both paths. Unavailable history enables packaging conservatively. Each package
build is bounded to 20 minutes and its worker to 60 minutes. Source consumers and
linkage assertions continue to validate the actual package, not cached app output.

Use the existing run_test_weekly_latest_stable.yml manual workflow on the desired
ref and select suite:

| Suite | Checks |
| --- | --- |
| latest-stable | Existing scheduled weekly latest-stable coverage |
| current-regression | Full current-version APIs and screenshot suites |
| full-compatibility | Historical Flutter/host combinations and all 18 original Apple groups |
| legacy-ios | Only Flutter 3.16 full iOS runtime compatibility |

current-regression sets full_regression=true; full-compatibility sets
full_compatibility=true, which also enables full regression. Manual suites skip
the regular weekly jobs and use separate concurrency groups. Documentation
artifacts are generated in the existing release workflow. Pub scoring stays weekly.

## Dependency-update budget

For a binary-only dependency replacement with unchanged public APIs, explicitly
set the existing run_gen_code=false input. The fast-path target is 10–15 minutes
including the updater and PR checks under normal runner/network conditions; it
must be checked against real runs. Header/API changes still require code generation
(run_gen_code=true, retained as the safe default) and its additional execution time.
The updater now uses the same macOS 26 label as the validated CI workers.
Code generation caches public Yarn package downloads, not generated output or Git
credentials. It still resolves dependencies and executes generation when enabled.

Release/publishing and post-release git/pub consumer verification retain their
existing behavior. Run deeper validation against the exact ref being released;
reuse successful results on identical code rather than rerunning unchanged suites.

## Local checks

~~~sh
ruby ci/check_apple_ci.rb
python3 -m unittest ci/test_check_apple_changes.py ci/test_flutter_vm_service_watchdog.py ci/test_ios_integration_startup_retry.py ci/test_sdk_startup_smoke.py
~~~
