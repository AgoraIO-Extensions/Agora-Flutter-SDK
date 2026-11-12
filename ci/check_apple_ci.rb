#!/usr/bin/env ruby
# Validate default CI, conditional packaging, and the preserved full matrix.
require 'json'
require 'yaml'

root = File.expand_path('..', __dir__)
read = lambda { |name| YAML.load_file(File.join(root, '.github/workflows', name)) }
workflow = read.call('run_test.yml')
packages = read.call('run_apple_dependency_matrix.yml')
ios_workflow = read.call('run_ios_integration_test.yml')
weekly = read.call('run_test_weekly_latest_stable.yml')
jobs = workflow.fetch('jobs')
triggers = lambda { |value| value['on'] || value[true] }

def values(job, field, full)
  value = job.fetch('strategy').fetch('matrix').fetch(field)
  return value if value.is_a?(Array)

  match = value.match(/\A\$\{\{ fromJSON\(inputs\.full_compatibility && '(.*?)' \|\| '(.*?)'\) \}\}\z/)
  raise "Unrecognized matrix: #{value}" unless match
  JSON.parse(match[full ? 1 : 2])
end

raise 'PRs must default to the current-version suite' unless triggers.call(workflow).fetch('workflow_call').fetch('inputs').fetch('full_compatibility').fetch('default') == false
versions = {
  'integration_test_android' => %w[3.16 3.24.5 3.38.5],
  'integration_test_ios' => %w[3.16 3.38.5],
  'integration_test_windows' => %w[3.24.5 3.38.5],
  'integration_test_web' => %w[3.24.5 3.38.5],
  'build_android_ubuntu' => %w[3.16 3.24.5 3.38.5],
  'build_android_windows' => %w[3.16 3.24.5 3.38.5],
  'build_web' => %w[3.24.5 3.38.5],
  'rendering_test_windows' => %w[3.24.5 3.38.5],
  'rendering_test_web' => %w[3.24.5 3.38.5]
}
versions.each do |id, expected|
  raise "Full compatibility versions changed: #{id}" unless values(jobs.fetch(id), 'version', true) == expected
  next if id == 'build_android_windows'
  raise "Default suite repeats old versions: #{id}" unless values(jobs.fetch(id), 'version', false) == ['3.38.5']
end
raise 'Windows-host Android builds must be opt-in' unless jobs.fetch('build_android_windows').fetch('if').include?('inputs.full_compatibility')
raise 'Core Android rendering was removed' unless jobs.fetch('rendering_test_android').fetch('steps').any? { |step| step.dig('with', 'script') == 'bash ci/rendering_test_android.sh' }
raise 'No real failures may be ignored' if jobs.values.any? { |job| job['continue-on-error'] == true || Array(job['steps']).any? { |step| step['continue-on-error'] == true } }

quality = jobs.fetch('quality_checks').fetch('steps')
raise 'Root unit tests missing' unless quality.any? { |step| step['run'] == 'flutter test' }
raise 'Default quality checks must use current Flutter' unless quality.find { |step| step['id'] == 'flutter' }.fetch('with').fetch('flutter-version') == '3.38.5'
raise 'Native static analysis missing' unless quality.any? { |step| step['run'] == 'flutter analyze --no-fatal-infos lib test' }
raise 'Pub scoring must not block default PRs' if quality.any? { |step| step['uses'].to_s.include?('dart-package-analyzer') }
dry_runs = jobs.values.sum { |job| Array(job['steps']).count { |step| step['run'].to_s.include?('bash ci/dart_pub_publish_check.sh') } }
raise 'Publish dry-run must run exactly once' unless dry_runs == 1
raise 'Documentation artifacts still block PRs' if jobs.key?('attach_docs')
raise 'Release documentation generation missing' unless read.call('release.yml').fetch('jobs').fetch('attach_documentation').fetch('steps').any? { |step| step['run'].to_s.include?('dart doc') }
raise 'Duplicate Android alignment build remains' if jobs.key?('check_android15_16k_page_alignment')
alignment = jobs.fetch('build_android_ubuntu').fetch('steps').find { |step| step['name'] == 'Check Android 16 KB page alignment' }
raise '16 KB verification must reuse the current APK build' unless alignment && alignment.fetch('run').include?('example/build/app/intermediates/merged_native_libs') && alignment.fetch('if').include?("matrix.version == '3.38.5'")

