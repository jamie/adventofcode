class Runner
  attr_reader :script, :duration, :solutions
  attr_reader :year, :day, :lang

  def self.find(year, day, lang)
    script = Dir["#{year}/#{lang}/*#{day}*.*"].first
    if script
      self.for(script)
    else
      Null.new
    end
  end

  def self.for(script)
    _year, lang, file = script.split('/')
    if file =~ /\d+/
      const_get("Runner::#{lang.capitalize}").new(script)
    else
      nil
    end
  end

  def initialize(script)
    @script = script
    @year, @lang, file = script.split('/')
    @day = file.match(/(\d+)/).captures[0]
  end

  def run
    build
    start = Time.now
    output = execute
    stop = Time.now

    @duration = stop - start
    @solutions = output.chomp.split("\n")
    self
  end

  def duration_s
    "%9.2fs" % @duration
  end

  def build
    # NOP for most
    self
  end

  class Null < Runner
    def initialize
    end

    def run
      self
    end

    def duration
      0.0
    end

    def duration_s
      "          "
    end
  end

  class Nim < Runner
    def build
      # Building in release mode for performance
      `nim c --hints=off --warning[UnusedImport]=off -p=lib/nim -d=release #{script}`
      self
    end

    def execute
      # Redirecting stderr to strip build debug output
      `#{script.split('.')[0]}`
    end
  end

  class Ruby < Runner
    def execute
      `ruby -Ilib/ruby -I#{year}/#{lang} #{script}`
    end
  end
end
