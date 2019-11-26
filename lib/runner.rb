class Runner
  attr_reader :script, :duration, :solutions, :output
  attr_reader :year, :day, :lang

  def self.find(year, day, lang)
    day = day.to_s.gsub(/^0/, '').to_i
    path = "%4d/%s/*%02d*.*" % [year, lang, day]
    script = Dir[path].first
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
    @day = file.match(/([1-9]?[0-9]+)/).captures[0].to_i
  end

  def run
    build
    start = Time.now
    @output = execute
    stop = Time.now

    @duration = stop - start
    @solutions = output.chomp.split("\n")
    self
  end

  def success?
    output == File.read('%4d/output/%02d' % [year, day])
  end

  def duration_s
    "%9.2fs" % @duration
  end

  def success_duration_s
    if success?
      duration_s
    else
      'FAIL'.rjust(10)
    end
  end

  def write!
    if !File.exist?('%4d/output/%s' % [year, day])
      FileUtils.mkdir_p('%4d/output' % year)
      File.open('%4d/output/%s' % [year, day], 'w') do |file|
        file.puts run.output
      end
    end
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

    def success?
      true
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
