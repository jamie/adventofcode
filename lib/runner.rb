begin
  require "tzinfo"
rescue LoadError => e
  puts "Errors with gems:"
  puts e.message
  exit
end

class Runner
  AOC_TIMEZONE = TZInfo::Timezone.get("US/Eastern")
  AOC_OFFSET = AOC_TIMEZONE.current_period.utc_total_offset / 60 / 60

  attr_reader :script, :duration, :solutions, :output
  attr_reader :year, :day

  LANG_EXTENSION = {
    "ruby" => "rb",
    "nim" => "nim",
  }.freeze

  def self.find(year, day, lang)
    ext = LANG_EXTENSION[lang]
    path = "%4d/%02d/*.%s" % [year, day, ext]
    script = Dir[path].first
    if script
      self.for(script)
    else
      Null.new
    end
  end

  def self.for(script)
    _basename, extension = script.split(".")
    lang = LANG_EXTENSION.key(extension)
    if lang && script =~ /solve/
      const_get("Runner::#{lang.capitalize}").new(script)
    else
      nil
    end
  end

  def initialize(script)
    @script = script
    @year, @day, _file = script.split("/")
    @day = @day.to_i
  end

  def has_input?
    infile = "%4d/%02d/input" % [year, day]
    if !File.exist?(infile)
      date = "%4d-12-%02d" % [year, day]
      now = Time.now.getlocal("%+.2d:00" % AOC_OFFSET)
      if now.strftime("%Y-%m-%d") == date
        `./advent get`
      else
        puts "Date is not #{date}, at #{now}"
        return false
      end
    end
    true
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

  def execute!
    has_input?
    execute
  end

  def execute
    local_execute
  end

  def success?
    has_input? && output == File.read("%4d/%02d/output" % [year, day])
  rescue Errno::ENOENT
    true
  end

  def duration_s
    "%9.2fs" % @duration
  end

  def success_duration_s
    if success?
      duration_s
    else
      "FAIL".rjust(10)
    end
  end

  def write!
    if !File.exist?("%4d/%02d/output" % [year, day])
      File.open("%4d/%02d/output" % [year, day], "w") do |file|
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
    def lang
      "nim"
    end

    def tmpdir
      "tmp/nim/#{script.split(".")[0]}"
    end

    def executable
      "#{tmpdir}/a.out"
    end

    def build
      FileUtils.mkdir_p tmpdir
      # Building in release mode for performance
      `nim c --hints=off --warning[UnusedImport]=off --out=#{executable} --nimcache=#{tmpdir} -p=lib/nim -d=release #{script}`
      self
    end

    def local_execute
      # Redirecting stderr to strip build debug output
      `#{executable}`
    end
  end

  class Ruby < Runner
    def lang
      "ruby"
    end

    def local_execute
      puts "ruby -Ilib/ruby -I#{year}/#{lang} #{script}" if ENV['VERBOSE']
      `ruby -Ilib/ruby -I#{year}/#{lang} #{script}`
    end
  end
end