route = jobs.fetch('check_changes')
raise 'Changed-file selection missing' unless route.fetch('steps').any? { |step| step['run'] == 'bash ci/select_apple_checks.sh' }
call = jobs.fetch('apple_dependency_linkage_matrix')
mac = jobs.fetch('integration_test_macos')
[call, mac].each do |job|
  raise 'Packaging selection dependency missing' unless Array(job.fetch('needs')).include?('check_changes')
end
raise 'Unknown changes must enable packaging' unless call.fetch('if').include?("outputs.apple_packages != 'false'") && call.fetch('if').include?('inputs.full_compatibility')
raise 'Latest-stable consumer must be reserved for full compatibility' unless call.fetch('with').fetch('include_swiftpm_integration').include?('inputs.full_compatibility')
steps = mac.fetch('steps').each_with_object({}) { |step, out| out[step['id']] = step if step['id'] }
%w[published_macos published_ios example_dependencies].each do |id|
  condition = steps.fetch(id).fetch('if')
  raise "Unconditional packaging step: #{id}" unless condition.include?("outputs.apple_packages != 'false'") && condition.include?('inputs.full_compatibility')
end
{
  'macos_api' => 'bash ci/run_flutter_macos_integration_test.sh',
  'ios_example' => 'flutter build ios --no-codesign --simulator',
  'published_macos' => 'bash ci/run_flutter_macos_published_package_smoke_test.sh',
  'published_ios' => 'bash ci/run_flutter_ios_published_package_smoke_test.sh',
  'macos_rendering' => 'bash ci/rendering_test_macos.sh'
}.each do |id, command|
  raise "Missing command: #{id}" unless steps.fetch(id).fetch('run').include?(command)
  raise "Sibling failure would skip #{id}" unless steps[id].fetch('if').include?('!cancelled()')
end

ios = ios_workflow.fetch('jobs').fetch('runtime')
simulator = ios.fetch('steps').find { |step| step['uses'] == 'futureware-tech/simulator-action@v4' }.fetch('with')
raise 'iOS runtime setup must remain shared' unless jobs.fetch('integration_test_ios').fetch('uses') == './.github/workflows/run_ios_integration_test.yml'
expected = [
  ['ios runtime', '3.16', 'macos-26', 'iPhone 16e', '>=26.2', 3],
  ['ios runtime', '3.38.5', 'macos-26', 'iPhone 16e', '>=26.2', 3],
  ['ios rendering', '3.24.5', 'macos-15', 'iPhone 16 Pro', '18.5', '16.4'],
  ['ios rendering', '3.38.5', 'macos-26', 'iPhone 16e', '>=26.2', 'latest-stable']
]
actual = values(jobs['integration_test_ios'], 'version', true).map do |version|
  ['ios runtime', version, ios['runs-on'], simulator['model'], simulator['os_version'], ios.fetch('env').fetch('IOS_TEST_MAX_ATTEMPTS').to_i]
end
values(jobs['rendering_test_ios'], 'include', true).each do |row|
  actual << ['ios rendering', row['version'], row['runner'], row['model'], row['os_version'], row['xcode_version']]
end
expected_mac = [
  { 'version' => '3.16', 'renderer_version' => '3.24.5' },
  { 'version' => '3.38.5', 'renderer_version' => '3.38.5' }
]
raise 'Full macOS matrix changed' unless values(mac, 'include', true) == expected_mac
raise 'Default macOS matrix repeats old versions' unless values(mac, 'include', false) == expected_mac.last(1)
raise 'Default iOS rendering repeats old versions' unless values(jobs['rendering_test_ios'], 'include', false) == values(jobs['rendering_test_ios'], 'include', true).last(1)
expected_mac.each do |row|
  %w[macos\ runtime ios\ example].each do |kind|
    expected << [kind, row['version'], 'macos-26']
    actual << [kind, row['version'], mac['runs-on']]
  end
  expected << ['macos rendering', row['renderer_version'], 'macos-26']
  actual << ['macos rendering', row['renderer_version'], mac['runs-on']]
end
%w[macos ios].each do |platform|
  expected << ['published ' + platform, '3.38.5', 'macos-26']
  actual << ['published ' + platform, '3.38.5', mac['runs-on']]
