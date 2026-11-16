# Add the private SDK source while retaining the public source for other pods.
path = ARGV.fetch(0)
content = File.read(path)
sources = ['https://download.agora.io/cocoapods/', 'https://cdn.cocoapods.org/']
missing = sources.reject do |source|
  content.lines.any? do |line|
    line.strip == "source '#{source}'" || line.strip == %Q(source "#{source}")
  end
end
unless missing.empty?
  header = missing.map { |source| "source '#{source}'" }.join("\n")
  File.write(path, "#{header}\n\n#{content}")
end
