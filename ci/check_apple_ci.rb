#!/usr/bin/env ruby
# Run with: ruby ci/check_apple_ci.rb
require 'yaml'

root = File.expand_path('..', __dir__)
workflow = YAML.load_file(File.join(root, '.github/workflows/run_test.yml'))
packages = YAML.load_file(File.join(root, '.github/workflows/run_apple_dependency_matrix.yml'))
jobs = workflow.fetch('jobs')
actual = []

# The coverage contract predates consolidation: 18 checks, including the exact
# simulator/Xcode combinations and both independent package managers.
expected = [
  ['ios runtime', '3.16', 'macos-26', 'iPhone 16e', '>=26.2', 1],
  ['ios runtime', '3.38.5', 'macos-26', 'iPhone 16e', '>=26.2', 3],
  ['ios rendering', '3.24.5', 'macos-15', 'iPhone 16 Pro', '18.5', '16.4'],
  ['ios rendering', '3.38.5', 'macos-26', 'iPhone 16e', '>=26.2', 'latest-stable'],
  ['macos runtime', '3.16', 'macos-latest'],
  ['macos runtime', '3.38.5', 'macos-latest'],
  ['ios example', '3.16', 'macos-latest'],
  ['ios example', '3.38.5', 'macos-latest'],
  ['macos rendering', '3.24.5', 'macos-latest'],
  ['macos rendering', '3.38.5', 'macos-latest'],
  ['published macos', '3.38.5', 'macos-latest'],
  ['published ios', '3.38.5', 'macos-latest']
]
%w[ios macos].each do |platform|
  expected << ['swiftpm integration', platform, 'stable', 'macos-latest']
  %w[cocoapods swiftpm].each do |manager|
    expected << ['linkage', platform, manager, '3.44.4', 'macos-latest']
  end
end

runtime = jobs.fetch('integration_test_ios')
runtime.fetch('strategy').fetch('matrix').fetch('include').each do |row|
  actual << ['ios runtime', row['version'], runtime['runs-on'], row['model'], row['os_version'], row['max_attempts']]
end
jobs.fetch('rendering_test_ios').fetch('strategy').fetch('matrix').fetch('include').each do |row|
  actual << ['ios rendering', row['version'], row['runner'], row['model'], row['os_version'], row['xcode_version']]
end
mac = jobs.fetch('integration_test_macos')
steps = mac.fetch('steps').each_with_object({}) { |step, out| out[step['id']] = step if step['id'] }
{
  'macos_api' => 'bash ci/run_flutter_macos_integration_test.sh',
  'ios_example' => 'flutter build ios --no-codesign --simulator',
  'published_macos' => 'bash ci/run_flutter_macos_published_package_smoke_test.sh',
  'published_ios' => 'bash ci/run_flutter_ios_published_package_smoke_test.sh',
  'macos_rendering' => 'bash ci/rendering_test_macos.sh'
}.each do |id, command|
  raise "Missing check command: #{id}" unless steps.fetch(id).fetch('run').include?(command)
  raise "A failed sibling would skip #{id}" unless steps[id].fetch('if').include?('!cancelled()')
end
mac.fetch('strategy').fetch('matrix').fetch('include').each do |row|
  actual << ['macos runtime', row['version'], mac['runs-on']]
  actual << ['ios example', row['version'], mac['runs-on']]
  actual << ['macos rendering', row['renderer_version'], mac['runs-on']]
  %w[macos ios].each do |platform|
    next unless row['version'] == '3.38.5'
    raise 'Consumer smoke test version condition changed' unless steps['published_' + platform]['if'].include?("matrix.version == '3.38.5'")
    actual << ['published ' + platform, row['version'], mac['runs-on']]
  end
end

call = jobs.fetch('apple_dependency_linkage_matrix')
raise 'SwiftPM integration consumers are missing' unless call.fetch('with').fetch('include_swiftpm_integration')
package_job = packages.fetch('jobs').fetch('build')
package_steps = package_job.fetch('steps').each_with_object({}) { |step, out| out[step['id']] = step if step['id'] }
raise 'Latest stable coverage changed' unless package_steps.fetch('swiftpm_flutter').fetch('with')['channel'] == 'stable'
package_job.fetch('strategy').fetch('matrix').fetch('platform').each do |platform|
  actual << ['swiftpm integration', platform, 'stable', package_job['runs-on']]
  %w[cocoapods swiftpm].each do |manager|
    step = package_steps.fetch(manager + '_linkage')
    raise "Missing #{manager} linkage command" unless step.fetch('run').end_with?(manager)
    raise 'A failed sibling would skip a package manager' unless step.fetch('if').include?('!cancelled()')
    actual << ['linkage', platform, manager, call.fetch('with')['flutter_version'], package_job['runs-on']]
  end
end
# The previous latest alias and the pinned label were both verified as
# macos-26-arm64/26.7.2, image 20261102.0473.1 on 2026-11-11.
image = lambda { |row| row.map { |value| value == 'macos-latest' ? 'macos-26' : value } }
raise "Apple coverage changed:\n#{actual.inspect}" unless actual.map(&image).sort == expected.map(&image).sort

removed = %w[pub_package_smoke_test_macos pub_package_smoke_test_ios integration_test_swiftpm build_ios rendering_test_macos]
raise 'Duplicate macOS allocations remain' if removed.any? { |id| jobs.key?(id) }
allocations = runtime['strategy']['matrix']['include'].length +
  jobs['rendering_test_ios']['strategy']['matrix']['include'].length +
  mac['strategy']['matrix']['include'].length +
  package_job['strategy']['matrix']['platform'].length
raise "Expected 8 macOS allocations, got #{allocations}" unless allocations == 8
puts 'Apple CI: all 18 checks preserved across 8 macOS runner allocations.'
