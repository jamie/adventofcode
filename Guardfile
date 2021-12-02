class AdventMatcher
  def initialize(suffix)
    @glob = %r{\d+/[^/]+\.#{suffix}}
  end

  def match(path)
    path = path.to_s
    return nil unless path =~ @glob
    year, lang, _file = path.split('/')
    return nil unless year =~ /\d{4}/
    {
      script: path,
    }
  end
end

require './lib/runner'

def watch_for(suffix, runner)
  watch(AdventMatcher.new(suffix)) do |match|
    path = match[:script]
    puts ">> #{path}"
    puts runner.new(path).build.execute!
    puts
  end
end

watch %r{lib/[^/]*\.rb} do
  Guard.reload
end

guard :shell do
  watch_for("exs?", ::Runner::Elixir)
  watch_for("nim", ::Runner::Nim)
  watch_for("rb", ::Runner::Ruby)
end
