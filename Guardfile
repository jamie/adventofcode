class AdventMatcher
  def initialize(glob)
    @glob = glob
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

watch %r{lib/[^/]*\.rb} do
  Guard.reload
end

guard :shell do
  watch(AdventMatcher.new(/.*\.rb/)) do |match|
    path = match[:script]
    puts ">> #{path}"
    puts ::Runner::Ruby.new(path).build.execute!
    puts
  end

  watch(AdventMatcher.new(/.*\.nim/)) do |match|
    path = match[:script]
    puts ">> #{path}"
    puts ::Runner::Nim.new(path).build.execute!
    puts
  end
end