end
package_job = packages.fetch('jobs').fetch('build')
package_steps = package_job.fetch('steps').each_with_object({}) { |step, out| out[step['id']] = step if step['id'] }
package_job.fetch('strategy').fetch('matrix').fetch('platform').each do |platform|
  expected << ['swiftpm integration', platform, 'stable', 'macos-26']
  actual << ['swiftpm integration', platform, package_steps.fetch('swiftpm_flutter').fetch('with')['channel'], package_job['runs-on']]
  %w[cocoapods swiftpm].each do |manager|
    step = package_steps.fetch(manager + '_linkage')
    raise "Missing linkage mode: #{manager}" unless step.fetch('run').end_with?(manager)
    raise "Unbounded packaging check: #{manager}" unless step.fetch('timeout-minutes') == 20
    raise 'A sibling would skip a package manager' unless step.fetch('if').include?('!cancelled()')
    expected << ['linkage', platform, manager, '3.44.4', 'macos-26']
    actual << ['linkage', platform, manager, call.fetch('with')['flutter_version'], package_job['runs-on']]
  end
end
raise 'Original 18 Apple groups missing from full compatibility' unless actual.sort == expected.sort
raise 'Packaging worker has no useful upper bound' unless package_job.fetch('timeout-minutes') == 60

weekly_triggers = triggers.call(weekly)
suite = weekly_triggers.fetch('workflow_dispatch').fetch('inputs').fetch('suite')
raise 'Manual suite choices changed' unless suite.fetch('default') == 'latest-stable' && suite.fetch('options').sort == %w[latest-stable full-compatibility legacy-ios].sort
raise 'Weekly schedule changed' unless weekly_triggers.fetch('schedule') == [{ 'cron' => '0 0 * * 0', 'timezone' => 'Asia/Shanghai' }]
weekly_jobs = weekly.fetch('jobs')
full = weekly_jobs.fetch('full_compatibility')
raise 'Full suite must call the same workflow' unless full.fetch('uses') == './.github/workflows/run_test.yml' && full.fetch('with').fetch('full_compatibility') == true
raise 'Full compatibility must be manual' unless full.fetch('if').include?("github.event_name == 'workflow_dispatch'") && full.fetch('if').include?("inputs.suite == 'full-compatibility'")
legacy = weekly_jobs.fetch('legacy_ios_compatibility')
raise 'Legacy iOS manual entry missing' unless legacy.fetch('with').fetch('flutter_version') == '3.16' && legacy.fetch('if').include?("inputs.suite == 'legacy-ios'")
raise 'Manual suites must skip weekly resolution' unless weekly_jobs.fetch('resolve_flutter_version').fetch('if').include?("inputs.suite == 'latest-stable'")
weekly_jobs.each do |id, job|
  next if %w[resolve_flutter_version legacy_ios_compatibility full_compatibility].include?(id)
  raise "Manual suites would also run #{id}" unless Array(job.fetch('needs')).include?('resolve_flutter_version')
end
raise 'Weekly duplicate documentation/publish jobs remain' if %w[attach_docs pub_publish_check flutter_ut].any? { |id| weekly_jobs.key?(id) }
raise 'Weekly unit coverage missing' unless weekly_jobs.fetch('flutter_codestyle_check').fetch('steps').any? { |step| step['run'] == 'flutter test' }
[weekly_jobs.fetch('flutter_codestyle_check').fetch('steps')].each do |sequence|
  analysis = sequence.index { |step| step['id'] == 'analysis' }
  ownership = sequence.index { |step| step['name'] == 'Restore workspace ownership after package analysis' }
  unit = sequence.index { |step| step['run'] == 'flutter test' }
  raise 'Container analysis must restore checkout ownership before host tests' unless analysis && ownership && unit && analysis < ownership && ownership < unit
end

count = lambda do |full_matrix, packaging|
  jobs.sum do |id, job|
    next 0 if id == 'build_android_windows' && !full_matrix
    next (packaging || full_matrix ? 2 : 0) if id == 'apple_dependency_linkage_matrix'
    matrix = job.dig('strategy', 'matrix')
    matrix ? values(job, matrix.key?('include') ? 'include' : 'version', full_matrix).length : 1
  end
end
raise 'Unexpected runner count' unless [count.call(false, false), count.call(false, true), count.call(true, true)] == [13, 15, 30]
normal_mac = values(jobs['integration_test_ios'], 'version', false).length +
  values(jobs['rendering_test_ios'], 'include', false).length + values(mac, 'include', false).length
raise 'Default macOS allocation count changed' unless normal_mac == 3
puts 'CI policy: 14 PR runners (3 macOS), 16 with packaging (5 macOS), including the permission job; full compatibility preserves all 18 Apple groups.'
