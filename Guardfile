class AdventMatcher
  def initialize(suffix)
    @glob = %r{\d+/[^/]+\.#{suffix}}
  end

  def match(path)
    path = path.to_s
    return nil unless path&.match?(@glob)
    year, lang, _file = path.split("/")
    return nil unless /\d{4}/.match?(year)
    {
      script: path
    }
  end
end

require "./lib/runner"
require "benchmark"

def watch_for(suffix, runner)
  watch(AdventMatcher.new(suffix)) do |match|
    path = match[:script]
    puts ">> #{path}"
    bm = Benchmark.measure do
      puts runner.new(path).build.execute!
    end
    puts bm
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
